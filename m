Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AD2874E3
	for <linux-mmc@vger.kernel.org>; Wed,  7 Jan 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823572; cv=none; b=M4V0ts6xNhfHrB/BkJuJQeaRPppm4xZeX383LqC3BI+AasHwxkhhv4sRYhRXA8jOiV1dHhH/X/sD0U9uF9hv/BK8ecES/+WqIDFhO4W5B7uWEY4nNMI1Yh4jpuCKVrHOFeG2Oto7JKfjueI3lNvsHsijS/D/x0dKT8WopM/pDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823572; c=relaxed/simple;
	bh=Ot5Y86aZ0R0b6nMPXRYLVaDslq687kJSb6uKMslorWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4USUnBEoTV0s9u8QiPgXtkjgS+QBucYwI+DbI/HM8NnpNiVWmfg2fkgQ+X+UEdJaMq0WAOyvdjQJmJpxl6WCp1yZCzOf2cXnDt60/dtNvJzdW522dnPQ5jk03OCgd7GYRbVANYfAa0QETRWB/jrcyje4Jxq0Y4BDm7L01bK7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLnoUnm3; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLnoUnm3"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11beb0a7bd6so883560c88.1
        for <linux-mmc@vger.kernel.org>; Wed, 07 Jan 2026 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767823567; x=1768428367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12Uy+o3o+oEZTYNVKNIdaVKdMEcJ24KSeXUMiY0DKfc=;
        b=SLnoUnm3BvBa/lAJ0gwL7kCaaEmnmW8ZDkMDO2LwWOySIm0C/aiD3ZN5wsiQzwA5gj
         lCCecV4w8YQ4MNrlAtgAYzU1I+PNp4vyKPah3vKWYGMAgEYpRCjw+TQTR9MfWCKn4inF
         tU0JQ3QhULH+7XXF7Zxk/6RVfoZl+XT0Wiz050gU9fPSSPVqx+q7nkGYIg/XQqx7XlkT
         Z/Vt9GWBxpeulgsAGtM6cHwN33yODN/YHOehTnl2y7krBqj+AQARlzqy8Eytc1ilE8mB
         tOUZ7e5x5AyKM2CoSfdB1/ufnV/8twkHGgU4aoin3uc2MDTIVgi3CLo41DclQBcWW6Gl
         SXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767823567; x=1768428367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12Uy+o3o+oEZTYNVKNIdaVKdMEcJ24KSeXUMiY0DKfc=;
        b=DCIYkqZF8FXG8BmqaqQetrx/pOwox+R0PU2/5jimLSzP/IrIcNmqgfk+vsm/OVKWrE
         fDWHfxyaJ3kJ94zQEeoj/UxVFLxtyp4Ycs38nquTg+pnpmDozT5IWJmft8ziQJ+2MsnJ
         oihezxnXwQ0jBq109EY6e/E+NaNKDUaoA7CacTWnnBKlwCfsTC87M/cp7ioBnKHikpbU
         MeAH7rF7l4P3qRVo1gNbGLIQy5DgldpQxN+mjtJphTHS56s89k47d+SiVawj0/cg1+xg
         Rdai1LvkGCCwrZEVBw4aOX8X8DoXEU49XeRBQj9MQ/nqgLB73RUGeJE4aGWkdR9Liydv
         PxHA==
X-Gm-Message-State: AOJu0Yx0gO0NqXhOLB1p6UM4gImKHh/p3IXeGc/7RvQYcx9mDZqm5f1Z
	m4GEckUUmkOm/TGEun/sREnIJ8oyFCUtq+zBpRQsNkaSioN2R36EDz3wfRetxtZr
X-Gm-Gg: AY/fxX6FFnL4Y4CFoPwh8go49ZTZUmOn8mkSsJYm9WnHnybIWM8IxGZHGlWzGY8cS5m
	6m8CQX7QiV1UFsCZMeqia0zjLrGvVaBZ2aJXmBxRCgrXvTx0nS/6jM8SaXiB5rB6quWEa5RkhCq
	/bwYR4J090IomrB94rs8/J3qZvoxoLFPRoQ+rFpMBiFDvlic19HGKqnmafHZ0ddZK7iOtbOlRwG
	WECIEKoPyV4fS/Gr2ArFk3w03q9P9sPG2eXfUpojqxeHfCa6BDNq1ZnAxbnmJgMZjpFwJZn1YkV
	vn4B2nqkbAT2iTJWEJGnrsWXJ5OwdMABsVOzwhCqohXCh1LE4Rwe6CoCYP+bkSURXMbFbi7Yvzs
	F0zKKKuECdv7uwuisIwIfAjRM4U2Lq5O5LnAMeUaYXSZQkdm4uWFEgKAL9TiNIs0B+14tD2ZQlA
	si3C8pFWcGVtUUZDT/dP9SllrPklnMqmiTAynxBUmkAnaZmdWWACMyu4EF
X-Google-Smtp-Source: AGHT+IFqXckW7tjhZyyjOqNEeZs5aqgauwYdX6MniW4gn48eopdWsDkpF72kZ53X4l5cCle+obNcNg==
X-Received: by 2002:a05:7022:3d82:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-121f1b1eb1amr6331986c88.14.1767823566808;
        Wed, 07 Jan 2026 14:06:06 -0800 (PST)
Received: from [192.168.0.108] (c-73-189-16-174.hsd1.ca.comcast.net. [73.189.16.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f249894fsm8894380c88.15.2026.01.07.14.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 14:06:06 -0800 (PST)
Message-ID: <07c5346a-4f3c-4f91-8b32-66ebbbc08706@gmail.com>
Date: Wed, 7 Jan 2026 14:06:04 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is
 enabled
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
 <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
 <CAL57YxZagMaZF1X1bpx-nB76s=vZMWhUDiVbvB9P3CLiXG-qHQ@mail.gmail.com>
 <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
Content-Language: en-US
From: Tabby Kitten <nyanpasu256@gmail.com>
In-Reply-To: <CAPDyKFpRi8u3MPauT1hnYC1pW7L4kAohAZDsgS2pgQ=4_sjgNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unfortunately this patch appears corrupted, requiring me to manually
recreate it. It seems the process of including it as text in the email
body has corrupted the text, including hard-wrapping the @@ lines into
multiple lines and converting tabs into spaces, so the patch no longer
maps to the Linux source code (eg. drivers/mmc/core/core.c). These
errors were present in Thunderbird, lore.kernel.org, and marc.info
(where downloading the raw emails additionally
equals-encodes/Quoted-Printable? special characters breaking the patch
further).

Additionally Adrian's email seems to be an informal patch rather than a
machine-readable specification.

I'm attemping to manually replicate the changes on Fedora 43's
kernel-6.18.3 checkout
(https://docs.fedoraproject.org/en-US/quick-docs/kernel-build-custom/),
though I'm much less experienced building kernels here than on Arch
Linux (the Arch SSD is currently in another computer). I will be
replying back with results once I can build and test these patches.

On 1/3/26 3:12 AM, Ulf Hansson wrote:
> + Adrian
>
> On Thu, 1 Jan 2026 at 05:58, Tabby Kitten <nyanpasu256@gmail.com> wrote:
>> Hi,
>>
>> It's been a few weeks since you looked into the bug. I think the merge window is over now, have you had the time to look into resolving this issue?
> Yes, sorry for the delay.
>
> See below for an attached patch. Please try it out and report back.
>
> Kind regards
> Uffe
>
>> Tabby
>>
>> On Tue, Dec 9, 2025 at 7:09 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Hi,
>>>
>>> On Wed, 26 Nov 2025 at 10:08, Tabby Kitten <nyanpasu256@gmail.com> wrote:
>>>> On a PC with a Realtek PCI Express SD reader, when you sleep with
>>>> `wakeup_count` active (eg. sleeping from KDE's lock screen), the MMC
>>>> driver wakes up the system and aborts suspend.
>>> Okay, that's clearly a problem that needs to be fixed!
>>>
>>>> I've found a sleep failure bug in the rtsx_pci and mmc_core drivers.
>>>> After userspace writes a number to `/sys/power/wakeup_count` (eg. KDE
>>>> Plasma does it to distinguish user wakes from timers and Wake-on-LAN),
>>>> if it attempts a mem suspend it will be aborted when
>>>> rtsx_pci_runtime_resume() -> mmc_detect_change() emits a
>>>> pm_wakeup_ws_event(). This breaks sleep on some hardware and desktop
>>>> environments.
>>>>
>>>> The detailed description:
>>>> The recently released Plasma 6.5.0 writes to `/sys/power/wakeup_count`
>>>> before sleeping. On my computer this caused the sleep attempt to fail
>>>> with dmesg error "PM: Some devices failed to suspend, or early wake
>>>> event detected". I got this error on both Arch Linux and Fedora, and
>>>> replicated it on Fedora with the mainline kernel COPR. KDE is tracking
>>>> this error at https://bugs.kde.org/show_bug.cgi?id=510992, and have
>>>> disabled writing to wakeup_count on Plasma 6.5.3 to work around this
>>>> issue.
>>>>
>>>> I've written a standalone shell script to reproduce this sleep failure
>>>> (save as badsleep.sh):
>>>>
>>>> #!/bin/bash
>>>> read wakeup_count < /sys/power/wakeup_count
>>>> if [[ $? -ne 0 ]]; then
>>>>     e=$?
>>>>     echo "Failed to open wakeup_count, suspend maybe already in progress"
>>>>     exit $e
>>>> fi
>>>> echo $wakeup_count > /sys/power/wakeup_count
>>>> if [[ $? -ne 0 ]]; then
>>>>     e=$?
>>>>     echo "Failed to write wakeup_count, wakeup_count may have changed in between"
>>>>     exit $e
>>>> fi
>>>> echo mem > /sys/power/state
>>>>
>>>> Running `sudo ./badsleep.sh` reproduces failed sleeps on my computer.
>>>> (sudo is needed to write to `/sys/power/wakeup_count` on Fedora.)
>>>>
>>>> * If I run the script unaltered, the screen turns off and on, and the
>>>>   terminal outputs
>>>>   `./badsleep.sh: line 14: echo: write error: Device or resource busy`
>>>>   indicating the mem sleep failed.
>>>>
>>>> * If I edit the script and comment out `echo $wakeup_count >
>>>>   /sys/power/wakeup_count`, the sleep succeeds, and waking the computer
>>>>   skips the lock screen and resumes where I left off.
>>>>
>>>> * If I run `sudo rmmod rtsx_pci_sdmmc` to disable the faulty module, the
>>>>   sleep succeeds, and waking the computer skips the lock screen and
>>>>   resumes where I left off.
>>>>
>>>> I think this problem happens in general when a driver spawns a wakeup
>>>> event from its suspend callback. On my system, the driver in question
>>>> lies in the MMC subsystem.
>>>>
>>>> ## Code debugging
>>>>
>>>> If I run `echo 1 > /sys/power/pm_debug_messages` to enable verbose
>>>> logging, then attempt a failed sleep, I see output:
>>>>
>>>>     PM: Wakeup pending, aborting suspend
>>>>     PM: active wakeup source: mmc0
>>>>     PM: suspend of devices aborted after 151.615 msecs
>>>>     PM: start suspend of devices aborted after 169.797 msecs
>>>>     PM: Some devices failed to suspend, or early wake event detected
>>>>
>>>> The "Wakeup pending, aborting suspend" message comes from function
>>>> `pm_wakeup_pending()`. This function checks if event checks are enabled,
>>>> and if some counters have changed aborts suspend and calls
>>>> `pm_print_active_wakeup_sources()`, which prints `wakeup_sources`.
>>>> Tracing the code that modifies `wakeup_sources`, I found that
>>>> `pm_wakeup_ws_event()` would activate an event and
>>>> `wakeup_source_register() → wakeup_source_add()` would add a new one.
>>> Thanks for all the details!
>>>
>>>> To find who changed wakeup events, I used my stacksnoop fork at
>>>> https://github.com/nyanpasu64/bcc/blob/local/examples/tracing/stacksnoop
>>>> .py to trace a failed suspend:
>>>>
>>>> nyanpasu64@ryzen ~/code/bcc (local)> sudo ./examples/tracing/stacksnoop.py pm_wakeup_ws_event wakeup_source_register
>>>> TIME(s)            FUNCTION
>>>> 7.254676819:
>>>> 0: ret_from_fork_asm [kernel]
>>>> 1: ret_from_fork [kernel]
>>>> 2: kthread [kernel]
>>>> 3: worker_thread [kernel]
>>>> 4: process_one_work [kernel]
>>>> 5: async_run_entry_fn [kernel]
>>>> 6: async_suspend [kernel]
>>>> 7: device_suspend [kernel]
>>>> 8: dpm_run_callback [kernel]
>>>> 9: mmc_bus_suspend [mmc_core]
>>>> 10: mmc_blk_suspend [mmc_block]
>>>> 11: mmc_queue_suspend [mmc_block]
>>>> 12: __mmc_claim_host [mmc_core]
>>>> 13: __pm_runtime_resume [kernel]
>>>> 14: rpm_resume [kernel]
>>>> 15: rpm_resume [kernel]
>>>> 16: rpm_callback [kernel]
>>>> 17: __rpm_callback [kernel]
>>>> 18: rtsx_pci_runtime_resume [rtsx_pci]
>>>> 19: mmc_detect_change [mmc_core]
>>>> 20: pm_wakeup_ws_event [kernel]
>>>>
>>>> On a previous kernel, lines 9-12 were replaced by a single call to
>>>> `pci_pm_suspend`. I've posted my detailed debugging on the older kernel
>>>> at https://bugs.kde.org/show_bug.cgi?id=510992#c26. There I found that
>>>> `pci_pm_suspend()` wakes PCI(e) devices before sending them into a full
>>>> sleep state, but in the process, `_mmc_detect_change()` will "Prevent
>>>> system sleep for 5s to allow user space to consume the\n corresponding
>>>> uevent"... which interrupts a system sleep in progress.
>>>>
>>>> On my current kernel, the same logic applies, but reading the source I
>>>> can't tell where `__mmc_claim_host()` is actually calling
>>>> `__pm_runtime_resume()`. Nonetheless the problem remains that
>>>> `rpm_resume()` is called during system suspend, `mmc_detect_change()`
>>>> wakes the system when called, and this will abort system sleep when
>>>> `/sys/power/wakeup_count` is active.
>>> __mmc_claim_host() will call pm_runtime_get_sync() to runtime resume
>>> the mmc host device.
>>>
>>> The mmc host device's parent (a pci device) will then be runtime
>>> resumed too. That's the call to rtsx_pci_runtime_resume() we see
>>> above.
>>>
>>> The problem is then that rtsx_pci_runtime_resume() invokes a callback
>>> (->card_event())) back into the mmc host driver
>>> (drivers/mmc/host/rtsx_pci_sdmmc.c), which ends up calling
>>> mmc_detect_change() to try to detect whether a card have been
>>> inserted/removed.
>>>
>>>> ## Next steps
>>>>
>>>> How would this problem be addressed? Off the top of my head, perhaps you
>>>> could not call `__pm_runtime_resume()` on a SD card reader during the
>>>> `device_suspend()` process, not call `pm_wakeup_ws_event()` when the SD
>>>> card status changes, not call  `pm_wakeup_ws_event()` *specifically*
>>>> when system suspend is temporarily waking up a SD card reader, or
>>>> disable pm_wakeup_ws_event() entirely during the suspend process (does
>>>> this defeat the purpose of the function?).
>>> Let me think a bit on what makes the best sense here. I will get back
>>> to you in a couple of days.
>>>
>>>> Are there other drivers which cause the same symptoms? I don't know. I
>>>> asked on the KDE bug tracker for other users to attempt a failed sleep
>>>> with `echo 1 > /sys/power/pm_debug_messages` active, to identify which
>>>> driver broke suspend in their system; so far nobody has replied with
>>>> logs.
>>>>
>>>> Given that this bug is related to `/sys/power/wakeup_count`
>>>> (https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power), I
>>>> was considering CCing Rafael J. Wysocki <rafael@kernel.org> and
>>>> linux-pm@vger.kernel.org, but have decided to only message the MMC
>>>> maintainers for now. If necessary we may have to forward this message
>>>> there to get their attention.
>>>>
>>>> ----
>>>>
>>>> System information:
>>>>
>>>> * I have an Intel NUC8i7BEH mini PC, with CPU 8 × Intel® Core™ i7-8559U
>>>>   CPU @ 2.70GHz.
>>>>
>>>>     * uname -mi prints `x86_64 unknown`.
>>>>
>>>> * `lspci -nn` prints
>>>>   "6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI Express Card Reader [10ec:522a] (rev 01)".
>>>>
>>>> * I am running kernel 6.18.0-0.rc7.357.vanilla.fc43.x86_64 from the Fedora COPRs
>>>>   (https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories).
>>>>
>>>> * dmesg at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-dmesg-2025-11-25-txt
>>>>
>>>> * Fully resolved config at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-config-6-18-0-0-rc7-357-vanilla-fc43-x86_64,
>>>>   source at https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/mainline-wo-mergew/fedora-43-x86_64/09831015-mainline-womergew-releases/kernel-6.18.0-0.rc7.357.vanilla.fc43.src.rpm
>>> Kind regards
>>> Uffe
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Sat, 3 Jan 2026 11:55:44 +0100
> Subject: [PATCH] mmc: core: Avoid runtime PM of host in mmc_queue_suspend()
>
> WIP
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/core.c     | 18 ++++++++++++------
>  drivers/mmc/core/core.h     | 11 ++++++++---
>  drivers/mmc/core/queue.c    |  4 ++--
>  drivers/mmc/core/sdio_irq.c |  2 +-
>  4 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 860378bea557..c3923522833a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -781,6 +781,7 @@ static inline void mmc_ctx_set_claimer(struct
> mmc_host *host,
>   *     @ctx: context that claims the host or NULL in which case the default
>   *     context will be used
>   *     @abort: whether or not the operation should be aborted
> + *     @do_pm: whether to use runtime PM or not
>   *
>   *     Claim a host for a set of operations.  If @abort is non null and
>   *     dereference a non-zero value then this will return prematurely with
> @@ -788,7 +789,7 @@ static inline void mmc_ctx_set_claimer(struct
> mmc_host *host,
>   *     with the lock held otherwise.
>   */
>  int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
> -                    atomic_t *abort)
> +                    atomic_t *abort, bool do_pm)
>  {
>         struct task_struct *task = ctx ? NULL : current;
>         DECLARE_WAITQUEUE(wait, current);
> @@ -821,7 +822,7 @@ int __mmc_claim_host(struct mmc_host *host, struct
> mmc_ctx *ctx,
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
>
> -       if (pm)
> +       if (do_pm && pm)
>                 pm_runtime_get_sync(mmc_dev(host));
>
>         return stop;
> @@ -829,13 +830,14 @@ int __mmc_claim_host(struct mmc_host *host,
> struct mmc_ctx *ctx,
>  EXPORT_SYMBOL(__mmc_claim_host);
>
>  /**
> - *     mmc_release_host - release a host
> + *     __mmc_release_host - release a host
>   *     @host: mmc host to release
> + *     @do_pm: whether to use runtime PM or not
>   *
>   *     Release a MMC host, allowing others to claim the host
>   *     for their operations.
>   */
> -void mmc_release_host(struct mmc_host *host)
> +void __mmc_release_host(struct mmc_host *host, bool do_pm)
>  {
>         unsigned long flags;
>
> @@ -851,6 +853,10 @@ void mmc_release_host(struct mmc_host *host)
>                 host->claimer = NULL;
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 wake_up(&host->wq);
> +
> +               if (!do_pm)
> +                       return;
> +
>                 pm_runtime_mark_last_busy(mmc_dev(host));
>                 if (host->caps & MMC_CAP_SYNC_RUNTIME_PM)
>                         pm_runtime_put_sync_suspend(mmc_dev(host));
> @@ -858,7 +864,7 @@ void mmc_release_host(struct mmc_host *host)
>                         pm_runtime_put_autosuspend(mmc_dev(host));
>         }
>  }
> -EXPORT_SYMBOL(mmc_release_host);
> +EXPORT_SYMBOL(__mmc_release_host);
>
>  /*
>   * This is a helper function, which fetches a runtime pm reference for the
> @@ -867,7 +873,7 @@ EXPORT_SYMBOL(mmc_release_host);
>  void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
>  {
>         pm_runtime_get_sync(&card->dev);
> -       __mmc_claim_host(card->host, ctx, NULL);
> +       __mmc_claim_host(card->host, ctx, NULL, true);
>  }
>  EXPORT_SYMBOL(mmc_get_card);
>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index a028b48be164..5979c90d3b09 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -135,8 +135,8 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card);
>  int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
>
>  int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
> -                    atomic_t *abort);
> -void mmc_release_host(struct mmc_host *host);
> +                    atomic_t *abort, bool do_pm);
> +void __mmc_release_host(struct mmc_host *host, bool do_pm);
>  void mmc_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
>  void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
>
> @@ -150,7 +150,12 @@ int mmc_card_alternative_gpt_sector(struct
> mmc_card *card, sector_t *sector);
>   */
>  static inline void mmc_claim_host(struct mmc_host *host)
>  {
> -       __mmc_claim_host(host, NULL, NULL);
> +       __mmc_claim_host(host, NULL, NULL, true);
> +}
> +
> +static inline void mmc_release_host(struct mmc_host *host)
> +{
> +       __mmc_release_host(host, true);
>  }
>
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..76e83f49ff4e 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -477,8 +477,8 @@ void mmc_queue_suspend(struct mmc_queue *mq)
>          * The host remains claimed while there are outstanding requests, so
>          * simply claiming and releasing here ensures there are none.
>          */
> -       mmc_claim_host(mq->card->host);
> -       mmc_release_host(mq->card->host);
> +       __mmc_claim_host(mq->card->host, NULL, NULL, false);
> +       __mmc_release_host(mq->card->host, false);
>  }
>
>  void mmc_queue_resume(struct mmc_queue *mq)
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 2b24bdf38296..e5d4f8c634c8 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -172,7 +172,7 @@ static int sdio_irq_thread(void *_host)
>                  * that doesn't require that lock to be held.
>                  */
>                 ret = __mmc_claim_host(host, NULL,
> -                                      &host->sdio_irq_thread_abort);
> +                                      &host->sdio_irq_thread_abort, true);
>                 if (ret)
>                         break;
>                 ret = process_sdio_pending_irqs(host);
