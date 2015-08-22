From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: [REGRESSION] dereference NULL pointer when removing mmc card
Date: Sat, 22 Aug 2015 10:17:14 +0300
Message-ID: <CAFMg4WALTEmjYk=QMUAcku+VPosMHsMeZ6YCAN40ku1MJEWC=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36187 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbbHVHRQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Aug 2015 03:17:16 -0400
Received: by lbbpu9 with SMTP id pu9so55303674lbb.3
        for <linux-mmc@vger.kernel.org>; Sat, 22 Aug 2015 00:17:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

mmc0: card 59b4 removed
BUG: unable to handle kernel NULL pointer dereference at 0000000000000558
IP: [<ffffffff813895a6>] __blkg_lookup+0x26/0x70
PGD 0
Oops: 0000 [#1] SMP
Modules linked in: rfcomm cmac ccm fuse nf_conntrack_netbios_ns
nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack ebtable_nat ebtable_filter ebtable_broute bridge stp llc
ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6
ip6table_raw ip6table_security ip6table_mangle ip6table_filter
ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
nf_nat nf_conntrack iptable_raw iptable_security iptable_mangle bnep
intel_rapl iosf_mbi btusb x86_pkg_temp_thermal coretemp kvm_intel
btrtl btbcm btintel bluetooth kvm vfat fat snd_hda_codec_hdmi arc4
snd_hda_codec_realtek iTCO_wdt iTCO_vendor_support
snd_hda_codec_generic iwldvm snd_hda_intel snd_hda_codec mac80211
snd_hda_core snd_hwdep snd_seq snd_seq_device crct10dif_pclmul
uvcvideo crc32_pclmul
 crc32c_intel videobuf2_vmalloc videobuf2_core videobuf2_memops
snd_pcm iwlwifi v4l2_common videodev ghash_clmulni_intel cfg80211
cdc_acm media thinkpad_acpi mmc_block mei_me snd_timer i2c_i801 snd
mei shpchp lpc_ich tpm_tis soundcore tpm rfkill soc_button_array wmi
nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 i2c_algo_bit
drm_kms_helper drm sdhci_pci serio_raw sdhci mmc_core video cdc_mbim
cdc_ncm usbnet mii cdc_wdm kdbus
CPU: 0 PID: 113 Comm: kworker/u16:4 Not tainted
4.2.0-0.rc6.git0.1.fc24.x86_64 #1
Hardware name: LENOVO 3444FHG/3444FHG, BIOS G6ETA6WW (2.66 ) 05/28/2014
Workqueue: kmmcd mmc_rescan [mmc_core]
task: ffff8802122b9b80 ti: ffff8802122e4000 task.ti: ffff8802122e4000
RIP: 0010:[<ffffffff813895a6>]  [<ffffffff813895a6>] __blkg_lookup+0x26/0x70
RSP: 0018:ffff8802122e7988  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff820176a0
RBP: ffff8802122e79a8 R08: 00000000118de901 R09: 000000018020001e
R10: ffff8802118de900 R11: 0000000000000004 R12: ffff8802118de700
R13: ffff880212390898 R14: ffff8802136edd90 R15: ffff8802136edcd0
FS:  0000000000000000(0000) GS:ffff88021e200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000558 CR3: 00000001f54ac000 CR4: 00000000001406f0
Stack:
 ffffffff82017700 ffffffff820176a0 ffff8802118de700 ffff880212390898
 ffff8802122e79d8 ffffffff8138cfaa ffff8802136edd90 ffff880212390898
 ffffffff81cb3320 0000000000000000 ffff8802122e79e8 ffffffff81389f68
Call Trace:
 [<ffffffff8138cfaa>] blk_throtl_drain+0x5a/0x110
 [<ffffffff81389f68>] blkcg_drain_queue+0x18/0x20
 [<ffffffff813698d0>] __blk_drain_queue+0xc0/0x170
 [<ffffffff81369f61>] blk_queue_bypass_start+0x61/0x80
 [<ffffffff81388ab9>] blkcg_deactivate_policy+0x39/0x100
 [<ffffffff81393545>] cfq_exit_queue+0xd5/0xf0
 [<ffffffff8136719f>] elevator_exit+0x2f/0x50
 [<ffffffff81370003>] blk_release_queue+0x53/0xc0
 [<ffffffff8139bb1a>] kobject_release+0x7a/0x190
 [<ffffffff8139b9cf>] kobject_put+0x2f/0x60
 [<ffffffff81369805>] blk_put_queue+0x15/0x20
 [<ffffffff8137d142>] disk_release+0xa2/0xe0
 [<ffffffff814c8466>] device_release+0x36/0xa0
 [<ffffffff8139bb1a>] kobject_release+0x7a/0x190
 [<ffffffff8139b9cf>] kobject_put+0x2f/0x60
 [<ffffffff8137c447>] put_disk+0x17/0x20
 [<ffffffffa031a158>] mmc_blk_put+0x68/0x90 [mmc_block]
 [<ffffffffa031a1c8>] mmc_blk_remove_req+0x48/0xb0 [mmc_block]
 [<ffffffffa031bcb6>] mmc_blk_remove+0xb6/0x130 [mmc_block]
 [<ffffffffa005cdda>] mmc_bus_remove+0x1a/0x20 [mmc_core]
 [<ffffffff814cd1e1>] __device_release_driver+0xa1/0x150
 [<ffffffff814cd2b3>] device_release_driver+0x23/0x30
 [<ffffffff814cc905>] bus_remove_device+0x105/0x180
 [<ffffffff814c8d49>] device_del+0x139/0x260
 [<ffffffffa005d3a2>] mmc_remove_card+0x52/0xa0 [mmc_core]
 [<ffffffffa0061f4a>] mmc_sd_remove+0x2a/0x40 [mmc_core]
 [<ffffffffa006205e>] mmc_sd_detect+0x4e/0x80 [mmc_core]
 [<ffffffffa005c8bf>] mmc_rescan+0x16f/0x300 [mmc_core]
 [<ffffffff810b64ae>] process_one_work+0x19e/0x3f0
 [<ffffffff810b674e>] worker_thread+0x4e/0x450
 [<ffffffff810b6700>] ? process_one_work+0x3f0/0x3f0
 [<ffffffff810bc858>] kthread+0xd8/0xf0
 [<ffffffff810bc780>] ? kthread_worker_fn+0x160/0x160
 [<ffffffff817773df>] ret_from_fork+0x3f/0x70
 [<ffffffff810bc780>] ? kthread_worker_fn+0x160/0x160
Code: eb bf 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 55 41 54 53 48 83
ec 08 48 8b 87 c8 00 00 00 48 85 c0 74 05 48 39 30 74 45 48 89 f3 <48>
63 b6 58 05 00 00 49 89 fd 48 8d bf b8 00 00 00 41 89 d4 e8
RIP  [<ffffffff813895a6>] __blkg_lookup+0x26/0x70
 RSP <ffff8802122e7988>
CR2: 0000000000000558
---[ end trace 365f1479450a495f ]---
BUG: unable to handle kernel paging request at ffffffffffffffd8
IP: [<ffffffff810bcce0>] kthread_data+0x10/0x20


Probably this regression caused by:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/card/block.c?id=96541bac0b4e62efa42e7900d9b32e6baa9a214c
-- 
-Igor Gnatenko
