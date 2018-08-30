From: Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: 4.19.0-rc1 rtsx_pci_sdmmc.0: error: data->host_cookie = 62,
 host->cookie = 63
Date: Thu, 30 Aug 2018 21:06:41 +0200
Message-ID: <221c1dd1-504c-a255-55cf-8d51041f63de@interlog.com>
References: <6c696030-51a5-9ab9-47a9-d6fa3000a8a3@interlog.com>
 <CAPDyKFqk+K7TOyHoB1-+sguxbS_1s=RwCRiFMdrWOaSVhkpqJQ@mail.gmail.com>
Reply-To: dgilbert@interlog.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqk+K7TOyHoB1-+sguxbS_1s=RwCRiFMdrWOaSVhkpqJQ@mail.gmail.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2018-08-30 02:03 PM, Ulf Hansson wrote:
> On 28 August 2018 at 23:47, Douglas Gilbert <dgilbert@interlog.com> wrote:
>> I usually boot my Lenovo X270 with a SD card in its:
>>    # lspci
>> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI
>> Express Card Reader (rev 01)
>> ...
>>
>> In lk 4.19.0-rc1 the boot locks up solid, almost immediately and nothing in
>> the logs. If I remove the SD card my machine boots and works okay until I
>> insert the SD card. Then:
>>
>> Aug 28 23:30:38 xtwo70 kernel: mmc0: cannot verify signal voltage switch
>> Aug 28 23:30:38 xtwo70 kernel: mmc0: new ultra high speed SDR104 SDXC card
>> at address aaaa
>> Aug 28 23:30:38 xtwo70 kernel: mmcblk0: mmc0:aaaa ACLCE 59.5 GiB
>> Aug 28 23:30:38 xtwo70 kernel: mmcblk0: p1 p2
>> Aug 28 23:30:38 xtwo70 kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: error:
>> data->host_cookie = 62, host->cookie = 63
>> Aug 28 23:30:38 xtwo70 kernel: BUG: unable to handle kernel NULL pointer
>> dereference at 0000000000000018
>> Aug 28 23:30:38 xtwo70 kernel: PGD 0 P4D 0
>> Aug 28 23:30:38 xtwo70 kernel: Oops: 0000 [#1] SMP
>> Aug 28 23:30:38 xtwo70 kernel: CPU: 3 PID: 1571 Comm: kworker/3:2 Not
>> tainted 4.19.0-rc1 #78
>> Aug 28 23:30:38 xtwo70 kernel: Hardware name: LENOVO 20HNCTO1WW/20HNCTO1WW,
>> BIOS R0IET53W (1.31 ) 05/22/2018
>> Aug 28 23:30:38 xtwo70 kernel: Workqueue: events sd_request [rtsx_pci_sdmmc]
>> Aug 28 23:30:38 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260
>> [rtsx_pci]
>> Aug 28 23:30:38 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00
>> 00 00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96
>> 90 00 00 00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83
>> c7
>> Aug 28 23:30:38 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
>> Aug 28 23:30:38 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003
>> RCX: 0000000000000000
>> Aug 28 23:30:38 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021
>> RDI: ffff8801b6328000
>> Aug 28 23:30:38 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400
>> R09: 0000000000000000
>> Aug 28 23:30:38 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000
>> R12: 00000000a8000000
>> Aug 28 23:30:38 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400
>> R15: 0000000000000001
>> Aug 28 23:30:38 xtwo70 kernel: FS:  0000000000000000(0000)
>> GS:ffff880227380000(0000) knlGS:0000000000000000
>> Aug 28 23:30:38 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018 CR3: 000000000400f006
>> CR4: 00000000003606e0
>> Aug 28 23:30:38 xtwo70 kernel: Call Trace:
>> Aug 28 23:30:38 xtwo70 kernel: ? mark_held_locks+0x50/0x80
>> Aug 28 23:30:38 xtwo70 kernel: ? _raw_spin_unlock_irqrestore+0x2d/0x40
>> Aug 28 23:30:38 xtwo70 kernel: sd_request+0x385/0x81a [rtsx_pci_sdmmc]
>> Aug 28 23:30:38 xtwo70 kernel: process_one_work+0x287/0x5e0
>> Aug 28 23:30:38 xtwo70 kernel: worker_thread+0x28/0x3d0
>> Aug 28 23:30:38 xtwo70 kernel: ? process_one_work+0x5e0/0x5e0
>> Aug 28 23:30:38 xtwo70 kernel: kthread+0x10e/0x130
>> Aug 28 23:30:38 xtwo70 kernel: ? kthread_park+0x80/0x80
>> Aug 28 23:30:38 xtwo70 kernel: ret_from_fork+0x3a/0x50
>> Aug 28 23:30:38 xtwo70 kernel: Modules linked in: mmc_block fuse msr bnep
>> ccm btusb btrtl btbcm btintel bluetooth squashfs ecdh_generic binfmt_misc
>> intel_rapl nls_iso8859_1 nls_cp437 x86_pkg_temp_thermal vfat
>> intel_powerclamp fat coretemp kvm_intel arc4 snd_hda_codec_hdmi kvm
>> snd_hda_codec_realtek snd_hda_codec_generic irqbypass crct10dif_pclmul
>> crc32_pclmul ghash_clmulni_intel pcbc iwlmvm aesni_intel aes_x86_64
>> crypto_simd cryptd glue_helper mac80211 intel_cstate intel_uncore
>> intel_rapl_perf snd_hda_intel joydev snd_hda_codec mousedev snd_hwdep
>> iwlwifi snd_hda_core input_leds efi_pstore snd_pcm serio_raw efivars
>> cfg80211 rtsx_pci_ms memstick mei_me idma64 virt_dma mei intel_lpss_pci
>> intel_lpss intel_pch_thermal thinkpad_acpi nvram snd_seq_dummy tps6598x
>> snd_seq_oss typec snd_seq_midi snd_rawmidi snd_seq_midi_event
>> Aug 28 23:30:38 xtwo70 kernel: snd_seq snd_seq_device snd_timer snd
>> soundcore rfkill tpm_crb tpm_tis tpm_tis_core tpm evdev mac_hid pcc_cpufreq
>> ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_hl ip6t_rt ipt_REJECT
>> nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp
>> xt_addrtype xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns
>> nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter parport_pc ppdev lp
>> parport efivarfs ip_tables x_tables autofs4 hid_logitech_hidpp
>> hid_logitech_dj hid_generic usbhid hid rtsx_pci_sdmmc mmc_core i915 nvme
>> e1000e i2c_algo_bit nvme_core drm_kms_helper syscopyarea sysfillrect
>> sysimgblt fb_sys_fops xhci_pci drm xhci_hcd video
>> drm_panel_orientation_quirks usbcore intel_gtt agpgart usb_common rtsx_pci
>> Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018
>> Aug 28 23:30:38 xtwo70 kernel: ---[ end trace bb8ce18072d22d51 ]---
>> Aug 28 23:30:38 xtwo70 dbus-daemon[2110]: [system] Activating via systemd:
>> service name='org.freedesktop.hostname1'
>> unit='dbus-org.freedesktop.hostname1.service' requested by ':1.77' (uid=1000
>> pid=3518 comm="/usr/bin/gnome-shell ")
>> Aug 28 23:30:38 xtwo70 systemd[1]: Attaching egress BPF program to cgroup
>> /sys/fs/cgroup/unified/system.slice/systemd-hostnamed.service failed:
>> Invalid argument
>> Aug 28 23:30:38 xtwo70 systemd[1]: Starting Hostname Service...
>> Aug 28 23:30:39 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260
>> [rtsx_pci]
>> Aug 28 23:30:39 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00
>> 00 00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96
>> 90 00 00 00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83
>> c7
>> Aug 28 23:30:39 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
>> Aug 28 23:30:39 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003
>> RCX: 0000000000000000
>> Aug 28 23:30:39 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021
>> RDI: ffff8801b6328000
>> Aug 28 23:30:39 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400
>> R09: 0000000000000000
>> Aug 28 23:30:39 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000
>> R12: 00000000a8000000
>> Aug 28 23:30:39 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400
>> R15: 0000000000000001
>> Aug 28 23:30:39 xtwo70 kernel: FS:  0000000000000000(0000)
>> GS:ffff880227380000(0000) knlGS:0000000000000000
>> Aug 28 23:30:39 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Aug 28 23:30:39 xtwo70 kernel: CR2: 000056531391e498 CR3: 000000000400f006
>> CR4: 00000000003606e0
>>
>>
>> Doug Gilbert
> 
> Thanks for reporting!
> 
> I don't fine anything obvious from the mmc host driver point of view.
> However, there are a few changes in the mmc core layer which we
> already have fixes for.
> 
> You may either try my fixes branch from my mmc tree or use Stephen's
> tree and the branch pending fixes, to see if that fixes the problem.
> 
> git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes
> 
> git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes


This patch from your fixes branch:
     mmc: block: Fix unsupported parallel dispatch of requests
fixes my boot problem. I also did a remove and re-insertion of
the SD card and that worked as well.

Doug Gilbert

P.S. it's commit 26caddf274cf1e89fd4ce44ab2b8dbc7a7f97681
