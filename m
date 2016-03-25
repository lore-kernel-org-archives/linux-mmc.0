From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2] mmc: Provide tracepoints for request processing
Date: Fri, 25 Mar 2016 08:10:29 -0600
Message-ID: <56F546D5.5090107@fb.com>
References: <7dff940d08f26e9994557d94652f581ad84899e0.1458893798.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28342 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962AbcCYOLM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2016 10:11:12 -0400
In-Reply-To: <7dff940d08f26e9994557d94652f581ad84899e0.1458893798.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, rostedt@goodmis.org, mingo@redhat.com
Cc: adrian.hunter@intel.com, yangbo.lu@freescale.com, akpm@linux-foundation.org, JBottomley@Odin.com, lporzio@micron.com, jonathanh@nvidia.com, grundler@chromium.org, fabf@skynet.be, yunpeng.gao@intel.com, dan.j.williams@intel.com, rabin.vincent@axis.com, chuanxiao.dong@intel.com, shawn.lin@rock-chips.com, heiko@sntech.de, dianders@chromium.org, david@protonic.nl, broonie@kernel.org, linus.walleij@linaro.org, takahiro.akashi@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 03/25/2016 02:19 AM, Baolin Wang wrote:
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index fe207e5..d372a2d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -46,6 +46,9 @@
>
>   #include "queue.h"
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmc.h>
> +
>   MODULE_ALIAS("mmc:block");
>   #ifdef MODULE_PARAM_PREFIX
>   #undef MODULE_PARAM_PREFIX
> @@ -1709,6 +1712,7 @@ static u8 mmc_blk_prep_packed_list(struct mmc_queue *mq, struct request *req)
>   		if (phys_segments > max_phys_segs)
>   			break;
>
> +		trace_mmc_block_packed_req(next);
>   		list_add_tail(&next->queuelist, &mqrq->packed->list);
>   		cur = next;
>   		reqs++;

This looks like the only valid trace point in the block part.

> @@ -1870,6 +1874,7 @@ static int mmc_blk_end_packed_req(struct mmc_queue_req *mq_rq)
>   		}
>   		list_del_init(&prq->queuelist);
>   		blk_end_request(prq, 0, blk_rq_bytes(prq));
> +		trace_mmc_block_req_done(prq);

We just logged a complete event through blk_end_request() here.
> @@ -1985,6 +1990,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>   			} else {
>   				ret = blk_end_request(req, 0,
>   						brq->data.bytes_xfered);
> +				trace_mmc_block_req_done(req);
>   			}

Ditto

> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 6f4323c..d0388cf 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -16,6 +16,7 @@
>   #include <linux/kthread.h>
>   #include <linux/scatterlist.h>
>   #include <linux/dma-mapping.h>
> +#include <trace/events/mmc.h>
>
>   #include <linux/mmc/card.h>
>   #include <linux/mmc/host.h>
> @@ -64,6 +65,9 @@ static int mmc_queue_thread(void *d)
>   		mq->mqrq_cur->req = req;
>   		spin_unlock_irq(q->queue_lock);
>
> +		if (req)
> +			trace_mmc_queue_fetch(req);

Issue event was just logged here, if req != NULL. So also redundant.

Basically only your core mmc events would potentially have merit, the 
rest are all dupes. So nak.

-- 
Jens Axboe

