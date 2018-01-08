From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] sdhci: Advertise 2.0v on SDIO host interface
Date: Mon, 08 Jan 2018 15:05:01 +0200
Message-ID: <1515416701.7000.781.camel@linux.intel.com>
References: <20180105203743.35201-1-andriy.shevchenko@linux.intel.com>
         <CAPDyKFoq2qF13+9yqt4HYmvqYWvcqtvxRp1wm=2uYbv_FiXNOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756064AbeAHNFD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jan 2018 08:05:03 -0500
In-Reply-To: <CAPDyKFoq2qF13+9yqt4HYmvqYWvcqtvxRp1wm=2uYbv_FiXNOA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, 2018-01-06 at 13:44 +0100, Ulf Hansson wrote:
> On 5 January 2018 at 21:37, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
> > requires 2.0v, while the host, according to Intel Merrifield TRM,
> > supports 1.8v I/O only.
> > 
> > The card announces itself as
> > 
> >   mmc2: new ultra high speed DDR50 SDIO card at address 0001
> > 
> > Introduce a custom OCR mask and ->set_power() callback to override
> > 2.0v
> > signaling on Intel Merrifield platforms by enforcing 1.8v power
> > choice.
> 
> This seems to be about VDD (vmmc) rather than about signaling voltage?

I'm not sure the case is the following:
1) SDHCI host reports (via OCR) that supported voltage is 1.8v (only)
2) BCM Wi-Fi card tells to the driver that it supports 2.0v (only)

In the result there is no OCR which has at least one supported voltage
by both.

Keep in mind that there is no regulator case.

> 
> Could you verify that is the case? I think we have had too many cases
> historically, which mixing the two voltages together and thus we end
> up by luck getting things to work.

If you tell me what to add to debug print this or alike, I will provide
you the answer. 

> >         case INTEL_MRFLD_SDIO:
> > +               slot->host->ocr_mask = MMC_VDD_20_21 |
> > MMC_VDD_165_195;
> 
> So this is about VDD and what VDD voltage levels the host support. If
> there a way to find out these values dynamically, that should be done
> instead.

Then we can't find a compatible voltage.

> > +       if (IS_ERR(host->mmc->supply.vmmc)) {
> > +               switch (1 << vdd) {
> > +               case MMC_VDD_20_21:
> > +                       sdhci_set_power_noreg(host, mode,
> > ilog2(MMC_VDD_165_195));
> 
> This looks weird.

Yes, it does. I have no idea how to do this better. I can't fix neither
hardware nor firmware to do something about this.

> I don't think you should need to treat the MMC_VDD_20_21 in a special
> way.
> 
> Or perhaps this is because this is about signal voltage after all?

See above.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
