From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: 2.6.39-rc7 and pxa168 MMC using sdhci-pxa
Date: Sat, 21 May 2011 18:26:44 +0800
Message-ID: <BANLkTi=HnZZMJqqdg5L=RwbBJjOujRgk8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64710 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1EUK0p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 May 2011 06:26:45 -0400
Received: by bwz15 with SMTP id 15so3540476bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 21 May 2011 03:26:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@marvell.com, prakity@marvell.com
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org

Hi Zhangfei, Philip, arm/mmc friends,

I have a quick question. I am using a pxa168 board that currently runs
2.6.28. Like several other people, I am having performance problems
with the MMC support on this. [1] That is, I was getting "pxa-sdh
pxa-sdh.0: DATA Line Error(status: 0x0010)!" every time that I read
more than an MB or so of data off the MMC card.

Since it is embarrassing to mention I'm using 2.6.28, I felt I should
try to bringup mainline on this board. I pulled down 2.6.39-rc7. First
thing that I noticed is that none of the pxa168 boards in
arch/arm/mach-mmp/ such as aspenite, avlite, zylonite seem to
implement MMC support. pxa168.h doesn't have any device entries for
sdh. Am I right in thinking that's a bit weird given that this
platform is quite old? Anyway, so I added the PXA168_DEVICE entries,
APMU_CLK, CLKREG for sdh0,1,2,3 to pxa168.c/h. I assume that the
appropriate driver to use is sdhci-pxa and not pxamci. Did that, and
then tried to boot, and I get:

[    0.543587] mmc0: SDHCI controller on MMC [sdhci-pxa.0] using DMA
[    0.665327] mmc0: new SD card at address df08
[    0.670686] mmcblk0: mmc0:df08 SU02G 1.84 GiB (ro)
[   10.686427] mmc0: Timeout waiting for hardware interrupt.
[   10.692391] mmcblk0: retrying using single block read
[   10.701043]  mmcblk0: p1 p2 p3
[   10.706259] VFS: Cannot open root device "mmcblk0p3" or unknown-block(179,3)
[   10.706484] Please append a correct "root=" boot option; here are
the available partitions:
[   10.722024] b300         1931264 mmcblk0  driver: mmcblk
[   10.725923]   b301          521885 mmcblk0p1
00000000-0000-0000-0000-000000000mmcblk0p1
[   10.727453]   b302            9455 mmcblk0p2
00000000-0000-0000-0000-000000000mmcblk0p2
[   10.743379]   b303           73749 mmcblk0p3
00000000-0000-0000-0000-000000000mmcblk0p3

The MMC card is fine, the same card boots fine when I switch the
kernel back to 2.6.28. I suspect "timeout waiting for hw interrupt"
above is where I should start debugging.

Quick check shows the irqs as:
arch/arm/mach-mmp/include/mach/irqs.h:#define IRQ_PXA168_SDH1			39
arch/arm/mach-mmp/include/mach/irqs.h:#define IRQ_PXA168_SDH2			40

Definitions look correct to me. Could you let me know if I've gone
down a wrong path here, did I miss why none of the other pxa168 boards
seem to have sdh setup? I would welcome any advice or suggestions
that'll help me get mainline up and running on this.

Thanks,
jaya

[1] http://plugcomputer.org/plugforum/index.php?topic=5088.0;wap2
