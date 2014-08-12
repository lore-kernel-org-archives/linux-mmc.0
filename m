From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: card: not access RPMB partition for normal read and write
Date: Tue, 12 Aug 2014 10:36:44 +0200
Message-ID: <CAPDyKFo11JSeEBbCfDG=0XPMnBXd_GHqx15G5yu9dGaR5R4OxA@mail.gmail.com>
References: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:40714 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaHLIgp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 04:36:45 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so9342556qge.32
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 01:36:45 -0700 (PDT)
In-Reply-To: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 12 August 2014 06:01, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> During kernel boot, it will try to read some logical sectors
> of each block device node for the possible partition table.
>
> But since RPMB partition is special and can not be accessed
> by normal eMMC read / write CMDs, it will cause below error
> messages during kernel boot:

The following patch were included in 3.8, does this solve your issue?

53d8f97 mmc: card: Do not scan RPMB partitions

Kind regards
Uffe

> ...
> <3>[    4.890052] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
> <3>[    4.892160] mmcblk0rpmb: error -110 transferring data, sector 0, nr 32, cmd response 0x900, card status 0xb00
> <4>[    4.892165] mmcblk0rpmb: retrying using single block read
> <3>[    4.895727] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.899269] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.901466] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.905106] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.907166] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.909235] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
> <3>[    4.909241] end_request: I/O error, dev mmcblk0rpmb, sector 0
> <3>[    4.909247] Buffer I/O error on device mmcblk0rpmb, logical block 0
> <3>[    4.909263] end_request: I/O error, dev mmcblk0rpmb, sector 8
> <3>[    4.909267] Buffer I/O error on device mmcblk0rpmb, logical block 1
> <3>[    4.909272] end_request: I/O error, dev mmcblk0rpmb, sector 16
> <3>[    4.909275] Buffer I/O error on device mmcblk0rpmb, logical block 2
> <3>[    4.909280] end_request: I/O error, dev mmcblk0rpmb, sector 24
> <3>[    4.909283] Buffer I/O error on device mmcblk0rpmb, logical block 3
> ...
>
> This patch will discard the access request in eMMC queue if
> it is RPMB partition access request. By this way, it avoids
> trigger above error messages.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/card/block.c |   13 +++++++++++++
>  drivers/mmc/card/queue.c |    2 +-
>  drivers/mmc/card/queue.h |    2 ++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..4b79592 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1025,6 +1025,19 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>         md->reset_done &= ~type;
>  }
>
> +int mmc_access_rpmb(struct mmc_queue *mq)
> +{
> +       struct mmc_blk_data *md = mq->data;
> +       /*
> +        * If this is a RPMB partition access, return ture
> +        */
> +       if (md && md->part_type == EXT_CSD_PART_CONFIG_ACC_RPMB)
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(mmc_access_rpmb);
> +
>  static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_blk_data *md = mq->data;
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 3e049c1..6ceede0 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -38,7 +38,7 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>                 return BLKPREP_KILL;
>         }
>
> -       if (mq && mmc_card_removed(mq->card))
> +       if (mq && (mmc_card_removed(mq->card) || mmc_access_rpmb(mq)))
>                 return BLKPREP_KILL;
>
>         req->cmd_flags |= REQ_DONTPREP;
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 5752d50..99e6521 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -73,4 +73,6 @@ extern void mmc_queue_bounce_post(struct mmc_queue_req *);
>  extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
>  extern void mmc_packed_clean(struct mmc_queue *);
>
> +extern int mmc_access_rpmb(struct mmc_queue *);
> +
>  #endif
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
