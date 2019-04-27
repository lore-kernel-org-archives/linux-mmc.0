From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/7] mmc: meson-gx: correct irq flag
Date: Sat, 27 Apr 2019 21:56:03 +0200
Message-ID: <CAFBinCC8hfFXXPhRP6A=wXpTrB=3=re=k_E-Ge+mStcjuLxCMA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423090235.17244-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 23, 2019 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is no reason for another device to request the MMC irq. It should
> only be used the MMC device, so remove IRQ_SHARED and replace by
> IRQ_ONESHOT as we don't the irq to fire again until the irq thread is
> done
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I'm doing the same thing (for the same purpose) in the meson-mx-sdio driver:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
