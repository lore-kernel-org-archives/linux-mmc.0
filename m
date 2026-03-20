Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8935836B
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038830; cv=none; b=NbH+Lp3zGRPx985hVt04To8WuAcG8IouHJIor2RTJ6uOiQiOqXC5n3B+mUTF55/PgIV7Q+gTwRoZi9Cz8hc6wacxrrB8MRD95eGwHZynojmp5BillASbijNh1bmCrQV2LvdowejnRfAhTK8jAfvTIkDle5GtlgYr+b6mEpDf7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038830; c=relaxed/simple;
	bh=8WmmNAFWdVy8iylQQm9cVlM3+5qqTYwPxJMPlafbX9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1+x73Auo5uQK7KpyOjOHTYWJEW59HmBpw3TisV/h+h+n3gLVhKULAD7q/6XNkJQa6c9Vkh8jGUiRQr/m2sp7l5UVu13bskuGG9ZBqJDcKvHWjX4QnScOUkUxGnNkuINgudE1lZBCLFo7FiGAynhp0gflC85WLEt/smvB3h3VBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=faaQK0pw; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="faaQK0pw"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2b04e6a989eso15599045ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774038828; x=1774643628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CXtTypYyHqjl2V69Ghw/md4zg3U7POaN7Ulg0LlUBU=;
        b=UO1rMESTALrM2t2AIedkcOMKcgIclCGPoriihPlPKN3ijqxdmbEKTJ4q14Pqp6Oapz
         lJ0YrMbqRTWDjUwnAjKbfC6arMVZ+bp1qQjUaGc0O7ukgpmV7YT780mUuBT5dSMXgqzf
         fhz3xrEt7Fv6x7Ye5juqgI+wdURpOvGhXLdAsExOuCk3093FOlos+F4T500+VV63MNz3
         ilBvfpLmevTTFf8DRPSFB/Z4EkKoRcqb1tuvpn/K0b0RzsfNvXLC0aKoDhTT4x+L7BwI
         kZvZaYBtBaV1RKVWkaQ2xrCW40TseEmz9h1waGtphyyuAV53hCqFbPLZvsmMSWoN04d+
         kxBA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+FBOyLVUW6fCTCtQXSug9dSPpELXV6rhiFCaXLSKh81HIjpZl0iI/vN14yfSnAtWdzBbP5kbvfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiTQgSwHZHwap3Fjhu983KXVwuPpcpjBmhoUoQ2tDT2GRMjOZ
	n8mB/MLj4XKQCXOjnCosjIwUqk1tj8AHrKMjKjmOapD12ti/bt1jc+ND16MPsNq0iK8fvP7WHyD
	+2T+4jdq5nxt5vpyyW2UWQ+ZAAci45/jTdcsAXd5uvloufm8fx8cTu99Kxx/nE9KhQKIlBnqLg6
	Hl0BIxPA5GX3ZBh6nCOymTOmExpwlBL9Z7wVD/ERRHaVFHhJBiUFvt7DSLBsqq+q9dFl4oJ32KQ
	Njudwdm2uLJ
X-Gm-Gg: ATEYQzwq9oeU8qKRSADOYa8l8yPmw1i3De2kUiNysgu/1x0fL/VZ+kFjWIiJ4ASkFJI
	m8J/HJf9Hp3wL/esXgjy5W4th6Lk0xF1xJd73NsTsE4jlB7ApKa3+mSPeltJ97GWkx54hPL17aS
	xZcFpuOB9rhEF2fjcrBQLJmjfoAh44tI45thf7dHfFJbfmBcLyc7YEcdJC+prPIpKwDVStv2jJu
	vyehKiFrIeMBRxFx9ieI4mmSMs45Fjtvek8vLJ8/VOxTLcVMtP3tVKL9kW2SHQ7cz7TYc742mMq
	mTozvrpOVOzBDPXCxdpoiGWgMJmZJCYB9gEMGdBm8PX43vOqJ7YS1Zc4gAG5q+BIqC3ytnrk7l8
	QehvdP6HhBrKhIzHNzsdu7k5Qfd5oE9zjh+TgPnRLOxL3pSru+29ySZLxIOFsbj3qfRx+w5lIeB
	252s+xjNAsV0otcxGF2KEs3J/J6/NhLGo8EpKIsSR8VqGNaZ81qzKS2A==
X-Received: by 2002:a17:902:e78d:b0:2b0:61c2:8e7a with SMTP id d9443c01a7336-2b08278afa1mr34922055ad.25.1774038828249;
        Fri, 20 Mar 2026 13:33:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0835f474bsm3835415ad.38.2026.03.20.13.33.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 13:33:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cfbbf78ca8so1160615785a.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774038827; x=1774643627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CXtTypYyHqjl2V69Ghw/md4zg3U7POaN7Ulg0LlUBU=;
        b=faaQK0pwL820M7tRl1pQ09cXnew/+OTBafmmefd1j6ti/iyi4/TZzdVRmZEx6eWKVQ
         vAW9uxNzcm3sk7+wJAKY0FtxIr6G1MQkooCM5YidxHl3Am/pZ5mN644IARWz7HEMtwUX
         Al0unux6zLlVSE+A4ez6/Hy72xfuZWak108qY=
X-Forwarded-Encrypted: i=1; AJvYcCWofUT6VtgEisjhVwQVA3K9llk4tAq4krQQGC3LHycg3dFVLxfLRVG0ccEGeV2XxwjuZcDsJtQ51FM=@vger.kernel.org
X-Received: by 2002:a05:620a:4689:b0:8cd:af31:b416 with SMTP id af79cd13be357-8cfc7f4b0a7mr653886485a.34.1774038826805;
        Fri, 20 Mar 2026 13:33:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:8cd:af31:b416 with SMTP id af79cd13be357-8cfc7f4b0a7mr653880885a.34.1774038826140;
        Fri, 20 Mar 2026 13:33:46 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8fb9c10sm280699985a.19.2026.03.20.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 13:33:45 -0700 (PDT)
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
Subject: [PATCH v4 2/4] mmc: sdhci: Implement panic-context write support
Date: Fri, 20 Mar 2026 16:32:47 -0400
Message-Id: <20260320203249.1965044-3-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci.c | 169 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   6 ++
 2 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fec9329e1edb..c40084e07eca 100644
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
 
@@ -3076,6 +3082,152 @@ static void sdhci_card_event(struct mmc_host *mmc)
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
+ * @mmc: MMC host structure
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
+ * @mmc: MMC host structure
+ * @mrq: MMC request being polled for completion
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
@@ -3091,6 +3243,9 @@ static const struct mmc_host_ops sdhci_ops = {
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.panic_prepare			= sdhci_panic_prepare,
+	.panic_poll_completion		= sdhci_panic_poll_completion,
+	.panic_complete			= sdhci_panic_complete,
 };
 
 /*****************************************************************************\
@@ -3242,6 +3397,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
 
 	host = timer_container_of(host, t, timer);
 
+	if (oops_in_progress)
+		return;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
@@ -3264,6 +3422,9 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
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

