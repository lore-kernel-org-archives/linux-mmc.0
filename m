Return-Path: <SRS0=h+Av=2K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8511C43603
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53BD24682
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 07:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLTHqI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:46:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:55982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLTHqI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Dec 2019 02:46:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 23:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="416457411"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2019 23:46:06 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use
 esdhc_tuning_window_ptr()
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <de219a41-bf73-3d53-bdc0-c2c5c6ebfa32@intel.com>
Date:   Fri, 20 Dec 2019 09:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212075219.48625-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/12/19 9:52 am, Yangbo Lu wrote:
> Convert to use a new function esdhc_tuning_window_ptr() to
> get tuning window start point and end point.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7f87a90..cd0f21e 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -882,20 +882,11 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
>  	esdhc_clock_enable(host, true);
>  }
>  
> -static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
> +static void esdhc_tuning_window_ptr(struct sdhci_host *host, u8 *window_start,
>  				    u8 *window_end)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> -	u8 tbstat_15_8, tbstat_7_0;
>  	u32 val;
>  
> -	if (esdhc->quirk_tuning_erratum_type1) {
> -		*window_start = 5 * esdhc->div_ratio;
> -		*window_end = 3 * esdhc->div_ratio;
> -		return;
> -	}
> -
>  	/* Write TBCTL[11:8]=4'h8 */
>  	val = sdhci_readl(host, ESDHC_TBCTL);
>  	val &= ~(0xf << 8);
> @@ -914,6 +905,25 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>  	val = sdhci_readl(host, ESDHC_TBSTAT);
>  	val = sdhci_readl(host, ESDHC_TBSTAT);
>  
> +	*window_end = val & 0xff;
> +	*window_start = (val >> 8) & 0xff;
> +}
> +
> +static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
> +				    u8 *window_end)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> +	u8 start_ptr, end_ptr;
> +
> +	if (esdhc->quirk_tuning_erratum_type1) {
> +		*window_start = 5 * esdhc->div_ratio;
> +		*window_end = 3 * esdhc->div_ratio;
> +		return;
> +	}
> +
> +	esdhc_tuning_window_ptr(host, &start_ptr, &end_ptr);
> +
>  	/* Reset data lines by setting ESDHCCTL[RSTD] */
>  	sdhci_reset(host, SDHCI_RESET_DATA);
>  	/* Write 32'hFFFF_FFFF to IRQSTAT register */
> @@ -924,10 +934,8 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
>  	 * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
>  	 * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
>  	 */
> -	tbstat_7_0 = val & 0xff;
> -	tbstat_15_8 = (val >> 8) & 0xff;
>  
> -	if (abs(tbstat_15_8 - tbstat_7_0) > (4 * esdhc->div_ratio)) {
> +	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
>  		*window_start = 8 * esdhc->div_ratio;
>  		*window_end = 4 * esdhc->div_ratio;
>  	} else {
> 

