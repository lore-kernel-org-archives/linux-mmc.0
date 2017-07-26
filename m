From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for MMC controllers
Date: Wed, 26 Jul 2017 22:09:41 +0800
Message-ID: <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
References: <20170724135905.28855-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:41076 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdGZOKJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jul 2017 10:10:09 -0400
In-Reply-To: <20170724135905.28855-1-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Mon, Jul 24, 2017 at 9:58 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v3 of my MMC controller support series.
>

[...]

> Chen-Yu Tsai (10):
>   clk: sunxi-ng: Add interface to query or configure MMC timing modes.
>   clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
>     switching
>   clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
>   mmc: sunxi: Support controllers that can use both old and new timings
>   mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
>   mmc: sunxi: Add support for A83T eMMC (MMC2)

So this series seems to be ready for inclusion, unless Ulf has further
concerns about the clk usage.

The first mmc patch have build time dependencies on the first clk patch.
Shall we put the clk patch on a separate immutable branch for both trees
to pull? Or we could just merge everything through the mmc tree? I don't
think we'll touch this part of the sunxi-ng clk driver for the remainder
of this cycle.


Regards
ChenYu


>   ARM: dts: sun8i: a83t: Add MMC controller device nodes
>   ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC on mmc2
>   ARM: dts: sun8i: a83t: cubietruck-plus: Enable micro-SD card and eMMC
>   ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC
