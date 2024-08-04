Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E847A60;
	Sun,  4 Aug 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722771728; cv=none; b=NVGVpXwuEmuZlVIKSNExiGOJwmVsxaX04CIt7HaZr8P9mNaA6ggpw9n+nUC43GxmQbVJGhFoPxjUu8x7iLVICVkhkK00rcIHp14/SGT/WoT5U7e3p4ec0Riul61UbjDG8Nkc1z0iq80HE9UDv9EmToR+rDtkt/qmyW1MS9GP7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722771728; c=relaxed/simple;
	bh=7eDdfGl0fYRwpTEihKkKLEsamRTy7CcjvzbmS+u4EQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL5v1VI42gIZDsRAFMm/4NQy953Mjh9L4Y9OY73ahMP95dyPD7qZiT7e+zWt7Lr/syZhro95+xJi0+F7gqd/bjEM9mVMuVWQ3djfjLWuyqZy7MmLiX/U9/khDsLTS1IUp6n+4+gEQ1A7NkmnUvxRnwWffN//fQXebcLNZND3LlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqh0oxpl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqh0oxpl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36ba3b06186so2311245f8f.2;
        Sun, 04 Aug 2024 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771725; x=1723376525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGVXwGIeb7N3J4+10swQ61/JYCMx3W28Do3i6QPWuig=;
        b=Xqh0oxpl1lO7nVBtTPT/lVz1X1Jex5oCk9VcEkF61VIkC5EK1QxaA/9iuc1NO06Vw+
         mffoI8zfI5kYeCzcH22vym0g2DO3raiFdsddmBd0dnYVRk1NUL5Wur5eq+5Msg+Qtc7q
         c2JNkepQlsTLOnF64fDWZC4B/NmHiV8rEXQ9gIHqnMKsJ9Pvu4s10b4kD2QoPLPYLAPg
         2hi1G2w02U/VKzmiFiw4VNxgSLBYb3mWqAWLGyrjRkjs+oqMvXhVkhwO7FfXoSdFS7yt
         THFE+aYulD3eALveRLbEhDcxvQCjPCJUiDENN72krhBqWabGyznzvoPBM6zD1DbkkVLK
         03MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771725; x=1723376525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGVXwGIeb7N3J4+10swQ61/JYCMx3W28Do3i6QPWuig=;
        b=TiUNkmj3lJQGJ+cAaISWxujHndEQoEVXhjii7IgTQb1o/MbAACNr5UxoEbLi+HKkg4
         7KyrXHkEwy+f/wPGEGB5CGsRytqxkXjLVMj/Sd93VSRWjA3jYZ1bEtbRNBbc596hGX3q
         6VCcJRiqQfaKii3p+ri+gGlcsFXOLJBUrhbC8vBqhFJ/lRuTejwK3v+06rUZmjzvQ6pH
         10WWwPwMTmr9nIyon5vp8erIub2Ct57JkjPrXOrVRNk2tD5ZaPYw0jSLLvuv7WD6HiFZ
         mD1KeRGRtSifkU5HJAtRA3y24NSwpp55KYxZh2aYVhi53r0b2PoTo6rLaYz1CmgGND1x
         C1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm7r4VyqJ5CYXAmfj2EdEmnWtLCpSODUhgFZftvneAKwbydOAXLr1pB16h6+oBt3TQ6W775Ke3p3Gi6gqaMxuN8X4ouNg09L98TJIaDEhq925gCLul+wu6iM77YkNA1h69qOSXvCtnOzjsBofam+C/TfooRMti0sBWLjixm+lKwex1xg==
X-Gm-Message-State: AOJu0Yw4b9TZ3RMdSLahpmQ+CZrB0SOjNH/tfhLmK7LHVOQMh4e6GUNs
	eV19PSq4n0UErSwmqQ8oL2NzLOY8oBYyGuFoXixRPXRea6KNnEI1
X-Google-Smtp-Source: AGHT+IEkEsf7rgv+FK5pMw1rjBxefAm0Wya/QF5fP5oHTqQufDhgjOYXj5NRtQfw4DJZ93Td23+0cg==
X-Received: by 2002:a05:6000:1faf:b0:368:d0d:a5d6 with SMTP id ffacd0b85a97d-36bbc1beb75mr5955215f8f.50.1722771724985;
        Sun, 04 Aug 2024 04:42:04 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:42:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/6] block2mtd: attach device OF node to MTD device
Date: Sun,  4 Aug 2024 13:41:04 +0200
Message-ID: <20240804114108.1893-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach device OF node to MTD device if defined and the root blockdev is
being used to add support for partitions defined in DT node.

This permits the usage of fixed-partition or alternative parser with the
use of block2mtd module.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/devices/block2mtd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index b06c8dd51562..0c4ecea51717 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -324,6 +324,15 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	dev->mtd.priv = dev;
 	dev->mtd.owner = THIS_MODULE;
 
+	/*
+	 * Check if we are using root blockdev.
+	 * If it's the case, connect the MTD of_node to the ddev parent
+	 * to support providing partition in DT node.
+	 */
+	ddev = disk_to_dev(dev->blkdev->bd_disk);
+	if (ddev == &dev->blkdev->bd_device)
+		dev->mtd.dev.of_node = of_node_get(ddev->parent->of_node);
+
 	if (mtd_device_register(&dev->mtd, NULL, 0)) {
 		/* Device didn't get added, so free the entry */
 		goto err_destroy_mutex;
@@ -337,6 +346,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	return dev;
 
 err_destroy_mutex:
+	of_node_put(dev->mtd.dev.of_node);
 	mutex_destroy(&dev->write_mutex);
 err_free_block2mtd:
 	block2mtd_free_device(dev);
@@ -515,6 +525,7 @@ static void block2mtd_exit(void)
 		struct block2mtd_dev *dev = list_entry(pos, typeof(*dev), list);
 		block2mtd_sync(&dev->mtd);
 		mtd_device_unregister(&dev->mtd);
+		of_node_put(dev->mtd.dev.of_node);
 		mutex_destroy(&dev->write_mutex);
 		pr_info("mtd%d: [%s] removed\n",
 			dev->mtd.index,
-- 
2.45.2

