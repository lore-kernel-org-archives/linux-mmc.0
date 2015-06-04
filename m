From: Bastien Nocera <hadess@hadess.net>
Subject: "Out of SW-IOMMU space" reading films from SD card
Date: Thu, 04 Jun 2015 15:39:40 +0200
Message-ID: <1433425180.5346.34.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36218 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbFDNjo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 09:39:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hey,

I was travelling recently and stuffed a micro SD card full of films. I
started reading the films on my laptop's builtin SD card reader, but
started getting garbage on the screen after a little while.

The error (repeated multiple times a second, until I stopped reading
from the device):
[   51.582128] ------------[ cut here ]------------
[   51.582134] WARNING: CPU: 3 PID: 0 at drivers/mmc/host/sdhci.c:857 sdhci_send_command+0xa73/0xc50 [sdhci]()
[   51.582135] Modules linked in: bnep bluetooth fuse xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw uvcvideo videobuf2_vmalloc videobuf2_core videobuf2_memops intel_rapl iosf_mbi v4l2_common videodev iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal coretemp kvm_intel arc4 kvm vfat fat iwldvm snd_hda_codec_hdmi mac80211 crct10dif_pclmul snd_hda_codec_realtek media snd_h
 da_codec_generic
[   51.582154]  crc32_pclmul crc32c_intel ghash_clmulni_intel snd_hda_intel snd_hda_controller snd_hda_codec joydev iwlwifi hid_multitouch snd_hwdep snd_seq cfg80211 i2c_i801 snd_seq_device serio_raw tpm_tis snd_pcm tpm thinkpad_acpi wmi rfkill snd_timer snd mei_me soc_button_array intel_rst mei soundcore shpchp lpc_ich mfd_core nfsd auth_rpcgss nfs_acl lockd grace sunrpc dm_multipath mmc_block i915 sdhci_pci i2c_algo_bit drm_kms_helper sdhci mmc_core drm video
[   51.582168] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W       4.0.4-301.fc22.x86_64 #1
[   51.582169] Hardware name: LENOVO 3444CUU/3444CUU, BIOS G6ET93WW (2.53 ) 02/04/2013
[   51.582170]  0000000000000000 fe4349754b3971e3 ffff88021e2c3d08 ffffffff81782644
[   51.582172]  0000000000000000 0000000000000000 ffff88021e2c3d48 ffffffff8109c66a
[   51.582173]  ffff88021407e4c0 ffff88021407e4c0 ffff88003f81d0f0 ffff88003f81d170
[   51.582175] Call Trace:
[   51.582176]  <IRQ>  [<ffffffff81782644>] dump_stack+0x45/0x57
[   51.582180]  [<ffffffff8109c66a>] warn_slowpath_common+0x8a/0xc0
[   51.582181]  [<ffffffff8109c79a>] warn_slowpath_null+0x1a/0x20
[   51.582186]  [<ffffffffa00a5e93>] sdhci_send_command+0xa73/0xc50 [sdhci]
[   51.582188]  [<ffffffff810dedeb>] ? autoremove_wake_function+0x2b/0x40
[   51.582192]  [<ffffffffa00a6ce4>] sdhci_finish_command+0x154/0x160 [sdhci]
[   51.582196]  [<ffffffffa00a7023>] sdhci_irq+0x273/0x9ba [sdhci]
[   51.582202]  [<ffffffffa00779a0>] ? mmc_wait_data_done+0x30/0x40 [mmc_core]
[   51.582204]  [<ffffffff810f45d7>] handle_irq_event_percpu+0x77/0x1a0
[   51.582206]  [<ffffffff810f473b>] handle_irq_event+0x3b/0x60
[   51.582208]  [<ffffffff810f7759>] handle_fasteoi_irq+0x79/0x120
[   51.582211]  [<ffffffff81016514>] handle_irq+0x74/0x140
[   51.582213]  [<ffffffff810bc57a>] ? atomic_notifier_call_chain+0x1a/0x20
[   51.582215]  [<ffffffff8178ba1f>] do_IRQ+0x4f/0xf0
[   51.582217]  [<ffffffff8178976d>] common_interrupt+0x6d/0x6d
[   51.582218]  <EOI>  [<ffffffff81618b7d>] ? cpuidle_enter_state+0x5d/0x170
[   51.582221]  [<ffffffff81618b6d>] ? cpuidle_enter_state+0x4d/0x170
[   51.582223]  [<ffffffff81618cc7>] cpuidle_enter+0x17/0x20
[   51.582224]  [<ffffffff810df3c4>] cpu_startup_entry+0x314/0x430
[   51.582226]  [<ffffffff8111283c>] ? clockevents_register_device+0xbc/0x130
[   51.582228]  [<ffffffff8104a9b5>] start_secondary+0x1a5/0x1f0
[   51.582230] ---[ end trace c1501b3328e6f175 ]---
[   51.585285] DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0
[   51.588335] DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0
[   51.591419] DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0
[   51.594506] DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0
[   51.597581] DMA: Out of SW-IOMMU space for 65536 bytes at device 0000:02:00.0

The kernel would tell me that I had 64 megs of software IO TLB on boot
up, by default. Bumping it to 256 megs using "swiotlb=131072" on the
kernel command-line would fix all my movie watching problems:
May 30 15:57:50 nuvo kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
May 30 15:57:50 nuvo kernel: software IO TLB [mem 0xbd9fe000-0xcd9fe000] (256MB) mapped at [ffff8800bd9fe000-ffff8800cd9fdfff]

The laptop is a Lenovo Carbon X1 first generation, using Fedora's 4.0.4
kernel on Fedora 22.

Is it a firmware bug? A driver bug? I'd very much like this sort of
error to be, at least, reported back to user space instead of making me
think that the SD card is dying.

Cheers
