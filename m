Return-Path: <SRS0=dEAU=3X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD2C33CAC
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F1F2084E
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 11:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBCLca (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:32:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:6727 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgBCLca (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Feb 2020 06:32:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 03:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,397,1574150400"; 
   d="scan'208";a="225138976"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2020 03:32:27 -0800
Subject: Re: [PATCH 3/4] mmc: sdhci-of-arasan: Add support for DLL reset for
 ZynqMP platforms
To:     Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-4-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <08d85f87-6180-2e59-5d71-d916a0e44603@intel.com>
Date:   Mon, 3 Feb 2020 13:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579602095-30060-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/01/20 12:21 pm, Manish Narani wrote:
> The DLL resets are required while executing the auto tuning procedure in
> ZynqMP. This patch adds code to support the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e49b44b4d82e..39176ab5ca1f 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -757,6 +757,50 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
>  	.set_phase = sdhci_zynqmp_sampleclk_set_phase,
>  };
>  
> +static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	struct sdhci_arasan_zynqmp_clk_data *zynqmp_clk_data =
> +		sdhci_arasan->clk_data.clk_of_data;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_clk_data->eemi_ops;
> +	u16 clk;
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Issue DLL Reset */
> +	eemi_ops->ioctl(deviceid, IOCTL_SD_DLL_RESET,
> +			PM_DLL_RESET_PULSE, 0, NULL);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	sdhci_enable_clk(host, clk);
> +}
> +
> +static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	struct clk_hw *hw = &sdhci_arasan->clk_data.sdcardclk_hw;
> +	const char *clk_name = clk_hw_get_name(hw);
> +	u32 device_id = !strcmp(clk_name, "clk_out_sd0") ? NODE_SD_0 :
> +							   NODE_SD_1;
> +	int err;
> +
> +	arasan_zynqmp_dll_reset(host, device_id);
> +
> +	err = sdhci_execute_tuning(mmc, opcode);
> +	if (err)
> +		return err;
> +
> +	arasan_zynqmp_dll_reset(host, device_id);
> +
> +	return 0;
> +}
> +
>  /**
>   * sdhci_arasan_update_clockmultiplier - Set corecfg_clockmultiplier
>   *
> @@ -1247,6 +1291,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  		zynqmp_clk_data->eemi_ops = eemi_ops;
>  		sdhci_arasan->clk_data.clk_of_data = zynqmp_clk_data;
> +		host->mmc_host_ops.execute_tuning =
> +			arasan_zynqmp_execute_tuning;
>  	}
>  
>  	arasan_dt_parse_clk_phases(&pdev->dev, &sdhci_arasan->clk_data);
> 

