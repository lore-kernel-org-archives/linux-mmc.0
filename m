Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530328;
	b=Rar9Gf1jMANl7HOyZI5hpRer8xCgpb5ftEmK5H40k7sgIA8J8jT8YcqV5WQa3hUmfx2H
	 WJxzgxPvcL68wbQlbIt9aPPzyQ+5+PkfCZnECG2hgnMsJFl3X0bCbLVQR5a2JKtWP8c/U
	 Ittda2XXcEubmV0du+uvI6Vrd0qdz7ORcoPetT+oGjDHUoMGsFz/qkFC3td2FhikKGepN
	 KlNtQp9lcdH/4hTJT16FmJ495612Leavj8pu+LBoX/EseOc3xN0/DoCmY5GfQ+6FFkAJq
	 sdDMilhKLmxFhzmf3OiQGFVhie7PnbHhd3pWMEc2vWHIj1yK91+ZEw92vXhpWGjeHWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530328;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pJVVKwHbhmfTEf9BsmBhWwB3UfIBhltnU3zTc/bmdjo=;
	b=kHjfFcSIkYIZDlZecGeDHWVs4emKYwEiBKB2xZGaGKQwVQempPQPCyeJX9j2KO1Pyzev
	 C3NVpbRNMD45aDRcK+9I/mg/L650Hy/ur6KknQQYRQI7/DtbTc2vZ6BuAwkt4iBhH4Kox
	 l+I/rSb4rGtB9ya4furnbNQKsAx6kcVa5T6UErAvuZpx2LW+CFw1QA6Xgqc0t3ecjpnW6
	 sGqX2KZTnu6XeZKXJOiZoATYBQaYnZnwgsEbmBtKG8wf1ZFdQap3h36r9/wJuJ/fdqGGu
	 gCuVD8dX2gxoZTTCe+NDs6c4HGx6LRHJBpdNIaS6+cI3G/VzO7CZ3VrwsQlefjDs9KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l0c/lPT/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E6606A324;
	Sun,  1 Nov 2026 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0c/lPT/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC941F000C1;
	Sun,  1 Nov 2026 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793530327;
	bh=pJVVKwHbhmfTEf9BsmBhWwB3UfIBhltnU3zTc/bmdjo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=l0c/lPT/eHsnt1tu0zHEi2fcjmyhFiZ/YhFGHrjw3FbL3pYqJvbloIdadawwaB612
	 FBUXj/oiY0K3qDL8wX/neSpZzhEHZkMFvAKvNkqQTnumEInIkI6/gCd7lKUmkFdqHz
	 PxfZ7v4jGDpZvZdkWaoBpXrQErbRQXKlIjTIeRWOR5hVqs/5jLB0rcT1poWWRrLIEx
	 keRC/Y8Be+MNkn9QSHiLWHWKDEisoJA/OWDywAbucKI3nYaJJ9dQt8eIPH0grbMLPQ
	 t9IDpoyBs4x4Ix9A6NGoqNrAX/wPqbatMCkyFH7cI18gzxBx4BVvfCmGl/YnX8O4C0
	 1UBl0NAQojcig==
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 21/27] phy: rockchip-inno-usb2: Add RK3572 support
From: Manivannan Sadhasivam <mani@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-21-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-21-0b0fd85a31ee@qq.com>
Date: Sun, 01 Nov 2026 16:21:52 +0530
Message-Id: <179353031285.2955.4272173079718014092.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=mani@kernel.org;
 h=from:subject:message-id; bh=31exuPQfsAOhnwIjmXEjjvAlTRXnnjz1PKLb/yyFj6k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5xnKP2pbzdBpJAuX9SwupspI7yJNwomVsnJuz
 aOJqq74qKuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaucZygAKCRBVnxHm/pHO
 9WQAB/96KIbnRgeB00Ab1FYAF1roqbKbj5c0aeRO93f5urNJ5r4URepXfyJP8dOuE9JZMVZcr5b
 GALeNpvXnpsL49mzVQohe0Sp2GxQbbkDvy3WNXMFLbrkiwoNUew3PXjGrpC+WP0iMwunoMh40sM
 +FfXLZ/BJbcm4CwP6xP2rbTgKlRX+YBDZ+5anFKAflhI8lyjzOroc6CaQKJWA1uoNR/cCsO3b/7
 PbLuWLleLh5V6qLB832ZwG0rMmEZomEhcXEuXh11t9ERKG4ysL4hKV6TinMlLU2Ruhu+iLPuGXa
 eWPJiKBNr/cTl6yoqPDo7ctlFKJ8f+OZjojQUZ/2GmF6FG2F
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-22 00:11 +0800, Cunhao Lu wrote:
> Support both RK3572 USB2 PHY instances.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Nitpicks below. With those fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 136 ++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 7d8a533f24aea..16a36e68cb6d3 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1544,6 +1544,49 @@ static int rk3528_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>  	return 0;
>  }
>  
> +static int rk3572_usb2phy_tuning(struct rockchip_usb2phy *rphy)
> +{
> +	u32 reg = rphy->phy_cfg->reg;
> +	struct clk *refclk;
> +	unsigned long rate;
> +	u32 val;
> +	int ret;
> +
> +	refclk = devm_clk_get(rphy->dev, "phyclk");
> +	if (IS_ERR(refclk))
> +		return PTR_ERR(refclk);

Please insert a newline between each operation to improve readability.

> +	rate = clk_get_rate(refclk);
> +	if (rate != 24000000 && rate != 26000000)
> +		return -EINVAL;
> +
> +	ret = regmap_write(rphy->grf, reg + 0x0004,
> +			   GENMASK(18, 16) | (rate == 24000000 ? 2 : 6));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(rphy->grf, reg + 0x0010, &val);
> +	if (ret)
> +		return ret;
> +	if (val & BIT(13)) {
> +		ret = regmap_write(rphy->grf, reg + 0x0010, BIT(29));
> +		if (ret)
> +			return ret;
> +		ret = rockchip_usb2phy_reset(rphy);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Set the normal line-state filter interval. */
> +	ret = regmap_write(rphy->grf, reg + 0x0020, 0x30100);
> +	if (ret)
> +		return ret;

Here.

> +	/* Increase HS voltage by 5.89% and double pre-emphasis current. */
> +	ret = regmap_write(rphy->grf, reg + 0x000c, GENMASK(27, 24) | 0x0900);
> +	if (ret)
> +		return ret;

And here.

- Mani


