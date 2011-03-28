From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: SPB104 SDIO WIFI card
Date: Mon, 28 Mar 2011 12:16:05 +0200
Message-ID: <4D905FE5.5000804@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:50848 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802Ab1C1KQQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Mar 2011 06:16:16 -0400
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8CC60111
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 10:16:11 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas5.st.com [10.75.90.71])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45CD92480
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 10:16:11 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Youssef TRIKI <youssef.triki@st.com>

Hello.
I need to use the SPB104 SDIO WiFi card on ST40 platforms with the SDHCI
HC driver.

IIUC, there is no support within the Kernel for this WiFi device.

I've found the driver at:
http://www.hd-wireless.se/index.php?option=com_content&view=article&id=46&Itemid=53
This is for ARM platform, only. Please, correct me if I'm wrong.

I wonder if somebody has used this card on *not* arm platforms.
If yes, please, could you help me to find the driver?

Looking at the d.d. (I mentioned above) there is, inside the
owl-linux-arm-1.0.4.tar.gz tarball file, a library prebuilt for ARM.
Where could I get the sources for this file? Hmm, contact Atmel
directly? :-)

In the end, I could buy other card for my development.
In this case, I wonder if somebody could point me to a WiFi card fully
supported and tested in Linux.

Many thanks in advance.

Best Regards,
Giuseppe
