From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver
Date: Fri, 24 Sep 2010 11:57:55 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D4BDC@zch01exm22.fsl.freescale.net>
References: <1285300467-5158-1-git-send-email-r65037@freescale.com> <1285300467-5158-2-git-send-email-r65037@freescale.com> <1285300467-5158-3-git-send-email-r65037@freescale.com> <1285300467-5158-4-git-send-email-r65037@freescale.com> <1285300467-5158-5-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:13558
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753293Ab0IXD6E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 23:58:04 -0400
Received: from mail22-va3 (localhost.localdomain [127.0.0.1])	by
 mail22-va3-R.bigfish.com (Postfix) with ESMTP id 98D23191020E	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:58:03 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.240])	by
 mail22-va3.bigfish.com (Postfix) with ESMTP id 4CC03148004F	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:58:02 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O3vv58028582	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:57:57
 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8O3vuYF009478	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:57:57
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1285300467-5158-5-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi:
Why I can't use the --compose to post the additional msg before sending
out the serial patches?
:(
Anyway, paste them here:

Hi Wolfram:
Here are the patches that enable the sdhci of i.MX51.
The IO and WP functions are verified on i.MX51 BBG board.
The missing bits of the HOST_CONTROL and so on had been made up in the
4-3 patch.


Hi Uwe:
I would change MSL part to the "dynamically allocated method" later.

Any review/comments/suggestions are appreciated.
Thanks in advanced.


Best Regards,
Richard Zhu
Freescale Semiconductor
Tel: +86-021-28937189
Email:Hong-Xing.Zhu@freescale.com 


-----Original Message-----
From: Zhu Richard-R65037 
Sent: Friday, 24 September, 2010 11:54
To: w.sang@pengutronix.de; u.kleine-koenig@pengutronix.de;
linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org; Zhu Richard-R65037
Subject: [PATCH 4/4] esdhc-4 mx51: enable fsl esdhc driver

Enable the fsl esdhc driver on mx51 platforms

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/configs/mx51_defconfig |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mx51_defconfig
b/arch/arm/configs/mx51_defconfig index a665ecb..4f3067b 100644
--- a/arch/arm/configs/mx51_defconfig
+++ b/arch/arm/configs/mx51_defconfig
@@ -106,8 +106,13 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK=m
-CONFIG_MMC_SDHCI=m
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_IMX=y
+# CONFIG_MMC_MXC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_RTC_CLASS=y
--
1.7.0


