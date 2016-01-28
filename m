From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/21] Totally remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Thu, 28 Jan 2016 16:27:37 +0000
Message-ID: <20160128162736.GK10826@n2100.arm.linux.org.uk>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com>
 <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
 <56AA03AA.5010706@intel.com>
 <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42315 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbcA1Q2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 11:28:04 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>

On Thu, Jan 28, 2016 at 04:16:27PM +0100, Ulf Hansson wrote:
> That's really great news. Thank you very much Adrian!
> 
> Perhaps Russell is willing to help co-maintain it?

Unfortunately, I'm not really in a position to co-maintain it, as
I'd be doing it in my spare time, and my spare time is already
spread thinly over much of the kernel (I've crypto, phy/sfp,
etnaviv drm, xf86-video-armada, etnaviv mesa, HDMI CEC, and DSA
stuff all wanting attention, and I'm having to tell people "sorry,
I won't be able to do anything on XYZ for a while".)  I'm quite
sure the Marvell Dove maintainers are going to want some more
patches from me for the next merge window soon...

Of course, that could change if Linaro wishes to fund work in this
area, because it would then take priority... ;)

I'm more than willing to put whatever time I can into helping with
SDHCI, which is exactly why you get the occasional large series of
patches from me - the whole reason behind these patch series are to
improve SDHCI in an incremental fashion.  However, I'd be lying if
I didn't say that there's an alterior motive behind it, which is to
get SDHCI on iMX6 stable.  What I realise is that the current
situation is quite dire, and SDHCI needs improving if we're not
going to decend into a totally unmaintainable mess.

Just before Christmas, I was working on a way to change the way we
kick off commands in SDHCI in order to clean up those paths - the
patches which follow on from the 25 I've already posted, and are:

mmc: sdhci: move interrupt enable settings to task
mmc: sdhci: move command and argument to sdhci_cmd_task
mmc: sdhci: move block size and block count into sdhci task structure
mmc: sdhci: compute transfer mode separately from programming it
mmc: sdhci: replace 'set_timeout' method with 'calculate_timeout'
mmc: sdhci: validate command response type
mmc: sdhci: clean up
mmc: sdhci: rearrange sdhci_set_transfer_mode() a little

It's a work-in-progress, which is why I haven't posted these yet.
The outline of it is that we (currently) end up with:

+struct sdhci_cmd_task {
+       bool has_argument2;
+       bool has_data;
+       u32 ier;
+       u32 argument2;
+       u16 block_size;
+       u16 block_count;
+       u32 argument;
+       u16 transfer_mode;
+       u16 command;
+};
+

which allows separation of the preparation step for a MMC command from
touching the hardware - this means that quirkly SDHCI drivers can do
this instead of litering the core code with quirk tests:

	struct sdhci_cmd_task task;

	sdhci_prepare_command(sdhci, &task, mmc_command);

	/* do whatever quirks */

	sdhci_execute_command(sdhci, &task);

This structure means that (eg) some of the quirks such as
SDHCI_QUIRK2_SUPPORT_SINGLE,
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD (which I'm sure is
actually a bug in the SDHCI driver) and eventually
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL can all be eliminated from the core
code and moved out into their respective drivers - because we have
the core code preparing "the standard" set of register settings for
the command to be sent, and then the driver gets the opportunity to
tweak them according to the bugs it has.

... and even after all these changes, I still haven't solved the
problems which bugs me on iMX6, which were my motivation for coming
back to putting some more effort into SDHCI! :p

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
