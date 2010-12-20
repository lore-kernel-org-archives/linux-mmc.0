From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch] workaround of 1-bit mmc card in case cmd19 & cmd 14 not
 supported
Date: Sun, 19 Dec 2010 20:52:20 -0800
Message-ID: <989F0D94-CD2D-4AA5-8F7A-68488E0DB01D@marvell.com>
References: <AANLkTim8BAxZE9SFigp3WD68qgMAWUpOABo4-dwsfv7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45733 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752602Ab0LTEyz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 19 Dec 2010 23:54:55 -0500
In-Reply-To: <AANLkTim8BAxZE9SFigp3WD68qgMAWUpOABo4-dwsfv7N@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


On Dec 16, 2010, at 7:21 PM, zhangfei gao wrote:

> If controller does not support cmd19 & cmd14, here is workaround we using.
> Send just in case somebody require.
> 
> From b95c5e8d1c5b42a149a521c4992dfd8fc8d61143 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Thu, 16 Dec 2010 22:28:40 -0500
> Subject: [PATCH] mmc: workaround of 1-bit mmc card
> 
> 	In case controller does not support cmd19 & cmd14.
> 	Use workaround to decrease bus width when error happen via reading
> partition table
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++++
> include/linux/mmc/host.h |    2 ++
> 2 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 217f820..c0d2b73 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -432,6 +432,34 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
> *mq, struct request *req)
> 		 * programming mode even when things go wrong.
> 		 */
> 		if (brq.cmd.error || brq.data.error || brq.stop.error) {
> +			if (mmc_card_mmc(card)) {
> +				u8 width = card->host->ios.bus_width;
> +
> +				if (width == MMC_BUS_WIDTH_4) {
> +					printk(KERN_WARNING "%s: "
> +						"retrying using 1 BIT WIDTH \n",
> +						req->rq_disk->disk_name);
> +					mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +							EXT_CSD_BUS_WIDTH,
> +							EXT_CSD_BUS_WIDTH_1);
> +
> +					mmc_set_bus_width(card->host,
> +							MMC_BUS_WIDTH_1);
> +					continue;
> +				}
> +				if (width == MMC_BUS_WIDTH_8) {
> +					printk(KERN_WARNING "%s: "
> +						"retrying using 4 BIT WIDTH \n",
> +						req->rq_disk->disk_name);
> +					mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +						EXT_CSD_BUS_WIDTH,
> +						EXT_CSD_BUS_WIDTH_4);
> +
> +					mmc_set_bus_width(card->host,
> +						MMC_BUS_WIDTH_4);
> +					continue;
> +				}
> +			}
> 			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
> 				/* Redo read one sector at a time */
> 				printk(KERN_WARNING "%s: retrying using single "
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4a9d9d2..2a2c1ab 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -249,6 +249,8 @@ extern struct mmc_host *mmc_alloc_host(int extra,
> struct device *);
> extern int mmc_add_host(struct mmc_host *);
> extern void mmc_remove_host(struct mmc_host *);
> extern void mmc_free_host(struct mmc_host *);
> +extern int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
> +extern void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
> 
> static inline void *mmc_priv(struct mmc_host *host)
> {
> -- 
> 1.7.0.4

Curious, 
What cards fail without this patch ?  and on what system ?
PXA168/PXA910 and MMP2 all support bus width testing for mmc cards.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

