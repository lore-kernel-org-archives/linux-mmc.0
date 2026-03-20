Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94179352C58
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038832; cv=none; b=gmyfWPQ7ua5d7WOBi0WJFJpZsDDvXWw84u7ddiUNB+5y/7KCuI9OU7nvzaZIVHi5rtlKm7L8dNxmpO3pUGVu9jFiky5qPHwSw5DhaInnBY/o/K0hXBflzlx87Xn30OAyadfERyT43wX7o/38GK5wqyMOwxRYfpU6Lb66KeqLnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038832; c=relaxed/simple;
	bh=7AmnG/UUYqW9PbgLMpQCGJh+iAZg56GN9U6BhFeGBjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDym+MYbQNkD1gbBnHVIaO0VVtijDPoMazV5F0iyaRgEZVjz4IKxokp3sww9vJJOUZhgAtVSPOklrIQzUjRqwB+ETM8u4PLU3YIRNROOz+VLmJ7bL495TLa4bPCLboPP8BDI0wdbwU3/7gsZutoaiAAgPMFP9ZqNcleQgQhAqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hqXTuOGA; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hqXTuOGA"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79495b1aaa7so20322107b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774038829; x=1774643629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eHxZs/jSCBES4akkCBqfFi+qs+gICn2xClTm9J1Alg=;
        b=YwJUQULY0MB8WOu+dPcC6Fbqb7KegeK/Xx7Wb2NQSXQuzi+TvHszRt3hjv7g8CVoBD
         QHW4EP2BA9hWOA1jLxFijBA/4r508GzRetMMWp4+mAR2rFl3lgGBG7bRCLvn+SQt4Hk6
         rAaim87aZY6da5OdE4qADk33zVrcWOO/9ap9xeqRpKidBDgrKL08qmyML72eRX0JovwK
         WyPXzvBVpLIToIEvBJaZSZ8VZrV4KsfZxmyPn55ZVE/hf13lUCcjFf1ZiZVdjg73xs/L
         fQaR9AvBfSg7P+2nRDAxB/Ymj2M7JoJoMB+0dhosSxKhaw2F5leQ4sQIJYEUgSjJHEcH
         3wtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW6/gNRdL4Xh1ziziCGRY0dnwbk+6eIRfSzKX6y/C6sz7hP2OKv/pAIx3D6p4wMX4fr5wIcwe7Bvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNhDOlZFGp+by9K5dDcY5dS6H9TTfZqSM3A7HqDX5+R+rJjt4
	dCCUvCMrKmT1FLU9RtiMtzzR2zjKKkqLzPfxgvvDgqWBn36HhaTG+VX4dbLQjwEdvMWwWa+sSgc
	6lHHlg++4q/sFsVQ+BGfYVVDnmgty3yDa6wXf/1hzDAoJO8dO3xyLzbR0nsdUA3ZPUBGZBDms4q
	Rke3DkfHNTuFN5J9KgyqEQGKEkVj+peSxsweXGRpYNaA/wjzYmHXOll8Hrlhlk7ycWazWLckbC0
	+PWJzJX0/Mc
X-Gm-Gg: ATEYQzydiX6nSwTbgI6pjCV3MU3gepZuHFdpBAlpjb6OGDb2AhWAk96izAOJWRhWzhj
	x/ak9ZzukNsgO//JYCo6hPtoSnLM9+vUpQ1auX3wjS8NFPafeYoXJxDJVHjfuITYq6/+1EMcme2
	50T4E/1r4unF5fy3fBMGREZFaX8vuWowBMMaBVBDo/DUJNfg3xU9HvGobZjuHhDenA3Wl8LbVAL
	M71vtddK/yoknRXTnYEYy6O3pdCv9Yn02QAw2NY+mfdHcSJYcMlaUHv3ZKeZgFxc1wXUBqP3FKQ
	aLUEO4D7fkuZuV+JXN5n+n+FpIQqS8J8Ra93IU1g43iVK95RXICgrtCMsJ9RpFMATeCRR975F3/
	YqkCIC/zFhXIbLF7vP/S+58oNODuhp4zNOTvqZLqG/HbtHombxv4ShzfbiE0Sk50HHLUinCNJHj
	QxQyOUirLGmuFpg1FGOATANn4Gc5/oolUFFSe2Dm1aC/yXpgJMpVyPcUPi
X-Received: by 2002:a05:690c:c4e8:b0:79a:349e:9548 with SMTP id 00721157ae682-79a90aa06famr45536787b3.3.1774038829353;
        Fri, 20 Mar 2026 13:33:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a90229af2sm2980687b3.0.2026.03.20.13.33.49
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 13:33:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cfc1bc572cso1073124985a.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774038829; x=1774643629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eHxZs/jSCBES4akkCBqfFi+qs+gICn2xClTm9J1Alg=;
        b=hqXTuOGA7rqt5Ei2nx+SD7vqijxYQX4Bdw6b10D+7i55SfVVUlBMGTifvh2jyumqoi
         NP5LChHs6YnORmg9moB5dcLi/jGSqY4/RS9sNgbzgFErKddiiSZX4F8dFb2l2////+rA
         YqHOCPmL+quvlU04SSEArx48M0fVfp22mik/A=
X-Forwarded-Encrypted: i=1; AJvYcCUCxROc3mv+nuQ2YSFTbv7QblH823PFRPfnkamiuAWamjEX7lxbd5q+dOlBGhGVI3w6bo+4rv6bZTA=@vger.kernel.org
X-Received: by 2002:a05:620a:4487:b0:8cd:97de:bb52 with SMTP id af79cd13be357-8cfc7e71174mr640560285a.22.1774038828663;
        Fri, 20 Mar 2026 13:33:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4487:b0:8cd:97de:bb52 with SMTP id af79cd13be357-8cfc7e71174mr640556185a.22.1774038828133;
        Fri, 20 Mar 2026 13:33:48 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8fb9c10sm280699985a.19.2026.03.20.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 13:33:47 -0700 (PDT)
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
Subject: [PATCH v4 3/4] mmc: block: Add helper to look up mmc_card by device name
Date: Fri, 20 Mar 2026 16:32:48 -0400
Message-Id: <20260320203249.1965044-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320203249.1965044-1-kamal.dasu@broadcom.com>
References: <20260320203249.1965044-1-kamal.dasu@broadcom.com>
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

