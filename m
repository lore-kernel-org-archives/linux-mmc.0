Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997D7C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9DE207C3
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHUOGY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:06:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:43263 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgHUOGX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:06:23 -0400
IronPort-SDR: kTm8tyVv1azRFqJHpbIdLS/Vxi3OZw59+Q0vaqXFRdFeptESV0i5E4AlrpPmBIKOxXI9UDOD1K
 O6qSkdxt6bdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="155522616"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="155522616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:06:22 -0700
IronPort-SDR: rA429/SPs+UYJIgosgfn1chovOBAF2J3Nx71RaEKWuF3Jj+LSgHoW3KsSIV851Cjadyf4Quf2R
 0cTgAeoYvXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="297952071"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2020 07:06:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 11/21] mmc: sdhci: UHS-II support, export host
 operations to core
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111044.29509-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5f3dc200-b9ef-a678-25b7-3bff3a529703@intel.com>
Date:   Fri, 21 Aug 2020 17:05:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111044.29509-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/20 2:10 pm, Ben Chuang wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Export sdhci-specific UHS-II operations to core.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 70 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c2f6923d296c..aaf41954511a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2977,6 +2977,70 @@ static void sdhci_card_event(struct mmc_host *mmc)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> +static int sdhci_uhs2_detect_init(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret;
> +
> +	if (sdhci_uhs2_ops.do_detect_init)
> +		ret = sdhci_uhs2_ops.do_detect_init(host);
> +	else
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret;
> +
> +	if (sdhci_uhs2_ops.do_set_reg)
> +		ret = sdhci_uhs2_ops.do_set_reg(host, act);
> +	else
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ktime_t timeout;
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		if (clk & SDHCI_CLOCK_INT_STABLE)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +#endif /* CONFIG_MMC_SDHCI_UHS2 */

Please put all uhs2 functions in sdhci-uhs2.c and call them through sdhci_ops.

> +
>  static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.post_req	= sdhci_post_req,
> @@ -2992,6 +3056,12 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.execute_tuning			= sdhci_execute_tuning,
>  	.card_event			= sdhci_card_event,
>  	.card_busy	= sdhci_card_busy,
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> +	.uhs2_detect_init	= sdhci_uhs2_detect_init,
> +	.uhs2_set_reg		= sdhci_uhs2_set_reg,
> +	.uhs2_disable_clk	= sdhci_uhs2_disable_clk,
> +	.uhs2_enable_clk	= sdhci_uhs2_enable_clk,
> +#endif /* CONFIG_MMC_SDHCI_UHS2 */
>  };
>  
>  /*****************************************************************************\
> 

