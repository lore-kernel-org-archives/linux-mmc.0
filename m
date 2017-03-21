From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [bug report] mmc: bcm2835: Add new driver for the sdhost
 controller.
Date: Wed, 22 Mar 2017 07:25:17 +0900
Message-ID: <4161ecb0-d848-449d-15dd-77073f57f1c9@samsung.com>
References: <CGME20170321201612epcas3p3b8f6908c50556c7d91c3bce97837a92c@epcas3p3.samsung.com>
 <20170321201400.GA22118@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60808 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933010AbdCUWZV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 18:25:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON602RPXRM6KH80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Mar 2017 07:25:18 +0900 (KST)
In-reply-to: <20170321201400.GA22118@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, eric@anholt.net
Cc: linux-mmc@vger.kernel.org

On 03/22/2017 05:14 AM, Dan Carpenter wrote:
> Hello Eric Anholt,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 5aa25d971ab4: "mmc: bcm2835: Add new driver for the sdhost 
> controller." from Mar 8, 2017, leads to the following Smatch 
> complaint:
> 
> drivers/mmc/host/bcm2835.c:1203 bcm2835_request()
> 	 error: we previously assumed 'host->mrq->data' could be null (see line 1186)
> 
> drivers/mmc/host/bcm2835.c
>   1156  static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   1157  {
>   1158          struct bcm2835_host *host = mmc_priv(mmc);
>   1159          struct device *dev = &host->pdev->dev;
>   1160          u32 edm, fsm;
>   1161  
>   1162          /* Reset the error statuses in case this is a retry */
>   1163          if (mrq->sbc)
>   1164                  mrq->sbc->error = 0;
>   1165          if (mrq->cmd)
>   1166                  mrq->cmd->error = 0;
>   1167          if (mrq->data)
>   1168                  mrq->data->error = 0;
>   1169          if (mrq->stop)
>   1170                  mrq->stop->error = 0;
>   1171  
>   1172          if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
>                     ^^^^^^^^^
> Tested here.
> 
>   1173                  dev_err(dev, "unsupported block size (%d bytes)\n",
>   1174                          mrq->data->blksz);
>   1175                  mrq->cmd->error = -EINVAL;
>   1176                  mmc_request_done(mmc, mrq);
>   1177                  return;
>   1178          }
>   1179  
>   1180          if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
>                                      ^^^^^^^^^
> And here.
> 
>   1181                  bcm2835_prepare_dma(host, mrq->data);
>   1182  
>   1183          mutex_lock(&host->mutex);
>   1184  
>   1185		WARN_ON(host->mrq);
>   1186		host->mrq = mrq;
> 
> Now host->mrq->data is possibly NULL.
> 
>   1187	
>   1188		edm = readl(host->ioaddr + SDEDM);
>   1189		fsm = edm & SDEDM_FSM_MASK;
>   1190	
>   1191		if ((fsm != SDEDM_FSM_IDENTMODE) &&
>   1192		    (fsm != SDEDM_FSM_DATAMODE)) {
>   1193			dev_err(dev, "previous command (%d) not complete (EDM %08x)\n",
>   1194				readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK,
>   1195				edm);
>   1196			bcm2835_dumpregs(host);
>   1197			mrq->cmd->error = -EILSEQ;
>   1198			bcm2835_finish_request(host);
>   1199			mutex_unlock(&host->mutex);
>   1200			return;
>   1201		}
>   1202	
>   1203		host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
>                                                ^^^^^^^^^^^^^^^^^
> Dereferenced without a test.

I think that it can be just added the condition checking for host->mrq->data.

Best Regards,
Jaehoon Chung

> 
>   1204		if (host->use_sbc) {
>   1205			if (bcm2835_send_command(host, mrq->sbc)) {
> 
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

