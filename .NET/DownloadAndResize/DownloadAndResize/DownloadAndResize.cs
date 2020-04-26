using System;
using System.IO;
using System.Net;
using System.Drawing;
using System.Drawing.Drawing2D;

namespace DownloadAndResize
{
    public interface IDownloadAndResize
    {
        void DownloadImage(string url, string local_path, string number, int x_scale, int y_scale);
    }

    public class DownloadAndResize : IDownloadAndResize
    {
        public void DownloadImage(string url, string local_path, string number, int x_scale, int y_scale)
        {
            string tempFileName;
            using (var client = new WebClient())
            {
                string ext = System.IO.Path.GetExtension(url);
                tempFileName = @"c:\temp\temp" + ext;
                client.DownloadFile(url, tempFileName);
            }

            ToJPG(tempFileName, local_path, number, x_scale, y_scale);
            File.Delete(tempFileName);
        }

        private static void ToJPG(string filename, string path, string name, int x_scale, int y_scale)
        {
            Image img = Image.FromFile(filename);
            Bitmap b = new Bitmap(img);
            Image newImg = ScaleImage(b, x_scale, y_scale);
            newImg.Save(path + @"/" + name + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            newImg.Dispose();
            img.Dispose();
            b.Dispose();
        }

        private static Bitmap ScaleImage(Bitmap bmp, int maxWidth, int maxHeight)
        {
            if ((bmp.Width <= maxWidth) | (bmp.Height <= maxHeight))
            {
                return bmp;
            }
            var ratioX = (double)maxWidth / bmp.Width;
            var ratioY = (double)maxHeight / bmp.Height;
            var ratio = Math.Min(ratioX, ratioY);
            var newWidth = (int)(bmp.Width * ratio);
            var newHeight = (int)(bmp.Height * ratio);
            var newImage = new Bitmap(newWidth, newHeight);
            using (var graphics = Graphics.FromImage(newImage))
            {
                graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                graphics.DrawImage(bmp, 0, 0, newWidth, newHeight);
            }
            return newImage;
        }
    }
}
