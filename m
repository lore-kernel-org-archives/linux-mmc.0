From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add
 'fixed-emmc-driver-type-hs{200,400}'
Date: Wed, 6 Nov 2019 18:39:07 -0600
Message-ID: <20191107003907.GA22634@bogus>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
 <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191105083213.GA24603@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 05, 2019 at 09:32:13AM +0100, Eugeniu Rosca wrote:
> Hi Wolfram,
> 
> On Tue, Nov 05, 2019 at 07:22:23AM +0100, Wolfram Sang wrote:
> > Hi Eugeniu,
> > 
> > thanks for this work!
> 
> Thanks for the prompt response. Very much appreciated.
> 
> > 
> > > A certain eMMC manufacturer provided below requirement:
> > >  ---snip---
> > >  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
> > >  ---snip---
> > 
> > I see.
> > 
> > > The existing "fixed-emmc-driver-type" property [1] is the closest one
> > > to implement the above, but it falls short due to being unable to define
> > > two values to differentiate between HS200 and HS400 (both modes may be
> > > supported by the same non-removable MMC device).
> > > 
> > > To allow users to set a preferred HS200/HS400 "drive strength", provide
> > > two more bindings inspired from [1]:
> > >  - fixed-emmc-driver-type-hs200
> > >  - fixed-emmc-driver-type-hs400
> > 
> > Main question before looking at the code: Can't we just extend the
> > existing binding with an optional second parameter?

I was thinking the same thing...

> 
> That's a great question/proposal, but before pushing the v2 right away,
> I would like to first share some thoughts.
> 
> >         minItems: 1
> >         maxItems: 2
> > 
> > I tend to favour this approach...
> 
> The first question which pops up in my mind is related to the meaning
> of each item. The option which I envision based on your proposal is:
> 
>   * minItems: 1
>   * maxItems: 2
>   * Item[0]: Presumably equivalent to the current
>     "fixed-emmc-driver-type", i.e. the strength value applied in both
>     HS200 and HS400 modes.
>   * Item[1] (optional): Presumably equivalent to
>     "fixed-emmc-driver-type-hs400" proposed in this series. If this
>     element is provided, the first one should likely change its role
>     and become an equivalent of "fixed-emmc-driver-type-hs200" from
>     this series.
>   + Pro: Full backward compatibility. No need to touch the existing
>     users of "fixed-emmc-driver-type".
>   - Con: Not sure we have such DT bindings which dynamically change
>     their semantics based on the usage pattern.
>   - Con: Can't easily achieve the same flexibility as accomplished in
>     this series. For example, current implementation allows users to
>     define each of the three parameters (i.e. HSx00-agnostic drive
>     strength, HS200 and HS400 specific drive strengths) individually,
>     as well as in all possible combinations. This might be needed if,
>     in certain HSx00 mode, users still need to rely on the
>     RAW/unmodified drive strength. I am unsure if/how this can be
>     achieved with an array OF property with a constant or variable
>     number of elements (I try to sketch one solution below).
> 
> One option to achieve a similar degree of flexibility by using an array
> OF property (instead of several u32 properties) would be to agree on a
> convention based on magic values, i.e. below DT one-liner could be an
> example of providing solely the "fixed-emmc-driver-type-hs200" value
> (based on the agreement that 0xFF values are discarded by the driver):
> 
>     fixed-emmc-driver-type = <0xFF 0x1 0xFF>;

I don't understand why you have 3 values instead of 2.

I would just use -1 if you want to ignore an entry. If that's the common 
case, then I'd stick with what you originally proposed. If rare, then I 
think an array is the better route.

Rob
