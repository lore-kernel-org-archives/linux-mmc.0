Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AB40DFAA
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946800; cv=none; b=BJ7+kPV7DvuqbhYEeEfA6oq+kPb5Fd+xSSCiGMzOHChcyZn1QshsOnH80GrKXFOmXRgLJE+TgFOe6Sv0AphL37DMDjG+qr+8TQubTTKnkZ730ue6vyGNCJuhb76akgD5ZR1PBez7BgX2DqLa+Svokr5LW/LEgQcnLq/1i5fsgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946800; c=relaxed/simple;
	bh=7AmnG/UUYqW9PbgLMpQCGJh+iAZg56GN9U6BhFeGBjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWZOZh1wC8h7rujBxZAjrIHofxsaDTVLKBq+kcFCti15hBqRo2zdwqlHIyLH4K/jHn3uWuBDBI97l4yxnMxJAg41huBDzH2ypFOjEoR248jeG1rc+KajK/BepTu1p7tAptGI3sSPCsrd7eV6wW4EubQqvypkFQyX9ex1qs+qjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DuAwCXcI; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DuAwCXcI"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8297310ce0aso485761b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946798; x=1774551598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eHxZs/jSCBES4akkCBqfFi+qs+gICn2xClTm9J1Alg=;
        b=S/71JiKLu2GfjgA0lmq6AUuIOUeszVp2cI5H0p8YdlWdyKgRqYFnu1LktjPfxrXKjO
         AchzQ7EmpAK87CIMkKWcVVd7K43CrjUS3t7tSa5nSf6Sa5HRJuZPoN1brTBXjdG85i0B
         dxyfFDwlR0er8L/MTgwKEpF4ka4paELoslpBUcNQGllanuUrlzQ9h3zo8id5VkhvfiGK
         lPddJAeqztuAYAOZ5sG94aJKBvBrKf6/ToVkTqnnwQTlLLBcjlky8L/73C8l0t1nm3ak
         mgxPwNQ9BRkjOuEkKgm7+YTtFkB6ZOmGJXO7vkF0fxADQrukXZDAo/tp0UCjcDO9Nql2
         Pw0w==
X-Forwarded-Encrypted: i=1; AJvYcCXchnR7msNTHYmtiDsHI0t+DTAzZPrs5Jsih++CAwg2fWf7cmqdhC5IGCYNmhDzW14p+z/n/Z7+Jqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXa9ambcXGvpy4IIv2tSkjEywVFsE47MclpJc6b2Ab5EHmTG7
	aVE4UxXPVY+YM6Ner3+x8Eop9OfMSwRYC1kHYvvEOp1sZahob3JJfKYs6tjj1/pilFM46D9R67C
	QdOKvAdTqz4eRB0c7TvV+MvjeOk/WMT+17NkZcIEWuTVfbV0T5tldOeiH/ILnhIKSdipK6QS+sE
	uOHMtuFmnuPKEfPW4YNC9ntszCuWZuHhiaJ8Ot35PRE9VFjXsYHtQXMKjoyZIUSD8ekcXtcljXG
	bCShY+ZLj2W
X-Gm-Gg: ATEYQzy5KPBzujPcJaQH1ctxUoleQKk5c2bJx+njSWQW2MQznpX+uuBpprwb0du9sng
	dkuXVkI+pAl8rEcpElM2CzwkdHOiqcvsOcz/9nJhV+AQR6U9Sz2lyRN/Dt4Rk8MriBHuE6eZsWv
	NYfXqx0eYQkeVlIyUNByCYdi/FsEK3CZFGbG3p8ZyAE495guJAUKkCHlXz9a62WeXYg3b2EpxBX
	MM4BggB7WTxRe3sECIItdBdUyc+4B1p8wH+tCU74DNTtJ4Jkd3i2Z0USGg268emIz1vasp3UFrO
	sll79gTf4PemFHycjvBfdm2I3nyQPF9wOxKa2GZK7PG7mVcq/HohfniRooK+76sBRiw06FuMBYR
	EZmGFxdkJvPqCSteQ7Z3k8xcgNzIAcQde8cvJRsKD8rCItGDyFM1k8OLakp5738/aqqBpEdhAQa
	3NI3zi2fxHmmXCQ9J7guU1YIWS7nWeUdMgSl+D7vAp5Agj8KjWLmk/IUlm
X-Received: by 2002:a05:6a00:4191:b0:829:809e:8977 with SMTP id d2e1a72fcca58-82a8c346979mr286131b3a.49.1773946797968;
        Thu, 19 Mar 2026 11:59:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82a6bfc5a9fsm982233b3a.1.2026.03.19.11.59.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 11:59:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so23455021eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773946796; x=1774551596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eHxZs/jSCBES4akkCBqfFi+qs+gICn2xClTm9J1Alg=;
        b=DuAwCXcI6dN/8lLmN22NPMdicBkDgCb3cStVa8sCCf3r1RmsXfEkjWtFPXR+qwUYl1
         1bEcF2+fQkMB8jadTGfQmy9YPRN24oDsWruQep+KJH+4TJbh9c/Y5W+oRk/RHLsOkgAQ
         hholXVPyD04cksw+34IIb9a7cN+WmYTuS3LfQ=
X-Forwarded-Encrypted: i=1; AJvYcCVXcoK68HbuDzVG8x3KwMZgO76x68CdANq3bejCFPFB28eTQv82DNYcgxVE+kyjgYKTg5jKVb72baE=@vger.kernel.org
X-Received: by 2002:a05:693c:2c13:b0:2ba:7875:10c9 with SMTP id 5a478bee46e88-2c109760e2dmr255821eec.26.1773946796138;
        Thu, 19 Mar 2026 11:59:56 -0700 (PDT)
X-Received: by 2002:a05:693c:2c13:b0:2ba:7875:10c9 with SMTP id 5a478bee46e88-2c109760e2dmr255795eec.26.1773946795468;
        Thu, 19 Mar 2026 11:59:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm9607220eec.14.2026.03.19.11.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:59:55 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 3/4] mmc: block: Add helper to look up mmc_card by device name
Date: Thu, 19 Mar 2026 14:57:04 -0400
Message-Id: <20260319185705.1516950-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
References: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add mmc_blk_get_card_by_name() which resolves an MMC block device
name (e.g., "mmcblk1") to its associated struct mmc_card by opening
the block device and traversing gendisk to the mmc_blk_data private
data.

This is needed by the mmcpstore backend driver to find the card
associated with a given pstore_blk block device path. When mmcpstore
is built as a module, the eMMC card is already probed by the time the
module loads, so the helper can look it up directly.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/block.c | 54 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/block.h |  4 +++
 2 files changed, 58 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 05ee76cb0a08..91e3a778d5b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3441,6 +3441,60 @@ static void __exit mmc_blk_exit(void)
 	bus_unregister(&mmc_rpmb_bus_type);
 }
 
+/**
+ * mmc_blk_get_card_by_name - Get mmc_card from device name
+ * @device_name: Name of the MMC device (e.g., "mmcblk1")
+ *
+ * Resolves an MMC block device name to its associated struct mmc_card.
+ * Used by the mmcpstore backend driver (when built as a module) to find
+ * the card associated with a given pstore_blk block device path.
+ *
+ * Returns: mmc_card pointer on success, NULL on failure
+ */
+struct mmc_card *mmc_blk_get_card_by_name(const char *device_name)
+{
+	struct file *bdev_file;
+	struct block_device *bdev;
+	struct gendisk *disk;
+	struct mmc_blk_data *md;
+	struct mmc_card *card = NULL;
+	char dev_path[32];
+
+	if (!device_name)
+		return NULL;
+
+	snprintf(dev_path, sizeof(dev_path), "/dev/%s", device_name);
+
+	bdev_file = bdev_file_open_by_path(dev_path, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file)) {
+		pr_debug("mmc_blk: Failed to open block device %s: %ld\n",
+			 dev_path, PTR_ERR(bdev_file));
+		return NULL;
+	}
+	bdev = file_bdev(bdev_file);
+
+	disk = bdev->bd_disk;
+	if (!disk) {
+		pr_err("mmc_blk: No gendisk found for %s\n", dev_path);
+		goto out_put_bdev;
+	}
+
+	md = disk->private_data;
+	if (!md) {
+		pr_debug("mmc_blk: No mmc_blk_data found for %s\n", dev_path);
+		goto out_put_bdev;
+	}
+
+	card = md->queue.card;
+	if (!card)
+		pr_err("mmc_blk: No mmc_card found for %s\n", dev_path);
+
+out_put_bdev:
+	fput(bdev_file);
+	return card;
+}
+EXPORT_SYMBOL_GPL(mmc_blk_get_card_by_name);
+
 module_init(mmc_blk_init);
 module_exit(mmc_blk_exit);
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f41..08798c56dcce 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -17,4 +17,8 @@ struct work_struct;
 
 void mmc_blk_mq_complete_work(struct work_struct *work);
 
+/* MMC block device helper for mmcpstore */
+struct mmc_card;
+struct mmc_card *mmc_blk_get_card_by_name(const char *device_name);
+
 #endif
-- 
2.34.1

