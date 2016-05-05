package org.sikolin;

import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class ImageUtil {

    public static String imageToBase64String(File imageFile) throws Exception {
        String image = null;
        BufferedImage buffImage = ImageIO.read(imageFile);

        if (buffImage != null) {
            java.io.ByteArrayOutputStream os = new java.io.ByteArrayOutputStream();
            ImageIO.write(buffImage, "jpg", os);
            byte[] data = os.toByteArray();
            image = Base64.encode(data);
        }

        return image;
    }
}
