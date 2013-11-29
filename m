From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Fri, 29 Nov 2013 08:34:24 -0800
Message-ID: <20131129163424.GK31534@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
 <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
 <20131127213726.GB26766@atomide.com>
 <52977711.6030806@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51760 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3K2Qef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Nov 2013 11:34:35 -0500
Content-Disposition: inline
In-Reply-To: <52977711.6030806@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

* Jarkko Nikula <jarkko.nikula@bitmer.com> [131128 09:03]:
> Hi
> 
> On 11/27/2013 11:37 PM, Tony Lindgren wrote:
> > * Jarkko Nikula <jarkko.nikula@bitmer.com> [131127 12:55]:
> > Bummer, sounds like some duplicate work could have been avoided :(
> > I suggest resend to Chris and linux-mmc one more time as Chris should
> > pick up the MMC patches in general.
> > 
> Before that should Chris merge your 2 patches in order to avoid couple
> trivial merge conflicts with my set when linux-omap and mmc are merged?

Those are already queued to arm-soc/fixes branch and should hit the
mainline tree within next few days, hopefully before -rc2 so it's probably
to wait for that for that for further fixes.

Regards,

Tony
