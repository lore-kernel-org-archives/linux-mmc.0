From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date: Tue, 30 Apr 2019 22:28:27 +0200
Message-ID: <0bd1e9c25ab11112c9f2913c2cb3483e8802099d.camel@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
         <20190423090235.17244-5-jbrunet@baylibre.com>
         <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
         <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
         <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
         <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
         <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2019-04-30 at 22:02 +0200, Martin Blumenstingl wrote:
> > Thanks for effort but all this just maintain the blur around HS400 on amlogic.
> > 
> > Let me rephrase it:
> > Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
> > and HS200 modes. In HS400, this should be taken care of by the data strobe.
> > But we have not been to enable this reliably enable this on amlogic chipset ...
> I wasn't aware of this: so far I assumed that we're not setting the
> phase correctly, end of the story.
> thank you again for taking your time to explain this!

No worries. There is the MMC in general, I think I understand it a bit now but 
I might still be mistaken about some stuff. Then there is the HW we have and the
related black magic.

I doubt this is the last update in this driver ...

> 
> > ... and I believe we are back to the original commit message.
> no need to update the description just to explain how HS400 works in
> general, so feel free to use my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
