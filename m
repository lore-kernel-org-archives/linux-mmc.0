Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5824166C
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148135; cv=none; b=VLYQ0wh7qwCqKw30fq6E0ND+dJg2+i1hFAjM9OCyEMYtopLZqF05H2Ew/gyKC5PYXNoiT9QcaoWHC2hAvR2K4yZt/ZzVGBbWGTeqzZELgbyxlsMwmuw3WtRidxmkXdIktXSLxea08geMING2nCCSD14+USKF/YpvQsBgCgZA+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148135; c=relaxed/simple;
	bh=EQbQQECKL8tmYBZCR70aGCTG1qpsW/lP0HYtINfwm8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qY7AKFbP09wYw+gIxlh4B9YyFgq4NKOG2GBkZ4oV4bTaFEhD8q+FvxtFKcDblvKxGc2qC3OPGMUXDWqwBlWd4/efyHz3J8VNgzPfEytrPcaIHtYEygKYTnyJn6azNaCd3pRubwE/sYgafQ5uhs6DfEcY5BtlrwBudousCpAuxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbnsPhKa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbnsPhKa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso5160917b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 01:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764148133; x=1764752933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTIeYzRvX9RmX58C/3dNB6Vl+6c7ZcJr+WiK7/9nR48=;
        b=EbnsPhKaLY3ex8dCDCNvv4ER8ArF23wfCyiVJtQ381b8uqYo65CwRF6qrU2BEsCwPj
         DZ6tZbSQ2omlGE0vLAucwBWX2vVm6ZEmYvracw9w/OtyQOXx/7AIAG0+Uf4D5q0Ez0SE
         1rWoCc0jSeS7cbUkIfJmkUUat9EMjagNXWwbJqiLXeVPgwtm2baR2MvnDUZmAqHvovzO
         O5WYpbfrvqNNv35skjznkpUbH4hDBf+kbhLg/FW9Iook+5bDe535WDCToAnd7BhFqyff
         S1ziReIpQVRdE2HK44cFjMvLiN4r7W9+BgxweTJS/X7K1XKMLgWPHyPuUzTB1W0f9x8m
         iF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148133; x=1764752933;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTIeYzRvX9RmX58C/3dNB6Vl+6c7ZcJr+WiK7/9nR48=;
        b=U+yL/AS3r+l4Ht6M54auD8kFmfcvSSvrE7GYQXUQOu4gVf3p4HSoXRTn9Kb6nhdCKc
         Q4/WWgRAf/Ym/SooHIb48lTinS7AG+dGBJHwBTT7bTvHZZGQQYAaYdI7OCShNv5uYJQS
         FCTedhfU6YAclWd37Noe2blTaqWrPoX/RtJ0I9wNQKW3DtpjmV7WgZ2MYK70laLCCvSX
         M06oJ6COoqWKtWGLdZ4IaGJ3Z1hBkTYmrgoNYjTYK0kdKClgzIRuzw2zuSc9bzqKwNh7
         vVNtZz/JI2qDyWcrgqyuTs0Xm+zGUW7Ff/NNzLOBd0+bkXxKLAW/pjhNHp5DZ4rx/Oek
         H/sQ==
X-Gm-Message-State: AOJu0YwQqf+/oyVHEan88AeUPSrLo2QYSzYKRK4qwnAT8agsyR452agN
	GgYqgIPSCuHZOONicNUYPQf3UTb628FRPhk7qp7n50rMBMAs0DjSB1m5
X-Gm-Gg: ASbGncsxhuoIdK4dPCClDA8UGm66cl4UBcIUZ+LB/Od2/dUNT0jRisbeq3HDc+sbfBW
	32JMvyzfhqviUUYOhuCzcOE8lDilW/U5luObDgZC/8md3dLmRujmAu0WQ1x2DLAbv0K2BHTk97a
	jG7stm5cRDFH5dO4EtVBvR4fORI4A1huB+vdru03EbRODa+TozFaEe+prHf7m8XOJa+CZ5+FMsB
	JTaABZ0cVW9ikQMPLsZket7Zn2NrKANdgH9Unxq0Wzw6GscJv0QuPe5JOylVLtPBD2ucvD68ytL
	ZMG5EcB4uWqpQ6l2plOjXQ3K40wqwnen5zvdzBUQeCP4yzxSmOyrwFKnwKlnQQACncae0cKhlz2
	bzfE/VdR9ZL4CQrgILpW5UoSX0FkVeU0Cw8WJgqTVaq5lYtU6zFUPx03pbFHK8Pjc9DTO2NjvLC
	TKSrVEIIl5FLzCDHGPi2S6A85gZrBDq3y8mEkQk54SZxTj2qS95bgpC+XKbVkcoiZuNHY=
X-Google-Smtp-Source: AGHT+IG7RjLZR1+drDTAi7Xx4LEIwiceWTLIWjhFr5YWza50WIYs7nWM4LrZGIoBP1JNB14K3jkFyw==
X-Received: by 2002:a05:7022:ed03:b0:11b:9386:a38d with SMTP id a92af1059eb24-11cbba87eb2mr2921274c88.48.1764148132894;
        Wed, 26 Nov 2025 01:08:52 -0800 (PST)
Received: from [192.168.0.186] (c-73-189-16-174.hsd1.ca.comcast.net. [73.189.16.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6dbc8sm95365061c88.10.2025.11.26.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 01:08:52 -0800 (PST)
Message-ID: <a242799a-d427-48e1-85ef-923f34df843a@gmail.com>
Date: Wed, 26 Nov 2025 01:08:51 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tabby Kitten <nyanpasu256@gmail.com>
Subject: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is enabled
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a PC with a Realtek PCI Express SD reader, when you sleep with
`wakeup_count` active (eg. sleeping from KDE's lock screen), the MMC
driver wakes up the system and aborts suspend.

I've found a sleep failure bug in the rtsx_pci and mmc_core drivers. 
After userspace writes a number to `/sys/power/wakeup_count` (eg. KDE 
Plasma does it to distinguish user wakes from timers and Wake-on-LAN), 
if it attempts a mem suspend it will be aborted when 
rtsx_pci_runtime_resume() -> mmc_detect_change() emits a 
pm_wakeup_ws_event(). This breaks sleep on some hardware and desktop 
environments.

The detailed description:
The recently released Plasma 6.5.0 writes to `/sys/power/wakeup_count`
before sleeping. On my computer this caused the sleep attempt to fail
with dmesg error "PM: Some devices failed to suspend, or early wake
event detected". I got this error on both Arch Linux and Fedora, and
replicated it on Fedora with the mainline kernel COPR. KDE is tracking
this error at https://bugs.kde.org/show_bug.cgi?id=510992, and have
disabled writing to wakeup_count on Plasma 6.5.3 to work around this
issue.

I've written a standalone shell script to reproduce this sleep failure 
(save as badsleep.sh):

#!/bin/bash
read wakeup_count < /sys/power/wakeup_count
if [[ $? -ne 0 ]]; then
    e=$?
    echo "Failed to open wakeup_count, suspend maybe already in progress"
    exit $e
fi
echo $wakeup_count > /sys/power/wakeup_count
if [[ $? -ne 0 ]]; then
    e=$?
    echo "Failed to write wakeup_count, wakeup_count may have changed in between"
    exit $e
fi
echo mem > /sys/power/state

Running `sudo ./badsleep.sh` reproduces failed sleeps on my computer.
(sudo is needed to write to `/sys/power/wakeup_count` on Fedora.)

* If I run the script unaltered, the screen turns off and on, and the 
  terminal outputs
  `./badsleep.sh: line 14: echo: write error: Device or resource busy`
  indicating the mem sleep failed.

* If I edit the script and comment out `echo $wakeup_count > 
  /sys/power/wakeup_count`, the sleep succeeds, and waking the computer 
  skips the lock screen and resumes where I left off.

* If I run `sudo rmmod rtsx_pci_sdmmc` to disable the faulty module, the 
  sleep succeeds, and waking the computer skips the lock screen and 
  resumes where I left off.

I think this problem happens in general when a driver spawns a wakeup 
event from its suspend callback. On my system, the driver in question 
lies in the MMC subsystem.

## Code debugging

If I run `echo 1 > /sys/power/pm_debug_messages` to enable verbose 
logging, then attempt a failed sleep, I see output:

    PM: Wakeup pending, aborting suspend
    PM: active wakeup source: mmc0
    PM: suspend of devices aborted after 151.615 msecs
    PM: start suspend of devices aborted after 169.797 msecs
    PM: Some devices failed to suspend, or early wake event detected

The "Wakeup pending, aborting suspend" message comes from function 
`pm_wakeup_pending()`. This function checks if event checks are enabled, 
and if some counters have changed aborts suspend and calls 
`pm_print_active_wakeup_sources()`, which prints `wakeup_sources`. 
Tracing the code that modifies `wakeup_sources`, I found that 
`pm_wakeup_ws_event()` would activate an event and 
`wakeup_source_register() → wakeup_source_add()` would add a new one.

To find who changed wakeup events, I used my stacksnoop fork at 
https://github.com/nyanpasu64/bcc/blob/local/examples/tracing/stacksnoop
.py to trace a failed suspend:

nyanpasu64@ryzen ~/code/bcc (local)> sudo ./examples/tracing/stacksnoop.py pm_wakeup_ws_event wakeup_source_register
TIME(s)            FUNCTION
7.254676819:
0: ret_from_fork_asm [kernel]
1: ret_from_fork [kernel]
2: kthread [kernel]
3: worker_thread [kernel]
4: process_one_work [kernel]
5: async_run_entry_fn [kernel]
6: async_suspend [kernel]
7: device_suspend [kernel]
8: dpm_run_callback [kernel]
9: mmc_bus_suspend [mmc_core]
10: mmc_blk_suspend [mmc_block]
11: mmc_queue_suspend [mmc_block]
12: __mmc_claim_host [mmc_core]
13: __pm_runtime_resume [kernel]
14: rpm_resume [kernel]
15: rpm_resume [kernel]
16: rpm_callback [kernel]
17: __rpm_callback [kernel]
18: rtsx_pci_runtime_resume [rtsx_pci]
19: mmc_detect_change [mmc_core]
20: pm_wakeup_ws_event [kernel]

On a previous kernel, lines 9-12 were replaced by a single call to 
`pci_pm_suspend`. I've posted my detailed debugging on the older kernel 
at https://bugs.kde.org/show_bug.cgi?id=510992#c26. There I found that 
`pci_pm_suspend()` wakes PCI(e) devices before sending them into a full 
sleep state, but in the process, `_mmc_detect_change()` will "Prevent 
system sleep for 5s to allow user space to consume the\n corresponding 
uevent"... which interrupts a system sleep in progress.

On my current kernel, the same logic applies, but reading the source I
can't tell where `__mmc_claim_host()` is actually calling
`__pm_runtime_resume()`. Nonetheless the problem remains that
`rpm_resume()` is called during system suspend, `mmc_detect_change()`
wakes the system when called, and this will abort system sleep when
`/sys/power/wakeup_count` is active.

## Next steps

How would this problem be addressed? Off the top of my head, perhaps you 
could not call `__pm_runtime_resume()` on a SD card reader during the 
`device_suspend()` process, not call `pm_wakeup_ws_event()` when the SD 
card status changes, not call  `pm_wakeup_ws_event()` *specifically* 
when system suspend is temporarily waking up a SD card reader, or 
disable pm_wakeup_ws_event() entirely during the suspend process (does 
this defeat the purpose of the function?).

Are there other drivers which cause the same symptoms? I don't know. I 
asked on the KDE bug tracker for other users to attempt a failed sleep 
with `echo 1 > /sys/power/pm_debug_messages` active, to identify which 
driver broke suspend in their system; so far nobody has replied with 
logs.

Given that this bug is related to `/sys/power/wakeup_count` 
(https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-power), I 
was considering CCing Rafael J. Wysocki <rafael@kernel.org> and 
linux-pm@vger.kernel.org, but have decided to only message the MMC 
maintainers for now. If necessary we may have to forward this message 
there to get their attention.

----

System information:

* I have an Intel NUC8i7BEH mini PC, with CPU 8 × Intel® Core™ i7-8559U 
  CPU @ 2.70GHz.

    * uname -mi prints `x86_64 unknown`.

* `lspci -nn` prints
  "6e:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI Express Card Reader [10ec:522a] (rev 01)".

* I am running kernel 6.18.0-0.rc7.357.vanilla.fc43.x86_64 from the Fedora COPRs 
  (https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories).

* dmesg at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-dmesg-2025-11-25-txt

* Fully resolved config at https://gist.github.com/nyanpasu64/ab5d3d1565aafe6c1c08cbcaf074e44a#file-config-6-18-0-0-rc7-357-vanilla-fc43-x86_64,
  source at https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/mainline-wo-mergew/fedora-43-x86_64/09831015-mainline-womergew-releases/kernel-6.18.0-0.rc7.357.vanilla.fc43.src.rpm
