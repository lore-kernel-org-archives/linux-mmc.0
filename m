Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8A13B7BC;
	Sun,  4 Aug 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793481; cv=none; b=d50AfIpeTcaezsHYubgLIdr71j06xiXVjsHcX3ZkXABXGzvX43MvyAlJXVeD7T+ZKmvgn/aE0t1qxdMZtuO1vaA1MgT5HkB00NoDAP7ad7sY8pXm+69H2xKy4c/vftG0mCPwCqMoFQsviF8XgYetJ36fHWwC/CErxIyWaW+mF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793481; c=relaxed/simple;
	bh=i39wCXbk/q1Tvo8ZjWFPqjdA9TSVJhHTaL2sBpHLfj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoRqJ5jQbgLkjQmG+dtMDVKgrj7uvFX1hWEvc0tTQbrHwcxZ3abPmC3MNmcMv0cqz0LT3H3DNR+Z1W5HeRPUEe4g/l++9FAAVKyhnLJBRUlQ9bRHRsJkRtaOYqnCu4gkNoybgdzrvuwTBiIhHf3bfuW5H7UHBtF6GLV6pIBZCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk49D1FB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk49D1FB"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso108270761fa.3;
        Sun, 04 Aug 2024 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793477; x=1723398277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=hk49D1FBGKjjF1vX1GuJooQ8x8VaIsrLZ02BZ4M2WbCCr0yHJ73aP5rf9Ygf6SZOjH
         aAwIxlsGH69L+Vf4dPslpA8rXpFBLCwiPYCZGkivlPC+nzybYnImHk0VV10ZlJJf12pZ
         ABFQZcU3JamDWpm78UQpxzhbMs2RihO+aUH8h2XSg1iM1PRvtGG5uvJXNxD4YwpNKppM
         pVZ5G0K1p13Eo+RNMVP1QcAdrV6G7hw7jQnl+mL5bGKlDHpUWXmIWNHyjDZCyLycBxnS
         +dYG1/cvhbTrQwAv5LTxgK+Uzwq2UNXB+lQU4opoCccwwySb+b2HQppqa4etGBlBVuxv
         E/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793477; x=1723398277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AwITVf2WPGSBxmw93SjsOJVEu1oqZyIKeUGfTrfzs4=;
        b=eZCdUhLejz07H10G+KfLPz2U3ydv19Wnn/dbhEzcnq+KBXSxRjKF5vkqzpaLCpunVN
         VdTG6Ij09kpRtPL9ynOi1xYERiKO3q3C7d/qkPPp7dmoLKsYwbfuWuzkuVQUydoLLvq8
         i2Haw6ttrgEgk6FZL3McRhP2Dzcrx/4NUR8X+lopamXoSzUGidYe2BIw/n4kAZx0HWCY
         QQcS8UY7JOKYwv0BPwvldQvIubGQw+Q9fQeY7pLBXlmILj5D9tjxjaEsAYlWXxTmj0Cq
         5MpFmMSY5sY9oI7nk5YD77FB0NwvmLQPCHMovYfWlHP3C/nYe5rrYv88swjlgqqjIcLZ
         cm4g==
X-Forwarded-Encrypted: i=1; AJvYcCUL16gbz07YwOUBF9wZoSmRvrk9b+oueGWnM8royWCz6QWI7hBZa9T7cD5BNkTn9+5zkjk7xIabU9MP5PBSKkZ8s7Jee5NgxScBrSM9rQ7tf47QSdX6x/r0ByFvYjR3rsrgMRKae+zldFKMyg+zc3oHISo8QFHgG5HeDHvNZm149nUeGA==
X-Gm-Message-State: AOJu0YyFPPci09rs3kwKdbS3GvQOcEYjqsNA8iVX6QX2R3ipR3n1uQ2H
	LhJMeX2Lk6rOXArXZbzy5r1rRPsfxmq1OwAvuLgrdYTEHJpxhsCV
X-Google-Smtp-Source: AGHT+IHwTmhJSwb0UG1rOpSRK6ekgmxd5y81uHXMaKyWlIHKHAQERVOHMSA2nnFtlJccl0EgNbQB/Q==
X-Received: by 2002:a05:651c:213:b0:2f0:1ead:b72d with SMTP id 38308e7fff4ca-2f15aaa3e9amr61952151fa.12.1722793477247;
        Sun, 04 Aug 2024 10:44:37 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:36 -0700 (PDT)
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
Subject: [PATCH v2 4/6] block2mtd: attach device OF node to MTD device
Date: Sun,  4 Aug 2024 19:44:08 +0200
Message-ID: <20240804174414.18171-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
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

