From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: add gpio hard reset support
Date: Wed, 16 Aug 2017 10:22:16 +0800
Message-ID: <20170816102216.3908b2d1@xhacker>
References: <1502749156-22798-1-git-send-email-zjwu@marvell.com>
        <20170815105607.38071d88@xhacker>       <5993790D.40305@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:54250 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752641AbdHPC1S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 22:27:18 -0400
In-Reply-To: <5993790D.40305@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, zmxu@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On Tue, 15 Aug 2017 15:43:25 -0700 Zhoujie Wu  wrote:

> Hi Jisheng,
> 
> On 08/14/2017 07:56 PM, Jisheng Zhang wrote:
> > On Mon, 14 Aug 2017 15:19:16 -0700 Zhoujie Wu wrote:
> >  
> >> On some platforms, like armada3700,  SD card need to
> >> do hard reset by gpio toggling to make it work properly
> >> after warm reset the board.
> >> Add gpio hard reset feature for this purpose.
> >>
> >> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> >> ---
> >>   drivers/mmc/host/sdhci-xenon.c | 49 +++++++++++++++++++++++++++++++++++++++---
> >>   drivers/mmc/host/sdhci-xenon.h |  4 ++++
> >>   2 files changed, 50 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> >> index edd4d915..54a7057 100644
> >> --- a/drivers/mmc/host/sdhci-xenon.c
> >> +++ b/drivers/mmc/host/sdhci-xenon.c
> >> @@ -18,6 +18,8 @@
> >>   #include <linux/ktime.h>
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >> +#include <linux/of_gpio.h>
> >> +
> >>   
> >>   #include "sdhci-pltfm.h"
> >>   #include "sdhci-xenon.h"
> >> @@ -210,12 +212,25 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
> >>   	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> >>   }
> >>   
> >> +static void xenon_hw_reset(struct sdhci_host *host)
> >> +{
> >> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >> +
> >> +	if (priv->reset_gpio) {
> >> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> >> +		msleep(30);
> >> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);  
> > Does setting the pin to low means assert reset in your HW? You'd better
> > invert the logic in the DT.
> >
> > As for reset gpio, logic "1" means assert the reset, logic "0" means
> > de-assert the reset.  
> 
> Actually what I want is to cut the sd card power and enable it after that.
> the gpio is used to controller the power supply to sd card.
> I need this gpio init as low, then set it from 0->1 to do a power cycle.

If so, name the "reset" in the commit msg and source as "power", I.E

"mmc: sdhci-xenon: add power gpio support"

and

"power_gpio"
