Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7936C5BB;
	Fri,  6 Feb 2026 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384405; cv=none; b=KpEAHjbEHl0wm7Lt49o3InDwVS2sCknCLcqLQB5Rm3Ia33o9f2ipnGNUDcVNIRlBesIDx4GPikjCIKUxRL7kt/pCZoqm2lhK4BHrsZiKSu4sjIcqbDZAys6XJLoiIiFIdFZtcin9xiTVkVyK1v68+R31I4FvI0yCqPFlCBcv/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384405; c=relaxed/simple;
	bh=oJHVy75SFVRMUlFGhtQOJ6ZioOzAKeIEQtFpWlVXd60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syDdu5gOHtC0ezV+4iefRl3GLC4BQ0lB7wADoIAfi1qhhHsZts3Z3dI2k6vU+fT9qXpd/MAbFxiXnaaQhylVmWnnvL1SCwlzlrFfyKgPE/JQrHlOeLCUUv1A3h75bVICU2e5q8lUn3UX0zrNKrn4G6OKHtZuG7bOUMnqNZUGIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdrie+5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdrie+5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363B9C116C6;
	Fri,  6 Feb 2026 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770384405;
	bh=oJHVy75SFVRMUlFGhtQOJ6ZioOzAKeIEQtFpWlVXd60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zdrie+5PnfGAKyXQ8OTEdnV88LjAQpW3IHYK1FcvqLnZzBXU2mcKZuWu6IT/knTBN
	 gQUq9eX8sVQhU+uz99KJ5ZmekM7CjA0TR1dgrAnxkeHMJgiDuhLQ5fDs26VzXLABRV
	 eHBq3ZnYzXyFIOFgRx2F3XiQksoX/CY+QSL2uGf2AnidzvhdNz0eVwla1Xq56evvY4
	 Mk2Up4KWRp5Km7UEW3RWxARXXo8lKxUpwKqKdez9h3+oHSv/+dK/eGzCAA1uYMqL1N
	 fV6vuQLFH4S3q4yjYFA6/t8Rq9Exl4YPE0XTQ1oOsd+omFAu8P5kx9uIPCOmK7YhKg
	 +6A/HqUckGrJw==
Message-ID: <e06bd9ca-11bb-4d87-9db5-87139731f181@kernel.org>
Date: Fri, 6 Feb 2026 14:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 gaohan@iscas.ac.cn, me@ziyao.cc
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204082908.27501-3-jiayu.riscv@isrc.iscas.ac.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260204082908.27501-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/02/2026 09:29, Jiayu Du wrote:
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +			     struct dwcmshc_priv *dwc_priv)
> +{
> +	static const char * const clk_ids[] = {"base", "timer", "ahb"};
> +	struct device_node *usb_phy_node;
> +	struct k230_priv *k230_priv;
> +	u32 data;
> +	int ret;
> +
> +	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
> +	if (!k230_priv)
> +		return -ENOMEM;
> +	dwc_priv->priv = k230_priv;
> +
> +	usb_phy_node = of_find_compatible_node(NULL, NULL, "canaan,k230-usb-phy");

Hm? You should use phandles, not look for various nodes.

> +	if (!usb_phy_node) {

Please follow Linux coding style.

> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find k230-usb-phy node\n");
> +	}
> +
> +	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
> +	of_node_put(usb_phy_node);
> +	if (IS_ERR(k230_priv->hi_sys_regmap)) {
> +		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
> +				     "Failed to get k230-usb-phy regmap\n");
> +	}
> +
> +	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get/enable k230 mmc other clocks\n");
> +	}
> +
> +	if (of_device_is_compatible(dev->of_node, "canaan,k230-sdio")) {

Driver match data is for this.


Best regards,
Krzysztof
