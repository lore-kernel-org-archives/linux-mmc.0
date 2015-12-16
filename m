From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.3 kernel panics when MMC/SDHC card is inserted on thinkpad
Date: Wed, 16 Dec 2015 09:50:53 +0200
Message-ID: <567117DD.8080109@intel.com>
References: <CAO2mnozX6QXbBqqRfr3pr-FXscGvrQRdxGjuJyYMq5BYWhiSFw@mail.gmail.com>
 <CAPDyKFprZJ+gKGa2VeHvA08OA=24TkSsmHJPpp64LeXYSUo-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9454 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbbLPHyK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Dec 2015 02:54:10 -0500
In-Reply-To: <CAPDyKFprZJ+gKGa2VeHvA08OA=24TkSsmHJPpp64LeXYSUo-6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Denis Bychkov <manover@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 15/12/15 18:01, Ulf Hansson wrote:
> +Adrian
> 
> On 8 November 2015 at 23:05, Denis Bychkov <manover@gmail.com> wrote:
>> The only started in 4.3 kernel (at least RC-5), 4.2.x does not have
>> this problem. The kernel panic happens immediately after the SDHC card
>> is inserted, reproducibility is 100%. If the system boots up with the
>> card already inserted, it will crash as soon as sdhci_pci module is
>> loaded. If the module is unloaded/blacklisted, obviously, nothing
>> happens as the system does not see the MMC card reader.
>> The machine is Lenovo thinkpad T-510 laptop with Intel Westmere
>> CPU/3400 series chipset running 64-bit kernel 4.3.0.
>>
>> (somewhat) relevant kernel configuration bits:
>> # CONFIG_CALGARY_IOMMU is not set
>> CONFIG_IOMMU_HELPER=y
>> CONFIG_VFIO_IOMMU_TYPE1=m
>> CONFIG_IOMMU_API=y
>> CONFIG_IOMMU_SUPPORT=y
>> # Generic IOMMU Pagetable Support
>> CONFIG_IOMMU_IOVA=y
>> # CONFIG_AMD_IOMMU is not set
>> CONFIG_INTEL_IOMMU=y
>> CONFIG_INTEL_IOMMU_DEFAULT_ON=y
>> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
>> # CONFIG_IOMMU_STRESS is not set
>> CONFIG_KVM_INTEL=m
>> CONFIG_PCI_MMCONFIG=y
>> # Supported MMC/SDIO adapters
>> CONFIG_MMC=m
>> # CONFIG_MMC_DEBUG is not set
>> # CONFIG_MMC_CLKGATE is not set
>> # MMC/SD/SDIO Card Drivers
>> CONFIG_MMC_BLOCK=m
>> CONFIG_MMC_BLOCK_MINORS=8
>> CONFIG_MMC_BLOCK_BOUNCE=y
>> CONFIG_MMC_TEST=m
>> # MMC/SD/SDIO Host Controller Drivers
>> CONFIG_MMC_SDHCI=m
>> CONFIG_MMC_SDHCI_PCI=m
>> CONFIG_MMC_RICOH_MMC=y
>> CONFIG_MMC_SDHCI_ACPI=m
>>
>> Card reader device:
>> 0d:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 01)
>>         Subsystem: Lenovo MMC/SD Host Controller
>>         Flags: bus master, fast devsel, latency 0, IRQ 16
>>         Memory at f2100000 (32-bit, non-prefetchable) [size=256]
>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>>         Capabilities: [78] Power Management version 3
>>         Capabilities: [80] Express Endpoint, MSI 00
>>         Capabilities: [100] Virtual Channel
>>         Capabilities: [800] Advanced Error Reporting
>>         Kernel driver in use: sdhci-pci
>>         Kernel modules: sdhci_pci
>>
>> The panic report caught via netconsole:
>>
>> [22946.904308] ------------[ cut here ]------------
>> [22946.906564] kernel BUG at drivers/iommu/intel-iommu.c:3485!
>> [22946.908801] invalid opcode: 0000 [#1] PREEMPT SMP
>> [22946.911113] Modules linked in: netconsole dm_mod bnep
>> cpufreq_powersave cpufreq_stats cpufreq_conservative cpufreq_userspace
>> coretemp intel_powerclamp kvm_intel kvm crct10dif_pclmul crc32_pclmul
>> jitterentropy_rng hmac sha256_ssse3 sha256_generic drbg
>> snd_hda_codec_hdmi ansi_cprng gpio_ich iTCO_wdt iTCO_vendor_support
>> aesni_intel arc4 aes_x86_64 nouveau mxm_wmi lrw gf128mul glue_helper
>> ablk_helper iwldvm cryptd psmouse mac80211 uvcvideo serio_raw pcspkr
>> nd_e820 videobuf2_vmalloc ttm evdev videobuf2_memops i2c_algo_bit
>> mousedev btusb videobuf2_core btrtl drm_kms_helper v4l2_common mac_hid
>> btbcm videodev btintel drm snd_hda_codec_conexant bluetooth
>> snd_hda_codec_generic iwlwifi syscopyarea sysfillrect sysimgblt
>> fb_sys_fops snd_hda_intel snd_hda_codec cfg80211 snd_hda_core
>> snd_hwdep i2c_i801 thinkpad_acpi lpc_ich snd_pcm sg mfd_core nvram
>> i2c_core snd_timer intel_ips rfkill hwmon snd mei_me soundcore
>> intel_agp mei tpm_tis intel_gtt shpchp tpm agpgart battery rtc_cmos ac
>> video thermal wmi acpi_cpufreq button processor tp_smapi(O)
>> thinkpad_ec(O) autofs4 ext4 crc16 mbcache jbd2 btrfs xor hid_generic
>> usbhid hid raid6_pq sr_mod cdrom sd_mod uas usb_storage firewire_ohci
>> ahci libahci crc32c_intel libata atkbd sdhci_pci scsi_mod ehci_pci
>> sdhci ehci_hcd e1000e firewire_core mmc_core crc_itu_t ptp usbcore
>> usb_common pps_core
>> [22946.929431] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G           O
>> 4.3.0-westmere #1
>> [22946.932551] Hardware name: LENOVO 4313CTO/4313CTO, BIOS 6MET92WW
>> (1.52 ) 09/26/2012
>> [22946.935701] task: ffff88023231a580 ti: ffff88023232c000 task.ti:
>> ffff88023232c000
>> [22946.938878] RIP: 0010:[<ffffffff813cacd0>]  [<ffffffff813cacd0>]
>> intel_unmap+0x1d0/0x210
>> [22946.942117] RSP: 0018:ffff88023bd83da8  EFLAGS: 00010046
>> [22946.945341] RAX: 0000000000000000 RBX: ffff880231ea5580 RCX: 0000000000000002
>> [22946.948592] RDX: 0000000000000000 RSI: 00000000fffebda0 RDI: ffff880231e7d098
>> [22946.951855] RBP: ffff88023bd83de0 R08: 0000000000000000 R09: 0000000000000000
>> [22946.955131] R10: 00000000563f08fc R11: 000000001849050d R12: ffff880231e7d098
>> [22946.958423] R13: ffff8800bacbbc20 R14: 00000000fffebda0 R15: 0000000000000000
>> [22946.961723] FS:  0000000000000000(0000) GS:ffff88023bd80000(0000)
>> knlGS:0000000000000000
>> [22946.965051] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [22946.968387] CR2: 00000000e4d9c0e0 CR3: 0000000001a0c000 CR4: 00000000000006e0
>> [22946.971760] Stack:
>> [22946.975131]  ffff8800bacbbc60 0000000000000000 ffff880231ea5580
>> ffff880231ea5580
>> [22946.978598]  ffff8800bacbbc20 0000000000000010 0000000000000000
>> ffff88023bd83df0
>> [22946.982064]  ffffffff813cad22 ffff88023bd83e48 ffffffffc01090c2
>> 0000000000000282
>> [22946.985546] Call Trace:
>> [22946.988984]  <IRQ>
>> [22946.989016]  [<ffffffff813cad22>] intel_unmap_sg+0x12/0x20
>> [22946.995844]  [<ffffffffc01090c2>] sdhci_finish_data+0x142/0x340 [sdhci]
>> [22946.999296]  [<ffffffffc0109f54>] sdhci_irq+0x484/0x9b5 [sdhci]
>> [22947.002759]  [<ffffffff81078dea>] ? notifier_call_chain+0x4a/0x70
>> [22947.006222]  [<ffffffff810affa9>] handle_irq_event_percpu+0x39/0x1b0
>> [22947.009694]  [<ffffffff810b0160>] handle_irq_event+0x40/0x60
>> [22947.013160]  [<ffffffff810b2e82>] handle_fasteoi_irq+0xc2/0x180
>> [22947.016633]  [<ffffffff810070aa>] handle_irq+0x1a/0x30
>> [22947.020095]  [<ffffffff81563ed7>] do_IRQ+0x57/0xf0
>> [22947.023553]  [<ffffffff81562001>] common_interrupt+0x81/0x81
>> [22947.026992]  <EOI>
>> [22947.027023]  [<ffffffff8142736e>] ? cpuidle_enter_state+0x13e/0x2b0
>> [22947.033852]  [<ffffffff81427363>] ? cpuidle_enter_state+0x133/0x2b0
>> [22947.037286]  [<ffffffff81427517>] cpuidle_enter+0x17/0x20
>> [22947.040717]  [<ffffffff81099382>] call_cpuidle+0x32/0x60
>> [22947.044131]  [<ffffffff814274f3>] ? cpuidle_select+0x13/0x20
>> [22947.047554]  [<ffffffff8109964e>] cpu_startup_entry+0x29e/0x360
>> [22947.050969]  [<ffffffff8103539b>] start_secondary+0x15b/0x190
>> [22947.054379] Code: 01 44 29 f1 e8 12 c6 ff ff 4c 89 ee 4c 89 ff e8
>> b7 8d ff ff 4c 89 e7 e8 0f c7 ff ff 48 83 c4 10 5b 41 5c 41 5d 41 5e
>> 41 5f 5d c3 <0f> 0b 49 8b 54 24 50 48 85 d2 74 29 4c 8b 45 d0 4c 89 f1
>> 48 c7
>> [22947.058834] RIP  [<ffffffff813cacd0>] intel_unmap+0x1d0/0x210
>> [22947.062568]  RSP <ffff88023bd83da8>
>> [22947.066285] ---[ end trace 12b22e7424e94db4 ]---
>> [22947.069999] Kernel panic - not syncing: Fatal exception in interrupt
>> [22947.073803] Kernel Offset: disabled
>> [22947.077240] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>>
> 
> Hi Denis,
> 
> Thanks for reporting and sorry for the delay!
> 
> Unfortunate, this isn't really my area of expertise and I don't have
> the HW. In other words, I don't think I will be able to help much.
> 
> Instead, I am looping in Adrian Hunter, who might be able to have a
> look at this.

Have you tried bisecting to find the commit that causes this?

