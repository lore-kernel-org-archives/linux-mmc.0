From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/21] Totally remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Wed, 27 Jan 2016 13:23:49 +0000
Message-ID: <20160127132348.GY10826@n2100.arm.linux.org.uk>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39476 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbcA0NYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 08:24:04 -0500
Content-Disposition: inline
In-Reply-To: <56A8BF22.8010509@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 27, 2016 at 02:59:14PM +0200, Adrian Hunter wrote:
> In my view Ulf needs to explain how the SDHCI library is going to work,
> particularly in the absence of new callbacks.

We need to add new callbacks as part of the conversion to a library,
otherwise we're very much into a total rewrite from scratch (which
I think is far too much work, and prone to errors) or a big flag day
to switch everything over (which will require a moritorium on sdhci
patches while the effort to switch everything is ongoing.)

Both of those approaches suffer from one huge drawback: there is no
way to bisect between them to locate the cause of a regression.

A piece-meal approach, where the driver is gradually converted is a
far saner approach, because it means that each conversion in the step
can be done as a series of transformations, which not only can be
properly reviewed, but also bisected - and that is _hugely_ important
for the existing state of SDHCI.

The chances of some hardware behavioural quirk being missed while
trying to convert SDHCI to a library are _extremely_ high, and the
only sane approach to this is one which allows a progressive
transformation of the driver.

Also, the last thing we want is for drivers to end up duplicating
entire functions from sdhci.c just because they have one thing
different (eg, because they need to do something in the middle of
a set_ios() call which no other SDHCI driver needs.)  Having such
code duplication will just make maintanence even more of a
nightmare.

set_ios() is probably one of the worst functions in sdhci right now,
and there's no obvious way to split it up into several stand-alone
functions which drivers could chain together.

I think what needs to happen here is that Ulf needs to leave such
decisions about what is acceptable or unacceptable to those who are
trying to convert sdhci to a library, otherwise the conversion will
probably never happen... unless Ulf wants to get directly involved
in the conversion effort, producing patches to make it happen.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
