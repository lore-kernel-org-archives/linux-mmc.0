From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Wed, 10 Jan 2018 20:04:41 +0200
Message-ID: <1515607481.7000.885.camel@linux.intel.com>
References: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
         <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751831AbeAJSKO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Jan 2018 13:10:14 -0500
In-Reply-To: <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, 2018-01-10 at 18:01 +0100, Ulf Hansson wrote:
> On 10 January 2018 at 16:32, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
> > requires 2.0v, while the host, according to Intel Merrifield TRM,
> > supports 1.8v supply only.

> > +       /*
> > +        * Without a regulator, SDHCI does not support 2.0v but we
> > get
> > +        * here because we advertised 2.0v support for compatibility
> > +        * with the SDIO card's OCR. Map it to 1.8v for the purpose
> > of
> > +        * turning on the power.
> > +        */
> > +       if (IS_ERR(host->mmc->supply.vmmc) && vdd ==
> > ilog2(MMC_VDD_20_21))
> > +               vdd = ilog2(MMC_VDD_165_195);
> 
> Why not instead extend the range in sdhci_set_power_noreg() to also
> check for MMC_VDD_20_21?
> 
> Or is there a problem with that?

Do we have any grounds to do this in generic code?

Moreover, if we check for 2.0v what should we do in generic code?
For my understanding

case _20_21:
 pwr = _180;

is absolutely wrong in generic code (see how it looked in v1 of this
patch).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
