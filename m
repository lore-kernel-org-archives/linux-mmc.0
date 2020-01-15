Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B9C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82232084D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAONNQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:13:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:5833 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONNP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 08:13:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 05:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="256769818"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 05:13:14 -0800
Subject: Re: [PATCH 2/3] mmc: sdhci_am654: Reset Command and Data line after
 tuning
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20200108143301.1929-1-faiz_abbas@ti.com>
 <20200108143301.1929-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1431a5a3-cc17-b03b-1f94-3e4290f3ce7d@intel.com>
Date:   Wed, 15 Jan 2020 15:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108143301.1929-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 4:33 pm, Faiz Abbas wrote:
> The tuning data is leftover in the buffer after tuning. This can cause
> issues in future data commands, especially with CQHCI. Reset the command
> and data lines after tuning to continue from a clean state.
> 
> Fixes: 41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 2d38b1e12a7e..59c0c41b3739 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -240,6 +240,22 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  	writeb(val, host->ioaddr + reg);
>  }
>  
> +static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int err = sdhci_execute_tuning(mmc, opcode);
> +
> +	if (err)
> +		return err;
> +	/*
> +	 * Tuning data remains in the buffer after tuning.
> +	 * Do a command and data reset to get rid of it
> +	 */
> +	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +	return 0;
> +}
> +
>  static struct sdhci_ops sdhci_am654_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -546,6 +562,8 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto pm_runtime_put;
>  	}
>  
> +	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
> +
>  	ret = sdhci_am654_init(host);
>  	if (ret)
>  		goto pm_runtime_put;
> 

