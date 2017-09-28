From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write
 support for sd card
Date: Thu, 28 Sep 2017 16:29:08 +0200
Message-ID: <20170928142908.GB30550@hc>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
 <20170927134740.GD7103@hc>
 <8d9ccd37-17ee-c93d-297a-2865e08baf0a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:36736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752017AbdI1O3Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 28 Sep 2017 10:29:25 -0400
Content-Disposition: inline
In-Reply-To: <8d9ccd37-17ee-c93d-297a-2865e08baf0a@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org

On Thu, Sep 28, 2017 at 11:33:00AM +0800, Shawn Lin wrote:
> Hi Jan,
> 
> On 2017/9/27 21:47, Jan Glauber wrote:
> >Hi Shawn,
> >
> >I'm trying your patches on Cavium's ARM SOC. How do I get debug
> >messages from the MMC layer nowadays? Enabling CONFIG_MMC_DEBUG
> >does not show anything (4.14-rc2) but worked in the past.
> >
> 
> Thanks for testing!
> 
> You could select CONFIG_DYNAMIC_DEBUG and enable/disable the log at any
> time by manipulating <debugfs>/dynamic_debug/control

I have CONFIG_DYNAMIC_DEBUG enabled but I'm not a big fan of it as
I want it at boot time which means I need to touch the boot parameters
which is more work then switching on the config option.

Anyway, added "dyndbg=file drivers/mmc/* +p" but still nothing showed
up. Probably I need to spend more time studying the documentation...

--Jan

> See: Documentation/dynamic-debug-howto.txt
> 
> >thanks,
> >Jan
> >
> >On Wed, Sep 27, 2017 at 11:40:36AM +0800, Shawn Lin wrote:
> >>Per SD specification version 4.10, section 4.3.4, it says "pre-erased
> >>(ACMD23) will make a following Multiple Block Write operation faster
> >>compared to the same operation without preceding ACMD23". ACMD23 is
> >>mandatory for all sd cards and the spec also says "Command STOP_TRAN
> >>(CMD12) shall be used to stop the transmission in Write Multiple Block
> >>whether or not the preerase (ACMD23) feature is used."
> >>
> >>However current code only check to see if CMD23 is available. If not, it
> >>would fallback to open-ending mode. So this patch is trying to activate
> >>ACMD23 support for SD cards when doing multiple write.
> >>
> >>The policy is:
> >><1> If the sd card claims to support CMD23, the behaviour isn't
> >>changed. So we still use CMD23 for both of multiple block read and
> >>write as before.
> >><2> If the sd card *doesn't* claims to support CMD23, we force all
> >>the multiple block write to use preceding ACMD23. The multiple read
> >>behaviour is changed since ACMD23 is for write only, per spec.
> >><3> If the sd card *falsely* claims to support CMD23, and we add the
> >>quirk, MMC_QUIRK_BLK_NO_CMD23. The behaviour is the same as <2>. And
> >>one of the reports and test could be found at the bottom link.
> >>
> >>Tested with the following cards:
> >>Apacer High Speed SDHC 8GB
> >>ADATA High Speed SDHC 4GB
> >>ADATA Premier UHS-I SDHC 16GB
> >>ez Share wifi-combo-SDHC 32GB
> >>Kingston UHS-I micro SDHC 32GB
> >>Toshiba High Speed micro SDHC 4GB
> >>Toshiba High Speed micro SDHC 8GB
> >>Toshiba Exceria UHS-I micro SDHC 32GB
> >>PNY High Speed micro SDHC 32GB
> >>Sandisk Ultra UHS-I micro SDHC 16GB
> >>Sandisk Extreme Pro UHS-I micro SDXC 512GB
> >>Samsung UHS-I micro SDHC 32GB
> >>Sony SFUX UHS-I SDHC 32GB
> >>Silicon Power High Speed SDHC 16GB
> >>Transcend UHS-I SDXC 64GB
> >>Topmore High Speed SDHC 8GB
> >>Longsys UHS-I micro SDHC 32GB
> >>Lexar Professional UHS-I micro SDHC 32GB
> >>.....
> >>
> >>More cards have been tested but not need to list here. Some of them
> >>support CMD23 but some don't. All the test shows this patch work fine.
> >>
> >>Link: https://patchwork.kernel.org/patch/9946125/
> >>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>---
> >>
> >>  drivers/mmc/core/block.c | 50 ++++++++++++++++++++++++++++++++++++++++++------
> >>  drivers/mmc/core/core.c  |  6 ++++++
> >>  include/linux/mmc/core.h |  2 ++
> >>  3 files changed, 52 insertions(+), 6 deletions(-)
> >>
> >>diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >>index ab9c780..b253d6a 100644
> >>--- a/drivers/mmc/core/block.c
> >>+++ b/drivers/mmc/core/block.c
> >>@@ -101,8 +101,9 @@ struct mmc_blk_data {
> >>  	struct list_head rpmbs;
> >>  	unsigned int	flags;
> >>-#define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
> >>-#define MMC_BLK_REL_WR	(1 << 1)	/* MMC Reliable write support */
> >>+#define MMC_BLK_CMD23	BIT(0)	/* Can do SET_BLOCK_COUNT for multiblock */
> >>+#define MMC_BLK_REL_WR	BIT(1)	/* MMC Reliable write support */
> >>+#define MMC_BLK_ACMD23	BIT(2)	/* Can do pre-erased before multiblock write */
> >>  	unsigned int	usage;
> >>  	unsigned int	read_only;
> >>@@ -905,7 +906,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
> >>  }
> >>  static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
> >>-		bool hw_busy_detect, struct request *req, bool *gen_err)
> >>+		bool hw_busy_detect, struct request *req, bool *gen_err,
> >>+		u32 *card_status)
> >>  {
> >>  	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> >>  	int err = 0;
> >>@@ -949,6 +951,9 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
> >>  	} while (!(status & R1_READY_FOR_DATA) ||
> >>  		 (R1_CURRENT_STATE(status) == R1_STATE_PRG));
> >>+	if (card_status)
> >>+		*card_status = status;
> >>+
> >>  	return err;
> >>  }
> >>@@ -994,7 +999,8 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
> >>  		*gen_err = true;
> >>  	}
> >>-	return card_busy_detect(card, timeout_ms, use_r1b_resp, req, gen_err);
> >>+	return card_busy_detect(card, timeout_ms, use_r1b_resp, req,
> >>+				gen_err, NULL);
> >>  }
> >>  #define ERR_NOMEDIUM	3
> >>@@ -1520,6 +1526,7 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
> >>  	 */
> >>  	if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
> >>  		int err;
> >>+		u32 stop_status;
> >>  		/* Check stop command response */
> >>  		if (brq->stop.resp[0] & R1_ERROR) {
> >>@@ -1530,9 +1537,23 @@ static enum mmc_blk_status mmc_blk_err_check(struct mmc_card *card,
> >>  		}
> >>  		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
> >>-					&gen_err);
> >>+					&gen_err, &stop_status);
> >>  		if (err)
> >>  			return MMC_BLK_CMD_ERR;
> >>+
> >>+		/*
> >>+		 * Some sd cards still leave in recv state after sending CMD12
> >>+		 * when preceding ACMD23 is used. But try again will fix that.
> >>+		 */
> >>+		if (brq->sbc.flags & MMC_CMD_SD_APP &&
> >>+		    R1_CURRENT_STATE(stop_status) == R1_STATE_RCV) {
> >>+			err = send_stop(card,
> >>+					DIV_ROUND_UP(brq->data.timeout_ns,
> >>+						     1000000),
> >>+					req, &gen_err, &stop_status);
> >>+			if (err)
> >>+				return MMC_BLK_CMD_ERR;
> >>+		}
> >>  	}
> >>  	/* if general error occurs, retry the write operation. */
> >>@@ -1687,6 +1708,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >>  	struct request *req = mmc_queue_req_to_req(mqrq);
> >>  	struct mmc_blk_data *md = mq->blkdata;
> >>  	bool do_rel_wr, do_data_tag;
> >>+	bool need_acmd23;
> >>  	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
> >>@@ -1727,11 +1749,22 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >>  	 * that for hosts that don't expose MMC_CAP_CMD23, no
> >>  	 * change of behavior will be observed.
> >>  	 *
> >>+	 * Per sd spec, section 4.3.4, it suggests to use ACMD23
> >>+	 * do achieve better write performance for those who can't
> >>+	 * support CMD23. But also note that ACMD23 is for write only,
> >>+	 * so we still need use CMD23 to do multiple block data transfer
> >>+	 * if the card claims to support CMD23.
> >>+	 *
> >>  	 * N.B: Some MMC cards experience perf degradation.
> >>  	 * We'll avoid using CMD23-bounded multiblock writes for
> >>  	 * these, while retaining features like reliable writes.
> >>  	 */
> >>-	if ((md->flags & MMC_BLK_CMD23) && mmc_op_multi(brq->cmd.opcode) &&
> >>+	need_acmd23 = !(md->flags & MMC_BLK_CMD23) &&
> >>+		      brq->cmd.opcode == MMC_WRITE_MULTIPLE_BLOCK &&
> >>+		      md->flags & MMC_BLK_ACMD23;
> >>+
> >>+	if (((md->flags & MMC_BLK_CMD23) || need_acmd23) &&
> >>+	    mmc_op_multi(brq->cmd.opcode) &&
> >>  	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
> >>  	     do_data_tag)) {
> >>  		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
> >>@@ -1739,6 +1772,8 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> >>  			(do_rel_wr ? (1 << 31) : 0) |
> >>  			(do_data_tag ? (1 << 29) : 0);
> >>  		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> >>+		if (need_acmd23)
> >>+			brq->sbc.flags |= MMC_CMD_SD_APP;
> >>  		brq->mrq.sbc = &brq->sbc;
> >>  	}
> >>@@ -2158,6 +2193,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
> >>  		    (mmc_card_sd(card) &&
> >>  		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
> >>  			md->flags |= MMC_BLK_CMD23;
> >>+
> >>+		if (mmc_card_sd(card))
> >>+			md->flags |= MMC_BLK_ACMD23;
> >>  	}
> >>  	if (mmc_card_mmc(card) &&
> >>diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >>index 66c9cf4..bc96e6d 100644
> >>--- a/drivers/mmc/core/core.c
> >>+++ b/drivers/mmc/core/core.c
> >>@@ -403,6 +403,12 @@ static int __mmc_start_data_req(struct mmc_host *host, struct mmc_request *mrq)
> >>  	mmc_wait_ongoing_tfr_cmd(host);
> >>+	if (mrq && mrq->sbc && mrq->sbc->flags & MMC_CMD_SD_APP) {
> >>+		err = mmc_app_cmd(host, host->card);
> >>+		if (err)
> >>+			return err;
> >>+	}
> >>+
> >>  	mrq->done = mmc_wait_data_done;
> >>  	mrq->host = host;
> >>diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> >>index 9275193..dcb5783 100644
> >>--- a/include/linux/mmc/core.h
> >>+++ b/include/linux/mmc/core.h
> >>@@ -46,6 +46,8 @@ struct mmc_command {
> >>  #define MMC_CMD_BC	(2 << 5)
> >>  #define MMC_CMD_BCR	(3 << 5)
> >>+#define MMC_CMD_SD_APP	(1 << 6)		/* app cmd for SD cards */
> >>+
> >>  #define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
> >>  #define MMC_RSP_SPI_S2	(1 << 8)		/* second byte */
> >>  #define MMC_RSP_SPI_B4	(1 << 9)		/* four data bytes */
> >>-- 
> >>1.9.1
> >>
> >
> >
> >
