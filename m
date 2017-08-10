From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: KASAN + general protection fault while writing to mmc
Date: Thu, 10 Aug 2017 22:07:33 +0200
Message-ID: <20170810200733.27sqzr47ixlpxd62@macchiaveli>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5fb4zqivi36bk67v"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34538 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdHJUHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Aug 2017 16:07:40 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


--5fb4zqivi36bk67v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I got this while restoring a backup with dd on an SDCard.
On 4.13.0-rc4 I get it everytime.

I'm not sure if it isn't a hardware problem as I have no more cards
left.



--5fb4zqivi36bk67v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

[  484.751664] ==================================================================
[  484.751695] BUG: KASAN: slab-out-of-bounds in sg_next+0x20/0x50
[  484.751706] Read of size 8 at addr ffff8801ed53e530 by task mmcqd/0/187

[  484.751724] CPU: 0 PID: 187 Comm: mmcqd/0 Not tainted 4.13.0-rc4-preempt+ #38
[  484.751729] Hardware name: Hewlett-Packard HP EliteBook 2560p/162B, BIOS 68SSU Ver. F.02 07/26/2011
[  484.751732] Call Trace:
[  484.751745]  dump_stack+0x4f/0x69
[  484.751756]  print_address_description+0x78/0x290
[  484.751764]  ? sg_next+0x20/0x50
[  484.751772]  kasan_report+0x22f/0x340
[  484.751780]  __asan_load8+0x54/0x90
[  484.751788]  sg_next+0x20/0x50
[  484.751796]  blk_rq_map_sg+0x33a/0x800
[  484.751807]  mmc_queue_map_sg+0x134/0x150
[  484.751819]  mmc_blk_rw_rq_prep+0x2ba/0x7b0
[  484.751828]  mmc_blk_issue_rw_rq+0x1a9/0x690
[  484.751837]  ? mmc_blk_reset+0x250/0x250
[  484.751845]  ? cfq_dispatch_requests+0x7f3/0x1220
[  484.751852]  ? mmc_access_rpmb+0x28/0x40
[  484.751859]  mmc_blk_issue_rq+0x4a1/0xbb0
[  484.751868]  mmc_queue_thread+0x178/0x300
[  484.751885]  ? mmc_blk_issue_rq+0xbb0/0xbb0
[  484.751892]  ? __schedule+0x46c/0xc20
[  484.751899]  ? __sched_text_start+0x8/0x8
[  484.751908]  ? __wake_up_common+0x75/0xb0
[  484.751915]  ? preempt_count_sub+0x18/0xc0
[  484.751922]  kthread+0x18c/0x1e0
[  484.751927]  ? mmc_blk_issue_rq+0xbb0/0xbb0
[  484.751933]  ? kthread_create_on_node+0xb0/0xb0
[  484.751941]  ret_from_fork+0x22/0x30

[  484.751951] Allocated by task 81:
[  484.751961]  save_stack_trace+0x1b/0x20
[  484.751966]  save_stack+0x46/0xd0
[  484.751971]  kasan_kmalloc+0xad/0xe0
[  484.751976]  __kmalloc+0x11c/0x260
[  484.751980]  mmc_alloc_sg+0x2c/0x60
[  484.751985]  mmc_init_request+0x162/0x190
[  484.751990]  alloc_request_size+0x77/0xa0
[  484.751996]  mempool_create_node+0x175/0x1d0
[  484.752001]  blk_init_rl+0xf4/0x180
[  484.752007]  blk_init_allocated_queue+0xb9/0x210
[  484.752011]  mmc_init_queue+0x154/0x580
[  484.752018]  mmc_blk_alloc_req+0x14d/0x510
[  484.752024]  mmc_blk_probe+0x41f/0x820
[  484.752031]  mmc_bus_probe+0x35/0x40
[  484.752039]  driver_probe_device+0x322/0x400
[  484.752054]  __device_attach_driver+0xc4/0x100
[  484.752056]  bus_for_each_drv+0xf6/0x160
[  484.752059]  __device_attach+0x161/0x1c0
[  484.752061]  device_initial_probe+0x13/0x20
[  484.752063]  bus_probe_device+0xfe/0x120
[  484.752065]  device_add+0x549/0xa10
[  484.752067]  mmc_add_card+0x1fe/0x420
[  484.752069]  mmc_attach_sd+0x15e/0x210
[  484.752072]  mmc_rescan+0x585/0x620
[  484.752075]  process_one_work+0x3f2/0x760
[  484.752077]  worker_thread+0x90/0x710
[  484.752079]  kthread+0x18c/0x1e0
[  484.752081]  ret_from_fork+0x22/0x30

[  484.752083] Freed by task 0:
[  484.752085] (stack is not available)

[  484.752089] The buggy address belongs to the object at ffff8801ed53e510
                which belongs to the cache kmalloc-32 of size 32
[  484.752093] The buggy address is located 0 bytes to the right of
                32-byte region [ffff8801ed53e510, ffff8801ed53e530)
[  484.752096] The buggy address belongs to the page:
[  484.752099] page:ffffea0007b54f80 count:1 mapcount:0 mapping:          (null) index:0x0
[  484.752103] flags: 0x100000000000100(slab)
[  484.752108] raw: 0100000000000100 0000000000000000 0000000000000000 0000000100550055
[  484.752111] raw: 0000000000000000 0000000100000001 ffff8801f580f800 0000000000000000
[  484.752113] page dumped because: kasan: bad access detected

[  484.752116] Memory state around the buggy address:
[  484.752119]  ffff8801ed53e400: 00 fc fc fc 00 00 00 00 fc fc 00 00 00 00 fc fc
[  484.752122]  ffff8801ed53e480: 00 00 00 00 fc fc 00 00 00 00 fc fc 00 00 00 00
[  484.752126] >ffff8801ed53e500: fc fc 00 00 00 00 fc fc 00 00 00 fc fc fc 00 00
[  484.752128]                                      ^
[  484.752130]  ffff8801ed53e580: 00 fc fc fc 00 00 00 fc fc fc 00 00 00 fc fc fc
[  484.752133]  ffff8801ed53e600: 00 00 00 fc fc fc fb fb fb fb fc fc 00 00 00 fc
[  484.752135] ==================================================================
[  484.752137] Disabling lock debugging due to kernel taint
[  484.752143] general protection fault: 0000 [#1] PREEMPT SMP KASAN
[  484.752227] Modules linked in: tun bridge stp llc fuse ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_addrtype iptable_nat nf_nat_ipv4 nf_nat x86_pkg_temp_thermal kvm_intel kvm irqbypass crc32_pclmul iwldvm mac80211 input_leds iwlwifi cfg80211 rfkill i915 ext4 mbcache jbd2 ahci libahci libata ehci_pci ehci_hcd
[  484.752514] CPU: 0 PID: 187 Comm: mmcqd/0 Tainted: G    B           4.13.0-rc4-preempt+ #38
[  484.752597] Hardware name: Hewlett-Packard HP EliteBook 2560p/162B, BIOS 68SSU Ver. F.02 07/26/2011
[  484.752687] task: ffff8801f051bb00 task.stack: ffff8801eb858000
[  484.752749] RIP: 0010:blk_rq_map_sg+0x345/0x800
[  484.752796] RSP: 0018:ffff8801eb85fa68 EFLAGS: 00010247
[  484.752851] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81429a75
[  484.752956] RDX: 0000000000000000 RSI: 0000000000000008 RDI: c9e000f200000050
[  484.753064] RBP: ffff8801eb85fb10 R08: fffffbfff0550bcc R09: ffffffff82a85e94
[  484.753185] R10: ffff8801eb85f957 R11: fffffbfff0550bcc R12: 0000000000001000
[  484.753323] R13: 0000000000000000 R14: 0000000000003000 R15: c9e000f200000050
[  484.753443] FS:  0000000000000000(0000) GS:ffff8801f5c00000(0000) knlGS:0000000000000000
[  484.753525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  484.753583] CR2: 00007f4505491000 CR3: 000000000240e000 CR4: 00000000000406f0
[  484.753689] Call Trace:
[  484.753807]  mmc_queue_map_sg+0x134/0x150
[  484.753853]  mmc_blk_rw_rq_prep+0x2ba/0x7b0
[  484.753899]  mmc_blk_issue_rw_rq+0x1a9/0x690
[  484.753946]  ? mmc_blk_reset+0x250/0x250
[  484.753988]  ? cfq_dispatch_requests+0x7f3/0x1220
[  484.754038]  ? mmc_access_rpmb+0x28/0x40
[  484.754081]  mmc_blk_issue_rq+0x4a1/0xbb0
[  484.754124]  mmc_queue_thread+0x178/0x300
[  484.754190]  ? mmc_blk_issue_rq+0xbb0/0xbb0
[  484.754385]  ? __schedule+0x46c/0xc20
[  484.754594]  ? __sched_text_start+0x8/0x8
[  484.754729]  ? __wake_up_common+0x75/0xb0
[  484.754875]  ? preempt_count_sub+0x18/0xc0
[  484.755026]  kthread+0x18c/0x1e0
[  484.755138]  ? mmc_blk_issue_rq+0xbb0/0xbb0
[  484.755279]  ? kthread_create_on_node+0xb0/0xb0
[  484.755432]  ret_from_fork+0x22/0x30
[  484.755553] Code: 48 01 f2 48 39 d1 0f 84 ca 02 00 00 4c 89 ff e8 82 75 e7 ff 4c 89 ff 49 83 27 fd e8 86 99 03 00 49 89 c7 4c 89 ff e8 6b 75 e7 ff <49> 8b 07 83 e0 03 f6 45 c8 03 0f 85 68 01 00 00 48 0b 45 c8 49 
[  484.756270] RIP: blk_rq_map_sg+0x345/0x800 RSP: ffff8801eb85fa68
[  484.792060] ---[ end trace 5c02e9b4d93d7033 ]---

--5fb4zqivi36bk67v--
