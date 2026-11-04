Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801390;
	b=mARfgcJH+MgwHKZAbxeWFcodz05feeI2seo5l8D5GNQdlNsrTWuK6NS9TzhzSnhevtLi
	 qAt2hekvZL1kTWJVeE3nPdPIMUYLQDMmTxErM3J1aPSEH5apFFKXBFIRkuGJ8w98ALGbV
	 nhcMZr4IcBO69lHkSSmgrTGn8sw4dFOJfozZFilmJPO+TJz1Rkw365IMXhHWUI2y8xuMK
	 nupCn2/triA6h6Y+s18rwll1xNP24SkssF27HYPoJYpoddq/cPUj5VNg3qQ3sp3wQxO0I
	 MwU3OT9dxdHOMzqSdWtg5HbG3hewNbum6S1mFRoSsYgbmUQla5x0WA/ZzCU5ijmSWJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801390;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=Rja63v8SvhDJ5Nc3/E8dKLOwWZaN1vZYvJXp3TIYRyU=;
	b=W51iHSQuiVFv/VifUMmI8iptnvdteV4vYkMBswZ0c643duySmRplkgmSgJIwonf6nCPG
	 Cjyy4zzow0ze3O5sAjJSxygWyFDy5BCo1DrM9DMakdavA8E2RmWDCrss/K6RoYDZnshmL
	 mExE8wrju4i/hiV3NKM2m6PpEpnZ1DqG/XCL2XbAcSmpPDxnMfbUWjAd9RmcKLfukg7jq
	 XkEfp9oPMTBHYqJl+UTowvvKh+tu2L0LzRv8ZFAkJ/TEx2Bo6zOV/OVV01pfZf576/JJ3
	 o6zXYbxIkElYl0/kLMtGo5BDABChy/PLcV0pU3vhOCP8zAaRTCP0TSFcCfc8Ef5jNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gvk23y7k;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7524606A31B;
	Wed,  4 Nov 2026 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7524606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gvk23y7k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Rja63v8SvhDJ5Nc3/E8dKLOwWZaN1vZYvJXp3TIYRyU=; b=gvk23y7kJEBYZNbym5UkxTlO9P
	MKtLMuI1GtzOfwN8IgqVVjghpttW9kmneskZ3WPq/IFiVAablWLBNFk56LfxqEGZgOvXx8WvwGT05
	uz4Sv81J0cHGguIvDSvduHmMhSIfNBAj95p3wTrNBPahDYaU9e+A9h0uVd/bhcK5g/9mK3KfQIBKH
	hamk2TPUX/tBy/e/UwM9Y16TZr6/oAnzSdpM+1QIsPJEsWK7mFUS2XPS7jTH9CWyW9D2brNDFzJkQ
	mgaSr75asaqS8r0T2ezs8RyHv5WLRJu5WgA44hEXYBdaaw90q4zsL9XLuyJPoEi1oMbczaK+4tdt1
	0yC29Khw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-rockchip@lists.infradead.org
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, 1579567540@qq.com
Subject: Re: [PATCH 08/27] pinctrl: rockchip: Add RK3572 support
Date: Wed, 04 Nov 2026 15:09:01 +0100
Message-ID: <4309904.anssfa2V6d@diego>
In-Reply-To: <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
References:
 <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 21. Oktober 2026, 18:11:05 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Cunhao Lu via B4 Relay:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> Support RK3572 pinmux, bias, drive-strength, and Schmitt controls.
> Enable input buffers during mux changes for the RGMII receive clocks.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 230 +++++++++++++++++++++++++++++++=
+++++-
>  drivers/pinctrl/pinctrl-rockchip.h |   1 +
>  2 files changed, 230 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl=
=2Drockchip.c
> index ba47b6f323cc..6d9a6510b343 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -1363,6 +1363,10 @@ static int rockchip_get_mux(struct rockchip_pin_ba=
nk *bank, int pin)
>  	if (bank->recalced_mask & BIT(pin))
>  		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
> =20
> +	if (ctrl->type =3D=3D RK3572 && bank->bank_num =3D=3D 0 &&
> +	    pin >=3D RK_PB4 && pin <=3D RK_PB7)
> +		reg +=3D 0x2000;
> +
>  	if (ctrl->type =3D=3D RK3576) {
>  		if ((bank->bank_num =3D=3D 0) && (pin >=3D RK_PB4) && (pin <=3D RK_PB7=
))
>  			reg +=3D 0x1ff4; /* GPIO0_IOC_GPIO0B_IOMUX_SEL_H */
> @@ -1421,6 +1425,24 @@ static int rockchip_verify_mux(struct rockchip_pin=
_bank *bank,
>  	return 0;
>  }
> =20
> +static int rk3572_enable_input(struct rockchip_pin_bank *bank, int pin)
> +{
> +	static const u32 offsets[] =3D { 0x300, 0x10310, 0x12320, 0x14330, 0x14=
340 };
> +	struct rockchip_pinctrl *info =3D bank->drvdata;
> +	u32 reg, bit =3D pin % 8;
> +
> +	if (bank->bank_num >=3D ARRAY_SIZE(offsets))
> +		return -EINVAL;
> +
> +	reg =3D offsets[bank->bank_num] + pin / 8 * 4;
> +	if (bank->bank_num =3D=3D 0 && pin >=3D RK_PB4)
> +		reg +=3D 0x2000;
> +	else if (bank->bank_num =3D=3D 4 && pin >=3D RK_PC0)
> +		reg -=3D 0x10000;
> +
> +	return regmap_write(info->regmap_base, reg, BIT(bit + 16) | BIT(bit));
> +}
> +
>  /*
>   * Set a new mux function for a pin.
>   *
> @@ -1498,6 +1520,10 @@ static int rockchip_set_mux(struct rockchip_pin_ba=
nk *bank, int pin, int mux)
>  	if (bank->recalced_mask & BIT(pin))
>  		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
> =20
> +	if (ctrl->type =3D=3D RK3572 && bank->bank_num =3D=3D 0 &&
> +	    pin >=3D RK_PB4 && pin <=3D RK_PB7)
> +		reg +=3D 0x2000;
> +
>  	if (ctrl->type =3D=3D RK3576) {
>  		if ((bank->bank_num =3D=3D 0) && (pin >=3D RK_PB4) && (pin <=3D RK_PB7=
))
>  			reg +=3D 0x1ff4; /* GPIO0_IOC_GPIO0B_IOMUX_SEL_H */
> @@ -1568,8 +1594,13 @@ static int rockchip_set_mux(struct rockchip_pin_ba=
nk *bank, int pin, int mux)
>  	rmask =3D data | (data >> 16);
>  	data |=3D (mux & mask) << bit;
>  	ret =3D regmap_update_bits(regmap, reg, rmask, data);
> +	if (ret)
> +		return ret;
> =20
> -	return ret;
> +	if (ctrl->type =3D=3D RK3572)
> +		return rk3572_enable_input(bank, pin);
> +
> +	return 0;
>  }
> =20
>  #define PX30_PULL_PMU_OFFSET		0x10
> @@ -3097,6 +3128,151 @@ static int rk3568_calc_drv_reg_and_bit(struct roc=
kchip_pin_bank *bank,
>  	return 0;
>  }
> =20
> +#define RK3572_DRV_BITS_PER_PIN		4
> +#define RK3572_DRV_PINS_PER_REG		4
> +#define RK3572_DRV_GPIO0_OFFSET		0x100
> +#define RK3572_DRV_GPIO1_OFFSET		0x10120
> +#define RK3572_DRV_GPIO2_OFFSET		0x12140
> +#define RK3572_DRV_GPIO3_OFFSET		0x14160
> +#define RK3572_DRV_GPIO4_OFFSET		0x14180
> +
> +static int rk3572_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
> +				       int pin_num, struct regmap **regmap,
> +				       int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl *info =3D bank->drvdata;
> +
> +	*regmap =3D info->regmap_base;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*reg =3D RK3572_DRV_GPIO0_OFFSET;
> +		if (pin_num >=3D 12)
> +			*reg +=3D 0x2000;
> +		break;
> +	case 1:
> +		*reg =3D RK3572_DRV_GPIO1_OFFSET;
> +		break;
> +	case 2:
> +		*reg =3D RK3572_DRV_GPIO2_OFFSET;
> +		break;
> +	case 3:
> +		*reg =3D RK3572_DRV_GPIO3_OFFSET;
> +		break;
> +	case 4:
> +		*reg =3D RK3572_DRV_GPIO4_OFFSET;
> +		if (pin_num >=3D 16)
> +			*reg -=3D 0x10000;
> +		break;
> +	default:
> +		dev_err(info->dev, "unsupported bank_num %d\n", bank->bank_num);
> +		return -EINVAL;
> +	}
> +
> +	*reg +=3D ((pin_num / RK3572_DRV_PINS_PER_REG) * 4);
> +	*bit =3D pin_num % RK3572_DRV_PINS_PER_REG;
> +	*bit *=3D RK3572_DRV_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +#define RK3572_PULL_BITS_PER_PIN	2
> +#define RK3572_PULL_PINS_PER_REG	8
> +#define RK3572_PULL_GPIO0_OFFSET	0x200
> +#define RK3572_PULL_GPIO1_OFFSET	0x10210
> +#define RK3572_PULL_GPIO2_OFFSET	0x12220
> +#define RK3572_PULL_GPIO3_OFFSET	0x14230
> +#define RK3572_PULL_GPIO4_OFFSET	0x14240
> +
> +static int rk3572_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> +					int pin_num, struct regmap **regmap,
> +					int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl *info =3D bank->drvdata;
> +
> +	*regmap =3D info->regmap_base;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*reg =3D RK3572_PULL_GPIO0_OFFSET;
> +		if (pin_num >=3D 12)
> +			*reg +=3D 0x2000;
> +		break;
> +	case 1:
> +		*reg =3D RK3572_PULL_GPIO1_OFFSET;
> +		break;
> +	case 2:
> +		*reg =3D RK3572_PULL_GPIO2_OFFSET;
> +		break;
> +	case 3:
> +		*reg =3D RK3572_PULL_GPIO3_OFFSET;
> +		break;
> +	case 4:
> +		*reg =3D RK3572_PULL_GPIO4_OFFSET;
> +		if (pin_num >=3D 16)
> +			*reg -=3D 0x10000;
> +		break;
> +	default:
> +		dev_err(info->dev, "unsupported bank_num %d\n", bank->bank_num);
> +		return -EINVAL;
> +	}
> +
> +	*reg +=3D ((pin_num / RK3572_PULL_PINS_PER_REG) * 4);
> +	*bit =3D pin_num % RK3572_PULL_PINS_PER_REG;
> +	*bit *=3D RK3572_PULL_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
> +#define RK3572_SMT_BITS_PER_PIN		1
> +#define RK3572_SMT_PINS_PER_REG		8
> +#define RK3572_SMT_GPIO0_OFFSET		0x400
> +#define RK3572_SMT_GPIO1_OFFSET		0x10410
> +#define RK3572_SMT_GPIO2_OFFSET		0x12420
> +#define RK3572_SMT_GPIO3_OFFSET		0x14430
> +#define RK3572_SMT_GPIO4_OFFSET		0x14440
> +
> +static int rk3572_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *ban=
k,
> +					   int pin_num,
> +					   struct regmap **regmap,
> +					   int *reg, u8 *bit)
> +{
> +	struct rockchip_pinctrl *info =3D bank->drvdata;
> +
> +	*regmap =3D info->regmap_base;
> +
> +	switch (bank->bank_num) {
> +	case 0:
> +		*reg =3D RK3572_SMT_GPIO0_OFFSET;
> +		if (pin_num >=3D 12)
> +			*reg +=3D 0x2000;
> +		break;
> +	case 1:
> +		*reg =3D RK3572_SMT_GPIO1_OFFSET;
> +		break;
> +	case 2:
> +		*reg =3D RK3572_SMT_GPIO2_OFFSET;
> +		break;
> +	case 3:
> +		*reg =3D RK3572_SMT_GPIO3_OFFSET;
> +		break;
> +	case 4:
> +		*reg =3D RK3572_SMT_GPIO4_OFFSET;
> +		if (pin_num >=3D 16)
> +			*reg -=3D 0x10000;
> +		break;
> +	default:
> +		dev_err(info->dev, "unsupported bank_num %d\n", bank->bank_num);
> +		return -EINVAL;
> +	}
> +
> +	*reg +=3D ((pin_num / RK3572_SMT_PINS_PER_REG) * 4);
> +	*bit =3D pin_num % RK3572_SMT_PINS_PER_REG;
> +	*bit *=3D RK3572_SMT_BITS_PER_PIN;
> +
> +	return 0;
> +}
> +
>  #define RK3576_DRV_BITS_PER_PIN		4
>  #define RK3576_DRV_PINS_PER_REG		4
>  #define RK3576_DRV_GPIO0_AL_OFFSET	0x10
> @@ -3441,6 +3617,18 @@ static int rockchip_get_drive_perpin(struct rockch=
ip_pin_bank *bank,
>  	if (ret)
>  		return ret;
> =20
> +	if (ctrl->type =3D=3D RK3572) {
> +		ret =3D regmap_read(regmap, reg, &data);
> +		if (ret)
> +			return ret;
> +		data >>=3D bit;
> +		if ((bank->bank_num =3D=3D 0 && pin_num < 12) ||
> +		    (bank->bank_num =3D=3D 4 && (pin_num =3D=3D 24 || pin_num =3D=3D 2=
5)))
> +			return ((data & BIT(1)) >> 1) | ((data & BIT(0)) << 1);
> +		return ((data & BIT(2)) >> 2) | ((data & BIT(0)) << 2) |
> +		       (data & BIT(1));
> +	}
> +
>  	switch (drv_type) {
>  	case DRV_TYPE_IO_1V8_3V0_AUTO:
>  	case DRV_TYPE_IO_3V3_ONLY:
> @@ -3559,6 +3747,22 @@ static int rockchip_set_drive_perpin(struct rockch=
ip_pin_bank *bank,
>  		rmask_bits =3D RK3568_DRV_BITS_PER_PIN;
>  		ret =3D (1 << (strength + 1)) - 1;
>  		goto config;
> +	} else if (ctrl->type =3D=3D RK3572) {
> +		if (strength < 0 || strength > 7)
> +			return -EINVAL;
> +		rmask_bits =3D RK3572_DRV_BITS_PER_PIN;
> +		if ((bank->bank_num =3D=3D 0 && pin_num < 12) ||
> +		    (bank->bank_num =3D=3D 4 && (pin_num =3D=3D 24 || pin_num =3D=3D 2=
5))) {
> +			/* Only four drive-strength levels are supported. */
> +			if (strength > 3)
> +				return -EINVAL;
> +			ret =3D ((strength & BIT(1)) >> 1) | ((strength & BIT(0)) << 1);
> +		} else {
> +			ret =3D ((strength & BIT(2)) >> 2) |
> +			      ((strength & BIT(0)) << 2) |
> +			      (strength & BIT(1));
> +		}
> +		goto config;
>  	} else if (ctrl->type =3D=3D RK3576) {
>  		rmask_bits =3D RK3576_DRV_BITS_PER_PIN;
>  		ret =3D ((strength & BIT(2)) >> 2) | ((strength & BIT(0)) << 2) | (str=
ength & BIT(1));
> @@ -3717,6 +3921,7 @@ static int rockchip_get_pull(struct rockchip_pin_ba=
nk *bank, int pin_num)
>  	case RK3528:
>  	case RK3562:
>  	case RK3568:
> +	case RK3572:
>  	case RK3576:
>  	case RK3588:
>  		pull_type =3D bank->pull_type[pin_num / 8];
> @@ -3786,6 +3991,7 @@ static int rockchip_set_pull(struct rockchip_pin_ba=
nk *bank,
>  	case RK3528:
>  	case RK3562:
>  	case RK3568:
> +	case RK3572:
>  	case RK3576:
>  	case RK3588:
>  		pull_type =3D bank->pull_type[pin_num / 8];
> @@ -4084,6 +4290,7 @@ static bool rockchip_pinconf_pull_valid(struct rock=
chip_pin_ctrl *ctrl,
>  	case RK3528:
>  	case RK3562:
>  	case RK3568:
> +	case RK3572:
>  	case RK3576:
>  	case RK3588:
>  		return (pull !=3D PIN_CONFIG_BIAS_PULL_PIN_DEFAULT);
> @@ -4296,6 +4503,7 @@ static const struct pinconf_ops rockchip_pinconf_op=
s =3D {
> =20
>  static const struct of_device_id rockchip_bank_match[] =3D {
>  	{ .compatible =3D "rockchip,gpio-bank" },
> +	{ .compatible =3D "rockchip,rk3572-gpio-bank" },
>  	{ .compatible =3D "rockchip,rk3188-gpio-bank0" },
>  	{},
>  };
> @@ -5643,6 +5851,24 @@ static struct rockchip_pin_ctrl rk3568_pin_ctrl =
=3D {
>  					       PULL_TYPE_IO_1V8_ONLY,	\
>  					       PULL_TYPE_IO_1V8_ONLY)
> =20
> +static struct rockchip_pin_bank rk3572_pin_banks[] =3D {
> +	RK3576_PIN_BANK(0, "gpio0", 0, 0x8, 0x2010, 0x2018),
> +	RK3576_PIN_BANK(1, "gpio1", 0x10020, 0x10028, 0x10030, 0x10038),
> +	RK3576_PIN_BANK(2, "gpio2", 0x12040, 0x12048, 0x12050, 0x12058),
> +	RK3576_PIN_BANK(3, "gpio3", 0x14060, 0x14068, 0x14070, 0x14078),
> +	RK3576_PIN_BANK(4, "gpio4", 0x14080, 0x14088, 0x4090, 0x4098),
> +};
> +
> +static struct rockchip_pin_ctrl rk3572_pin_ctrl __maybe_unused =3D {
> +	.pin_banks		=3D rk3572_pin_banks,
> +	.nr_banks		=3D ARRAY_SIZE(rk3572_pin_banks),
> +	.label			=3D "RK3572-GPIO",
> +	.type			=3D RK3572,
> +	.pull_calc_reg		=3D rk3572_calc_pull_reg_and_bit,
> +	.drv_calc_reg		=3D rk3572_calc_drv_reg_and_bit,
> +	.schmitt_calc_reg	=3D rk3572_calc_schmitt_reg_and_bit,
> +};
> +
>  static struct rockchip_pin_bank rk3576_pin_banks[] =3D {
>  	RK3576_PIN_BANK(0, "gpio0", 0, 0x8, 0x2004, 0x200C),
>  	RK3576_PIN_BANK(1, "gpio1", 0x4020, 0x4028, 0x4030, 0x4038),
> @@ -5727,6 +5953,8 @@ static const struct of_device_id rockchip_pinctrl_d=
t_match[] =3D {
>  		.data =3D &rk3562_pin_ctrl },
>  	{ .compatible =3D "rockchip,rk3568-pinctrl",
>  		.data =3D &rk3568_pin_ctrl },
> +	{ .compatible =3D "rockchip,rk3572-pinctrl",
> +		.data =3D &rk3572_pin_ctrl },
>  	{ .compatible =3D "rockchip,rk3576-pinctrl",
>  		.data =3D &rk3576_pin_ctrl },
>  	{ .compatible =3D "rockchip,rk3588-pinctrl",
> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl=
=2Drockchip.h
> index 950097699643..553197f6dc69 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.h
> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> @@ -203,6 +203,7 @@ enum rockchip_pinctrl_type {
>  	RK3528,
>  	RK3562,
>  	RK3568,
> +	RK3572,
>  	RK3576,
>  	RK3588,
>  };
>=20
>=20




