From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC] i.MX25/35/SDHCI: switch off DMA usage
Date: Mon, 10 Aug 2015 14:45:06 +0200
Message-ID: <4555081.2nUx7FPr1R@ws-stein>
References: <201503271152.04348.jbe@pengutronix.de> <201504141142.00237.jbe@pengutronix.de> <20150422073258.GB25437@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59613 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751583AbbHJMpO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 08:45:14 -0400
In-Reply-To: <20150422073258.GB25437@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Juergen Borleis <jbe@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, eric@eukrea.com

Hello,

On Wednesday 22 April 2015 15:33:00, Dong Aisheng wrote:
> > On Friday 27 March 2015 12:44:03 Dong Aisheng wrote:
> > > On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> > > > DMA and the required overhead on very small data blocks seems an
> > > > expensive operation. Due to erratum ENGCM07207 for i.MX25 and i.MX35 SoCs
> > > > the support for multiblock transfers is disabled which results into a
> > > > huge amount of single 512 byte sector transfers and interrupts. This
> > > > slows down the transmission speed to below 500 kiB/s (even at 50 MHz SD
> > > > card clock). Using PIO instead of DMA to avoid ENGCM07207 happens and
> > > > re-enabling multiblock transfers again improve the transmission
> > > > capability up to about 2.5 MiB/s.
> > > >
> > > > I'm still not sure if ENGCM07207 is related to DMA only and can not
> > > > happen when PIO is used instead. Someone out there with experience
> > > > regarding this topic?
> > >
> > > The errata does not state it's related to DMA only.
> > > http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> > > I could double check with our IC guys to confirm it.
> > 
> > Gentle ping.
> > 
> 
> Hi Juergen,
> 
> Got the info from our IC guy.
> PIO mode is not related to AHB access, so AHB hang is not exist.
> But, he supposes the incorrect state machine of IP after sending CMD12 should
> also exist on PIO mode. We may still needs reset the controller after sending
> CMD12.(Reset before sending CMD12 should also work)
> 
> BTW the errata already indicates a workaround for AHB hang:
> "To abort data transfers on the AHB, software can reset the eSDHC by
> writing 1 to SYSCTL[24] (RSTA)."
> 
> So the issue could be avoided by reset controller.
> 
> And the current SDHCI driver already does reset if any error(cmd or data)
> happens, and current MMC core seems only sending stop command when meets error.
> (not sending stop during normal transfer).
> So it looks to me the issue may already be workarounded and can not
> be reproduced.
> 
> I'm not sure if anyone really meets the issue.
> 
> By googling the original post of this patch, it seems the patch
> owner also did not reproduce this issue.
> See:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-October/029818.html
> 
> I would suggest someone who has the MX35/MX25 boards, to run the test again by
> manually triggering a data error.(e.g: shorting data line to ground during
> transfer). Then to see if the controller can still work well.
> 
> If can not reproduce, then we can remove this errata and back to DMA mode.

I did some timing tests on my imx35 based board by removing the SDHCI_QUIRK_NO_MULTIBLOCK. Patches are inlined below.

Current v4.2-rc6:
# time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=100
100+0 records in
100+0 records out
real    3m 8.40s
user    0m 0.02s
sys     0m 3.67s

Current v4.2-rc6 + patch1:
# time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=100
100+0 records in
100+0 records out
real    0m 5.90s
user    0m 0.02s
sys     0m 1.43s

So apparently using multiblock transfers increases the performance considerably. I tried your suggestion to short a data line (DAT0 in my case) to GND. The transfers fail with data CRC errors. So far as expected. But after releasing short DAT0 to GND the data CRC errors remain. I can only get the transfers back to work when unplugging/pluggin the card or reboot the system. But this behavior is also the case when using SDHCI_QUIRK_NO_MULTIBLOCK, aka. the current state. I have no explanation for that. Sample error message is:
> [  297.671266] mmcblk0: error -84 transferring data, sector 506, nr 6, cmd response 0x900, card status 0x0
So card state 0x900 is fine. I also get the same when doing
# cat /sys/kernel/debug/mmc0/mmc0\:1234/status
00000900

So I cannot say anything if using multiblock transfers has any negative effect. Up to now it has the same behavior regarding data crc errors as running without multiblock.

While at it I was curious why ADMA was disabled at all. So I did another test _with_ multiblock transfer and ADMA.

Current v4.2-rc6 + patch2:
# time dd if=/dev/mmcblk0 of=/dev/null bs=1M count=100
100+0 records in
100+0 records out
real    0m 5.28s
user    0m 0.00s
sys     0m 1.26s

Everything seems ok so far. Why has ADMA been disabled at all? Checking git history this quirk was added with the initial commit 95f25efe0ce22e28d61722d655d2ef582f5f7520 (mmc: sdhci-pltfm: add -pltfm driver for imx35/51).

Any comments regarding multiblock and (not so) broken ADMA?

Best regard,
Alexander

patch1:
8<----------------------------------------------------------------------------------
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c6b9f64..bc82abe 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1065,8 +1065,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
        if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
                /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
-               host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
-                       | SDHCI_QUIRK_BROKEN_ADMA;
+               host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
        /*
         * The imx6q ROM code will change the default watermark level setting
8<----------------------------------------------------------------------------------

patch2:
8<----------------------------------------------------------------------------------
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c6b9f64..74d552c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -130,7 +130,7 @@ static struct esdhc_soc_data esdhc_imx25_data = {
 };
 
 static struct esdhc_soc_data esdhc_imx35_data = {
-       .flags = ESDHC_FLAG_ENGCM07207,
+       .flags = 0,
 };
 
 static struct esdhc_soc_data esdhc_imx51_data = {
8<----------------------------------------------------------------------------------
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

