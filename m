From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: fix card block compile warnings
Date: Thu, 22 Mar 2012 11:58:03 +0100
Message-ID: <4F6B05BB.3080109@stericsson.com>
References: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:59838 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753474Ab2CVK7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 06:59:00 -0400
In-Reply-To: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 03/22/2012 08:35 AM, Linus Walleij wrote:
> I'm pretty tired of seeing these in my kernel compiles:
> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_secdisca=
rd_rq=E2=80=99:
> drivers/mmc/card/block.c:911:18: warning: =E2=80=98arg=E2=80=99 may b=
e used uninitialized in this function [-Wuninitialized]
> drivers/mmc/card/block.c:910:6: warning: =E2=80=98nr=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]
> drivers/mmc/card/block.c:910:6: warning: =E2=80=98from=E2=80=99 may b=
e used uninitialized in this function [-Wuninitialized]
>
> This patch marks the variables explicitly uninitialized as
> seems to be the intention, I can assure myself they are not
> actually uninitialized at use time by just reading the code.
>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   drivers/mmc/card/block.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c6a383d..214ae68 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -874,7 +874,9 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc=
_queue *mq,
>   {
>   	struct mmc_blk_data *md =3D mq->data;
>   	struct mmc_card *card =3D md->queue.card;
> -	unsigned int from, nr, arg;
> +	unsigned int uninitialized_var(from);
> +	unsigned int uninitialized_var(nr);
> +	unsigned int uninitialized_var(arg);
>   	int err =3D 0, type =3D MMC_BLK_SECDISCARD;
>
>   	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) =
{

Is not the problem only related to the arg variable?

What about:
	unsigned int from, nr, arg =3D 0;

Yours!

Ulf Hansson

