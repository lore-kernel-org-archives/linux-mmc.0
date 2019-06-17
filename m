From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Mon, 17 Jun 2019 16:58:47 +0200
Message-ID: <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Manish Narani <manish.narani@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

[...]

> >>
> >>
> >>> In regards to the mmc data part, I suggest to drop the
> >>> ->set_tap_delay() callback, but rather use a boolean flag to indicate
> >>> whether clock phases needs to be changed for the variant. Potentially
> >>> that could even be skipped and instead call clk_set_phase()
> >>> unconditionally, as the clock core deals fine with clock providers
> >>> that doesn't support the ->set_phase() callback.
> >>
> >> In connection to another version of this driver for latest Xilinx chip
> >> it would be better to keep set_tap_delay callback in the driver. The
> >> reason is that new chip/ip is capable to setup tap delays directly
> >> without asking firmware to do it. That's why for versal IP there is a
> >> need to call different setup_tap_delay function.
> >
> > The ->set_tap_delay() callback is for ZyncMp pointing to
> > sdhci_arasan_zynqmp_set_tap_delay(). This function calls the
> > clk_set_phase() API.
> >
> > What does ->set_tap_delay() do for the latest version?
>
> There is different set of default tap delays which should be programmed
> and it is done just via writing to registers which are the part of
> controller address space.

Okay, I see.

Not sure what makes most sense to do here, but it sounds to me like
another ->set_phase() callback should be implemented for the clock
provider. In other words, calling clk_set_phase() should continue to
works just fine for this case as well. If it turns out to be
inconvenient, we can always add the ->set_tap_delay() at a later point
when it makes more sense.

[...]

Kind regards
Uffe
