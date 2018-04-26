From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] mmc: meson-gx: add device reset
Date: Thu, 26 Apr 2018 16:35:34 -0700
Message-ID: <7ha7tp35ix.fsf@baylibre.com>
References: <20180426103817.12675-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180426103817.12675-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Thu, 26 Apr 2018 12:38:17 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Trigger the reset line of the mmc controller while probing, if available
> The reset should be optional for now, at least until all related DT node
> have the reset property
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
