Return-Path: <SRS0=dEAU=3X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0570C3524D
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915E120661
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 11:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgBCLcO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:32:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:54615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgBCLcN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Feb 2020 06:32:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 03:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,397,1574150400"; 
   d="scan'208";a="225138954"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2020 03:32:10 -0800
Subject: Re: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
To:     Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com>
Date:   Mon, 3 Feb 2020 13:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/01/20 12:21 pm, Manish Narani wrote:
> This patch removes quirk which indicates a broken base clock. This was
> making the kernel report wrong base clock of ~187MHz instead of 200MHz
> even as the measurement on the hardware was showing 200MHz.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> State: pending

Huh?

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 39176ab5ca1f..0146d7dd315b 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -358,6 +358,17 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
>  	.pdata = &sdhci_arasan_pdata,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
> +	.ops = &sdhci_arasan_ops,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +			SDHCI_QUIRK2_STOP_WITH_TC,
> +};
> +
> +static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
> +	.pdata = &sdhci_arasan_zynqmp_pdata,
> +};
> +
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	int cmd_error = 0;
> @@ -553,7 +564,7 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  	},
>  	{
>  		.compatible = "xlnx,zynqmp-8.9a",
> -		.data = &sdhci_arasan_data,
> +		.data = &sdhci_arasan_zynqmp_data,
>  	},
>  	{ /* sentinel */ }
>  };
> 

