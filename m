From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller 3.0
Date: Fri, 18 Feb 2011 07:49:13 -0800
Message-ID: <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181408.35946.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
 <201102181640.16398.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47771 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1BRP47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 10:56:59 -0500
In-Reply-To: <201102181640.16398.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <Arindam.Nath@amd.com>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>, Nicolas Pitre <nico@fluxnic.net>


Arindam,

Could you look at making (Tuning)  CMD19 part of the sdhc.ci driver?   It flow is part of the Host Controller and Physical layer specs.

I am not sure that it belongs in core/ as it is transparent to the other functions and is unclear why it needs to be exposed

adding Nico for comments

PHilip