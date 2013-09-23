From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Mon, 23 Sep 2013 14:14:51 -0700
Message-ID: <CAME+o4kCPRu0EXvKPijC9bdfEZGefO9XyE=xUARpvRstunLTCA@mail.gmail.com>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:47928 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab3IWVOw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 17:14:52 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so1446980bkb.29
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2013 14:14:51 -0700 (PDT)
In-Reply-To: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>

Hi Ulf,
I like the fact that wakeups are now quite simplified. A couple of
comments below:

> By signaling the wakeup event for a time of 5 s for devices configured
> as wakeup capable, we likely will be prevent a sleep long enough to let
> user space consume the event.
Given that there is no pm_relax(), 5 seconds is probably too long.
User space should grab a wakeup_source of its own if it needs to
extend the awake state. I recommend putting just enough to start the
mount process - probably 0.5-1 second - but Android guys would know
better.

> +       /*
> +        * If the device is configured as wakeup, we prevent a new sleep for
> +        * 5 s to give provision for user space to consume the event.
> +        */
> +       if (cd_irq && !(host->caps & MMC_CAP_NEEDS_POLL) &&
> +               device_can_wakeup(mmc_dev(host)))
> +               pm_wakeup_event(mmc_dev(host), 5000);
It seems like device_can_wakeup() is redundant here and I'm not sure
what happens if a device is not wakeup capable. Was the intention to
go into autosleep until something else wakes up the system long enough
to complete the mount? Also is it ok if MMCs that require polling
exhibit wakeup behaviour of their own?

Zoran
