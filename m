From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Fix compile time warning for uninitalized
 variables
Date: Fri, 25 Nov 2011 12:06:49 +0200
Message-ID: <4ECF68B9.7050708@intel.com>
References: <1322043102-28050-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46569 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764Ab1KYKGx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Nov 2011 05:06:53 -0500
In-Reply-To: <1322043102-28050-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kyungmin.park@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

On 23/11/11 12:11, Tushar Behera wrote:
> This patch fixes following compile time warnings.
>=20
> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_rq=E2=80=
=99:
> drivers/mmc/card/block.c:828:18: warning: =E2=80=98arg=E2=80=99 may b=
e used uninitialized in this function [-Wun    initialized]
> drivers/mmc/card/block.c:794:25: note: =E2=80=98arg=E2=80=99 was decl=
ared here
> drivers/mmc/card/block.c:827:6: warning: =E2=80=98nr=E2=80=99 may be =
used uninitialized in this function [-Wunin    itialized]
> drivers/mmc/card/block.c:794:21: note: =E2=80=98nr=E2=80=99 was decla=
red here
> drivers/mmc/card/block.c:827:6: warning: =E2=80=98from=E2=80=99 may b=
e used uninitialized in this function [-Wun    initialized]
> drivers/mmc/card/block.c:794:15: note: =E2=80=98from=E2=80=99 was dec=
lared here
>=20
> If the code follows the labels 'out' and 'retry', then we get
> to situation when these variables are used uninitialized.
>=20
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>=20
> The patch is rebased on v3.2-rc2.
>=20
> I don't have much idea on what should be the default value
> for these variables. The fixes are provided just to do away
> with the compile time warnings.

It is a "goto" that is wrong, not the initialization.

But there is another problem.  The sanitize code is
side-stepping the reset and retry path entirely.


>=20
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a1cb21f..8e0ffe9 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -791,7 +791,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc=
_queue *mq,
>  {
>  	struct mmc_blk_data *md =3D mq->data;
>  	struct mmc_card *card =3D md->queue.card;
> -	unsigned int from, nr, arg;
> +	unsigned int from =3D 0, nr =3D 0, arg =3D 0;
>  	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
> =20
>  	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {

