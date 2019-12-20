Return-Path: <SRS0=h+Av=2K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C84C43603
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E601227BF
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 07:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLTHrF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:47:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:34925 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfLTHrE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Dec 2019 02:47:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 23:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="416457547"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2019 23:47:02 -0800
Subject: Re: [PATCH 2/2] mmc: sdhci-of-esdhc: update tuning erratum A-008171
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
 <20191212075219.48625-2-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <885bec01-9f24-caf5-a5c4-4d3e60eba439@intel.com>
Date:   Fri, 20 Dec 2019 09:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212075219.48625-2-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/12/19 9:52 am, Yangbo Lu wrote:
> There is an official update for eSDHC tuning erratum A-008171.
> This patch is to implement the changes,
> - Affect all revisions of SoC.
> - Changes for tuning window checking.
> - Hardware hits a new condition that tuning succeeds although
>   the eSDHC might not have tuned properly for type2 SoCs
>   (soc_tuning_erratum_type2[] array in driver). So check
>   tuning window after tuning succeeds.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index cd0f21e..a99c000d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -848,20 +848,20 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
>  }
>  
>  static struct soc_device_attribute soc_tuning_erratum_type1[] = {
> -	{ .family = "QorIQ T1023", .revision = "1.0", },
> -	{ .family = "QorIQ T1040", .revision = "1.0", },
> -	{ .family = "QorIQ T2080", .revision = "1.0", },
> -	{ .family = "QorIQ LS1021A", .revision = "1.0", },
> +	{ .family = "QorIQ T1023", },
> +	{ .family = "QorIQ T1040", },
> +	{ .family = "QorIQ T2080", },
> +	{ .family = "QorIQ LS1021A", },
>  	{ },
>  };
>  
>  static struct soc_device_attribute soc_tuning_erratum_type2[] = {
> -	{ .family = "QorIQ LS1012A", .revision = "1.0", },
> -	{ .family = "QorIQ LS1043A", .revision = "1.*", },
> -	{ .family = "QorIQ LS1046A", .revision = "1.0", },
> -	{ .family = "QorIQ LS1080A", .revision = "1.0", },
> -	{ .family = "QorIQ LS2080A", .revision = "1.0", },
> -	{ .family = "QorIQ LA1575A", .revision = "1.0", },
> +	{ .family = "QorIQ LS1012A", },
> +	{ .family = "QorIQ LS1043A", },
> +	{ .family = "QorIQ LS1046A", },
> +	{ .family = "QorIQ LS1080A", },
> +	{ .family = "QorIQ LS2080A", },
> +	{ .family = "QorIQ LA1575A", },
>  	{ },
>  };
>  
> @@ -929,13 +929,13 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>  	/* Write 32'hFFFF_FFFF to IRQSTAT register */
>  	sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
>  
> -	/* If TBSTAT[15:8]-TBSTAT[7:0] > 4 * div_ratio
> -	 * or TBSTAT[7:0]-TBSTAT[15:8] > 4 * div_ratio,
> +	/* If TBSTAT[15:8]-TBSTAT[7:0] > (4 * div_ratio) + 2
> +	 * or TBSTAT[7:0]-TBSTAT[15:8] > (4 * div_ratio) + 2,
>  	 * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
>  	 * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
>  	 */
>  
> -	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
> +	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio + 2)) {
>  		*window_start = 8 * esdhc->div_ratio;
>  		*window_end = 4 * esdhc->div_ratio;
>  	} else {
> @@ -1008,6 +1008,19 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		if (ret)
>  			break;
>  
> +		/* For type2 affected platforms of the tuning erratum,
> +		 * tuning may succeed although eSDHC might not have
> +		 * tuned properly. Need to check tuning window.
> +		 */
> +		if (esdhc->quirk_tuning_erratum_type2 &&
> +		    !host->tuning_err) {
> +			esdhc_tuning_window_ptr(host, &window_start,
> +						&window_end);
> +			if (abs(window_start - window_end) >
> +			    (4 * esdhc->div_ratio + 2))
> +				host->tuning_err = -EAGAIN;
> +		}
> +
>  		/* If HW tuning fails and triggers erratum,
>  		 * try workaround.
>  		 */
> 

