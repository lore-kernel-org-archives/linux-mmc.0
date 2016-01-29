From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/21] Totally remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Fri, 29 Jan 2016 17:28:17 +0000
Message-ID: <20160129172817.GR10826@n2100.arm.linux.org.uk>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com>
 <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
 <56AA03AA.5010706@intel.com>
 <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
 <56AB5635.9030007@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbcA2R2h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 12:28:37 -0500
Content-Disposition: inline
In-Reply-To: <56AB5635.9030007@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>

On Fri, Jan 29, 2016 at 02:08:21PM +0200, Adrian Hunter wrote:
> I might make a tree because I want to try to separate Russell's bug fixes
> from the clean-ups, and then cc stable on the bug fixes.

It would be good if you could ask for that, I'll look at rearranging
(and re-testing) the patches to achieve that.  Had I known that, I
could've done it before posting the latest set of patches.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
