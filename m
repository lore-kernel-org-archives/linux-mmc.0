From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
Date: Sat, 30 Sep 2017 10:41:09 +0800
Message-ID: <20170930104109.60853202@xhacker.debian>
References: <20170929130435.6805-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:7872
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752578AbdI3Cle (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Sep 2017 22:41:34 -0400
In-Reply-To: <20170929130435.6805-1-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hi Gregory,

On Fri, 29 Sep 2017 15:04:35 +0200 Gregory CLEMENT wrote:

> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Without this patch the kernel hand during boot if the mvpp2.2 network
> driver was not present in the kernel. Indeed the clock needed by the
> xenon controller was set by the network driver.
> 
> Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core
> functionality)"
> CC: Stable <stable@vger.kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

<snip>

> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 2eec2e652c53..15f912d08a4c 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -466,6 +466,7 @@ static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> +	struct xenon_priv *priv;
>  	int err;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
> @@ -474,6 +475,7 @@ static int xenon_probe(struct platform_device *pdev)
>  		return PTR_ERR(host);
>  
>  	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  
>  	/*
>  	 * Link Xenon specific mmc_host_ops function,
> @@ -491,9 +493,21 @@ static int xenon_probe(struct platform_device *pdev)
>  	if (err)
>  		goto free_pltfm;
>  
> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> +	if (IS_ERR(priv->axi_clk)) {
> +		err = PTR_ERR(priv->axi_clk);
> +		if (err == -EPROBE_DEFER)
> +			goto err_clk;
> +		priv->axi_clk = NULL;

IMHO, this assignment could be removed. What do you think?

Thanks
