From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 0/2] mmc: sdhci: fixed missing error control
Date: Tue, 05 Apr 2011 17:02:18 +0900
Message-ID: <4D9ACC8A.9080707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17453 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1DEIDu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 04:03:50 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ60043T6EATQE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Apr 2011 17:03:46 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ6006CA6EA9M@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Apr 2011 17:03:46 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>

In sdhci.c, sdhci_add_host() didn't perform correct error control.
So, We need to add correct error control.
version

v3: [1/2] mmc:sdhci: add error checking for mmc_add_host
 	* add "unregister for leds class, free buffer and del timer" reviewed by Wolfram Sang.
    [2/2] mmc:sdhci: add regulator disable/put when control error
	* fixed missing regulator disable/put

 drivers/mmc/host/sdhci.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)
    
