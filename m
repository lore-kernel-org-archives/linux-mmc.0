From: Lin Tony-B19295 <B19295@freescale.com>
Subject: RE: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
 from 100ms to 1ms
Date: Thu, 1 Sep 2011 07:46:37 +0000
Message-ID: <97D3A72708D04647A5AC84A04996E5B519DDC6@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
 <20110901055522.GB22652@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:50407
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754523Ab1IAHqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Sep 2011 03:46:48 -0400
In-Reply-To: <20110901055522.GB22652@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Thursday, September 01, 2011 1:55 PM
> To: Lin Tony-B19295
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> cjb@laptop.org
> Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting
> clock from 100ms to 1ms
> 
> On Thu, Sep 01, 2011 at 01:51:15PM +0800, Tony Lin wrote:
> > 1ms is enough for hardware to change the clock to stable.
> > 100ms is too long.
> 
> How do you know that? Can you be sure for PowerPC as well? Have you
> researched why the original author of the code has chosen that value? If
> so, please update your commit message with such infos.
> 
I got this confirmation by IC simulation, but sorry I just noticed that's also used for PPC.
I can update the information after got confirmation from author. 

> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

