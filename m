Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE485653;
	Wed, 22 May 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376231; cv=none; b=DQESNXoZYJG8lif0mGZE87N/0qOO7as5DpCyYL0y3/pEu9OHpxhJ0Regd52x4UzgF9vQPrNlw1ARAVRTHJQZj/usW2R1k09JMgwuFgkS6kvSpPXAd4PAvv6PDqr6LKSLt43os2Yk3qtxOaF821M+xovLvdNdkCXnQizxbiqyCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376231; c=relaxed/simple;
	bh=WGKNS+M4uvmyVADO6kV2Rz8dgUfAoyZ3Rw9SMkikxmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPhHUU0CaVyWv1uLx6g1MELJG9msdg6/pvyzzUxo3XlyOokwqEwJBBd3sJ4Ns+aSNWg9hlW1BZ89OKadFa/Ft2TNtwrIhhxj31j+U8vKz07acw4gLWnzK4+sloteJ5hKQwwmh0zI6t/Yptgl1iqsIvGp0a6LlXn7coytKeuJ7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkiN9lqZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkiN9lqZ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4472561f1so1400833b3a.0;
        Wed, 22 May 2024 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376229; x=1716981029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM6jWsdGxNEldTlDx9TzGSmAZ/JbjkpexPLr2ExNSek=;
        b=SkiN9lqZOVsV7dUhRxM+A6ToNEdOcmdlMr/tOT8ARl+q4BqfsavTxpZaUKLlt0XniC
         1R0h3cULVNEtkhyZa7nrdb01lIaSekRF0okTqrFWl3+B9XPusbEGBc7LWAkLCJ8tpfU4
         jRvRor6nrZn/sGmCzxjzBt7rOgUFSTLk+Gpzpdw62qWVdwtYDBTdPOz13k+kSyFOtTJR
         WDOkDgYHupfBuovKZKeZIYcLonXhwWCv8xGtkfvsK6pAWxWQ2hocSNao0s7bvSJRHp17
         tozEjmZ2rRd3DSI8ac8rSoCzyIgePA1d2aiTfvB86REBqrvzvmMgY7O59OXMauLZ3UkF
         caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376229; x=1716981029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM6jWsdGxNEldTlDx9TzGSmAZ/JbjkpexPLr2ExNSek=;
        b=aTKcqixVBPfeO1s0B65h0MJBuqDu1FU3OPRs8eKByePzBpw1Cyg0pJwBG+iqZ2ReP5
         mgklKcsYsNvbTPkVHNIp1YkVDPTC0x+hntpMoGafUkT+74VK/oLBvaVzRS+hZTyG6eB8
         BxwEFqpdYAbfw8PuM2NcMHGhyRASmYba/KRmD6tTv/6gs/0ECx66yv7h8m9vUmg8Mc0N
         +RjEffrAIndZEG9kmvk/ECtuCTIENm9ttB3ldKSRwcSzrsz9giAg627B61OXyR3azDLE
         izETpTU8LTtZnoBKdgZAZq5bV9RutB1d9m8JgCa1ENRY31iKX7rEuVfjd1cqmgZPJgfY
         LJyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBfFzQzkA43uQRMFYCgZOryhBFrlr9oTl8eCkEA5ZnWobJWNac8kCUpzRU8cDUnHsPykQqSWMTLfhgi/85jIjkZmDDO6fRFUDPeWfZ
X-Gm-Message-State: AOJu0YypqvqkYjvvF0YiBk2XmvcHnMfEPgdjZ8EMMCrVPtXRxMQOkUR9
	Bliq4aaXnqb+d0bLazGUmhoI/QY6UWWiA9ALQDXXNYbqzHdlZkYr
X-Google-Smtp-Source: AGHT+IHtWNEMB5g8mQ+p12F1MJ2eOtxBsIifB0RgrboAVOt/hoDIJVSSHAOsHE8YFA0uhkW6jpUtLg==
X-Received: by 2002:a05:6a00:4b49:b0:6ea:f351:1df9 with SMTP id d2e1a72fcca58-6f6d6170bd5mr2150683b3a.23.1716376228870;
        Wed, 22 May 2024 04:10:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:28 -0700 (PDT)
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
Subject: [PATCH V16 19/23] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date: Wed, 22 May 2024 19:09:05 +0800
Message-Id: <20240522110909.10060-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
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
index 28a25cd09753..30a8f6b7d275 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -1162,6 +1163,103 @@ static void __exit sdhci_uhs2_mod_exit(void)
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
index beef08db0a16..42f34ca75275 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -183,5 +183,7 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f2157a26020..ed55aab24f92 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4112,6 +4112,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->complete_work_fn = sdhci_complete_work;
+	host->thread_irq_fn    = sdhci_thread_irq;
+
 	return host;
 }
 
@@ -4861,7 +4864,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (!host->complete_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&host->complete_work, sdhci_complete_work);
+	INIT_WORK(&host->complete_work, host->complete_work_fn);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4870,7 +4873,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index db412c7b132c..03148c7ea614 100644
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

