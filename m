From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: tmio: Use modern PM ops
Date: Mon, 11 Nov 2013 10:24:49 +0100
Message-ID: <CAPDyKFp73ew81u48oXV2wHG8UB48da2YK87+JDF=kzb0sSnQdg@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1311081309140.22449@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:55612 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3KKJYu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2013 04:24:50 -0500
Received: by mail-qc0-f172.google.com with SMTP id c9so3931796qcz.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2013 01:24:49 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1311081309140.22449@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On 8 November 2013 13:16, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Ulf,
>
> A general question concerning this your effort just occurred to me: what
> if runtime PM is disabled on a system? Will the clock(s) then at all be
> enabled? Doesn't one need for such a case either a fall-back to statically
> enable clock in .probe() and disable in .remove() or should such drivers
> select PM_RUNTIME?
>

That is a quite interesting question, I would suggest you post this
one on linux-pm. :-)

Normally I would expect it to be convenient to enable clocks in .probe
and then use pm_runtime_set_active. So that will then work for both
scenarios.

A bit more tricky is the .remove. To make it work in both scenarios
you can do pm_runtime_get_sync, a then explicitly disable the clocks.

If the driver would select PM_RUNTIME, the code could likely be
simplified. In best cases the .remove callback should not even need to
exist since PM core will do it's best to put the device into
"inactive" state.

Kind regards
Uffe

> Thanks
> Guennadi
>
> On Tue, 5 Nov 2013, Ulf Hansson wrote:
>
>> This patchset converts tmio and sh_mobile_sdhi to use the modern PM ops.
>>
>> Ulf Hansson (3):
>>   mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
>>   mmc: tmio_mmc: Convert from legacy to modern PM ops
>>   mmc: tmio: Adapt to proper PM configs for exported functions
>>
>>  drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
>>  drivers/mmc/host/tmio_mmc.c       |   32 ++++++++++++++++++--------------
>>  drivers/mmc/host/tmio_mmc.h       |    7 +++----
>>  drivers/mmc/host/tmio_mmc_pio.c   |    7 ++++---
>>  4 files changed, 29 insertions(+), 25 deletions(-)
>>
>> --
>> 1.7.9.5
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
