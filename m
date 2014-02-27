From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: SDIO driver return -ENOSYS behaviour change?
Date: Thu, 27 Feb 2014 11:18:16 +0100
Message-ID: <CAPDyKFrZAAVfFcaFx7o3TWMikWx7TvSPW_AuV1VsiuQF656uXg@mail.gmail.com>
References: <530F0118.2010501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:45164 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaB0KSR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2014 05:18:17 -0500
Received: by mail-qg0-f42.google.com with SMTP id q107so5090434qgd.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Feb 2014 02:18:17 -0800 (PST)
In-Reply-To: <530F0118.2010501@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 27 February 2014 10:10, Aaron Lu <aaron.lu@intel.com> wrote:
> Hi Ulf,
>
> I was tracking some SDIO suspend problem and came across this. As Neil
> mentioned here:
> http://lkml.org/lkml/2012/3/25/20
> Quote:
> "
> SDIO (and possible MMC in general) has a protocol where the suspend
>  method can return -ENOSYS and this means "There is no point in suspending,
>  just turn me off".
> "
>
> It seems that the following commit:
>
> commit 810caddba42a54fe5db4e2664757a9a334ba359c
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Mon Jun 10 17:03:37 2013 +0200
>
>     mmc: core: Validate suspend prerequisites for SDIO at SUSPEND_PREPARE
>
> Changed this behaviour?

I realized I changed the behaviour to not cover for sdio func drivers,
that actually implements the pm callbacks - but do return -ENOSYS in
them. That wasn't obvious when looking at the code back then, sorry!

There are no solution to this problem in the mmc core right now, since
we can't remove the card while we have reach the state when the
suspend callback is being invoked.

Instead, the sdio func driver shall not implement the PM callbacks at
all. That behaviour means the mmc core will remove the card, but now
it's done a in an earlier phase of the system suspend when we are
still able to remove it.

Kind regards
Uffe

>
> For example, the libertas SDIO driver's suspend callback still returns
> -ENOSYS and before this commit, that error code will result in the SDIO
> device being removed; after this commit, that would result in an error
> code returned to PM core and a failure in system suspend.
>
> I'm not sure if I understand this correctly as I do not have any SDIO
> card to test. Can you please take a look at this? If this is indeed the
> case, do we need to maintain this behaviour? I need to know this answer
> as that would affect the way I'm going to solve my problem. Thanks.
