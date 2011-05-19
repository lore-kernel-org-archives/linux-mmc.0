From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] mmc_test: how use mmc_test on only eMMC board
Date: Thu, 19 May 2011 13:53:19 +0900
Message-ID: <4DD4A23F.10400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35930 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab1ESExY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 00:53:24 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLF00LB0EWYGTH0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 May 2011 13:53:22 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLF00HYYEWYI0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 May 2011 13:53:22 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi mailing..

I want to know how use mmc_test..

In my case, i used only eMMC board.
So i didn't use unbind/bind for mmc_test.

echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
then rootfs of my board has be broken 

Plz let me know..

Regards,
Jaehoon Chung
