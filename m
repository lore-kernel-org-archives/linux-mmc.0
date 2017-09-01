From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Fri, 1 Sep 2017 13:30:36 -0700
Message-ID: <20170901203036.GA21656@codeaurora.org>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
 <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com>
 <20170830123624.vurdnh6bojbtrjal@flea.lan>
 <CAPDyKFqw7PNs_GQXmbJx8doo-tGW6PsKSffJhzVgU3cX3-wvsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqw7PNs_GQXmbJx8doo-tGW6PsKSffJhzVgU3cX3-wvsg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 08/30, Ulf Hansson wrote:
> On 30 August 2017 at 14:36, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Ulf,
> >
> > On Wed, Aug 30, 2017 at 02:29:24PM +0200, Ulf Hansson wrote:
> >> On 25 August 2017 at 11:49, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > The reset hook was left implemented. Provide a dumb implementation so that
> >> > client drivers can depend on it.
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >>
> >> Do you want me to pick this up via my mmc tree? If so, is that okay by
> >> the clock maintainers?
> >
> > I also happen to be the maintainer of that part of the kernel
> > (reporting to Mike and Stephen of course). We don't have anything
> > touching that file in next, so unless they feel like it should go
> > through their tree, it would be easier to keep the two changes
> > together and merge them through your tree.
> 
> Alright, I have picked it up for next!
> 

Thanks!

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

if that helps.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
