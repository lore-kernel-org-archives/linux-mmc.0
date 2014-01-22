From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/10] mmc: mmci: Handle CMD irq before DATA irq
Date: Wed, 22 Jan 2014 16:43:40 +0100
Message-ID: <CAPDyKFqmCPjjUGg2171oOqxMP8eLCuWcS_E-xpVTVa=gMU61gA@mail.gmail.com>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
	<1390402824-9850-10-git-send-email-ulf.hansson@linaro.org>
	<20140122151926.GD15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:56710 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbaAVPnl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:43:41 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so680994qcy.25
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:43:40 -0800 (PST)
In-Reply-To: <20140122151926.GD15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Johan Rudholm <jrudholm@gmail.com>

On 22 January 2014 16:19, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 22, 2014 at 04:00:23PM +0100, Ulf Hansson wrote:
>> In case of a read operation both MCI_CMDRESPEND and MCI_DATAEND can be
>> set in the status register when entering the interrupt handler. This is
>> due to that the card start sending data before the host has
>> acknowledged the command response.
>>
>> To resolve the issue for this scenario, we must start by handling the
>> CMD irq instead of the DATA irq. The reason is beacuse the completion
>> of the DATA irq will not respect the current command and then causing
>> it to be garbled.
>
> And that's because the driver isn't written to be able to handle a
> command being issued concurrently with a data transfer, because it
> only has one place to store the current command.

For a READ request, we are starting the data state machine by invoking
mmci_start_data before we send the READ command. That is not like we
handle concurrent requests, it is still only one request we are
operating on.

Now, suppose you have a high interface speed and a well performing
card, that will mean you can actually get the DATAEND irq at the same
time you get the CMD response. It is only because of this scenario we
need to reverse the order of handling the IRQs. Sorry if the commit
message was to vague.

>
> Consider what happens in this case:
>
> - Command issued to start a transfer.
> - Command completes, data transfer starts.
> - New command comes along to be issued, and is in progress
> - Data transfer finishes, we now issue the stop command to halt the
>   transfer
> - We overwrite the new command with the stop command
>
> All hell breaks loose.  No, this isn't a fix I want to see until the
> driver can properly handle concurrent commands.

This is not the scenario I want or need to solve. The host must only
handle one request at time. When we are done, we do call
mmc_request_done, which tells the mmc core it's fine to start a new
one. So the above sequence is not even possible.

Kind regards
Ulf Hansson

>
> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
