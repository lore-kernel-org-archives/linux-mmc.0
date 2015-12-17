From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: BUG: SDHCI fails to DMA-unmap, and other warnings
Date: Thu, 17 Dec 2015 21:51:40 +0000
Message-ID: <20151217215140.GK8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59275 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbbLQVvu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 16:51:50 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Haijun Zhang <Haijun.Zhang@freescale.com>

Firstly, with a UHS-1 card on iMX6 (so sdhci-esdhc-imx):

WARNING: CPU: 1 PID: 93 at lib/dma-debug.c:509 add_dma_entry+0xfc/0x13c()
DMA-API: exceeded 7 overlapping mappings of cacheline 0x00f99290
Modules linked in: snd_soc_imx_sgtl5000 snd_soc_fsl_asoc_card hid_cypress snd_soc_imx_spdif snd_soc_sgtl5000 snd_soc_imx_audmux cec_dev imx_sdma rc_cec caam imx2_wdt snd_soc_fsl_spdif(+) snd_soc_fsl_ssi coda v4l2_mem2mem imx_pcm_dma videobuf2_dma_contig videobuf2_vmalloc dw_hdmi_cec videobuf2_memops imx_thermal dw_hdmi_ahb_audio cec etnaviv(C) fuse rc_pinnacle_pctv_hd
CPU: 1 PID: 93 Comm: mmcqd/0 Tainted: G         C      4.4.0-rc5+ #1934
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
[<c00138a4>] (dump_backtrace) from [<c0013a40>] (show_stack+0x18/0x1c)
 r6:c033cb44 r5:000001fd r4:00000000 r3:00000000
[<c0013a28>] (show_stack) from [<c0313220>] (dump_stack+0x7c/0x98)
[<c03131a4>] (dump_stack) from [<c002d8f4>] (warn_slowpath_common+0x80/0xbc)
 r4:ee715a48 r3:ee718b80
[<c002d874>] (warn_slowpath_common) from [<c002d9d4>] (warn_slowpath_fmt+0x38/0x40)
 r8:efdc3940 r7:3e64a400 r6:20010093 r5:00f99290 r4:c09fce77
[<c002d9a0>] (warn_slowpath_fmt) from [<c033cb44>] (add_dma_entry+0xfc/0x13c)
 r3:00000007 r2:c086cc50
[<c033ca48>] (add_dma_entry) from [<c033ce94>] (debug_dma_map_page+0x128/0x164)
 r6:00000000 r5:ef1e1c10 r4:ef236800
[<c033cd6c>] (debug_dma_map_page) from [<c052ae90>] (sdhci_send_command+0x300/0xe44)
 r10:c13bc880 r9:ee715bf8 r8:ef1e1c10 r7:ee715bc4 r6:3e64a400 r5:00000400
 r4:ee6a0440 r3:00000200
[<c052ab90>] (sdhci_send_command) from [<c052c10c>] (sdhci_request+0x90/0x104)
 r10:00000001 r9:ee715e7c r8:00010013 r7:ee6a0440 r6:ee715c2c r5:ee6a05b8
 r4:ee6a0000
[<c052c07c>] (sdhci_request) from [<c05142e0>] (__mmc_start_request+0x48/0xd8)
 r10:ee991e40 r8:c07217dc r7:ee715c2c r6:ee715c2c r5:ee6a0000 r4:ee715c2c
[<c0514298>] (__mmc_start_request) from [<c0514470>] (mmc_start_request+0x100/0x130)
 r7:ee715c3c r6:ee715c2c r5:ee6a0000 r4:ee715c2c
[<c0514370>] (mmc_start_request) from [<c05144e4>] (mmc_wait_for_req+0x44/0x15c)
 r5:ee6a0000 r4:ee6a0000
[<c05144a0>] (mmc_wait_for_req) from [<c051acc0>] (mmc_send_tuning+0x130/0x1a4)
 r8:c07217dc r7:00000200 r6:00000000 r5:00000040 r4:ee6a0000 r3:00000001
[<c051ab90>] (mmc_send_tuning) from [<c052ee64>] (esdhc_executing_tuning+0x44/0xf8)
 r10:00000001 r8:ee6a0440 r7:00000013 r6:ee6a05b8 r5:ee6a0440 r4:0000000c
[<c052ee20>] (esdhc_executing_tuning) from [<c052ba98>] (sdhci_execute_tuning+0xc4/0x6a8)
 r7:00000013 r6:ee6a05b8 r5:20000013 r4:ee6a0000
[<c052b9d4>] (sdhci_execute_tuning) from [<c0515a30>] (mmc_execute_tuning+0x38/0x78)
 r10:00000001 r9:ee715e7c r8:ee710ad0 r7:ee7109a8 r6:00000000 r5:ee6a0000
 r4:ee6a0000
[<c05159f8>] (mmc_execute_tuning) from [<c0517e5c>] (mmc_retune+0x74/0xd0)
 r5:ee6a0000 r4:ee6a0000
[<c0517de8>] (mmc_retune) from [<c05142b0>] (__mmc_start_request+0x18/0xd8)
 r4:ee7109a8 r3:c0527808
[<c0514298>] (__mmc_start_request) from [<c0514470>] (mmc_start_request+0x100/0x130)
 r7:ee7109a8 r6:00000000 r5:ee6a0000 r4:ee7109a8
[<c0514370>] (mmc_start_request) from [<c0514ddc>] (mmc_start_req+0x298/0x3a8)
 r5:00000000 r4:ee6a0000
[<c0514b44>] (mmc_start_req) from [<c0523e74>] (mmc_blk_issue_rw_rq+0xd0/0xb30)
 r10:ee6a1000 r9:ee7109a8 r8:ee710824 r7:ee710800 r6:ee6a1000 r5:ee6a1000
 r4:00000000
[<c0523da4>] (mmc_blk_issue_rw_rq) from [<c05249d8>] (mmc_blk_issue_rq+0x104/0x49c)
 r10:00000001 r9:24590000 r8:ee710800 r7:ee710800 r6:ee737b60 r5:ee6a1000
 r4:ee710824
[<c05248d4>] (mmc_blk_issue_rq) from [<c05265dc>] (mmc_queue_thread+0xbc/0x160)
 r10:00000001 r9:ee71082c r8:24590000 r7:00000000 r6:ee5aec60 r5:ee737b60
 r4:ee710824
[<c0526520>] (mmc_queue_thread) from [<c004da9c>] (kthread+0xe0/0xfc)
 r10:00000000 r9:00000000 r8:00000000 r7:c0526520 r6:ee710824 r5:00000000
 r4:ee67ed80 r3:00000000
[<c004d9bc>] (kthread) from [<c000fcf0>] (ret_from_fork+0x14/0x24)
 r7:00000000 r6:00000000 r5:c004d9bc r4:ee67ed80
---[ end trace 41e5fc6596fc8196 ]---

Secondly, my logs are spammed with this at _info_ level:

/soc/aips-bus@02100000/usdhc@02190000: voltage-ranges unspecified

which is really interesting, because the binding document says that
"voltage-ranges" is optional.  If it's optional, then we shouldn't
be spamming the kernel log 24+ times during boot with this.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
