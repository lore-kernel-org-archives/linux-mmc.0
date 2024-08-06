Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6191C4630;
	Tue,  6 Aug 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944497; cv=none; b=tzQqGwVcxHt6XZv6IT0j6MfPvHJlKZ5PJHGaK0iQcj+4UL9uanPdSePVHUyacjZkAmkXJCCV6qMiCn+KH4y+jMRN1lmkzNdSopynnZ+f//ErwJD/xh2kyU3cYPIU0/M+1uNfHiTqG16kn1RqZmQQL+Q0IHX0eMPwbZWEAZX5Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944497; c=relaxed/simple;
	bh=i39wCXbk/q1Tvo8ZjWFPqjdA9TSVJhHTaL2sBpHLfj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knWqNWVpGWBMD6+i0GQofRQDIKHIGiRiaeDVfpIjbvR0b0IOL9LOKdu/1K35ic/1SuagdIUFo/wuTqoihHTa52bqYfOlE7Kx7jN3bsJMyReFsIplf1kzX0L5AHZ0Ms3i03Dn3pQnc22WAZri181Iotz8viDAizL9gw//FZemYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6qXVGCD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6qXVGCD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso4948805e9.3;
        Tue, 06 Aug 2024 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944494; x=1723549294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=Y6qXVGCDVaPQDmaoH3htnVPpYMIUS+pstp7tL5ZAL6xZrGrZXENeioPiPXliGNrfr7
         aO178VVzXP9F32rYPH4uosBgzjzZDER6HSOoFKUFYBC8JIzS/9yVNRCQkLNvLgfH0mgp
         cmlv3vJhRQpThO8A40W+4VKdVIoevRjW5v3aJQftpORprVbr9YxagrQI6X7MsL3T8iBl
         xvKoz1/19frZ6xYzEgpWTte/jTQnQUkGi7lahQeCYuOQQejFvp9xeYtd3FUCD5IjRSxs
         Vt0iNVRTz5ypu0wL5KgFis9V0LJtR2eIO9U5cg201ROElCfNzTjti60rX6tpnBUhTnfN
         gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944494; x=1723549294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=ouztzby5yx1uW9eJcYuzFDmuANRjxVs+/zZmd2GogkP8qroQuVurdzluTOk0ss4Fgc
         zmFg/ZFbpVJM18oOYFBllID068nwFNsXGuPspMGkxDovduy8r54jD4/JCJH4n0IbxmzF
         Nidvn/l+EhJgYmInE2HkWYWU2Tf9wgygOoo6aGy8/MU1tiarDZ6mZ+giKqCOICgAiwhu
         WZ0e4ICIdwVpYsbFIYXgKLKy1sJTEkWhtrErWf2ZNYSUZfqoyyML+/QtDx7R7LepBqsy
         NJpZKNUg4pklBAbzroY25L604N64jyXolrgTpIQP4Tl5H10asHkTq2nTS0l2nZnswLcH
         GU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtMScHijpRtHqizPm0x122D4mqAx3q5EumqfAORAfto1lTMXROQueqVhwVYFYnmgdRuyvyWqA/0MOivr8GkMszq1x9OUCM3wC7+qB61BySja9uNQSOvj+NY9jb3ckF8asMLMX9RAeq2Juwb9Yz+bpgEyQhzzEHkpKgvA2OKw7gMkhC/g==
X-Gm-Message-State: AOJu0YwS+fHQFwji5AFnln2NLilaQD/anEi3DfCRux68K5JnO3T1YEjP
	2vMm2I+kAs3MfEOtAhhtg1GP6WsxpS7IN133KlzDwYjfu8SSH1M8
X-Google-Smtp-Source: AGHT+IFGVYMjIkc1rf+t9JbyTCPhrBWsc7Ju4jzCOzjNnzD1sS+oEYPY0w7XNI1EwLNMTIC2ME3gng==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428e6b0274emr117918275e9.11.1722944493977;
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:33 -0700 (PDT)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/6] block2mtd: attach device OF node to MTD device
Date: Tue,  6 Aug 2024 13:41:14 +0200
Message-ID: <20240806114118.17198-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
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
 drivers/mtd/devices/block2mtd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index b06c8dd51562..8ff9787edc24 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -265,6 +265,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	struct file *bdev_file;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
+	struct device *ddev;
 	loff_t size;
 	char *name;
 
@@ -324,6 +325,15 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	dev->mtd.priv = dev;
 	dev->mtd.owner = THIS_MODULE;
 
+	/*
+	 * Check if we are using root blockdev.
+	 * If it's the case, connect the MTD of_node to the ddev parent
+	 * to support providing partition in DT node.
+	 */
+	ddev = disk_to_dev(bdev->bd_disk);
+	if (ddev == &bdev->bd_device)
+		dev->mtd.dev.of_node = of_node_get(ddev->parent->of_node);
+
 	if (mtd_device_register(&dev->mtd, NULL, 0)) {
 		/* Device didn't get added, so free the entry */
 		goto err_destroy_mutex;
@@ -337,6 +347,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	return dev;
 
 err_destroy_mutex:
+	of_node_put(dev->mtd.dev.of_node);
 	mutex_destroy(&dev->write_mutex);
 err_free_block2mtd:
 	block2mtd_free_device(dev);
@@ -515,6 +526,7 @@ static void block2mtd_exit(void)
 		struct block2mtd_dev *dev = list_entry(pos, typeof(*dev), list);
 		block2mtd_sync(&dev->mtd);
 		mtd_device_unregister(&dev->mtd);
+		of_node_put(dev->mtd.dev.of_node);
 		mutex_destroy(&dev->write_mutex);
 		pr_info("mtd%d: [%s] removed\n",
 			dev->mtd.index,
-- 
2.45.2

