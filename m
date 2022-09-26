Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548DEC32771
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIZTUw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIZTUu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:20:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5604BD29
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220042; x=1695756042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s8gI6C3jeyOYQweaaonVTPWiuQhB23UXuc+mOF1toBE=;
  b=LWAeNwxsC7TINiMyRUOgYhzGO8RjUkq2HXlpE8d155NOFTibrs+GTyGI
   DEmAe6Q2y7p6MYXihN6kU6xYqtccXjJ/mGHIn6aipLbZLB4/8FQnWj9vu
   S/i9xk+rXarav1DWWktLc8PpLzg/UPhy1//jqmQYqasz5a5RyI1lx6Rl7
   yGEG8TFLSr6vBhw3uqIazqh/3BCDzW46EBwoYbXvo/MU+X6/3N4uQEh9I
   Ij66lMWbSuYSUKc8JHlgoNxGrVissMJeybAwSupGRbj6lW1s/QawiiUX1
   wjW7JfcXhP9/uCP0PJhFVQ2Avak2C3SM0Fs0WF0DTNi2a6tUkUnMg5T6J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298717894"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298717894"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796455553"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796455553"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: [PATCH 1/4] mmc: sdhci: Separate out sdhci_reset_for_all()
Date:   Mon, 26 Sep 2022 22:20:19 +0300
Message-Id: <20220926192022.85660-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926192022.85660-1-adrian.hunter@intel.com>
References: <20220926192022.85660-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tidy sdhci_do_reset() slightly by separating out sdhci_reset_for_all()
which removes the need to test the mask in sdhci_do_reset().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22152029e14c..34b351363f41 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -232,23 +232,27 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
 
-static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
+static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
 
 		if (!mmc->ops->get_cd(mmc))
-			return;
+			return false;
 	}
 
 	host->ops->reset(host, mask);
 
-	if (mask & SDHCI_RESET_ALL) {
+	return true;
+}
+
+static void sdhci_reset_for_all(struct sdhci_host *host)
+{
+	if (sdhci_do_reset(host, SDHCI_RESET_ALL)) {
 		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 			if (host->ops->enable_dma)
 				host->ops->enable_dma(host);
 		}
-
 		/* Resetting the controller clears many */
 		host->preset_enabled = false;
 	}
@@ -324,7 +328,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	if (soft)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 	else
-		sdhci_do_reset(host, SDHCI_RESET_ALL);
+		sdhci_reset_for_all(host);
 
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
@@ -4037,7 +4041,7 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (debug_quirks2)
 		host->quirks2 = debug_quirks2;
 
-	sdhci_do_reset(host, SDHCI_RESET_ALL);
+	sdhci_reset_for_all(host);
 
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
@@ -4778,7 +4782,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 unled:
 	sdhci_led_unregister(host);
 unirq:
-	sdhci_do_reset(host, SDHCI_RESET_ALL);
+	sdhci_reset_for_all(host);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
@@ -4836,7 +4840,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	sdhci_led_unregister(host);
 
 	if (!dead)
-		sdhci_do_reset(host, SDHCI_RESET_ALL);
+		sdhci_reset_for_all(host);
 
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
-- 
2.25.1

