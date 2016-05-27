From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/4] mmc: tmio: Add tuning support
Date: Fri, 27 May 2016 13:47:15 +0200
Message-ID: <20160527114715.GC1663@katana>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
 <1464057797-29951-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464057797-29951-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct tmio_mmc_host *host =3D mmc_priv(mmc);
> +	unsigned int num =3D 0;
> +	int i, ret =3D 0;
> +	bool *tap;
> +
> +	if (host->init_tuning)
> +		num =3D host->init_tuning(host);
> +	if (!num) {
> +		/* Tuning is not supported */
> +		ret =3D 0;

ret is already 0 here. Not sure to remove the redundancy, though. This
is clearer and easier to read.

> +		goto out;
> +	}
> +
> +	tap =3D kmalloc(num * 2, GFP_KERNEL);
> +	if (!tap) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Issue CMD19 twice for each tap
> +	 */
> +	for (i =3D 0; i < 2 * num; i++) {
> +		int err;

Maybe drop err here...

> +
> +		if (host->prepare_tuning)
> +			host->prepare_tuning(host, i);
> +
> +		err =3D mmc_send_tuning(host->mmc, opcode, NULL);
> +		if (err && err !=3D -EILSEQ) {
> +			ret =3D err;
> +			goto err_free;

=2E.. use ret here directly ...

> +		}
> +		tap[i] =3D (err =3D=3D 0);
> +
> +		mdelay(1);
> +	}

=2E.. and set ret =3D 0 here ?

> +
> +	if (host->select_tuning)
> +		ret =3D host->select_tuning(host, tap, num * 2);

I wonder if we shouldn't check the validity of the function pointers
together at the beginning of the function and bail out if some pointer
is missing? The above block skips the OOPS but it doesn't make sense to
not select something, or?

> +
> +err_free:
> +	kfree(tap);
> +out:
> +	if (ret < 0) {
> +		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
> +		tmio_mmc_hw_reset(mmc);
> +	} else {
> +		host->mmc->retune_period =3D 0;
> +	}
> +
> +	return ret;
> +
> +}
> +
>  /* Process requests from the MMC layer */
>  static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *m=
rq)
>  {
> @@ -781,6 +851,14 @@ static void tmio_mmc_request(struct mmc_host *mmc, s=
truct mmc_request *mrq)
> =20
>  	spin_unlock_irqrestore(&host->lock, flags);
> =20
> +	if (mrq->sbc) {
> +		ret =3D tmio_mmc_start_command(host, mrq->sbc);
> +		if (ret)
> +			goto fail;
> +		host->last_req_ts =3D jiffies;
> +		host->mrq =3D mrq;
> +	}

Is this related? Maybe a comment would help?

> +
>  	if (mrq->data) {
>  		ret =3D tmio_mmc_start_data(host, mrq->data);
>  		if (ret)
> @@ -978,6 +1056,8 @@ static struct mmc_host_ops tmio_mmc_ops =3D {
>  	.enable_sdio_irq =3D tmio_mmc_enable_sdio_irq,
>  	.card_busy	=3D tmio_mmc_card_busy,
>  	.multi_io_quirk	=3D tmio_multi_io_quirk,
> +	.execute_tuning =3D tmio_mmc_execute_tuning,
> +	.hw_reset	=3D tmio_mmc_hw_reset,
>  };
> =20
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> @@ -1202,6 +1282,9 @@ int tmio_mmc_host_runtime_suspend(struct device *de=
v)
>  	struct mmc_host *mmc =3D dev_get_drvdata(dev);
>  	struct tmio_mmc_host *host =3D mmc_priv(mmc);
> =20
> +	mmc_retune_timer_stop(host->mmc);
> +	mmc_retune_needed(host->mmc);
> +
>  	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);

All in all, this looks way better now. Thanks!


--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSDPDAAoJEBQN5MwUoCm2jPYP/2UigwnTOYS6yu7oXN4ZSsJo
qxEKBAeMMtwSsbYU3Afqs4n580ONKAAKslfcNdQgOu3YtZ49YYGXZiZWEFwJdbSi
PF/hSHPGDWIwhseXqNDULMIc3GHCWchwVlhPx2utWcW72jB4zBm6EEliJ1IQ6w7h
m5w2Gdphi9LUBTCpd/RsG/rECZTaasPEYUM3QEO9RRTNyEpM2muRQptSpsloIliS
8U/8T8MP0XRm5nmiWXsgla0kv/c+9w5eck+rlb1N30yDYAMpwDBLztPFhCsvY3Va
N0kSKvFfuSYummraQHcoLagDZAliE7usVdjSWTAeQhFDL1GGRNKjtU0W4tutZT8d
c8LhHmqQ9u1G1xb5Z/5vTXKZawDU0P6nEr43WNPObRibYeLVChkmkL6b79K2JeMO
MxKOa5O4EyYaryNgFSqMPbtgTf2IC+51t1z20xXUXsH/pixJCqX/0z3iBXF3iIGH
XSvoJ1jaPLH4yIj4EkfGNHRYe0iZw3+0FKuRtgXNFzp6Tt1fUikyzTtYRJ40nCkl
Kyd+YHvQb1ICtxKnN8XKyPb2UwBzb9OSxT4YFpOpb4eJ5kmgaYBgsZu5lN+k5uQH
EaGzN2vMkPgytm8FZYQns5+2MQ9VeMDmQqHfFKdFGLBOMmgnYlas4FIDcSte/XKs
iHzqqzkesuBQDpJUHxfV
=SvER
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
