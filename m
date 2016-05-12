From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Thu, 12 May 2016 18:50:05 +0200
Message-ID: <20160512165005.GC13121@katana>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47613 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbcELQuY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2016 12:50:24 -0400
Content-Disposition: inline
In-Reply-To: <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

nice you got it working with upstream! Thanks. It still looks a bit too
much like BSP code, though, so we need to clean it up. I found 'git log
--grep=3Dtuning drivers/mmc/host' to be useful to get an idea of current
best practices.

> +	bool (*inquiry_tuning)(struct tmio_mmc_host *host);

Do we really need this? I'd think the core will check that tuning only
gets called when needed.

> -static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
> +static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int s=
tat)
>  {
>  	struct mmc_data *data;
>  	spin_lock(&host->lock);
> @@ -529,6 +558,9 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *h=
ost)
>  	if (!data)
>  		goto out;
> =20
> +	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
> +	    stat & TMIO_STAT_TXUNDERRUN)
> +		data->error =3D -EILSEQ;
>  	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio=
) {
>  		u32 status =3D sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
>  		bool done =3D false;
> @@ -577,8 +609,6 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *ho=
st,
>  		goto out;
>  	}
> =20
> -	host->cmd =3D NULL;
> -
>  	/* This controller is sicker than the PXA one. Not only do we need to
>  	 * drop the top 8 bits of the first response word, we also need to
>  	 * modify the order of the response for short response command types.
> @@ -598,14 +628,16 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *=
host,
> =20
>  	if (stat & TMIO_STAT_CMDTIMEOUT)
>  		cmd->error =3D -ETIMEDOUT;
> -	else if (stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC)
> +	else if ((stat & TMIO_STAT_CRCFAIL && cmd->flags & MMC_RSP_CRC) ||
> +		 stat & TMIO_STAT_STOPBIT_ERR ||
> +		 stat & TMIO_STAT_CMD_IDX_ERR)
>  		cmd->error =3D -EILSEQ;
> =20
>  	/* If there is data to handle we enable data IRQs here, and
>  	 * we will ultimatley finish the request in the data_end handler.
>  	 * If theres no data or we encountered an error, finish now.
>  	 */
> -	if (host->data && !cmd->error) {
> +	if (host->data && (!cmd->error || cmd->error =3D=3D -EILSEQ)) {
>  		if (host->data->flags & MMC_DATA_READ) {
>  			if (host->force_pio || !host->chan_rx)
>  				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
> @@ -666,7 +698,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_hos=
t *host,
>  	/* Data transfer completion */
>  	if (ireg & TMIO_STAT_DATAEND) {
>  		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
> -		tmio_mmc_data_irq(host);
> +		tmio_mmc_data_irq(host, status);
>  		return true;
>  	}

I wonder if the changes to this tmio_mmc_*_irq are a seperate patch?
I'd think they need a seperate description.

> =20
> @@ -753,6 +785,157 @@ static int tmio_mmc_start_data(struct tmio_mmc_host=
 *host,
>  	return 0;
>  }
> =20
> +#define TMIO_MMC_MAX_TUNING_LOOP 40
> +
> +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{

I'd think we can use mmc_send_tuning() from the mmc core here in here.

> +	struct tmio_mmc_host *host =3D mmc_priv(mmc);
> +	struct mmc_ios *ios =3D &mmc->ios;
> +
> +	unsigned long timeout, val;
> +	unsigned long *tap;
> +	int tuning_loop_counter =3D TMIO_MMC_MAX_TUNING_LOOP;
> +	int ret, timeleft;
> +
> +	struct mmc_request mrq =3D {NULL};
> +	struct mmc_command cmd =3D {0};
> +	struct mmc_data data =3D {0};
> +	struct scatterlist sg;
> +	u8 *data_buf;
> +	unsigned int num, tm =3D CMDREQ_TIMEOUT;
> +	unsigned long flags;
> +
> +	if ((ios->timing !=3D MMC_TIMING_UHS_SDR50 &&
> +	     ios->timing !=3D MMC_TIMING_UHS_SDR104) ||
> +	    (host->inquiry_tuning && !host->inquiry_tuning(host)) ||
> +	    host->done_tuning || !host->init_tuning)
> +		return 0;
> +
> +	num =3D host->init_tuning(host);
> +
> +	tap =3D kmalloc(num * 2, GFP_KERNEL);
> +	if (tap =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_tap;
> +	}
> +
> +	data_buf =3D kmalloc(64, GFP_KERNEL);
> +	if (data_buf =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_data;
> +	}
> +
> +	val =3D 0;
> +
> +	/*
> +	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
> +	 * of loops reaches 40 times or a timeout of 150ms occurs.
> +	 */

Note to self: this is copied from sdhci.c

So far for now!

Thanks,

   Wolfram


--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNLQ9AAoJEBQN5MwUoCm2Z84P/1CR4SqngoJcAlSsG3EmwHlF
+Qhxbh7r25r6eR8TVmtCCPErY6odws84sgDrHu2xcrB1tZi6THy206w90tMp8pi7
9lZx6r7iHyhqyCvuI8m3RnynJSc8EWxZEP4CWvrUGfhQASnzbMEEzMqO26YLHrfX
YVpimV/P64KBt8iIgx7juhFPUbqmSjopLfrSzOzf7vIUD/n2vg9xZ8Nm2znXcBdB
9LUUOBOPAv48b9qTAfh8AZKP5Jf3BeCQ8SHO9sWTU5HLNm6Mq1Z6J2NTeHXS9E0Q
QpuEvjMwxk4QtfXEsSwWV6T62syri2E6PNfgGEQsk/fMR6nwTXjVA9UyCXpIYH9u
CaCr4IqcPzvoUeVGoYVZ9/XUs0UquPAMq4DetIB3+pIiyAFGsBznPKeZzq9qEGp7
7KP7heOJU/Amd+5EUV/Ux9zpw9TrPZrQkreX8C1t25TY51yKoDUz+jxCWRdSGLIt
QrICzjyZS+GfhrCwd08xU0cYboCugTqBJjGOuolumfJiz8LnO6EoU2ru6N3qJVp7
8ZCj0kqNQPFK+fpjMEGBiQf8CFVZ99Gwx95MLLCdWDxNI9w/2l4qygkMmV7q2QYi
ily6ppeFVSy9MVyBu5hOTpGh0Xdu71SOEOcXyPNlzS5KjYGjtpiGsCpOiQL4V69n
5vC3KvWfZeXgmiyx5M9b
=/NYv
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
