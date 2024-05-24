Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92E3F9EC
	for <linux-mmc@vger.kernel.org>; Fri, 24 May 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575278; cv=none; b=LEzz9wMHxf2Tsu1LnSgOCLKCsnDfcROXlVMv8PYTefO/+Xg8IvpKhy2/9LhfSJVaqTJEh11tykh4UDMOzKOLNFWyCJjTwKYe2JPP7QUeey0WqJKQu2dLeN67PGkJlBNd7nhUFvM2KBzP/3HewrllW77xaTeG0qmk8kEz59sQzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575278; c=relaxed/simple;
	bh=t6EOXzX5NBCieefJXhaqEj/EuhQeMzBIdGFGnmyqFc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/RdlTLPaxPgE+m008qFZpMVbdSAajV0hsh3QXN1WHJZCxEUlYisz4PYmM+gvraNCNAjXffVXjiTHafoaH/GPrKY62/T5YOos/2fdnZPOB/WUBQkwVniWDZ5amxVIjAyWtRL5IIfBRonu3nMzLZ2kKp9fwf92FUEJZJS+psqZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=tyumMzdp; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="tyumMzdp"
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso68196345e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575272; x=1717180072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=tyumMzdp8FGH9YqbvdldjlPB0bjTiwCyYniuRFs67n7zZL41LXqMUi3apYcvJ/FTA5
         M3kAX0WE4j8SDbpzjxwWCCKxbw1u57Nguq/v2FMPSS4uI6dtAxizOCGZ0eBMI+giPfLs
         QvApk0fZcExSdaNCsei0Em4f1G/bHa02obSiWQYxPJYf2OTrcqNngtG7fqN92qpSMWd4
         qD7ebj+Y4Dpe1rZl9wjNyKqKRINFSoYAGtTAXt2pntSVMA26ch4aqH5QiFZPeqmkseQA
         K4fAR/cssGDV9rbvR/Vs87o/WpMpGCPjJua5UqgwybJZQDrXX7FDKs9zXG64mCd7eDD3
         osvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575272; x=1717180072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmjLsXIH2Amncxc11ehW4fWxMk13TiDZ+O44YXe6Wgk=;
        b=CaUtg2MN2hypf5zFJlWusdHSbsi5m+t7Gjk2kPTr3wnTYiH6A7I1vRpsuLdBBXk/Dr
         HrgN6jlSFDh0hQCL2DZI5WQL/Ms5fKZTqjguV9LHCxPYjYlWHJVqP5Zm2bRnXrD0gh/z
         hPnSQKC9f+1DB9oyr+MarW/pjZGWxpMqmjV6CK4kWFHpom8gQLMAC4EFqM2uxBsc6Wf2
         NjF/hEvmDnk3H7ZdfC6FHsmFUIPo7Kc6JlCPq0WLWvoLbxUkuOvzZxtshvVw2fRm3hLK
         bLW4rp2yzOYjq/fLfE3vLBrtjQ31iXCp0s+mX7tWAHkLP+3Yk+H1SppVTieMHshX1BgO
         NRlw==
X-Forwarded-Encrypted: i=1; AJvYcCUkXdi5QXEM7WhQ0udl5kRjO+lyVmvIdPNYwXJ71BMxKnnMGCpPFWsh1VX4Si1ZcaLrsGVNbDyuvKn8l0EcGOQViJJ7n1aItSTn
X-Gm-Message-State: AOJu0Yzdn/eOAxAXZviHBDH+TXPjVtTqSb4qQpPsNvViqQ5BmazXA0uF
	OGhBnC7o8cs5AzYU+434L6ppfqT9tHPhreeH61dz912WbSN0J7AoYENfX2G22p07Iww+s0o34tb
	vqsFvlpRZ0L1Zd4CbO9flMszuWijz/pEj
X-Google-Smtp-Source: AGHT+IGfOa5XBgeYIs/cH5TAMCHbRBfIruDizHffdZ+UPyoZ3jK796PR+KziATsAgtd+BnPEgr+Se5nRlYpt
X-Received: by 2002:a05:600c:3114:b0:420:2cbe:7ee8 with SMTP id 5b1f17b1804b1-421089f1394mr28435685e9.6.1716575272442;
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3557a1cd354sm56646f8f.101.2024.05.24.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:52 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 02/18] dmaengine: bcm2835: Support common dma-channel-mask
Date: Fri, 24 May 2024 19:26:46 +0100
Message-Id: <20240524182702.1317935-3-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <stefan.wahren@i2se.com>

Nowadays there is a generic property for dma-channel-mask in the DMA
controller binding. So prefer this one instead of the old vendor specific
one. Print a warning in case the old one is used. Btw use the result of
of_property_read_u32() as return code in error case.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9d74fe97452e..528c4593b45a 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -941,12 +941,19 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-			"brcm,dma-channel-mask",
-			&chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	rc = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				  &chans_available);
+
+	if (rc) {
+		/* Try deprecated property */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			goto err_no_dma;
+		}
+
+		dev_warn(&pdev->dev, "brcm,dma-channel-mask deprecated - please update DT\n");
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.34.1

