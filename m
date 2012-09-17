From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/4] drivers/mmc/host/dw_mmc.c: fix error return code
Date: Mon, 17 Sep 2012 18:54:37 +0900
Message-ID: <016401cd94ba$733937d0$59aba770$%jun@samsung.com>
References: <1347869728-2696-1-git-send-email-peter.senna@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1347869728-2696-1-git-send-email-peter.senna@gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Peter Senna Tschudin' <peter.senna@gmail.com>, cjb@laptop.org
Cc: will.newton@imgtec.com, jh80.chung@samsung.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday, September 17, 2012, Peter Senna Tschudin <peter.senna@gmail.com> wrote:
> From: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> Convert a nonnegative error return code to a negative one, as returned
> elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 36f98c0..7ad5176 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2039,8 +2039,10 @@ int dw_mci_probe(struct dw_mci *host)
>  	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
>  	host->card_workqueue = alloc_workqueue("dw-mci-card",
>  			WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
> -	if (!host->card_workqueue)
> +	if (!host->card_workqueue) {
> +		err = -ENOMEM;
ret is expected instead of err.
err isn't defined.

Thanks,
Seungwon Jeon

>  		goto err_dmaunmap;
> +	}
>  	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
>  	ret = request_irq(host->irq, dw_mci_interrupt, host->irq_flags, "dw-mci", host);
>  	if (ret)
> --
> 1.7.11.4
