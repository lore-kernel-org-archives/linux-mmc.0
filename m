From: Peter Guo <peter.guo@bayhubtech.com>
Subject: RE: [PATCH v3] mmc:sdhci-pci: Add Support of O2Mirco/BayHubTech SD
 Host
Date: Wed, 6 Nov 2013 11:16:20 +0000
Message-ID: <2b022a4239ee41c481e9e8fa427efa57@BN1PR04MB091.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:25285
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756416Ab3KFLQb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 06:16:31 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Samuel Guan <samuel.guan@bayhubtech.com>, Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>, Adam Lee <adam.lee@canonical.com>, Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bill Pemberton <wfp5p@virginia.edu>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,

Do you have any comments on this patch?

Thanks,
Peter.Guo

-----Original Message-----
From: Peter Guo 
Sent: Monday, October 28, 2013 7:34 PM
To: 'Chris Ball'; 'Adrian Hunter'; 'Greg Kroah-Hartman'; 'Bill Pemberton'; 'Guennadi Liakhovetski'; 'linux-mmc@vger.kernel.org'; 'linux-kernel@vger.kernel.org'
Cc: Samuel Guan; Xiaoguang Yu; Shirley Her; Yuxiang Wan; 'Adam Lee'
Subject: [PATCH v3] mmc:sdhci-pci: Add Support of O2Mirco/BayHubTech SD Host

Add O2Micro/BayHubTech SD Host DeviceId 8520 support.
Add O2Micro/BayHubTech SD Host DeviceId 8420 & 8421 support.
Add O2Micro/BayHubTech SD Host DeviceID 8620 & 8621 support.
Move O2Micro/BayHubTech SD Host support code to sdhci-pci-o2micro.c

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---

