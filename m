From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: rtsx: add support for pre_req and post_req
Date: Tue, 25 Feb 2014 01:03:28 +0300
Message-ID: <20140224220328.GA29170@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49061 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaBXWD0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2014 17:03:26 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: linux-mmc@vger.kernel.org

Hello Micky Ching,

This is a semi-automatic email about new static checker warnings.

The patch c42deffd5b53: "mmc: rtsx: add support for pre_req and 
post_req" from Feb 17, 2014, leads to the following Smatch complaint:

drivers/mmc/host/rtsx_pci_sdmmc.c:194 sd_finish_request()
	 error: we previously assumed 'mrq' could be null (see line 158)

drivers/mmc/host/rtsx_pci_sdmmc.c
   157		mrq = host->mrq;
   158		if (!mrq) {
                    ^^^^
Patch introduces check.

   159			dev_err(sdmmc_dev(host), "error: no request need finish\n");
   160			goto out;
   161		}
   162	
   163		cmd = mrq->cmd;
   164		data = mrq->data;
   165	
   166		any_error = (mrq->sbc && mrq->sbc->error) ||
   167			(mrq->stop && mrq->stop->error) ||
   168			(cmd && cmd->error) || (data && data->error);
   169	
   170		if (any_error) {
   171			rtsx_pci_stop_cmd(pcr);
   172			sd_clear_error(host);
   173		}
   174	
   175		if (data) {
   176			if (any_error)
   177				data->bytes_xfered = 0;
   178			else
   179				data->bytes_xfered = data->blocks * data->blksz;
   180	
   181			if (!data->host_cookie)
   182				rtsx_pci_dma_unmap_sg(pcr, data->sg, data->sg_len,
   183						data->flags & MMC_DATA_READ);
   184	
   185		}
   186	
   187		host->mrq = NULL;
   188		host->cmd = NULL;
   189		host->data = NULL;
   190	
   191	out:
   192		spin_unlock_irqrestore(&host->lock, flags);
   193		mutex_unlock(&pcr->pcr_mutex);
   194		mmc_request_done(host->mmc, mrq);
                                            ^^^
Dereferenced inside function.  Patch introduces dereference.

   195	}
   196	

regards,
dan carpenter
