From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: imx6 emmc issue
Date: Thu, 21 Nov 2013 20:57:01 +0800
Message-ID: <CAA+hA=R603Pj346PAA=t=w23siNTrW=-0vxFk3k8F3MkCTnKqw@mail.gmail.com>
References: <528CDDEA.1040500@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:55861 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab3KUM5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2013 07:57:02 -0500
Received: by mail-qc0-f176.google.com with SMTP id n9so1140422qcw.35
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2013 04:57:01 -0800 (PST)
In-Reply-To: <528CDDEA.1040500@alcatel-lucent.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ed Sutter <ed.sutter@alcatel-lucent.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ed,

On Thu, Nov 21, 2013 at 12:06 AM, Ed Sutter
<ed.sutter@alcatel-lucent.com> wrote:
> Dong,
> Hello, I am currently working on an Freescale iMX6 SABRE Board platform
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=RDIMX6SABREBRD
>
> I'm trying to run with mainline kernel/uboot/buildroot just to be a bit more
> up-to-date than the LTIB distribution.  I am trying to setup a ROOTFS
> directly
> on the eMMC device.  Referring to this thread on the freescale forum:
>
> https://community.freescale.com/message/363870?et=watches.email.thread#363870
>
> I'm working with linux-3.12 and patch-v3.12-next-20131119 and I've applied
> these
> additional patches: http://comments.gmane.org/gmane.linux.kernel.mmc/23339
>
> I am able to access the emmc device from linux when using fdisk; however,
> when I attempt to run "mkfs.ext3 /dev/mmcblk0p1" the "Discarding device
> blocks"
> step takes over an hour (80 minutes last time I tried it).
>
> Fabio Estevam (from freescale) suggested I report this to you.
> Are you aware of this issue?  Are you aware of anyone that's actually tried
> to do mkfs.ext3 on emmc with a recent kernel version for this board/SOC?
>

Yes, i know about this issue.
It seems to be caused by eMMC discard feature.
root@imx6qdlsolo:/sys/block/mmcblk1/queue# cat discard_max_bytes
512
root@imx6qdlsolo:/sys/block/mmcblk1/queue# cat discard_zeroes_data
1
root@imx6qdlsolo:/sys/block/mmcblk1/queue# cat discard_granularity
0

The discard_max_bytes is to small.
When we do mkfs.ext3 it will ease the whole eMMC card with one block each time
which will cause huge time and looks like it hanged.

>From the command arg in CMD35 and CMD36, they means the erase range,
from and to.
It only eases one block one time (see log at last).

I still do not have time to check this issue detailedly, but quick
looking the code, it seems the
discard_max_bytes calculation is related to mmc->max_discard_to which
is based on
host->timeout_clk as

if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
        host->timeout_clk = mmc->f_max / 1000;
mmc->max_discard_to = (1 << 27) / host->timeout_clk;

For uSDHC, and f_max is 198Mhz and then the max_discard_to will be
small, only 677 ms.

Currently i'm not sure if this is a common code issue or host driver issue.
Will look into it later when i've time.

If anyone else know about this issue, please let us know.

BTW, a quick workaround for this issue is do not use discard feature
for eMMC devices by:
mkfs.ext3 -E nodiscard, then it becomes very quick.

root@imx6qdlsolo:~# mkfs.ext3 -E nodiscard
/dev/mmcblk1p1/dev/mmcblk1p1/dev/mmcblk1p1
mke2fs 1.42.8 (20-Jun-2013)
mmc2: starting CMD35 arg 00000800 flags 00000095
sdhci-esdhc-imx 219c000.usdhc: desired SD clock: 52000000, actual: 49500000
sdhci-esdhc-imx 219c000.usdhc: change pinctrl state for uhs 7
sdhci-esdhc-imx 219c000.usdhc: desired SD clock: 52000000, actual: 49500000
sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
mmc2: req done (CMD35): 0: 00000900 00000000 00000000 00000000
mmc2: starting CMD36 arg 00000800 flags 00000095
sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
mmc2: req done (CMD36): 0: 00000900 00000000 00000000 00000000
mmc2: starting CMD38 arg 00000001 flags 0000049d
sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
mmc2: req done (CMD38): 0: 00000800 00000000 00000000 00000000
mmc2: starting CMD13 arg 00010000 flags 00000015
sdhci [sdhci_irq()]: *** mmc2 got interrupt: 0x00000001
mmc2: req done (CMD13): 0: 00000900 00000000 00000000 00000000
................

Regards
Dong Aisheng

> Thanks in advance,
> Ed Sutter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
