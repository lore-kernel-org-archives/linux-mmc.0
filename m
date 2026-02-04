Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FC3B5315;
	Wed,  4 Feb 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198233; cv=pass; b=dpYqLiFvV9+0fdSUFtQQs7kIcm4eQbhhUOevcX/iVduBlvVjAZRUSBPO7yKLvuywS8zjDIqd9WpTSfeAJylofiwpSGbl6CBu9U31IhsfBd48puOSJCF91XCo2YNnV/2cbCRoEw1WGYxtI3YM9Ht3ezto8RGKP1fJCPn+CU+8Iww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198233; c=relaxed/simple;
	bh=YT14e5OvBVI3H3FuEBE0sEtRW6b3uficAw6zfPl105s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvXteE/nb7j5OvFHDmKsjvcbgDU2pIBRa5Tcq/tFlT8rwbbItI7eB32s2GdqJg8KURDdzJ9jEUgGOlIg/ooN3cb2rQUh9KBTHLBJHO20ZZBAG/iJwKqvOZA7IHdILipvJhL0mho5z0rjNFcQAbJC30NkXFWiT0J9/+ySOvnVG18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=cCYr1Afk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="cCYr1Afk"
ARC-Seal: i=1; a=rsa-sha256; t=1770198211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=He/AJn2ull9BtmEg+hw/Hybv0lttxljRsN0kZndzWazc2Df2nfTbpnMPfslRB/TjXwiQo0kXPu9hX/aTZY5Pdi0/Gj5MD7yP4H0xCQCYI9Yi/rl0bSUx8/0Y671B0CK6Xx/hxbfBrTei9KR30ypGvmdyj+zwMpAKBV8M+szQylY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770198211; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SUFCyq+gCiZFk0TJKSu+lUgs8x/dwNpXwyQ1mknE6CA=; 
	b=WW6jYHfImUuY38SBnj/5V3n+rT53b4VcBFW4xbqhdxTlLebYBHu0fpf1SQYy+wOlLiOzWVdg0jqPm0bwqKgeJOirgvzfOSOA2w+5Y5DGiitGU77nx5BF6QJ675MDzw35i9Y34d9cnHPZOhBmTTitUHNLn9EDe9o+7wWwCe9lBUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770198211;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=SUFCyq+gCiZFk0TJKSu+lUgs8x/dwNpXwyQ1mknE6CA=;
	b=cCYr1AfkRa5qq2cmKMTHqwtQVxusCMQpaM64N9q0piXmrVEukvs7o/ZwI40SEHfL
	pjEyIQcbXWfdWWSFeY7GtOz8qHcjnoe7KWw55XHahrOcOcOl0Xxy3FRWRV5TJaxw2Gm
	cP83fZtxQ+dJ2jq/uQ1a5WfMzosxvy3f2c5ZJMqA=
Received: by mx.zohomail.com with SMTPS id 1770198208851372.4656749723831;
	Wed, 4 Feb 2026 01:43:28 -0800 (PST)
Date: Wed, 4 Feb 2026 09:43:03 +0000
From: Yao Zi <me@ziyao.cc>
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>, ulf.hansson@linaro.org,
	adrian.hunter@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn
Subject: Re: [PATCH 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
Message-ID: <aYMUp6maC70zDrAP@pie>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204082908.27501-3-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204082908.27501-3-jiayu.riscv@isrc.iscas.ac.cn>
X-ZohoMailClient: External

On Wed, Feb 04, 2026 at 04:29:07PM +0800, Jiayu Du wrote:
> Add SDHCI controller driver for Canaan k230 SoC. Implement custom
> sdhci_ops for set_clock, phy init, init and reset.
> 
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 247 ++++++++++++++++++++++++++++
>  1 file changed, 247 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 204830b40587..bc427bfbba25 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c

...

> +static void dwcmshc_k230_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	sdhci_set_clock(host, clock);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_PROG_CLOCK_MODE;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

Why it's necessary to always set SDHCI_PROG_CLOCK_MODE? If it's a vendor
quirk, it deserves a comment to explain what's happening here.

> +}

...

> +static int dwcmshc_k230_phy_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 rxsel = PHY_PAD_RXSEL_3V3;
> +	unsigned int timeout = 15000;
> +	u32 val;
> +	u32 reg;
> +
> +	/* reset phy */
> +	sdhci_writew(host, 0, PHY_CNFG_R);
> +
> +	/* Disable the clock */
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (priv->flags & FLAG_IO_FIXED_1V8)
> +		rxsel = PHY_PAD_RXSEL_1V8;

This may be a little nitpick, but the logic looks cleaner to me if you
do

	rxsel = priv->flags & FLAG_IO_FIXED_1V8 ?
			PHY_PAD_RXSEL_1V8 : PHY_PAD_RXSEL_3V3;

...

> +	/* Wait max 150 ms */
> +	while (1) {
> +		reg = sdhci_readl(host, PHY_CNFG_R);
> +		if (reg & FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1))
> +			break;
> +		if (!timeout)
> +			return -ETIMEDOUT;
> +		timeout--;
> +		usleep_range(10, 15);
> +	}

You could use readx_poll_timeout() with sdhci_readl() to simplify this
loop.

> +	reg = FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN_k230) |
> +	      FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP_k230);
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	/* de-assert the phy */
> +	reg |= PHY_CNFG_RSTN_DEASSERT;
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	return 0;
> +}
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +			     struct dwcmshc_priv *dwc_priv)
> +{

...

> +	if (!usb_phy_node) {
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find k230-usb-phy node\n");
> +	}

Please drop the curly braces, if there's only one statement in the body
of an if, they're not necessary. This is also preferred in kernel coding
style,

> Do not unnecessarily use braces where a single statement will do.[1]

Same for branches below.

> +	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
> +	of_node_put(usb_phy_node);
> +	if (IS_ERR(k230_priv->hi_sys_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
> +				     "Failed to get k230-usb-phy regmap\n");
> +	}

...

> +	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;

Why not set it in sdhci_dwcmshc_k230_data.pdata.quirks?

> +	return 0;
> +}

...

> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_k230_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_k230_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	},
> +	.init = dwcmshc_k230_init,
> +};

Best regards,
Yao Zi

[1]: https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/process/coding-style.rst#L197
