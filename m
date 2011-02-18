From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller 3.0
Date: Fri, 18 Feb 2011 13:55:11 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102181352090.14920@xanadu.home>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181408.35946.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
 <201102181640.16398.arnd@arndb.de>
 <F099B2A7-9E9B-4E33-A1D7-2C975A1A3BAB@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20613 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1BRSzM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 13:55:12 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGT00HUZTV9N6D0@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 18 Feb 2011 13:54:45 -0500 (EST)
In-reply-to: <6C03668EAF45B747AF947A1603D1B300DCED1BCC@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Fri, 18 Feb 2011, Nath, Arindam wrote:

> Hi Philip,
> 
> 
> > -----Original Message-----
> > From: Philip Rakity [mailto:prakity@marvell.com]
> > Sent: Friday, February 18, 2011 9:19 PM
> > To: Nath, Arindam
> > Cc: Zhangfei Gao; Chris Ball; linux-mmc@vger.kernel.org; Su, Henry; Lu,
> > Aaron; anath.amd@gmail.com; Nicolas Pitre
> > Subject: [PATCH 01/12] mmc: sdhci: add support for SD Host Controller
> > 3.0
> > 
> > 
> > Arindam,
> > 
> > Could you look at making (Tuning)  CMD19 part of the sdhc.ci driver?
> > It flow is part of the Host Controller and Physical layer specs.

Still, if this is something that is common to all host controllers then 
it should live in the core code.  The host controller driver should be 
as dumb as possible and try to be command agnostic.

> There are two main reasons for exposing the callback of tuning procedure from sdhci.c:
> 
> 1. The tuning procedure is part of UHS-I initialization sequence as described in Physical Layer Spec v3.01. Since the UHS-I init sequence takes places inside sd.c, so I thought it better to place it there instead.
> 2. In future, if we need to add support for UHS-I sequence for sdio cards too, we can use the same callback from sdhci.c without any modifications.

And this won't have to be duplicated in all the host controller drivers.


Nicolas
