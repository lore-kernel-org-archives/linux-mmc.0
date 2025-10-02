Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2522BD11
	for <linux-mmc@vger.kernel.org>; Thu,  2 Oct 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367059; cv=none; b=WdZbjbpjfjni9tt08cD3yis1z40lBesgV1rFOuWpe+5SQT8T/89kPtBsje8HHnGx1bPP72cdTk86RgsH9zoQ18qn2lmiPeHDnXG1vTtftLILYdKg+8y92jFLEhFbCqg+8BLxl73FS15XzN2cJqTBZoyPExFSgImAe81/L+rFsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367059; c=relaxed/simple;
	bh=Y505aKQKUnwUfjNG+Qp9UI4/UlFZuJIXU1Q3R7U1VQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nd0mpqKzRRpjruGl1NMgMKDsq+5jlE/C5E4eOLSKe6Gd0utmvnJT0q3rweY3qsTnc+DktEmpPxW0s4lnpaOnMd41slPC5vbj8NJuGCATQ6nWi+SkjQkkxFjamV2c8jGlNUeFUgUjpeaM0NSgiTIN14RmiEiCRRSCif0u7nIIe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUVAA4jQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUVAA4jQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so743763a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Oct 2025 18:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759367057; x=1759971857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHTDHANhx2I7dIzGsQLBn00mkeR2Scl9/Qsf768Yqmk=;
        b=XUVAA4jQxE2GzEGj1p+3rCXuCEWhnqL9FPU18AeYaCKDXhVqXewfXVrSXjPXnYGinv
         zrweugwmjPfeKpA0PHVipI0U9AYEtGRaUq8Dx+KIVIV+wFtxUBjtpKKEPIc0ZX2PybSF
         yev9WGg+MEwntDz8bhgtMKBeUnQeAlTr+Wq3H6vYPChvNZdz20IA9FrUAUVgMuU7sEv1
         X+RJJtuwAc2xSdN44aT9VA6byut8C3b0gQhvj3kTb+U67gqllF0MBVhr40CqCjEzsFAF
         F5r9Nxhdl7stVAloWvl0gDxQkLZpMDBEd+0/IhQQMeK4vCnjrGD3eYzNZxoRgZ92B/4H
         +gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367057; x=1759971857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHTDHANhx2I7dIzGsQLBn00mkeR2Scl9/Qsf768Yqmk=;
        b=cECCuSqCbr6HHEEtCVYenmKaUa1wfJqhr/S1J8kBOXoGIJ5b1Vc72bkxe47MBWTcNM
         ya7odlAgJxndVKXCEvQTZoztMVdAnm2UYbhTYRCxtKZEgCbAzHacZPimFq8t5CX1t+sr
         jNL4RxugajBQdk1YTgEuzFp28cQf9e6jtrzjRNqTabDk204NLUI0x5yBykO/MMeR0H5s
         H2MeHHLB5bW1q+Y3Fkz3s5NWfc/FC7JD7g33IGQfv+rEmlZ7Jg6fHMEjAGXO2mB6Q+yJ
         K5/53gPjaDwN1SDX6WSOWBbIPB+wcegWii39UutvG3i7yrae0Z4ciW5BMn9ySif9HDF0
         AxSg==
X-Forwarded-Encrypted: i=1; AJvYcCXcVwUXZmI23VRCFVKSDSiDnDti+Hh1hDIKGAsuHd39bVN6nXsRzBlc8uU6+YgwgXy68gV437H932M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy745ByHrtPXP4+uf2K6xMg+kX48j4E+5Sk7Zio8vYyJd6uLfJ/
	fKGzVOGh6Mq5nBS+jM4HIcCCf5DUUePJQNlfSt9mc8BxVaeECfSJTJB+
X-Gm-Gg: ASbGncsqk1HIxqgr3gaKPOweR9A8phlWs9NVLr/Nevm3yI2tWJQQmBPpa78sroFLhiG
	oSlJ//YoBjxw0kJQC55pH/GTvIj4A/nkyMO3WTbXdB+gnb4CvdVolfQMO29wKloDsPIdDz4qO+V
	N8CklMiBr1mpwajnZ11ySL6krwvbJThAhbjZr5FA2fUOBguxLLrKQYZSntZiq53CtQDpaai62iU
	/4T5bcEylxLPegbbiEYPYhArzKVyzcNdjqM6OrU0UWCAiTLkwh8uuv/Jj9F3sK0oeAeDwIzRVyL
	ySlCPKe0W1XTa2pIuGD0FcWjY2jh3rWHgagUyp5gay844tyqBPXLHlbkm/hKoHYfI4rohSK8wA7
	tGE0fp3hcNl8TCaob8+N2sZkOfb51aztS+Y+/ufrSUA++k0lU5IikxDXIhg==
X-Google-Smtp-Source: AGHT+IF3t1LeatYEk8zV1ykLzbl5xhmZAqb1p7kS4fD0Fq+BS96TmnxU8ltYTQ5Psy74eDVDoRHjJQ==
X-Received: by 2002:a17:90b:1b0b:b0:32e:a535:4872 with SMTP id 98e67ed59e1d1-339a6e281ebmr5626461a91.2.1759367057231;
        Wed, 01 Oct 2025 18:04:17 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:f637:ab:9082:d04])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-339b4f3ceedsm943113a91.18.2025.10.01.18.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:04:16 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] mmc: use octal file permissions instead of symbolic
Date: Wed,  1 Oct 2025 21:57:14 -0300
Message-Id: <20251002005714.6380-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated in Documentation/dev-tools/checkpatch.rst, octal file
permissions are preferred over symbolic constants because they are
easier to read and understand. Replace symbolic permissions with
their octal equivalents.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 drivers/mmc/core/block.c       |  6 +++---
 drivers/mmc/core/bus.h         |  2 +-
 drivers/mmc/core/mmc.c         |  4 ++--
 drivers/mmc/core/mmc_test.c    |  4 ++--
 drivers/mmc/core/sd.c          |  2 +-
 drivers/mmc/host/atmel-mci.c   | 10 +++++-----
 drivers/mmc/host/davinci_mmc.c |  6 +++---
 drivers/mmc/host/dw_mmc.c      | 10 +++++-----
 drivers/mmc/host/omap.c        |  4 ++--
 drivers/mmc/host/omap_hsmmc.c  |  4 ++--
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9cc47bf94804..78dc1a9ca2ef 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -387,10 +387,10 @@ static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
 	if (a == &dev_attr_ro_lock_until_next_power_on.attr &&
 	    (md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 	    md->queue.card->ext_csd.boot_ro_lockable) {
-		mode = S_IRUGO;
+		mode = 0444;
 		if (!(md->queue.card->ext_csd.boot_ro_lock &
 				EXT_CSD_BOOT_WP_B_PWR_WP_DIS))
-			mode |= S_IWUSR;
+			mode |= 0200;
 	}
 
 	mmc_blk_put(md);
@@ -3244,7 +3244,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 
 	if (mmc_card_mmc(card)) {
 		md->ext_csd_dentry =
-			debugfs_create_file("ext_csd", S_IRUSR, root, card,
+			debugfs_create_file("ext_csd", 0400, root, card,
 					    &mmc_dbg_ext_csd_fops);
 	}
 }
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index cfd0d02d3420..8b69624fa46e 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -20,7 +20,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
 	struct mmc_card *card = mmc_dev_to_card(dev);				\
 	return sysfs_emit(buf, fmt, args);					\
 }										\
-static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
+static DEVICE_ATTR(name, 0444, mmc_##name##_show, NULL)
 
 struct mmc_card *mmc_alloc_card(struct mmc_host *host,
 				const struct device_type *type);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5be9b42d5057..e4b7829469ea 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -830,7 +830,7 @@ static ssize_t mmc_fwrev_show(struct device *dev,
 				  card->ext_csd.fwrev);
 }
 
-static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
+static DEVICE_ATTR(fwrev, 0444, mmc_fwrev_show, NULL);
 
 static ssize_t mmc_dsr_show(struct device *dev,
 			    struct device_attribute *attr,
@@ -846,7 +846,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
 		return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
-static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
+static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
 
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 80e5d87a5e50..62b4983c1ef5 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3218,12 +3218,12 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
 
 	mutex_lock(&mmc_test_lock);
 
-	ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
+	ret = __mmc_test_register_dbgfs_file(card, "test", 0644,
 		&mmc_test_fops_test);
 	if (ret)
 		goto err;
 
-	ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
+	ret = __mmc_test_register_dbgfs_file(card, "testlist", 0444,
 		&mtf_testlist_fops);
 	if (ret)
 		goto err;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ec02067f03c5..5ed6bc47f1c4 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -744,7 +744,7 @@ static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "0x%x\n", 0x404);
 }
 
-static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
+static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
 
 MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
 MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 777342fb7657..d4a504f0aded 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -609,12 +609,12 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 	if (!root)
 		return;
 
-	debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
-	debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
-	debugfs_create_u32("state", S_IRUSR, root, &host->state);
-	debugfs_create_xul("pending_events", S_IRUSR, root,
+	debugfs_create_file("regs", 0400, root, host, &atmci_regs_fops);
+	debugfs_create_file("req", 0400, root, slot, &atmci_req_fops);
+	debugfs_create_u32("state", 0400, root, &host->state);
+	debugfs_create_xul("pending_events", 0400, root,
 			   &host->pending_events);
-	debugfs_create_xul("completed_events", S_IRUSR, root,
+	debugfs_create_xul("completed_events", 0400, root,
 			   &host->completed_events);
 }
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c691f1b60395..3174e7ac65b3 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -145,17 +145,17 @@
 #define MAX_NR_SG	16
 
 static unsigned rw_threshold = 32;
-module_param(rw_threshold, uint, S_IRUGO);
+module_param(rw_threshold, uint, 0444);
 MODULE_PARM_DESC(rw_threshold,
 		"Read/Write threshold. Default = 32");
 
 static unsigned poll_threshold = 128;
-module_param(poll_threshold, uint, S_IRUGO);
+module_param(poll_threshold, uint, 0444);
 MODULE_PARM_DESC(poll_threshold,
 		 "Polling transaction size threshold. Default = 128");
 
 static unsigned poll_loopcount = 32;
-module_param(poll_loopcount, uint, S_IRUGO);
+module_param(poll_loopcount, uint, 0444);
 MODULE_PARM_DESC(poll_loopcount,
 		 "Maximum polling loop count. Default = 32");
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..2380ab82812a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -175,12 +175,12 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 	if (!root)
 		return;
 
-	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
-	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
-	debugfs_create_u32("state", S_IRUSR, root, &host->state);
-	debugfs_create_xul("pending_events", S_IRUSR, root,
+	debugfs_create_file("regs", 0400, root, host, &dw_mci_regs_fops);
+	debugfs_create_file("req", 0400, root, slot, &dw_mci_req_fops);
+	debugfs_create_u32("state", 0400, root, &host->state);
+	debugfs_create_xul("pending_events", 0400, root,
 			   &host->pending_events);
-	debugfs_create_xul("completed_events", S_IRUSR, root,
+	debugfs_create_xul("completed_events", 0400, root,
 			   &host->completed_events);
 #ifdef CONFIG_FAULT_INJECTION
 	fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 52ac3f128a1c..5fc7d6d722b7 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -326,7 +326,7 @@ mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
 		       "closed");
 }
 
-static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
+static DEVICE_ATTR(cover_switch, 0444, mmc_omap_show_cover_switch, NULL);
 
 static ssize_t
 mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
@@ -338,7 +338,7 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%s\n", slot->pdata->name);
 }
 
-static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
+static DEVICE_ATTR(slot_name, 0444, mmc_omap_show_slot_name, NULL);
 
 static void
 mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index adc0d0b6ae37..5c679b795af1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -747,7 +747,7 @@ omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%s\n", mmc_pdata(host)->name);
 }
 
-static DEVICE_ATTR(slot_name, S_IRUGO, omap_hsmmc_show_slot_name, NULL);
+static DEVICE_ATTR(slot_name, 0444, omap_hsmmc_show_slot_name, NULL);
 
 /*
  * Configure the response type and send the cmd.
@@ -1673,7 +1673,7 @@ DEFINE_SHOW_ATTRIBUTE(mmc_regs);
 static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 {
 	if (mmc->debugfs_root)
-		debugfs_create_file("regs", S_IRUSR, mmc->debugfs_root,
+		debugfs_create_file("regs", 0400, mmc->debugfs_root,
 			mmc, &mmc_regs_fops);
 }
 
-- 
2.39.5

