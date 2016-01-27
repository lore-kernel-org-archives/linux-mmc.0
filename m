From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Wed, 27 Jan 2016 14:59:14 +0200
Message-ID: <56A8BF22.8010509@intel.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8533 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbcA0NC7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jan 2016 08:02:59 -0500
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

On 27/01/16 07:05, Shawn Lin wrote:
> Ulf wants to make sdhci into a library, but it's a huge task
> since any improvemts may touch too much platforms. But at least
> we should make some effort to push things torwards to this target.
> 
> This patchset remove SDHCI_QUIRK_BROKEN_CARD_DETECTION from sdhci
> to gradually reduce quirk of sdhci.
> 
> Firstly, SDHCI_QUIRK_BROKEN_CARD_DETECTION aims at claiming the slot is
> a "broken-cd" one, but "broken-cd" is not a quirk from my view.
> In addition, mmc core stack had already obtain "broken-cd" from dts via
> mmc_of_parse and pass MMC_CAP_NEEDS_POLL to mmc->caps. So we can reuse it
> instead of SDHCI_QUIRK_BROKEN_CARD_DETECTION.

That assumes there is no driver that wants to disable the card detect
interrupts and disable the use of the Present State register, but still use
a Card Detect GPIO and therefore not have MMC_CAP_NEEDS_POLL.

A way forward should provide for drivers do to things like that.

One way is to make selected existing functions into library functions and
provide callbacks for them.  In this case do with sdhci_set_card_detection()
what Russell King did with sdhci_reset().  However Ulf is against new callbacks.

I would much prefer the structure for a SDHCI library be put in place, or at
least agreed to, before individual quirks are tackled.

In my view Ulf needs to explain how the SDHCI library is going to work,
particularly in the absence of new callbacks.

