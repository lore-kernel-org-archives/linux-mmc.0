From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [Patch 1/1]sdhci: verify ddr50 mode
Date: Wed, 3 Nov 2010 23:26:50 -0400
Message-ID: <AANLkTi=iNe+Fg8tqTSj7H+UKOB-J=xb5gGp4x3ZNnEiH@mail.gmail.com>
References: <AANLkTin5S_xKj_H5tFUE+RHa-T_z0USvhdzap3fpSaa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49493 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0KDD0v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 23:26:51 -0400
Received: by fxm16 with SMTP id 16so1104009fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Nov 2010 20:26:50 -0700 (PDT)
In-Reply-To: <AANLkTin5S_xKj_H5tFUE+RHa-T_z0USvhdzap3fpSaa8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi All,

The regulator voltage change need some time to keep stable, how could
we put in set_ios, which inside spin_lock, can not use msleep.

>From spec 3.0.
1.8V Signaling Enable Setting
Setting this bit from 1 to 1 starts changing signal voltage from 3.3v
to 1.8v. 1.8v voltage output shall be stable within 5ms. Host
Contrller clears this bit if switching to 1.8v fails.
Clearing this bit from 1 to 0 starts changing signal voltage from 1.8v
to 3.3v . 3.3V regulatro output shall be stable within 5ms.

According to spec, we should wait 5ms to check SDHCI_CTRL2_1_8V
whether it is set or not.
However, here is spin_lock, and we can not put msleep inside.
Our controller does not switch to 1.8v in fact, so the ddr50 mode work
at 3.3v in fact.
Currently our controller count on external pmic to provide 1.8v when
support SBR mode, however, how to consider wait 5ms or so to wait
regulator to be stable.

Thanks

+       if (ddr & MMC_1_8V_DDR_MODE) {
+               con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+               con |= SDHCI_CTRL2_1_8V;
+               sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+
+               /* Wait 5 ms to check 1.8v regulator swithing success or not */
+               msleep(5);
+               if (!(sdhci_readw(host, SDHCI_HOST_CONTROL2)
+                                       & SDHCI_CTRL2_1_8V)) {
+                       printk(KERN_ERR "%s: HOST CONTROL fail switch
to 1.8v\n",
+                                       mmc_hostname(host->mmc));
+                       sdhci_dumpregs(host);
+                       return;
+               }
+               con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+               con &= ~SDHCI_CTRL2_UHS_MASK;
+               if (ddr & MMC_1_8V_DDR_MODE)
+                       con |= SDHCI_CTRL2_DDR50;
+               sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+       }
