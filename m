From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Check for timeout before checking mmc device state
Date: Mon, 18 May 2015 11:39:07 +0200
Message-ID: <CAPDyKFq_AoOiAewF+KpNO9ByXgVzskKBnRa5iQfUeu9MHHe-ow@mail.gmail.com>
References: <1431052847-16270-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
	<CAPDyKFp0kdu7d_mXKJMDhu=Njjb46YEZKsk+fuAUqwf8sMe3DA@mail.gmail.com>
	<1431381353.3328.36.camel@mattb-dl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:33257 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbERJjI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 05:39:08 -0400
Received: by qcvo8 with SMTP id o8so86450696qcv.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2015 02:39:07 -0700 (PDT)
In-Reply-To: <1431381353.3328.36.camel@mattb-dl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Bennett <Matt.Bennett@alliedtelesis.co.nz>
Cc: "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "johan.rudholm@axis.com" <johan.rudholm@axis.com>

On 11 May 2015 at 23:55, Matt Bennett <Matt.Bennett@alliedtelesis.co.nz> wrote:
> Hi Uffe,
>
> We are using the Octeon mmc host driver supplied from the Cavium SDK (I
> don't believe it is released to upstream linux). We have both a mmc
> flash memory device and an SD card reader attached to the mmc bus.

I assume that's as two separate instances of an mmc host?

BTW, I don't think these are attached to the mmc bus. It's probably
the platform bus or another subsystem specific bus, right?

>
> In the host driver code their is a mutex which must be obtained before
> the driver can access the mmc bus. This stops the mmc flash and SD card
> reader being written to in parallel (otherwise the signal on the bus
> will be corrupted). It doesn't prevent parallel requests, it's just that
> the second request will block on this mutex until the first request has
> been completed.

I think I will stop here. This becomes too much of a hypothetical issue.
Considering the above statement, I wonder if this couldn't be handled
in the mmc host driver instead.

Anyway, to continue to discuss $subject patch, I first think we should
worry about to get the Octeon driver upstreamed.

>
> In our specific case the following is occurring:
>
> 1. mmc_blk_part_switch() is called to switch partition on the mmc flash
> device. This calls mmc_switch with a timeout_ms value of
> 'card->ext_csd.part_time' which is 10ms in this case.
>
> 2. In __mmc_switch() the command to switch partition is sent to the mmc
> flash.
>
> 3. Between the command being sent to the flash and then the host polling
> the status of the device (no busy detection hardware) a read or write
> operation is begun on the SD card (in our case a Specification Version
> 2.00 card). In my testing I have seen the bus be blocked up to 800ms
> while completing this operation.
>
> 4. The host polls the device for the status but blocks the first time on
> the mutex for ~800ms while the SD card operation completes.
>
> 5. Finally the host gains the mutex and gets the status from the flash
> device.
>
> In my testing at this stage the status was never still
> 'R1_STATE_PRG' (it has been 800ms since the command was sent after all).
> However the timeout check fails because it has been 800ms compared to
> the original timeout_ms value passed in of 10ms. Therefore even though
> the device has left the 'R1_STATE_PRG' state we return early with an
> error that eventually gets printed to the log. This does not affect any
> functionality as the host will simply try to switch the partition again
> and if the bus does not block again then there are no issues.
>
> By putting the timeout check before we read the status of the device
> (and potentially block for longer than the timeout) we don't return an
> early error if the device has indeed left the programming state. We
> might as well continue through the function as after we return the error
> the host is just going to issue the command again.
>

Thanks for elaborating!

> Please excuse me if I have missed something fundamental.
>
> Thanks,
> Matt
>

Kind regards
Uffe
