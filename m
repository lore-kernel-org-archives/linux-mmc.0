From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date: Mon, 29 Apr 2019 10:29:17 +0200
Message-ID: <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > been unsuccessful or unreliable. Until we can figure out how to enable this
> > mode safely and reliably, let's force it off.
> last year I have seen issues with HS400 on my Khadas VIM2: [0]
> have you tested all other patches from this series and HS400 is still
> not working for you?

Because HS400 was never really stable to begin with.
It was a mistake to enable it on the VIM2

> 
> I'm curious because this patch is early in the series and all the
> tuning fixes and improvements are after this patch.

There are several reasons why this new tuning won't solve the HS400 problem:
- Signal resampling tuning granularity gets worse when rate rises. The resampling 
is done using the input frequency. We can basically resample up to the value of 
internal divider.

In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
           possible (internal div = 1)
           Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
           that's not enough to tune

Going further, tuning the Rx path does not make much sense in HS400 since we
should be using the data strobe signal to account for the round trip delay of
the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
HS400, it is most likely linked to the data strobe.

> 
> 
> Martin
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-January/006251.html
