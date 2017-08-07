From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
Date: Sun, 6 Aug 2017 23:48:14 -0700
Message-ID: <20170807064813.GA5487@atomide.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
 <e9c1cce6-5d6d-3762-8a84-28f36fa3bc33@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56896 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbdHGGsZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Aug 2017 02:48:25 -0400
Content-Disposition: inline
In-Reply-To: <e9c1cce6-5d6d-3762-8a84-28f36fa3bc33@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [170803 04:20]:
> Hi Tony.
> 
> On Thursday 08 June 2017 12:50 PM, Ulf Hansson wrote:
> > On 7 June 2017 at 11:37, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> There are the set of fixes that were sent initially as part
> >> of [1].
> >>
> >> These are mostly fixes w.r.t populating regulators in
> >> mmc dt node. It was working before because the regulators
> >> connecting to the IO lines are always on regulators. This will
> >> break once we add UHS support where voltage has to be changed
> >> dynamically.
> >>
> >> It also includes a patch to replace all vmmc_aux-supply
> >> with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
> >> vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).
> >> This will break old dt compatibility but not sure how better
> >> to handle this.
> >>
> >> Performed enumeration testing on dra72-evm-revc, dra72-evm,
> >> dra7-evm, am572x-evm, am571x-idk, am572x-idk, omap5-evm,
> >> pandaboard-es, am43xx-evm, am335x-evm, beagleboard etc.,
> >>
> >> This is a preparation series for adding UHS mode support in
> >> the above mentioned platforms.
> >>
> >> Changes from v1:
> >> *) Included a patch to replace deprecated "vmmc_aux" with
> >>    "vqmmc"
> 
> Have you already merged this series in your for-next? I could see all the
> patches except "ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc" in
> your for-next.

Sorry it got delayed, I was planning to send it at -rc1 time but
had a pending pull request for fixes that got delayed, and it's
too late now until next merge window.

> Do you want me to resend the entire series or only "ARM: dts: omap*: Replace
> deprecated "vmmc_aux" with "vqmmc"?

Seems that the missing one is safe to apply now? If so, let me just
take a look at that since I do have a branch already set up that
I can use.

Also, I was offline last week so I'll first have to check for any
pending fixes that might need attention.

> Please note having vqmmc property is required when we move to sdhci driver.

OK

Regards,

Tony
