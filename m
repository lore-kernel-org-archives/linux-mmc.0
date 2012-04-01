From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: card: move variable initialization earlier
Date: Sun, 01 Apr 2012 00:07:47 -0400
Message-ID: <8762dkm6wc.fsf@laptop.org>
References: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36348 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab2DAEHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Apr 2012 00:07:47 -0400
In-Reply-To: <1332495146-16312-1-git-send-email-linus.walleij@linaro.org>
	(Linus Walleij's message of "Fri, 23 Mar 2012 10:32:26 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Rabin Vincent <rabin@rab.in>, Adrian Hunter <adrian.hunter@intel.com>

Hi Adrian,

On Fri, Mar 23 2012, Linus Walleij wrote:
> I was pretty tired of seeing these in my kernel compiles:
>
> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdisca=
rd_rq=E2=80=99:
> drivers/mmc/card/block.c:911:18: warning: =E2=80=98arg=E2=80=99 may b=
e used uninitialized in this function [-Wuninitialized]
> drivers/mmc/card/block.c:910:6: warning: =E2=80=98nr=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]
> drivers/mmc/card/block.c:910:6: warning: =E2=80=98from=E2=80=99 may b=
e used uninitialized in this function [-Wuninitialized]
>
> The problem stems from the code path in
> mmc_blk_issue_secdiscard_rq() where mmc_switch()
> with EXT_CSD_SANITIZE_START may return -EIO and fall back
> to using the default trim operations instead. At this point
> the variables needed for the fallback will be uninitialized.
>
> Cc: Ulf Hansson <ulf.hansson@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I don't know if this is the actual intention - maybe we
> should just fail the call entirely if the sanitize command
> fails?

I think you (Adrian) introduced this "goto out->goto retry" logic in
upstream commit 67716327eec7e9 -- please could you take a look here?

> ---
>  drivers/mmc/card/block.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c6a383d..2741d93 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -877,6 +877,14 @@ static int mmc_blk_issue_secdiscard_rq(struct mm=
c_queue *mq,
>  	unsigned int from, nr, arg;
>  	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
> =20
> +	from =3D blk_rq_pos(req);
> +	nr =3D blk_rq_sectors(req);
> +
> +	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
> +		arg =3D MMC_SECURE_TRIM1_ARG;
> +	else
> +		arg =3D MMC_SECURE_ERASE_ARG;
> +
>  	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {
>  		err =3D -EOPNOTSUPP;
>  		goto out;
> @@ -889,13 +897,6 @@ static int mmc_blk_issue_secdiscard_rq(struct mm=
c_queue *mq,
>  		goto out;
>  	}
> =20
> -	from =3D blk_rq_pos(req);
> -	nr =3D blk_rq_sectors(req);
> -
> -	if (mmc_can_trim(card) && !mmc_erase_group_aligned(card, from, nr))
> -		arg =3D MMC_SECURE_TRIM1_ARG;
> -	else
> -		arg =3D MMC_SECURE_ERASE_ARG;
>  retry:
>  	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>  		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
