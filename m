From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 06:08:54 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCED1913@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-2-git-send-email-arindam.nath@amd.com>
 <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
 <201102181150.41350.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:53625
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754207Ab1BRMJA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Feb 2011 07:09:00 -0500
In-Reply-To: <201102181150.41350.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, zhangfei gao <zhangfei.gao@gmail.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Friday, February 18, 2011 4:21 PM
> To: zhangfei gao
> Cc: Nath, Arindam; cjb@laptop.org; linux-mmc@vger.kernel.org; Su,
> Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
> 
> On Friday 18 February 2011 11:45:27 zhangfei gao wrote:
> > On Tue, Feb 15, 2011 at 4:34 AM, Arindam Nath <arindam.nath@amd.com>
> wrote:
> > > Host Controller v3.00 and later support Auto CMD23 in the Transfer
> > > Mode register. Since Auto CMD23 can be used with or without DMA,
> > > and if used with DMA, it should only be ADMA, we check against
> > > SDHCI_USE_SDMA not being set. This flag is reset when
> SDHCI_USE_ADMA
> > > is set.
> > >
> > > A new definition for SDHCI_ARGUMENT2 register has been added
> > > in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program
> the
> > > block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> > > stop multiple block transfers. But during error recovery procedure,
> > > we will need to send Abort command, so we use a global variable
> > > abort_cmd to save the stop command to be used later.
> > >
> > > Two bits are added to SCR register as per the Physical Layer Spec
> v3.01,
> > > which specify whether the card supports CMD20 and/or CMD23. We use
> this
> > > as one of the conditions to decide whether to enable Auto CMD23 or
> not.
> > >
> > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> 
> Why are you doing this in the SDHC code and not in the block driver
> code?
> 
> AFAICT, whether CMD23 can be used or not is primarily a decision based
> on
> the card, and the block driver might want issue it for a longer range
> if it needs to split a block request into multiple MMC requests.

Thanks for the comments. Yes, whether a card supports CMD23 depends on the card, but Auto CMD23 is a feature added to the Host Controller v3.00 just like Auto CMD12. I am already doing a check inside sdhci_host_auto_cmd23_supported() whether the card supports CMD23, and whether the request is for multiple block transfers. Also I tried to make my implementation consistent with Auto CMD12 implementation already there in the sdhc code.

Regards,
Arindam

