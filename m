From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 0/4] Adding support for esdhc on mx35/51
Date: Fri, 24 Sep 2010 10:40:22 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D4BC5@zch01exm22.fsl.freescale.net>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:21678
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab0IXCki convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 22:40:38 -0400
Received: from mail48-am1 (localhost.localdomain [127.0.0.1])	by
 mail48-am1-R.bigfish.com (Postfix) with ESMTP id CD36C14A829C	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 02:40:34 +0000 (UTC)
Received: from am1ehsmhs011.bigfish.com (unknown [10.3.201.246])	by
 mail48-am1.bigfish.com (Postfix) with ESMTP id C6BC2F30055	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 02:40:27 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O2eOet028771	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 19:40:25
 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8O2eNrT023359	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 21:40:23
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram:
I have the following a few common comments about these patches.

* About the share between i.MX and PPC eSDHC.
Why configure a few parts be shared between the i.MX eSDHC and PPC
eSDHC? Can they be separated into two independent systems?
It would bring the conveniences to maintain stuff in the future if we
separate them.
And there is already one set of eSDHC driver for all the i.MX SOCs.
As we know that i.MX and PPC are the disparate SOC families.

* About the driver name of i.MX eSDHC driver, I think that use the imx
to identify it is better than esdhc.
As I know that the eSDHC name wouldn't be used anymore in next
generation SOCs of i.MX family.
So the name of imx would be much clear and exact.


Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 

-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Tuesday, 21 September, 2010 20:30
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org; Anton Vorontsov; Zhu
Richard-R65037; Wolfram Sang
Subject: [PATCH 0/4] Adding support for esdhc on mx35/51

Hi,

this series adds basic support for the esdhc-controller found on
mx35/51-cpus.
It first extends the sdhci-pltfm-driver to have a runtime-structure for
data (1/4), does a bit of cleanup (2/4), extracts a few parts which can
be shared with the OF-version (3/4) and finally adds the driver (4/4).

Note that the support is basic at the moment. Still to be done are:

* ADMA support (Richard Zhu mentioned it has issues and knows the
details)

* 8-Bit bus width (needs more research; it breaks some cards for me :( )

* voltage switching using a regulator (I don't have such hardware,
hopefully
  Richard can pick this up)

* write_protect using a GPIO (we need to retrieve board-specific data
for that;
  an RFC follows after this series)

Platform resources could be posted after write_protect issue has been
sorted out.

Please review and/or give comments. Please let me also know if you
intend to work on a missing bit.

Thanks,

   Wolfram

===

Wolfram Sang (4):
  mmc: sdhci-pltfm: Add structure for host-specific data
  mmc: sdhci-pltfm: move .h-file into apropriate subdir
  mmc: sdhci-of-esdhc: factor out common stuff
  mmc: sdhci-pltfm: add pltfm-driver for imx35/51

 drivers/mmc/host/Kconfig          |    9 +++
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/sdhci-cns3xxx.c  |    2 +-
 drivers/mmc/host/sdhci-esdhc.c    |  141
+++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h    |   81 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |   70 ++----------------
 drivers/mmc/host/sdhci-pltfm.c    |   12 +++-
 drivers/mmc/host/sdhci-pltfm.h    |    8 ++-
 include/linux/mmc/sdhci-pltfm.h   |   35 +++++++++
 include/linux/sdhci-pltfm.h       |   35 ---------
 10 files changed, 292 insertions(+), 102 deletions(-)  create mode
100644 drivers/mmc/host/sdhci-esdhc.c  create mode 100644
drivers/mmc/host/sdhci-esdhc.h  create mode 100644
include/linux/mmc/sdhci-pltfm.h  delete mode 100644
include/linux/sdhci-pltfm.h



