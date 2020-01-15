Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0611C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F8A2084D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAONQp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:16:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:48309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONQp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 08:16:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 05:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="256770814"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 05:16:43 -0800
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Fix Command Queuing in AM65x
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20200108143301.1929-1-faiz_abbas@ti.com>
 <20200108143301.1929-4-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d15c1406-e92d-5822-5cd6-4e95e023b21d@intel.com>
Date:   Wed, 15 Jan 2020 15:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108143301.1929-4-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 4:33 pm, Faiz Abbas wrote:
> Command Queuing was enabled completely for J721e controllers which lead
> to partial enablement even for Am65x. Complete CQ implementation for
> AM65x by adding the irq callback.
> 
> Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 59c0c41b3739..b8fe94fd9525 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -256,6 +256,19 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	return 0;
>  }
>  
> +static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
>  static struct sdhci_ops sdhci_am654_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -264,6 +277,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  	.set_power = sdhci_am654_set_power,
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
> +	.irq = sdhci_am654_cqhci_irq,
>  	.reset = sdhci_reset,
>  };
>  
> @@ -278,19 +292,6 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
>  	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
>  };
>  
> -static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> -{
> -	int cmd_error = 0;
> -	int data_error = 0;
> -
> -	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> -		return intmask;
> -
> -	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> -
> -	return 0;
> -}
> -
>  static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> 

