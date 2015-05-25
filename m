From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Date: Mon, 25 May 2015 23:02:33 +0200
Message-ID: <20150525210233.GN8557@lukather>
References: <cover.1432491958.git.hramrach@gmail.com>
 <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwXh6gFRjCd3qPCM"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7U4R2VQKGQERSK3ZBY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--OwXh6gFRjCd3qPCM
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Michal,

The patch itself looks good, but there's a few style issues.

On Sun, May 24, 2015 at 08:07:32PM +0200, Michal Suchanek wrote:
> The 250ms timeout is too short.
> 
> On my system enabling the oclk takes under 50ms and disabling slightly
> over 100ms when idle. Under load disabling the clock can take over
> 350ms.
> 
> This does not make mmc clock gating look like good option to have on
> sunxi but the system should not crash with mmc clock gating enabled
> nonetheless.
> 
> This patch sets the timeout to 750ms and adds debug prints which show
> how long enabling/disabling the clock took so more data can be collected
> from other systems.
> 
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 4d3e1ff..7cdeecd 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
>  
>  static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  {
> -	unsigned long expire = jiffies + msecs_to_jiffies(250);
> +	unsigned long start, end;
>  	u32 rval;
>  
>  	rval = mmc_readl(host, REG_CLKCR);
> @@ -604,6 +604,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  	if (oclk_en)
>  		rval |= SDXC_CARD_CLOCK_ON;
>  
> +	start = jiffies;
> +	end = start + msecs_to_jiffies(750);
>  	mmc_writel(host, REG_CLKCR, rval);
>  
>  	rval = SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
> @@ -611,15 +613,29 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  
>  	do {
>  		rval = mmc_readl(host, REG_CMDR);
> -	} while (time_before(jiffies, expire) && (rval & SDXC_START));
> +	} while (time_before(jiffies, end) && (rval & SDXC_START));
> +	end = jiffies;
>  
>  	/* clear irq status bits set by the command */
>  	mmc_writel(host, REG_RINTR,
>  		   mmc_readl(host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT);
>  
>  	if (rval & SDXC_START) {
> -		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
> +		dev_err(mmc_dev(host->mmc),
> +			"fatal err update oclk timeout. Could not %s in %ims.\n",
> +			oclk_en ? "enable" : "disable",
> +			jiffies_to_msecs(end-start));

You should have spaces around that operator.

>  		return -EIO;
> +	} else {
> +		int msecs = jiffies_to_msecs(end-start);

Ditto.

> +		const char *ing = oclk_en ? "enabling" : "disabling";
> +
> +		if ((msecs > 150) || (oclk_en && (msecs > 50)))
> +			dev_warn(mmc_dev(host->mmc),
> +				 "%s oclk took %ims", ing, msecs);
> +		else
> +			dev_dbg(mmc_dev(host->mmc),
> +				 "%s oclk took %ims", ing, msecs);

And this should be aligned with the opening parenthesis.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--OwXh6gFRjCd3qPCM--
