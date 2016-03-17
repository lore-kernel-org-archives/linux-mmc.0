From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt
 on AM335x
Date: Thu, 17 Mar 2016 20:32:50 +0300
Message-ID: <20160317173250.GA21370@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49623 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030207AbcCQRdB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2016 13:33:01 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: afenkart@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hello Andreas Fenkart,

The patch 455e5cd6f736: "mmc: omap_hsmmc: Pin remux workaround to
support SDIO interrupt on AM335x" from May 29, 2014, leads to the
following static checker warning:

	drivers/mmc/host/omap_hsmmc.c:1788 omap_hsmmc_configure_wake_irq()
	error: 'p' dereferencing possible ERR_PTR()

drivers/mmc/host/omap_hsmmc.c
  1780          if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
  1781                  struct pinctrl *p = devm_pinctrl_get(host->dev);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
  1782                  if (!p) {
  1783                          ret = -ENODEV;
  1784                          goto err_free_irq;
  1785                  }
  1786                  if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
  1787                          dev_info(host->dev, "missing default pinctrl state\n");
  1788                          devm_pinctrl_put(p);
                                ^^^^^^^^^^^^^^^^^^^^

I believe that devm_pinctrl_get() only returns NULL when we are building
with COMPILE_TEST and not on bootable kernels.

This is an annoying thing, btw, because Smatch does cross function
analysis and I have to handle all these as a special case.  "Whatever
function() returns ERR_PTR (and never NULL) in real life but NULL when
you are parsing the inline code."  A lot of people do this or the
opposite and I can't see how it hels anyone, only how it hurts me.

And of course doing it all backwards depending leads to bugs like this.

  1789                          ret = -EINVAL;
  1790                          goto err_free_irq;
  1791                  }
  1792  
  1793                  if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_IDLE))) {
  1794                          dev_info(host->dev, "missing idle pinctrl state\n");
  1795                          devm_pinctrl_put(p);
  1796                          ret = -EINVAL;
  1797                          goto err_free_irq;
  1798                  }
  1799                  devm_pinctrl_put(p);
  1800          }

regards,
dan carpenter
