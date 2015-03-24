From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Tue, 24 Mar 2015 10:40:25 +0100
Message-ID: <CAPDyKFpM8S3kvMfF+e=tb6bL3ObTc1_g=O+wnVeGgZYn8iVOSQ@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
	<54FD5BDD.9060004@intel.com>
	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
	<54FEFDB0.5050104@intel.com>
	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
	<5510227F.70605@intel.com>
	<20150324134922.63130696@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33962 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbCXJk0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2015 05:40:26 -0400
Received: by qgep97 with SMTP id p97so57840082qge.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2015 02:40:25 -0700 (PDT)
In-Reply-To: <20150324134922.63130696@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 24 March 2015 at 03:49, NeilBrown <neilb@suse.de> wrote:
> On Mon, 23 Mar 2015 16:26:07 +0200 Adrian Hunter <adrian.hunter@intel.com>
> wrote:
>
>> For Neil's problem I would do something quiet different:
>>
>> 1. The host driver already knows the bus width so can easily "get/put"
>> runtime pm to prevent suspend when the bus width does not permit it.
>>
>> 2. The need to do things when the card is idle comes up a lot (e.g. bkops,
>> sleep notification, cache flush etc etc). In Neil's case he wants to switch
>> to 1-bit mode, but that just seems another of these "idle" operations. So I
>> would investigate the requirements of supporting idle operations in general.
>>
>
> Hi,
>  I agree that what I want to achieve could be characterised as an "idle"
>  operation.
>  I also happen to think that runtime PM is designed to support "idle"
>  operations - it can track when a device goes 'idle' and "do the right thing".
>  It handles all the needed ref counting and races with resume etc.  So I
>  think it should be used to manage these "idle" operations.
>
>  The difficulty is that in the naive approach, we want to do something in the
>  "runtime_suspend" operation which actually uses the device.  So it has to be
>  non-idle in order to go idle.  I agree that this can appear clumsy.
>
>  What we effectively have here is two levels of "idle".  First the "host"
>  goes idle in that no new commands are arriving and no interrupts have
>  happened.  In response to this the host sends a few final commands to the
>  controller and then the controller goes idle.
>
>  This two-stage process should be able to be modelled with the two levels of
>  device: the mmc_host class device and the platform device which controls the
>  hardware.  e.g. mmc1 and omap_hsmmc.1 on my board.
>
>  So this is (roughly) what I would do if I wanted to implement fully general
>  "idle" operations for mmc cards.
>
>  1/ enable runtime_pm on the host device - in mmc_add_host.
>    I think pm_suspend_ignore_children() would be needed so that the host
>    can go to sleep while the card is still active.
>  2/ Use pm_runtime_get / pm_runtime_put_autosuspend in mmc_claim_host
>     and mmc_release_host.
>  3/ Remove the ->enable and  ->disable calls from mmc_{claim,release}_host.
>     I think they only affect omap_hsmmc and it only uses them for runtime
>     PM, which now will happen automatically.
>  4/ In the 'runtime_suspend' method for mmc_host, take a runtime_pm reference
>     on the platform device and schedule a work item to run the "idle"
>     operations
>
>
>  When the "idle" operations complete, the runtime_pm reference will be
>  dropped and then - having no active children or references - the
>  platform device will go to sleep (stop its clocks or whatever).
>  When something then calls mmc_claim_host(), the "idle" operations can be
>  undone, either directly or via the runtime_resume operation.

I don't think this will work.

The problem is that the scheduled work which performs the idle
operations will invoke mmc_claim|release_host() when it's about to
execute the  "idle commands/requests".

>
> This would be a fairly intrusive change.  I'm happy to try to find time to
> write bits of it if there is general agreement, but I cannot test anything
> other than omap_hsmmc, and I don't know any details about any other possible
> "idle" operations so I would need input from someone who does.
>
> NeilBrown

Kind regards
Uffe
