From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
Date: Wed, 6 Nov 2019 12:07:38 +0100
Message-ID: <CACRpkdbO6df3OKn4wnz9LMjf4i94jQPs9n_Cdzv7boWMZDCovA@mail.gmail.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Eugeniu,

thanks for your patch!

On Tue, Nov 5, 2019 at 6:50 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> A certain eMMC manufacturer provided below requirement:
>  ---snip---
>  Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
>  ---snip---
>
> The existing "fixed-emmc-driver-type" property [1] is the closest one
> to implement the above, but it falls short due to being unable to define
> two values to differentiate between HS200 and HS400 (both modes may be
> supported by the same non-removable MMC device).
>
> To allow users to set a preferred HS200/HS400 "drive strength", provide
> two more bindings inspired from [1]:
>  - fixed-emmc-driver-type-hs200
>  - fixed-emmc-driver-type-hs400

I am sorry that I do not quite understand but as pin control maintainer I
am of course triggered by the talk about selecting "drive strength".

In my book this means that the pad driver on the chip, driving the
line low/high with push-pull (totempole output, usually) is connecting
more driver stages, usually just shunting in more totempoles.
(Ref https://en.wikipedia.org/wiki/Push%E2%80%93pull_output)

If say one totempole gives 2mA drive strength then 4 totempoles
gives 8mA drive strength.

Are we on the same page here that this is what physically happens?

Usually selection of drive strength is done with the pin control
framework, so this would need to be backed by code (not in this
patch set) that select pin control states that reconfigure the
SoC pad drivers to use the requested strength.

Alternatively, the (e)MMC block would implement this control
directly, but I doubt it.

Please clarify which hardware is eventually going to provide the
drive strength alteration, because I just don't see it in the patch
set. Is the assumption that the (e)MMC hardware will do this
autonomously or something? That may be a pecularity to the hardware
you're using in that case.

I find the fixed-emmc-driver-type-* assignment a but puzzling
to be honest, isnt' the driver device tree already specifying
what the hardware can do with all of these:

mmc-ddr-1_2v
mmc-ddr-1_8v
mmc-ddr-3_3v
mmc-hs200-1_2v
mmc-hs200-1_8v
mmc-hs400-1_2v
mmc-hs400-1_8v
mmc-hs400-enhanced-strobe

If the host is already specifying mmc-hs200-* or
mmc-hs400-* then certainly it should be implied that the
host supports hs200 and hs400 and there is no need for
the fixed-emmc-driver-type-hs* properties.

The code detects when to use each mode and that is when
you can insert the code to switch drive strengths, whether using
the pin control framework or something else.

So to me it seems these DT properties are just introduced to
hammer down a certain usecase instead of letting the code with the
help of DT speed capabilities flags determine what speed is to be used
and select the appropriate drive strength.

Yours,
Linus Walleij
