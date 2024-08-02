Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39C1DE85D;
	Fri,  2 Aug 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594253; cv=none; b=Kj04vV1348jU2bQLuGQJgBUg9Z9+VlMKy1YBpJD7Q5TyEksiMel/gXvQIPx4QtZktjPoMAAwMTLoD9C0oINVL5x2O2tS0N3elBFZFyBqhPoG6Wl39+P4OOgSofD+9sBrE8sK3a2uHuiwschQczD2ZuLbvd9tn+worum4RaW9rMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594253; c=relaxed/simple;
	bh=WZHXkW7zoPYtZs6BTqh7DRH1nRkb5Pj/yyqdIVPXErE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEHfrNwVWNzFDgua2c7GvGSTXYHGX+RbgXqa1RY7tVmKfCk+PiOyJh2yrkbZzxxCS6xaLW6vARPX3rayxz09Mair/UPAd8JeCH5b3MHvsYSJnnIS40J2F2lP9Vrc7VnXwGsxAZfjaQZT+EvROitxFiKVUMp7M7GOvRs8cFvqOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDDdepS3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDDdepS3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso6898092b3a.0;
        Fri, 02 Aug 2024 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594251; x=1723199051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glGjjnDZpBOlWcnUyrZ3EpoJKaEc4YTHd7YbkBIMlxk=;
        b=BDDdepS3XNaFSlt34tMU2OYwCG6JzbaUCy807mdmxFW8X50u19+Gwf4C0ME2UvbUQ7
         yvhRxU0SJJtMa82dNXKqVwdo9wEXP3GQERKp3BEFYXgxaFKa+xVi9Er9RSu+8+ILA1Sq
         maRr1ef+nC3Zi0gONygxE/BqRcrYfIm/rQqq7z+nWNCMdq++loXkcp1F/4xBs57SmYnG
         MHIMQYVBbxlK6iwmBfXlBgA0GwpnxhK3yxD0H4RQxWEbThma0Zq4isdOA8StE/nPg0jZ
         MzUDSOyKVcZLgoeLiX0xr1VIVtveiNHhiaor37Grq1zQ95HcZeP/sYZ8xG/mJ0DKdvYg
         5roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594251; x=1723199051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glGjjnDZpBOlWcnUyrZ3EpoJKaEc4YTHd7YbkBIMlxk=;
        b=mAXZp3DOuFbRLh7t9TTg/jWVj6n5M3Ssi3250p4SB56XksabmN3xgcUZSJJHfxDgoc
         cA96ESFgng105I5kOBHUfCfnDRDpOgtbScVGl5jIkjR38TKTxX2J2ig/E8XhRcetsldv
         rF/qp3sVrb+20m5xKBcRX3RybGT9yoKYY/RNaDgoAw7xr9tWd65jlHL7uE0v/hYjt9Yt
         z19N6Mg1dPEVDP6UclZjPy4nYX8mhndFURbV5d11UuZbxunEbm62cr4XbUMQlJ8kDeFy
         zasXUoQWGex8o2EZ3D5j+OtupHiMr2laebiJHENY2pDeKzH07ZEgx+1Z/uh6MJVzl420
         EO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEMZMvZeIPL9s071KIXyMzoQIQM80VqNW1QVOSkx74sFMZM9rhhDZQORr54+ZMJV3/FZjFlKQZCjIYIFsNlPlFFiIuN0w/UU0jQiR1
X-Gm-Message-State: AOJu0YwymwNslKbYQTbY7Y83tORYOcxpQNqbPkPVH24GkZMW7sSyaA+V
	QrQFXwz/PNpfi6udGMhZpHT99TIF1+IlSkdMponouNlx35lF4hmF
X-Google-Smtp-Source: AGHT+IFLwyn1iATlqO+4EPglLa7KzZnzbopmzgpN+J76O2GipFsnfkxnLhQ0LdHMwa9dMjeyo+uUvw==
X-Received: by 2002:a05:6a00:1887:b0:70c:f1fa:d7a3 with SMTP id d2e1a72fcca58-7106cfab41bmr3409963b3a.12.1722594250572;
        Fri, 02 Aug 2024 03:24:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:24:10 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V18 18/22] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date: Fri,  2 Aug 2024 18:22:25 +0800
Message-Id: <20240802102229.10204-19-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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
index c9bd438e9c26..864e3c08d83f 100644
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
index 442a89234b54..f4a7733a8ad2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4098,6 +4098,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->complete_work_fn = sdhci_complete_work;
+	host->thread_irq_fn    = sdhci_thread_irq;
+
 	return host;
 }
 
@@ -4862,7 +4865,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (!host->complete_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&host->complete_work, sdhci_complete_work);
+	INIT_WORK(&host->complete_work, host->complete_work_fn);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4871,7 +4874,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 941723cea698..c5e987dce927 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -625,6 +625,9 @@ struct sdhci_host {
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

