Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394D361664;
	Mon,  9 Mar 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048215; cv=none; b=P85i06L0iygibaqPT/fgZ6HtrEzB0r1FOQPVHfDm4z5uEB4OX8hd8TCL/6FJX+8Zfd0GWAil/dTo8kjSZyKuZIAvMSuiJjdLU0xJF/F3s928108gkgvpx6SAlHqfFDbysTfuXkDGxPbftk+M5PHQ/EezNaEN6+PulD0aqL7R7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048215; c=relaxed/simple;
	bh=HdpYv+AK/YGT3wtX9pT1P3XlHW6w2YeAT+IqCsoGv0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxhjeZLhkJnno7x0LZTAnOopmEjI6ExDTm7BdXSu+QgCNfUsfmK9icocHMpJ7I2X919u8oinOYUtg5PElruKICjIc42kbAxInjlWRzMIlfCuF9X+F12I9xOH9l8YT0limSHiOX9BXLTkYe9YPoGlm+TJJb05gj7spAHGW2zITzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVoNSA6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVoNSA6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC431C4CEF7;
	Mon,  9 Mar 2026 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773048214;
	bh=HdpYv+AK/YGT3wtX9pT1P3XlHW6w2YeAT+IqCsoGv0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hVoNSA6VbeUuOvEG/YRgGoQiIZ14lpU77V6B1mvJhk/nFVFKx9hcsVlGxBF2N/gwf
	 xc2YpBcFA0BeItIW0YP1PQano5iDKE84YGZ8/Ki+izwCfu98+Pnqrolkv4SjPKT15v
	 mXIv6Nf4GrhBbpMA/3JHI81W+mDbkShlX0ApQaoI+i1P/QpU4W3JwzBVToVDPOb5Cd
	 CrF1FcH3OGqlAleb8yIczwiMoM8y9nDA05Si4T9Qz65xRwWIVe6E+k1itqqzUm+KEZ
	 tychkPaNiQlcquXMPOY0uANFx5DKElbbLnh92GcRPqy98Dr/rZhkzK+E2j1javF4Ry
	 w+UNDjKzdUAfg==
From: Thomas Gleixner <tglx@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, s32@nxp.com, Christophe Lizzi
 <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo
 <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>, Ciprian Marian
 Costea <ciprianmarian.costea@oss.nxp.com>, Larisa Grigore
 <larisa.grigore@nxp.com>
Subject: Re: [PATCH v4 5/8] irqchip/imx-irqsteer: add NXP S32N79 support
In-Reply-To: <20260306161555.9000-6-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-6-ciprianmarian.costea@oss.nxp.com>
Date: Mon, 09 Mar 2026 10:23:31 +0100
Message-ID: <87jyvls6ek.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 06 2026 at 17:15, Ciprian Costea wrote:
> +/* SoC does not implement the CHANCTRL register */
> +#define IRQSTEER_QUIRK_NO_CHANCTRL	BIT(0)
> +
> +struct irqsteer_devtype_data {
> +	u32 quirks;
> +};
> +
>  struct irqsteer_data {
>  	void __iomem		*regs;
>  	struct clk		*ipg_clk;
> @@ -37,8 +44,22 @@ struct irqsteer_data {
>  	struct irq_domain	*domain;
>  	u32			*saved_reg;
>  	struct device		*dev;
> +	const struct irqsteer_devtype_data *devtype_data;

The struct was perfectly tabular formatted before....

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

>  };
>  
> +static const struct irqsteer_devtype_data imx_data = {
> +	.quirks = 0,
> +};
> +
> +static const struct irqsteer_devtype_data s32n79_data = {
> +	.quirks = IRQSTEER_QUIRK_NO_CHANCTRL,
> +};
> +
> +static bool irqsteer_has_chanctrl(const struct irqsteer_devtype_data *data)
> +{
> +	return !(data->quirks & IRQSTEER_QUIRK_NO_CHANCTRL);
> +}
> +
>  static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
>  				      unsigned long irqnum)
>  {
> @@ -188,6 +209,10 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	data->devtype_data = device_get_match_data(&pdev->dev);
> +	if (!data->devtype_data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				"failed to match device data\n");

No point for this line break. You have 100 characters. If you have the
line break, then this needs curly brackets. See the bracket rules in the
above linked document.

>  static const struct of_device_id imx_irqsteer_dt_ids[] = {
> -	{ .compatible = "fsl,imx-irqsteer", },
> +	{ .compatible = "fsl,imx-irqsteer", .data = &imx_data },
> +	{ .compatible = "nxp,s32n79-irqsteer", .data = &s32n79_data },

Tabular layout please for readability sake.

Thanks,

        tglx
