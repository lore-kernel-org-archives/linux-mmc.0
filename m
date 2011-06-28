From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] How working MMC_BUS_WIDTH_TEST??
Date: Tue, 28 Jun 2011 19:54:27 +0900
Message-ID: <4E09B2E3.20903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31285 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab1F1KyM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 06:54:12 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LNH007TIYA6UQP0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jun 2011 19:54:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LNH005X1YAA91@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jun 2011 19:54:10 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi..

I found the MMC_CAP_BUS_WIDTH_TEST...
In mailing, I read the related patches..
but i didn't fully understand...

/*
 * If controller can't handle bus width test,
 * compare ext_csd previously read in 1 bit mode
 * against ext_csd at new bus width
 */
if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
	err = mmc_compare_ext_csds(card,
		ext_csd,
		bus_width);
else
	err = mmc_bus_test(card, bus_width);
if (!err)
	break;

And i tested suspend/resume..it's failed..
If i didn't set MMC_CAP_BUS_WIDTH_TEST, always return -EINVAL..
(using SDHCI controller, card is eMMC4.41)

Didn't compare ext_csd's value..

So i want to know how use MMC_CAP_BUS_WIDTH_TEST..

Thanks,
Jaehoon Chung
