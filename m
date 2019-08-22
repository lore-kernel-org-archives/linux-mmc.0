From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Date: Thu, 22 Aug 2019 14:12:59 +0200
Message-ID: <CAPDyKFp_UdPqnOtqsOZcNxt+fTayMYm89_YLNH8J5-=VRcWTJA@mail.gmail.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com> <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Ferre <Nicolas.Ferre@microchip.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 9 Aug 2019 at 10:09, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> On Thu, Aug 08, 2019 at 05:23:00PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
> > >
> > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > >
> > > HS200 is not implemented in the driver, but the controller claims it
> > > through caps.
> > > Remove it via quirk.
> > > Without this quirk, the mmc core will try to enable hs200, which will fail,
> > > and the eMMC initialization will fail.
> > >
> > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >
> > Should this be applied as a fix and possibly tagged for stable?
> >
> > In such case, do you have a specific commit that it fixes?
>
> I think so, I would say:
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Cc: stable@vger.kernel.org #v4.4 and later
>
> It doesn't apply on 4.4 but resolution is trivial.
>
> Regards
>
> Ludovic
>

[...]

Applied for fixes, by adding the above tags, thanks!

Kind regards
Uffe
