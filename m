From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: mmc: imx: 8-bit bus timeout (4.10-rc1)
Date: Mon, 2 Jan 2017 20:15:08 +0100
Message-ID: <20170102191508.ty7wr42pzxhhchaa@t450s.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f173.google.com ([209.85.210.173]:36792 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdABTPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2017 14:15:20 -0500
Received: by mail-wj0-f173.google.com with SMTP id c11so225336871wjx.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2017 11:15:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawnguo@kernel.org, fabio.estevam@nxp.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org

Hi Fabio, Shawn,

While I was testing some pinctrl modifications based on kernel 4.10-rc1,
I've encountered some errors with the sdhci driver:
[   13.919613] mmc2: Timeout waiting for hardware cmd interrupt.
[   13.925400] sdhci: =========== REGISTER DUMP (mmc2)===========
[   13.931260] sdhci: Sys addr: 0x3d733000 | Version:  0x00000002
[   13.937113] sdhci: Blk size: 0x00000200 | Blk cnt:  0x00000001
[   13.942965] sdhci: Argument: 0x00010000 | Trn mode: 0x00000013
[   13.948817] sdhci: Present:  0x01fd8009 | Host ctl: 0x00000031
[   13.954668] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
[   13.960518] sdhci: Wake-up:  0x00000008 | Clock:    0x0000001f
[   13.966369] sdhci: Timeout:  0x0000008f | Int stat: 0x00000000
[   13.972221] sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
[   13.978071] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
[   13.983922] sdhci: Caps:     0x07eb0000 | Caps_1:   0x0000a007
[   13.989773] sdhci: Cmd:      0x00000d1a | Max curr: 0x00ffffff
[   13.995623] sdhci: Host ctl2: 0x00000000
[   13.999563] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0xefc7d208
[   14.005406] sdhci: ===========================================
...

This goes on until it finally says:
[  169.532125] mmc2: switch to bus width 8 ddr failed
[  169.536970] mmc2: error -110 whilst initialising MMC card

This issue was seen on a Nitrogen6_MAX and only affects the eMMC (8-bit
bus) whereas the regular SD card slot works fine.

Have you seen such behavior? Is the eMMC on the SABRE platform working
fine?

Regards,
Gary
