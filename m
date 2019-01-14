From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during probe
Date: Mon, 14 Jan 2019 12:44:14 +0100
Message-ID: <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
Sender: stable-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 23 Dec 2018 at 22:00, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> We need to handle mmc_of_parse() errors during probe.
>
> This finally fixes the wifi regression on Raspberry Pi 3 series.
> In error case the wifi chip was permanently in reset because of
> the power sequence depending on the deferred probe of the GPIO expander.
>
> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 0db9905..9d12c06 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -296,7 +296,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>
>         iproc_host->data = iproc_data;
>
> -       mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err;
> +
>         sdhci_get_property(pdev);
>
>         host->mmc->caps |= iproc_host->data->mmc_caps;
> --
> 2.7.4
>
