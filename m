Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC62D2EE97C
	for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248573; cv=none; b=mXcsX9B71AvKfm5BF1ST5gK5CTGdugZMMw3l3l51YSZizLxBWOpR2nfxlkSuNCXDYYMsXs/ztYgeg3Zj744NeIiEAjqWACpgHmehE06FJ303aipuyvbOidJ7/TAuj5AkTnKtb0Vuy9zXVWbQnaPElwDE5fbS44ZgLgw5KfWk2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248573; c=relaxed/simple;
	bh=9TVIFhZ9Ng8MM6GMhXRvugXYBKdmh0MJIMmnJr3YuU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Il9B2iVsCW6IT0Mnfgek3zxNTnP88lCUAu2vWCVOIWjVGLllm/StfDQubHpP4dMMfm+AwZ8bfS9K3drZjFElvn0mI8P7Y/kTfX4kUSbeI7YY9OwfRzyq8j9hUEyXcCiJ4CjXW1e4ZMdGgYxD8Hu8aXDbyaZ71AqfPYS8biLu1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bfd1zTrz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bfd1zTrz"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74ce477af25so1516711b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248569; x=1752853369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtwPggwvOo/q4KD7Ta8DPc1XFco1ExVXRxOJ3t8Lkxk=;
        b=bfd1zTrzovhKaa/4Q4fJ1OcLKEUpXGwz3f51cxj5oiTM9o2aVVxP55EeSkOhg29wGe
         C33Idhdc2/DLvM53JA1F9LJtCrRUhoc31oi3f10AmPxDcadnMtsoROBSudr3owNqb5am
         SoZ1GJnSXHxDwWO6rIF/VoHRD+8HHM+0hkQME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248569; x=1752853369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtwPggwvOo/q4KD7Ta8DPc1XFco1ExVXRxOJ3t8Lkxk=;
        b=NMosjkseiq1uicbDwVGXBEk2RTl3PAn+lklApwe8u15aMr+dYqfgtqjMfEJoHimsbI
         WraOeA9m6mcwiVUz82T69BkQ66jY4bzrDnfDnBm6eNTnBiA90hJrnFi4v3lSZSXuFRwP
         dauBGn7LeZUM2cFa56LrWz1fnmwQroRxINUKIbwoy+GsU2iTq2eA79rhL6EVBT4AjmnZ
         nK5iocrX5MD6ihGPft3OJ4AEejXZA7mSB/R/O8s1jmHYdEPW2LYP6Fvt3nDEPuxz3vDX
         X3divVHuALED8jIaHtVikoJrwlR2CISpDaRgJOSfhsbcZKc3GodIaGbzLzwoYr+ESgiC
         hmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj7B07rBNIHBfBj3lU4nRdT7oysLfJxhhKi5aDmjddP78sMVQbTeQLH0uzepHxnFeyRnDrphzZcqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoNo06kUJBFarYnqwo29538S7IGrnmYubpqj3CDgEaS0ciPKb
	3Oz5bvxGX/IKLhwGgNrFp29G/F3Fa/qlHNVpoQDE+TBww5kJuf30296GSYzDXMl3+A==
X-Gm-Gg: ASbGnct9eWzDifFfT0PK/Louqfi+dMCYu9VAXpY+KIQuyjiChGghphQ442jHSa0CMlA
	pHDGomAiqefbIbeK/KPUKGtADx/bvgJX4fJLUd1tqKGjZIOUhtsVGKCBdd4x/Ht1XTLufCQ5BK+
	XtA/4RjrgqUbRVYmZ2H4rJ0GUMHbKSVhAgzgFxZoOFf8kv4O5dcNk1DRPLB0yQvgyxj7SOeQreP
	XK7Qox8fIgDUDRk7jh2WPw3v72HRKXNqMoqGdxGRjoEIjMwYPKdf8bDuJsi6/dvKTZkD3m1euO7
	1vCIGBIQFvvYLIDLqAHt+gdMErF5NA4vyo5Qyq11WZ5qcHTTsyqboIti7tczfarYICOr1L7XP1E
	LGBCoKR8L+Oo563foAW/jSQCuCtA1ONYoXhtrr0wcqW2gEfM8dS1znjyqNA==
X-Google-Smtp-Source: AGHT+IF2UJ8jyAWBU3zH4viF1mk0nN5U7SEontiO31z0G3cZg60lf2YSZB1k7c/7Pe+wyfwJ2gn7PA==
X-Received: by 2002:a05:6a00:b44:b0:730:9946:5973 with SMTP id d2e1a72fcca58-74ee0aa69bamr4150852b3a.5.1752248569006;
        Fri, 11 Jul 2025 08:42:49 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:48 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 4/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS
Date: Fri, 11 Jul 2025 11:42:21 -0400
Message-Id: <20250711154221.928164-6-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kamal Dasu <kdasu@broadcom.com>

Adding sdio rpmb partition sharing support in brcmstb host driver.
The sdhci-brcmstb controller driver uses SDIO_SHARE work registers
along with use of brcmstb hwspinlock framework to synchronize access
between linux and trusted zone firmware. The sdhci-brcmstb driver
claims and releases host for TZOS only when it is requested to do
via ipi0 interrupt.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 243 ++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 48cdcba0f39c..dd68fd512459 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -12,6 +12,10 @@
 #include <linux/of.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/hwspinlock.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include "../core/core.h"
 
 #include "sdhci-cqhci.h"
 #include "sdhci-pltfm.h"
@@ -34,6 +38,11 @@
 #define SDIO_CFG_CQ_CAPABILITY			0x4c
 #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
 
+#define SDHCI_BRCMSTB_AGENT_LINUX		'L'
+#define SDHCI_BRCMSTB_AGENT_TZOS		'A'
+#define FLSHARE_IPIS0_INT_SEND_MASK		BIT(17)
+#define HWSPINLOCK_TIMEOUT_MS			100
+
 #define SDIO_CFG_CTRL				0x0
 #define SDIO_CFG_CTRL_SDCD_N_TEST_EN		BIT(31)
 #define SDIO_CFG_CTRL_SDCD_N_TEST_LEV		BIT(30)
@@ -46,9 +55,26 @@
 /* Select all SD UHS type I SDR speed above 50MB/s */
 #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
 
+#define BRCMSTB_SD_SHARE_REG_NEXT		0x0 /* Next Agent Register */
+#define BRCMSTB_SD_SHARE_REG_PMC		0x4 /* Work Agent1 Register */
+#define BRCMSTB_SD_SHARE_REG_TZOS		0x8 /* Work Agent2 Register */
+#define BRCMSTB_SD_SHARE_REG_LINUX		0xc /* Work Agent3 Register */
+
+struct brcmstb_sdio_share_info {
+	void __iomem *share_reg;
+	void __iomem *ipis0_reg;
+	struct hwspinlock *hwlock;
+	struct sdhci_host *host;
+	int irq_recv;
+	int host_claimed;
+	wait_queue_head_t wq;
+	struct task_struct  *claim_thread;
+};
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
+	struct brcmstb_sdio_share_info *si;
 	struct clk *base_clk;
 	u32 base_freq_hz;
 };
@@ -303,6 +329,218 @@ static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{},
 };
 
+static void sdhci_brcmstb_dump_shr_regs(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+
+	dev_dbg(mmc_dev(host->mmc), "wn:0x%x wa:0x%x wl:0x%x\n",
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT),
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_TZOS),
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_LINUX));
+}
+
+static bool sdhci_brcmstb_linux_host_is_next(struct brcmstb_sdio_share_info *si)
+{
+	u32 wn;
+
+	/* check if linux is next */
+	wn = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	return ((wn == SDHCI_BRCMSTB_AGENT_LINUX) ? true : false);
+}
+
+static void sdhci_brcmstb_wait_for_linux_host(struct brcmstb_sdio_share_info *si)
+{
+	int ret;
+
+	while (1) {
+		/* put self in wait queue when host not available  */
+		ret = wait_event_interruptible(si->wq,
+				       sdhci_brcmstb_linux_host_is_next(si));
+		if (ret != -ERESTARTSYS)
+			break;
+	};
+}
+
+static bool sdhci_brcmstb_tzos_is_waiting(struct brcmstb_sdio_share_info *si)
+{
+	u32 wt;
+
+	/* check if TZOS has put itself in the work queue  */
+	wt = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_TZOS);
+	return ((wt == SDHCI_BRCMSTB_AGENT_TZOS) ? true : false);
+}
+
+static void sdhci_brcmstb_wait_for_tzos(struct brcmstb_sdio_share_info *si)
+{
+	int ret;
+
+	while (1) {
+		/* wait in queue when tzos cannot use controller */
+		ret = wait_event_interruptible(si->wq,
+				   sdhci_brcmstb_tzos_is_waiting(si));
+		if (ret != -ERESTARTSYS)
+			break;
+	}
+}
+
+static void sdhci_brcmstb_aquire_hwsem(struct brcmstb_sdio_share_info *si)
+{
+	u32 wl = SDHCI_BRCMSTB_AGENT_LINUX;
+	struct mmc_host *mmc = si->host->mmc;
+	int ret;
+
+	/*
+	 * aquire hw sem :
+	 * 1. write linux agent id to work register WL
+	 * 2. Aquire hw semaphore
+	 * 2. clear next work register WN
+	 */
+	writel(wl, si->share_reg + BRCMSTB_SD_SHARE_REG_LINUX);
+	/*  try hw semaphore lock, we should never have to wait here */
+	ret =  hwspin_lock_timeout(si->hwlock, HWSPINLOCK_TIMEOUT_MS);
+	WARN_ON(ret != 0);
+	/* clear next register when holding the semaphore */
+	writel(0, si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	dev_dbg(mmc_dev(mmc), "hwsem aquire\n");
+	sdhci_brcmstb_dump_shr_regs(si->host);
+}
+
+static void sdhci_brcmstb_release_hwsem(struct brcmstb_sdio_share_info *si)
+{
+	u32 wt;
+	struct mmc_host *mmc = si->host->mmc;
+	int ret;
+
+	/*
+	 * release hw semphore
+	 * 1. set the next work agent register WN before releasing hw sem
+	 * 2. Release hw semaphore
+	 * 3. send ipi to TZOS
+	 */
+	wt = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_TZOS);
+	writel(wt, si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+
+	/* release hw semaphore if we hold it and send IPI */
+	ret =  hwspin_trylock_raw(si->hwlock);
+	WARN_ON(ret != 0);
+	hwspin_unlock(si->hwlock);
+
+	if (wt == SDHCI_BRCMSTB_AGENT_TZOS)
+		writel(FLSHARE_IPIS0_INT_SEND_MASK, si->ipis0_reg);
+
+	dev_dbg(mmc_dev(mmc), "hwsem release\n");
+	sdhci_brcmstb_dump_shr_regs(si->host);
+}
+
+static irqreturn_t sdhci_brcmstb_recv_ipi0_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+
+	dev_dbg(mmc_dev(host->mmc), "ipi irq %d next L:%d T:%d ch:%d\n",
+		 irq, sdhci_brcmstb_linux_host_is_next(si),
+		 sdhci_brcmstb_tzos_is_waiting(si),
+		 si->host_claimed);
+	wake_up_interruptible(&si->wq);
+	return IRQ_HANDLED;
+}
+
+static int sdhci_brcmstb_host_claim_thread(void *data)
+{
+	struct brcmstb_sdio_share_info *si = data;
+	struct mmc_host *mmc = si->host->mmc;
+
+	do {
+		sdhci_brcmstb_wait_for_tzos(si);
+		/* claim host for TZOS */
+		mmc_claim_host(mmc);
+		si->host_claimed += 1;
+		sdhci_brcmstb_release_hwsem(si);
+		dev_dbg(mmc_dev(mmc), "host claimed %d\n", si->host_claimed);
+		sdhci_brcmstb_wait_for_linux_host(si);
+		sdhci_brcmstb_aquire_hwsem(si);
+		/* release host */
+		mmc_release_host(mmc);
+		si->host_claimed -= 1;
+		dev_dbg(mmc_dev(mmc), "host released %d\n", si->host_claimed);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static int sdhci_brcmstb_sdio_share_init(struct platform_device *pdev)
+{
+	struct sdhci_host *host = dev_get_drvdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si;
+	void __iomem *sdio_sh_regs;
+	int ret;
+
+	/* sdio_share block */
+	sdio_sh_regs = devm_platform_ioremap_resource_byname(pdev, "share");
+	if (IS_ERR(sdio_sh_regs))
+		return 0;
+
+	si = devm_kcalloc(&pdev->dev, 1, sizeof(struct brcmstb_sdio_share_info),
+			  GFP_KERNEL);
+	if (!si)
+		return -ENOMEM;
+
+	si->share_reg = sdio_sh_regs;
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get hwspinlock id %d\n", ret);
+		return ret;
+	}
+
+	si->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
+	if (!si->hwlock) {
+		dev_err(&pdev->dev, "failed to request hwspinlock\n");
+		return -ENXIO;
+	}
+
+	si->irq_recv = platform_get_irq_byname_optional(pdev, "recv_ipi0");
+	if (si->irq_recv < 0) {
+		ret = si->irq_recv;
+		dev_err(&pdev->dev, "recv_ipi0 IRQ not found\n");
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, si->irq_recv,
+			       sdhci_brcmstb_recv_ipi0_irq,
+			       0, "mmc_recv_ipi0", host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "mmc_recv_ipi0 IRQ request_irq failed\n");
+		return ret;
+	}
+
+	si->ipis0_reg = devm_platform_ioremap_resource_byname(pdev, "flshr_ipis0");
+	if (IS_ERR(si->ipis0_reg))
+		return -ENXIO;
+
+	priv->si = si;
+	si->host = host;
+	init_waitqueue_head(&si->wq);
+	/* acquire hwsem */
+	sdhci_brcmstb_aquire_hwsem(si);
+	si->claim_thread =
+		kthread_run(sdhci_brcmstb_host_claim_thread, si,
+			    "ksdshrthread/%s", mmc_hostname(host->mmc));
+	if (IS_ERR(si->claim_thread)) {
+		ret = PTR_ERR(si->claim_thread);
+		dev_err(&pdev->dev, "failed to run claim thread\n");
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -482,8 +720,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		goto err;
 
 	pltfm_host->clk = clk;
-	return res;
+	res  = sdhci_brcmstb_sdio_share_init(pdev);
+	if (res)
+		dev_warn(&pdev->dev, "sdio share unavailable\n");
 
+	return 0;
 err:
 	sdhci_pltfm_free(pdev);
 	clk_disable_unprepare(base_clk);
-- 
2.34.1

