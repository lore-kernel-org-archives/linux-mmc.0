From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card: Fixup request missing in mmc_blk_issue_rw_rq
Date: Thu, 28 May 2015 10:29:16 +0200
Message-ID: <CAPDyKFrpScGLoUAmO07YPmF+6gG1iYg0X4zuyUtWQFTb9hJ4RQ@mail.gmail.com>
References: <dbf65349aac343abbd215129dd3ceefb@SHMBX03.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbf65349aac343abbd215129dd3ceefb@SHMBX03.spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?= <Justin.Wang@spreadtrum.com>
Cc: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "JBottomley@Odin.com" <JBottomley@odin.com>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "chuanxiao.dong@intel.com" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 May 2015 at 08:32, Justin Wang (=E7=8E=8B=E4=B8=81) <Justin.Wang@=
spreadtrum.com> wrote:
> From 05849da563c80c20597ab6275d5881a8ed426f96 Mon Sep 17 00:00:00 200=
1
> From: justin.wang <justin.wang@spreadtrum.com>
> Date: Mon, 18 May 2015 20:14:15 +0800
> Subject: [PATCH] mmc: card: Fixup request missing in mmc_blk_issue_rw=
_rq
>
> The current handler of MMC_BLK_CMD_ERR in mmc_blk_issue_rw_rq functio=
n
> may cause new coming request permanent missing when the ongoing
> request (previoulsy started) complete end.

I think you need to elaborate a bit more here. In exactly what
scenario does this problem occur?

>
> This would cause the process related to the missing request stay at '=
D'
> state forever.

'D' state?

I suppose it waits for a response for its IO request. Doesn't also the
block layer complain or timeout somehow? Would be interesting to know
a bit more about what really happens when things goes wrong.

>

Seems like we should have a fixes tag here as well, could you possibly
try to find what commit that introduced this bug?

> Signed-off-by: Ding Wang <justin.wang@spreadtrum.com>
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

Kind regards
Uffe
