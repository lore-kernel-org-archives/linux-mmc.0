From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on platform sdhci api
Date: Thu, 9 Sep 2010 16:51:43 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0789F0@zch01exm22.fsl.freescale.net>
References: <1283334533-12793-1-git-send-email-r65037@freescale.com> <20100906104729.GB2617@pengutronix.de> <A88EF4D64D8447468743DC1503C0B6CA0787D4@zch01exm22.fsl.freescale.net> <20100907102817.GA7534@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:34977
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895Ab0IIIwI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Sep 2010 04:52:08 -0400
Received: from mail68-db3 (localhost.localdomain [127.0.0.1])	by
 mail68-db3-R.bigfish.com (Postfix) with ESMTP id 4274316D0290	for
 <linux-mmc@vger.kernel.org>; Thu,  9 Sep 2010 08:52:04 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.241])	by
 mail68-db3.bigfish.com (Postfix) with ESMTP id 96ADF6A004B	for
 <linux-mmc@vger.kernel.org>; Thu,  9 Sep 2010 08:52:02 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o898pkwW023165	for
 <linux-mmc@vger.kernel.org>; Thu, 9 Sep 2010 01:51:57 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8995kaq004549	for <linux-mmc@vger.kernel.org>; Thu, 9 Sep 2010 04:05:47
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100907102817.GA7534@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hi Wolfram:
See my comments.

Best Regards,
Richard Zhu
Freescale Semiconductor


-----Original Message-----
From: Wolfram Sang [mailto:w.sang@pengutronix.de] 
Sent: Tuesday, 7 September, 2010 18:28
To: Zhu Richard-R65037
Cc: linux-mmc@vger.kernel.org; kernel@pengutronix.de;
linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] esdhc-4 esdhc: fsl esdhc driver based on
platform sdhci api

Hi Richard,

for easier reading, I removed the parts of the code we were not talking
about.

> > +static unsigned int sdhci_fsl_get_ro(struct sdhci_host *host) {
> > +	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
> > +
> > +	return fsl_host->pdata->wp_status(host->mmc->parent);
> > +}
> 
> Is there really no way to route the WP-GPIO to the SD_WP pin of the 
> controller (sigh)? Still, I'd think we can be more abstract by using 
> the gpiolib and just pass the gpio number in the platform-data?
> [<Zhu Richard-r65037>] Up to now, refer to the limitations of the HW 
> design on the different boards, the WP-GPIO mechanism is used.
> About the more abstract method by passing the GPIO number in the 
> platform-data.
> Do you means that just pass the GPIO number in the sdhci_pltfm_data 
> defined in sdhci_pltfm_data.h file?

Yes, sdhci_pltfm.h would need such a member.

> I don't think we can do that, because the WP-GPIO pins maybe different

> refer to different boards.

Sure, the original information which GPIO the current board uses must
come from some kind of platform_data-struct special to the board in
question. The main thing I was after is that a gpio-number might be
enough for that, no need for a function pointer. The handling of that
GPIO could then be taken into sdhci-esdhc.c (should be generic, request
it and set it to input).
[<Zhu Richard-r65037>] Agree, we can just handle the gpio-number,
otherwise one func pointer.
BTW, Do you know that how to define and pass the kinds of
platform_data-struct special to the board to the sdhci_pltfm.c layer
platform-data struct?

> > +
> > +static void sdhci_fsl_set_clock(struct sdhci_host *host, unsigned 
> > +int
> 
> > +clock) {
> > +	/*This variable holds the value of clock divider, prescaler */
> > +	int div = 0, prescaler = 1;
> > +	int clk_rate = 0;
> > +	u32 clk;
> > +	unsigned long timeout;
> > +	struct sdhci_fsl_host *fsl_host = sdhci_priv(host);
> > +
> > +	if (clock == 0) {
> > +		host->clock = 0;
> > +		clk = readl(host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +		writel(clk & (~FSL_SDHCI_CLOCK_HLK_EN),
> > +				host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +		return;
> > +	}
> > +
> > +	clk_rate = clk_get_rate(fsl_host->clk_input);
> > +	clk = readl(host->ioaddr + SDHCI_CLOCK_CONTROL) &
> ~FSL_SDHCI_CLOCK_MASK;
> > +	/* precaler can't be set to zero in CLK_CTL reg */
> > +	clk |= (prescaler << 8);
> > +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +
> > +	if (clock == sdhci_fsl_get_min_clock(host))
> > +		prescaler = 0x10;
> > +
> > +	while (prescaler <= 0x80) {
> > +		for (div = 0; div <= 0xF; div++) {
> > +			int x;
> > +			if (prescaler != 0)
> > +				x = (clk_rate / (div + 1)) / (prescaler
> * 2);
> > +			else
> > +				x = clk_rate / (div + 1);
> > +
> > +			dev_dbg(&fsl_host->pdev->dev, "x=%d, clock=%d
> %d\n",
> > +					x, clock, div);
> > +			if (x <= clock)
> > +				break;
> > +		}
> > +		if (div < 0x10)
> > +			break;
> > +
> > +		prescaler <<= 1;
> > +	}
> > +	dev_dbg(&fsl_host->pdev->dev, "prescaler = 0x%x, divider =
> 0x%x\n",
> > +			prescaler, div);
> > +	clk |= (prescaler << 8) | (div << 4);
> > +
> > +	/* Configure the clock control register */
> > +	clk |= readl(host->ioaddr + SDHCI_CLOCK_CONTROL)
> > +		& (~FSL_SDHCI_CLOCK_MASK);
> > +	clk |= FSL_SDHCI_CLOCK_HLK_EN;
> > +	writel(clk, host->ioaddr + SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Wait max 10 ms */
> > +	timeout = 5000;
> > +	while (timeout > 0) {
> > +		timeout--;
> > +		udelay(20);
> > +	}
> > +	writel(clk | FSL_SDHCI_CLOCK_SD_EN, host->ioaddr + 
> > +SDHCI_CLOCK_CONTROL);
> > +
> > +	host->clock = (clk_rate / (div + 1)) / (prescaler * 2); }
> 
> Do you know if there is an improvement over the set_clock-routine in 
> sdhic-of-esdhc.c?
> [<Zhu Richard-r65037>] Accepted.

Does that mean there is one or there is none? :)
[<Zhu Richard-r65037>] The one used in sdhci-of-esdhc.c is better than
the one listed abov; it's more logical and clear. :)

> > +
> > +static void sdhci_fsl_set_bus(struct sdhci_host *host, unsigned int
> > +bus_width) {
> > +	u32 ctrl;
> > +
> > +	ctrl = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> > +
> > +	if (bus_width == MMC_BUS_WIDTH_4) {
> > +		ctrl &= ~FSL_SDHCI_CTRL_8BITBUS;
> > +		ctrl |= SDHCI_CTRL_4BITBUS;
> > +	} else if (bus_width == MMC_BUS_WIDTH_8) {
> > +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> > +		ctrl |= FSL_SDHCI_CTRL_8BITBUS;
> > +	} else if (bus_width == MMC_BUS_WIDTH_1) {
> > +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> > +		ctrl &= ~FSL_SDHCI_CTRL_8BITBUS;
> > +	}
> 
> I'd be careful with the 8Bit-mode for now. We need some to deal with 
> it correctly in sdhci.c first.
> [<Zhu Richard-r65037>] Are there some problems in the 8bits bus_width 
> in sdhci.c file?
> I find that the sdhci.c had been support the 8bits bus_width.

Yes, it was added recently, but it might have issues. See here:

http://thread.gmane.org/gmane.linux.kernel.mmc/3370
[<Zhu Richard-r65037>] Different IC design may have the different
definitions of the bus width configuration in the HOST_CONTROL register.
This is not a big issue; we can handle these differences in the SW.
About the 8bits supports, I had been verified this feature on i.MX
platforms for a while.
The MMC cards 8bits mode can work well on some i.MX eSDHC platforms.
One more suggestion, the caps should be handled carefully, because not
only the caps of the IC design, but also the caps of the board HW design
should be taken care,
So the board special platform-data should have the caps flag that
indicated the max width that the board can support and so on.

> > +	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
> 
> Why did you add all the DMA-stuff and mark it as broken then?
> Is there a problem with the engine?
> [<Zhu Richard-r65037>] The ADMA is broken, and I still can't find the 
> root cause.
> I would enable the ADMA feature later.
> Up to now, the Simple DMA and PIO mode are enabled.

Ok, thanks. Better to leave all ADMA stuff out for now, then.

Did you have the chance to test/review my RFC yet?
[<Zhu Richard-r65037>] I'm checking it, and still trying finding a way
to pass the board related info (such as the WP pins, and bus width to
sdhci-platfm.c layer)
The host->ops->get_ro should be added into the sdhci.c file although
following the method provided in the RFC patches. How do you think about
that?
Like the following codes:
@@ -1208,6 +1208,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)

         host = mmc_priv(mmc);

 +       if (host->ops->get_ro)
 +               return host->ops->get_ro(host);
 +

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang
|
Industrial Linux Solutions                 | http://www.pengutronix.de/
|

