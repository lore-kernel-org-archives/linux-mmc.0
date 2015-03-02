From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Add exclusion between cmd and
 interrupt
Date: Mon, 2 Mar 2015 09:22:05 +0900
Message-ID: <20150302002204.GD30671@verge.net.au>
References: <1424011607-3682-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424011607-3682-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi all and in particular Sergei,

elsewhere in this thread Sergei indicated that he felt that
the spin lock around reading host->wait_for in sh_mmcif_irqt() doesn't
"seem to have much sense here, as the read is already atomic."

My initial reaction was that remark was correct. However, Kaneko-san
has done some further analysis which I would now like to share. My
apologies if in advance if I have misinterpreted that analysis.

On Sun, Feb 15, 2015 at 11:46:46PM +0900, Yoshihiro Kaneko wrote:
> From: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
> 
> A command end interrupt should not be processed between command issue
> and setting of wait_for flag. It expects already the flag to be set.
> Therefore the exclusive control was added.
> 
> Signed-off-by: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on next branch of Chris Ball's mmc tree.
> 
>  drivers/mmc/host/sh_mmcif.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7d9d6a3..e5d0b42 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -875,6 +875,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
>  	struct mmc_command *cmd = mrq->cmd;
>  	u32 opc = cmd->opcode;
>  	u32 mask;
> +	unsigned long flags;
>  
>  	switch (opc) {
>  	/* response busy check */
> @@ -909,10 +910,12 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
>  	/* set arg */
>  	sh_mmcif_writel(host->addr, MMCIF_CE_ARG, cmd->arg);
>  	/* set cmd */

We could get an interrupt here.

> +	spin_lock_irqsave(&host->lock, flags);
>  	sh_mmcif_writel(host->addr, MMCIF_CE_CMD_SET, opc);
>  
>  	host->wait_for = MMCIF_WAIT_FOR_CMD;
>  	schedule_delayed_work(&host->timeout_work, host->timeout);
> +	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
>  static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
> @@ -1171,6 +1174,12 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  	struct sh_mmcif_host *host = dev_id;
>  	struct mmc_request *mrq;
>  	bool wait = false;
> +	unsigned long flags;
> +	int wait_work;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	wait_work = host->wait_for;
> +	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	cancel_delayed_work_sync(&host->timeout_work);

And without the locking that this patch proposes if an interrupt did occur
at the point noted above then we may cancel work that has not yet been
scheduled. And furthermore the work will subsequently be scheduled and
never canceled.

> @@ -1188,7 +1197,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  	 * All handlers return true, if processing continues, and false, if the
>  	 * request has to be completed - successfully or not
>  	 */
> -	switch (host->wait_for) {
> +	switch (wait_work) {

And without the locking proposed by this patch if an interrupt occurred
at the point annotated above then host->wait_for may be read before it
is set by sh_mmcif_start_cmd().

>  	case MMCIF_WAIT_FOR_REQUEST:
>  		/* We're too late, the timeout has already kicked in */
>  		mutex_unlock(&host->thread_lock);
