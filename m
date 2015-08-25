From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Tue, 25 Aug 2015 14:06:43 +0200
Message-ID: <CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sdliyong@gmail.com
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 August 2015 at 09:30,  <sdliyong@gmail.com> wrote:
> From: Yong Li <sdliyong@gmail.com>
>
> Signed-off-by: Yong Li <sdliyong@gmail.com>
> ---
>  drivers/mmc/card/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..d9e3c45 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1366,7 +1366,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>         bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
>                           (req->cmd_flags & REQ_META)) &&
>                 (rq_data_dir(req) == WRITE) &&
> -               (md->flags & MMC_BLK_REL_WR);
> +               (md->flags & MMC_BLK_REL_WR) &&
> +               !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);

Further down in mmc_blk_rw_rq_prep() we check for
MMC_QUIRK_BLK_NO_CMD23. That check becomes redundant after this
change, please remove that check as a part of this patch as well.

>
>         memset(brq, 0, sizeof(struct mmc_blk_request));
>         brq->mrq.cmd = &brq->cmd;
> --
> 2.1.0
>

Kind regards
Uffe
