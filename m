Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790035295C;
	Sat, 14 Mar 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483835; cv=none; b=XnMfpttODlmR4BJ4gWDBpDQ4Sg/G+mHjDIUNWijwYNlZpka/LgxROEQIqkr3yKzX2GPR6FMzTFv6Wz7WQ91COZmGmviMutl3SkROtMK+fnnBGaY8tkU9Snd82/ObuP8jah5uz4OrRlPZpaZ8dTq0biRcfcT5CiaqhfB13L2J9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483835; c=relaxed/simple;
	bh=9tW88wtC23Nu5H1ydEbU0qbXKKzXQG4pyrrMW/FnfBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgBlv0AmHwS8wKsDAmM6DQ/+29zh3i+9I39CWtcJGlLYkBIM04QBB/n6vjtrM9/YdBXKioRKl0amEXY34r/U2bY56oaV3dJmcQfE97Tu2BYf9t7n92+kqVmEM670PCFahK5JvyGfqPx1r8iB+g2T/Ugbu24LEAULcjx+ieCxhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQfZyiSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQfZyiSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDDCC116C6;
	Sat, 14 Mar 2026 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483834;
	bh=9tW88wtC23Nu5H1ydEbU0qbXKKzXQG4pyrrMW/FnfBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQfZyiSMrQ8sCNW+FgXGj8pS7B2I71bND85ID+aaX+dyaNsrK6Z2WF/Yzq8rtLc3z
	 lNaSGk7qEyKg8lTXtkndoebnJx74Dqadt3FXTYRtREm/THj6j5Avdy41R5Cxk2d1h3
	 mesHyl4ABmGIceuHiM7EXsWb9UPDGrFIRoTe5JMnsvzThU4FAdtKZKhgG9oECf5wiX
	 ulYn08uz4fXLtcA/kVRXmLW7ttkpPwe3ljwaMQEzlhicaKrmih08Kc6z8F3TqHuvTN
	 JWeKzyYRcIXCWoZHTqBB8VWbu1OTO4Q4TgOd2WBc6U3hzsQ9tTa1ZdBQ7wgdEUJaC1
	 51rErr4AXPbPA==
Date: Sat, 14 Mar 2026 11:23:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Message-ID: <20260314-flat-topaz-peacock-440a9c@quoll>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>

On Fri, Mar 13, 2026 at 01:27:57PM +0800, Ryan Chen wrote:
> Add support for the AST2700 SOC in the sd controller driver. AST2700 sd
> controller requires an reset line, so hook up the optional reset control
> and deassert it during probe.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ca97b01996b1..91c36245e506 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -520,6 +520,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  {
>  	struct device_node *parent, *child;
> +	struct reset_control *reset;
>  	struct aspeed_sdc *sdc;
>  	int ret;
>  
> @@ -529,6 +530,15 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&sdc->lock);
>  
> +	reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
> +				     "unable to acquire reset\n");
> +	ret = reset_control_deassert(sdc->rst);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "reset deassert failed\n");
> +
>  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sdc->clk))
>  		return PTR_ERR(sdc->clk);
> @@ -577,6 +587,7 @@ static const struct of_device_id aspeed_sdc_of_match[] = {
>  	{ .compatible = "aspeed,ast2400-sd-controller", },
>  	{ .compatible = "aspeed,ast2500-sd-controller", },
>  	{ .compatible = "aspeed,ast2600-sd-controller", },
> +	{ .compatible = "aspeed,ast2700-sd-controller", },

So devices are fully compatible. You must express it in the bindings and
drop this hunk.

Best regards,
Krzysztof

