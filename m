From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Wed, 27 Nov 2013 22:57:04 +0200
Message-ID: <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-3-git-send-email-tony@atomide.com>
	<20131118184723.GR10317@atomide.com>
	<87ioveeo0x.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48095 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757198Ab3K0UyN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Nov 2013 15:54:13 -0500
In-Reply-To: <87ioveeo0x.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hi Chris

On Tue, 26 Nov 2013 18:33:50 -0500
Chris Ball <cjb@laptop.org> wrote:

> Hi Tony,
> 
> On Mon, Nov 18 2013, Tony Lindgren wrote:
> > We are wrongly relying on device id for the DMA configuration
> > which can lead to wrong DMA channel being selected.
> >
> > Fix the issue by using the standard resources like we should.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Feel free to merge via your tree:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
Can you enlighten me what's the proper way to get patches to mmc since
I cannot figure out working methodology from MAINTAINERS file?

I happened to notice that Tony had this similar patch in linux-omap
list I sent first time already September to you and linux-mmc (sorry
linux-omap folks, I didn't want to spam multiple lists):

http://www.spinics.net/lists/linux-mmc/msg22137.html

After that I've resend the set a few times including a fix to
user triggable NULL pointer dereference:

http://www.spinics.net/lists/linux-mmc/msg22610.html

I'm fine if mmc patches should go through other subsystems but at least
it should be documented in MAINTAINERS file.

-- 
Jarkko
