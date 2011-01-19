From: Philip Rakity <prakity@marvell.com>
Subject: Re: A MMC card transfer issue
Date: Tue, 18 Jan 2011 16:59:32 -0800
Message-ID: <190C6814-8150-491F-AB90-05A93B347246@marvell.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
 <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com>
 <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com>
 <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com>
 <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com>
 <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47764 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752871Ab1ASA7o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Jan 2011 19:59:44 -0500
In-Reply-To: <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: Kyungmin Park <kmpark@infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andrew.chih.howe.khor@intel.com" <andrew.chih.howe.khor@intel.com>, "kok.howg.ewe@intel.com" <kok.howg.ewe@intel.com>


I just looked in the 2.6.37 code and the fix is not there.  It is in the 2.6.37 linus  tree.  

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/mmc/core/mmc.c;h=16006ef153fe081c2f0f0a09cd4443ce7f3c49a1;hb=a25cecce88194b2edf38b8c3b1665e9318eb2d22

Chris Ball who maintains this should know when it will be pushed upwards.

Philip 
On Jan 18, 2011, at 4:36 PM, Tomoya MORINAGA wrote:

> Hi Philip,
>  
> On Wednesday, December 01, 2010 10:31 AM, Philip Rakity wrote:
> > Thanks very much, I'll plan on sending this to Linus tomorrow, along
> > with the rest of my .37 queue, unless there are any more review
> > comments from anyone.
>  
> We tried to use the MMC card like the following on kernel-2.6.37.
>  
> On Tuesday, November 09, 2010 2:40 PM, Tomoya MORINAGA wrote:
> > I am facing the issue about some MMC cards on Intel EG20T PCH 
> > (Platform Controller Hub).
> > The linux version is 2.6.36.
> > I can not transfer data the MMC cards (e.g. Transcned MMC card).
> > The card is 1 bit bus width. And the card is according to MMC 
> > specification V3.x.
> > And the EG20T has a 4 bit bus width capability Linux MMC 
> > standard driver decides the card bus width as 4 bit, if the 
> > MMC specification version is larger than or equal to V4.0 like below.
>  
> However it seems the issue remains to be seen.
> Have you fixed the MMC unrecognized issue in kernel-2.6.37?
>  
> Thanks,
> -----------------------------------------
> Tomoya MORINAGA
> OKI SEMICONDUCTOR CO., LTD.

