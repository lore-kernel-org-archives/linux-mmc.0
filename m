Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCA2E06EA
	for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891101; cv=none; b=qmUcfMIFwRC825jNyGTMEGy4EUHBZueEwee/8ffzyE+HIDvXFHFJjGI17zCaBJhlNwL52KB6l0mD4busxIMIeuhqROp5krFGdKubs96ypWPGtNmv6Xs900eXBZGnEJ6jr/q/WNMBuYYg0raVLTHD2NdGgyvJGJ/vkc5DlIhE0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891101; c=relaxed/simple;
	bh=Pw1nom+hf3TcoV20hCuOOTw1KW67HhhOv/VDC2F+mf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ge0jZ1od5DqR0smXm4nqdxv5w9Q/qi0KriEany1WT1nxJ/U475a0g3HhDv2koxxRIN7J+GJcVAUTpYyQztUnJZ2Y9e2vWAA0hX8dp+utemk1dPCThXvAYVAUIKZP57RANXbsd/4LV3JHeBiSRdHd8sbjALLsrTtZ0/KM2mWXuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VHrZY2Ok; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VHrZY2Ok"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8a016799d2cso67236096d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891099; x=1777495899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utyKBbsMHkrf1RLZ9+YGSbMi4REas0kUOyTQWzOet08=;
        b=Bxj2X3AY6bN3QdCFI92mY/Bmwy5VIqWtuz33yjjwnqPXMLr8DqRz3Kp8pGMbcsyGIk
         EnbKU7brmsljdilDO8sOpK4qxdOSrJPTGu/thOoDPWcg2XLKFuaYG+Myea7E+FArSqWZ
         VscCZPPpiWF8dO9bia33OFeWkmA1HTKvCVs9MrV4CBWwfBmhjoJJSH/LUINgHMOwhj1K
         tMLHWZMXpNH7DJVPHEd39Zr3+i7cEBBM7jBwYveNP4Z/ayUQJ8VRh88QeQS8pdRNbATl
         6PBYmrZIDZs97Bj8z+c4/HnjQRrgxgpeQLucSxTBhX2R28rYkY2otygJrGZ7j+FLVa0S
         jyFA==
X-Forwarded-Encrypted: i=1; AFNElJ8mhtNmo2gb9gAyszXWGzm4/HXWwtnLYe00iNLWwUh4+BReD9/NEoxhPgonf4giusGzcAlV8JbqbAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86sNjxu/kRLU1oqDewG+HGMzZYyRhN54ydH5Nl1ocgrptZ0Bj
	4cOXJayvcU2TltHrzMvVbr1M5YPH1mpDLRO1stxT2IGYp5yGAuCuhdagmgoWnH8PNHjiiMVdLml
	0WyksWlFhE5EsMZKHY8NSVTpG6LngjgnhvfFBTAc55QOOw0QGRFAs+sOV5fCdk06H401yQpqOo9
	vgQ2axKRUbQUhWJ9XBo/8ov1gu25Re0hnNGnavL1zqm2tVRNf8oKTQ+Bc9xxo8cFbU+72OndsUV
	5l1PW9ZjXO/
X-Gm-Gg: AeBDievd/C/SFWAyjYK6dn/QSOL8D52oYpve8Ki16+hXuSdDEzWzPPwFsl/rH6YCleB
	XI2sNcXcJh2rs5dQchUM+BeD72KSc6jz8tQAryYnFOwnSfDa14BKQ57An3vEoCOAnr2sR5SBVur
	wbChDZ4i3ttph49biYu03QJUmzWxjHxsPB0UjBt+e5xqcBmWk3oIeqIzBiDESIpI+qPJmkhP6LV
	4R7TIcJQP7kJ4LJLKRlg/gabBwch30p3jomZcOIEHLx4kn97olcR1kqeTmvJzwevhUvIcD32XIw
	AGi7qsug0HrYnDNKg9EutccbOOMs4BtOQLRt8Eba7Y269PK6BkSfVHkN0NAVCsFpwZsoV/OrlZw
	x5X1z4hIbYfO3wACe0UpyEA3X5zyh3Ha629S87/KLlXIX1ukB3CjMpcz9dKsPrF6giBetY6+nM+
	1vhQukGEPe9MaCR9sRivXr3fvc43mliaM6HeYwZ2qL9wzkw1uv0WlEiJcDiAbnke4ozRI=
X-Received: by 2002:ad4:5f0f:0:b0:89c:e38f:6b6c with SMTP id 6a1803df08f44-8b027ff8fe6mr380921026d6.3.1776891098686;
        Wed, 22 Apr 2026 13:51:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b1fef8d44dsm3135936d6.26.2026.04.22.13.51.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 13:51:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a16036c90eso151136456d6.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776891098; x=1777495898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utyKBbsMHkrf1RLZ9+YGSbMi4REas0kUOyTQWzOet08=;
        b=VHrZY2OkEFN4ohwqyDnk9NRckI5HsxVQ+yATP7f7fyT/VU5fhSkAB/Ldc8OQARTtCP
         w/5QDshKBK5bSOmhC+Cs1oKtg9f/htsGQUUHLngyt5nirNIhhNIn7sF+8DFmIPiV9s0N
         dFZkf9WmPcyHOcd7lNAqkcqMssIGDy8+sJN9A=
X-Forwarded-Encrypted: i=1; AFNElJ/umB1uWwTbEv6qSfrInsPWQuKqy811vXzJghgN9xYfLj+ZzhOce0PjfGOudObf7KdYLOwp1B1B4SU=@vger.kernel.org
X-Received: by 2002:ad4:5de9:0:b0:89a:f0b:60e9 with SMTP id 6a1803df08f44-8b0280476c8mr357553516d6.13.1776891097824;
        Wed, 22 Apr 2026 13:51:37 -0700 (PDT)
X-Received: by 2002:ad4:5de9:0:b0:89a:f0b:60e9 with SMTP id 6a1803df08f44-8b0280476c8mr357553046d6.13.1776891097161;
        Wed, 22 Apr 2026 13:51:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae88d5fsm171453486d6.39.2026.04.22.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:51:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v5 2/4] mmc: sdhci: Implement panic-context write support
Date: Wed, 22 Apr 2026 16:50:51 -0400
Message-Id: <20260422205053.3392395-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci.c | 173 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   6 ++
 2 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 605be55f8d2d..b5e6cc9d150a 100644
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
 
@@ -3076,6 +3082,156 @@ static void sdhci_card_event(struct mmc_host *mmc)
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
+#define SDHCI_PANIC_RESET_TIMEOUT_US	500000
+#define SDHCI_PANIC_DRAIN_TIMEOUT_US	500000
+
+/**
+ * sdhci_panic_prepare - Prepare SDHCI controller for panic-context I/O
+ * @mmc: MMC host structure
+ *
+ * Called during kernel panic. Drains any in-flight request, resets the
+ * CMD and DATA lines, then clears software state under spinlock.
+ * The drain + reset ensures no stopped CPU is still inside sdhci_irq
+ * holding host->lock by the time we take it.
+ *
+ * Return: 0 on success, -ETIMEDOUT if hardware reset timed out.
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
+ * @mmc: MMC host structure
+ * @mrq: MMC request being polled for completion
+ *
+ * Checks interrupt status and present state registers to determine if a
+ * request has completed. Used during panic when interrupts are disabled.
+ *
+ * Return: true if request has completed (with or without error), false if still in progress.
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
+ * @mmc: MMC host structure
+ * @mrq: MMC request that has completed
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
@@ -3091,6 +3247,9 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.panic_prepare			= sdhci_panic_prepare,
+	.panic_poll_completion		= sdhci_panic_poll_completion,
+	.panic_complete			= sdhci_panic_complete,
 };
 
 /*****************************************************************************\
@@ -3242,6 +3401,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
 
 	host = timer_container_of(host, t, timer);
 
+	if (oops_in_progress)
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
@@ -3264,6 +3426,9 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
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

