From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
Date: Fri, 2 Mar 2018 09:21:04 -0600
Message-ID: <20180302152104.gnylb6xtgy5hb7i5@rob-hp-laptop>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com>
 <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
 <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
 <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org, Will Deacon <will.deacon@arm.com>, "xuwei (O)" <xuwei5@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 23, 2018 at 06:16:39PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2018 at 4:19 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > On 2018/2/23 21:27, Andy Shevchenko wrote:
> >> On Fri, Feb 23, 2018 at 8:41 AM, Jaehoon Chung <jh80.chung@samsung.com>
> >> wrote:
> >>>
> >>> 'clock-freq-min-max' property had already deprecated.
> >>> Remove the 'clock-freq-min-max' property that is kept to maintain
> >>> the compatibility.
> >>
> >>
> >> Removing a property without telling the user what to expect is a bad
> >> idea and ABI breakage.
> >>
> >
> > What's the general process to remove a property?
> >
> > I guess we should do:
> > 1) deprecate it in the first place and remove it from all upstream DT

Yes

> > 2) wait some long enough days for expecting the stale of all old DTB
> > containing that property

Yes. How long that is depends on the platform. I think the minimum is 1 
release cycle. Some stable platforms are years. If there are other DT 
changes with new features everyone should want/need, then that can be a 
decision point.

Given this is a shared IP block it's harder to know, so you may need to 
err on the longer side.

> > 3) remove the functionality of the deprecated property from the driver
> > but still leave some warning there

I'd say add a warning in step 1 and combine 3 and 4.

> > 4) remove the left warning finally
> 
> I don't know. Perhaps Rob can shed a light here.
> But I would really OK with removal of some of such properties from
> some drivers where it's more burden to keep them.
> 
> > And for the ABI breakage, we should add something in Documentation/ABI
> > /obsolete  or Documentation/ABI/removed ?

It is only an ABI break if someone notices.

Rob
