From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Wed, 12 Apr 2017 22:54:47 +0300
Message-ID: <20170412195447.GA9213@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33804 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbdDLTzC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 15:55:02 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jglauber@cavium.com
Cc: linux-mmc@vger.kernel.org

Hello Jan Glauber,

This is a semi-automatic email about new static checker warnings.

The patch 8047c753f3d3: "mmc: cavium: Add core MMC driver for Cavium 
SOCs" from Mar 30, 2017, leads to the following Smatch complaint:

drivers/mmc/host/cavium.c:694 cvm_mmc_dma_request()
	 warn: variable dereferenced before check 'mmc->card' (see line 675)

drivers/mmc/host/cavium.c
   674	
   675		emm_dma = prepare_ext_dma(mmc, mrq);
                                          ^^^
Dereferenced inside this function call.

   676		addr = prepare_dma(host, data);
   677		if (!addr) {
   678			dev_err(host->dev, "prepare_dma failed\n");
   679			goto error;
   680		}
   681	
   682		host->dma_active = true;
   683		host->int_enable(host, MIO_EMM_INT_CMD_ERR | MIO_EMM_INT_DMA_DONE |
   684				 MIO_EMM_INT_DMA_ERR);
   685	
   686		if (host->dmar_fixup)
   687			host->dmar_fixup(host, mrq->cmd, data, addr);
   688	
   689		/*
   690		 * If we have a valid SD card in the slot, we set the response
   691		 * bit mask to check for CRC errors and timeouts only.
   692		 * Otherwise, use the default power reset value.
   693		 */
   694		if (mmc->card && mmc_card_sd(mmc->card))
                    ^^^^^^^^^
Checked too late.

   695			writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK(host));
   696		else

regards,
dan carpenter
