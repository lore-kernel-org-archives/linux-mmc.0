From: Richard Zhu <r65037@freescale.com>
Subject: [4-0] serial patches that enable the eSDHC on iMX51
Date: Fri, 24 Sep 2010 11:54:23 +0800
Message-ID: <1285300467-5158-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:9021
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601Ab0IXDu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:50:58 -0400
Received: from mail40-db3 (localhost.localdomain [127.0.0.1])	by
 mail40-db3-R.bigfish.com (Postfix) with ESMTP id 45E706D0632	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:57 +0000 (UTC)
Received: from DB3EHSMHS003.bigfish.com (unknown [10.3.81.244])	by
 mail40-db3.bigfish.com (Postfix) with ESMTP id 4A830CC8052	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:50 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O3okgJ013618	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:50:46
 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o8O3ojXO008265	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:50:46 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi All:
Sorry, for wrong --compose usage.

Hi Wolfram:
Here are the patches that enable the sdhci of i.MX51.
The IO and WP funcs are verified on i.MX51 BBG board.
The misssing bits of the HOST_CONTROL and so on had been made up in the 4-3 patch.


Hi Uwe:
I would change MSL part to the "dynamically allocated method" later.

Any review/comments/suggestions are appreciated.
Thanks in advanced.


