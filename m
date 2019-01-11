From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
Date: Thu, 10 Jan 2019 17:28:11 -0800
Message-ID: <7hftu0oudw.fsf@baylibre.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Loys Ollivier <lollivier@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

Loys Ollivier <lollivier@baylibre.com> writes:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "active high".
>
> Fix the SD card for meson by setting the cd-gpios as "active low" according
> to the boards specifications.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

Thanks for fixing this!

Queued as a fix for v5.1-rc,

I see that this is being fixed in the driver also, but I think fixing
the DTs is necessary also.

Kevin
