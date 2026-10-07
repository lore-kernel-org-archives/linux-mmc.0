Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E21C5D72
	for <linux-mmc@vger.kernel.org>; Wed,  7 Oct 2026 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350731; cv=none; b=n5C6CzaIMJ+YgHCrXTGjYiIAR0nNQnaOevYvR08IEsadw77nnL/llXBlbljc3zNc0ih/61+ykHHxCNxPF/LZRCGKy4fLiZf4JCsq0j/YK3Cy2xrngGXGJAUP/fbSLFkBr0V2ofqSTaA3ove5zrynFxtgx2f8GdM6a+wGP87l7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350731; c=relaxed/simple;
	bh=RosoGxQaWGo3IhirW+R5sUBXeY3HDfjxZWFsm+mnPxA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZHuVKLG5GVarUtR2FbCJOgUeKJvTXTTeioyGg/GQfz0qOc5eJO/b5DRZKXQLSafL5jDx2ig5HMOiuU/+RhOFlEf+eV9xgYwRmql5pNQf7EK3MZvdIkyp2rSlz6w/hVdD5T5MtMHux+RHjcTWBU3B1i8nodxmtRewNs/g0gMJOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avbesHVD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avbesHVD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so11940295e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 06 Oct 2026 22:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791350728; x=1791955528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3W65GoaIdAJN1o200mUJfQHssxpjmfu4hTkX3ESO6vg=;
        b=avbesHVDr5U/Zq7c3eXWzdnfvhsQmI+n5Og/Ndbieg8hEfo+QsS5/H37BzrNdyyOnJ
         eXHPT+JhY/HEYENU9KZvNk/R5+9GomnXW+UrF1TcXtZC9lrnyWBcALecQ8sUwSuJ7c2X
         rhFh+rTaRuQZH7+dL/cJ0G10u0wxWUfv92bIjKywmpeTa+EGIhW2GM6r4EnrY802+h2r
         gm7twBMrrwF8LYPlr8ActbUA/mEG7Oldz7QuCBYCTcXrToLzKI6aoz5QM9NEI2za0hzW
         d/H42SK8ckGW18GRYyJJu+kEP0E7UwsuZmnKVHuctXqowyhx1FZH0tOfqwEvzz8XIV06
         4G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350728; x=1791955528;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3W65GoaIdAJN1o200mUJfQHssxpjmfu4hTkX3ESO6vg=;
        b=Nw9v7/0jfiTHj2Mk6rypJNnWxStgBP0iwox9Sv4dZkG8QaYRUzBZ1HfMT5iWOVX8Pf
         GksoOb81MR8jSg6HQ6qDFyoNkBgRMUxY7kBV3pBWSHgVPtuYkGimRrfhLox4IJcN+Ija
         RESVN1Puye5ZnvbkoARWEmZC1zrjfO/UQKc8yDJQXG65/WyKf6hMuDLgLrn5HEImqd2B
         p1qXjpZBtPxBtvP4h4AZtJ5APyjX84s6V0juw4y7F22jUIJzAm9Th6WUZxYWJlKluyap
         nIN5qjePfhBzp2VmBYoLEUKJuPeol6yfZ0VaAsl6oYG7cbezhOn2LEjhTDtINmJsiyIi
         uMkw==
X-Forwarded-Encrypted: i=1; AKwUvBwLR/BawulnjL1TFWzDL979hzElSTduMs3zHsHd1Ur0yfJqTsycA9/9YWVQSLYOvHaLyOKN12nqo/g=@vger.kernel.org
X-Gm-Message-State: AFuF++k1IY0KIxUec85/DYp3Bkbt4+SyXYAAXPJrB9dbACiwXuNn6GQu
	BjpoZn8QbLCqlaqV0NTw1y3L6CXEnCHnHjzoPs37AsKvrTMvxHKCmPgi
X-Gm-Gg: AYBFou29TW1GwYMItWVPFHusf0XHC/U+FcnVQmcmXYrBQs7+Q1YlsZ7jOyhjJlFBb3m
	ODFXbxlIhIrjcAHiMAWq4/1J/9QCtiLkGLCCcHxfXPWkjsPT/DAzxZk77DdgE0P1Ua+G5xsg74j
	XC87hhEU9wmZ+gMgH9hPbc2KHICwZR/wkgZYKQ/yeoLdafyCYop7AeNPyXaho5GXRAbRHLWwJ5D
	S/mn6Psr04JTjK9EBsUFwuasnvB2imIVobSmWv87ve2imFhb809GbJW694/PMvyFU72r4+7tqYQ
	FC4u4+y6tgvNfF12CTNsFvEl0rF5CNRSmx2nHgqY8RMWeWtS/IA1jLuuqUnZxmTYfHAahYVBKMG
	wjUFO+b6Vnit//2+kpAGFASg9rHOGs1aNnp9wDC4B7OGRk8ck1fQdBu8ZUsYYbKa5JOStUfxMRW
	C0UQga57vBiOlKVDMO0LeMrGSYf34COzcC6ZRjxIzoJ/aGsgw+DhmimQ6Qx9oq35Z/NQ6CJeoFw
	1bifjv7HTg=
X-Received: by 2002:a05:600c:6095:b0:4a0:2835:6fd3 with SMTP id 5b1f17b1804b1-4a18041c519mr13321265e9.17.1791350727646;
        Tue, 06 Oct 2026 22:25:27 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f557bcbsm52757645e9.9.2026.10.06.22.25.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Oct 2026 22:25:27 -0700 (PDT)
Date: Wed, 7 Oct 2026 07:25:22 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org
Subject: [BUG] Big splat on rtsx_usb disconnection
Message-ID: <20261007072522.6e40ce0b.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ulf,

I get quite a bunch of MMC warnings if I disconnect the reader with
ongoing operations, either during card initialization or otherwise.

Looks like remove() is failing to notify MMC core about teardown?
I can test patches and debug things, but not sure where to start.

Regards,
Michal

---
[88777.845834] usb 8-1: new high-speed USB device number 7 using xhci_hcd
[88777.971097] usb 8-1: New USB device found, idVendor=0bda, idProduct=0129, bcdDevice=39.60
[88777.972868] usb 8-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[88777.972880] usb 8-1: Product: USB2.0-CRW
[88777.972884] usb 8-1: Manufacturer: Generic
[88777.972888] usb 8-1: SerialNumber: 20100201396000000
[88778.741563] mmc0: new UHS-I speed SDR50 SDHC card at address e624
[88778.744126] mmcblk0: mmc0:e624 SD08G 7.40 GiB
[88778.753927]  mmcblk0: p1
[88778.922130] usb 8-1: USB disconnect, device number 7
[88778.924779] mmc0: card e624 removed
[88779.027940] ------------[ cut here ]------------
[88779.027949] WARNING: drivers/mmc/core/core.c:637 at mmc_wait_for_cmd+0x61/0x70, CPU#3: kworker/3:1H/137
[88779.027967] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid xhci_pci xhci_hcd rtsx_usb_sdmmc rtsx_usb mfd_core r8153_ecm cdc_ether usbnet r8152 mii ext2 ehci_pci snd_pcsp ehci_hcd usbcore usb_common serio_raw ppdev dm_mod [last unloaded: xhci_hcd]
[88779.028015] CPU: 3 UID: 0 PID: 137 Comm: kworker/3:1H Not tainted 7.3.0-rc6 #33 PREEMPT 
[88779.028023] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[88779.028027] Workqueue: mmc_complete mmc_blk_mq_complete_work
[88779.028036] RIP: 0010:mmc_wait_for_cmd+0x61/0x70
[88779.028044] Code: c7 48 c7 43 10 00 00 00 00 89 53 1c 48 c7 43 28 00 00 00 00 48 89 5c 24 08 e8 eb fe ff ff 8b 43 20 48 81 c4 a8 00 00 00 5b c3 <0f> 0b eb c8 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 83
[88779.028049] RSP: 0018:ffffc9000161fc80 EFLAGS: 00010246
[88779.028054] RAX: 0000000000000000 RBX: ffffc9000161fd38 RCX: 0000000000000000
[88779.028059] RDX: 0000000000000000 RSI: ffffc9000161fc80 RDI: ffffc9000161fd28
[88779.028062] RBP: ffff88814d314e10 R08: ffff88811ad8c000 R09: 00000000ffffffed
[88779.028066] R10: ffff88814d3116b8 R11: fefefefefefefeff R12: 0000000000000001
[88779.028069] R13: ffff888105c56000 R14: ffff88814d314e00 R15: ffffc9000161fd9c
[88779.028072] FS:  0000000000000000(0000) GS:ffff88829c75c000(0000) knlGS:0000000000000000
[88779.028077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88779.028081] CR2: 00005583ac34cd20 CR3: 00000001b9422000 CR4: 00000000001506f0
[88779.028085] Call Trace:
[88779.028089]  <TASK>
[88779.028097]  __mmc_send_status+0x62/0x80
[88779.028105]  mmc_blk_mq_rw_recovery+0x3f/0x340
[88779.028111]  ? hrtimer_start_range_ns+0x6a/0xf0
[88779.028121]  mmc_blk_mq_poll_completion+0x5e/0x1e0
[88779.028127]  mmc_blk_mq_complete_work+0x44/0x70
[88779.028133]  process_one_work+0x189/0x340
[88779.028140]  worker_thread+0x19b/0x310
[88779.028146]  ? rescuer_thread+0x510/0x510
[88779.028150]  kthread+0xde/0x110
[88779.028157]  ? kthreads_online_cpu+0x10/0x10
[88779.028164]  ret_from_fork+0x17e/0x250
[88779.028172]  ? kthreads_online_cpu+0x10/0x10
[88779.028178]  ret_from_fork_asm+0x11/0x20
[88779.028187]  </TASK>
[88779.028189] ---[ end trace 0000000000000000 ]---
[88779.028214] ------------[ cut here ]------------
[88779.028216] WARNING: drivers/mmc/core/host.c:166 at mmc_retune_release+0x19/0x20, CPU#3: kworker/3:1H/137
[88779.028227] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid xhci_pci xhci_hcd rtsx_usb_sdmmc rtsx_usb mfd_core r8153_ecm cdc_ether usbnet r8152 mii ext2 ehci_pci snd_pcsp ehci_hcd usbcore usb_common serio_raw ppdev dm_mod [last unloaded: xhci_hcd]
[88779.028265] CPU: 3 UID: 0 PID: 137 Comm: kworker/3:1H Tainted: G        W           7.3.0-rc6 #33 PREEMPT 
[88779.028273] Tainted: [W]=WARN
[88779.028275] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[88779.028278] Workqueue: mmc_complete mmc_blk_mq_complete_work
[88779.028284] RIP: 0010:mmc_retune_release+0x19/0x20
[88779.028292] Code: e0 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 8b 87 e0 03 00 00 85 c0 74 0a 83 e8 01 89 87 e0 03 00 00 c3 <0f> 0b c3 0f 1f 40 00 0f 1f 44 00 00 80 7f f0 00 74 07 c7 47 f4 01
[88779.028296] RSP: 0018:ffffc9000161fd88 EFLAGS: 00010246
[88779.028301] RAX: 0000000000000000 RBX: ffff888161c9db00 RCX: 0000000000000000
[88779.028304] RDX: 00000000ffffff85 RSI: ffffc9000161fc80 RDI: ffff88811ad8c000
[88779.028308] RBP: ffff88814d314e10 R08: ffff88811ad8c000 R09: 00000000ffffffed
[88779.028311] R10: ffff88814d3116b8 R11: fefefefefefefeff R12: 0000000000000001
[88779.028314] R13: ffff888105c56000 R14: ffff88814d314e00 R15: ffffc9000161fd9c
[88779.028318] FS:  0000000000000000(0000) GS:ffff88829c75c000(0000) knlGS:0000000000000000
[88779.028322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88779.028326] CR2: 00005583ac34cd20 CR3: 00000001b9422000 CR4: 00000000001506f0
[88779.028329] Call Trace:
[88779.028331]  <TASK>
[88779.028333]  mmc_blk_mq_rw_recovery+0x269/0x340
[88779.028340]  ? hrtimer_start_range_ns+0x6a/0xf0
[88779.028348]  mmc_blk_mq_poll_completion+0x5e/0x1e0
[88779.028354]  mmc_blk_mq_complete_work+0x44/0x70
[88779.028359]  process_one_work+0x189/0x340
[88779.028365]  worker_thread+0x19b/0x310
[88779.028370]  ? rescuer_thread+0x510/0x510
[88779.028374]  kthread+0xde/0x110
[88779.028381]  ? kthreads_online_cpu+0x10/0x10
[88779.028387]  ret_from_fork+0x17e/0x250
[88779.028394]  ? kthreads_online_cpu+0x10/0x10
[88779.028400]  ret_from_fork_asm+0x11/0x20
[88779.028408]  </TASK>
[88779.028410] ---[ end trace 0000000000000000 ]---
[88779.028428] ------------[ cut here ]------------
[88779.028430] WARNING: drivers/mmc/core/core.c:637 at mmc_wait_for_cmd+0x61/0x70, CPU#3: kworker/3:1H/137
[88779.028439] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid xhci_pci xhci_hcd rtsx_usb_sdmmc rtsx_usb mfd_core r8153_ecm cdc_ether usbnet r8152 mii ext2 ehci_pci snd_pcsp ehci_hcd usbcore usb_common serio_raw ppdev dm_mod [last unloaded: xhci_hcd]
[88779.028473] Buffer I/O error on dev mmcblk0p1, logical block 65, async page read
[88779.028477] CPU: 3 UID: 0 PID: 137 Comm: kworker/3:1H Tainted: G        W           7.3.0-rc6 #33 PREEMPT 
[88779.028490] Tainted: [W]=WARN
[88779.028493] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[88779.028495] Workqueue: mmc_complete mmc_blk_mq_complete_work
[88779.028501] RIP: 0010:mmc_wait_for_cmd+0x61/0x70
[88779.028507] Code: c7 48 c7 43 10 00 00 00 00 89 53 1c 48 c7 43 28 00 00 00 00 48 89 5c 24 08 e8 eb fe ff ff 8b 43 20 48 81 c4 a8 00 00 00 5b c3 <0f> 0b eb c8 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 83
[88779.028511] RSP: 0018:ffffc9000161fc80 EFLAGS: 00010246
[88779.028516] RAX: 0000000000000000 RBX: ffffc9000161fd38 RCX: 0000000000000000
[88779.028520] RDX: 0000000000000000 RSI: ffffc9000161fc80 RDI: ffffc9000161fd28
[88779.028523] RBP: ffff88814d314e10 R08: ffff88811ad8c000 R09: 00000000ffffffed
[88779.028526] R10: ffff88814d3116b8 R11: fefefefefefefeff R12: 0000000000000001
[88779.028529] R13: ffff888105c56000 R14: ffff88814d314e00 R15: ffffc9000161fd9c
[88779.028532] FS:  0000000000000000(0000) GS:ffff88829c75c000(0000) knlGS:0000000000000000
[88779.028537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88779.028540] CR2: 00005583ac34cd20 CR3: 00000001b9422000 CR4: 00000000001506f0
[88779.028544] Call Trace:
[88779.028546]  <TASK>
[88779.028550]  __mmc_send_status+0x62/0x80
[88779.028557]  mmc_blk_mq_rw_recovery+0x276/0x340
[88779.028563]  ? hrtimer_start_range_ns+0x6a/0xf0
[88779.028566] Buffer I/O error on dev mmcblk0p1, logical block 64, async page read
[88779.028571]  mmc_blk_mq_poll_completion+0x5e/0x1e0
[88779.028577]  mmc_blk_mq_complete_work+0x44/0x70
[88779.028583]  process_one_work+0x189/0x340
[88779.028589]  worker_thread+0x19b/0x310
[88779.028594]  ? rescuer_thread+0x510/0x510
[88779.028598]  kthread+0xde/0x110
[88779.028604]  ? kthreads_online_cpu+0x10/0x10
[88779.028611]  ret_from_fork+0x17e/0x250
[88779.028617]  ? kthreads_online_cpu+0x10/0x10
[88779.028623]  ret_from_fork_asm+0x11/0x20
[88779.028631]  </TASK>
[88779.028633] ---[ end trace 0000000000000000 ]---
[88779.028656] ------------[ cut here ]------------
[88779.028658] WARNING: drivers/mmc/core/core.c:2184 at mmc_detect_card_removed+0xd0/0xe0, CPU#3: kworker/3:1H/137
[88779.028667] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid xhci_pci xhci_hcd rtsx_usb_sdmmc rtsx_usb mfd_core r8153_ecm cdc_ether usbnet r8152 mii ext2 ehci_pci snd_pcsp ehci_hcd usbcore usb_common serio_raw ppdev dm_mod [last unloaded: xhci_hcd]
[88779.028704] CPU: 3 UID: 0 PID: 137 Comm: kworker/3:1H Tainted: G        W           7.3.0-rc6 #33 PREEMPT 
[88779.028711] Tainted: [W]=WARN
[88779.028713] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[88779.028716] Workqueue: mmc_complete mmc_blk_mq_complete_work
[88779.028722] RIP: 0010:mmc_detect_card_removed+0xd0/0xe0
[88779.028728] Code: e2 20 74 0e 48 89 df e8 4e fe ff ff 89 c5 85 c0 75 1f 31 ed 5b 89 e8 5d 41 5c c3 c7 83 a8 04 00 00 00 00 00 00 e9 77 ff ff ff <0f> 0b e9 49 ff ff ff 8b 93 54 03 00 00 eb 90 90 0f 1f 44 00 00 55
[88779.028732] RSP: 0018:ffffc9000161fd70 EFLAGS: 00010246
[88779.028736] RAX: ffff888105c56000 RBX: ffff88811ad8c000 RCX: 0000000000000000
[88779.028740] RDX: 00000000ffffff85 RSI: ffffc9000161fc80 RDI: ffff88811ad8c000
[88779.028743] RBP: ffff88814d314e10 R08: ffff88811ad8c000 R09: 00000000ffffffed
[88779.028746] R10: ffff88814d3116b8 R11: fefefefefefefeff R12: 0000000000000001
[88779.028749] R13: ffff888105c56000 R14: ffff88814d314e00 R15: ffffc9000161fd9c
[88779.028752] FS:  0000000000000000(0000) GS:ffff88829c75c000(0000) knlGS:0000000000000000
[88779.028756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88779.028760] CR2: 00005583ac34cd20 CR3: 00000001b9422000 CR4: 00000000001506f0
[88779.028763] Call Trace:
[88779.028765]  <TASK>
[88779.028768]  mmc_blk_mq_rw_recovery+0x287/0x340
[88779.028774]  ? hrtimer_start_range_ns+0x6a/0xf0
[88779.028782]  mmc_blk_mq_poll_completion+0x5e/0x1e0
[88779.028788]  mmc_blk_mq_complete_work+0x44/0x70
[88779.028793]  process_one_work+0x189/0x340
[88779.028798]  worker_thread+0x19b/0x310
[88779.028803]  ? rescuer_thread+0x510/0x510
[88779.028807]  kthread+0xde/0x110
[88779.028813]  ? kthreads_online_cpu+0x10/0x10
[88779.028830]  ret_from_fork+0x17e/0x250
[88779.028841]  ? kthreads_online_cpu+0x10/0x10
[88779.028849]  ret_from_fork_asm+0x11/0x20
[88779.028858]  </TASK>
[88779.028860] ---[ end trace 0000000000000000 ]---
[88779.028878] ------------[ cut here ]------------
[88779.028880] WARNING: block/blk.h:703 at blk_mq_free_request+0x77/0x80, CPU#3: kworker/3:1H/137
[88779.028890] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid xhci_pci xhci_hcd rtsx_usb_sdmmc rtsx_usb mfd_core r8153_ecm cdc_ether usbnet r8152 mii ext2 ehci_pci snd_pcsp ehci_hcd usbcore usb_common serio_raw ppdev dm_mod [last unloaded: xhci_hcd]
[88779.028927] CPU: 3 UID: 0 PID: 137 Comm: kworker/3:1H Tainted: G        W           7.3.0-rc6 #33 PREEMPT 
[88779.028933] Tainted: [W]=WARN
[88779.028935] Hardware name: HP HP EliteDesk 705 G3 MT/8265, BIOS P06 Ver. 02.45 07/16/2024
[88779.028938] Workqueue: mmc_complete mmc_blk_mq_complete_work
[88779.028944] RIP: 0010:blk_mq_free_request+0x77/0x80
[88779.028949] Code: 00 00 83 c0 7f 83 f8 7f 76 20 f0 ff 8b 80 00 00 00 74 03 5b 5d c3 48 89 df 5b 5d e9 c3 f6 ff ff 48 89 de e8 3b 47 01 00 eb cb <0f> 0b eb dc 0f 1f 44 00 00 0f 1f 44 00 00 41 54 4c 8d 67 58 55 53
[88779.028953] RSP: 0018:ffffc9000161fe18 EFLAGS: 00010246
[88779.028957] RAX: 000000000000007f RBX: ffff888161c9db00 RCX: 0000000000000088
[88779.028961] RDX: 0000000000000003 RSI: 0000000000000003 RDI: ffff888161c9db00
[88779.028964] RBP: ffff88812cb3a730 R08: ffff88811ad8c000 R09: 00000000ffffffed
[88779.028967] R10: ffff88814d3116b8 R11: fefefefefefefeff R12: 0000000000000002
[88779.028970] R13: 0000000000000001 R14: ffff88810017c405 R15: 0000000000000000
[88779.028973] FS:  0000000000000000(0000) GS:ffff88829c75c000(0000) knlGS:0000000000000000
[88779.028977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[88779.028980] CR2: 00005583ac34cd20 CR3: 00000001b9422000 CR4: 00000000001506f0
[88779.028984] Call Trace:
[88779.028986]  <TASK>
[88779.028988]  mmc_blk_mq_post_req+0xdf/0xf0
[88779.028995]  mmc_blk_mq_complete_work+0x55/0x70
[88779.029000]  process_one_work+0x189/0x340
[88779.029005]  worker_thread+0x19b/0x310
[88779.029010]  ? rescuer_thread+0x510/0x510
[88779.029014]  kthread+0xde/0x110
[88779.029020]  ? kthreads_online_cpu+0x10/0x10
[88779.029027]  ret_from_fork+0x17e/0x250
[88779.029033]  ? kthreads_online_cpu+0x10/0x10
[88779.029039]  ret_from_fork_asm+0x11/0x20
[88779.029046]  </TASK>
[88779.029048] ---[ end trace 0000000000000000 ]---
