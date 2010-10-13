From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Wed, 13 Oct 2010 18:22:14 +0800
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-6-git-send-email-w.sang@pengutronix.de> <1286817032-21219-1-git-send-email-w.sang@pengutronix.de> <20101011183300.GC21335@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:18092
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab0JMKWL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Oct 2010 06:22:11 -0400
Received: from mail60-am1 (localhost.localdomain [127.0.0.1])	by
 mail60-am1-R.bigfish.com (Postfix) with ESMTP id DC09B10383B9	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 10:22:08 +0000 (UTC)
Received: from am1ehsmhs011.bigfish.com (unknown [10.3.201.248])	by
 mail60-am1.bigfish.com (Postfix) with ESMTP id 69416E7005C	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 10:22:08 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id o9DAMMIq000774	for
 <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 03:22:22 -0700 (MST)
Received: from zch01exm22.fsl.freescale.net (zch01exm22.ap.freescale.net
 [10.192.129.206])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o9DAcIts027278	for <linux-mmc@vger.kernel.org>; Wed, 13 Oct 2010 05:38:19
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20101011183300.GC21335@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram:
It's better that the mdelay(100) is replaced by some litter value such
as 10ms and so on,
 since I encounter one bug ever when this values is set to 100. The
audio playback would
 be noised by the sd/mmc insertion/extraction operations.

Best Regards
Richard Zhu



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, October 12, 2010 2:33 AM
> To: Wolfram Sang
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
Zhu
> Richard-R65037
> Subject: Re: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common
stuff
> 
> Hi Wolfram,
> 
> On Mon, Oct 11, 2010 at 07:10:32PM +0200, Wolfram Sang wrote:
> > +static inline void esdhc_set_clock(struct sdhci_host *host,
unsigned
> > +int clock) {
> > +	int pre_div = 2;
> > +	int div = 1;
> > +	u32 temp;
> > +
> > +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> > +	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
ESDHC_CLOCK_PEREN
> > +		| ESDHC_CLOCK_MASK);
> > +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > +
> > +	if (clock == 0)
> > +		goto out;
> > +
> > +	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> > +		pre_div *= 2;
> > +
> > +	while (host->max_clk / pre_div / div > clock && div < 16)
> > +		div++;
> > +
> > +	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual:
%d\n",
> > +		clock, host->max_clk / pre_div / div);
> > +
> > +	pre_div >>= 1;
> > +	div--;
> > +
> > +	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> > +	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
ESDHC_CLOCK_PEREN
> > +		| (div << ESDHC_DIVIDER_SHIFT)
> > +		| (pre_div << ESDHC_PREDIV_SHIFT));
> > +	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > +	mdelay(100);
> 
> This isn't directly related to this patchset (the code was there
> beforehand), but it would be nice to rework the mdelay(100).
> 
> Thanks,
> 
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


