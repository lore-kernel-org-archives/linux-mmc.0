From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: failure of block read wait for long time
Date: Tue, 27 Jul 2010 16:22:13 +0300
Message-ID: <4C4EDD85.5060606@nokia.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Sukumar Ghorai wrote:
>  multi-block read failure retries in single block read one by one. It continues
>  retry of subsequent blocks, even after failure. Application will not be able
>  to decode the interleave data (even if few single block read success).
>  This patch fixes this problem by returning at the first failure instead of
>  waiting for long duration.

How can you know what sectors are important to the upper layers?

> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  drivers/mmc/card/block.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cb9fbc8..cfb0827 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  				spin_lock_irq(&md->lock);
>  				ret = __blk_end_request(req, -EIO, brq.data.blksz);
>  				spin_unlock_irq(&md->lock);
> -				continue;
>  			}
>  			goto cmd_err;
>  		}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
