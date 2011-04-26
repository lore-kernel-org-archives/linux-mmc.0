From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v7] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Tue, 26 Apr 2011 15:28:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104261524030.6706@peruna>
References: <alpine.DEB.2.00.1104211735290.3919@peruna> <alpine.DEB.2.00.1104211743210.3919@peruna> <201104261614.35455.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:53799 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758193Ab1DZW2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 18:28:11 -0400
In-Reply-To: <201104261614.35455.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>

On Tue, 26 Apr 2011, Arnd Bergmann wrote:
> On Friday 22 April 2011, John Calixto wrote:
> > Allows appropriately-privileged applications to send CMD (normal) and
> > ACMD (application-specific; preceded with CMD55) commands to
> > cards/devices on the mmc bus.  This is primarily useful for enabling the
> > security functionality built in to every SD card.
> > 
> > It can also be used as a generic passthrough (e.g. to enable virtual
> > machines to control mmc bus devices directly).  However, this use case
> > has not been tested rigorously.  Generic passthrough testing was only
> > conducted for a few non-security opcodes to prove the feasibility of the
> > passthrough.
> > 
> > Since any opcode can be sent using this passthrough, it is very possible
> > to render the card/device unusable.  Applications that use this ioctl
> > must have CAP_SYS_RAWIO.
> > 
> > Security commands tested on TI PCIxx12 (SDHCI), Sigma Designs SMP8652
> > SoC, TI OMAP3621 SoC, TI OMAP3630 SoC, Samsung S5PC110 SoC, Qualcomm
> > MSM7200A SoC.
> > 
> > Signed-off-by: John Calixto <john.calixto@modsystems.com>
> > Reviewed-by: Andrei Warkentin <andreiw@motorola.com>
> 
> The implementation looks good to me now,
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'll leave the final decision whether this is a good feature to have
> to Chris. I still believe that we should have per-command ioctls
> for the security feature, but getting there would require someone
> to implement it, and I'm not going to do that.
> 


Arnd - Thanks a lot for the review and your help getting the
implementation right!

Chris - What do you think?  How should I proceed here?

John
