From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: parse new binding for eMMC fixed driver type
Date: Thu, 30 Nov 2017 12:20:27 +0300
Message-ID: <20171130092027.pt4i5knisyv2c6pr@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49025 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdK3JUs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Nov 2017 04:20:48 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wsa+renesas@sang-engineering.com
Cc: linux-mmc@vger.kernel.org

Hello Wolfram Sang,

The patch 6186d06c519e: "mmc: parse new binding for eMMC fixed driver
type" from Oct 15, 2017, leads to the following static checker
warning:

	drivers/mmc/core/mmc.c:1309 mmc_select_driver_type()
	error: uninitialized symbol 'drv_type'.

drivers/mmc/core/mmc.c
  1291  static void mmc_select_driver_type(struct mmc_card *card)
  1292  {
  1293          int card_drv_type, drive_strength, drv_type;
  1294          int fixed_drv_type = card->host->fixed_drv_type;
  1295  
  1296          card_drv_type = card->ext_csd.raw_driver_strength |
  1297                          mmc_driver_type_mask(0);
  1298  
  1299          if (fixed_drv_type >= 0)
  1300                  drive_strength = card_drv_type & mmc_driver_type_mask(fixed_drv_type)
  1301                                   ? fixed_drv_type : 0;

drv_type is not initialized if fixed_drv_type is greater than zero.

  1302          else
  1303                  drive_strength = mmc_select_drive_strength(card,
  1304                                                             card->ext_csd.hs200_max_dtr,
  1305                                                             card_drv_type, &drv_type);
  1306  
  1307          card->drive_strength = drive_strength;
  1308  
  1309          if (drv_type)
                    ^^^^^^^^

  1310                  mmc_set_driver_type(card->host, drv_type);
  1311  }

regards,
dan carpenter
