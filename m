From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 09/10] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Tue, 21 Aug 2012 13:42:49 +0300
Message-ID: <20120821104248.GR10347@arwen.pp.htv.fi>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
 <1345229550-8672-10-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWsnvgFfkTS2ATo5"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345229550-8672-10-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org


--SWsnvgFfkTS2ATo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 12:22:29AM +0530, Venkatraman S wrote:
> omap hsmmc controller IP has an inbuilt timer that can be programmed to
                                  ^^^^^^^
				  built-in
> guard against unresponsive operations. But it's range is very narrow,
                                             ^^^^
					     its


> and it's maximum countable time is a few seconds.
      ^^^^
      its


> Card maintenance operations like BKOPS and SECURE DISCARD and long
> stream writes like packed command require timers of order of
> several minutes.
> So get rid of using the IP timer entirely and use kernel's hrtimer
> functionality for guarding the device operations.
> As part of this change, a workaround that disabled timeouts for
> MMC_ERASE commands is removed, and the arbitary timing of 100ms
> is used only when the timeout is not explicitly specified by core.
>=20
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 96 ++++++++++++++++++++++---------------=
------
>  1 file changed, 50 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9afdd20..8f7cebc 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -79,7 +79,7 @@
>  #define CLKD_SHIFT		6
>  #define DTO_MASK		0x000F0000
>  #define DTO_SHIFT		16
> -#define INT_EN_MASK		0x307F0033
> +#define INT_EN_MASK		0x306E0033

not related to this patch in particular, but it would be nice if this
was converted to something more meaningfull, like ORing a bunch of bit
defines.

>  #define BWR_ENABLE		(1 << 4)
>  #define BRR_ENABLE		(1 << 5)
>  #define DTO_ENABLE		(1 << 20)
> @@ -160,6 +160,7 @@ struct omap_hsmmc_host {
>  	unsigned int		dma_sg_idx;
>  	unsigned char		bus_mode;
>  	unsigned char		power_mode;
> +	unsigned int		ns_per_clk_cycle;
>  	int			suspended;
>  	int			irq;
>  	int			use_dma, dma_ch;
> @@ -172,6 +173,7 @@ struct omap_hsmmc_host {
>  	int			reqs_blocked;
>  	int			use_reg;
>  	int			req_in_progress;
> +	struct hrtimer	guard_timer;
>  	struct omap_hsmmc_next	next_data;
> =20
>  	struct	omap_mmc_platform_data	*pdata;
> @@ -455,10 +457,6 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_=
host *host,
>  	else
>  		irq_mask =3D INT_EN_MASK;
> =20
> -	/* Disable timeout for erases */
> -	if (cmd->opcode =3D=3D MMC_ERASE)
> -		irq_mask &=3D ~DTO_ENABLE;
> -
>  	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
>  	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
>  	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> @@ -508,6 +506,9 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_ho=
st *host)
>  		&& time_before(jiffies, timeout))
>  		cpu_relax();
> =20
> +	if (ios->clock)
> +		host->ns_per_clk_cycle =3D DIV_ROUND_UP(NSEC_PER_SEC, ios->clock);
> +
>  	omap_hsmmc_start_clock(host);
>  }
> =20
> @@ -824,7 +825,7 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, st=
ruct mmc_data *data)
>  		omap_hsmmc_request_done(host, mrq);
>  		return;
>  	}
> -
> +	hrtimer_cancel(&host->guard_timer);
>  	host->data =3D NULL;
> =20
>  	if (!data->error)
> @@ -859,8 +860,11 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, st=
ruct mmc_command *cmd)
>  			cmd->resp[0] =3D OMAP_HSMMC_READ(host->base, RSP10);
>  		}
>  	}
> -	if ((host->data =3D=3D NULL && !host->response_busy) || cmd->error)
> +	if ((host->data =3D=3D NULL && !host->response_busy) || cmd->error) {

could just go ahead and make this check uniform by:

if ((!host->data && !host->response_busy)) || cmd->error)

> +		if (cmd->error !=3D -ETIMEDOUT)
> +			hrtimer_cancel(&host->guard_timer);
>  		omap_hsmmc_request_done(host, cmd->mrq);
> +	}
>  }
> =20
>  /*
> @@ -992,7 +996,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host =
*host, int status)
>  			hsmmc_command_incomplete(host, -EILSEQ);
> =20
>  		end_cmd =3D 1;
> -		if (host->data || host->response_busy) {
> +		if (data || host->response_busy) {

This doesn't seem like it belongs to $SUBJECT...

>  			end_trans =3D 1;
>  			host->response_busy =3D 0;
>  		}
> @@ -1292,41 +1296,35 @@ static int omap_hsmmc_start_dma_transfer(struct o=
map_hsmmc_host *host,
>  	return 0;
>  }
> =20
> -static void set_data_timeout(struct omap_hsmmc_host *host,
> -			     unsigned int timeout_ns,
> -			     unsigned int timeout_clks)
> +static void set_guard_timer(struct omap_hsmmc_host *host,
> +		unsigned long timeout_ms, unsigned long timeout_ns,
> +		unsigned int timeout_clks)
>  {
> -	unsigned int timeout, cycle_ns;
> -	uint32_t reg, clkd, dto =3D 0;
> +	ktime_t gtime;
> +	unsigned int sec, nsec;
> =20
> -	reg =3D OMAP_HSMMC_READ(host->base, SYSCTL);
> -	clkd =3D (reg & CLKD_MASK) >> CLKD_SHIFT;
> -	if (clkd =3D=3D 0)
> -		clkd =3D 1;
> +	sec =3D timeout_ms / MSEC_PER_SEC;
> +	nsec =3D (timeout_ms % MSEC_PER_SEC) * NSEC_PER_MSEC + timeout_ns;
> =20
> -	cycle_ns =3D 1000000000 / (clk_get_rate(host->fclk) / clkd);
> -	timeout =3D timeout_ns / cycle_ns;
> -	timeout +=3D timeout_clks;
> -	if (timeout) {
> -		while ((timeout & 0x80000000) =3D=3D 0) {
> -			dto +=3D 1;
> -			timeout <<=3D 1;
> -		}
> -		dto =3D 31 - dto;
> -		timeout <<=3D 1;
> -		if (timeout && dto)
> -			dto +=3D 1;
> -		if (dto >=3D 13)
> -			dto -=3D 13;
> -		else
> -			dto =3D 0;
> -		if (dto > 14)
> -			dto =3D 14;
> -	}
> +	nsec +=3D timeout_clks * host->ns_per_clk_cycle;
> +	gtime =3D ktime_set(sec, nsec);
> =20
> -	reg &=3D ~DTO_MASK;
> -	reg |=3D dto << DTO_SHIFT;
> -	OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
> +	hrtimer_start(&host->guard_timer, gtime, HRTIMER_MODE_REL);
> +}
> +
> +enum hrtimer_restart omap_hsmmc_timedout(struct hrtimer *gtimer)

static ?

--=20
balbi

--SWsnvgFfkTS2ATo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM2YoAAoJEIaOsuA1yqREjKMP/R/eojIx632OiW/TWDaTG1I6
xcHwjEUETbABbj5kyBTo8EKzN9dbcf/hJEeHihgoAmVrP13Xvw2macrrX/E56Thn
2JtACsEuyHHe+CAC10YLj5MGkOVwPHt0VKpaFp0bCiaov5zbW3SAl5NQDt9zjKN/
h2umsh1s3XLy8Khw8la7Jt8N5ZyBLH136OcF1nUm63V4+c9bKSotNO0vZfQ/Yfoh
EKJi2VQ7DPQPxv1qcSIhIFMZBQaItJWnGWkQlak4F5rluSrhddWIYbqIHsokan5O
XHKdK6bfwhdWHjb6/dGsMW6YIY3UVLjUdAVY+L4Yj5vr9LltjZDb3XX4afnqEwWR
zYSjnqAiDFUAKeUjB3l5tqE//LkmR3Xdhd9VB1SlXRQ9ymvOd690SyAgnYFx2x+x
CR8llV5eRUfEOS9QdUysYZk83bKnNrnuozG1mUIfUn9Adaj4XLrztbsw2yC3p58u
TUWRdsmgWhdFYPjatxCtxuBYfq+81ZWnHBixB9UU0FZpCSM44rQJPql0GS8Kk1t7
mgKCntZNzEj8YGT9ddWy09x+bQ9HVBFs2TsqLLilDKqgJhJciX+d4736efmN9LQ5
ANKiqeJisMqYqhE3j7ynp2cnG9afkCFm0lD3IMvf+5VIQQubRREWF6xNfb2T5RQR
N0pafXQK5F/L+gHxHRjj
=vW/H
-----END PGP SIGNATURE-----

--SWsnvgFfkTS2ATo5--
