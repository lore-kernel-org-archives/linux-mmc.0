Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A3C49EA3
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 12:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E9361C6A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 12:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhF1Mgs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Jun 2021 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhF1Mgo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2021 08:36:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF3C061767
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 05:34:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k30-20020a05600c1c9eb02901d4d33c5ca0so5635494wms.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMcNdNV/zxnl24Zb+eQ2KAOBn0PDg3eIMbVHzi6s7uc=;
        b=n4ybLPlL3/1joPuxxHNHpI3mW5tO5FpCM+YJ8TS6PbYpUBHjO1jKxdNa8PMOTxleqP
         1j8S2N2LPNveDMkTxJx0ROrVWO++gplHxSfJnB/B5alz9cr+jiPfZEjU4MV3XTMs3hNd
         SYuRlZslWF6ipwvOQt5RFqunoRgnl/C5lNgr8guE25rlAmPxbKg0ghoL5nPB9MxSzECV
         WwZRGOA2vKuYrCh6AXxySl8UGEz4vgbpkiuhxYHJBRlg8X1Ua+oT1S4sE3VwYgM9W0Dn
         iFuoS2D7Co6N8UcOdS1htqI42LaK/bSP2IRid1pQBuExDaReZ+xlpf/ueyyf8BUQw8sg
         yAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMcNdNV/zxnl24Zb+eQ2KAOBn0PDg3eIMbVHzi6s7uc=;
        b=Pb2phU/GOomaicraJrTF+942iu1aF7XiR5tgDFtp0kD7flIzjWm4fMyCImWnH/gVcb
         no9a0Ny+1wAuGZK2IdlbViAkc+XtYGAM2ihn2AYDuY5R2B0HcSI+MTvtjfFrd4LrAp+L
         CaZsTS1G7/ORa+4WxvSkha2sYj6/xYQOdYzJbLUkEKjxJtAqdw/uDTXmqqXDCOzDJkT3
         80ZZLeAnK9EbWDJLVLnJkj2ddjeVap1jKTPWxhB5mrS5pk7e9nwv0MlXEmXKTLnGPmDl
         IuWw8KL2acKhjm44YOLoPcry2rjVGkJyv8Ms3m7jEkH2NTDAJhBvXOJd8OQa0bSpikQ+
         2k0g==
X-Gm-Message-State: AOAM533NCbLKl64V/RDiC3/BaSg0+zrHmTdsStSvokodcPd/OvXN2RI9
        TbL1Iy+8fQhZ7sARz2p+KOPfxg==
X-Google-Smtp-Source: ABdhPJyRVNiwbKEUyZiv1OXqr+IiS6cag6J6zkL71re9VjAEg/KXzt2XgTERz1sN3Xa+wcEkOR/9MQ==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr27223719wme.45.1624883656922;
        Mon, 28 Jun 2021 05:34:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:e503:e76:4043:c4f7])
        by smtp.gmail.com with ESMTPSA id p7sm2357334wrr.68.2021.06.28.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:34:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jgg@ziepe.ca, leon@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, ulf.hansson@linaro.org
Cc:     torvalds@linux-foundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RFC 1/2] scatterlist: add I/O variant of sg_pcopy & sg_copy
Date:   Mon, 28 Jun 2021 14:34:10 +0200
Message-Id: <20210628123411.119778-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628123411.119778-1-narmstrong@baylibre.com>
References: <20210628123411.119778-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6417; h=from:subject; bh=BbSammnaIH+4ihlQd79kuFnb7IsiPaFQmdq0nUxcd2M=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBg2cGYtsG66kVzD7lz6EwaEWdyAL8yAmArtvUj/T1g MUixpOWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYNnBmAAKCRB33NvayMhJ0VlfEA DBZ4/86P5cZzbrVWPKSl4cL3yRar43R+bByxESQSRjmBxgl4YXNmec1BkZZL7/IwM2h/J8ggjJ25oF m2iY6QQ14YOahg6umbLDrURx8u9mj1gNeAXFhIpK7si8RFIFkYNCf/bzVpsnxMTQVfY2AI1lwr7zcx SH7mY8CZ0uOkcnnD6G+ifITXRE2Dve5S1rAZ6eXC2k+aOjjhypnkhI06TJSw8J/z381vNAPaijyt7d l5DtyIezXQp59pEfaFj3PkquUkf8E5madStPjMtwqNE0kNxkaadEnLytf2Aq00IRSt37sGSjxLfGOk 3qF78NvBQuB/N6BUfBRbgtiNw4r6NYdiVcJk2zWtMSSeKZcHzzabqsOuotTh2sCpyVUkWBQTTaar3W OjPbd7s+IooVw7NtlTrSuqC/pYRSEr5EYuZcA68qHuYzNSFDcrIL5zRgd6oPSnfG7JzyIGhAm6qqXM SLncij/H8uiWO2trRxWXC7ArbDGbQdVIR+gQ6XSdWSdSMPt7T8pFXobyuF6DzLyf1AOip0knhNLVfv dO8UQIejVuhfVdYgrgjUs6JuoIElohBok1+QNHTbo/lIzHGpEIwIfI8D2Meouzy+98/VnPrEmHDpsI EbkblupObOlG8SoJSMGGflvg21+VIR6Ni4Cn27n/5HNffB34smISo+QQxUww==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When copying from/to an iomem mapped memory, the current sg_copy & sg_pcopy can't
be used and lead to local variants in drivers like in [1] & [2].

This introduces an I/O variant to be used instead of the local variants.

[1] mv_cesa_sg_copy in drivers/crypto/marvell/cesa/tdma.c
[2] meson_mmc_copy_buffer in drivers/mmc/host/meson-gx-mmc.c

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/linux/scatterlist.h |  14 +++++
 lib/scatterlist.c           | 119 ++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f70572b2938..6ef339ba5290 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -308,15 +308,29 @@ void sgl_free(struct scatterlist *sgl);
 size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 		      size_t buflen, off_t skip, bool to_buffer);
 
+size_t sg_copy_io(struct scatterlist *sgl, unsigned int nents, void __iomem *buf,
+		  size_t buflen, off_t skip, bool to_buffer);
+
 size_t sg_copy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 			   const void *buf, size_t buflen);
 size_t sg_copy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 			 void *buf, size_t buflen);
 
+size_t sg_copy_from_io(struct scatterlist *sgl, unsigned int nents,
+		       const void __iomem *buf, size_t buflen);
+size_t sg_copy_to_io(struct scatterlist *sgl, unsigned int nents,
+		     void __iomem *buf, size_t buflen);
+
 size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 			    const void *buf, size_t buflen, off_t skip);
 size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 			  void *buf, size_t buflen, off_t skip);
+
+size_t sg_pcopy_from_io(struct scatterlist *sgl, unsigned int nents,
+			const void __iomem *buf, size_t buflen, off_t skip);
+size_t sg_pcopy_to_io(struct scatterlist *sgl, unsigned int nents,
+		      void __iomem *buf, size_t buflen, off_t skip);
+
 size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
 		       size_t buflen, off_t skip);
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..e52f37b181fa 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -954,6 +954,55 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 }
 EXPORT_SYMBOL(sg_copy_buffer);
 
+/**
+ * sg_copy_io - Copy data between an I/O mapped buffer and an SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy from
+ * @buflen:		 The number of bytes to copy
+ * @skip:		 Number of bytes to skip before copying
+ * @to_buffer:		 transfer direction (true == from an sg list to a
+ *			 buffer, false == from a buffer to an sg list)
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_copy_io(struct scatterlist *sgl, unsigned int nents, void __iomem *buf,
+		  size_t buflen, off_t skip, bool to_buffer)
+{
+	unsigned int offset = 0;
+	struct sg_mapping_iter miter;
+	unsigned int sg_flags = SG_MITER_ATOMIC;
+
+	if (to_buffer)
+		sg_flags |= SG_MITER_FROM_SG;
+	else
+		sg_flags |= SG_MITER_TO_SG;
+
+	sg_miter_start(&miter, sgl, nents, sg_flags);
+
+	if (!sg_miter_skip(&miter, skip))
+		return 0;
+
+	while ((offset < buflen) && sg_miter_next(&miter)) {
+		unsigned int len;
+
+		len = min(miter.length, buflen - offset);
+
+		if (to_buffer)
+			memcpy_toio(buf + offset, miter.addr, len);
+		else
+			memcpy_fromio(miter.addr, buf + offset, len);
+
+		offset += len;
+	}
+
+	sg_miter_stop(&miter);
+
+	return offset;
+}
+EXPORT_SYMBOL(sg_copy_io);
+
 /**
  * sg_copy_from_buffer - Copy from a linear buffer to an SG list
  * @sgl:		 The SG list
@@ -988,6 +1037,40 @@ size_t sg_copy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 }
 EXPORT_SYMBOL(sg_copy_to_buffer);
 
+/**
+ * sg_copy_from_io - Copy from an I/O mapped buffer to an SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy from
+ * @buflen:		 The number of bytes to copy
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_copy_from_io(struct scatterlist *sgl, unsigned int nents,
+		       const void *buf, size_t buflen)
+{
+	return sg_copy_io(sgl, nents, (void __iomem *)buf, buflen, 0, false);
+}
+EXPORT_SYMBOL(sg_copy_from_io);
+
+/**
+ * sg_copy_to_io - Copy from an SG list to an I/O mapped buffer
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy to
+ * @buflen:		 The number of bytes to copy
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_copy_to_io(struct scatterlist *sgl, unsigned int nents,
+		     void __iomem *buf, size_t buflen)
+{
+	return sg_copy_io(sgl, nents, buf, buflen, 0, true);
+}
+EXPORT_SYMBOL(sg_copy_to_io);
+
 /**
  * sg_pcopy_from_buffer - Copy from a linear buffer to an SG list
  * @sgl:		 The SG list
@@ -1024,6 +1107,42 @@ size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
 }
 EXPORT_SYMBOL(sg_pcopy_to_buffer);
 
+/**
+ * sg_pcopy_from_io - Copy from an I/O mapped buffer to an SG list
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy from
+ * @buflen:		 The number of bytes to copy
+ * @skip:		 Number of bytes to skip before copying
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_pcopy_from_io(struct scatterlist *sgl, unsigned int nents,
+			const void __iomem *buf, size_t buflen, off_t skip)
+{
+	return sg_copy_io(sgl, nents, (void __iomem *)buf, buflen, skip, false);
+}
+EXPORT_SYMBOL(sg_pcopy_from_io);
+
+/**
+ * sg_pcopy_to_io - Copy from an SG list to an I/O mapped buffer
+ * @sgl:		 The SG list
+ * @nents:		 Number of SG entries
+ * @buf:		 Where to copy to
+ * @buflen:		 The number of bytes to copy
+ * @skip:		 Number of bytes to skip before copying
+ *
+ * Returns the number of copied bytes.
+ *
+ **/
+size_t sg_pcopy_to_io(struct scatterlist *sgl, unsigned int nents,
+		      void __iomem *buf, size_t buflen, off_t skip)
+{
+	return sg_copy_io(sgl, nents, buf, buflen, skip, true);
+}
+EXPORT_SYMBOL(sg_pcopy_to_io);
+
 /**
  * sg_zero_buffer - Zero-out a part of a SG list
  * @sgl:		 The SG list
-- 
2.25.1

