From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller 3.0
Date: Fri, 18 Feb 2011 11:17:42 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181408.35946.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
 <201102181640.16398.arnd@arndb.de>
 <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:5819
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754021Ab1BRRRy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 12:17:54 -0500
In-Reply-To: <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>, Nicolas Pitre <nico@fluxnic.net>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Friday, February 18, 2011 9:19 PM
> To: Nath, Arindam
> Cc: Zhangfei Gao; Chris Ball; linux-mmc@vger.kernel.org; Su, Henry; Lu,
> Aaron; anath.amd@gmail.com; Nicolas Pitre
> Subject: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller
> 3.0
> 
> 
> Arindam,
> 
> Could you look at making (Tuning)  CMD19 part of the sdhc.ci driver?
> It flow is part of the Host Controller and Physical layer specs.

There are two main reasons for exposing the callback of tuning procedure from sdhci.c:

1. The tuning procedure is part of UHS-I initialization sequence as described in Physical Layer Spec v3.01. Since the UHS-I init sequence takes places inside sd.c, so I thought it better to place it there instead.
2. In future, if we need to add support for UHS-I sequence for sdio cards too, we can use the same callback from sdhci.c without any modifications.

I am open to suggestions.

Regards,
Arindam

