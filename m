Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A734DCC8
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946797; cv=none; b=jblLjfYfe0fBWIIuWOSWggRhsySxr0somniTRav5lrpY74Rlg8clndNAs1KSlmPWgtT5TbEsN2iXDU1njFNRiPZljoJnjQnYIi7y8x3R12TgnmI/tfOI7a1ILj9SfqGbEIyezTczA+M5krOCthjaRelJUWQGHtQnSgaMlMy/KEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946797; c=relaxed/simple;
	bh=cxhSMtFnsE52QjMezqtF/D1wAEUlllDGEc4sSAeOF48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Csms8GVfgHa9keGjLR3GzJho+NjvlIarL9/I2yJ58+mhuyfayx+aCZbywN24Cy49L7PF2wDcdMkvZ/CFRx6IydDS1pfsw9HyWzb4tkL7iSJ337suWsDvWHXe/8yakQB8QI/7TCE5fQzM0WmzRhLY4J1NJktflpgc+q8xS9xjw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C74nikIf; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C74nikIf"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ad21f437eeso10843835ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946795; x=1774551595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpun292QO0p2AqLgzYUrlOVsADRTpPXqRTdqpP531bs=;
        b=XST+2JEI8juJyqbUCheDnZHFFw4IaASodlLQzs2x1j5HIXE2yCj5eOK/Bm0xhDY5SO
         pQKja2v5vNiEpW/QhVBq7FW1gYknyHpexGPq+dUnt/I+8ts6im5ZUBvPwF8MntvOGpEG
         3lFVpAZn1U7NTpyI4px8tVdKYiAMWIilulG+Tfr47K97R/mjSTvGwq9weCtcKpHMWXLf
         EaqnS9aGq2U9a1luCqa4O9u4WfFTOAhr6NCj+EiA9o3YExIbzLBrKs+kANJC0DeoV+om
         JGNV6dBQMaQ5fk/mJAINfrgexA46oHNauO711ekvYOvsaby010JKNKr2tGTguOaJ6lu/
         xnPA==
X-Forwarded-Encrypted: i=1; AJvYcCUIooh2yPSHHo+iqP9YPVIaWG+bLifoPjmBy9OLc+YoWoN96Aad+yL/ONvmdOaoBBBG1U5JryoQspY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaigNLanRg5TF5lgF6GoaVAm/S0+xIUeJo6clS/GSKwroN59XA
	3i8jNJtnPOHFoE4Sxnqldv2njgiyWcnWZyeDxbSJ1CiFUYwDTZWSVyorVSzgaJY5lIcVJ5lVG3i
	ehj2j+XBqTkCVXqAD2NDR3QmTuDCGqsuCoylVFo5o2bwdmEQTMR8FS3XjxgnjklnZdrXVmI6B0T
	i6KPl7B13654+o6FSNDBDck2GASoNs47coVafcgbVBjSWhmibKKNgcQk6poi9JPo+DSAVRNtmJb
	LsMALwcfnMu
X-Gm-Gg: ATEYQzyiRjIh3TMo/RDVcSKPxC9f472WcJ3VgBDodyTn7QRlm53WhMdmoB1jwu3baQp
	mAVwX6Nn1MCz3sMDAewQFSICLow5HAEtstQeiFwLk9fiOTHv72cobH/DnMpEIICCdROhtrFjIGl
	r5Eq2t4xI/Q8bDZ4lBNapuGbiHOBvU955r9xD/Uzw6KpECqZFS08BZXdwvN2qIYYdHRhfX3rEAp
	qDOyUl0KM3TsUvgRiIg9EacSOd4H8V+ZiH2ovrj7mJ9gnv3Zv9SZ/wlUR1mDvanulAIssdXuF4y
	ct18B0Hk19PqmPAFkdQDug+ZxC5M9zhfE8tGvTX61LEGQKT+Uj/0DvRiXEm8QHzNEC4otkWk/wb
	2hgMdxpRfazf0x9yIWvg3giMabaVghO3g7rKUcEFKyDKDt84RNr/jpcQRMsCeRrezqVY/fMzWmE
	yhQ/Ql9sArsNYs3J8Xf+nkhK/U1onc9zJwvKwlb01CEUA0WmY+rC6csVjQ
X-Received: by 2002:a17:902:f683:b0:2b0:5722:f89 with SMTP id d9443c01a7336-2b077143206mr38879515ad.7.1773946794813;
        Thu, 19 Mar 2026 11:59:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b06e46e6dasm6976075ad.13.2026.03.19.11.59.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 11:59:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdd327d970so715894eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773946793; x=1774551593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpun292QO0p2AqLgzYUrlOVsADRTpPXqRTdqpP531bs=;
        b=C74nikIfCeWgULdqFY8BGmusXfCkZg+Hom+phuQBvJPj4gsgw9ep/se9rPRQdkdHJH
         9W54QfXAeCsNmv6LwINgWVGgUio2JEUtp2g53s3MZ8VvJzQOwDFKT4yEdQJg2rMaZ1Bu
         HR6OmoQ3wCDZzv1zuVIh3VUtL3JSFaYBZ5Xp8=
X-Forwarded-Encrypted: i=1; AJvYcCWLYkjE4WqaPeViVfCmvPsi6Ps0r3hJzgsPZ/lopXrtd8jBZzwcXWaAPufe2S6bcVYz6+OFr8c+gPE=@vger.kernel.org
X-Received: by 2002:a05:7301:fa0a:b0:2c0:da13:8c45 with SMTP id 5a478bee46e88-2c10974ccabmr192223eec.7.1773946792740;
        Thu, 19 Mar 2026 11:59:52 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0a:b0:2c0:da13:8c45 with SMTP id 5a478bee46e88-2c10974ccabmr192202eec.7.1773946791925;
        Thu, 19 Mar 2026 11:59:51 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm9607220eec.14.2026.03.19.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:59:51 -0700 (PDT)
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
Subject: [PATCH v3 2/4] mmc: sdhci: Implement panic-context write support
Date: Thu, 19 Mar 2026 14:57:03 -0400
Message-Id: <20260319185705.1516950-3-kamal.dasu@broadcom.com>
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

Implement the panic-context host operations for SDHCI controllers:

  sdhci_panic_prepare(): Reset the controller, drain any pending
  requests by polling Present State, and clear interrupt status to
  start from a known-good state.

  sdhci_panic_poll_completion(): Poll for command and data completion
  using register reads instead of waiting for interrupts.

  sdhci_panic_complete(): Clear interrupt status and restore the
  host to normal operation after panic I/O.

Make sdhci_send_command_retry() panic-safe by using mdelay() instead
of usleep_range() when oops_in_progress is set, and suppress WARN
output during panic.

Add oops_in_progress guards to sdhci_timeout_timer() and
sdhci_timeout_data_timer() to prevent spurious timeout handling
during panic writes.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci.c | 164 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   6 ++
 2 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af7..311ab361ee32 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -1765,17 +1766,22 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
 
 	while (!sdhci_send_command(host, cmd)) {
 		if (!timeout--) {
-			pr_err("%s: Controller never released inhibit bit(s).\n",
-			       mmc_hostname(host->mmc));
+			if (!oops_in_progress) {
+				pr_err("%s: Controller never released inhibit bit(s).\n",
+				       mmc_hostname(host->mmc));
+				sdhci_dumpregs(host);
+			}
 			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
-			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			return false;
 		}
 
 		spin_unlock_irqrestore(&host->lock, flags);
 
-		usleep_range(1000, 1250);
+		if (unlikely(oops_in_progress))
+			mdelay(1);
+		else
+			usleep_range(1000, 1250);
 
 		present = host->mmc->ops->get_cd(host->mmc);
 
@@ -3076,6 +3082,147 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/*
+ * Panic-context operations for pstore backends.
+ * These run with interrupts disabled and other CPUs stopped.
+ */
+
+#define SDHCI_PANIC_POLL_ITERATIONS	2000
+#define SDHCI_PANIC_POLL_DELAY_US	500
+#define SDHCI_PANIC_MIN_POLL_COUNT	300
+#define SDHCI_PANIC_RESET_TIMEOUT_US	100000
+#define SDHCI_PANIC_DRAIN_TIMEOUT_US	100000
+
+/**
+ * sdhci_panic_prepare - Prepare SDHCI controller for panic-context I/O
+ *
+ * Called during kernel panic. Drains any in-flight request, resets the
+ * CMD and DATA lines, then clears software state under spinlock.
+ * The drain + reset ensures no stopped CPU is still inside sdhci_irq
+ * holding host->lock by the time we take it.
+ */
+int sdhci_panic_prepare(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u32 present;
+	u8 val;
+	int ret;
+
+	/*
+	 * If the controller has a request in flight, give it a short
+	 * bounded time to finish. The CMD/DATA reset below will
+	 * force-abort anything that doesn't complete in time.
+	 */
+	present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	if (present & (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
+		readl_poll_timeout_atomic(host->ioaddr + SDHCI_PRESENT_STATE,
+					  present,
+					  !(present & (SDHCI_CMD_INHIBIT |
+						       SDHCI_DATA_INHIBIT)),
+					  10, SDHCI_PANIC_DRAIN_TIMEOUT_US);
+	}
+
+	sdhci_writeb(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA,
+		     SDHCI_SOFTWARE_RESET);
+
+	ret = readb_poll_timeout_atomic(host->ioaddr + SDHCI_SOFTWARE_RESET,
+					val, !(val & (SDHCI_RESET_CMD | SDHCI_RESET_DATA)),
+					10, SDHCI_PANIC_RESET_TIMEOUT_US);
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->cmd = NULL;
+	host->data = NULL;
+	host->data_cmd = NULL;
+	host->mrqs_done[0] = NULL;
+	host->mrqs_done[1] = NULL;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops && host->ops->panic_prepare)
+		host->ops->panic_prepare(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_panic_prepare);
+
+/**
+ * sdhci_panic_poll_completion - Poll SDHCI registers for request completion
+ *
+ * Checks interrupt status and present state registers to determine if a
+ * request has completed. Used during panic when interrupts are disabled.
+ */
+bool sdhci_panic_poll_completion(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned int poll_count;
+	u32 int_status, present;
+
+	for (poll_count = 0; poll_count < SDHCI_PANIC_POLL_ITERATIONS;
+	     poll_count++) {
+		cpu_relax();
+		udelay(SDHCI_PANIC_POLL_DELAY_US);
+
+		int_status = sdhci_readl(host, SDHCI_INT_STATUS);
+
+		if (int_status & SDHCI_INT_ERROR) {
+			if (mrq->cmd)
+				mrq->cmd->error = -EIO;
+			if (mrq->data)
+				mrq->data->error = -EIO;
+			sdhci_writel(host, int_status, SDHCI_INT_STATUS);
+			return true;
+		}
+
+		if (int_status & SDHCI_INT_RESPONSE)
+			sdhci_writel(host, SDHCI_INT_RESPONSE,
+				     SDHCI_INT_STATUS);
+
+		if (int_status & SDHCI_INT_DATA_END)
+			sdhci_writel(host, SDHCI_INT_DATA_END,
+				     SDHCI_INT_STATUS);
+
+		/*
+		 * Use the same completion heuristic as the working v5
+		 * implementation: after a minimum number of poll
+		 * iterations, treat the request as complete when the
+		 * DATA_INHIBIT bit clears (controller is idle).
+		 */
+		if (poll_count >= SDHCI_PANIC_MIN_POLL_COUNT) {
+			present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+			if (!(present & SDHCI_DATA_INHIBIT))
+				return true;
+		}
+	}
+
+	if (mrq->cmd)
+		mrq->cmd->error = -ETIMEDOUT;
+	if (mrq->data)
+		mrq->data->error = -ETIMEDOUT;
+	return false;
+}
+EXPORT_SYMBOL_GPL(sdhci_panic_poll_completion);
+
+/**
+ * sdhci_panic_complete - Clean up SDHCI state after a panic-context request
+ *
+ * Clears host software state under spinlock so the next panic request
+ * starts clean.
+ */
+void sdhci_panic_complete(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->cmd = NULL;
+	host->data = NULL;
+	host->data_cmd = NULL;
+	host->mrqs_done[0] = NULL;
+	host->mrqs_done[1] = NULL;
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_panic_complete);
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -3091,6 +3238,9 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.panic_prepare			= sdhci_panic_prepare,
+	.panic_poll_completion		= sdhci_panic_poll_completion,
+	.panic_complete			= sdhci_panic_complete,
 };
 
 /*****************************************************************************\
@@ -3242,6 +3392,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
 
 	host = timer_container_of(host, t, timer);
 
+	if (oops_in_progress)
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
@@ -3264,6 +3417,9 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 	host = timer_container_of(host, t, data_timer);
 
+	if (oops_in_progress)
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->data || host->data_cmd ||
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b6a571d866fa..396eca56439f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void	(*panic_prepare)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -906,6 +907,11 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+int sdhci_panic_prepare(struct mmc_host *mmc);
+bool sdhci_panic_poll_completion(struct mmc_host *mmc,
+				 struct mmc_request *mrq);
+void sdhci_panic_complete(struct mmc_host *mmc, struct mmc_request *mrq);
+
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 #define SDHCI_DBG_ANYWAY 0
-- 
2.34.1

