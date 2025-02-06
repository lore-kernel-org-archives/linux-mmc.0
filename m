Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F322FF59
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879812; cv=none; b=DJOn8Mq9N+MzlDybvgG5tPMniN0w0w/T+yK0y9NtquB/NLme020GQRTy2Wz3v1QyypZfK62xm7lytKaMKUCQ4bQ+3CLgeut2FUQtZwarzE6tvbNGO3KOqX9LV2lKLCaOsjXfFnGPS1BSfalGAMA5p7B6XqnjU6bmjU8EqeHI28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879812; c=relaxed/simple;
	bh=2ltdpSYNJ4qp7eXJZyWR/TpXJn8oKt1mLyYkedoWIV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VKRmKYahiiD7gKiIJ3ELdBtgknMOJMGYrKtKkHSwMLhi6w6PhgHQhWjtMAVT/+38ovbNCc+USUpPB5BDw92TlWhyZgR3B78X6iISrszocQd8P1JOTiMkmyGpYkQXRS2sJ8l2Am03EVbnCExVe9pO3CMDhZqetzpv36W5LqRYcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AuRaHETx; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AuRaHETx"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3284f963so931610a34.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2025 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738879809; x=1739484609; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lkz5Ief6/yedXCa2E82v4RvcWGp3Dzv7ilZTZRS1+D0=;
        b=AuRaHETxL11y3S7exSjvwLVj4VYvHkWf4r7mjhENAtlltELCClEOEJR8TLz2s7XXWa
         bdKwy5gFBqUMilUJxzKIemTJFBNUodxzGXUpNQRarB7VUKRR3DGcOn73P1eRFBZE2dwm
         /IBaDvBWP3L8Fn7eM4rJIxv4yTELH+XuJYA0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879809; x=1739484609;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lkz5Ief6/yedXCa2E82v4RvcWGp3Dzv7ilZTZRS1+D0=;
        b=v50Hfe6BNlrzkx5IfiEN8aO6a6V9JY1CnZp7ZvQeRxVkl7fN3q87nMN1VgXdEoALR8
         JnIwayG+IjyukrbMGmsg0LG3Vj1fqWvBhaGkMN5iKOLPcV9iKGfFBHh09BWl9KoA5wOy
         KzAHvuC0E5/z4Ul3u4lCx0QPVfoY3u1c5N7AVffNwCrQVwRMKTZwWQKlaM8O4+sdRBcE
         yBbheHetw74mM3SXfLX74094rZjlNXV8gj67nvNIy4lSLnXdCVA2sRW8P8RNWzIzA+Qo
         tNlh1WZ5j8qwfbAx3Med0cII2cPMnYOhd17mf6AMtf0dXywC3LgMxLeMY2zx3ahAaH+I
         IxWg==
X-Forwarded-Encrypted: i=1; AJvYcCWB8p94YMA2rzAHxrlrNiBuCihlNeMO8gXvacqiol4DT7YVidqLCUl6HflU6lQnbOMLuJKcfeyeCQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ol4YOx1uFI29KPuTlziz13WepOp+rwaTJgDetisxRg6c12TY
	JvmjB3n/CwnJfILoJ6mtaiEmHvykPvwxAQd/Nu95j3yFrrvYHVwgVsHcloV1xA==
X-Gm-Gg: ASbGncsBSXcNRmtb21yfwL7ShZer476NKWa+5Vy8iqJ02Y6lanm2REFnCaYw++ntwpc
	LcjWG3Up5qG/tCVVm58q8dVJpjVv+vIkPMSuJcblmLc19yBBEi0G/P2oi1FTLIlgJsjwbS84z6D
	G7vnz1B0AtJEoe3/AQIUoaIJHbqbpoyZIoYYT7eskSaN+2+4sfBLxVoYMCbGT4hMHR/hYygcdza
	ILYVYqppwZCMrUpAFHdgTpy97Snco3oW90eZwoBAnlJ72zQP/ei0LkQVEMeIYc0Sl6SJclLqYwM
	JNqkXh8/N5/lBds22OTY4jZ2tGBuyswZTxsbYcqyh3yc9usHvz4=
X-Google-Smtp-Source: AGHT+IFe5+HDp6jW4POK05lh6FZmTZaClwC8C9AdZB4KwfkTEdj/0zyU6GxhcMlShT6jCqkuU2sdmg==
X-Received: by 2002:a05:6830:378c:b0:71e:946:80c4 with SMTP id 46e09a7af769-726b87f8463mr750227a34.12.1738879808913;
        Thu, 06 Feb 2025 14:10:08 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544cf88esm454109eaf.15.2025.02.06.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:10:08 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH RFC 3/3] mmc: sdhci-brcmstb: Add rpmb sharing support in host driver
Date: Thu,  6 Feb 2025 17:09:40 -0500
Message-Id: <20250206220940.10553-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206220940.10553-1-kamal.dasu@broadcom.com>
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Kamal Dasu <kdasu@broadcom.com>

Adding sdio rpmb parition sharing support to brcmstb host driver.
The sdhci-brcmstb controller driver uses SDIO_SHARE registers and
HW semaphore register to synchronize access between linux and the
trusted zone firmware.

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 275 ++++++++++++++++++++++++++++++-
 1 file changed, 273 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..6ba90108cd5c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -46,9 +46,32 @@
 /* Select all SD UHS type I SDR speed above 50MB/s */
 #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
 
+#define SDHCI_BRCMSTB_AGENT_LINUX		'L'
+#define SDHCI_BRCMSTB_AGENT_TZOS		'A'
+#define FLSHARE_IPIS0_INT_SEND_MASK		BIT(17)
+#define HWSEM_AQUIRE		1
+#define HWSEM_RELEASE		0
+
+enum brcmstb_sdhci_share_reg {
+	BRCMSTB_SD_SHARE_REG_NEXT = 0x0,	/* Next Agent Register */
+	BRCMSTB_SD_SHARE_REG_PMC = 0x4,		/* Work Agent1 Register */
+	BRCMSTB_SD_SHARE_REG_TZOS = 0x8,	/* Work Agent2 Register */
+	BRCMSTB_SD_SHARE_REG_LINUX = 0xc,	/* Work Agent3 Register */
+};
+
+struct brcmstb_sdio_share_info {
+	void __iomem *share_reg;
+	void __iomem *sem_reg;
+	void __iomem *ipis0_reg;
+	int irq_recv;
+	wait_queue_head_t wq;
+};
+
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
+	struct brcmstb_sdio_share_info *si;
 	struct clk *base_clk;
 	u32 base_freq_hz;
 };
@@ -288,7 +311,7 @@ static const struct brcmstb_match_priv match_priv_7216 = {
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
-static struct brcmstb_match_priv match_priv_74165b0 = {
+static const struct brcmstb_match_priv match_priv_74165b0 = {
 	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_74165b0,
@@ -303,6 +326,176 @@ static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{},
 };
 
+static void sdhci_brcmstb_dbg_dump_sdio_share_regs(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+
+	dev_dbg(mmc_dev(host->mmc),
+		"sem:0x%x wn:0x%x wa:0x%x wl:0x%x\n",
+		readl(si->sem_reg),
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT),
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_TZOS),
+		readl(si->share_reg + BRCMSTB_SD_SHARE_REG_LINUX));
+}
+
+static bool sdhci_brcmstb_host_is_next(struct brcmstb_sdio_share_info *si)
+{
+	u32 wn;
+
+	/* if work queue is empty or we are next */
+	wn = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	return (wn == 0 ? true : (wn == SDHCI_BRCMSTB_AGENT_LINUX));
+}
+
+#define SDHCI_BRCMSTB_HOST_TIMEOUT_MS  5
+
+static int sdhci_brcmstb_wait_for_host(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+	int ret = 0;
+
+	/* put self in wait queue if host not avialable  */
+	ret = wait_event_timeout(si->wq, sdhci_brcmstb_host_is_next(si),
+			 msecs_to_jiffies(SDHCI_BRCMSTB_HOST_TIMEOUT_MS) + 1);
+
+	return ret;
+}
+
+static u32 semreg_wrrdl(struct sdhci_host *host, u32 value, void __iomem *addr)
+{
+	writel(value, addr);
+	return readl(addr);
+}
+
+static void sdhci_brcmstb_hwsem(struct sdhci_host *host, int sem_op)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+	u32 wr_val;
+	u32 wa, sem_val;
+	bool is_next;
+	int ret = 0;
+
+	while (1) {
+		if (sem_op == HWSEM_AQUIRE)  {
+			/*
+			 * get hw sem :
+			 *
+			 * 1. write linux agent id to work register WL
+			 * 2. check if we are next in line or workqueue empty
+			 * 3. if linux is not next in queue go into waitq
+			 *
+			 * handle case where the next work agent was not set
+			 * but TZOS grabbed the semaphore before we could
+			 * in that case too we put ourselves in wait queue,
+			 * tzos shall remove linux from wait queue using IPI
+			 */
+			wr_val = SDHCI_BRCMSTB_AGENT_LINUX;
+			writel(wr_val, si->share_reg + BRCMSTB_SD_SHARE_REG_LINUX);
+			is_next = sdhci_brcmstb_host_is_next(si);
+			if (!is_next)
+				ret = sdhci_brcmstb_wait_for_host(host);
+		} else {
+			/*
+			 * release hw semphore
+			 * 1. set the next agent before releasing hw sem
+			 * 2. clear work agent
+			 * 3. Release hw semaphore
+			 */
+			wa = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_TZOS);
+			writel(wa, si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+			writel(0, si->share_reg + BRCMSTB_SD_SHARE_REG_LINUX);
+			wr_val = 0;
+			sem_val = readl(si->sem_reg);
+			if (!sem_val || sem_val != SDHCI_BRCMSTB_AGENT_LINUX)
+				goto out;
+
+		}
+
+		/* try to grab/release hw semaphore */
+		sem_val = semreg_wrrdl(host, wr_val, si->sem_reg);
+
+		if (!wr_val || (sem_val == wr_val))
+			break;
+	}
+
+	return;
+out:
+	sdhci_brcmstb_dbg_dump_sdio_share_regs(host);
+	dev_dbg(mmc_dev(host->mmc), "%s ret:%d\n",
+		(sem_op == HWSEM_AQUIRE) ? "get" : "release", ret);
+}
+
+static bool sdhci_brcmstb_cqe_is_idle(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
+	struct cqhci_host *cq_host;
+
+	if (!(priv->flags & BRCMSTB_PRIV_FLAGS_HAS_CQE))
+		return true;
+
+	cq_host = mmc->cqe_private;
+	/* still processing mrqs in cqe mode  */
+	return (cq_host->qcnt == 0 && !cq_host->recovery_halt) ? true : false;
+}
+
+static void sdhci_brcmstb_aquire_hwsem(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+	u32 wn = SDHCI_BRCMSTB_AGENT_LINUX;
+
+	sdhci_brcmstb_hwsem(host, HWSEM_AQUIRE);
+	/* indicate linux as next agent since it got the hw semaphore */
+	writel(wn, si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	dev_dbg(mmc_dev(host->mmc), "hwsem get\n");
+	sdhci_brcmstb_dbg_dump_sdio_share_regs(host);
+}
+
+static void sdhci_brcmstb_release_hwsem(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+	u32 wn;
+
+	if (!sdhci_brcmstb_cqe_is_idle(host))
+		return;
+
+	wn = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	/* release hw semaphore send IPI when done */
+	sdhci_brcmstb_hwsem(host, HWSEM_RELEASE);
+
+	if (wn == SDHCI_BRCMSTB_AGENT_TZOS)
+		writel(FLSHARE_IPIS0_INT_SEND_MASK, si->ipis0_reg);
+
+	dev_dbg(mmc_dev(host->mmc), "hwsem release\n");
+	sdhci_brcmstb_dbg_dump_sdio_share_regs(host);
+}
+
+static void sdhci_brcmstb_request_start(struct mmc_host *mmchost,
+					struct mmc_request *mrq)
+{
+	sdhci_brcmstb_aquire_hwsem(mmc_priv(mmchost));
+}
+
+static void sdhci_brcmstb_request_done(struct mmc_host *mmchost,
+				       struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmchost);
+
+	if (!mmchost->ongoing_mrq)
+		sdhci_brcmstb_release_hwsem(host);
+}
+
 static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -316,6 +509,81 @@ static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+static irqreturn_t sdhci_brcmstb_recv_ipi0_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct brcmstb_sdio_share_info *si = priv->si;
+	u32 wn;
+
+	wn = readl(si->share_reg + BRCMSTB_SD_SHARE_REG_NEXT);
+	dev_dbg(mmc_dev(host->mmc), "ipi irq %d wn 0x%x\n", irq, wn);
+
+	if (wn == SDHCI_BRCMSTB_AGENT_LINUX)
+		wake_up(&si->wq);
+
+	return IRQ_HANDLED;
+}
+
+static int sdhci_brcmstb_sdio_share_init(struct platform_device *pdev)
+{
+	struct sdhci_host *host = dev_get_drvdata(&pdev->dev);
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
+	si = kcalloc(1, sizeof(struct brcmstb_sdio_share_info),
+		     GFP_KERNEL);
+	if (!si)
+		return -ENOMEM;
+
+	si->share_reg = sdio_sh_regs;
+	si->sem_reg = devm_platform_ioremap_resource_byname(pdev,
+							    "mmc_sem");
+	if (IS_ERR(si->sem_reg)) {
+		ret = PTR_ERR(si->sem_reg);
+		dev_err(&pdev->dev, "mmc_sem register\n");
+		goto err;
+	}
+
+	si->irq_recv = platform_get_irq_byname_optional(pdev, "recv_ipi0");
+	if (si->irq_recv < 0) {
+		ret = si->irq_recv;
+		dev_err(&pdev->dev, "recv_ipi0 IRQ not found\n");
+		goto err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, si->irq_recv,
+			       sdhci_brcmstb_recv_ipi0_irq,
+			       0, "mmc_recv_ipi0", host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "mmc_recv_ipi0 IRQ request_irq failed\n");
+		goto err;
+	}
+
+	si->ipis0_reg = devm_platform_ioremap_resource_byname(pdev, "flshr_ipis0");
+	if (IS_ERR(si->ipis0_reg))
+		goto err;
+
+	priv->si = si;
+	init_waitqueue_head(&si->wq);
+	host->mmc_host_ops.request_start = sdhci_brcmstb_request_start;
+	host->mmc_host_ops.request_done = sdhci_brcmstb_request_done;
+
+	return 0;
+err:
+	kfree(si);
+	return ret;
+}
+
 static int sdhci_brcmstb_add_host(struct sdhci_host *host,
 				  struct sdhci_brcmstb_priv *priv)
 {
@@ -482,8 +750,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		goto err;
 
 	pltfm_host->clk = clk;
-	return res;
+	res  = sdhci_brcmstb_sdio_share_init(pdev);
+	if (res)
+		goto err;
 
+	return res;
 err:
 	sdhci_pltfm_free(pdev);
 	clk_disable_unprepare(base_clk);
-- 
2.17.1

