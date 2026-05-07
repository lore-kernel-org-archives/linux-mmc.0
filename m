Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851374508E5
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170219; cv=none; b=Bgs60bv59XNB0RkLJdPGKzqj1qSr9l1Kt80hue3aBs/F9QDhuVauhNO5LerXout7C/l+DCn1tdQGJ3zdWidk3XNUSMcPpw2EVqlnd08Me2Ez1w6WpeJEgslt531TTOAfDTtIY6Kh21slf5QyVX7qXvWeABv2c0JWX2jFZMmvJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170219; c=relaxed/simple;
	bh=pZLKugcNuIFz+TCCWdncQFh/3U8qnsDMYQHV/KwPCIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUntZvS3xBhclfTUTovOYINOCjh3FAj0yZxkVn0j/JMVSs4CrhfKvK0DM6sCwdQoYdRqC0Kn0MWX5c9ex1D5Sen5a5G905Qwd8MaR4eQDghqpLXIYPlOrO2NyvfPapf7gne7w2cFb2qSzv8V03mp7lTMYeYLhikCZmXth6dZdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Vie/eGWx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Vie/eGWx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso7504775e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778170216; x=1778775016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ3SQvBiRUwqrCcVCAbqsQm4u0JNgKs4uH+IAlcNiSM=;
        b=Vie/eGWxRkpOsLCY5nvQ7FxyOM2aoEfQg8tElMmNG39of2HnHtTNHBYCxWdesmjp/m
         8a/Yw2xJ8G+F8EfhqhMICD03w6gWN9EvgQaD1wbtnywjWY1zC/a5zWxPCG3ITlTZ2HjF
         c1AqIx5eU1PNHmniE8vUe6FNs9yRa8ODv81Zr2Yi5QVoDYMughY6i9leLJnpCPuaQPO4
         4ra2oHXsdEPhqhjSL01SFX5D+KnxKAq040ckWfLGaAROb8FCuLcXwMHbvkPTj3kkakcu
         YKf5CZOS2nKF2Qo6Okoaandc4aroPslxPGQNkIJAr2MIz2TU44wKFPry7ooXWoHH2tds
         5W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170216; x=1778775016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ3SQvBiRUwqrCcVCAbqsQm4u0JNgKs4uH+IAlcNiSM=;
        b=ToYfMDKQbvbK3EcaGxenfDsXTncsgCgkAajT1doB6ABbSMHDAe/+WOFCAGS8sQFDQl
         t2ZPbTft7j7kOYcy7QlvNBFflya8fciIA92dx/5kaIouTMqYaYLF/K14224WcMpf5LtG
         5iA5C26yqw0FSoVW1pnzAT8iGhvUIJDUEOifMy3RLCSRhSiaw193O5pLTNRd8H3jn4Fy
         5FPPhtPugShvcLK0Y5Pb5hbJtO6r7V0EcS+X/3CmEZs5GYzRlVmbkwwwMO882clS+0R1
         Oahg4WOlrnoK3E2UrFX4O4Q1CCNT7mZIBVVJ4SJN4PUqVyyzwp9KkRgZA2r5j9iDeXzk
         y7dQ==
X-Gm-Message-State: AOJu0YxuPxUYZgTnm4f7WCbOrKdAavngrXTne39MVbRVLTEjSB9L+nPu
	sNQujh8qJkn4G3J6TbJMzzpSUz/2x9rEeoZnvXIhm4uFcwoCjlmtxFqyO99ZN22I5hQ=
X-Gm-Gg: AeBDieuHob2y/BNFWvNJ3wgHv7Zdn/OmP4AMcYGG2wCPl4x5zZZefkkv90CEEI5wG62
	TKFXXRVFmvCR60mYiR1eibhUjZbmBaRD1MVbck37T1e2ZEARtKVlV25tmjteRr6qAz9St+ePPxO
	JYiA9F9RA1SqA7kOxBFTmZctFn7hcq5dHoKmowK90qMj/9chbmGifuY1KPXDhAlPrq74ImlaRfK
	RPTE30sRKDXx+jVsLkWlJjearWPpCXv0eFPM7DHRewJgql148sBEO6315o+VX6I5QbrZwe9mYo/
	jqXlgcG9/9ihkxwSZCrDYl5jypqjJ6ecTq09d9w5o2JGfmc44fIu0zOUuIPgUj/X0/RTKGYqbt1
	raLq79Q9azdbufKwvlhMIverIew9l1nLSBcseVnOTI3awylsTeri4krKTo52ud74mZ12+ZyH0O2
	efkDZs+kJSbEl+AiNdc7Uutzrcfamfg7aZYL9CflQScKrlAZtCNAiypNc7qF9GnR62gDumgIOjL
	pl0PchTSEctw0isxeRR7KgR+w==
X-Received: by 2002:a05:600c:3b17:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48e51f18561mr134064005e9.6.1778170215581;
        Thu, 07 May 2026 09:10:15 -0700 (PDT)
Received: from localhost (p200300f65f114e08e9fd60f450b139aa.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:e9fd:60f4:50b1:39aa])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e538fb1a7sm233571675e9.9.2026.05.07.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:10:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] mmc: via-sdmmc: Simplify initialisation of pci_device_id array
Date: Thu,  7 May 2026 18:10:07 +0200
Message-ID: <20260507161008.3423977-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=pZLKugcNuIFz+TCCWdncQFh/3U8qnsDMYQHV/KwPCIU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp/LlgxbXjFmnL1/KWaNoKK5E+38Q6jYt6xKLgQ vYmvxfN8YOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafy5YAAKCRCPgPtYfRL+ Tp6HCACbUYVynyLfxWs/MZfoOhbxACQMGzroPNx+NcW/0ob480s2t1AV+j7xSCO5F7585WdU96u x4IZa0WG2l/8OhoYL2KbTOCVWMw1Sv8tNqZk5ehGpuU+u486QuYQLRrWReqiiI68hyb2KoO0pw+ 3IDiOAnwo1RM66o664I/jtiHna/K/iAoL9ueKymU8sN+hsbe0w58/HdTAk55lQbqaO7rGfo7qAT WizU/En/akR3KMg93A5LJp8iClCKBFvty6lZ0NKa7b92ASHk98ZmuWaWD74jO9VqH0jb6IBl2yD qVT7XToGGMGLIRIxrWTYeZBiQuQZ0U12ycF9gwPDw44TX4sH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of assigning the pci_device_id members using a list (which is
hard to read as you need to look at the order of the members in that
struct in parallel) use the PCI_VDEVICE() convenience macro to compact
the initialisation while improving readability.

Also drop trailing zeros that the compiler will care about then.

The change doesn't introduce binary changes to the compiled driver,
verified on both ARCH=x86 and ARCH=arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is a preparing change for making struct pci_device_id::driver_data
an anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/).
This requires named initializers for .driver_data. In this case the
initialization can be dropped as the driver doesn't make use of
.driver_data at all.

Best regards
Uwe

 drivers/mmc/host/via-sdmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index c628b3bbfd7a..8c049f8355cd 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -323,9 +323,8 @@ struct via_crdr_mmc_host {
 #define VIA_CMD_TIMEOUT_MS		1000
 
 static const struct pci_device_id via_ids[] = {
-	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_9530,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
-	{0,}
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_9530) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, via_ids);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

