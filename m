From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] mmc:Fix error handling in the function mmc_blk_remove
Date: Tue, 21 Jul 2015 19:03:33 +0100
Message-ID: <1437501813.29812.11.camel@decadent.org.uk>
References: <1437485391-25505-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EXC/8tm4uIjWbpMTe+vx"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33187 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755042AbbGUSDy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 14:03:54 -0400
In-Reply-To: <1437485391-25505-1-git-send-email-xerofoify@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>, ulf.hansson@linaro.org
Cc: kuninori.morimoto.gx@renesas.com, jh80.chung@samsung.com, adrian.hunter@intel.com, chuanxiao.dong@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--=-EXC/8tm4uIjWbpMTe+vx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-07-21 at 09:29 -0400, Nicholas Krause wrote:
> This fixes error handling in the function mmc_blk_remove by
> checking the return value of the call to mmc_blk_part_switch
> and if it has failed by returning a error code we now print
> out on the console to the user that removed the mmc device
> has failed before returning immediately.

A removal function isn't allowed to fail.  Printing an error message
seems reasonable (though it should be printed using one of the dev_
logging functions), but returning early is not.

Ben.

> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/card/block.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c9c3d20..24af338 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2508,7 +2508,10 @@ static void mmc_blk_remove(struct mmc_card *card)
>  > 	> mmc_blk_remove_parts(card, md);
>  > 	> pm_runtime_get_sync(&card->dev);
>  > 	> mmc_claim_host(card->host);
> -> 	> mmc_blk_part_switch(card, md);
> +> 	> if (mmc_blk_part_switch(card, md)) {
> +> 	> 	> pr_crit("Unable to successfully remove %s due to failed mmc_blk_=
part_switch call\n", card->part[MMC_NUM_PHY_PARTITION].name);
> +> 	> 	> return;
> +> 	> }
>  > 	> mmc_release_host(card->host);
>  > 	> if (card->type !=3D MMC_TYPE_SD_COMBO)
>  > 	> 	> pm_runtime_disable(&card->dev);
--=20
Ben Hutchings
No political challenge can be met by shopping. - George Monbiot


--=-EXC/8tm4uIjWbpMTe+vx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVa6Jdee/yOyVhhEJAQoH0xAAlykfx4tFXZmIZlNLfq/54Ib/ec/z6+7s
iLvg3K56EYuYWdXEqQhTPWgnebbk2GH6uv2CGIN7Ff9ZOCP8FgJyTIRxGVTq3YGy
96g4kuLQmWBdxKMZom0Wx7O/AxwUZLwlqkICf4h7afoggZPEVfjt2DYQxJHMVqsM
vycu5YNN62V2IHRN97CGevQ9TBeFp4+FR/bqDMyOQs/nP87VRSJRfcNSABxME2+2
EbpPQt0QDCitWkmZdmicMT7sCuT5YhBgrAN1Ka9r9xHM9YdVAiXcgs2bTlwM6zK+
iPFybxV5SJAnk/4zC+6c35X72gziEV+keJBjKXPPaJiJZiWaFxO+arrnLVeTFYU2
WLjQf8Gnf+mfsRHRmZ3yA4ClsBlgJTRVVephCA3Rf9DNcquO4tzRRzBKOE/0ig4D
yVc2IN4FwFE8Xvr6ng8PGXZmrqfibURucjlRfFZCl4Dfot4Z6umiAPkg+SFkqsiq
g6jaBU/dnMNTakd+rLVEWClTd5ISZwVs7Jk8APJhnyiU1RlUS0cOxRiWBiwaOe01
6LptbsJxkuuT8e6WTq5EZZcydw681at5fthgklSeqgaHmzjc156aNLT0nukFgmEM
X3xi9FA8TF7ffK0wdJYSoYfRy8g6KSR1OhsSjvLCf+e+e1nDvwkffGYZ2EsG/qAA
6D818Q/JaWQ=
=2qVT
-----END PGP SIGNATURE-----

--=-EXC/8tm4uIjWbpMTe+vx--
