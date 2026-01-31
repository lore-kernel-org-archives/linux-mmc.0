Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C731283A
	for <linux-mmc@vger.kernel.org>; Sat, 31 Jan 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824848; cv=none; b=SvbHSYqUXgkWmAS3VZdsHSbrLwEMhY1X62nK7NYZh5EA3hZcQWwKtpRlcZ5QzmgFDZ8jcaN9tvCKF8e/9dfUL/QAlsbDdAJXzWyuEV+AUYIBZwF73a0MbRK4X2NiLc8U0LZvVapgyqLcgzAI8CX2h0Pa8K5pc0A1LMKeI2g0OwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824848; c=relaxed/simple;
	bh=CNwPigzZGDKA5oRK2nGauMH5qUsneYXhqYJflSVffa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yo294oE6aov90FAr5dymm8jbx04RBFbyntvGE+qOeotBATdj3dAXtGhGESQkkrTYgIGRdxzivKV+ripwLC/PRRbofRgdL2glWfkFlHnEB2+zj9Fxst2ym3+ptguRa08DhWMAatkZyXaRCts0lQ3Nx8uLdjsucLY7D1/V5015oAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCfyn3aO; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCfyn3aO"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11f36012fb2so3500285c88.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2026 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769824845; x=1770429645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdahHyL8IV+6utRIDqW9CRmzmHxmcQw76s4h9oUSvv4=;
        b=nCfyn3aOvIOldD2l3PiZJFbccNQa+22GfUyE0UF9M98UrZqRaKX/NzgaTtbsAsweXt
         7Guy+YMun+1d2dfe5cUa8LLDCcVP/KwSumzChBKQmVRV8jYPeN8RsKapD7/yeW4Y6Cnk
         I4ujxln6V8bcpCo+lGHHQE0cCjopdrvdV2J3lJLdKE1NWTOX3uE/Sd7boG7UhgES5Qkb
         whPUaufy/r3A1sX11rxvERR8MGVY450wB/B1jS/d4azK+xnQVknmKPZoVuhu//CeYLrQ
         zgZnR0YYq9NhNV3IYwM5/LGlJk0AY/T06EtDJ1CBMRqFNs+qoaI/5bES/c9Gdp7RyeHr
         SGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769824845; x=1770429645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdahHyL8IV+6utRIDqW9CRmzmHxmcQw76s4h9oUSvv4=;
        b=Wf/0ZGbXmaPze+qDsO7Vtg9o6gWeHY7Lqw34A63mXr+tRq992FP/Stw8jtTGX0MHYD
         QiuGMzkI0SA1gFpHD1RxqEgZPvfdXpLhtL+N8BwKn78/5Iuev1zk48q/SSf8LszxSrur
         7glLCapvlpFnbLa86dn+54KKHSxg1bLCQkv7oaiksW7QuYM4P4vE8gFOpRVdfIDym6gd
         NGC3kEbZW6HQpwE3sUiGXMN1Dg5if0ZMmbFrh1g6WFB8sqpdGIeiLXkzfHH4oKiCu7SU
         bcD3n3gqSb+oTZ+vYSLSS91XIB+SscAC+MY+9sDMEuJxPUUUZ12FpkYHcZ5lSqLos3zr
         AW/Q==
X-Gm-Message-State: AOJu0YyaEK9I21eixMMjxqRfcYCJKILkfC2hagIegeBsHboFBZft07Za
	k/f9D3u+mXPIUGf0ap2APboPF4zQDrMxsTrjzJY7QUKyELEjwIcaqOS+12U04h47
X-Gm-Gg: AZuq6aIHOcDDE3JsQWdnKCylK0hq4GDUgmlxR5Uq1DRpz77ZfRn8WtzcPZbpbxJkzSb
	FzUmNLaI6PV/U2fTSf1ZPJRoN4vE5iO0QhnRilbQSMm0CrFGW5JV9McOTJ7htt78kczQYYlIep7
	u8TnbvcGtJT7gSQVVbJ/+LD9wR342f+UfzAzs3QB+RnlzPzH4Gf5wFOhMnQ4FUQh14u2AEqra5P
	fCFtnVerFP/ALjvmv/HAs4cOatUUMaye56NoudRNNSwbNfnL26lbg77pYHqnoN35VNJeX9UE24I
	F5xXArQjvIU1769yJ10DFtGAdhCOzlIDYluO9dW0xa46vUJS66PA7noNqK9RmdfXvk8ojnQI5++
	4XDtfCAytXPuPWct6BStGYBlSpv9Jm9xfoeWDCwaAU4X1Dp95f5p5yzzqfXSF0bzMYMwUMmllDM
	F3n2pRreXZdo0z8Q524kAGWCI1l/6mk3Eq+0vsu9a8gfrLCLxDZiQqGWChk8Hj7ocqRQ9iFRkL4
	EHGqV2PY4+rqTPFnDWy7kwSv8w8EwBAslGHXfNBLsVf1gBUVbyK3nLV4nr9FeAP40WYGjGqfBAy
	cIYB
X-Received: by 2002:a05:7022:2218:b0:11a:2e9c:1130 with SMTP id a92af1059eb24-125c0f7e485mr2115357c88.7.1769824844531;
        Fri, 30 Jan 2026 18:00:44 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm12502910c88.16.2026.01.30.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:00:44 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: remove unnecessary module_init/exit functions
Date: Fri, 30 Jan 2026 18:00:38 -0800
Message-ID: <20260131020039.45966-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three MMC drivers have unnecessary module_init and module_exit functions
that are empty or just print a message. Remove them. Note that if a
module_init function exists, a module_exit function must also exist;
otherwise, the module cannot be unloaded.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/mmc/host/dw_mmc.c      | 13 -------------
 drivers/mmc/host/sdhci-pltfm.c | 13 -------------
 drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9e74b675e92d..613d74d2e946 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3693,19 +3693,6 @@ int dw_mci_runtime_resume(struct device *dev)
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 #endif /* CONFIG_PM */
 
-static int __init dw_mci_init(void)
-{
-	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
-	return 0;
-}
-
-static void __exit dw_mci_exit(void)
-{
-}
-
-module_init(dw_mci_init);
-module_exit(dw_mci_exit);
-
 MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
 MODULE_AUTHOR("NXP Semiconductor VietNam");
 MODULE_AUTHOR("Imagination Technologies Ltd");
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7f6ac636f040..d4fb60c1ef69 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -215,19 +215,6 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
 };
 EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
 
-static int __init sdhci_pltfm_drv_init(void)
-{
-	pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
-
-	return 0;
-}
-module_init(sdhci_pltfm_drv_init);
-
-static void __exit sdhci_pltfm_drv_exit(void)
-{
-}
-module_exit(sdhci_pltfm_drv_exit);
-
 MODULE_DESCRIPTION("SDHCI platform and OF driver helper");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c459a08d01da..41e49c6cc751 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1126,7 +1126,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 
 /*****************************************************************************\
  *                                                                           *
- * Driver init/exit                                                          *
+ * Driver init                                                               *
  *                                                                           *
 \*****************************************************************************/
 
@@ -1138,17 +1138,6 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 	return 0;
 }
 
-static int __init sdhci_uhs2_mod_init(void)
-{
-	return 0;
-}
-module_init(sdhci_uhs2_mod_init);
-
-static void __exit sdhci_uhs2_mod_exit(void)
-{
-}
-module_exit(sdhci_uhs2_mod_exit);
-
 /*****************************************************************************\
  *
  * Device allocation/registration                                            *
-- 
2.43.0

