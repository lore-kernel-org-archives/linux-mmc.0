From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-st: Handle interconnect clock
Date: Thu, 8 Sep 2016 12:58:49 +0100
Message-ID: <20160908115849.GS4921@dell>
References: <20160908091136.17301-1-lee.jones@linaro.org>
 <20160908091136.17301-5-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37309 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758122AbcIHL5B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Sep 2016 07:57:01 -0400
Received: by mail-wm0-f50.google.com with SMTP id w12so84456483wmf.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Sep 2016 04:57:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160908091136.17301-5-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, patrice.chotard@st.com, peter.griffin@linaro.org, robh@kernel.org, adrian.hunter@intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, stable@vger.kernel.org, linux-mmc@vger.kernel.org

Sorry Adrian, left you of the list.  Rectifying.

FYI, this patch is due for the v4.8 -rcs:

  http://www.spinics.net/lists/kernel/msg2338219.html

> Some ST platforms contain interconnect (ICN) clocks which must be handed
> correctly in order to obtain full functionality of a given IP.  In this
> case, if the ICN clocks are not handled properly by the ST SDHCI driver
> MMC will break and the following output can be observed:
> 
>     [   13.916949] mmc0: Timeout waiting for hardware interrupt.
>     [   13.922349] sdhci: =========== REGISTER DUMP (mmc0)===========
>     [   13.928175] sdhci: Sys addr: 0x00000000 | Version:  0x00001002
>     [   13.933999] sdhci: Blk size: 0x00007040 | Blk cnt:  0x00000001
>     [   13.939825] sdhci: Argument: 0x00fffff0 | Trn mode: 0x00000013
>     [   13.945650] sdhci: Present:  0x1fff0206 | Host ctl: 0x00000011
>     [   13.951475] sdhci: Power:    0x0000000f | Blk gap:  0x00000080
>     [   13.957300] sdhci: Wake-up:  0x00000000 | Clock:    0x00003f07
>     [   13.963126] sdhci: Timeout:  0x00000004 | Int stat: 0x00000000
>     [   13.968952] sdhci: Int enab: 0x02ff008b | Sig enab: 0x02ff008b
>     [   13.974777] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>     [   13.980602] sdhci: Caps:     0x21ed3281 | Caps_1:   0x00000000
>     [   13.986428] sdhci: Cmd:      0x0000063a | Max curr: 0x00000000
>     [   13.992252] sdhci: Host ctl2: 0x00000000
>     [   13.996166] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x7c048200
>     [   14.001990] sdhci: ===========================================
>     [   14.009802] mmc0: Got data interrupt 0x02000000 even though no data operation was in progress.
> 
> A decent point was raised about minimising the use of a local variable that
> we 'could' do without.  I've chosen consistency over the possibility of
> reducing the local variable count by 1.  Thinking that it's more important
> for the code to be grouped and authoured in a similar manner/style for
> greater maintainability/readability.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mmc/host/sdhci-st.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index c95ba83..ed92ce7 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -28,6 +28,7 @@
>  
>  struct st_mmc_platform_data {
>  	struct  reset_control *rstc;
> +	struct  clk *icnclk;
>  	void __iomem *top_ioaddr;
>  };
>  
> @@ -353,7 +354,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct st_mmc_platform_data *pdata;
>  	struct sdhci_pltfm_host *pltfm_host;
> -	struct clk *clk;
> +	struct clk *clk, *icnclk;
>  	int ret = 0;
>  	u16 host_version;
>  	struct resource *res;
> @@ -365,6 +366,11 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  		return PTR_ERR(clk);
>  	}
>  
> +	/* ICN clock isn't compulsory, but use it if it's provided. */
> +	icnclk = devm_clk_get(&pdev->dev, "icn");
> +	if (IS_ERR(icnclk))
> +		icnclk = NULL;
> +
>  	rstc = devm_reset_control_get(&pdev->dev, NULL);
>  	if (IS_ERR(rstc))
>  		rstc = NULL;
> @@ -389,6 +395,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	}
>  
>  	clk_prepare_enable(clk);
> +	clk_prepare_enable(icnclk);
>  
>  	/* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -400,6 +407,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	}
>  
>  	pltfm_host->clk = clk;
> +	pdata->icnclk = icnclk;
>  
>  	/* Configure the Arasan HC inside the flashSS */
>  	st_mmcss_cconfig(np, host);
> @@ -422,6 +430,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_out:
> +	clk_disable_unprepare(icnclk);
>  	clk_disable_unprepare(clk);
>  err_of:
>  	sdhci_pltfm_free(pdev);
> @@ -442,6 +451,8 @@ static int sdhci_st_remove(struct platform_device *pdev)
>  
>  	ret = sdhci_pltfm_unregister(pdev);
>  
> +	clk_disable_unprepare(pdata->icnclk);
> +
>  	if (rstc)
>  		reset_control_assert(rstc);
>  
> @@ -462,6 +473,7 @@ static int sdhci_st_suspend(struct device *dev)
>  	if (pdata->rstc)
>  		reset_control_assert(pdata->rstc);
>  
> +	clk_disable_unprepare(pdata->icnclk);
>  	clk_disable_unprepare(pltfm_host->clk);
>  out:
>  	return ret;
> @@ -475,6 +487,7 @@ static int sdhci_st_resume(struct device *dev)
>  	struct device_node *np = dev->of_node;
>  
>  	clk_prepare_enable(pltfm_host->clk);
> +	clk_prepare_enable(pdata->icnclk);
>  
>  	if (pdata->rstc)
>  		reset_control_deassert(pdata->rstc);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
