From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as the
 general APIs
Date: Fri, 25 Mar 2011 09:05:51 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900D45DB@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1301024346-2232-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1301024346-2232-3-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110325085329.GA3302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.181]:10742
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599Ab1CYJF6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Mar 2011 05:05:58 -0400
In-Reply-To: <20110325085329.GA3302@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Wolfram:
Got that.
Thanks for your reminder.
Would follow your advice in future.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Friday, March 25, 2011 4:53 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; eric.miao@linaro.org
> Subject: Re: [PATCH V8 3/4] mmc: sdhci-esdhc: make the writel/readl as
> the general APIs
>
> On Fri, Mar 25, 2011 at 11:39:05AM +0800, Richard Zhu wrote:
> > Add one flag to indicate the GPIO CD/WP is enabled or not on imx
> > platforms, and reuse the writel/readl as the general APIs for imx
> > SOCs.
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
>
> Please provide something like "changes since last time" _below_ this
> dashed line "---" next time. Or use --cover-letter to introduce the
> changes.
>
> Other than that
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

