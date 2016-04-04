From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: core: Remove redundant ->power_restore() callback"
Date: Mon, 4 Apr 2016 13:59:00 +0200
Message-ID: <CAPDyKFqEw--fu44svhgY+c-DfPC5VhFT86E=s7uuWxyz60TQCw@mail.gmail.com>
References: <1459455931-19538-1-git-send-email-gwendal@chromium.org>
	<CAPDyKFqc_w1Cr+3DWgV=rWxOU4homsJfGoeRHKWfk4bQyEBZ7g@mail.gmail.com>
	<CAMHSBOWrpgyV1Yi84imoc8rCvJN27oNiKOFVksfe-y_J356XcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35393 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcDDL7E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 07:59:04 -0400
Received: by mail-lb0-f169.google.com with SMTP id bc4so156795869lbc.2
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 04:59:02 -0700 (PDT)
In-Reply-To: <CAMHSBOWrpgyV1Yi84imoc8rCvJN27oNiKOFVksfe-y_J356XcA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 1 April 2016 at 18:41, Gwendal Grignou <gwendal@google.com> wrote:
>
>
> On Fri, Apr 1, 2016 at 3:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>
>> I don't want to restore the callbacks.
>>
>> Instead, let's be a bit more clever and try to extend mmc_reset() to
>> cover the MMC case as well. I haven't thought about that in detail,
>> but I think it should work.
>
> I am posting a different path soon.
> Also, given power_restore is gone, mmc_host_power_restore is going to crash
> when called for a MMC or SD device.
> Shall we remove the interface  mmc_power_save_host/mmc_power_restore_host?

It's in my long term plan, yes.

> It is only supported for sdio devices, and used only by the wl1271 to power
> cycle the controller via sysfs. I am wondering if we could use the
> suspend/resume entry point instead.

Regarding SDIO power management support in the mmc core, it's
fragile/broken. I have gotten error reports several times, unfortunate
it's not a trivial task to fix them but needs some structural changes
in the mmc core for SDIO.
I have plans to look into this, but I can't make any promises when that will be.

In your case I would start by extending mmc_reset() to serve MMC cards
as well, that seems like a fairly simple change. Then we can discuss
SDIO separately, if you are still interested. :-)

Kind regards
Uffe
