From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sdhci: fix DMA leaks [was: [SHDCI] Heavy (thousands) DMA
 leaks]
Date: Wed, 5 Aug 2015 18:25:22 +0200
Message-ID: <20150805162522.GC16341@amd>
References: <55B9EF02.7040404@suse.cz>
 <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
 <55BF36D6.4080504@suse.cz>
 <55C1F919.4080002@suse.cz>
 <55C227B4.3030102@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54588 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbHEQZY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2015 12:25:24 -0400
Content-Disposition: inline
In-Reply-To: <55C227B4.3030102@suse.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Chen Bough <Haibo.Chen@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>

On Wed 2015-08-05 17:11:48, Jiri Slaby wrote:
> On 08/05/2015, 01:52 PM, Jiri Slaby wrote:
> >> Yes, I see:
> >> sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 65536 bytes)
> >> after some time. The driver falls back to non-DMA transfers after that.
> >> It also generates a warning about that:
> >> WARNING: CPU: 0 PID: 0 at drivers/mmc/host/sdhci.c:857
> >> sdhci_prepare_data+0x8ec/0x900 [sdhci]()
> > 
> > I am attaching a debug patch and a debug log. You can see where
> > 0x00000000fffb0000 and 0x00000000fffe0000 is leaked. It is when 'invalid
> > cookie' error happens.
> 
> And you could see the cookie handling is totally bogus.
> 
> With this rewrite, I no longer see the problems. Could you confirm it
> still does the good job with respect to performance -- the numbers you
> mentioned in your commit.
> 
> Ulf, what do you think about the attached patch? (Do not look at the
> commented info prints.)

Umm. Normally we inline patches for easier comments.

Attaching it with type of _mailbox_ is not really good.

									Pavel

[-- Attachment #2: fix.patch --]
[-- Type: application/mbox, Encoding: base64, Size: 8.2K --]





-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
