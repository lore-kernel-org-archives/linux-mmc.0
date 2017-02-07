From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: block: return errorcode from mmc_sd_num_wr_blocks()
Date: Tue, 7 Feb 2017 11:23:16 +0300
Message-ID: <20170207082316.GA25804@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44602 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdBGIXd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 03:23:33 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-mmc@vger.kernel.org

Hello Linus Walleij,

The patch 9a5e7ddc7954: "mmc: block: return errorcode from
mmc_sd_num_wr_blocks()" from Feb 1, 2017, leads to the following
static checker warning:

	drivers/mmc/core/block.c:1589 mmc_blk_rw_cmd_err()
	error: uninitialized symbol 'blocks'.

drivers/mmc/core/block.c
   766  static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
   767  {
   768          int err;
   769          u32 result;
   770          __be32 *blocks;
   771  
   772          struct mmc_request mrq = {};
   773          struct mmc_command cmd = {};
   774          struct mmc_data data = {};
   775  
   776          struct scatterlist sg;
   777  
   778          cmd.opcode = MMC_APP_CMD;
   779          cmd.arg = card->rca << 16;
   780          cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
   781  
   782          err = mmc_wait_for_cmd(card->host, &cmd, 0);
   783          if (err)
   784                  return err;
   785          if (!mmc_host_is_spi(card->host) && !(cmd.resp[0] & R1_APP_CMD))
   786                  return 0;

This is supposed to be "return -EIO", I suspect.  The caller expects
that *written_blocks is initialized if we return zero.

   787  
   788          memset(&cmd, 0, sizeof(struct mmc_command));
   789  
   790          cmd.opcode = SD_APP_SEND_NUM_WR_BLKS;
   791          cmd.arg = 0;
   792          cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
   793  

regards,
dan carpenter
