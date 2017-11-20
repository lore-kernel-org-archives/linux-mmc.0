From: Jiri Slaby <jslaby@suse.cz>
Subject: sdhci broke in 4.14 [was: MMC fixes for v.4.14-rc4]
Date: Mon, 20 Nov 2017 14:12:05 +0100
Message-ID: <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz>
References: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43088 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdKTNMI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 08:12:08 -0500
In-Reply-To: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 10/07/2017, 09:33 AM, Ulf Hansson wrote:
> Here's a PR with a couple of MMC fixes intended for v4.14-rc4. Details about the
> highlights are as usual found in the signed tag.
...
> ----------------------------------------------------------------
> MMC core:
>  - Delete bounce buffer handling:
>    This change fixes a problem related to how bounce buffers are being
>    allocated. However, instead of trying to fix that, let's just remove
>    the mmc bounce buffer code altogether, as it has practically no use.

That is completely false, this breaks my sd card reader in 4.14 so that
the system is mostly unusable during transfers -- it is stuttering:
sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 311296 bytes)
sdhci-pci 0000:02:00.0: DMA: Out of SW-IOMMU space for 311296 bytes
sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 311296 bytes)
sdhci-pci 0000:02:00.0: DMA: Out of SW-IOMMU space for 311296 bytes
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10410 at ../drivers/mmc/host/sdhci.c:848
sdhci_send_command+0x674/0xa10 [sdhci]
Modules linked in: mmc_block tun cmac fuse rfcomm af_packet nf_log_ipv6
xt_comment nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_recen
 nls_cp437 vfat fat snd_hda_intel snd_hda_codec arc4 snd_hda_core
snd_hwdep snd_pcm_oss intel_rapl snd_pcm x86_pkg_temp_thermal intel
 ttm drm efivarfs
CPU: 0 PID: 10410 Comm: mmcqd/0 Tainted: G        W
4.14.0-1.gab9e909-default #1
Hardware name: LENOVO 23252SG/23252SG, BIOS G2ET33WW (1.13 ) 07/24/2012
task: ffff93590deac140 task.stack: ffffa036021cc000
RIP: 0010:sdhci_send_command+0x674/0xa10 [sdhci]
RSP: 0018:ffff935add803e48 EFLAGS: 00010086
RAX: 00000000ffffffe4 RBX: ffff935ade27d580 RCX: 0000000000000002
RDX: 0000000000004005 RSI: ffff9359f57fb5c0 RDI: ffff935add5620a0
RBP: ffff9359f56f8620 R08: 0000000000000020 R09: 0000000000000420
R10: 0000000000000001 R11: 0000000000000000 R12: ffff9359f56f86a0
R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff935add800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4260053010 CR3: 000000031cc09003 CR4: 00000000001606f0
Call Trace:
 <IRQ>
 ? ehci_irq+0x264/0x450 [ehci_hcd]
 sdhci_irq+0x9ae/0xb00 [sdhci]
 __handle_irq_event_percpu+0x40/0x1c0
 handle_irq_event_percpu+0x20/0x50
 handle_irq_event+0x3a/0x60
 handle_fasteoi_irq+0x8c/0x150
 handle_irq+0x19/0x30
 do_IRQ+0x41/0xc0
 common_interrupt+0x8c/0x8c
 </IRQ>
RIP: 0010:memcpy_erms+0x6/0x10
RSP: 0018:ffffa036021cfd18 EFLAGS: 00010286 ORIG_RAX: ffffffffffffff5d
RAX: ffff9359923e7000 RBX: 0000000000001e0a RCX: 0000000000012480
RDX: 0000000000019000 RSI: ffff9358951aab80 RDI: ffff9359923edb80
RBP: 0000000000000032 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000148 R12: 0000000000001e0a
R13: 0000000000000001 R14: ffff935add5620a0 R15: 0000000000000000
 swiotlb_tbl_unmap_single+0x10d/0x120
 swiotlb_unmap_sg_attrs+0x3c/0x60
 sdhci_post_req+0x4d/0x60 [sdhci]
 mmc_start_areq+0x151/0x380 [mmc_core]
 ? finish_wait+0x80/0x80
 mmc_blk_issue_rw_rq+0xbf/0x390 [mmc_block]
 mmc_blk_issue_rq+0x29a/0x810 [mmc_block]
 ? cfq_dispatch_requests+0x348/0xc00
 ? ktime_get+0x3b/0x90
 ? mmc_blk_issue_rq+0x810/0x810 [mmc_block]
 mmc_queue_thread+0xc9/0x160 [mmc_block]
 kthread+0x118/0x130
 ? kthread_create_on_node+0x40/0x40
 ? do_group_exit+0x3a/0xa0
 ret_from_fork+0x25/0x30
Code: ff ff 48 8b 43 28 48 8b 50 58 48 85 d2 75 04 48 8b 50 18 48 c7 c6
58 3e 68 c0 48 c7 c7 60 76 68 c0 e8 41 fe d9 fa e9 81 fd ff f




So the code actually was used a lot as this is a standard Thinkpad X230
laptop with:
02:00.0 System peripheral: Ricoh Co Ltd MMC/SD Host Controller (rev 07)
(prog-if 01)
        Subsystem: Lenovo Device 21fa
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f1d00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [80] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
SlotPowerLimit 10.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: sdhci-pci
lspci: Unable to load libkmod resources: error -12
00: 80 11 22 e8 06 00 10 00 07 01 80 08 10 00 00 00
10: 00 00 d0 f1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 fa 21
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 00 00



>From what I made the mmc core to output, maxsegs=1 of that beast.

The commit log also is not completely true:

    What we can however notice is that the x86 defconfigs in the
    kernel did not enable CONFIG_MMC_BLOCK_BOUNCE option, which
    means that any such laptop would have to have a custom
    configured kernel to actually take advantage of this
    bounce buffer speed-up. It simply seems like there was
    a speed optimization for the Ricoh controllers that noone
    was using. (I have not checked the distro defconfigs but
    I am pretty sure the situation is the same there.)

openSUSE always set CONFIG_MMC_BLOCK_BOUNCE=y.

Reverting the commit makes it work again.

thanks,
-- 
js
suse labs
