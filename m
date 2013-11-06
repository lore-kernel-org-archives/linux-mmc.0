From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: sh_mmcif: Terminate DMA transactions when detecting timeout
 or error
Date: Wed, 6 Nov 2013 19:15:29 +0300
Message-ID: <20131106161529.GH15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17874 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab3KFQPl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 11:15:41 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: teppei.kamijou.yb@renesas.com
Cc: linux-mmc@vger.kernel.org

Hello Teppei Kamijou,

This is a semi-automatic email about new static checker warnings.

The patch eae309836509: "mmc: sh_mmcif: Terminate DMA transactions 
when detecting timeout or error" from Dec 12, 2012, leads to the 
following Smatch complaint:

drivers/mmc/host/sh_mmcif.c:1122 sh_mmcif_end_cmd()
	 error: we previously assumed 'host->chan_rx' could be null (see line 1105)

drivers/mmc/host/sh_mmcif.c
  1104		if (data->flags & MMC_DATA_READ) {
  1105			if (host->chan_rx)
                            ^^^^^^^^^^^^^
Existing check.

  1106				sh_mmcif_start_dma_rx(host);
  1107		} else {
  1108			if (host->chan_tx)
  1109				sh_mmcif_start_dma_tx(host);
  1110		}
  1111	
  1112		if (!host->dma_active) {
  1113			data->error = sh_mmcif_data_trans(host, host->mrq, cmd->opcode);
  1114			return !data->error;
  1115		}
  1116	
  1117		/* Running in the IRQ thread, can sleep */
  1118		time = wait_for_completion_interruptible_timeout(&host->dma_complete,
  1119								 host->timeout);
  1120	
  1121		if (data->flags & MMC_DATA_READ)
  1122			dma_unmap_sg(host->chan_rx->device->dev,
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^
Patch introduces new unchecked dereference.

Same thing for chan_tx as well.

  1123				     data->sg, data->sg_len,
  1124				     DMA_FROM_DEVICE);

regards,
dan carpenter
