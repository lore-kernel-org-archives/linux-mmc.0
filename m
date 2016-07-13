From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] mmc: pxamci: fix card detect with slot-gpio API
Date: Wed, 13 Jul 2016 23:14:07 +0300
Message-ID: <20160713201407.GA19098@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44554 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMUOS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2016 16:14:18 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org

Hello Robert Jarzmik,

The patch fd546ee6a7dc: "mmc: pxamci: fix card detect with slot-gpio
API" from Sep 26, 2015, leads to the following static checker warning:

	drivers/mmc/host/pxamci.c:809 pxamci_probe()
	warn: variable dereferenced before check 'host->pdata' (see line 798)

drivers/mmc/host/pxamci.c
  775  
   776          if (host->pdata) {
                    ^^^^^^^^^^^
We check it here.

   777                  gpio_cd = host->pdata->gpio_card_detect;
   778                  gpio_ro = host->pdata->gpio_card_ro;
   779                  gpio_power = host->pdata->gpio_power;
   780          }
   781          if (gpio_is_valid(gpio_power)) {
   782                  ret = devm_gpio_request(&pdev->dev, gpio_power,
   783                                          "mmc card power");
   784                  if (ret) {
   785                          dev_err(&pdev->dev, "Failed requesting gpio_power %d\n",
   786                                  gpio_power);
   787                          goto out;
   788                  }
   789                  gpio_direction_output(gpio_power,
   790                                        host->pdata->gpio_power_invert);
   791          }
   792          if (gpio_is_valid(gpio_ro))

If gpio_is_valid is valid that implies "host->pdata" is non-NULL.


   793                  ret = mmc_gpio_request_ro(mmc, gpio_ro);
   794          if (ret) {
                    ^^^
If host->pdata is NULL that implies ret is zero.  If it's non-NULL then
ret could be zero or negative.

   795                  dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
   796                  goto out;
   797          } else {
   798                  mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
                                      ^^^^^^^^^^^^^
Potential oops.

   799                          0 : MMC_CAP2_RO_ACTIVE_HIGH;
   800          }
   801  
   802          if (gpio_is_valid(gpio_cd))
   803                  ret = mmc_gpio_request_cd(mmc, gpio_cd, 0);
   804          if (ret) {
   805                  dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
   806                  goto out;
   807          }
   808  
   809          if (host->pdata && host->pdata->init)
                    ^^^^^^^^^^^
There are no possible path where we can reach this check with
host->pdata is NULL and we haven't oopsed.

   810                  host->pdata->init(&pdev->dev, pxamci_detect_irq, mmc);
   811  

regards,
dan carpenter
