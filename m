From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: eMMC tuning issue on Odroid C2 and a possible solution
Date: Thu, 12 Oct 2017 17:22:39 +0200
Message-ID: <1507821759.16356.225.camel@baylibre.com>
References: <b931985f-16b2-0a90-e73b-b6c349ad7d6c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:57234 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdJLPWm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 11:22:42 -0400
Received: by mail-wm0-f50.google.com with SMTP id l68so14342264wmd.5
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 08:22:41 -0700 (PDT)
In-Reply-To: <b931985f-16b2-0a90-e73b-b6c349ad7d6c@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>

On Wed, 2017-10-11 at 22:46 +0200, Heiner Kallweit wrote:
> Hi Jerome,
> 
> we have the known issue that the latest next kernel still fails on
> Odroid C2 with a 128GB eMMC card (w/o adjusting the initial tx phase).
> 
> I found the time to dig a little deeper into it and reason is that
> there are certain rx/tx phase combinations which are perfectly fine
> when tuning but fail in real life.

You did not mention it in this mail, but I going to guess this is done, again,
in hs400 ...

> Don't ask me how this can happen, I just see it happen.

Oh I have pretty good idea of what is happening here, and to be absolutely it is
not a regression.

I think I already explained this but, before the MMC series that went in this
cycle, the frequency reported by the mmc driver was twice what it really was
for all DDR mode, including HS400.

So, up to v4.13, when you thought you were doing hs400 @ 200MHz, the frequency
was really 100Mhz

With all the mmc patches applied (including the recent tuning fix) the frequency
in DDR mode is set as requested by the framework. So on your target, it has
increased from 100MHz to 166Mhz. This is a huge difference. You did not change
the DT but the frequency did change.

The symptoms you are describing, I have seen them while trying SDR104 on boards
where the layout proved to be unable to cope with the clock rate involved. Some
cards worked well, some did not at all. When looking at the signal amplitude,
the problem was clear, the signal quality was just not good enough. The
communication might be OK for a short while (while doing the tuning) but may
fail while doing "real life" transfers.

So why does the tuning succeed and you get errors later on ? Simply because the
tuning is not the problem. The HW (and the frequency used) is.

As far as I can tell, your eMMC card + your odroidc2 is simply not able to cope
(reliably) with 166Mhz. The fact that you continue to have CRC errors with your
"hand picked phases" is an evidence of this fact.

This is not the only platform out there which can't cope with hs400 @ 166Mhz,
the p200 eMMC is hs400 capable, but the platform can't cope with it. That's how
it is.

Lower your frequency or change the mode to hs200 (which is the setting in the
upstream DT BTW)

> 
> To deal with such cases I added some code to avoid known invalid phase
> values when retuning. In addition I added some code to deal with the
> following (more or less corner) case:
> Let's say we have rx = 0° and tx = 0° and working is only combination
> rx = 180° and tx = 180°.
> Then just tuning rx only or tx only will never result in a working
> combination.
> 
> Following patch makes my system work. I just see one CRC error when
> the initally tuned rx/tx phase combination fails and then the
> retuning results in a stable system w/o further errors.
> 
> I'd appreciate if you could check that this patch doesn't break any
> of your systems.
> 
> Rgds, Heiner
> 
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 85745ef1..95cb439d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -120,6 +120,7 @@
>  #define SD_EMMC_DESC_CHAIN_MODE BIT(1)
>  
>  #define MUX_CLK_NUM_PARENTS 2
> +#define MAX_TUNING_ATTEMPTS 10
>  
>  struct sd_emmc_desc {
>  	u32 cmd_cfg;
> @@ -687,15 +688,23 @@ static int meson_mmc_find_tuning_point(unsigned long
> *test)
>  static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
>  				      struct clk *clk)
>  {
> -	int point, ret;
> +	int point, ret, old_phase;
>  	DECLARE_BITMAP(test, CLK_PHASE_POINT_NUM);
>  
> +	old_phase = clk_get_phase(clk);
> +	if (old_phase < 0)
> +		return old_phase;
> +
>  	dev_dbg(mmc_dev(mmc), "%s phase/delay tunning...\n",
>  		__clk_get_name(clk));
>  	bitmap_zero(test, CLK_PHASE_POINT_NUM);
>  
>  	/* Explore tuning points */
>  	for (point = 0; point < CLK_PHASE_POINT_NUM; point++) {
> +		/* when retuning avoid the surrounding of where we failed */
> +		if (mmc->doing_retune)
> +			if (abs(point * CLK_PHASE_STEP - old_phase) <= 45)
> +				continue;

This is just a fake alteration of the working window.
The point of this whole tuning is to find the middle of the window to get the
most stable setting

If you still get CRC error with the center of the window, the signal quality is
just too low to cope with the timing set.

This is patch is just a (convoluted) hack that will force the tuning algorithm
to come up with new values each times, hoping to pick setting where the problem
is bit masked.


>  		clk_set_phase(clk, point * CLK_PHASE_STEP);
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
> @@ -704,8 +713,11 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host
> *mmc, u32 opcode,
>  
>  	/* Find the optimal tuning point and apply it */
>  	point = meson_mmc_find_tuning_point(test);
> -	if (point < 0)
> +	if (point < 0) {
> +		/* prevent from getting stuck if we failed */
> +		clk_set_phase(clk, (old_phase + 90) % 360);
>  		return point; /* tuning failed */
> +	}
>  
>  	clk_set_phase(clk, point * CLK_PHASE_STEP);
>  	dev_dbg(mmc_dev(mmc), "success with phase: %d\n",
> @@ -716,7 +728,7 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host
> *mmc, u32 opcode,
>  static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	int ret;
> +	int i, ret;
>  
>  	/*
>  	 * If this is the initial tuning, try to get a sane Rx starting
> @@ -729,11 +741,14 @@ static int meson_mmc_execute_tuning(struct mmc_host
> *mmc, u32 opcode)
>  			return ret;
>  	}
>  
> -	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < MAX_TUNING_ATTEMPTS; i++) {
> +		meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
> +		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
> +		if (!ret)
> +			return 0;

With the hack that is going to skip 25% on the phase, that is up to:
12 phase * 2 (TX/RX) * 10 * 0.75 = 180 MMC tunes !! that's way too much and
unnecessary.

> +	}
>  
> -	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
> +	return ret;
>  }
>  
>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)

