From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: card: Fixup request missing in mmc_blk_issue_rw_rq
Date: Mon, 15 Jun 2015 11:55:50 +0200
Message-ID: <CAPDyKFq9L26iHUoK_2bV=bgCZWurADJZ=iDNCPQjYH0aSqQv0Q@mail.gmail.com>
References: <dbf65349aac343abbd215129dd3ceefb@SHMBX03.spreadtrum.com>
	<bf6c98d20e3e4fae9bf942e7682aba85@SHMBX03.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bf6c98d20e3e4fae9bf942e7682aba85@SHMBX03.spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?= <Justin.Wang@spreadtrum.com>
Cc: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "JBottomley@Odin.com" <JBottomley@odin.com>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "chuanxiao.dong@intel.com" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 June 2015 at 14:38, Justin Wang (=E7=8E=8B=E4=B8=81) <Justin.Wang=
@spreadtrum.com> wrote:
> From 0e01e7546745f39843d54810f74c198e01cb8226 Mon Sep 17 00:00:00 200=
1
> From: justin.wang <justin.wang@spreadtrum.com>
> Date: Mon, 18 May 2015 20:14:15 +0800
> Subject: [PATCH v2] mmc: card: Fixup request missing in mmc_blk_issue=
_rw_rq
>
> The current handler of MMC_BLK_CMD_ERR in mmc_blk_issue_rw_rq functio=
n
> may cause new coming request permanent missing when the ongoing
> request (previoulsy started) complete end.
>
> The problem scenario is as follows:
> (1) Request A is ongoing;
> (2) Request B arrived, and finally mmc_blk_issue_rw_rq() is called;
> (3) Request A encounters the MMC_BLK_CMD_ERR error;
> (4) In the error handling of MMC_BLK_CMD_ERR, suppose mmc_blk_cmd_err=
()
>     end request A completed and return zero. Continue the error handl=
ing,
>     suppose mmc_blk_reset() reset device success;
> (5) Continue the execution, while loop completed because variable ret
>     is zero now;
> (6) Finally, mmc_blk_issue_rw_rq() return without processing request =
B.
>
> The process related to the missing request may wait that IO request
> complete forever, possibly crashing the application or hanging the sy=
stem.
>
> Fix this issue by starting new request when reset success.
>
> Signed-off-by: Ding Wang <justin.wang@spreadtrum.com>

Thanks, applied for next.

I have added a the following fixes tag:
=46ixes 67716327eec7 ("mmc: block: add eMMC hardware reset support")
I am not sure, whether the bug were introduced even earlier than that,
but I think $subject patch should be trivial to apply on top that one.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 60f7141..f05cd1f 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1910,9 +1910,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queu=
e *mq, struct request *rqc)
>                         break;
>                 case MMC_BLK_CMD_ERR:
>                         ret =3D mmc_blk_cmd_err(md, card, brq, req, r=
et);
> -                       if (!mmc_blk_reset(md, card->host, type))
> -                               break;
> -                       goto cmd_abort;
> +                       if (mmc_blk_reset(md, card->host, type))
> +                               goto cmd_abort;
> +                       if (!ret)
> +                               goto start_new_req;
> +                       break;
>                 case MMC_BLK_RETRY:
>                         if (retry++ < 5)
>                                 break;
> --
> 1.7.4.1
>
