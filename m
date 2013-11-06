From: Peter Guo <peter.guo@bayhubtech.com>
Subject: RE: [PATCH] mmc:sdhci fix 2 tuning issues in sdchi_exectuing_tuning
Date: Wed, 6 Nov 2013 11:14:30 +0000
Message-ID: <ddebee7a9b284b968a8a10f7cb2bc3c6@BN1PR04MB091.namprd04.prod.outlook.com>
References: <97254cf7c23548fdbb3ebc10170af6a8@BL2PR04MB083.namprd04.prod.outlook.com>
 <20131016081532.GB3416@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1lp0149.outbound.protection.outlook.com ([207.46.163.149]:49911
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068Ab3KFLOe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Nov 2013 06:14:34 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Samuel Guan <samuel.guan@bayhubtech.com>, Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>, Adam Lee <adam.lee@canonical.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,

Do you have any comments on this patch?

Thanks,
Peter.Guo

-----Original Message-----
From: Peter Guo 
Sent: Tuesday, October 29, 2013 6:55 PM
To: 'Chris Ball'; 'linux-mmc@vger.kernel.org'; 'linux-kernel@vger.kernel.org'
Cc: Samuel Guan; Xiaoguang Yu; Shirley Her; Yuxiang Wan; 'Adam Lee'
Subject: [PATCH] mmc:sdhci fix 2 tuning issues in sdchi_exectuing_tuning


1. Tuning success at 40th time should be ok, but current code take this as
   failed.
2. tuning_count equals to 0 means disable retuning function, but current
   code still do retuning.

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---

