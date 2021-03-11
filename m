Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A5C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 08:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0865F64F9F
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 08:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCKIg2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhCKIg1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 03:36:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB2C061574;
        Thu, 11 Mar 2021 00:36:27 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lr13so44491520ejb.8;
        Thu, 11 Mar 2021 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4e7sXMmeGlkbOCFeyCBbwWaGqDoFKONJA2VE4Vop7GA=;
        b=vW+EPE/57UpxlneBXe/dkPRkxkVBaGhlpGq+rqtMNgfByNLF7dA2uencwI3q9e8UQf
         8K9LHMSkbOswP6nkq19+Qc02cl8a7TK9XJ/Ubphg58HUGrTIi4eQmM14H54pa5L7aiip
         gO0ciUsnL4flfl0jDZVQL6sGsvqpgKR71ZXe1PWeWp2tj5rSvkzypu3xHNuc92ORqXJi
         swRyn1qBkO2vSiquQZdCHysrg8SgPEGA+rGcqph37CXcG0ArXF3jB39bHjnZpbm0WssT
         LeQP4BDy6pRFI65RBM0lGdgbYB7pznQB+H7d5OLT2MqmK1DOeaccWf8Z6xACewQrr5zS
         pVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4e7sXMmeGlkbOCFeyCBbwWaGqDoFKONJA2VE4Vop7GA=;
        b=HLJttcyNUPVp/hoqPzDWl++k6jl25kmzoJSGnVKqZJzkop+JI34AjKXlWvv9O+SsLB
         BMJQYXlt/v3PK9s/S86DPudnhqH/xAhG0xiqRmsO/EvhKIh9zsdItlq9FIyH9eGZFrqO
         PdfqIlsp+rGI28KUeX/BTIwfLenOaEvhwbDPdV58+mi7rfhSHmYCD508yi3K81PhhhBy
         jtKt5DpQDgByJlYKDg0omQDYUf0iGwaEos3X/XSXhPr4a0RT+W3fGeqE8Zd6RBQH1m9K
         Xn/xP6JFvecySa9QpNrB48dmuk/pEFQWXD6Xf+yaAhoCbWCloArYzBsVOBxcJdNHTQgt
         N91g==
X-Gm-Message-State: AOAM530q7mn63PwRYuZTi+oZzBHfAZOOOQz+8bRBirsTy1ZWlJMcxMxs
        ScV/V7OTdmOmf+V1URPMaW4qxze49fjXXw==
X-Google-Smtp-Source: ABdhPJwKGU2fifk8t90VNAPoQ3Sr+fZqxZzLkpMelsMul50GTnuIkERlBSx++ZKyfcKsqp3AprQagQ==
X-Received: by 2002:a17:907:76b6:: with SMTP id jw22mr2004006ejc.11.1615451785723;
        Thu, 11 Mar 2021 00:36:25 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 11sm890428ejv.101.2021.03.11.00.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 00:36:25 -0800 (PST)
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: add rockchip platform
 support
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <1615443684-198078-1-git-send-email-shawn.lin@rock-chips.com>
 <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <5a08f1da-6f8a-35fa-4718-07a6aaeeb526@gmail.com>
Date:   Thu, 11 Mar 2021 09:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1615443684-198078-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

Some comments. Have a look if useful or that you disagee with.

The compatibility string was changed.
Then change the driver from platform to Soc focus too.

On 3/11/21 7:21 AM, Shawn Lin wrote:
> sdhci based synopsys MMC IP is also used on some rockchip platforms,
> so add a basic support here.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Remove ack, because things will change in version 5.
In need for a new review.

> ---
> 
> Changes in v4:
> - add comments for disabling rx invert
> - add tag from Adrian
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 225 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 218 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 59d8d96..dabc1ec 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -9,9 +9,11 @@
>  
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>

>  #include <linux/of.h>
> +#include <linux/of_device.h>

sort includes

>  #include <linux/sizes.h>
>  
>  #include "sdhci-pltfm.h"
> @@ -21,11 +23,43 @@
>  /* DWCMSHC specific Mode Select value */
>  #define DWCMSHC_CTRL_HS400		0x7
>  
> +/* Rockchip specific Registers */
> +#define DWCMSHC_HOST_CTRL3		0x508
> +#define DWCMSHC_EMMC_CONTROL		0x52c
> +#define DWCMSHC_EMMC_ATCTRL		0x540
> +#define DWCMSHC_EMMC_DLL_CTRL		0x800
> +#define DWCMSHC_EMMC_DLL_RXCLK		0x804
> +#define DWCMSHC_EMMC_DLL_TXCLK		0x808
> +#define DWCMSHC_EMMC_DLL_STRBIN		0x80c
> +#define DWCMSHC_EMMC_DLL_STATUS0	0x840
> +#define DWCMSHC_EMMC_DLL_START		BIT(0)
> +#define DWCMSHC_EMMC_DLL_RXCLK_SRCSEL	29
> +#define DWCMSHC_EMMC_DLL_START_POINT	16
> +#define DWCMSHC_EMMC_DLL_INC		8
> +#define DWCMSHC_EMMC_DLL_DLYENA		BIT(27)
> +#define DLL_TXCLK_TAPNUM_DEFAULT	0x8
> +#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
> +#define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
> +#define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
> +#define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
> +#define DWCMSHC_EMMC_DLL_TIMEOUT	BIT(9)
> +#define DLL_RXCLK_NO_INVERTER		1
> +#define DLL_RXCLK_INVERTER		0
> +#define DWCMSHC_ENHANCED_STROBE		BIT(8)
> +#define DLL_LOCK_WO_TMOUT(x) \
> +	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
> +	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))

> +#define ROCKCHIP_MAX_CLKS		3

#define RK3568_MAX_CLKS		3

> +
>  #define BOUNDARY_OK(addr, len) \
>  	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>  

>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;

      void *priv; ?? pointer to SoC private stuff ??

Please advise how private stuff of multiple SoCs should be stored.
Structures should be expandable.

}

common private stuff

  struct rk3568_priv {
> +
> +	/* Rockchip specified optional clocks */
> +	struct clk_bulk_data rockchip_clks[ROCKCHIP_MAX_CLKS];

RK3568_MAX_CLKS

> +	u8 txclk_tapnum;
>  };

rk3568 private stuff

>  
>  /*
> @@ -100,6 +134,102 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  }
>  

> +static void dwcmshc_rk_hs400_enhanced_strobe(struct mmc_host *mmc,

static void dwcmshc_rk3568_hs400_enhanced_strobe(struct mmc_host *mmc,

> +					     struct mmc_ios *ios)
> +{
> +	u32 vendor;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	vendor = sdhci_readl(host, DWCMSHC_EMMC_CONTROL);
> +	if (ios->enhanced_strobe)
> +		vendor |= DWCMSHC_ENHANCED_STROBE;
> +	else
> +		vendor &= ~DWCMSHC_ENHANCED_STROBE;
> +
> +	sdhci_writel(host, vendor, DWCMSHC_EMMC_CONTROL);
> +}
> +

> +static void dwcmshc_rk_set_clock(struct sdhci_host *host, unsigned int clock)

static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned
int clock)

For FTRACE it is needed that all function names start with the same prefix.
Change from platform to Soc.

> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);

> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);

rk3568_priv

> +	u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +	u32 extra;
> +	int err;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	/*
> +	 * DO NOT TOUCH THIS SETTING. RX clk inverter unit is enabled
> +	 * by default, but it shouldn't be enabled. We should anyway
> +	 * disable it before issuing any cmds.
> +	 */
> +	extra = DWCMSHC_EMMC_DLL_DLYENA |
> +		DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> +
> +	if (clock == 0)
> +		return;
> +
> +	/* Rockchip platform only support 375KHz for identify mode */
> +	if (clock <= 400000)
> +		clock = 375000;
> +
> +	err = clk_set_rate(pltfm_host->clk, clock);
> +	if (err)
> +		dev_err(mmc_dev(host->mmc), "fail to set clock %d", clock);
> +
> +	sdhci_set_clock(host, clock);
> +
> +	/* Disable cmd conflict check */
> +	extra = sdhci_readl(host, DWCMSHC_HOST_CTRL3);
> +	extra &= ~BIT(0);
> +	sdhci_writel(host, extra, DWCMSHC_HOST_CTRL3);
> +
> +	if (clock <= 400000) {
> +		/* Disable DLL to reset sample clock */
> +		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> +		return;
> +	}
> +
> +	/* Reset DLL */
> +	sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
> +	udelay(1);
> +	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
> +
> +	/* Init DLL settings */
> +	extra = 0x5 << DWCMSHC_EMMC_DLL_START_POINT |
> +		0x2 << DWCMSHC_EMMC_DLL_INC |
> +		DWCMSHC_EMMC_DLL_START;
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CTRL);
> +	err = readl_poll_timeout(host->ioaddr + DWCMSHC_EMMC_DLL_STATUS0,
> +				 extra, DLL_LOCK_WO_TMOUT(extra), 1,
> +				 500 * USEC_PER_MSEC);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
> +		return;
> +	}
> +
> +	extra = 0x1 << 16 | /* tune clock stop en */
> +		0x2 << 17 | /* pre-change delay */
> +		0x3 << 19;  /* post-change delay */
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_ATCTRL);
> +
> +	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
> +		txclk_tapnum = priv->txclk_tapnum;
> +
> +	extra = DWCMSHC_EMMC_DLL_DLYENA |
> +		DLL_TXCLK_TAPNUM_FROM_SW |
> +		txclk_tapnum;
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
> +
> +	extra = DWCMSHC_EMMC_DLL_DLYENA |
> +		DLL_STRBIN_TAPNUM_DEFAULT |
> +		DLL_STRBIN_TAPNUM_FROM_SW;
> +	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -109,21 +239,91 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  

> +static const struct sdhci_ops sdhci_dwcmshc_rk_ops = {

static const struct sdhci_ops rk3568-dwcmshc_ops = {

> +	.set_clock		= dwcmshc_rk_set_clock,

	.set_clock		= dwcmshc_rk3568_set_clock,

> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> +	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.reset			= sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  	.ops = &sdhci_dwcmshc_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  

> +static const struct sdhci_pltfm_data sdhci_dwcmshc_rk_pdata = {

static const struct sdhci_pltfm_data rk3568-dwcmshc_pdata = {

> +	.ops = &sdhci_dwcmshc_rk_ops,

	.ops = &rk3568-dwcmshc_ops,

> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +};
> +

> +static int rockchip_pltf_init(struct sdhci_host *host, struct dwcmshc_priv *priv)

static int dwcmshc_rk3568_init(struct sdhci_host *host, struct
rk3568_priv *priv)

For FTRACE it is needed that all function names start with the same prefix.

> +{
> +	int err;
> +
> +	priv->rockchip_clks[0].id = "axi";
> +	priv->rockchip_clks[1].id = "block";
> +	priv->rockchip_clks[2].id = "timer";
> +	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), ROCKCHIP_MAX_CLKS,

RK3568_MAX_CLKS

> +					 priv->rockchip_clks);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);

RK3568_MAX_CLKS

> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +		return err;
> +	}
> +
> +	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> +				&priv->txclk_tapnum))
> +		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +
> +	/* Disable cmd conflict check */
> +	sdhci_writel(host, 0x0, DWCMSHC_HOST_CTRL3);
> +	/* Reset previous settings */
> +	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {


	{
		.compatible = "rockchip,rk3568-dwcmshc",
		.data = &rk3568-dwcmshc_pdata,
	},


Keep in sort order for if later other manufactures and SoCs are added.

> +	{
> +		.compatible = "snps,dwcmshc-sdhci",
> +		.data = &sdhci_dwcmshc_pdata,
> +	},

> +	{
> +		.compatible = "rockchip,dwcmshc-sdhci",
> +		.data = &sdhci_dwcmshc_rk_pdata,
> +	},

remove

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
>  static int dwcmshc_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;

>  	struct dwcmshc_priv *priv;
Separate common private and rk3568 private stuff.

> +	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra;
>  
> -	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +	pltfm_data = of_device_get_match_data(&pdev->dev);
> +	if (!pltfm_data) {
> +		dev_err(&pdev->dev, "Error: No device match data found\n");
> +		return -ENODEV;
> +	}
> +
> +	host = sdhci_pltfm_init(pdev, pltfm_data,
>  				sizeof(struct dwcmshc_priv));

fix common and private

>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> @@ -161,6 +361,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  

[..]

	pltfm_host = sdhci_priv(host);
	priv = sdhci_pltfm_priv(pltfm_host);

----

	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");

Maybe make this common private too?

	if (IS_ERR(pltfm_host->clk)) {
		err = PTR_ERR(pltfm_host->clk);
		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
		goto free_pltfm;
	}
	err = clk_prepare_enable(pltfm_host->clk);
	if (err)
		goto free_pltfm;

	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");

This is common private.

	if (!IS_ERR(priv->bus_clk))
		clk_prepare_enable(priv->bus_clk);


You are doing mixed private stuff in a common function.

----

	err = mmc_of_parse(host->mmc);
	if (err)
		goto err_clk;

	sdhci_get_of_property(pdev);

[..]

>  	host->mmc_host_ops.request = dwcmshc_request;
>  
> +	if (pltfm_data == &sdhci_dwcmshc_rk_pdata) {

	if (pltfm_data == &rk3568-dwcmshc_pdata) {

> +		host->mmc_host_ops.hs400_enhanced_strobe =
> +			dwcmshc_rk_hs400_enhanced_strobe;

dwcmshc_rk3568_hs400_enhanced_strobe;

> +

> +		err = rockchip_pltf_init(host, priv);

		err = dwcmshc_rk3568_init(host, priv);




> +		if (err)
> +			goto err_clk;
> +	}
> +
>  	err = sdhci_add_host(host);
>  	if (err)
>  		goto err_clk;
> @@ -170,6 +379,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:

>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> +	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);

dito
keep private stuff separate.
RK3568_MAX_CLKS

>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -185,6 +395,7 @@ static int dwcmshc_remove(struct platform_device *pdev)
>  

>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);

> +	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);

dito
only rk3568
RK3568_MAX_CLKS

>  
>  	sdhci_pltfm_free(pdev);
>  
> @@ -207,6 +418,8 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
>  

> +	clk_bulk_disable_unprepare(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +

dito
RK3568_MAX_CLKS

>  	return ret;
>  }
>  
> @@ -227,18 +440,16 @@ static int dwcmshc_resume(struct device *dev)
>  			return ret;
>  	}
>  
> +	ret = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +	if (ret)
> +		return ret;
> +

dito
RK3568_MAX_CLKS

>  	return sdhci_resume_host(host);
>  }
>  #endif
>  
>  static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
>  
> -static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> -	{ .compatible = "snps,dwcmshc-sdhci" },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> -
>  static struct platform_driver sdhci_dwcmshc_driver = {
>  	.driver	= {
>  		.name	= "sdhci-dwcmshc",
> 

