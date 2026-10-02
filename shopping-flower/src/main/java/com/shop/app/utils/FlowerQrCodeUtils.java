package com.shop.app.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.shop.app.common.config.RuoYiConfig;
import com.shop.app.common.utils.file.FileUploadUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * 鲜花二维码工具类
 *
 * @author ruoyi
 * @date 2025-09-08
 */
public class FlowerQrCodeUtils {

    /**
     * 生成二维码并保存到指定路径
     *
     * @param content 二维码内容
     * @param width   宽度
     * @param height  高度
     * @return 二维码图片的Base64编码
     * @throws WriterException
     * @throws IOException
     */
    public static String generateQrCode(String content, int width, int height) throws WriterException, IOException {
        // 设置二维码参数
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 1);

        // 生成二维码
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, width, height, hints);

        // 转换为BufferedImage
        BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix);

        // 转换为Base64编码
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "png", baos);
        byte[] bytes = baos.toByteArray();
        return Base64.getEncoder().encodeToString(bytes);
    }

    /**
     * 生成二维码并保存为文件
     *
     * @param content    二维码内容
     * @param width      宽度
     * @param height     高度
     * @param uploadDir  上传目录
     * @param fileName   文件名
     * @throws WriterException
     * @throws IOException
     */
    public static String generateQrCodeToFile(String content, int width, int height, String uploadDir, String fileName)
            throws WriterException, IOException {
        // 设置二维码参数
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
        hints.put(EncodeHintType.MARGIN, 1);

        // 生成二维码
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, width, height, hints);

        // 创建目录
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 保存二维码图片
        Path path = Paths.get(uploadDir, fileName);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

        // 返回文件路径
        return path.toString();
    }
}