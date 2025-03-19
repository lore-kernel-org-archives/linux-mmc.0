Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DD254B1F
	for <linux-mmc@vger.kernel.org>; Wed, 19 Mar 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384434; cv=none; b=t1ohYbIxzzyh8el9EkgKi0+Tb71OCL4TUQF6uA3H2FYmyU3fqr6HXLyTlvWItVGag+/qwT30IzljlRXcFN9dMwan4E8ctFFYIA2b3nu5/60EtOxUok89VclOg/gqcQHP1iRmqur3GDOWYPqsshRy9V3MiR6PPEdWVgLurBSJyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384434; c=relaxed/simple;
	bh=GvQSOwF1xH0FZlOKPakW6KhIuzxRRubgM1HAP8GrOps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxQ0x7qpXWJnkKfYoAHNS3m9ACdTS3qIj+RC/29latGtjXEoSUOFZfWKZXIxkDUTGBEDfn4SncyWHhrZ4Dm3r7RA2BB7SUS6ONKtzR9T3dX6nK9xDRsK605DJJYv8j8B23nSrw/iLFm0rFCjnoTaeDJAWZE420q1SOwerIzgsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIwkpfst; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIwkpfst"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso1356726166b.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Mar 2025 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384431; x=1742989231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZobRQyE82PrcfyAci98JM5F/Bf80o+9zGJoT1dqPqSU=;
        b=wIwkpfst8xvsi0xwuml5lUSENs46QiU9//MB/rzqvsvjGQtH+Wk/m29V2voCwNvwhJ
         M2QMZFJEoDxbbLdn96ebkitvTDSSp7XfSYSCHCUrmEg0dDfEL15Gtq8yn0q+1bn/4/IY
         S5jt7vfB+O2R03HPml0U4iqLzPUpNsoUCkOSw8Iry6yM7uHhQ9qbhv/VMhPwlsNZUGc4
         pdfmkZEv+6hayPuKo+SQ3TJm/oxKWE2R3rY5gQ3YKmMWqs+NYfy85BrNA9Nw0N04QuGX
         kz0y7is+mKrUxD8eFvpZjgimUcV72JW8SJpnNGqqMSHuP/GPK8ZD8HeM9UJyyRTKvtt6
         D4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384431; x=1742989231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZobRQyE82PrcfyAci98JM5F/Bf80o+9zGJoT1dqPqSU=;
        b=Q5vk+1Gte/iswVp+Av3lfs8ufbe7Nb+DCJwJHJRGFQt2ifBw6aq6C1giKUq3/xNKjj
         JHzkJbDEEQ2CZCM9r/kO/CNH+MEooTHhnKumU5/UNTHshbdq7IolmCuke+y3nTKIqSJW
         KiLzvSWk8XGds2suWA+pqk4u/9NFnnd1mVrS9tOeQr/AVYvkc9efhs+Mlt6QNjrDp1Wb
         xV0JUQw/+JiqjGK1qsJtEFcy/EITObbvmQ/a89VAKCp/jLyDXSzlWwsDJNTgdSITkAfl
         FauNTfnmVS6HZh2IiLTFxbhlzbdnK3CLVf6VQu1zUqUU0GXbVx5nnxeiDcwy723a+JhA
         wdcA==
X-Forwarded-Encrypted: i=1; AJvYcCVUqcAvEnznLjInKnk3GRi53XOU94rax3w1hav8kOXZh3xAx4yjZk2JeTCxMZSmvNfpT5y1PE5d2nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMcEoeEZj0Bddnhmjh0kyxrXqLXG/luKr79jxaWzG6umAJPcO
	OO1f7yRpsOaV9BSuJPda9QIREJNIzjq4DBv5qvxgnFxFXbzrdpJBKexwK6I3Qdl3w7eISjQbL1w
	Q9ICwpM5mgd29YgWhZAsi27Imai7pxmDUf2FQ/w==
X-Gm-Gg: ASbGncs4/cV9mtHHfRYMYVEb5YWPV8P9sAEOoI0MbMejV+T7b9So48PWP9LW9fs8aEr
	ONbv7FJ6JOFH4vSGSPUWouPHJaNvHuvU0p77b+PP0YFU5/16Lsn/M6mj27fMCgkyaUy8VfQWR2a
	qjowToHnel4cUif8qFULOKpLA2p/c=
X-Google-Smtp-Source: AGHT+IFS/PPGTdYtEdh2OXEgwTgKoJAR66wmbxIQaI6A3hPCkyHmNSnjXRFkqxtLCFGoBNAmk+plQIPi/A81gnmm/sY=
X-Received: by 2002:a17:907:60c9:b0:abf:5fa3:cf96 with SMTP id
 a640c23a62f3a-ac3b7c38f43mr238032566b.14.1742384430960; Wed, 19 Mar 2025
 04:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4B7BC3E6E291E6F2+20250317101438.25650-1-luoqiu@kylinsec.com.cn>
In-Reply-To: <4B7BC3E6E291E6F2+20250317101438.25650-1-luoqiu@kylinsec.com.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Mar 2025 12:39:52 +0100
X-Gm-Features: AQ5f1JoTSBQDmnilXX4f2ulXbMJwEZU9MPFIEYIubx8tpTqEivhTG9yRp9CEfB8
Message-ID: <CAPDyKFqxezZ0zXhKzRewLB4OdrXU0Sc9DFHJwJ=Jozbjmo9UWQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove
To: Luo Qiu <luoqiu@kylinsec.com.cn>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 11:21, Luo Qiu <luoqiu@kylinsec.com.cn> wrote:
>
> This fixes the following crash:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
> Read of size 8 at addr ffff888136335380 by task kworker/6:0/140241
>
> CPU: 6 UID: 0 PID: 140241 Comm: kworker/6:0 Kdump: loaded Tainted: G            E      6.14.0-rc6+ #1
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: LENOVO 30FNA1V7CW/1057, BIOS S0EKT54A 07/01/2024
> Workqueue: events rtsx_usb_ms_poll_card [rtsx_usb_ms]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x51/0x70
>  print_address_description.constprop.0+0x27/0x320
>  ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
>  print_report+0x3e/0x70
>  kasan_report+0xab/0xe0
>  ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
>  rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
>  ? __pfx_rtsx_usb_ms_poll_card+0x10/0x10 [rtsx_usb_ms]
>  ? __pfx___schedule+0x10/0x10
>  ? kick_pool+0x3b/0x270
>  process_one_work+0x357/0x660
>  worker_thread+0x390/0x4c0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x190/0x1d0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 161446:
>  kasan_save_stack+0x20/0x40
>  kasan_save_track+0x10/0x30
>  __kasan_kmalloc+0x7b/0x90
>  __kmalloc_noprof+0x1a7/0x470
>  memstick_alloc_host+0x1f/0xe0 [memstick]
>  rtsx_usb_ms_drv_probe+0x47/0x320 [rtsx_usb_ms]
>  platform_probe+0x60/0xe0
>  call_driver_probe+0x35/0x120
>  really_probe+0x123/0x410
>  __driver_probe_device+0xc7/0x1e0
>  driver_probe_device+0x49/0xf0
>  __device_attach_driver+0xc6/0x160
>  bus_for_each_drv+0xe4/0x160
>  __device_attach+0x13a/0x2b0
>  bus_probe_device+0xbd/0xd0
>  device_add+0x4a5/0x760
>  platform_device_add+0x189/0x370
>  mfd_add_device+0x587/0x5e0
>  mfd_add_devices+0xb1/0x130
>  rtsx_usb_probe+0x28e/0x2e0 [rtsx_usb]
>  usb_probe_interface+0x15c/0x460
>  call_driver_probe+0x35/0x120
>  really_probe+0x123/0x410
>  __driver_probe_device+0xc7/0x1e0
>  driver_probe_device+0x49/0xf0
>  __device_attach_driver+0xc6/0x160
>  bus_for_each_drv+0xe4/0x160
>  __device_attach+0x13a/0x2b0
>  rebind_marked_interfaces.isra.0+0xcc/0x110
>  usb_reset_device+0x352/0x410
>  usbdev_do_ioctl+0xe5c/0x1860
>  usbdev_ioctl+0xa/0x20
>  __x64_sys_ioctl+0xc5/0xf0
>  do_syscall_64+0x59/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 161506:
>  kasan_save_stack+0x20/0x40
>  kasan_save_track+0x10/0x30
>  kasan_save_free_info+0x36/0x60
>  __kasan_slab_free+0x34/0x50
>  kfree+0x1fd/0x3b0
>  device_release+0x56/0xf0
>  kobject_cleanup+0x73/0x1c0
>  rtsx_usb_ms_drv_remove+0x13d/0x220 [rtsx_usb_ms]
>  platform_remove+0x2f/0x50
>  device_release_driver_internal+0x24b/0x2e0
>  bus_remove_device+0x124/0x1d0
>  device_del+0x239/0x530
>  platform_device_del.part.0+0x19/0xe0
>  platform_device_unregister+0x1c/0x40
>  mfd_remove_devices_fn+0x167/0x170
>  device_for_each_child_reverse+0xc9/0x130
>  mfd_remove_devices+0x6e/0xa0
>  rtsx_usb_disconnect+0x2e/0xd0 [rtsx_usb]
>  usb_unbind_interface+0xf3/0x3f0
>  device_release_driver_internal+0x24b/0x2e0
>  proc_disconnect_claim+0x13d/0x220
>  usbdev_do_ioctl+0xb5e/0x1860
>  usbdev_ioctl+0xa/0x20
>  __x64_sys_ioctl+0xc5/0xf0
>  do_syscall_64+0x59/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Last potentially related work creation:
>  kasan_save_stack+0x20/0x40
>  kasan_record_aux_stack+0x85/0x90
>  insert_work+0x29/0x100
>  __queue_work+0x34a/0x540
>  call_timer_fn+0x2a/0x160
>  expire_timers+0x5f/0x1f0
>  __run_timer_base.part.0+0x1b6/0x1e0
>  run_timer_softirq+0x8b/0xe0
>  handle_softirqs+0xf9/0x360
>  __irq_exit_rcu+0x114/0x130
>  sysvec_apic_timer_interrupt+0x72/0x90
>  asm_sysvec_apic_timer_interrupt+0x16/0x20
>
> Second to last potentially related work creation:
>  kasan_save_stack+0x20/0x40
>  kasan_record_aux_stack+0x85/0x90
>  insert_work+0x29/0x100
>  __queue_work+0x34a/0x540
>  call_timer_fn+0x2a/0x160
>  expire_timers+0x5f/0x1f0
>  __run_timer_base.part.0+0x1b6/0x1e0
>  run_timer_softirq+0x8b/0xe0
>  handle_softirqs+0xf9/0x360
>  __irq_exit_rcu+0x114/0x130
>  sysvec_apic_timer_interrupt+0x72/0x90
>  asm_sysvec_apic_timer_interrupt+0x16/0x20
>
> The buggy address belongs to the object at ffff888136335000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 896 bytes inside of
>  freed 2048-byte region [ffff888136335000, ffff888136335800)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x136330
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> page_type: f5(slab)
> raw: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
> raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> head: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
> head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> head: 0017ffffc0000003 ffffea0004d8cc01 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff888136335280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888136335300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888136335380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff888136335400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888136335480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
> Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")
>
> Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/rtsx_usb_ms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 6eb892fd4d34..3878136227e4 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -813,6 +813,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>
>         host->eject = true;
>         cancel_work_sync(&host->handle_req);
> +       cancel_delayed_work_sync(&host->poll_card);
>
>         mutex_lock(&host->host_mutex);
>         if (host->req) {
> --
> 2.48.1
>
