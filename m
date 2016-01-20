From: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: RE: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
Date: Wed, 20 Jan 2016 06:02:12 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C527CE@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <20160119175757.GR19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:31840
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757970AbcATGCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 01:02:21 -0500
In-Reply-To: <20160119175757.GR19062@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, "Emil P. Lenchak" <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.ker

Hi,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 19, 2016 11:28 PM
> To: Lakshmi Sai Krishna Potthuri
> Cc: Michal Simek; Soren Brinkmann; Ulf Hansson; Kevin Hao; Emil P. Lenchak;
> Tobias Klauser; Sudeep Holla; Adrian Hunter; Jisheng Zhang; Ivan T. Ivanov;
> Scott Branden; Vincent Yang; Haibo Chen; Marek Vasut;
> ludovic.desroches@atmel.com; Rob Herring; Pawel Moll; Mark Rutland; Ian
> Campbell; Kumar Gala; Suman Tripathi; Shawn Lin;
> devicetree@vger.kernel.org; Harini Katakam; linux-mmc@vger.kernel.org;
> linux-kernel@vger.kernel.org; Lakshmi Sai Krishna Potthuri; Anirudha
> Sarangi; Punnaiah Choudary Kalluri; linux-arm-kernel@lists.infradead.org
> Subject: Re: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto
> tuning mode.
>
<snip>
> > +
> > +   /*
> > +    * As per controller erratum, program the SDCLK Frequency
> > +    * Select of clock control register with a value, say
> > +    * clock/2. Wait for the Internal clock stable and program
> > +    * the desired frequency.
> > +    */
> > +   host->ops->set_clock(host, clock/2);
>
> The comment above says "wait for the internal clock stable" - I see no wait in
> here.  Does the code actually conform with the comment?

Wait for internal clock stable is taken care of inside
set_clock()

<snip>
> > +   if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING) &&
> > +           (tuning_loop_counter >= 0) && (ctrl &
> SDHCI_CTRL_TUNED_CLK)) {
> > +           host->ops->tune_clk(host);
> > +   }
>
> Do we need this "SDHCI_QUIRK2_BROKEN_TUNING" quirk at all?  What's
> wrong
> with:
>
>       if (host->ops->tune_clk && tuning_loop_counter >= 0 &&
>           ctrl & SDHCI_CTRL_TUNED_CLK)
>               host->ops->tune_clk(host);
>
> here?
>

tune_clock is provided as part of ops and will always be present.
Other users of arasan and this driver might not have tuning broken
And won't use this manual tuning.

Regards
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

