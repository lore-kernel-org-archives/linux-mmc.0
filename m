Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83453A41
	for <linux-mmc@vger.kernel.org>; Thu,  1 Jan 2026 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244320; cv=none; b=ahlZ84OikIwOLzZFW6p1b+hhF4bmDLrI9BQ3sUkh3HFs+kDdu0VnnxLo9oSiZkbqpoujbgi+EfuovYIsCIwtKPeON9Z3gzYV1vlXu3X77UZKnEd3s+JUIBlswiJ5TNhiliJa8Pb76m+jBVJMAfwMd33QvoRtElukZ5z/oAH1wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244320; c=relaxed/simple;
	bh=h/royyGZIoVL78Ipke9ggyrPvwgz5qP7BWwl6uoeEAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R19UzBH9TbTenghQMlKmT389eXc6p43u1rCdyt7NI3FuYBOKh8M7Y2ilsek+7xhmND5aTOKJzjgk/Zyf8w6yP2pknhds+Ib6qvkYnmwKa86HCSuHLX5TMyTsuw402T1oZMgN4WfKEx7dxhg01hoBIEAy6+ovsyN6yE9NvSnJ5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaUP1vND; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUP1vND"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso6126015241.2
        for <linux-mmc@vger.kernel.org>; Wed, 31 Dec 2025 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244317; x=1767849117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq6cx9sMpRva27qIsnRbjolAfnjlhU8Qgkc4DzWVXxI=;
        b=SaUP1vNDETtxEVUsx/dtZ58fjO6SpvnjGpoYxcgLvHSPaxLrpOibXYqyjyK+3CwJGq
         s+5iO2d//1t5C4rcHvtavBCihU/tl3qLKMPK03kv8OtxLlIMAE6T4wvKy5F+UQ8X9ccf
         Hvm/WT/MvZHah4O5h/wBilJjZpsBLeIAiYBAFhV9XCm1gj30Rwzn6EWOsyAt0ocy0Xev
         RmtBQh3zS/mo/uo5COn6Pc/FZ1qYtqT4kAwrHbXtQaoPY1OlHIHowpWmhVgl4TI0esGe
         Dzz3nlyXGJf4HIL5cHlFeSLpuqgRexNb6dl/MTcDPo8qWiVikLFKQJSqoyFUXYWWcDgN
         c/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244317; x=1767849117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zq6cx9sMpRva27qIsnRbjolAfnjlhU8Qgkc4DzWVXxI=;
        b=WhLnHIYRBw7yDFD0Ys19vWlL3SMUOptw0nFsx1/TOvkTrs1WqKUQ4PnTPx2+YcbNw2
         pSs/e1IK5iYOUfUkPWlLdKP44dT9D1ZLsBwbmcwzUp0vdQEXcRMX3FnhtF72yI69UPc2
         8272fr/PVHPXvhKEF+88gwrF1uQRIs6LXwuRjMlqypQW5OhJXnpvxRqlRtCj9rAwo0Yh
         PQ+GFhTSozaOnOs/IanwEN8QtfL3G7Ypz9Ry/4cbWtW0+Ao/YJH3R+AbcRwHpXrb50w6
         dyZWA7UtUJf0HiXDqQYp3tmmIEi6qTffoYFEf0277C3WHpEv+RG3oY2XscuoXdpGwcDg
         Tz4Q==
X-Gm-Message-State: AOJu0Ywhbeo1AFKn4rmec7IrRlwVn77tmwJyADpX+y4hE6eSXLHttbYp
	XViO5iyckCKYz1GgRWCyDUoaZahPmaQTQYV6OaVdQk2+BAeXelG2QjWCCE36V7Xc3xWI8xu90hv
	otK5qn+6sUy5jLouTB+dQN4tdGctaMz6CqQnqpLw=
X-Gm-Gg: AY/fxX4z/lhJmKmXrW88F4t+l1AN3Kdc/rrBFrf7QhnYcq1RlwyoTmnhIHqV89ZKsgu
	9/lIsQVOS4DBAlRCc9T6tjY0O+rude0V6auVdIByN4gjqcm9LU7JqQK4BMCKbKxGfQEepsZP/aX
	BZxfeqEWuv3QAw2o0cP96cLx08RyQe/fCMbUyEPXrHbUAICLrZTQcj1oDqbg05txxP2RQ5gMxCH
	j0+5C6UyQZHFsh7r2nE0Z1P6Tl09i6D8PospQUKfZkN5XBL+zDhaPcg0qSWYwAI8BJmIQs=
X-Google-Smtp-Source: AGHT+IFFOGlqfl4A8P4rdfQbioZ21yDaBKR+237T39958yhW1EGzXRObG4BgUxjqDgBg07czjCGvP5bmWWAXokvkg04=
X-Received: by 2002:a05:6102:952:b0:5db:25b5:9b5e with SMTP id
 ada2fe7eead31-5eb1a7d5662mr12148435137.22.1767244317147; Wed, 31 Dec 2025
 21:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com> <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
In-Reply-To: <CAPDyKFq55Vqfd7cMdmQZBzvS1Xr-Z4QaTzEeuWWn3EX4HBbP3A@mail.gmail.com>
From: Tabby Kitten <nyanpasu256@gmail.com>
Date: Wed, 31 Dec 2025 21:11:46 -0800
X-Gm-Features: AQt7F2ofcvUjD8SlJnhzdp02YjN4VLrFdHxOvLQBMamAvg_uw-Z5sdbcz4cggTM
Message-ID: <CAL57YxYec8x+YhHXD4G_b+4e=BL3LksT7KuyQEeL=og_4ZzCDA@mail.gmail.com>
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is enabled
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It's been a few weeks since you looked into the bug. I think the merge
window is over now, have you had the time to look into resolving this
issue?

Tabby


On Tue, Dec 9, 2025 at 7:09=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Hi,
>
> On Wed, 26 Nov 2025 at 10:08, Tabby Kitten <nyanpasu256@gmail.com> wrote:
> >
> > On a PC with a Realtek PCI Express SD reader, when you sleep with
> > `wakeup_count` active (eg. sleeping from KDE's lock screen), the MMC
> > driver wakes up the system and aborts suspend.
>
> Okay, that's clearly a problem that needs to be fixed!
>
> >
> > I've found a sleep failure bug in the rtsx_pci and mmc_core drivers.
> > After userspace writes a number to `/sys/power/wakeup_count` (eg. KDE
> > Plasma does it to distinguish user wakes from timers and Wake-on-LAN),
> > if it attempts a mem suspend it will be aborted when
> > rtsx_pci_runtime_resume() -> mmc_detect_change() emits a
> > pm_wakeup_ws_event(). This breaks sleep on some hardware and desktop
> > environments.
> >
> > The detailed description:
> > The recently released Plasma 6.5.0 writes to `/sys/power/wakeup_count`
> > before sleeping. On my computer this caused the sleep attempt to fail
> > with dmesg error "PM: Some devices failed to suspend, or early wake
> > event detected". I got this error on both Arch Linux and Fedora, and
> > replicated it on Fedora with the mainline kernel COPR. KDE is tracking
> > this error at https://bugs.kde.org/show_bug.cgi?id=3D510992, and have
> > disabled writing to wakeup_count on Plasma 6.5.3 to work around this
> > issue.
> >
> > I've written a standalone shell script to reproduce this sleep failure
> > (save as badsleep.sh):
> >
> > #!/bin/bash
> > read wakeup_count < /sys/power/wakeup_count
> > if [[ $? -ne 0 ]]; then
> >     e=3D$?
> >     echo "Failed to open wakeup_count, suspend maybe already in progres=
s"
> >     exit $e
> > fi
> > echo $wakeup_count > /sys/power/wakeup_count
> > if [[ $? -ne 0 ]]; then
> >     e=3D$?
> >     echo "Failed to write wakeup_count, wakeup_count may have changed i=
n between"
> >     exit $e
> > fi
> > echo mem > /sys/power/state
> >
> > Running `sudo ./badsleep.sh` reproduces failed sleeps on my computer.
> > (sudo is needed to write to `/sys/power/wakeup_count` on Fedora.)
> >
> > * If I run the script unaltered, the screen turns off and on, and the
> >   terminal outputs
> >   `./badsleep.sh: line 14: echo: write error: Device or resource busy`
> >   indicating the mem sleep failed.
> >
> > * If I edit the script and comment out `echo $wakeup_count >
> >   /sys/power/wakeup_count`, the sleep succeeds, and waking the computer
> >   skips the lock screen and resumes where I left off.
> >
> > * If I run `sudo rmmod rtsx_pci_sdmmc` to disable the faulty module, th=
e
> >   sleep succeeds, and waking the computer skips the lock screen and
> >   resumes where I left off.
> >
> > I think this problem happens in general when a driver spawns a wakeup
> > event from its suspend callback. On my system, the driver in question
> > lies in the MMC subsystem.
> >
> > ## Code debugging
> >
> > If I run `echo 1 > /sys/power/pm_debug_messages` to enable verbose
> > logging, then attempt a failed sleep, I see output:
> >
> >     PM: Wakeup pending, aborting suspend
> >     PM: active wakeup source: mmc0
> >     PM: suspend of devices aborted after 151.615 msecs
> >     PM: start suspend of devices aborted after 169.797 msecs
> >     PM: Some devices failed to suspend, or early wake event detected
> >
> > The "Wakeup pending, aborting suspend" message comes from function
> > `pm_wakeup_pending()`. This function checks if event checks are enabled=
,
> > and if some counters have changed aborts suspend and calls
> > `pm_print_active_wakeup_sources()`, which prints `wakeup_sources`.
> > Tracing the code that modifies `wakeup_sources`, I found that
> > `pm_wakeup_ws_event()` would activate an event and
> > `wakeup_source_register() =E2=86=92 wakeup_source_add()` would add a ne=
w one.
>
> Thanks for all the details!
>
> >
> > To find who changed wakeup events, I used my stacksnoop fork at
> > https://github.com/nyanpasu64/bcc/blob/local/examples/tracing/stacksnoo=
p
> > .py to trace a failed suspend:
> >
> > nyanpasu64@ryzen ~/code/bcc (local)> sudo ./examples/tracing/stacksnoop=
.py pm_wakeup_ws_event wakeup_source_register
> > TIME(s)            FUNCTION
> > 7.254676819:
> > 0: ret_from_fork_asm [kernel]
> > 1: ret_from_fork [kernel]
> > 2: kthread [kernel]
> > 3: worker_thread [kernel]
> > 4: process_one_work [kernel]
> > 5: async_run_entry_fn [kernel]
> > 6: async_suspend [kernel]
> > 7: device_suspend [kernel]
> > 8: dpm_run_callback [kernel]
> > 9: mmc_bus_suspend [mmc_core]
> > 10: mmc_blk_suspend [mmc_block]
> > 11: mmc_queue_suspend [mmc_block]
> > 12: __mmc_claim_host [mmc_core]
> > 13: __pm_runtime_resume [kernel]
> > 14: rpm_resume [kernel]
> > 15: rpm_resume [kernel]
> > 16: rpm_callback [kernel]
> > 17: __rpm_callback [kernel]
> > 18: rtsx_pci_runtime_resume [rtsx_pci]
> > 19: mmc_detect_change [mmc_core]
> > 20: pm_wakeup_ws_event [kernel]
> >
> > On a previous kernel, lines 9-12 were replaced by a single call to
> > `pci_pm_suspend`. I've posted my detailed debugging on the older kernel
> > at https://bugs.kde.org/show_bug.cgi?id=3D510992#c26. There I found tha=
t
> > `pci_pm_suspend()` wakes PCI(e) devices before sending them into a full
> > sleep state, but in the process, `_mmc_detect_change()` will "Prevent
> > system sleep for 5s to allow user space to consume the\n corresponding
> > uevent"... which interrupts a system sleep in progress.
> >
> > On my current kernel, the same logic applies, but reading the source I
> > can't tell where `__mmc_claim_host()` is actually calling
> > `__pm_runtime_resume()`. Nonetheless the problem remains that
> > `rpm_resume()` is called during system suspend, `mmc_detect_change()`
> > wakes the system when called, and this will abort system sleep when
> > `/sys/power/wakeup_count` is active.
>
> __mmc_claim_host() will call pm_runtime_get_sync() to runtime resume
> the mmc host device.
>
> The mmc host device's parent (a pci device) will then be runtime
> resumed too. That's the call to rtsx_pci_runtime_resume() we see
> above.
>
> The problem is then that rtsx_pci_runtime_resume() invokes a callback
> (->card_event())) back into the mmc host driver
> (drivers/mmc/host/rtsx_pci_sdmmc.c), which ends up calling
> mmc_detect_change() to try to detect whether a card have been
> inserted/removed.
>
> >
> > ## Next steps
> >
> > How would this problem be addressed? Off the top of my head, perhaps yo=
u
> > could not call `__pm_runtime_resume()` on a SD card reader during the
> > `device_suspend()` process, not call `pm_wakeup_ws_event()` when the SD
> > card status changes, not call  `pm_wakeup_ws_event()` *specifically*
> > when system suspend is temporarily waking up a SD card reader, or
> > disable pm_wakeup_ws_event() entirely during the suspend process (does
> > this defeat the purpose of the function?).
>
> Let me think a bit on what makes the best sense here. I will get back
> to you in a couple of days.
>
> >
> > Are there other drivers which cause the same symptoms? I don't know. I
> > asked on the KDE bug tracker for other users to attempt a failed sleep
> > with `echo 1 > /sys/power/pm_debug_messages` active, to identify which
> > driver broke suspend in their system; so far nobody has replied with
> > logs.
> >
> > Given that this bug is related to `/sys/power/wakeup_count`
> > (https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power), I
> > was considering CCing Rafael J. Wysocki <rafael@kernel.org> and
> > linux-pm@vger.kernel.org, but have decided to only message the MMC
> > maintainers for now. If necessary we may have to forward this message
> > there to get their attention.
> >
> > ----
> >
> > System information:
> >
> > * I have an Intel NUC8i7BEH mini PC, with CPU 8 =C3=97 Intel=C2=AE Core=
=E2=84=A2 i7-8559U
> >   CPU @ 2.70GHz.
> >
> >     * uname -mi prints `x86_64 unknown`.
> >
> > * `lspci -nn` prints
> >   "6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS=
522A PCI Express Card Reader [10ec:522a] (rev 01)".
> >
> > * I am running kernel 6.18.0-0.rc7.357.vanilla.fc43.x86_64 from the Fed=
ora COPRs
> >   (https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories).
> >
> > * dmesg at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf=
074e44a#file-dmesg-2025-11-25-txt
> >
> > * Fully resolved config at https://gist.github.com/nyanpasu64/ab5d3d156=
5aafe6c1c08cbcaf074e44a#file-config-6-18-0-0-rc7-357-vanilla-fc43-x86_64,
> >   source at https://download.copr.fedorainfracloud.org/results/@kernel-=
vanilla/mainline-wo-mergew/fedora-43-x86_64/09831015-mainline-womergew-rele=
ases/kernel-6.18.0-0.rc7.357.vanilla.fc43.src.rpm
>
> Kind regards
> Uffe
