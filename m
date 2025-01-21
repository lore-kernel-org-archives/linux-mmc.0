Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362712913;
	Tue, 21 Jan 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737446363; cv=none; b=iOSnfjh7gYOVLi6z70BDhJ035KGOL9tycmP0Zitope8KZ29E4oZEHT50ypDkMgK6K4rcPgr2kSJ+jo1tpp6SX2cCfmVEBCoqm4JS2/iU39zgjOYWdSyUIQlmtTjvQ/Ae5vvScm4RmgaX4xZ7fkJsRXtoRl0heRzyK8Lo6mSf1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737446363; c=relaxed/simple;
	bh=1sW03D4JYjdR1oZ97WjKdWnJzzKwgUK7haavl1Dli8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBXy+x73CXv+Y32rOHhzDrTuXDB1JVRK0IIWBw+0MGovkyvsOf9ooPoX5uP7C8pYIx2YFHFDheuOk+AnfzmlsynvLQ+Ty+x9zmW99dyXvrSxASodM3e63wH0/4edlOO51SyDYxZ+6yS1hvv4JhueB5DjhQRkFkbFGYH1faFiB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVo4NKhI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVo4NKhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0EDC4CEDF;
	Tue, 21 Jan 2025 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737446362;
	bh=1sW03D4JYjdR1oZ97WjKdWnJzzKwgUK7haavl1Dli8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVo4NKhIrBKzg3cz0dISq6baOKDz6NV+zfrADVUA6dm7iRN+Kg72RITkx7MqXSLBx
	 +6fVMi8wRWU/ehdEjaKqMw6l3rzYouqA/YhL8yiRr9jqo3/RKpJo0NJdjPZUXAvGT5
	 mdxrwpYNPQ99YAlqd3h1JrzNWhx52Q1wcnmXoTvGL9PS9Kvke/REvje6aSoRIt60Zj
	 XKnH7V01rgbsdbMlk9r18ijQtA70a1HQUippzJluj35bzIXspZfNMwJLEmnqU+QHIc
	 5iscnX3VAEaQbj4fDZ3hXoCdY2yd7xTtlPbaKc96XIe/zmtUMp7fIZ37CxT1Urtaw4
	 KsenzX6hGoWuQ==
Date: Tue, 21 Jan 2025 08:59:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
Message-ID: <20250121-zippy-umber-fossa-abbfb0@krzk-bin>
References: <20250120184728.18325-1-ansuelsmth@gmail.com>
 <20250120184728.18325-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120184728.18325-2-ansuelsmth@gmail.com>

On Mon, Jan 20, 2025 at 07:47:02PM +0100, Christian Marangi wrote:
> -			pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +			/* Skip setting uhs pins if not supported */
> +			if (host->pins_uhs)
> +				pinctrl_select_state(host->pinctrl, host->pins_uhs);
>  		} else {
>  			dev_pm_clear_wake_irq(host->dev);
>  		}
> @@ -2816,9 +2835,12 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
>  	if (IS_ERR(host->src_clk))
>  		return PTR_ERR(host->src_clk);
>  
> -	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> -	if (IS_ERR(host->h_clk))
> -		return PTR_ERR(host->h_clk);
> +	/* AN7581 SoC doesn't have hclk */
> +	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {

Please avoid coding compatible in multiple places. Not only because
above check is slow comparing to check on integer, but it just scales
poorly and leads to less readable further code. Use driver data with
model name or flags/quirks bitmask.

Best regards,
Krzysztof

