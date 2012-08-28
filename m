From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 1/2] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Tue, 28 Aug 2012 16:21:38 +0300
Message-ID: <20120828132134.GY27166@arwen.pp.htv.fi>
References: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwSFAA0Com6UqrPP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41058 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab2H1NZu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 09:25:50 -0400
Received: by lbao2 with SMTP id o2so3482696lba.24
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 06:25:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balbi@ti.com


--wwSFAA0Com6UqrPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2012 at 06:49:06PM +0530, Venkatraman S wrote:
> omap hsmmc controller IP has a built in timer that can be programmed to
> guard against unresponsive operations. But its range is very narrow,
> and the maximum countable time is a few seconds.
>=20
> Card maintenance operations like BKOPS and MMC_ERASE and long
> stream writes like packed command require timers of order of
> several minutes, much beyond the capability of the IP timer.
> So get rid of using the IP timer entirely and use kernel's hrtimer
> functionality for guarding the device operations.
> As part of this change, a workaround that disabled timeouts for
> MMC_ERASE command is removed, and the arbitary timing of 100ms
> is used only when the timeout is not explicitly specified by core.
>=20
> A trivial change to get rid of unnecessary dealiasing of host->data
> in omap_hsmmc_do_irq is also included.
>=20
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Now it looks good:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>=20
> v1->v2:
>    Fix typos in commit message.
>    Add checks to handle subtle races between MMC IRQ and HRTIMER IRQ
>    Mark set_guard_timer function as static
>    (Felipe's comment to use macros for INT_EN_MASK is done as a separate =
patch )
>  drivers/mmc/host/omap_hsmmc.c | 96 ++++++++++++++++++++++---------------=
------
>  1 file changed, 50 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 9afdd20..57e86a4 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -79,7 +79,7 @@
>  #define CLKD_SHIFT		6
>  #define DTO_MASK		0x000F0000
>  #define DTO_SHIFT		16
> -#define INT_EN_MASK		0x307F0033
> +#define INT_EN_MASK		0x306E0033
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
> +static enum hrtimer_restart omap_hsmmc_timedout(struct hrtimer *gtimer)
> +{
> +	struct omap_hsmmc_host *host;
> +	host =3D container_of(gtimer, struct omap_hsmmc_host, guard_timer);
> +	if (host->req_in_progress) {
> +		omap_hsmmc_disable_irq(host);
> +		hsmmc_command_incomplete(host, -ETIMEDOUT);
> +		host->response_busy =3D 0;
> +		omap_hsmmc_cmd_done(host, host->cmd);
> +		if (host->data)
> +			omap_hsmmc_xfer_done(host, host->data);
> +	}
> +	return HRTIMER_NORESTART;
>  }
> =20
>  /*
> @@ -1340,18 +1338,22 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *h=
ost, struct mmc_request *req)
> =20
>  	if (req->data =3D=3D NULL) {
>  		OMAP_HSMMC_WRITE(host->base, BLK, 0);
> -		/*
> -		 * Set an arbitrary 100ms data timeout for commands with
> -		 * busy signal.
> -		 */
> -		if (req->cmd->flags & MMC_RSP_BUSY)
> -			set_data_timeout(host, 100000000U, 0);
> +		if (req->cmd->cmd_timeout_ms =3D=3D 0) {
> +			/*
> +			 * Set an arbitrary 100ms data timeout for commands with
> +			 * busy signal.
> +			 */
> +			set_guard_timer(host, 100, 0, 0);
> +		} else {
> +			set_guard_timer(host, req->cmd->cmd_timeout_ms, 0, 0);
> +		}
>  		return 0;
>  	}
> =20
>  	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
>  					| (req->data->blocks << 16));
> -	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
> +	set_guard_timer(host, 0, req->data->timeout_ns,
> +			req->data->timeout_clks);
> =20
>  	if (host->use_dma) {
>  		ret =3D omap_hsmmc_start_dma_transfer(host, req);
> @@ -1921,6 +1923,8 @@ static int __devinit omap_hsmmc_probe(struct platfo=
rm_device *pdev)
>  		pdata->suspend =3D omap_hsmmc_suspend_cdirq;
>  		pdata->resume =3D omap_hsmmc_resume_cdirq;
>  	}
> +	hrtimer_init(&host->guard_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	host->guard_timer.function =3D omap_hsmmc_timedout;
> =20
>  	omap_hsmmc_disable_irq(host);
> =20
> --=20
> 1.7.11.1.25.g0e18bef
>=20

--=20
balbi

--wwSFAA0Com6UqrPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQPMXeAAoJEIaOsuA1yqREC/UP/1ok5BA+GGrya/hSFm5Ur9Qr
ma3ZCVINoku5EfPxTpEYPZE8u6UlhKSfWdF26ulhPDh769GluwWMfP1nfv3kACJP
gYP8x5v6aRixbIIoePHx9ABbET2Vqz/LcVWlucgMOyJDXJCbcClLbilSzPUtAKln
YYCLjxrTqradaEU5qVT4IUTnpiQ5BQ/FUmW18IjUVNxQSz7lzRMWWaNpnXV61N7Z
wdWeK/TD/FqaByKhX8fKbROdpNIy1F/ACBJGfkJ2W7+Sgfu8Vj19dq2ATe/EfRs+
5fNwDHrJXoNJX9EwwezUmXv4zzWRq5+1XPiKqx4FhxUTrI73X4nAPJpcBjQTEZmn
/5RJer7JMqGavsfVvI3AgVRhTX+lZxkTEweUXF3U1B8LVSsRhvqFGi8zZtYVdb6G
X9Kuy8KcTIm9+A+iqoEr+tkiKpfA4ErgJJduAfn6XYlz6EVU8Ddjbb0g04c0ip54
qnq6xbIXAQOwaK1DsmN9rRZIxsn1WRs08L6OREn6RWQJov+XHchmX2/zxi/8Lb9n
XXlplHYL+3XlnPerw8B/smDDsI4/J0zoBdwdokF2KbUF2IozwrbcyKjZGEq+AkJ7
42KeqeYAt9UgQk3TXC6nQtQXA+B1a6Fg6Xt0DiRayi9KZd59wWLxhbeEIZez0cSu
L+wY0i3a/6RebUPNDLMv
=+JaT
-----END PGP SIGNATURE-----

--wwSFAA0Com6UqrPP--
