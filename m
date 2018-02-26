From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation
 for 32-bit systems
Date: Mon, 26 Feb 2018 20:27:22 +0000
Message-ID: <1519676841.2997.7.camel@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
 <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
 <1519658060.31245.4.camel@synopsys.com>
 <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
 <1519665265.31245.6.camel@synopsys.com>
 <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
Content-Language: en-US
Content-ID: <3651F71BBF0E724AB1BD729E3381FBE2@internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi Andy,

On Mon, 2018-02-26 at 20:30 +0200, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 7:14 PM, Evgeniy Didin
> <Evgeniy.Didin@synopsys.com> wrote:
> > On Mon, 2018-02-26 at 18:53 +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin
> > > <Evgeniy.Didin@synopsys.com> wrote:
> > > > On Mon, 2018-02-26 at 16:39 +0200, Andy Shevchenko wrote:
> > > > > On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
> > > > > <Evgeniy.Didin@synopsys.com> wrote:
> > > > > > In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> > > > > > have been made changes which can cause multiply overflow for 32-bit systems.
> > > > > > The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
> > > > > > Lets cast this multiply to u64 type which prevents overflow.
> > > > > > -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> > > > > > +
> > > > > > +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> > > > > 
> > > > > IIRC, someone commented on this or similar, i.e.
> > > > > 
> > > > > DIV_ROUND_UP_ULL() ?
> > > > 
> > > > Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
> > > > because overflow happens on multiply and DIV_ROUND_UP_ULL helps
> > > > with sum overflow.
> > > 
> > > Did you try to compile your code for 32-bit target?
> > 
> > Yes, we have compiled code for 32-bit system.
> > I am wondering why are you asking that?
> 
> Because I simple didn't believe you.

Well world around us is much more complicated than it sometimes looks like :)

> ERROR: "__udivdi3" [drivers/mmc/host/dw_mmc.ko] undefined!
> ...scripts/Makefile.modpost:92: recipe for target '__modpost' failed
> make[2]: *** [__modpost] Error 1

That's right __udivdi3() is not defined for some architectures but it is defined for
some others including ARC, Xtensa etc, see
https://elixir.bootlin.com/linux/latest/ident/__udivdi3

What happens __udivdi3() is implemented in libgcc in one form or another form
be it pure assembly or generic implementation written in C.

So maybe we need to add export of __udivdi3() for other arches, what do you think?

-Alexey
