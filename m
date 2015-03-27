From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] mmc: core: Enable runtime PM management of host devices
Date: Sat, 28 Mar 2015 08:52:42 +1100
Message-ID: <20150328085242.5e1e1acc@notabene.brown>
References: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5_yc_eL0_HeWzJZ5AvPenlP"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbbC0VxA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 17:53:00 -0400
In-Reply-To: <1427454915-12893-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

--Sig_/5_yc_eL0_HeWzJZ5AvPenlP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2015 12:15:15 +0100 Ulf Hansson <ulf.hansson@linaro.org> wro=
te:

> Currently those host drivers which have deployed runtime PM, deals with
> the runtime PM reference counting entirely by themselves.
>=20
> Since host drivers don't know when the core will send the next request
> through some of the host_ops callbacks, they need to handle runtime PM
> get/put between each an every request.
>=20
> In quite many cases this has some negative effects, since it leads to a
> high frequency of scheduled runtime PM suspend operations. That due to
> the runtime PM reference count will normally reach zero in-between
> every request.

I don't understand why this is a problem.
All the drivers use put_autosuspend, so the suspend doesn't happen for
(typically) 50ms, so the actually suspend won't happen if there is a sequen=
ce
of requests.

Is it just the scheduling of a suspend - even without the suspend happening=
 -
that is causing problems?  If so, maybe the runtime_pm code needs optimisin=
g?

Thanks,

NeilBrown


>=20
> We can decrease that frequency, by enabling the core to deal with
> runtime PM reference counting of the host device. Since the core often
> knows that it will send a seqeunce of requests, it makes sense for it
> to keep a runtime PM reference count during these periods.
>=20
> More exactly, let's increase the runtime PM reference count by invoking
> pm_runtime_get_sync() from __mmc_claim_host(). Restore that action by
> invoking pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend()
> in mmc_release_host(). In this way a runtime PM reference count will be
> kept during the complete cycle of a claim -> release host.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 709ada9..c296bc0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -897,6 +897,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t =
*abort)
>  	DECLARE_WAITQUEUE(wait, current);
>  	unsigned long flags;
>  	int stop;
> +	bool pm =3D false;
> =20
>  	might_sleep();
> =20
> @@ -916,13 +917,18 @@ int __mmc_claim_host(struct mmc_host *host, atomic_=
t *abort)
>  		host->claimed =3D 1;
>  		host->claimer =3D current;
>  		host->claim_cnt +=3D 1;
> +		if (host->claim_cnt =3D=3D 1)
> +			pm =3D true;
>  	} else
>  		wake_up(&host->wq);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  	remove_wait_queue(&host->wq, &wait);
> +
> +	if (pm)
> +		pm_runtime_get_sync(mmc_dev(host));
> +
>  	return stop;
>  }
> -
>  EXPORT_SYMBOL(__mmc_claim_host);
> =20
>  /**
> @@ -947,6 +953,8 @@ void mmc_release_host(struct mmc_host *host)
>  		host->claimer =3D NULL;
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		wake_up(&host->wq);
> +		pm_runtime_mark_last_busy(mmc_dev(host));
> +		pm_runtime_put_autosuspend(mmc_dev(host));
>  	}
>  }
>  EXPORT_SYMBOL(mmc_release_host);


--Sig_/5_yc_eL0_HeWzJZ5AvPenlP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRXRKjnsnt1WYoG5AQLZLw/+MbRNNcDCh9VRAo4Ivp0/HZyezWDPoHPQ
rDO7Sx/YVCxOFTgN3kS7/uwkH3HLd+EI+v9Pxm2OI4U2tpA5QNwGsFcxtHaDx0m8
Se03d5VbR+Y/VP/uOpt4JIItMbLPwWBnX3XstYmwgSnD5Y0QL5p5mrpGIQWyjtZ6
dGJnCL44vX3VF14ulZRPtHUfx9N+n+FNqLPvay+VUWQAWB9gHeftylmUIiaSERTa
NJn5NvlCL6DE56X3J2hbgvUXkJlwJAeVSt1hu1JM1lBYBLWaAphy1uQHxKVEYNyr
QNfwPTMvCHGApZU6S5541qg1pTPTOB9dXzHg8QmQx+M53i+/ix0D9gKng5ZkGvjb
Du08EiRE96SUxrcEXNG2Gp0DzDBvQZMcA/4FUxw0Qek9XZNix4OQnS70AkjxrjCN
JRSyVdvCNwZyw2snJs13wyP/RRRzOmiidnW4BRjl5emkmJYQRMkK0DTFzhSoTYwX
HeNZeVkYBw1YLosaiUBky6be8tBcsbFOOVS1W2nH0HNP2UrYPGT8IcK2CdsYeiO4
ZRGDcIW20MlABEk0NdIoKXq7Dufm8op5kU68fn0OLk/KjRBzYdIS2lRdOyv4hLvn
fGPqqJmQhf7QjP3Ll1RYoImTSnIiBdCz7nFJ/940ACswfTGJbvYf2wifESeC8VS/
dCpXyLlSTMU=
=eD53
-----END PGP SIGNATURE-----

--Sig_/5_yc_eL0_HeWzJZ5AvPenlP--
