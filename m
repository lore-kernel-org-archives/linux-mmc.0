From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: DaVinci: MMC: MMC/SD controller driver for DaVinci family
Date: Wed, 6 Nov 2013 19:15:03 +0300
Message-ID: <20131106161503.GG15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17531 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3KFQPO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 11:15:14 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: vipin.bhandari@ti.com
Cc: linux-mmc@vger.kernel.org

Hello Vipin Bhandari,

This is a semi-automatic email about new static checker warnings.

The patch b4cff4549b7a: "DaVinci: MMC: MMC/SD controller driver for 
DaVinci family" from Dec 14, 2009, leads to the following Smatch 
complaint:

drivers/mmc/host/davinci_mmc.c:984 mmc_davinci_irq()
	 error: we previously assumed 'data' could be null (see line 967)

drivers/mmc/host/davinci_mmc.c
   966			/* All blocks sent/received, and CRC checks passed */
   967			if (data != NULL) {
                            ^^^^^^^^^^^^
Check.

   968				if ((host->do_dma == 0) && (host->bytes_left > 0)) {
   969					/* if datasize < rw_threshold
   970					 * no RX ints are generated
   971					 */
   972					davinci_fifo_data_trans(host, host->bytes_left);
   973				}
   974				end_transfer = 1;
   975				data->bytes_xfered = data->blocks * data->blksz;
   976			} else {
   977				dev_err(mmc_dev(host->mmc),
   978						"DATDNE with no host->data\n");
   979			}
   980		}
   981	
   982		if (qstatus & MMCST0_TOUTRD) {
   983			/* Read data timeout */
   984			data->error = -ETIMEDOUT;
                        ^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

   985			end_transfer = 1;
   986	

regards,
dan carpenter
