Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCDD29E
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240535; cv=none; b=KbMgPAOnuFQXqNnjhtfZ6/kAlsBCtlsICFaTxFJADa+9yM5UTXLI/WT8ysh46MaMrAD53MKWDb721Xd+wArLX9OcpYGfKrjRrCDVNbJpALnYJ3cLWfgVDkMiyu2xWLvv+N2TPibLb+XUIRrIPMzgRcKDwuWdbl+deA4RNHDTEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240535; c=relaxed/simple;
	bh=i61iriaHsLTXBQJeVHPzQE+TtyVHYruTFs3R9d4R12Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDikTKCNGl2lHJSD8rnmqEikcnXkcVK/KGzgUOTBwWRc+1b0W8+6bL0zkg9jjgCPmROoUXLmFq1DCHnktGYaSuL7vepg/iMSemXn9tpujXp6FbuIevVej3VNORKi9HQJiIDXVElW7azHAH8GZenJueRMl0KodvquUq4s4brRDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semenov.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semenov.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ff940b456so2561115e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 09:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240531; x=1707845331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsdcXa4Qx4HaKCx419GphbnTiDdfpQ+Fio1KJSGYIvk=;
        b=TGlezoHFKhZHlWTLDTV/soQlmF24N+AXBiRfru4FgYa5UF9mHdT+d00hSnXgxp7P7s
         rLII2DZMYbxFvNMFm4gWjZnzT5FC/FVqA1TdDPFuxMdubwYUt4d2ygMPX0zzajtgZS3H
         Js42c4GXAVgsA6PzQ1YjYx7h/Ef/5uWOtxxdaY3dG+/W2yligyV6dM0lpSws0s4ogdaO
         xjao5qGTOdRackdFe7SJm4RWY5jbGBuEgYbLb9vg6JhPJNhK8kgZYCVFCczzP+4Vq4La
         SN4WQsmATuiUTTDrlc1FRNfUiMwwoCe7x3XsWA/76zSqvRfXldoo31E2n29bTZPqVmpF
         8ZFw==
X-Gm-Message-State: AOJu0YzKCxxN/xbXKL5OrZQWjthogkfSbuBZklooDX5VIyCLYhcTI2Nd
	oJsGjry0M1aCJkmx4PIXsjergqyh/gnfUE+Q6rnDh5UbTKbnooGyX8x3EhpLF82WVg==
X-Google-Smtp-Source: AGHT+IFAVGJrC0k2iRAO299lOWkxF+bisrYqb1ufu5pp1vvBSe3AM2NoAHiXOff/TDXiIXnMWf1pEw==
X-Received: by 2002:a05:600c:3147:b0:40f:af68:3ab with SMTP id h7-20020a05600c314700b0040faf6803abmr2226834wmo.5.1707240531537;
        Tue, 06 Feb 2024 09:28:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFQ4r+vnTFC8tFdlBZ+ZhXy59FhgumJz2UMWd5/EiDjLCpWWGHywU/EjXwij/qfJhrEH2uLaVJTjh9qDbWqCJPSwxmstAQ3Li1qJYpJS1G5r9GYN87iQ==
Received: from Ivans-MBP.lan ([31.216.122.163])
        by smtp.gmail.com with ESMTPSA id jq16-20020a05600c55d000b0040fb0bf6abesm2558946wmb.29.2024.02.06.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:28:51 -0800 (PST)
From: Ivan Semenov <ivan@semenov.dev>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	tgih.jun@samsung.com,
	Ivan Semenov <ivan@semenov.dev>
Subject: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
Date: Tue,  6 Feb 2024 19:28:45 +0200
Message-ID: <20240206172845.34316-1-ivan@semenov.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux mmc driver currently encounters a problem with eMMC chips connected via a 1-bit bus, when the chip supports a 4-bit bus. This regression was introduced in commit 577fb13 after functioning correctly in kernel version 3.15.

In the function mmc_select_bus_width, the driver attempts to switch to 8-bit and 4-bit modes, but if the 4-bit bus test fails, it does not fall back to 1-bit mode and leaves eMMC in broken 4-bit mode. This results in I/O errors and failure to read the partition table.

This patch addresses the issue by ensuring that the driver fallback to 1-bit bus mode if the attempt to switch to 4-bit mode fails.

dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 pin) before patch:

[134509.044225] mmc0: switch to bus width 4 failed
[134509.044509] mmc0: new high speed MMC card at address 0001
[134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
[134509.281602] mmc0: switch to bus width 4 failed
[134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.284609] ldm_validate_partition_table(): Disk read failed.
[134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.289553]  mmcblk0: unable to read partition table
[134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
[134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
[134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
[134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, async page read

After patch:

[134551.089613] mmc0: switch to bus width 4 failed
[134551.090377] mmc0: new high speed MMC card at address 0001
[134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
[134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21
[134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
[134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
---
 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f410bee50132..58ed7193a3ca 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
 		EXT_CSD_BUS_WIDTH_4,
+		EXT_CSD_BUS_WIDTH_1,
 	};
 	static unsigned bus_widths[] = {
 		MMC_BUS_WIDTH_8,
 		MMC_BUS_WIDTH_4,
+		MMC_BUS_WIDTH_1,
 	};
 	struct mmc_host *host = card->host;
 	unsigned idx, bus_width = 0;
-- 
2.43.0

