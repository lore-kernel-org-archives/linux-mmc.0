Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2072356B5;
	Mon, 17 Mar 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206894; cv=none; b=cZzU1To5RzClcDWpceGS5x4B3kJE8aiIRtIsKRNClIDYG6cPSW3GnNl9391rfggUphKAAtl+MVWql30MMRmsWE9KdGZ1+XK031b7u6hj70IYXJ1Skk72khg8b4bNPTilrY67OXFoVxFkPsGTGQWoYHEs/0tcg2kN9chYTU+FKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206894; c=relaxed/simple;
	bh=U837RjvHyqJR3NZVbuSILd/Dyfs80zJOUM3qdXAfa68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbiUwa/vJFVepLCj7vNlMEhujlPtc6gJ/X8s4gffWB057XoKftrf/yt9ysCOXTKCXk+W7dh1jkEFce4Q3WfEAckJoVVApYs+HHWOG/kzoJT1+GULGYmU0W96jiw8EtrHenMhCmz1H7UtD94BvPCF3I553BVvbhMpc9C8IrzF5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: bizesmtpsz9t1742206857tnk4565
X-QQ-Originating-IP: fAQAPivMZcpfE1jWjItifzjDTQuPzY/G62Js0ufJpCw=
Received: from localhost.localdomain ( [175.10.25.237])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Mar 2025 18:20:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4273478174350150020
From: Luo Qiu <luoqiu@kylinsec.com.cn>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove
Date: Mon, 17 Mar 2025 18:14:38 +0800
Message-ID: <4B7BC3E6E291E6F2+20250317101438.25650-1-luoqiu@kylinsec.com.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NGbdgxYCWWEIaOOm/RYCpAi45Q+x9v5ShG51/Y0cYHBKn6yikYrmssPC
	miTRqRO0qood5OYARvSv/6nT+D2QAI2J0CxqtAIlR6qUhuJJjAcgYIfTxouogKYmPa3oa+H
	PbFg4G636dwTb4cOQ+8Q5S6q9wTuXFZNUwhfX88BJOfG6AYgL1ly61KGjsWu5G6Zr42urFc
	GauJHvzWc4mhhBbIudeR5fw57vRyBsTvXS5XV+6O9sU1CtjcfRpm+6y2E0G7q5p/Y4CJeE+
	teMy14XPCS8iTDVEpNPCZEuj5UEzwWAI44QIJqYv2pfQhc706OocTaaH7dCXKw6Nadf7yB4
	ArPltzJ3wPW6HeYBYSxWtmrpH+g4woQP2mq7qMy9PP0MKi+a2nnGSEPDQpZ0BM0xpDCCRLd
	kws/oVaGun+Q5g4RMOaHYEIj1tI0MKxjEvsgYQtgSfoz67CZvW7HKya2o4HUybnLhZRyZ8S
	h5B/dSYL6AHfDeOcBKyNMSKooJOPMHJxAQ7GQQC0T+hzwTRM+Y+hWtiqdFKfTUUPf1+Oyy5
	uBq0zQZCNJd8yY62B0Qs9Ygfw2g6KKoldkWBLGmRVZly1aK2K5OGNDfILKojHLafMduZgi1
	jwvv1SD6iXNbgEZfj/1spvFWhu6iq/EJRhJK9J7wPLBIsiqc9HRd9ZrDX8gI68WG3lQFolG
	ArRFb38HzTByKH21JuFLTjaKKteiAtPNSJxVOaOw6bluMOH1gqlAXtVR33gnEnNeD67gm0n
	e3T93Z33u5/D/wDXcemAPnSKoM5HHCeswNg0EA+9frHplJTbUUNY/MZWZh1UDQ/wHPaqZoB
	A0rYw2+lp0R6J/nGNI8WRilfQAKqakpjnrmaHknePPhi5i9S+mOzUSlGP2Dva84kYxtxph8
	zVYJRSrlT9/7od/1YQxXV+5cMPn2ajoKNHeHK+tw/4p0FWmLP/srYkOPUA4Utge/Iw9ZRVs
	KMOZQOuvtY291Xw+0oBrzmWhl6PhjIjuagBRVQMbts1j2oWMLpN7HUOmv7v1rqmg3Qbj6L9
	BprkULKEQ2Qt+xxP3grnKzwx+uykA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

This fixes the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
Read of size 8 at addr ffff888136335380 by task kworker/6:0/140241

CPU: 6 UID: 0 PID: 140241 Comm: kworker/6:0 Kdump: loaded Tainted: G            E      6.14.0-rc6+ #1
Tainted: [E]=UNSIGNED_MODULE
Hardware name: LENOVO 30FNA1V7CW/1057, BIOS S0EKT54A 07/01/2024
Workqueue: events rtsx_usb_ms_poll_card [rtsx_usb_ms]
Call Trace:
 <TASK>
 dump_stack_lvl+0x51/0x70
 print_address_description.constprop.0+0x27/0x320
 ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 print_report+0x3e/0x70
 kasan_report+0xab/0xe0
 ? rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 rtsx_usb_ms_poll_card+0x159/0x200 [rtsx_usb_ms]
 ? __pfx_rtsx_usb_ms_poll_card+0x10/0x10 [rtsx_usb_ms]
 ? __pfx___schedule+0x10/0x10
 ? kick_pool+0x3b/0x270
 process_one_work+0x357/0x660
 worker_thread+0x390/0x4c0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x190/0x1d0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 161446:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x10/0x30
 __kasan_kmalloc+0x7b/0x90
 __kmalloc_noprof+0x1a7/0x470
 memstick_alloc_host+0x1f/0xe0 [memstick]
 rtsx_usb_ms_drv_probe+0x47/0x320 [rtsx_usb_ms]
 platform_probe+0x60/0xe0
 call_driver_probe+0x35/0x120
 really_probe+0x123/0x410
 __driver_probe_device+0xc7/0x1e0
 driver_probe_device+0x49/0xf0
 __device_attach_driver+0xc6/0x160
 bus_for_each_drv+0xe4/0x160
 __device_attach+0x13a/0x2b0
 bus_probe_device+0xbd/0xd0
 device_add+0x4a5/0x760
 platform_device_add+0x189/0x370
 mfd_add_device+0x587/0x5e0
 mfd_add_devices+0xb1/0x130
 rtsx_usb_probe+0x28e/0x2e0 [rtsx_usb]
 usb_probe_interface+0x15c/0x460
 call_driver_probe+0x35/0x120
 really_probe+0x123/0x410
 __driver_probe_device+0xc7/0x1e0
 driver_probe_device+0x49/0xf0
 __device_attach_driver+0xc6/0x160
 bus_for_each_drv+0xe4/0x160
 __device_attach+0x13a/0x2b0
 rebind_marked_interfaces.isra.0+0xcc/0x110
 usb_reset_device+0x352/0x410
 usbdev_do_ioctl+0xe5c/0x1860
 usbdev_ioctl+0xa/0x20
 __x64_sys_ioctl+0xc5/0xf0
 do_syscall_64+0x59/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 161506:
 kasan_save_stack+0x20/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x36/0x60
 __kasan_slab_free+0x34/0x50
 kfree+0x1fd/0x3b0
 device_release+0x56/0xf0
 kobject_cleanup+0x73/0x1c0
 rtsx_usb_ms_drv_remove+0x13d/0x220 [rtsx_usb_ms]
 platform_remove+0x2f/0x50
 device_release_driver_internal+0x24b/0x2e0
 bus_remove_device+0x124/0x1d0
 device_del+0x239/0x530
 platform_device_del.part.0+0x19/0xe0
 platform_device_unregister+0x1c/0x40
 mfd_remove_devices_fn+0x167/0x170
 device_for_each_child_reverse+0xc9/0x130
 mfd_remove_devices+0x6e/0xa0
 rtsx_usb_disconnect+0x2e/0xd0 [rtsx_usb]
 usb_unbind_interface+0xf3/0x3f0
 device_release_driver_internal+0x24b/0x2e0
 proc_disconnect_claim+0x13d/0x220
 usbdev_do_ioctl+0xb5e/0x1860
 usbdev_ioctl+0xa/0x20
 __x64_sys_ioctl+0xc5/0xf0
 do_syscall_64+0x59/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x20/0x40
 kasan_record_aux_stack+0x85/0x90
 insert_work+0x29/0x100
 __queue_work+0x34a/0x540
 call_timer_fn+0x2a/0x160
 expire_timers+0x5f/0x1f0
 __run_timer_base.part.0+0x1b6/0x1e0
 run_timer_softirq+0x8b/0xe0
 handle_softirqs+0xf9/0x360
 __irq_exit_rcu+0x114/0x130
 sysvec_apic_timer_interrupt+0x72/0x90
 asm_sysvec_apic_timer_interrupt+0x16/0x20

Second to last potentially related work creation:
 kasan_save_stack+0x20/0x40
 kasan_record_aux_stack+0x85/0x90
 insert_work+0x29/0x100
 __queue_work+0x34a/0x540
 call_timer_fn+0x2a/0x160
 expire_timers+0x5f/0x1f0
 __run_timer_base.part.0+0x1b6/0x1e0
 run_timer_softirq+0x8b/0xe0
 handle_softirqs+0xf9/0x360
 __irq_exit_rcu+0x114/0x130
 sysvec_apic_timer_interrupt+0x72/0x90
 asm_sysvec_apic_timer_interrupt+0x16/0x20

The buggy address belongs to the object at ffff888136335000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 896 bytes inside of
 freed 2048-byte region [ffff888136335000, ffff888136335800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x136330
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0017ffffc0000040 ffff888100042f00 ffffea000417a000 dead000000000002
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0017ffffc0000003 ffffea0004d8cc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888136335280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888136335300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888136335380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888136335400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888136335480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")

Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
---
 drivers/memstick/host/rtsx_usb_ms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 6eb892fd4d34..3878136227e4 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -813,6 +813,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 
 	host->eject = true;
 	cancel_work_sync(&host->handle_req);
+	cancel_delayed_work_sync(&host->poll_card);
 
 	mutex_lock(&host->host_mutex);
 	if (host->req) {
-- 
2.48.1

