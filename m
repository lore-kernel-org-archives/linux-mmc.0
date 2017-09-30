From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
Date: Sat, 30 Sep 2017 10:56:38 +0800
Message-ID: <20170930105638.145dcb1e@xhacker.debian>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
        <CAG18LKhU0Ecjmh=7_YAM8pOpO295Fu1NXy2mL46KwxkVmQ9O2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:58828
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752578AbdI3C5F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Sep 2017 22:57:05 -0400
In-Reply-To: <CAG18LKhU0Ecjmh=7_YAM8pOpO295Fu1NXy2mL46KwxkVmQ9O2A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <davidhuzj@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Stable <sta>

Hi Ziji,

On Sat, 30 Sep 2017 10:47:39 +0800 Ziji Hu wrote:

> Hi Gregory,
> 
> 2017-09-28 23:05 GMT+08:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> > On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> > is optional because not all the SoCs need them but at least for Armada
> > 7K/8K it is actually mandatory.
> >
> > The binding documentation is updating accordingly.
> >
> > Without this patch the kernel hand during boot if the mvpp2.2 network
> > driver was not present in the kernel. Indeed the clock needed by the
> > xenon controller was set by the network driver.
> >
> > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core
> > functionality)"
> > CC: Stable <stable@vger.kernel.org>
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> > Hi Ulf and Adrian,
> >
> > This patch should be merged in 4.14-rc, as it fixes real issues.
> >
> > This patch maye looks like just as a nice clean-up but it is not. On
> > the earlier version of the series adding the support for the xenon
> > controller there was already this axi bus clock. But at this moment
> > the documentation for the clock on the Armada 7K/8K was missing and
> > there was no driver for it, so we just use the clock set by the
> > bootloader and never change them that's why it worked without any
> > visible problem.
> >
> > Then as explained in the commit log the network driver enabled the
> > clock for us, and it happened that it was setup before the xenon
> > driver. It is only thanks the new information we received on the
> > clocks of the Sov and with more exhaustive testes that we found this
> > issue and the fix for it.  
> 
>     I know very little about clk in Linux.
>     But I just happened to review this very issue before I left Marvell.
>     I had some concerns about this patch at that time.
>     Please check the following.
> 
>     1. If that network device is used again, so that clock will be setup *twice*
>     since there are two duplicated clock setup in that network driver
> and Xenon driver. Right?

The first "setup" will be executed, the second one just increase the enable
and prepare count.

>     2. If that network device is used again and Xenon later exists and
> shutdown the clock,
>     will that network device be corrupted?

No. The enable and prepare count is reduced to 1, nothing else could happen.
The clock won't be shutdown until there's no users.

>     3. In my very own opinion, such a shared AXI bus clock might be
> controlled in u-boot or
>     a "SoC-level" init routine.

IMHO, it's the driver's responsibility to manage its own clocks.

Thanks

