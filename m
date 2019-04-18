From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/7] mmc: meson-gx: irq is not shared
Date: Thu, 18 Apr 2019 21:52:47 +0200
Message-ID: <CAFBinCCLr2-zBhAUcYsyqF1f0hvH03zoXd9SmSjMU5aA3K7Ytw@mail.gmail.com>
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417204355.469-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jerome,

On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is no reason for another device to request the MMC irq. It should
> only be used the MMC device.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 8b690ecde4c5..3df50b53f834 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1328,7 +1328,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                host->regs + SD_EMMC_IRQ_EN);
>
>         ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -                                  meson_mmc_irq_thread, IRQF_SHARED,
> +                                  meson_mmc_irq_thread, IRQF_ONESHOT,
>                                    dev_name(&pdev->dev), host);
the commit message reads as if the intention is to remove the IRQF_SHARED flag.
however, the commit message doesn't mention IRQF_ONESHOT (which was
not set before).

if you used IRQF_ONESHOT on purpose then please mention it in the
patch description.


Martin
