Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096802D2384
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292978; cv=none; b=NgcxFvz8vKP/uJN0Rm8t+Rtxk96uQAq2m7GuC9jbuh7OFonVUByvEZPwb5SFL5hJrgLrP3H4Ih67H8k1cjSrmiDZO3Yoj6VrswfWgxZMGcOuOMSW/0stf6Sn6+ZyDoZEPLSaHVLsSuEZep9mVoGNlbjxHUiFKycBCVs0Joss4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292978; c=relaxed/simple;
	bh=1qHxKu0EvYbPN3yD5HxFWrzUzKG/VT7vU9nG/tmJgg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtVOsjt+DrwLDQyRpeDMvb4Lbp26/lFdPanHtpZRm0TdQk5Rr3z6jFseiKlHSFRlWY+kVBqE1OsFiXqU9AxvVAwIWPK+pGa6FVwnX4BeINE5JNo+BYs1qreMR3Utz/BDpxKMTPoEMNzs/ug4tTmZSJuIUsGZ8wABM32jJAiuFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WoV8Ly2N; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoV8Ly2N"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78c64370309so3474727b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Dec 2025 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765292976; x=1765897776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVlvWluulxEv0GJ4cexIdlNFHd7uwHf9iig/rmN9aZ0=;
        b=WoV8Ly2Npm21hszD7sgNNpAlyWuu+XtO902f01isQmixTByO8dLAng7YSafHDIBVdQ
         j/IMRuge92wC5xINJqz8OOJZlgBV3koSZlzBcDTyUKfss4e4GFR+nGHunpcwFqbHekit
         ie7rWj+EWrlj877VB0sfVvaKpgtOR7Jdsm+hQ40/2L1NcO7IZT4l1pGxbjdVI/fKRWvz
         2OziCbJyASg3bZRiJN5CqcYih9A488c5KdC2cZ2UXET9MqGhGGpCFUkoR5CezHwB7o+U
         cN98MCgqzi2oAOBBaEmi2sdS5LXK/HRwPvc7r5MRdP8+8s0+2dS0Hdrwpi2JpIsuv5ff
         /yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765292976; x=1765897776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVlvWluulxEv0GJ4cexIdlNFHd7uwHf9iig/rmN9aZ0=;
        b=iu9EOKFcjIuQJnScSWH73yakiKkB9Juu+7oFDN8KeDsy9/JDgPRogCpUe/r1vB9cE0
         Xs00npUWHpK6lLgtsGS+ZnYCpWS48xTuckzbCRAcXdwljWyoKRR+tzd0yaxTcNGdR3kk
         taKtzN3lrb1prYbivrTM8vq9s46Ak1RGNRi44hotlTRb01BQes9XxZkJt2ZdcWnqFJeo
         A87uzVhcetL6Ob8XuLDW5w5ZI2eCI1tEXg0UcBfhp9vkmgtuwwszNK0SBUE9i1GEiyse
         74zHhMyKt053TtHLyJ+wQmtg3B6fZDYGatV+X/hwGtGRbdeDeMOFcIuQnsSMUgOHCssf
         bfKA==
X-Gm-Message-State: AOJu0Yws9PEY3aCivNUP/EqgkeZhAn/fz5qox9pQ+ZDyTY1k885blK2T
	VM9nA8drp1i0nn/lW71XZBE3ZgZ6/9+UQOas0SN9lxAGJtKitDpAE9vz2DjtLu7+htnOgQ/fheL
	BFr7ZJr1ovUkMfvzTbPb13D2ofFleIk54TVj6jKHTOCzn4DB19euXEpg=
X-Gm-Gg: AY/fxX7ZZP4BMgyTzE/XiHEHF/Z2aaFGd5gP/Hm1NIRCAQ98OLnO8HywvUGp5LdJS9R
	V6+Q9JICyw6p75PnMJtQTDTMYSD3BSESHzb0Jj3P+01cu2+3WpAc1J7gQhRGPJa7DpOEVZocn05
	Q/7S0uI9IdcgQHih6vdnlNIVDtD7SVNpEjbYtxkgiKp+6zhyYjtZtkwXnZo818b21P7D/9NxCUK
	pxtmlLbH+WRJXEi6F/JqdxtfxXGweDahAt7oliNetTbQUfXOQUKtnljKFRJlf8dziJDIigc
X-Google-Smtp-Source: AGHT+IGH/7+0FlBskiNov2GF1FDi2N2LW3NOQlX5YRdyAahow+RMrAM18YCrk9YTyIBFeo6FacVK1SixgxvHQ0qnwLA=
X-Received: by 2002:a05:690c:4985:b0:787:f793:b573 with SMTP id
 00721157ae682-78c33b75270mr110455427b3.29.1765292975749; Tue, 09 Dec 2025
 07:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
In-Reply-To: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Dec 2025 16:08:59 +0100
X-Gm-Features: AQt7F2omrK-qtMppcOtTeej_35kNUiF-Gbu3uLG-dCK8kagg3cnTM1C6f33079c
Message-ID: <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is enabled
To: Tabby Kitten <nyanpasu256@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 26 Nov 2025 at 10:08, Tabby Kitten <nyanpasu256@gmail.com> wrote:
>
> On a PC with a Realtek PCI Express SD reader, when you sleep with
> `wakeup_count` active (eg. sleeping from KDE's lock screen), the MMC
> driver wakes up the system and aborts suspend.

Okay, that's clearly a problem that needs to be fixed!

>
> I've found a sleep failure bug in the rtsx_pci and mmc_core drivers.
> After userspace writes a number to `/sys/power/wakeup_count` (eg. KDE
> Plasma does it to distinguish user wakes from timers and Wake-on-LAN),
> if it attempts a mem suspend it will be aborted when
> rtsx_pci_runtime_resume() -> mmc_detect_change() emits a
> pm_wakeup_ws_event(). This breaks sleep on some hardware and desktop
> environments.
>
> The detailed description:
> The recently released Plasma 6.5.0 writes to `/sys/power/wakeup_count`
> before sleeping. On my computer this caused the sleep attempt to fail
> with dmesg error "PM: Some devices failed to suspend, or early wake
> event detected". I got this error on both Arch Linux and Fedora, and
> replicated it on Fedora with the mainline kernel COPR. KDE is tracking
> this error at https://bugs.kde.org/show_bug.cgi?id=3D510992, and have
> disabled writing to wakeup_count on Plasma 6.5.3 to work around this
> issue.
>
> I've written a standalone shell script to reproduce this sleep failure
> (save as badsleep.sh):
>
> #!/bin/bash
> read wakeup_count < /sys/power/wakeup_count
> if [[ $? -ne 0 ]]; then
>     e=3D$?
>     echo "Failed to open wakeup_count, suspend maybe already in progress"
>     exit $e
> fi
> echo $wakeup_count > /sys/power/wakeup_count
> if [[ $? -ne 0 ]]; then
>     e=3D$?
>     echo "Failed to write wakeup_count, wakeup_count may have changed in =
between"
>     exit $e
> fi
> echo mem > /sys/power/state
>
> Running `sudo ./badsleep.sh` reproduces failed sleeps on my computer.
> (sudo is needed to write to `/sys/power/wakeup_count` on Fedora.)
>
> * If I run the script unaltered, the screen turns off and on, and the
>   terminal outputs
>   `./badsleep.sh: line 14: echo: write error: Device or resource busy`
>   indicating the mem sleep failed.
>
> * If I edit the script and comment out `echo $wakeup_count >
>   /sys/power/wakeup_count`, the sleep succeeds, and waking the computer
>   skips the lock screen and resumes where I left off.
>
> * If I run `sudo rmmod rtsx_pci_sdmmc` to disable the faulty module, the
>   sleep succeeds, and waking the computer skips the lock screen and
>   resumes where I left off.
>
> I think this problem happens in general when a driver spawns a wakeup
> event from its suspend callback. On my system, the driver in question
> lies in the MMC subsystem.
>
> ## Code debugging
>
> If I run `echo 1 > /sys/power/pm_debug_messages` to enable verbose
> logging, then attempt a failed sleep, I see output:
>
>     PM: Wakeup pending, aborting suspend
>     PM: active wakeup source: mmc0
>     PM: suspend of devices aborted after 151.615 msecs
>     PM: start suspend of devices aborted after 169.797 msecs
>     PM: Some devices failed to suspend, or early wake event detected
>
> The "Wakeup pending, aborting suspend" message comes from function
> `pm_wakeup_pending()`. This function checks if event checks are enabled,
> and if some counters have changed aborts suspend and calls
> `pm_print_active_wakeup_sources()`, which prints `wakeup_sources`.
> Tracing the code that modifies `wakeup_sources`, I found that
> `pm_wakeup_ws_event()` would activate an event and
> `wakeup_source_register() =E2=86=92 wakeup_source_add()` would add a new =
one.

Thanks for all the details!

>
> To find who changed wakeup events, I used my stacksnoop fork at
> https://github.com/nyanpasu64/bcc/blob/local/examples/tracing/stacksnoop
> .py to trace a failed suspend:
>
> nyanpasu64@ryzen ~/code/bcc (local)> sudo ./examples/tracing/stacksnoop.p=
y pm_wakeup_ws_event wakeup_source_register
> TIME(s)            FUNCTION
> 7.254676819:
> 0: ret_from_fork_asm [kernel]
> 1: ret_from_fork [kernel]
> 2: kthread [kernel]
> 3: worker_thread [kernel]
> 4: process_one_work [kernel]
> 5: async_run_entry_fn [kernel]
> 6: async_suspend [kernel]
> 7: device_suspend [kernel]
> 8: dpm_run_callback [kernel]
> 9: mmc_bus_suspend [mmc_core]
> 10: mmc_blk_suspend [mmc_block]
> 11: mmc_queue_suspend [mmc_block]
> 12: __mmc_claim_host [mmc_core]
> 13: __pm_runtime_resume [kernel]
> 14: rpm_resume [kernel]
> 15: rpm_resume [kernel]
> 16: rpm_callback [kernel]
> 17: __rpm_callback [kernel]
> 18: rtsx_pci_runtime_resume [rtsx_pci]
> 19: mmc_detect_change [mmc_core]
> 20: pm_wakeup_ws_event [kernel]
>
> On a previous kernel, lines 9-12 were replaced by a single call to
> `pci_pm_suspend`. I've posted my detailed debugging on the older kernel
> at https://bugs.kde.org/show_bug.cgi?id=3D510992#c26. There I found that
> `pci_pm_suspend()` wakes PCI(e) devices before sending them into a full
> sleep state, but in the process, `_mmc_detect_change()` will "Prevent
> system sleep for 5s to allow user space to consume the\n corresponding
> uevent"... which interrupts a system sleep in progress.
>
> On my current kernel, the same logic applies, but reading the source I
> can't tell where `__mmc_claim_host()` is actually calling
> `__pm_runtime_resume()`. Nonetheless the problem remains that
> `rpm_resume()` is called during system suspend, `mmc_detect_change()`
> wakes the system when called, and this will abort system sleep when
> `/sys/power/wakeup_count` is active.

__mmc_claim_host() will call pm_runtime_get_sync() to runtime resume
the mmc host device.

The mmc host device's parent (a pci device) will then be runtime
resumed too. That's the call to rtsx_pci_runtime_resume() we see
above.

The problem is then that rtsx_pci_runtime_resume() invokes a callback
(->card_event())) back into the mmc host driver
(drivers/mmc/host/rtsx_pci_sdmmc.c), which ends up calling
mmc_detect_change() to try to detect whether a card have been
inserted/removed.

>
> ## Next steps
>
> How would this problem be addressed? Off the top of my head, perhaps you
> could not call `__pm_runtime_resume()` on a SD card reader during the
> `device_suspend()` process, not call `pm_wakeup_ws_event()` when the SD
> card status changes, not call  `pm_wakeup_ws_event()` *specifically*
> when system suspend is temporarily waking up a SD card reader, or
> disable pm_wakeup_ws_event() entirely during the suspend process (does
> this defeat the purpose of the function?).

Let me think a bit on what makes the best sense here. I will get back
to you in a couple of days.

>
> Are there other drivers which cause the same symptoms? I don't know. I
> asked on the KDE bug tracker for other users to attempt a failed sleep
> with `echo 1 > /sys/power/pm_debug_messages` active, to identify which
> driver broke suspend in their system; so far nobody has replied with
> logs.
>
> Given that this bug is related to `/sys/power/wakeup_count`
> (https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power), I
> was considering CCing Rafael J. Wysocki <rafael@kernel.org> and
> linux-pm@vger.kernel.org, but have decided to only message the MMC
> maintainers for now. If necessary we may have to forward this message
> there to get their attention.
>
> ----
>
> System information:
>
> * I have an Intel NUC8i7BEH mini PC, with CPU 8 =C3=97 Intel=C2=AE Core=
=E2=84=A2 i7-8559U
>   CPU @ 2.70GHz.
>
>     * uname -mi prints `x86_64 unknown`.
>
> * `lspci -nn` prints
>   "6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS52=
2A PCI Express Card Reader [10ec:522a] (rev 01)".
>
> * I am running kernel 6.18.0-0.rc7.357.vanilla.fc43.x86_64 from the Fedor=
a COPRs
>   (https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories).
>
> * dmesg at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf07=
4e44a#file-dmesg-2025-11-25-txt
>
> * Fully resolved config at https://gist.github.com/nyanpasu64/ab5d3d1565a=
afe6c1c08cbcaf074e44a#file-config-6-18-0-0-rc7-357-vanilla-fc43-x86_64,
>   source at https://download.copr.fedorainfracloud.org/results/@kernel-va=
nilla/mainline-wo-mergew/fedora-43-x86_64/09831015-mainline-womergew-releas=
es/kernel-6.18.0-0.rc7.357.vanilla.fc43.src.rpm

Kind regards
Uffe
