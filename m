From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 13/16] mmc: meson-gx: use CCF to handle the clock phases
Date: Thu, 24 Aug 2017 17:04:26 -0700
Message-ID: <7hd17kh5rp.fsf@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
        <20170821160301.21899-14-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-14-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Mon, 21 Aug 2017 18:02:58 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Several phases can be controlled on the meson-gx controller, the core, tx
> and rx clock phase. The tx and rx uses delays to allow for a more fine
> grained setting of the phase. To properly compute the phase using delays,
> accessing the clock rate is necessary.
>
> Instead of ad-hoc functions, use the common clock framework to set the
> clock phases (and access the clock rate while doing it).
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I have to admit to not fully understanding the MMC tuning aspsects here,
but I like this approach to using the clock framework for handling the
extra clocks.

Acked-by: Kevin Hilman <khilman@baylibre.com>
