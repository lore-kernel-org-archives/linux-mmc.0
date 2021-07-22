Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D7C636C8
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0958261222
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhGVDWN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhGVDWB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4AC061575;
        Wed, 21 Jul 2021 21:02:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so3687884pjo.3;
        Wed, 21 Jul 2021 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nmb7MQUj4yN2N+TKnPZpClMZdUK4ahExo7YxzodDXVQ=;
        b=eyD3kr1LZwlWLV/a6t2lr7RU2FUMzSy9+33qqWhUL+fJyVmrNIpxX7QtPRQN/9hC8M
         5wOuXQrYehiOqyTh5+v6NrwelMfzQ73ne/G/qXcrTsSJ/x7DnB/PS7qLfanZ3Tt4wnMF
         9biaMI1YF82FZpNpu50+c9b+Z+fJa0oqmxnIGLjw7ccLCvTI7CpwXBh4iSUy+IzSe1tb
         84NZ9jmfm90w1L2eVPsns1AWX+ILv1IuDQlSuI2y4FhLziT3bJ1XydZC2X76ccUbbO6f
         UrSbHvjnHd/wuN1dlsnglPuNqdTuceuCoOJHMLiBgDOIAcVArhmVirkcLR2F2uaxAnyW
         7zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmb7MQUj4yN2N+TKnPZpClMZdUK4ahExo7YxzodDXVQ=;
        b=YjCsTAzvch17OKMUKRosIdzYAh4JG2k2yOmNhiEqxcLXVe617Sr0dIFEMPi8/MWQYd
         IrP9NrmF+N+Ke8rpSIeUvdbfYMAawAi2L0V3J9Xj+hub2rcswbqoa5o1vLdX7vL/q5zF
         NGvdsyaCs6e4M7wW77/hlCVFa9tlyjZy1jeHcY6dl/Dy6Gc7RLg6g/prj0vSu/RDBYMR
         DxmUhEyIzLxompCl0fqhlwovYSRgdrAF+hRWs4Gee5abukEgvbwAxhKMkw+GBQxoyA4N
         3PR5eKSIHxKLTvlVGeVmvr6QrjGdhAfBBtdkslDvy3t/SH+zDNNGZTBurA9wFnOUziSY
         nacw==
X-Gm-Message-State: AOAM531tmymNSho2wIcSO15MYZPu5+PjXPdG52DJ6D6i6xZFiCYHCJ6r
        4rl+hQdd4eH43hzS63Pgrg4=
X-Google-Smtp-Source: ABdhPJwnR70DRL9bJQhoBUPwEJ9jowGhD9oq7L4j5Z1uunpu2gGX+qzFW3B93iOmuhfLD/8WN7JG7A==
X-Received: by 2002:a63:5259:: with SMTP id s25mr33377975pgl.397.1626926553948;
        Wed, 21 Jul 2021 21:02:33 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:33 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 22/29] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date:   Thu, 22 Jul 2021 12:01:17 +0800
Message-Id: <20210722040124.7573-22-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 198 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   2 +
 drivers/mmc/host/sdhci.c      |  24 +++--
 drivers/mmc/host/sdhci.h      |  10 ++
 4 files changed, 226 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index d50134e912f3..5d3362ea138f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mmc/mmc.h>
+#include <linux/regulator/consumer.h>

 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -406,6 +407,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 {
 }
 #else
+static inline int sdhci_led_register(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static inline void sdhci_led_unregister(struct sdhci_host *host)
+{
+}
+
 static inline void sdhci_led_activate(struct sdhci_host *host)
 {
 	__sdhci_led_activate(host);
@@ -1298,6 +1308,194 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	if (host->version < SDHCI_SPEC_400)
+		return 0;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps |= MMC_CAP_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_SUPPORT_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
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
+	if (caps1 & SDHCI_SUPPORT_VDD2_180) {
+		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
+		/*
+		 * UHS2 doesn't require this. Only UHS-I bus needs to set
+		 * max current.
+		 */
+		mmc->max_current_180_vdd2 = (max_current_caps2 &
+					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
+					SDHCI_MAX_CURRENT_MULTIPLIER;
+	} else {
+		mmc->caps &= ~MMC_CAP_UHS2;
+	}
+
+	return 0;
+}
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
+
+static int __sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	if ((mmc->caps2 & MMC_CAP2_CQE) &&
+	    (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
+		mmc->caps2 &= ~MMC_CAP2_CQE;
+		mmc->cqe_ops = NULL;
+	}
+
+	/* overwrite ops */
+	if (mmc->caps & MMC_CAP_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
+	if (!host->complete_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&host->complete_work, sdhci_uhs2_complete_work);
+
+	timer_setup(&host->timer, sdhci_timeout_timer, 0);
+	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
+
+	init_waitqueue_head(&host->buf_ready_int);
+
+	sdhci_init(host, 0);
+
+	ret = request_threaded_irq(host->irq, sdhci_irq,
+				   sdhci_uhs2_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
+	if (ret) {
+		pr_err("%s: Failed to request IRQ %d: %d\n",
+		       mmc_hostname(mmc), host->irq, ret);
+		goto unwq;
+	}
+
+	ret = sdhci_led_register(host);
+	if (ret) {
+		pr_err("%s: Failed to register LED device: %d\n",
+		       mmc_hostname(mmc), ret);
+		goto unirq;
+	}
+
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto unled;
+
+	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
+		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
+		(host->flags & SDHCI_USE_ADMA) ?
+		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
+		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
+
+	sdhci_enable_card_detection(host);
+
+	return 0;
+
+unled:
+	sdhci_led_unregister(host);
+unirq:
+	sdhci_do_reset(host, SDHCI_RESET_ALL);
+	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+	free_irq(host->irq, host);
+unwq:
+	destroy_workqueue(host->complete_wq);
+
+	return ret;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!(host->mmc) || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_SIG_EN);
+	host->mmc->flags &= ~MMC_UHS2_INITIALIZED;
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
+	if (host->version >= SDHCI_SPEC_400) {
+               ret = __sdhci_uhs2_add_host_v4(host, host->caps1);
+               if (ret)
+                       goto cleanup;
+	}
+
+	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		/* FIXME: Do we have to do some cleanup here? */
+		mmc->caps &= ~MMC_CAP_UHS2;
+
+	ret = __sdhci_uhs2_add_host(host);
+	if (ret)
+		goto cleanup2;
+
+	return 0;
+
+cleanup2:
+	/*
+	 * TODO: Is this a right cleanup?
+	 */
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+cleanup:
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
+	sdhci_uhs2_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index b74af641d00e..34e140f21284 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -218,5 +218,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);

 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4a2046c22319..5356cd5f4907 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -175,10 +175,11 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }

-static void sdhci_enable_card_detection(struct sdhci_host *host)
+void sdhci_enable_card_detection(struct sdhci_host *host)
 {
 	sdhci_set_card_detection(host, true);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_card_detection);

 static void sdhci_disable_card_detection(struct sdhci_host *host)
 {
@@ -236,7 +237,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);

-static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
+void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
@@ -257,6 +258,7 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 		host->preset_enabled = false;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_do_reset);

 static void sdhci_set_default_irqs(struct sdhci_host *host)
 {
@@ -320,7 +322,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }

-static void sdhci_init(struct sdhci_host *host, int soft)
+void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
@@ -345,6 +347,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_init);

 static void sdhci_reinit(struct sdhci_host *host)
 {
@@ -409,7 +412,7 @@ static void sdhci_led_control(struct led_classdev *led,
 	spin_unlock_irqrestore(&host->lock, flags);
 }

-static int sdhci_led_register(struct sdhci_host *host)
+int sdhci_led_register(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;

@@ -426,14 +429,16 @@ static int sdhci_led_register(struct sdhci_host *host)

 	return led_classdev_register(mmc_dev(mmc), &host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_register);

-static void sdhci_led_unregister(struct sdhci_host *host)
+void sdhci_led_unregister(struct sdhci_host *host)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_LED)
 		return;

 	led_classdev_unregister(&host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_unregister);

 static inline void sdhci_led_activate(struct sdhci_host *host)
 {
@@ -3249,7 +3254,7 @@ static void sdhci_complete_work(struct work_struct *work)
 		;
 }

-static void sdhci_timeout_timer(struct timer_list *t)
+void sdhci_timeout_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3269,8 +3274,9 @@ static void sdhci_timeout_timer(struct timer_list *t)

 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_timer);

-static void sdhci_timeout_data_timer(struct timer_list *t)
+void sdhci_timeout_data_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3300,6 +3306,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)

 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_data_timer);

 /*****************************************************************************\
  *                                                                           *
@@ -3543,7 +3550,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 		data->host_cookie == COOKIE_MAPPED);
 }

-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS] = {0};
 	irqreturn_t result = IRQ_NONE;
@@ -3683,6 +3690,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)

 	return result;
 }
+EXPORT_SYMBOL_GPL(sdhci_irq);

 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 74572b54ec47..b1d856664b58 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -832,8 +832,15 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 }

 bool sdhci_data_line_cmd(struct mmc_command *cmd);
+void sdhci_enable_card_detection(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+void sdhci_do_reset(struct sdhci_host *host, u8 mask);
+void sdhci_init(struct sdhci_host *host, int soft);
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+int sdhci_led_register(struct sdhci_host *host);
+void sdhci_led_unregister(struct sdhci_host *host);
+#endif
 void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
                      unsigned long timeout);
 void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
@@ -884,6 +891,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
 void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
 bool sdhci_request_done(struct sdhci_host *host);
+void sdhci_timeout_timer(struct timer_list *t);
+void sdhci_timeout_data_timer(struct timer_list *t);
+irqreturn_t sdhci_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);

--
2.32.0

