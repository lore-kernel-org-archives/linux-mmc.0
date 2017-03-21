From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: bcm2835: Add new driver for the sdhost controller.
Date: Tue, 21 Mar 2017 23:14:01 +0300
Message-ID: <20170321201400.GA22118@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35605 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbdCUUPp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 16:15:45 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: eric@anholt.net
Cc: linux-mmc@vger.kernel.org

Hello Eric Anholt,

This is a semi-automatic email about new static checker warnings.

The patch 5aa25d971ab4: "mmc: bcm2835: Add new driver for the sdhost 
controller." from Mar 8, 2017, leads to the following Smatch 
complaint:

drivers/mmc/host/bcm2835.c:1203 bcm2835_request()
	 error: we previously assumed 'host->mrq->data' could be null (see line 1186)

drivers/mmc/host/bcm2835.c
  1156  static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
  1157  {
  1158          struct bcm2835_host *host = mmc_priv(mmc);
  1159          struct device *dev = &host->pdev->dev;
  1160          u32 edm, fsm;
  1161  
  1162          /* Reset the error statuses in case this is a retry */
  1163          if (mrq->sbc)
  1164                  mrq->sbc->error = 0;
  1165          if (mrq->cmd)
  1166                  mrq->cmd->error = 0;
  1167          if (mrq->data)
  1168                  mrq->data->error = 0;
  1169          if (mrq->stop)
  1170                  mrq->stop->error = 0;
  1171  
  1172          if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
                    ^^^^^^^^^
Tested here.

  1173                  dev_err(dev, "unsupported block size (%d bytes)\n",
  1174                          mrq->data->blksz);
  1175                  mrq->cmd->error = -EINVAL;
  1176                  mmc_request_done(mmc, mrq);
  1177                  return;
  1178          }
  1179  
  1180          if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
                                     ^^^^^^^^^
And here.

  1181                  bcm2835_prepare_dma(host, mrq->data);
  1182  
  1183          mutex_lock(&host->mutex);
  1184  
  1185		WARN_ON(host->mrq);
  1186		host->mrq = mrq;

Now host->mrq->data is possibly NULL.

  1187	
  1188		edm = readl(host->ioaddr + SDEDM);
  1189		fsm = edm & SDEDM_FSM_MASK;
  1190	
  1191		if ((fsm != SDEDM_FSM_IDENTMODE) &&
  1192		    (fsm != SDEDM_FSM_DATAMODE)) {
  1193			dev_err(dev, "previous command (%d) not complete (EDM %08x)\n",
  1194				readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK,
  1195				edm);
  1196			bcm2835_dumpregs(host);
  1197			mrq->cmd->error = -EILSEQ;
  1198			bcm2835_finish_request(host);
  1199			mutex_unlock(&host->mutex);
  1200			return;
  1201		}
  1202	
  1203		host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
                                               ^^^^^^^^^^^^^^^^^
Dereferenced without a test.

  1204		if (host->use_sbc) {
  1205			if (bcm2835_send_command(host, mrq->sbc)) {

regards,
dan carpenter
