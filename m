From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Move dev_err() of mmcif_timeout_work()
Date: Thu, 5 Mar 2015 15:57:21 +0100
Message-ID: <CAPDyKFo2hNP==FCLONp5qaYTQQd7=LxdAVD45wxddTkP4CV+nA@mail.gmail.com>
References: <1424011607-3682-2-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1424011607-3682-2-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 February 2015 at 15:46, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
>
> If interruption of command already occurred, mrq pointer in dev_err()
> would refer to NULL, because the host-state is changed to STATE_IDLE
> and mrq pointer is changed to NULL by interrupt handler.
> Therefore dev_err is moved after checking STATE_IDLE.
>
> Signed-off-by: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Applied, thanks!

Kind regards
Uffe


> ---
>
> This patch is based on next branch of Chris Ball's mmc tree.
>
>  drivers/mmc/host/sh_mmcif.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7d9d6a3..e075804 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1312,15 +1312,15 @@ static void mmcif_timeout_work(struct work_struct *work)
>                 /* Don't run after mmc_remove_host() */
>                 return;
>
> -       dev_err(&host->pd->dev, "Timeout waiting for %u on CMD%u\n",
> -               host->wait_for, mrq->cmd->opcode);
> -
>         spin_lock_irqsave(&host->lock, flags);
>         if (host->state == STATE_IDLE) {
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 return;
>         }
>
> +       dev_err(&host->pd->dev, "Timeout waiting for %u on CMD%u\n",
> +               host->wait_for, mrq->cmd->opcode);
> +
>         host->state = STATE_TIMEOUT;
>         spin_unlock_irqrestore(&host->lock, flags);
>
> --
> 1.9.1
>
