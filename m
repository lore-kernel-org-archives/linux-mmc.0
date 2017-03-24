From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
Date: Fri, 24 Mar 2017 09:52:18 +0200
Message-ID: <13a83728-0031-5683-c371-4b517df32299@intel.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: srv_heupstream@mediatek.com, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 24/03/17 08:19, Chaotian Jing wrote:
> this patch is refine for 'commit c6dbab9cb58f ("mmc: core: Hold re-tuning
> during switch commands")'
> Since it has 3 retries at max for CMD6, if the first CMD6 got CRC error,
> then should do re-tune before the next CMD6 was sent.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc_ops.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index fe80f26..6931927 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -534,8 +534,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  	bool use_r1b_resp = use_busy_signal;
>  	unsigned char old_timing = host->ios.timing;
>  
> -	mmc_retune_hold(host);
> -
>  	/*
>  	 * If the cmd timeout and the max_busy_timeout of the host are both
>  	 * specified, let's validate them. A failure means we need to prevent
> @@ -567,6 +565,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  		cmd.sanitize_busy = true;
>  
>  	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +	mmc_retune_hold(host);

That is not how mmc_retune_hold() works, you need mmc_retune_hold_now() as
it is here:

	https://marc.info/?l=linux-mmc&m=148940903816582

But using "retries" with commands that have busy-waiting on the data line
doesn't make much sense anyway.  Particularly with CRC errors, I would
expect the card is actually busily doing the switch and we need only to wait
for it.  The same can be true for timeout errors.  For some CMD6 we might
need to send CMD12 if the card is busy after an error.  I would prefer an
explicit attempt at recovery from CMD6 errors.
