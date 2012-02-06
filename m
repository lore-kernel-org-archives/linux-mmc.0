From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: always reset all during resume
Date: Mon, 06 Feb 2012 15:14:47 +0200
Message-ID: <4F2FD247.70004@intel.com>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com> <1327926439-23603-3-git-send-email-adrian.hunter@intel.com> <m2d39u84sm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45373 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837Ab2BFNPt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Feb 2012 08:15:49 -0500
In-Reply-To: <m2d39u84sm.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>, Nicolas Pitre <nico@fluxnic.net>

On 05/02/12 03:09, Chris Ball wrote:
> This patch doesn't look correct to me -- yes, the hardware might have
> lost power during suspend, but that's what the common-case of:
> 
>         sdhci_init(host, soft=0);
> 
> is for.  soft=1 is supposed to indicate that the power stayed up via
> MMC_PM_KEEP_POWER, but you're changing that by setting ->pwr = 0 in the
> soft=1 path.  If I'm using soft=1 because my controller has a wifi SDIO
> card on it, I don't want you to reprogram the power to it on resume.
> Does that make sense?

Yes, I will send a different patch (to handle the "card is on, but the host
controller is off" case)
