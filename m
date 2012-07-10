From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: A new flag SDHCI_USING_RETUNING_TIMER
Date: Mon, 09 Jul 2012 22:55:01 -0400
Message-ID: <87a9z8uxyy.fsf@octavius.laptop.org>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
	<1340957852-28936-3-git-send-email-aaron.lu@amd.com>
	<87vci45p5h.fsf@octavius.laptop.org>
	<20120704052909.GB2607@aarontestpc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56390 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2GJCzI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jul 2012 22:55:08 -0400
In-Reply-To: <20120704052909.GB2607@aarontestpc.amd.com> (Aaron Lu's message
	of "Wed, 4 Jul 2012 13:29:09 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Philip Rakity <prakity@marvell.com>

Hi Aaron,

On Wed, Jul 04 2012, Aaron Lu wrote:
> Add a new flag of SDHCI_USING_RETUNING_TIMER to represent if the host
> is using a retuning timer for the card inserted.
>
> This flag is set when the host does tuning the first time for the card
> and the host's retuning mode is 1. This flag is used afterwards whenever
> needs to decide if the host is currently using a retuning timer.
>
> This flag is cleared when the card is removed in sdhci_reinit.
>
> The set/clear of the flag and the start/stop of the retuning timer is
> associated with the card's init/remove time, so there is no need to
> touch it when the host is to be removed as at that time the card should
> have already been removed.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---
> v3:
> Change the macro name from SDHCI_NEEDS_RETUNING_TIMER to
> SDHCI_USING_RETUNING_TIMER for better description of the flag as suggested
> by Chris Ball.

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
