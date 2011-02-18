From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 07:35:05 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <201102181150.41350.arnd@arndb.de>
 <6C03668EAF45B747AF947A1603D1B300DCED1913@SAUSEXMBP01.amd.com>
 <201102181408.35946.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:30609 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1BRNfK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 08:35:10 -0500
In-Reply-To: <201102181408.35946.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Friday, February 18, 2011 6:39 PM
> To: Nath, Arindam
> Cc: zhangfei gao; cjb@laptop.org; linux-mmc@vger.kernel.org; Su, Henry;
> Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
> 
> On Friday 18 February 2011, Nath, Arindam wrote:
> > > AFAICT, whether CMD23 can be used or not is primarily a decision
> based
> > > on
> > > the card, and the block driver might want issue it for a longer
> range
> > > if it needs to split a block request into multiple MMC requests.
> >
> > Thanks for the comments. Yes, whether a card supports CMD23 depends
> on
> > the card, but Auto CMD23 is a feature added to the Host Controller
> v3.00
> > just like Auto CMD12. I am already doing a check inside
> > sdhci_host_auto_cmd23_supported() whether the card supports CMD23,
> and
> > whether the request is for multiple block transfers. Also I tried to
> make
> > my implementation consistent with Auto CMD12 implementation already
> > there in the sdhc code.
> 
> Ok, I see.
> 
> But, assuming that the block driver was changed to always to CMD23
> where
> appropriate, what is the advantage auf Auto CMD23?

Quoting verbatim from the Host Controller Spec v3.00, section 1.15 --

Auto CMD23 is a feature that automatically issues a CMD23 before a CMD18 or CMD25 is sent. Objective of this function is to avoid performance deterioration during memory access by removing interrupt service of CMD23.

Regards,
Arindam

