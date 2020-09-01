Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934BC433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9A5206C0
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 10:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIAKyN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:54:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:47718 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKyN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 06:54:13 -0400
IronPort-SDR: amZBlG5XIPHsk7nZVt3SL1eQc82d5f1jOAoHH+lHOjo1+3k61aKS1cizuo43MJpMwIXVlJm95q
 mYZksf1BYnrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="157145789"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="157145789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 03:54:11 -0700
IronPort-SDR: MhyLawlSYFxgTjbp1pRehKmCFmZMsQDM3v493i2rX8H9uVSQQF9pJehotKlIdp0o3M5Mf8+MeX
 GD5P5YmgZHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="477150956"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2020 03:54:03 -0700
Subject: Re: [PATCH v2] mmc: sdhci: Don't enable presets while tuning
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Akshu.Agrawal@amd.com, Jisheng Zhang <jszhang@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20200824122131.v2.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <873b0786-a088-54af-80ad-96d2b041945d@intel.com>
Date:   Tue, 1 Sep 2020 13:53:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824122131.v2.1.Id6f3c92fecf4acc60c3b7f57d5f4e4c854ace765@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/20 9:21 pm, Raul E Rangel wrote:
> SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
> used for DDR52. The HS400 retuning sequence is:
> 
>     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> 
> This means that when HS400 tuning happens, we transition through DDR52
> for a very brief period. This causes presets to be enabled
> unintentionally and stay enabled when transitioning back to HS200 or
> HS400.
> 
> This patch prevents enabling presets while tuning is in progress.

Preset value should not generally have to depend on tuning, so this
seems less than ideal.  Also I am not sure you can say some controllers
are not accidentally benefiting from the current situation.

What about just letting drivers choose the timing modes that support
preset values?  e.g. using the change below, a driver could alter
host->preset_value_support as needed

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3ad394b40eb1..3e69c25c90a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2360,12 +2360,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->timing = ios->timing;
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
-				((ios->timing == MMC_TIMING_UHS_SDR12) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
-				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
-				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
-				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
+		    sdhci_preset_value_support(host, ios->timing)) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
@@ -3934,6 +3929,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	 */
 	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
 
+	host->preset_value_support = (1 << MMC_TIMING_UHS_SDR12 ) |
+				     (1 << MMC_TIMING_UHS_SDR25 ) |
+				     (1 << MMC_TIMING_UHS_SDR50 ) |
+				     (1 << MMC_TIMING_UHS_SDR104) |
+				     (1 << MMC_TIMING_UHS_DDR50 ) |
+				     (1 << MMC_TIMING_MMC_DDR52 );
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0770c036e2ff..79be471ff934 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -603,6 +603,9 @@ struct sdhci_host {
 	/* Host ADMA table count */
 	u32			adma_table_cnt;
 
+	/* Which transfer modes support preset value */
+	u32			preset_value_support;
+
 	u64			data_timeout;
 
 	unsigned long private[] ____cacheline_aligned;
@@ -760,6 +763,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+static inline bool sdhci_preset_value_support(struct sdhci_host *host,
+					      unsigned char timing)
+{
+	if (timing < 32)
+		return host->preset_value_support & (1 << timing);
+	return false;
+}
+
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);





> 
> Fixes: 0dafa60eb2506 ("mmc: sdhci: also get preset value and driver type for MMC_DDR52")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> The indentation changed because I ran clang-format
> 
> Changes in v2:
> - Fixed commit message. Patman didn't properly strip off the TEST= line.
> 
>  drivers/mmc/host/sdhci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 37b1158c1c0c9..fd702c436c165 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2360,12 +2360,13 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		host->timing = ios->timing;
>  
>  		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> -				((ios->timing == MMC_TIMING_UHS_SDR12) ||
> -				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
> -				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
> -				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
> +		    !mmc_doing_retune(mmc) &&
> +		    ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> +		     (ios->timing == MMC_TIMING_UHS_SDR25) ||
> +		     (ios->timing == MMC_TIMING_UHS_SDR50) ||
> +		     (ios->timing == MMC_TIMING_UHS_SDR104) ||
> +		     (ios->timing == MMC_TIMING_UHS_DDR50) ||
> +		     (ios->timing == MMC_TIMING_MMC_DDR52))) {
>  			u16 preset;
>  
>  			sdhci_enable_preset_value(host, true);
> 

