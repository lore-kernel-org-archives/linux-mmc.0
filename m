From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: linux 4.17, drivers/mmc/host/sdhci-pci-o2micro.c, crash with
 sdcard >128G
Date: Mon, 11 Jun 2018 14:10:03 +0300
Message-ID: <e6ab8c4a-2371-c4a4-a95e-4c72cefa8696@intel.com>
References: <CAMjKNNM=f5pKgYh+ZAB+hvxeDG5B_5PsYX8YWZMZrmF9qS2DZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMjKNNM=f5pKgYh+ZAB+hvxeDG5B_5PsYX8YWZMZrmF9qS2DZA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jean-luc malet <jeanluc.malet@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 09/06/18 11:38, jean-luc malet wrote:
> Hi everybody!
> thanks for adding support to my O2 Micro, Inc. Device 8620 in last kernel!!!
> I was looking for it since long time!!!!
> 
> # lspci -kv
> 02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog-if 01)
> Subsystem: Lenovo Device 3800
> Flags: bus master, fast devsel, latency 0, IRQ 17
> Memory at a1001000 (32-bit, non-prefetchable) [size=4K]
> Memory at a1000000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [6c] Power Management version 3
> Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
> Capabilities: [80] Express Endpoint, MSI 00
> Capabilities: [100] Virtual Channel
> Capabilities: [200] Advanced Error Reporting
> Capabilities: [230] Latency Tolerance Reporting
> Capabilities: [240] L1 PM Substates
> Kernel driver in use: sdhci-pci
> Kernel modules: sdhci_pci
> 
> it works fine with sdcard up to 128G but crash on my samsung 256G evo plus
> card
> (https://www.samsung.com/fr/memory-storage/evo-plus-microsd-card-with-sd-adapter/MB-MC256DAEU/)
> 
> insert 256G card
> #dmesg
> 
>     [94815.892525] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [94815.892627] mmc0: new ultra high speed SDR104 SDXC card at address 0001
>     [94815.893398] mmcblk0: mmc0:0001 EE8QT 239 GiB 
>     [94815.945330] mmc0: Tuning timeout, falling back to fixed sampling clock
> 
> # dd if=/dev/mmcblk0 of=test bs=512 count=1
> 
>     dd: error reading '/dev/mmcblk0': Input/output error
>     0+0 records in
>     0+0 records out
>     0 bytes copied, 42.829 s, 0.0 kB/s
> 
> #dmesg
> 
>     [94825.956285] mmc0: Timeout waiting for hardware interrupt.
>     [94825.956289] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>     [94825.956297] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000603
>     [94825.956304] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
>     [94825.956310] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
>     [94825.956316] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000017
>     [94825.956322] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>     [94825.956327] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>     [94825.956333] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>     [94825.956339] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
>     [94825.956344] mmc0: sdhci: AC12 err:  0x00000004 | Slot int: 0x00000000
>     [94825.956350] mmc0: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
>     [94825.956356] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x005800c8
>     [94825.956362] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>     [94825.956368] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00001b00
>     [94825.956371] mmc0: sdhci: Host ctl2: 0x0000800b
>     [94825.956378] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfffff208
>     [94825.956380] mmc0: sdhci: ============================================
>     [94826.007314] mmc0: Tuning timeout, falling back to fixed sampling clock
> 
> remove card
> insert 128G card (http://www.toshiba-sdcard.com/microsd/microsd_m302.html)
> #dmesg
> 
>     [95214.753428] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [95214.753530] mmc0: new ultra high speed SDR104 SDXC card at address 1234
>     [95214.754399] mmcblk0: mmc0:1234 SA128 116 GiB 
>     [95214.756474]  mmcblk0: p1
> 
> 
>     # dd if=/dev/mmcblk0 of=test bs=512 count=1
>     1+0 records in
>     1+0 records out
>     512 bytes copied, 0.00209609 s, 244 kB/s
> 
> 
> remove card 
> insert 128G card (samsung 128Gb evo U1 card)
> #dmseg
> 
>     [95438.053427] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [95438.053552] mmc0: new ultra high speed DDR50 SDXC card at address 59b4
>     [95438.054139] mmcblk0: mmc0:59b4 00000 120 GiB 
>     [95438.056451]  mmcblk0: p1
> 
> 
> # dd if=/dev/mmcblk0 of=test bs=512 count=1
> 
>     1+0 records in
>     1+0 records out
>     512 bytes copied, 0.0346192 s, 14.8 kB/s
> 
> 
> since the toshiba a 256G samsung are both U3 this seems not related to this
> since one of the samsung card works, this don't seems to be related to the
> brand....
> so this seems related to the size of the card....
> if you need more information, I'll try to provide the best accurate ones :)

Tuning fails for all the cards, it is just some of them still work with
fixed sampling.  You need to find someone who knows about the O2 Micro
controllers. but no one has touched the driver since 2015.
