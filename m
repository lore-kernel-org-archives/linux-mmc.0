From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: remove another TMIO MMC variant usdhi6rol0.c
Date: Mon, 8 Jul 2019 12:21:52 +0200
Message-ID: <CAPDyKFqdRO9VeTrG7-nSU-oMB=HenCB3GO4GS0sN=KHnLYDCtw@mail.gmail.com>
References: <20190621060511.29609-1-yamada.masahiro@socionext.com>
 <CAK7LNASGVbkGgu7psy4DfCxmr-AxSQ3fmGJ=aDAiuSkJ5hrDwA@mail.gmail.com>
 <20190621105025.GA2987@kunai> <CADnJP=sg1Kp=TAvUD-ofQje9Y6mWWE_ZnQM_eB85uw3z6PHrVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnJP=sg1Kp=TAvUD-ofQje9Y6mWWE_ZnQM_eB85uw3z6PHrVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars Persson <lists@bofh.nu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc <linux-mmc@vger.kernel.org>, Rabin Vincent <rabin.vincent@axis.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 24 Jun 2019 at 09:04, Lars Persson <lists@bofh.nu> wrote:
>
> On Fri, Jun 21, 2019 at 12:50 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > Hi,
> >
> > On Fri, Jun 21, 2019 at 03:16:11PM +0900, Masahiro Yamada wrote:
> > > (Added Lars Persson, Guennadi Liakhovetski)
> > >
> > > On Fri, Jun 21, 2019 at 3:06 PM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >
> > > This needs Ack from Renesas.
> > > But, I do not know if TMIO folks are sure about this driver, though.
> > > (If they had been sure about it, they should not have duplicated the driver
> > > in the first place.)
> >
> > ... and from the original mail:
> >
> > > Delete this driver now. Please re-implement it based on tmio_mmc_core.c
> > > if needed.
> >
> > I was never happy with this driver existing, yet I never knew which HW
> > platform needed this, so I didn't touch it. But I'd like to see it go in
> > favor of merging with the TMIO code base.
> >
> > >
> > > Perhaps, some code snippets in this driver might be useful for cleaning
> > > tmio_mmc. It will stay in git history forever, and you can dig for it
> > > whenever you need it.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > I double checked there is no user in the current tree. I also searched
> > the web and did not find any out-of-tree user or even a reference of it.
> >
> > So, for now:
> >
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > But this seriously needs an Ack from Shimoda-san or Morimoto-san. And
> > maybe Guennadi has remarks, too?
> >
>
> So let me tell you the real use of this driver.
>
> It is used by Axis Communications in our Artpec-6 chips that will be
> around for at least 5 years in active development at our side. The SoC
> is upstreamed, but the upstreaming effort was side-tracked before the
> usdhi6rol0 was added to the devicetree.
>
> I do agree with you guys that we should not keep two drivers for the
> same IP so there should be an effort to unify the drivers. In the mean
> time, we can make the connection with Axis more explicit by assigning
> us as maintainer and pushing the device tree entries.

To me, this sounds like a reasonable good plan. Although, we need a
formal maintainer rather than just a company name.

If you or anybody at Axis can send a patch for MAINTAINERS, that would
serve as commitment that I would be happy with.

Additionally, of course, the sooner we can get things moving on
converting usdhi6rol0 into using the tmio family driver, the better.

Kind regards
Uffe
