From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Wed, 19 Jun 2019 16:40:36 +0200
Message-ID: <CAPDyKFqC7aGX+BSP7U162Viq8qoL_df+N=zP_6P9xbzSZseipw@mail.gmail.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com> <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
 <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <MNARANI@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 18 Jun 2019 at 06:59, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
> Thanks for the review. Please find my comments below.
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, June 17, 2019 8:29 PM
> > To: Michal Simek <michals@xilinx.com>
> > Cc: Manish Narani <MNARANI@xilinx.com>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Adrian
> > Hunter <adrian.hunter@intel.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly
> > Shah <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Olof
> > Johansson <olof@lixom.net>; linux-mmc@vger.kernel.org; DTML
> > <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
> > Platform Tap Delays Setup
> >
> > [...]
> >
> > > >>
> > > >>
> > > >>> In regards to the mmc data part, I suggest to drop the
> > > >>> ->set_tap_delay() callback, but rather use a boolean flag to indicate
> > > >>> whether clock phases needs to be changed for the variant. Potentially
> > > >>> that could even be skipped and instead call clk_set_phase()
> > > >>> unconditionally, as the clock core deals fine with clock providers
> > > >>> that doesn't support the ->set_phase() callback.
>
> In the current implementation, I am taking care of both the input and
> output clock delays with the single clock (which is output clock) registration
> and differentiating these tap delays based on their values
> (<256 then input delay and  >= 256 then output delay), because that is
> zynqmp specific. If we want to make this generic, we may need to
> register 'another' clock which will be there as an input (sampling) clock
> and then we can make this 'clk_set_phase()' be called unconditionally
> each for both the clocks and let the platforms handle their clock part.
> What's your take on this?

Not sure exactly what you are suggesting, but my gut feeling says it
sounds good.

How is tap delays managed for both the input clock and the output
clock? Is some managed by the clock provider (which is probably
firmware in your case) and some managed by the MMC controller?

[...]

Kind regards
Uffe
