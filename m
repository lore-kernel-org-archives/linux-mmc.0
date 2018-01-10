From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Wed, 10 Jan 2018 22:16:22 +0200
Message-ID: <1515615382.7000.889.camel@linux.intel.com>
References: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
         <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com>
         <1515607481.7000.885.camel@linux.intel.com>
         <CAPDyKFrtZqX4n-5F8d9PpmJ+RrmVuAziMKw+srBpqugZjKpT9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43256 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbeAJUQY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Jan 2018 15:16:24 -0500
In-Reply-To: <CAPDyKFrtZqX4n-5F8d9PpmJ+RrmVuAziMKw+srBpqugZjKpT9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, 2018-01-10 at 21:06 +0100, Ulf Hansson wrote:
> On 10 January 2018 at 19:04, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, 2018-01-10 at 18:01 +0100, Ulf Hansson wrote:
> > > On 10 January 2018 at 16:32, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

> > > Why not instead extend the range in sdhci_set_power_noreg() to
> > > also
> > > check for MMC_VDD_20_21?
> > > 
> > > Or is there a problem with that?
> > 
> > Do we have any grounds to do this in generic code?
> > 
> > Moreover, if we check for 2.0v what should we do in generic code?
> > For my understanding
> > 
> > case _20_21:
> >  pwr = _180;
> 
> Yeah, why is that a problem?

For me there is none. I assume that there might be hardware which we do
not possess and which would be broken by this change.

If you think this is okay, the resulting patch can be just two liner:

1) add custom ocr_mask in sdhci-pci-core;
2) add additional case in sdhci generic code.

> You should never reach this point, unless the host announce support
> via the ocr mask, for the _20_21 VDD.
> 
> What does other variants do in this regards?

I'm not sure I understand what "variants" you meant. Hardware? Host
controllers? Cards?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
