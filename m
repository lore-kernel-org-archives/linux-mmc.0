From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 0/8] mmc: dw_mmc-rockchip: allow tuning using the clk-phase api
Date: Sat, 10 Oct 2015 00:31:22 +0200
Message-ID: <9143852.fAJ0a7C1AC@phil>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de> <CAD=FV=XdVt5Uop5WAUv6vY3=qPksnc9HzR4C9CBWpXJKuteTEQ@mail.gmail.com> <CAD=FV=VaZQcbgByQOAQL4qDCCOb_pNRHnXBS77L8D-dc_eYR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VaZQcbgByQOAQL4qDCCOb_pNRHnXBS77L8D-dc_eYR5A@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Am Freitag, 9. Oktober 2015, 13:11:21 schrieb Doug Anderson:
> Hi,
> 
> On Fri, Oct 9, 2015 at 10:19 AM, Doug Anderson <dianders@chromium.org> 
wrote:
> > Hi,
> > 
> > On Fri, Oct 9, 2015 at 1:10 AM, Ulf Hansson <ulf.hansson@linaro.org> 
wrote:
> >> Dough, Heiko,
> >> 
> >> This patchset seems to be causing a boot regression for
> >> exynos5800-peach-pi [1].
> >> 
> >> Apparently, the vmmc regulator doesn't exist for one of the controller
> >> but vqmmc is. This leads to the following NULL pointer exception.
> > 
> > Ugh.  Hrm, it didn't used to be possible for vmmc to be NULL.  :-/  It
> > 
> > changed in v3.16:
> >   4d1f52f mmc: core: Improve support for deferred regulators
> > 
> > ...and I didn't notice it (most of my development is done on 3.14).  :(
> > 
> > 
> > Is it sensible to have vqmmc without vmmc.  One option would be to
> > change mmc_regulator_get_supply() to not even bother trying to get
> > vqmmc if vmmc is not there.
> > 
> > Another option would be to just totally fail mmc_regulator_set_vqmmc()
> > always if vmmc is an error.  ...or assume that any bogus vmmc (either
> > vmmc is an error or regulator_get_voltage(vmmc) returns an error) is
> > 3.3V?
> > 
> > 
> > I guess the safest is to assume that bogus vmmc means 3.3V...
> 
> Ah, doh.  Just noticed Ulf's suggestion all the way at the bottom of
> the crash info, which I somehow missed before.  Yes, let's do that.
> Heiko: are you going to re-post?

definitly :-) .

I was just travelling back from ELCE today, otherwise I would've done that 
directly today. So I'm hoping to get that done tomorrow.


Heiko
