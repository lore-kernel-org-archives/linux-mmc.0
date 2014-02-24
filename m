From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: rtsx: add support for pre_req and post_req
Date: Tue, 25 Feb 2014 01:03:59 +0300
Message-ID: <20140224220359.GB29170@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43967 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaBXWD4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2014 17:03:56 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: linux-mmc@vger.kernel.org

Hello Micky Ching,

This is a semi-automatic email about new static checker warnings.

The patch c42deffd5b53: "mmc: rtsx: add support for pre_req and 
post_req" from Feb 17, 2014, leads to the following Smatch complaint:

drivers/mmc/host/rtsx_pci_sdmmc.c:504 sd_get_rsp()
	 error: we previously assumed 'cmd' could be null (see line 434)

drivers/mmc/host/rtsx_pci_sdmmc.c
   433	
   434		if (!cmd) {
                     ^^^
Patch introduces check.

   435			dev_err(sdmmc_dev(host), "error: cmd not exist\n");
   436			goto out;
   437		}
   438	

[ snip ]

   497		if (cmd->data) {
   498			sd_start_multi_rw(host, host->mrq);
   499			spin_unlock_irqrestore(&host->lock, flags);
   500			return;
   501		}
   502	
   503	out:
   504		cmd->error = err;
                ^^^^^^^^^^
Dereference was already there.

   505	
   506		tasklet_schedule(&host->finish_tasklet);

regards,
dan carpenter
