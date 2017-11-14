From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH] mmc: card: increase wait time
Date: Tue, 14 Nov 2017 12:44:42 +0000
Message-ID: <DM5PR04MB1085B1BAE62048DF2054E5B2FC280@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <CGME20171114024825eucas1p218873c4ff649c17d4061b6660aa6264f@eucas1p2.samsung.com>
 <1510627683-5209-1-git-send-email-huijin.park@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55009 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbdKNMot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Nov 2017 07:44:49 -0500
In-Reply-To: <1510627683-5209-1-git-send-email-huijin.park@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huijin Park <huijin.park@samsung.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "bbang.huijin.park@gmail.com" <bbang.huijin.park@gmail.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Huijin Park
> Sent: Tuesday, November 14, 2017 4:48 AM
> To: ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; bbang.huijin.park@gmail.com; Huijin Park
> <huijin.park@samsung.com>
> Subject: [PATCH] mmc: card: increase wait time
>=20
> Some eMMC products keep busy time a little longer intermittently.
> (eg. prepare free blocks, garbage collection...) In this case, we recomme=
nd to
> wait a little longer than fail.
>=20
> Signed-off-by: Huijin Park <huijin.park@samsung.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> ea80ff4..b5b0fe6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -584,7 +584,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>  		 * Ensure RPMB command has completed by polling CMD13
>  		 * "Send Status".
>  		 */
> -		err =3D ioctl_rpmb_card_status_poll(card, &status, 5);
> +		err =3D ioctl_rpmb_card_status_poll(card, &status, 50);
 Is this up to 1.25 sec or am I counting wrong?
5[msec] x 5 [__mmc_send_status] x 50=20

>  		if (err)
>  			dev_err(mmc_dev(card->host),
>  					"%s: Card Status=3D0x%08X, error
> %d\n",
> --
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
