From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Mon, 22 Jul 2019 20:10:17 +0200
Message-ID: <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Matthias Brugger <mbrugger@suse.com>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Nicolas,

[add Christoph]

Am 22.07.19 um 15:18 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
> I rebased your bcm2711-initial branch on top of v5.3-rc1 and got this:
>
> [    2.307920] mmc1: new ultra high speed DDR50 SDHC card at address 59b4
> [    2.314972] mmcblk1: mmc1:59b4 USD   15.0 GiB
> [    2.320240]  mmcblk1: p1 p2
> [    2.324366] mmc0: new high speed SDIO card at address 0001
> [    2.365315] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data mode. Opts: (null)
> [    2.373579] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
> [    2.381220] devtmpfs: mounted
> [    2.386618] Freeing unused kernel memory: 2048K
> [    2.394373] Run /sbin/init as init process
> [    2.644330] 8<--- cut here ---
> [    2.647439] Unable to handle kernel paging request at virtual address bb000000
> [    2.654795] pgd = (ptrval)
> [    2.657540] [bb000000] *pgd=00000000
> [    2.661172] Internal error: Oops: 2805 [#1] SMP ARM
> [    2.666122] Modules linked in:
> [    2.669225] CPU: 0 PID: 86 Comm: kworker/0:1H Not tainted 5.3.0-rc1-00020-g496d90bc72a9 #374
> [    2.677792] Hardware name: BCM2835
> [    2.681254] Workqueue: mmc_complete mmc_blk_mq_complete_work
> [    2.687002] PC is at v7_dma_inv_range+0x3c/0x54
> [    2.691602] LR is at __dma_page_dev_to_cpu+0x84/0x104
> [    2.696728] pc : [<c031cfec>]    lr : [<c0317468>]    psr: 80000013
> [    2.703089] sp : e8081e60  ip : ea059000  fp : 00000000
> [    2.708390] r10: 00000002  r9 : 00000002  r8 : e9fb9000
> [    2.713692] r7 : c1708cc4  r6 : c18cde80  r5 : 00001000  r4 : 00000000
> [    2.720316] r3 : 0000003f  r2 : 00000040  r1 : bb001000  r0 : bb000000
> [    2.726942] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    2.734185] Control: 10c5383d  Table: 0020406a  DAC: 00000051
> [    2.740017] Process kworker/0:1H (pid: 86, stack limit = 0x(ptrval))
> [    2.746466] Stack: (0xe8081e60 to 0xe8082000)
> [    2.750891] 1e60: c031d084 ea004480 e928f300 e8053014 00000002 c0319350 c0f015d0 e9196c10
> [    2.759197] 1e80: 00000002 c0317ac4 00000000 c124fc74 0000757d e97fb390 c0317a6c c1704c48
> [    2.767503] 1ea0: e92a60c4 00000000 e97fb2b0 e9782800 e9783800 c0cce770 00000000 ea004480
> [    2.775809] 1ec0: e928f300 e92a6008 e97fb200 c0cc8c68 e92a6008 e97fb200 c1704c48 e92a60c4
> [    2.784115] 1ee0: 00000000 c0cc9040 00000000 e4380000 00000000 ada3354f 28989000 e92a60d8
> [    2.792420] 1f00: e9286080 ea004280 ff7b0200 00000000 c1891c70 00000000 ea004280 c0360eb8
> [    2.800726] 1f20: ffffe000 ea004280 c1703d00 e9286080 ea004280 e9286094 c1703d00 ea004298
> [    2.809032] 1f40: ffffe000 00000008 ea004280 c0361bb4 ffffe000 c18915ac c124ea98 00000000
> [    2.817338] 1f60: ffffe000 e91fc380 e92d3b00 00000000 e8080000 e9286080 c0361b70 e90bfea4
> [    2.825643] 1f80: e91fc39c c0366dac 00000001 e92d3b00 c0366c64 00000000 00000000 00000000
> [    2.833948] 1fa0: 00000000 00000000 00000000 c03010e8 00000000 00000000 00000000 00000000
> [    2.842253] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.850559] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    2.858872] [<c031cfec>] (v7_dma_inv_range) from [<c0317468>] (__dma_page_dev_to_cpu+0x84/0x104)
> [    2.867797] [<c0317468>] (__dma_page_dev_to_cpu) from [<c0317ac4>] (arm_dma_unmap_sg+0x58/0x74)
> [    2.876635] [<c0317ac4>] (arm_dma_unmap_sg) from [<c0cce770>] (sdhci_post_req+0x5c/0x8c)
> [    2.884857] [<c0cce770>] (sdhci_post_req) from [<c0cc8c68>] (mmc_blk_mq_post_req+0x30/0xb4)
> [    2.893340] [<c0cc8c68>] (mmc_blk_mq_post_req) from [<c0cc9040>] (mmc_blk_mq_complete_prev_req.part.4+0x174/0x238)
> [    2.903855] [<c0cc9040>] (mmc_blk_mq_complete_prev_req.part.4) from [<c0360eb8>] (process_one_work+0x218/0x510)
> [    2.914104] [<c0360eb8>] (process_one_work) from [<c0361bb4>] (worker_thread+0x44/0x5c0)
> [    2.922323] [<c0361bb4>] (worker_thread) from [<c0366dac>] (kthread+0x148/0x150)
> [    2.929836] [<c0366dac>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    2.937168] Exception stack(0xe8081fb0 to 0xe8081ff8)
> [    2.942296] 1fa0:                                     00000000 00000000 00000000 00000000
> [    2.950601] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.958906] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.965623] Code: e1110003 e1c11003 1e071f3e e1500001 (3e070f36)
> [    2.971830] ---[ end trace 918fd7aaa4c1e4cc ]---
>
> I'm looking into it. Any ideas?

i rebased this series also and got this only on the RPi 4.

After reverting the following:

79a986721de dma-mapping: remove dma_max_pfn
7559d612dff0 mmc: core: let the dma map ops handle bouncing

This crash disappear, but wifi seems to be still broken.

Would be nice, if you can investigate further.

Regards
Stefan

>
> Regards,
> Nicolas
>
