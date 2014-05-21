From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: moxart: Add MOXA ART SD/MMC driver
Date: Wed, 21 May 2014 15:28:25 +0300
Message-ID: <20140521122825.GE23396@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19512 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaEUM2d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 May 2014 08:28:33 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jonas.jensen@gmail.com
Cc: linux-mmc@vger.kernel.org

Hello Jonas Jensen,

The patch 1b66e94e6b99: "mmc: moxart: Add MOXA ART SD/MMC driver"
from Apr 9, 2014, leads to the following static checker warning:

	drivers/mmc/host/moxart-mmc.c:691 moxart_remove()
	warn: variable dereferenced before check 'mmc' (see line 687)

drivers/mmc/host/moxart-mmc.c
   684  static int moxart_remove(struct platform_device *pdev)
   685  {
   686          struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
   687          struct moxart_host *host = mmc_priv(mmc);
                                           ^^^^^^^^^^^^^
Dereference.

   688  
   689          dev_set_drvdata(&pdev->dev, NULL);
   690  
   691          if (mmc) {
                    ^^^
Check.

   692                  if (!IS_ERR(host->dma_chan_tx))

regards,
dan carpenter
