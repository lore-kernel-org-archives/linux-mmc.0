From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: meson-gx: fixes for v4.14
Date: Mon, 02 Oct 2017 11:33:20 -0700
Message-ID: <7hk20d8knj.fsf@baylibre.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Mon, 2 Oct 2017 14:27:40 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset fixes the issues reported by Heiner [0] with the odroid-c2.
> In a nutshell, this series does the following:
>
> * Make sure the mmc clock rate is not set higher than what is requested
> * Reset the tuning values on mmc power cycle instead of POWER_ON
> * Add tuning of the tx phase to the tuning function.
>
> This fixes the problem seen on the odroid-c2, both for hs200 and hs400.
> To check for regression, this series has also been tested on the gxl
> libretech-cc
>
> Ulf, could you please pick this as fixes for v4.14 ?
>
> [0]: https://lkml.kernel.org/r/e2171288-84ef-82db-2efc-300935e6c062@gmail.com
>
> Jerome Brunet (3):
>   mmc: meson-gx: make sure the clock is rounded down
>   mmc: meson-gx: fix rx phase reset
>   mmc: meson-gx: include tx phase in the tuning process
>
>  drivers/mmc/host/meson-gx-mmc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
