From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 1 Oct 2015 10:33:25 +0100
Message-ID: <20151001093325.GU21513@n2100.arm.linux.org.uk>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
 <20150924233756.GN23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59635 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033AbbJAJdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2015 05:33:42 -0400
Content-Disposition: inline
In-Reply-To: <20150924233756.GN23801@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, arm@kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 24, 2015 at 04:37:56PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150924 02:04]:
> > Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
> > SDP fail to boot due to lack of working MMC.  Both platforms fail to
> > find their rootfs, which is on a SD card.
> > 
> > The breakage occurred somewhere between trees of September 9th (commit
> > 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
> > merge window.
> 
> Yes sorry things got messed up in multiple ways :( I've summarized
> the mess here earlier:
> 
> http://article.gmane.org/gmane.linux.kernel.mmc/33911
> 
> And today commit b9c93646fd5c ("regulator: pbias: program pbias register
> offset in pbias driver") hit mainline so I'll send a pull request for
> the related dts change.

It's still broken and untestable.  We're 8 days off it being a full
month worth of failed testing for OMAP3 and OMAP4 platforms.

I think OMAP and MMC people need to do a post-mortem and work out why
this happened, and how to stop it happening again in the future.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
