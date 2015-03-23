From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Mon, 23 Mar 2015 16:02:17 +0100
Message-ID: <CAPDyKFqJ3ahAPXec6LRmMtzucS3N=b5wOYGQcd0ELHZByeudJA@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
	<54FD5BDD.9060004@intel.com>
	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
	<54FEFDB0.5050104@intel.com>
	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
	<5510227F.70605@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36819 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbCWPCb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 11:02:31 -0400
Received: by qgez102 with SMTP id z102so59929711qge.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 08:02:30 -0700 (PDT)
In-Reply-To: <5510227F.70605@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Neil Brown <neilb@suse.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

[...]

>
> I have no locking issues, so I am not sure what you mean here.

Okay, I should have stated race conditions.

>
>>
>>>
>>>> I think we need an generic approach to deal with the runtime PM
>>>> synchronization issue described above. More precisely in those
>>>> scenarios when mmc hosts needs to notify the mmc core to take some
>>>> specific actions, from a mmc host's runtime PM callback.
>>>
>>> For the re-tune case I did not want to assume what the host driver
>>> needed to do, so I added ->hold_tuning() and ->release_tuning()
>>> host operations.
>>
>> I have thought a bit more on how I would like this to be implemented.
>> It's a bit closer to what Neil's suggests in his approach [1].
>
> I am not sure it is valuable to mix up the two issues.
>
> For Neil's problem I would do something quiet different:
>
> 1. The host driver already knows the bus width so can easily "get/put"
> runtime pm to prevent suspend when the bus width does not permit it.

To me the problem is the other way around.

The host driver don't want prevent runtime PM suspend. Instead it want
to notify the core that it's ready to be runtime PM suspended.

Due to restrictions by the SDIO spec, the mmc core first need to
switch to 1-bit data, before the host can do clock gating in runtime
PM suspend.

>
> 2. The need to do things when the card is idle comes up a lot (e.g. bkops,
> sleep notification, cache flush etc etc). In Neil's case he wants to switch
> to 1-bit mode, but that just seems another of these "idle" operations. So I
> would investigate the requirements of supporting idle operations in general.

That won't work for the SDIO case, since runtime PM is being deployed
differently for SDIO than for MMC/SD.

In the SDIO case it's the SDIO func drivers that handles the get/put.
For the MMC/SD case it's handled by the block device layer.

Still, yes I agree that it would be of great interest to look into
"idle" operations of eMMC/SD, especially for those other things you
mention, but I don't see it as the solution for Neil's SDIO issue.

Kind regards
Uffe
