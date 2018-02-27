From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for
 32-bit systems
Date: Tue, 27 Feb 2018 12:49:06 +0200
Message-ID: <CAHp75Vfb6HQvx531bDi_j1wG=-vae73o+hcOyCGfOeQKEUpYeg@mail.gmail.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-3-Evgeniy.Didin@synopsys.com> <CAHp75Vct=jMohCFnn3aoZCAw-Q8=8OOF-nPXh9dfwrWHVPXSfA@mail.gmail.com>
 <1519658060.31245.4.camel@synopsys.com> <CAHp75VeJhHWhxc4DBiqiu4n6raXbNQ0+W5YX_jthQd2OFF9F=w@mail.gmail.com>
 <1519665265.31245.6.camel@synopsys.com> <CAHp75VcABGN+awEUzNiTAc985EM0XVS6eiNLGYYD1_vCrRC00Q@mail.gmail.com>
 <1519676841.2997.7.camel@synopsys.com> <20180227115243.7ca84b3b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180227115243.7ca84b3b@xhacker.debian>
Sender: stable-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@chromium.org" <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 27, 2018 at 5:52 AM, Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> On Mon, 26 Feb 2018 20:27:22 +0000 Alexey Brodkin wrote:
>> On Mon, 2018-02-26 at 20:30 +0200, Andy Shevchenko wrote:
>> > On Mon, Feb 26, 2018 at 7:14 PM, Evgeniy Didin
>> > <Evgeniy.Didin@synopsys.com> wrote:
>> > > On Mon, 2018-02-26 at 18:53 +0200, Andy Shevchenko wrote:
>> > > > On Mon, Feb 26, 2018 at 5:14 PM, Evgeniy Didin

>> > > > > > IIRC, someone commented on this or similar, i.e.
>> > > > > > DIV_ROUND_UP_ULL() ?

^^^^^^^^^^^^

>> So maybe we need to add export of __udivdi3() for other arches, what do you think?

> Per my understanding, Linux kernel prefer to make use of do_div or implementations
> in <linux/math64.h> for 64bit divide

To everyone in this thread. See just above. That's solution which will work.
Other than that, drop COMPILE_TEST from the Kconfig and put a comment
that driver will not compile on architectures w/o division library.

-- 
With Best Regards,
Andy Shevchenko
