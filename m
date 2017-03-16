From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: check also R1 response for stop commands
Date: Thu, 16 Mar 2017 12:33:33 +0100
Message-ID: <20170316113333.tcm2rllud5yrwrki@ninjato>
References: <20170314101501.25463-1-wsa+renesas@sang-engineering.com>
 <PS1PR06MB16924720592DB11B43DD5AF0D8240@PS1PR06MB1692.apcprd06.prod.outlook.com>
 <20170314104904.4ig62cy2w6fkpqzm@ninjato>
 <PS1PR06MB1692B56C7B571EBB02EB23C1D8270@PS1PR06MB1692.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e7e3335haxtis556"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <PS1PR06MB1692B56C7B571EBB02EB23C1D8270@PS1PR06MB1692.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--e7e3335haxtis556
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shimoda-san

> Anyway, I tested this patch. And the mmc core said some error happened.
> I think this is suitable behavior. So,
>=20
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thank you very much for the quick response and testing!

> < Question >
> In mmc_blk_cmd_recovery(), if "brq->stop.resp[0] & R1_CARD_ECC_FAILED" is=
 true, ecc_err is set to true.
> However, in mmc_blk_err_check(), ecc_err is only referred when brq->data.=
error is true.
> So, I guess we need a patch like below as another patch. What do you thin=
k?
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0e838b0..99c937b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1374,7 +1374,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct=
 mmc_ca
>                 return MMC_BLK_RETRY;
>         }
>=20
> -       if (brq->data.error) {
> +       if (brq->data.error || ecc_err) {
>                 if (need_retune && !brq->retune_retry_done) {
>                         pr_debug("%s: retrying because a re-tune was need=
ed\n",
>                                  req->rq_disk->disk_name);
>=20
> After that, the mmc core also output the following message:
>=20
> mmcblk1: error 0 transferring data, sector 0, nr 128, cmd response 0x900,=
 card status 0x200b00
> mmcblk1: retrying using single block read

I think you are right that we need to change something somewhere in this
code block. I was about to suggest adding "|| brq->stop.error" instead
of "|| ecc_err". However, I am not so sure about this as well, since the
code is a little confusing to me. Especially this:

1381                 if (rq_data_dir(req) =3D=3D READ) {=20
1382                         if (ecc_err)=20
1383                                 return MMC_BLK_ECC_ERR;=20
1384                         return MMC_BLK_DATA_ERR;
1385                 } else {
1386                         return MMC_BLK_CMD_ERR;
1387                 }

If the data_directions is WRITE, then we return a CMD_ERR instead of a
DATA_ERR? And all that in a code path which is only run when
brq->data.error, i.e. brq->cmd.err is not even touched?

I'd think the if-block in question wants to handle errors which happened
while transferring data. As such, I'd still think adding
"|| brq->stop.error" might be a good idea. And revisiting if this block
should really return CMD_ERR.

But I may be wrong and misunderstanding, so I am happy for further
opinions. Maybe the code needs just some more comments.

Thanks and regards,

   Wolfram


--e7e3335haxtis556
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljKeAgACgkQFA3kzBSg
Kbah2Q/8DtCzBOWirVTh+Z7EIN1kBZw99J3hIZ/zuETmQyfHen+cmC8r9VpbFrsi
Ky+/ylFStpWQ7mtIKtd6HiTxZRTQNwvnzAiE7SNOwAhuOnPxFpvVKZqEN3MV7xZl
xgBzm68tMPcxv6yeDmgZjtUkJwmLZsi9Dgf0fXYFEhg8ODYkV3ItlFkKvQIrWwTP
1vv3YW1qBdhRccaEFFxOxjtj7c3mPgJKX1D0ih13yYcHb5fRS6nPzRaW3Ha7u99a
Nnc14mSECgc1Vx/2x7kEfzQmGE8zMaHLKlD5z7YKjPDTOrUR1F5c9OV94lipdL0R
6E8cnx8WLd9ZVSRH4cVS9OJzXYObIkEemla6qy6fX2CFhNav9nNFbnEW9bI0IVTM
9Vmgf6JSj3rmxAHV4tnl6+82jRQKydnYmNdmOD68rBKFKO5+V38AKyXIvCh7Su8i
P7et0Q3kGLBvRY7Nqe/y6622Ewj+Sv8S7CqQXjS8rK9nQsMHIJ0DxxPLAq8vzWzz
SFZaN0UeJjdMf9EEpscXjK+l/5z7nENgC08NLiJYkNNkDgOZ/43Yy2BXPp+YdPRP
tVKwYOm5MQF0ZP46h4Sfdye7RElXeSrl73zYVDPs/Jm47RBP5KxKR4dctbnUARUc
V73jbkADS8deqc7EEGLEMD8hC1AD4Zu/0HFx6NUEqgRyre39Mo8=
=+ufA
-----END PGP SIGNATURE-----

--e7e3335haxtis556--
