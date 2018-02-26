From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
Date: Mon, 26 Feb 2018 20:30:41 +0200
Message-ID: <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com> <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
 <1519658060.31245.4.camel@synopsys.com> <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
 <1519665265.31245.6.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1519665265.31245.6.camel@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 26, 2018 at 7:14 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> On Mon, 2018-02-26 at 18:53 +0200, Andy Shevchenko wrote:
>> On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin
>> <Evgeniy.Didin@synopsys.com> wrote:
>> > On Mon, 2018-02-26 at 16:39 +0200, Andy Shevchenko wrote:
>> > > On Mon, Feb 26, 2018 at 4:34 PM, Evgeniy Didin
>> > > <Evgeniy.Didin@synopsys.com> wrote:
>> > > > In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>> > > > have been made changes which can cause multiply overflow for 32-bit systems.
>> > > > The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
>> > > > Lets cast this multiply to u64 type which prevents overflow.
>> > > > -       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
>> > > > +
>> > > > +       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
>> > >
>> > > IIRC, someone commented on this or similar, i.e.
>> > >
>> > > DIV_ROUND_UP_ULL() ?
>> >
>> > Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
>> > because overflow happens on multiply and DIV_ROUND_UP_ULL helps
>> > with sum overflow.
>>
>> Did you try to compile your code for 32-bit target?
> Yes, we have compiled code for 32-bit system.

> I am wondering why are you asking that?

Because I simple didn't believe you.

ERROR: "__udivdi3" [drivers/mmc/host/dw_mmc.ko] undefined!
...scripts/Makefile.modpost:92: recipe for target '__modpost' failed
make[2]: *** [__modpost] Error 1


+++ b/drivers/mmc/host/dw_mmc.c
@@ -409,7 +409,7 @@ static inline void dw_mci_set_cto(struct dw_mci *host)

-       cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+       cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div,
host->bus_hz);

-- 
With Best Regards,
Andy Shevchenko
