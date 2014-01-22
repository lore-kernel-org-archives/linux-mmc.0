From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 09/10] mmc: mmci: Handle CMD irq before DATA irq
Date: Wed, 22 Jan 2014 15:19:26 +0000
Message-ID: <20140122151926.GD15937@n2100.arm.linux.org.uk>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org> <1390402824-9850-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45283 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755254AbaAVPTh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:19:37 -0500
Content-Disposition: inline
In-Reply-To: <1390402824-9850-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Johan Rudholm <jrudholm@gmail.com>

On Wed, Jan 22, 2014 at 04:00:23PM +0100, Ulf Hansson wrote:
> In case of a read operation both MCI_CMDRESPEND and MCI_DATAEND can be
> set in the status register when entering the interrupt handler. This is
> due to that the card start sending data before the host has
> acknowledged the command response.
> 
> To resolve the issue for this scenario, we must start by handling the
> CMD irq instead of the DATA irq. The reason is beacuse the completion
> of the DATA irq will not respect the current command and then causing
> it to be garbled.

And that's because the driver isn't written to be able to handle a
command being issued concurrently with a data transfer, because it
only has one place to store the current command.

Consider what happens in this case:

- Command issued to start a transfer.
- Command completes, data transfer starts.
- New command comes along to be issued, and is in progress
- Data transfer finishes, we now issue the stop command to halt the
  transfer
- We overwrite the new command with the stop command

All hell breaks loose.  No, this isn't a fix I want to see until the
driver can properly handle concurrent commands.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
