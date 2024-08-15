Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275919E7FA;
	Thu, 15 Aug 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729971; cv=none; b=BFu5JwsCj8BzZCbfl4GF9UQK8EIL5ThYRTsXEQe58QVEbmw79I7KvIf0xbatFs8CqRNOwNHaIK+r0SIRdG0Bf+XOGYEjI2hVlKBb3dj4ZipOi/7ylrcbqc3bcEAoj4OnZnpNsO200Hpxvp5Ssf0E77BeZEHkmi1TGoh+zdIEJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729971; c=relaxed/simple;
	bh=G95pZGLRKcJIGdjjD0ZvQ+U3eEm6I8epNhEg1jZU3Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MORYmM/21O5A9cds62jvlSYkHWa2S+CwYZ10krtsMCzGQ58rrq0uUksmHhr08dLjS4hBopaiSZOrbfcrJslyZ7P45JySs/8gfbGFZCUKpDOY7DGvhKoiEdHu1aLbY0jEn3XYZE0rBur8p4O5NW8TKHTuzPexOa8NBzToMXk8wI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=b9WyvxSS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="b9WyvxSS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MsRxBz3yKwaI5Jy/pfioIi0ruFXHd6dE3S/c9N2LVTQ=; b=b9WyvxSSrtg9dDeKf+yBjbYhBN
	+Tz6VbKbEXzp1OnmCxvKQcV5GytSVeRxNbtZwJTmebfYnxqWdyMj/ZAvORgeUVVdBYVmMNh9CLiGZ
	BK/TEGoQEW/3vcufbizHAotLK7ZOHMAKm17QHfpTo23T1iuGva4yiAP7fO8DNq0LzSDH+RS9WPUyM
	4Nyv7rdKLg9hWJfloNNMoyU4PSo0vwjx5EnbzKdCC5NtHSsH39M+Y3P+UOD5r2SPJxvMqhOI3+osk
	BJKt9GvxpKZxHSP7qCuny7ePIdaOgl7avGmwpL/og5AqN9mOMONON/j4UJxIQaDEQ30HCXw1XCz6J
	G9X9lBTw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seau9-0003Eo-CV; Thu, 15 Aug 2024 15:52:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 3/3] mmc: dw_mmc-rockchip: Add internal phase support
Date: Thu, 15 Aug 2024 15:52:40 +0200
Message-ID: <12141241.2vOk3Fo9v1@diego>
In-Reply-To: <20240814223555.3695-4-detlev.casanova@collabora.com>
References:
 <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-4-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 15. August 2024, 00:34:02 CEST schrieb Detlev Casanova:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Some Rockchip devices put the phase settings into the dw_mmc controller.
> 
> The feature is implemented in devices where the USRID register contains
> 0x20230002.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 184 ++++++++++++++++++++++++++---
>  1 file changed, 170 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 367633f4e8892..03e25a8b8a305 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -16,6 +16,17 @@
>  #include "dw_mmc-pltfm.h"
>  
>  #define RK3288_CLKGEN_DIV	2
> +#define USRID_INTER_PHASE	0x20230001
> +#define SDMMC_TIMING_CON0	0x130
> +#define SDMMC_TIMING_CON1	0x134
> +#define ROCKCHIP_MMC_DELAY_SEL BIT(10)
> +#define ROCKCHIP_MMC_DEGREE_MASK 0x3
> +#define ROCKCHIP_MMC_DELAYNUM_OFFSET 2

the delaynum offset in the register is 3, please don't encode how you
use constants below into the values. So the constants should reflect the
register setup


> +#define ROCKCHIP_MMC_DELAYNUM_MASK (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)

please use one firm of mask values ROCKCHIP_MMC_DEGREE_MASK is used
for values _after_ they are shifted, while your DELAYNUM_MASK is vor values
_before_ they are shifted. Please decide on one form for both.


> +#define PSECS_PER_SEC 1000000000000LL

this is the second definition of this value, after clk/rockchip/clk-mmc-phase.c [0] .
The kernel already has a PSEC_PER_SEC definition in vdso/time64.h [1] and
thus linux/time64.h, so please re-use that - the innosilicon-dsi-phy
already does it too [2].

[0] https://elixir.bootlin.com/linux/v6.10.5/source/drivers/clk/rockchip/clk-mmc-phase.c#L37
[1] https://elixir.bootlin.com/linux/v6.10.5/source/include/vdso/time64.h#L11
[2] https://elixir.bootlin.com/linux/v6.11-rc3/source/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c#L415


> +#define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC 60
> +#define HIWORD_UPDATE(val, mask, shift) \
> +		((val) << (shift) | (mask) << ((shift) + 16))
>  
>  static const unsigned int freqs[] = { 100000, 200000, 300000, 400000 };
>  
> @@ -25,9 +36,121 @@ struct dw_mci_rockchip_priv_data {
>  	int			default_sample_phase;
>  	int			num_phases;
>  	bool			use_v2_tuning;
> +	int			usrid;
>  	int			last_degree;
>  };
>  
> +/*
> + * Each fine delay is between 44ps-77ps. Assume each fine delay is 60ps to
> + * simplify calculations. So 45degs could be anywhere between 33deg and 57.8deg.
> + */
> +static int rockchip_mmc_get_phase(struct dw_mci *host, bool sample)
> +{
> +	unsigned long rate = clk_get_rate(host->ciu_clk);
> +	u32 raw_value;
> +	u16 degrees;
> +	u32 delay_num = 0;
> +
> +	/* Constant signal, no measurable phase shift */
> +	if (!rate)
> +		return 0;
> +
> +	if (sample)
> +		raw_value = mci_readl(host, TIMING_CON1) >> 1;
> +	else
> +		raw_value = mci_readl(host, TIMING_CON0) >> 1;

please define some sort of 
	#define ROCKCHIP_MMC_DEGREE_OFFSET	1 
above and use that constant instead of hard-coding the 1 shift

> +
> +	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
> +
> +	if (raw_value & ROCKCHIP_MMC_DELAY_SEL) {
> +		/* degrees/delaynum * 1000000 */
> +		unsigned long factor = (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
> +					36 * (rate / 10000);
> +
> +		delay_num = (raw_value & ROCKCHIP_MMC_DELAYNUM_MASK);
> +		delay_num >>= ROCKCHIP_MMC_DELAYNUM_OFFSET;
> +		degrees += DIV_ROUND_CLOSEST(delay_num * factor, 1000000);
> +	}
> +
> +	return degrees % 360;
> +}
> +
> +static int rockchip_mmc_set_phase(struct dw_mci *host, bool sample, int degrees)
> +{
> +	unsigned long rate = clk_get_rate(host->ciu_clk);
> +	u8 nineties, remainder;
> +	u8 delay_num;
> +	u32 raw_value;
> +	u32 delay;
> +
> +	/*
> +	 * The below calculation is based on the output clock from
> +	 * MMC host to the card, which expects the phase clock inherits
> +	 * the clock rate from its parent, namely the output clock
> +	 * provider of MMC host. However, things may go wrong if
> +	 * (1) It is orphan.
> +	 * (2) It is assigned to the wrong parent.
> +	 *
> +	 * This check help debug the case (1), which seems to be the
> +	 * most likely problem we often face and which makes it difficult
> +	 * for people to debug unstable mmc tuning results.
> +	 */
> +	if (!rate) {
> +		dev_err(host->dev, "%s: invalid clk rate\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	nineties = degrees / 90;
> +	remainder = (degrees % 90);
> +
> +	/*
> +	 * Due to the inexact nature of the "fine" delay, we might
> +	 * actually go non-monotonic.  We don't go _too_ monotonic
> +	 * though, so we should be OK.  Here are options of how we may
> +	 * work:
> +	 *
> +	 * Ideally we end up with:
> +	 *   1.0, 2.0, ..., 69.0, 70.0, ...,  89.0, 90.0
> +	 *
> +	 * On one extreme (if delay is actually 44ps):
> +	 *   .73, 1.5, ..., 50.6, 51.3, ...,  65.3, 90.0
> +	 * The other (if delay is actually 77ps):
> +	 *   1.3, 2.6, ..., 88.6. 89.8, ..., 114.0, 90
> +	 *
> +	 * It's possible we might make a delay that is up to 25
> +	 * degrees off from what we think we're making.  That's OK
> +	 * though because we should be REALLY far from any bad range.
> +	 */
> +
> +	/*
> +	 * Convert to delay; do a little extra work to make sure we
> +	 * don't overflow 32-bit / 64-bit numbers.
> +	 */
> +	delay = 10000000; /* PSECS_PER_SEC / 10000 / 10 */
> +	delay *= remainder;
> +	delay = DIV_ROUND_CLOSEST(delay,
> +			(rate / 1000) * 36 *
> +				(ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10));
> +
> +	delay_num = (u8) min_t(u32, delay, 255);
> +
> +	raw_value = delay_num ? ROCKCHIP_MMC_DELAY_SEL : 0;
> +	raw_value |= delay_num << ROCKCHIP_MMC_DELAYNUM_OFFSET;
> +	raw_value |= nineties;
> +
> +	if (sample)
> +		mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value, 0x07ff, 1));
> +	else
> +		mci_writel(host, TIMING_CON0, HIWORD_UPDATE(raw_value, 0x07ff, 1));
> +
> +	dev_dbg(host->dev, "set %s_phase(%d) delay_nums=%u actual_degrees=%d\n",
> +		sample ? "sample" : "drv", degrees, delay_num,
> +		rockchip_mmc_get_phase(host, sample)
> +	);
> +
> +	return 0;
> +}
> +
>  static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>  	struct dw_mci_rockchip_priv_data *priv = host->priv;
> @@ -65,8 +188,12 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  	}
>  
>  	/* Make sure we use phases which we can enumerate with */
> -	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
> -		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS) {
> +		if (priv->usrid == USRID_INTER_PHASE)
> +			rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
> +		else
> +			clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +	}
>  
>  	/*
>  	 * Set the drive phase offset based on speed mode to achieve hold times.
> @@ -129,7 +256,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  			break;
>  		}
>  
> -		clk_set_phase(priv->drv_clk, phase);
> +		if (priv->usrid == USRID_INTER_PHASE)
> +			rockchip_mmc_set_phase(host, false, phase);
> +		else
> +			clk_set_phase(priv->drv_clk, phase);
>  	}
>  }
>  
> @@ -141,13 +271,16 @@ static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  	struct dw_mci *host = slot->host;
>  	struct dw_mci_rockchip_priv_data *priv = host->priv;
>  	struct mmc_host *mmc = slot->mmc;
> -	u32 degrees[4] = {90, 180, 270, 360};
> +	u32 degree, degrees[4] = {90, 180, 270, 360};
>  	int i;
>  	static bool inherit = true;
>  
>  	if (inherit) {
>  		inherit = false;
> -		i = clk_get_phase(priv->sample_clk) / 90 - 1;
> +		if (priv->usrid == USRID_INTER_PHASE)
> +			i = rockchip_mmc_get_phase(host, true) / 90;
> +		else
> +			i = clk_get_phase(priv->sample_clk) / 90 - 1;
>  		goto done;
>  	}
>  
> @@ -156,7 +289,11 @@ static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  		if (degrees[i] == priv->last_degree)
>  			continue;
>  
> -		clk_set_phase(priv->sample_clk, degrees[i]);
> +		degree = (degrees[i] + priv->last_degree + 90) % 360;
> +		if (priv->usrid == USRID_INTER_PHASE)
> +			rockchip_mmc_set_phase(host, true, degree);
> +		else
> +			clk_set_phase(priv->sample_clk, degree);
>  		if (!mmc_send_tuning(mmc, opcode, NULL))
>  			break;
>  	}
> @@ -189,6 +326,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  	int longest_range_len = -1;
>  	int longest_range = -1;
>  	int middle_phase;
> +	int phase;
>  
>  	if (IS_ERR(priv->sample_clk)) {
>  		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
> @@ -209,8 +347,15 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  
>  	/* Try each phase and extract good ranges */
>  	for (i = 0; i < priv->num_phases; ) {
> -		clk_set_phase(priv->sample_clk,
> -			      TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
> +		/* Cannot guarantee any phases larger than 270 would work well */
> +		if (TUNING_ITERATION_TO_PHASE(i, priv->num_phases) > 270)
> +			break;

this changes behaviour for the existing user as well.
Not say that this is incorrect, but limiting phases to a working area should be a separate change.

> +		if (priv->usrid == USRID_INTER_PHASE)
> +			rockchip_mmc_set_phase(host, true,
> +				TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
> +		else
> +			clk_set_phase(priv->sample_clk,
> +				TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
>  
>  		v = !mmc_send_tuning(mmc, opcode, NULL);
>  
> @@ -256,7 +401,10 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  	}
>  
>  	if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
> -		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
> +		if (priv->usrid == USRID_INTER_PHASE)
> +			rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
> +		else
> +			clk_set_phase(priv->sample_clk, priv->default_sample_phase);
>  		dev_info(host->dev, "All phases work, using default phase %d.",
>  			 priv->default_sample_phase);
>  		goto free;
> @@ -293,12 +441,13 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>  
>  	middle_phase = ranges[longest_range].start + longest_range_len / 2;
>  	middle_phase %= priv->num_phases;
> -	dev_info(host->dev, "Successfully tuned phase to %d\n",
> -		 TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases));
> +	phase = TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases);
> +	dev_info(host->dev, "Successfully tuned phase to %d\n", phase);
>  
> -	clk_set_phase(priv->sample_clk,
> -		      TUNING_ITERATION_TO_PHASE(middle_phase,
> -						priv->num_phases));
> +	if (priv->usrid == USRID_INTER_PHASE)
> +		rockchip_mmc_set_phase(host, true, phase);
> +	else
> +		clk_set_phase(priv->sample_clk, phase);

with the change in compatible (not claiming to be compatible with tk3288)
you can also just introduce a new dw_mci_drv_data for the rk3576 and
following can therefore create a separate tuning function to not need all
those ifs.

And also a shorter parse_dt function that does not tries to get non-existent
clocks.


>  
>  free:
>  	kfree(ranges);
> @@ -342,6 +491,7 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>  static int dw_mci_rockchip_init(struct dw_mci *host)
>  {
>  	int ret, i;
> +	struct dw_mci_rockchip_priv_data *priv = host->priv;
>  
>  	/* It is slot 8 on Rockchip SoCs */
>  	host->sdio_id0 = 8;
> @@ -365,6 +515,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>  			dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
>  	}
>  
> +	priv->usrid = mci_readl(host, USRID);
> +	if (priv->usrid == USRID_INTER_PHASE) {
> +		priv->sample_clk = NULL;
> +		priv->drv_clk = NULL;
> +	}
> +

in any case, shouldn't the clocks be NULL anyway?


Heiko


