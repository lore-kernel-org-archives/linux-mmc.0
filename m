From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/3] ARM: Kirkwood: Add DT support for (eSATA)
 Sheevaplug
Date: Mon, 13 May 2013 13:30:17 -0400
Message-ID: <20130513173017.GV31290@titan.lakedaemon.net>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10774 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752149Ab3EMRam (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 13:30:42 -0400
Content-Disposition: inline
In-Reply-To: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, thomas.petazzoni@free-electrons.com, andrew@lunn.ch, cjb@laptop.org

On Mon, Apr 22, 2013 at 09:54:57PM +0200, Simon Baatz wrote:
> These patches add DT support for the Sheevaplugs by Globalscale
> Technologies.  There exists two versions, one with an eSATA port and
> one without.
> 
> Surprisingly, the conversion was not straight forward. In the eSATA
> version (board revision 1.3), the CD and WP pins are connected to GPIO
> lines, but I could not get this to work.  Apparently, I am not the only
> one ([1]).  I found that the pins are reversed on my hardware and use
> different active low/active high settings.
> 
> Thus, the first patch adds support for the GPIO active low/high flag in
> DT to the mvsdio driver.
> 
> With that, everything except the Gigabit Ethernet can be described in
> the DTS.  I have split the DTS and the board support files into two
> patches.  This way, we can drop the last patch once we can describe
> everything in the DTS or we can squash them together if we don't want
> to wait.
> 
> I could only test on an eSATA Sheevaplug. I found patches with
> different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> someone with the hardware could give this a spin on a non-eSATA
> version.  Some additional testing of the change detect and write
> protect behaviour for sdio can't hurt either.  I hope that there aren't
> board revisions with different CD/WP pins out there.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062567.html
> 
> Simon Baatz (3):
>   mmc: mvsdio: Support inverted CD and WP GPIO lines
>   ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
>   ARM: Kirkwood: Add DT support for Sheevaplug and Sheevaplug eSATA

Simon,

Were you able to find any time to work on this?

thx,

Jason.
