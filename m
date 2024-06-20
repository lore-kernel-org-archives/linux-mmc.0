Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4321ACE7D;
	Thu, 20 Jun 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880365; cv=none; b=N2b+2jYJ9bi8lLfrtdmGOG1k/wpy4rKuQmZhrH/O2lhVXQeqreCGqh3lzieEDAXI4ZxC0zPL/7SNWDawscv3udB8xfPEIxcFV470mcUmvhWuHC56tp9VUnX3DaMUnONwPIMWl4U+L2v1/EwhqeRPsiIv5F0QRvcsPZHxH+Hpt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880365; c=relaxed/simple;
	bh=xv9mS558lobU5BheXc9QSpOL1NwlyWiw/azi426xp+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ng3cT+bfqX9n7EPpYW8ClAzKQrEeXtlJddmeamjhLUgT2owexx4o+VpD5wLeVdCplsSXwE609hp0ub9gB+VaNfCARt1O1fV6YK59PKMAk6xG/h+c+q9N2y1JFteNmkxmtw8o56q1er8CD/qvdG8Jz4JuGxBiFRr6DQWlRRW4kKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF9+rSUu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF9+rSUu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f99fe4dc5aso6202605ad.0;
        Thu, 20 Jun 2024 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880363; x=1719485163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEegtx0tVLk7ZV57rKcPVeNnJHYICNHIhLc+W8rY9WM=;
        b=nF9+rSUuFBSAjwCciZllAlysln5y77Lgyxq9LzDLGcjPQeWjW+2K2Gl+LVcTHdRzrm
         mJQz8iuzB7ugI+4kTbLUBYYxdhInapBGmv7OD+z6vruEcqPpirep/waS8eRh3EybVB3q
         FG2rTu3UbsQzFr2kUfZJmqaBlET+ecZSU1HkhMv9Va6khmI4AOzp7lTBEZehBrGI7yuC
         LLP1/tyWqlZ2OIpF6BddZlyUNQvIxZwUihxDFlVQ5x3t5nGRK53oywqqyGxcEUE1GE8w
         1oGjWH+ocYFWJSTN+AruF1vLoCf0DADqYGMXOihU9Im9As0+Cf74nY9LAvSTbiM8CAww
         xgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880363; x=1719485163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEegtx0tVLk7ZV57rKcPVeNnJHYICNHIhLc+W8rY9WM=;
        b=Pozh2AhJ/tBk+mdz8Y+ZY6zGPD7ywzXHIor9EdtQ1hxhkRgBdLwDP/9aTcIUemIHKq
         9eMT4Kb5fA4u4feP/TavBg1pyfKHRkozkhdh/V27X7Tz55dkrgykeGVvvZ9jKloYHh5C
         +Vj29IsPCIzkBZ5L1Z3iRqOaT8pTv46zC/XqSHSuHLmhT+wuc3ufVJffvdkNCxLWrLYi
         zsIxaN7NJ1rYQwmMl34ttrFvdOArhwhNaEcDGp/nfAmDyK2ybZoZuKcomKpVVlGCobZP
         uCCJIPaIU8XvKV6n8DiAsIVHew93eL8vWCNCm9nYZe4/wlB2K7sUl2NeMCroGWWr964V
         2HDA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ07y9SXKrIoYA+zJ8JQgnSaspaloHlTbrxMbjDtcQoC9Qi31gvWI0zbkbhBTAGjY13WOHYICG4qe4Yrzl6TPy5afI2fIcobdjkZ/m
X-Gm-Message-State: AOJu0Yy/oczDveA7jC2WC776mT11SkRagOmRz87KJqSNMp1zprRELcyP
	dwSScKwguHdqjXwaToCXP6UbrHajSKTIWHZslfrB0rIyn7nHvL0iCZU8Hg==
X-Google-Smtp-Source: AGHT+IFsGWg8Tar1yfbVq2ZdYbv3TQr5/Rtu0lRAYEiCgN4L1VkJc17gOsmYWhwf7HSKFjIXBNhp1A==
X-Received: by 2002:a17:902:c404:b0:1f8:904a:d6f3 with SMTP id d9443c01a7336-1f9aa41202fmr57303395ad.40.1718880363374;
        Thu, 20 Jun 2024 03:46:03 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:46:02 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V17 18/22] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date: Thu, 20 Jun 2024 18:44:40 +0800
Message-Id: <20240620104444.5862-19-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   __sdhci_uhs2_remove_host().

Updates in V13:
 - Re-order function to avoid declaration.
 - Use vqmmc2 to stead vmmc2.

Updates in V11:
 - Remove unused ocr_avail_uhs2.

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[20/23].

Updates in V8:
 - Change return type to void for __sdhci_uhs2_add_host_v4().
 - Remove unused variables in __sdhci_uhs2_add_host_v4().

Updates in V7:
 - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
   in sdhci_uhs2_add_host().
 - Cancel export state of some functions.

Updates in V6:
 - Add complete_work_fn/thread_irq_fn variables in struct sdhci_host.
 - Use complete_work_fn/thread_irq_fn variables in
   sdhci_alloc_host() and sdhci_uhs2_add_host().
 - Use sdhci_uhs2_mode() to simplify code in __sdhci_uhs2_remove_host().

---

 drivers/mmc/host/sdhci-uhs2.c | 98 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 drivers/mmc/host/sdhci.c      |  7 ++-
 drivers/mmc/host/sdhci.h      |  3 ++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2ed00c8abe88..c6732187b70c 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -1166,6 +1167,103 @@ static void __exit sdhci_uhs2_mod_exit(void)
 }
 module_exit(sdhci_uhs2_mod_exit);
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps2 |= MMC_CAP2_SD_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_CAN_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vqmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vqmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr / 1000;  /* convert to mA */
+			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (!(caps1 & SDHCI_CAN_VDD2_180))
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!mmc_card_uhs2(host->mmc))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+}
+
+int sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_add_host_v4(host, host->caps1);
+
+	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+
+	/* overwrite ops */
+	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_work_fn = sdhci_uhs2_complete_work;
+	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
+
+	/* LED support not implemented for UHS2 */
+	host->quirks |= SDHCI_QUIRK_NO_LED;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+
+	sdhci_cleanup_host(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	__sdhci_uhs2_remove_host(host, dead);
+
+	sdhci_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
 MODULE_DESCRIPTION("MMC UHS-II Support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 077a2c7a6cb0..1f3155307fb2 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -184,5 +184,7 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7c9d475eacb7..55f0db0fc007 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4114,6 +4114,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->complete_work_fn = sdhci_complete_work;
+	host->thread_irq_fn    = sdhci_thread_irq;
+
 	return host;
 }
 
@@ -4863,7 +4866,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (!host->complete_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&host->complete_work, sdhci_complete_work);
+	INIT_WORK(&host->complete_work, host->complete_work_fn);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4872,7 +4875,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d3098d231122..5d600f41ac50 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -627,6 +627,9 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
 
+	void		(*complete_work_fn)(struct work_struct *work);
+	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
+
 #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
 	struct dma_chan *rx_chan;
 	struct dma_chan *tx_chan;
-- 
2.25.1

