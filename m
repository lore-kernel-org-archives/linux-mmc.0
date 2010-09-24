From: Richard Zhu <r65037@freescale.com>
Subject: [4-0] Serial patchs that upstream fsl i.MX MX51 sdhci driver
Date: Fri, 24 Sep 2010 11:43:04 +0800
Message-ID: <1285299788-32209-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:6578 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753491Ab0IXDjc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:39:32 -0400
Received: from mail164-va3 (localhost.localdomain [127.0.0.1])	by
 mail164-va3-R.bigfish.com (Postfix) with ESMTP id 9E4341A003A1	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:39:30 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.247])	by
 mail164-va3.bigfish.com (Postfix) with ESMTP id 2EE151B8050	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:39:29 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o8O3dRlM002056	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:39:28 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o8O3ruHd001157	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:53:57 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi Wolfram:
Here are the patches that I changed the codes refer to your previous comments.
The data IO and WP func are verified on the i.MX51 BBG board.

The missing bits of the HOST_CONTROL and so on had been complemented in 4-3 patch.

Hi Uwe:
The MSL specifed part code is still on-going.
I would change them to the "dynamically allocated method" later.

Any review/comments and suggestions are appreciated.
Thanks in advanced.
[4-1] sdhci/sdhci-pltfm common codes modifications when support FSL eSDHC driver.
[4-2] MX51 MSL codes modification.
[4-3] i.MX sdhci driver seperated from MPC esdhc driver.
[4-4] board config


