From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650
Date: Fri, 8 Nov 2013 13:03:50 +0300
Message-ID: <20131108100350.GS27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:16672 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab3KHKEB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 05:04:01 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@prisktech.co.nz
Cc: linux-mmc@vger.kernel.org

Hello Tony Prisk,

This is a semi-automatic email about new static checker warnings.

The patch 3a96dff0f828: "mmc: SD/MMC Host Controller for Wondermedia 
WM8505/WM8650" from Nov 18, 2012, leads to the following Smatch 
complaint:

drivers/mmc/host/wmt-sdmmc.c:764 wmt_mci_probe()
	 warn: variable dereferenced before check 'of_id' (see line 760)

drivers/mmc/host/wmt-sdmmc.c
   759			of_match_device(wmt_mci_dt_ids, &pdev->dev);
   760		const struct wmt_mci_caps *wmt_caps = of_id->data;
                                                      ^^^^^^^^^^^
Dereference.

   761		int ret;
   762		int regular_irq, dma_irq;
   763	
   764		if (!of_id || !of_id->data) {
                     ^^^^^
Check.

   765			dev_err(&pdev->dev, "Controller capabilities data missing\n");
   766			return -EFAULT;

regards,
dan carpenter
