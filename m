From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sat, 4 Jun 2011 11:18:10 +0100
Message-ID: <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44031 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1FDKSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jun 2011 06:18:11 -0400
Received: by pzk9 with SMTP id 9so1154317pzk.19
        for <linux-mmc@vger.kernel.org>; Sat, 04 Jun 2011 03:18:11 -0700 (PDT)
In-Reply-To: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>

On 30 May 2011 15:26, Daniel Drake <dsd@laptop.org> wrote:
> Hi,
>
> The libertas_sdio driver has a suspend routine which returns -ENOSYS
> when the card should effectively be removed and powered during
> suspend, to be re-probed during resume.
>
> This is broken in linus master.

Actually, it only breaks when I enable runtime PM via the patch we are
discussing in the other thread.

Here is the call trace:

mmc_suspend_host
mmc_sdio_remove
sdio_remove_func
device_del
sdio_bus_remove

In sdio_bus_remove, we hit:

	/* Make sure card is powered before invoking ->remove() */
	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
		ret = pm_runtime_get_sync(dev);
		if (ret < 0)
			goto out;
	}

pm_runtime_get_sync returns -11, therefore we skip the following
drv->remove call, causing this confusion. -11 is EAGAIN

Digging further, in the pm_runtime_get_sync() call we reach
rpm_resume() in drivers/base/power where we hit:

	else if (dev->power.disable_depth > 0)
		retval = -EAGAIN;

Not sure what this means. Any thoughts?

Thanks,
Daniel
