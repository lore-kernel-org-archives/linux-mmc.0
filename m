Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953216DC32;
	Fri,  9 Aug 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244557; cv=none; b=mqMkE17qUtO2KmZ3sTy7k+hKkSRMW9g0lQKijxdI2eQ2OhdakDJjZAapHqjOjuiWv/XQgN92xxXPKuj724lh5ZKODEhrBFqvcBPPvQRUtjD8I+zq/7RKksDmiOQ5l6eZdkYDWn4e2aLyub2o2MiEZ04iKZodQHw4KoZaSpFxYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244557; c=relaxed/simple;
	bh=i39wCXbk/q1Tvo8ZjWFPqjdA9TSVJhHTaL2sBpHLfj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvVpp4F1jMgS8j3D6ror7TtS0Bc4zY0a24gm64KWntxCiK5E3uFbhetjRfm72GI4O6iaV+ZLoDSEp5p4b9VNv2SITDmncjmMLgLdDgST0GfEl9t/hK8XvuvidYEplEQy1zDFIUdGIOIf6qoPudhEuquCrBU1HerY29peByezBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6BM23Fl; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6BM23Fl"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so33345651fa.2;
        Fri, 09 Aug 2024 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244554; x=1723849354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=G6BM23FlXcCPTcOak9NDbtS9061t1/JNTXwt18wCvCIJ04vxTlmNgsWjJpFvVwUlZg
         3bqc7OQVq6IClgX0bBhwTxP8keh+kaGVsK+/4pHc3P2EWGtuLfv/byQcfVL3FsoWzMES
         DWtuhtlXrsRPwtMyhVeuAcQqYbcN4C+srncz0s578L31lY5kDCFiSA0B3Rx9G06Wv7uU
         T5of31F7e+z/fWV+3sHOcTaWooI0Rns6ALzwGZEDHYUWWh245jwcDKk8OAR3c92zYUhu
         n/a/ysA4ItVmxZ8iF/lfv5gAu9178+rzgssxtPp86b+A9bfWPSS1oucPKhLVqoHoOm0X
         X40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244554; x=1723849354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=Yrun9Nvz0xT5z7ArF4ZaBv/mGjE7yQSr8OTqTQYrXSJB+VrgKIsxMUgciZSfOa2bfQ
         zS3H61QixkK4YPneAyt84nwXgD6RWPJBOcW7KEP8yZIjW2oQ8/u7MUHiFfdYGieUbbOB
         X+ZEAplNjvnHWXTcKqLzjkbg2tq9fFXgiuBsvur3OFLGhwgl5HSqMVMIQUOiqiTiNzxL
         gXKxMBvCIo/4k0hWRZrralUDszS56RmfCzOqIYjJ4n15uBbWtu0xK4G4dZQPJDXvAJxe
         TEYn27Jkl2yfnF311G5ZXQ7E6KU0LlslHpVn6dECLTMIhcorxixvMLqbHAxvzS1BBwE6
         QYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2itlZkj2dESLH7vFCymEeqAr+Qj4sYRr23yji2004hazcKLVCQ3I1rAjMQ0YTejsnhFkD/UlBWiGyiNXEbz5h1X5DGFx8jRTjKSn7CIxd/44ueSQhhaE6Hp9zNp9kUhr62vc1sfa+yyfrEP+6znFeqca58W3ck86w9+ZPo2HhLcoeSQ==
X-Gm-Message-State: AOJu0Yw+Uj1dhTfViXGLSnTps4Kv0RC1CIotgjPlPYFRCjdVx0pvcBHS
	r+NN4cBR2HW2vyWoDjLqEUp5dQXSs1G0BxCjd6igTEVspFpH/5tBFvXOsQ==
X-Google-Smtp-Source: AGHT+IEF0Y3NVeo/gUFLIVY34RZUu3ByxZUGMianP0w6Y0uhOo40dlxWIt5krkPxbZ2lUqfhtQM47Q==
X-Received: by 2002:a2e:a589:0:b0:2ef:228a:1b86 with SMTP id 38308e7fff4ca-2f1a6c6b8b6mr20863381fa.21.1723244553325;
        Fri, 09 Aug 2024 16:02:33 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:33 -0700 (PDT)
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
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 4/7] block2mtd: attach device OF node to MTD device
Date: Fri,  9 Aug 2024 19:21:02 +0200
Message-ID: <20240809172106.25892-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
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

