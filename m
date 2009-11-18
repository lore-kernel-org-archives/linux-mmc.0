From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH] [mmc-omap] Add support for 16-bit and 32-bit registers
Date: Thu, 19 Nov 2009 00:35:41 +0100
Message-ID: <20091118233541.GA25192@localhost.localdomain>
References: <1258255495.4209.3.camel@runt> <20091118184152.GA6865@localhost.localdomain> <6cb013310911181309w6e21b8e9o62fad1a80f300c08@mail.gmail.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:47391 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbZKRWfe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Nov 2009 17:35:34 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310911181309w6e21b8e9o62fad1a80f300c08@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Nov 18, 2009 at 01:09:22PM -0800, Cory Maccarrone wrote:
> On Wed, Nov 18, 2009 at 10:41 AM, Ladislav Michl
> <Ladislav.Michl@seznam.cz> wrote:
> > Did you test it? It does not work on 5910, see here:
> > http://thread.gmane.org/gmane.linux.kernel.mmc/649
> 
> Not sure why it wouldn't work on the 5910.  I tested it on my device,
> and it works properly for me, but then I don't have an omap-based
> device that uses 32-bit register definitions.  I'm confused at the
> post you have above though...Is that with my patch, or is that with
> something else?  It seems to reference the status of current git,
> which I don't think this patch shouldn't be in.

To put it clear, current git does not work and it is unrelated to your patch.
If driver works for you with your patch, then either your MMC card or
controller in your SoC survives multiple init sequences or it has something
to do with clock settings or... You can find two more people confirming
this here: http://www.spinics.net/lists/linux-omap/msg09547.html
I'll probably need to find some time to read MMC spec.

	ladis
