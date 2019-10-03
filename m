From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
Date: Thu, 3 Oct 2019 12:00:33 +0200
Message-ID: <CAPDyKFpy_bC=pngV8c6PuTYm4UGeH0FtQxGPSydCf8VB9MvH9A@mail.gmail.com>
References: <20190904164625.236978-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 4 Sep 2019 at 18:46, Raul E Rangel <rrangel@chromium.org> wrote:
>
> In sdhci_do_reset we call the reset callback which is typically
> sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
> controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
> controller will clear the IRQ mask. If during that 100ms the card is
> removed there is no notification to the MMC system that the card was
> removed. So from the drivers point of view the card is always present.
>
> By making sdhci_reinit compare the present state it can schedule a
> rescan if the card was removed while a reset was in progress.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Sorry this took me so long to send out. I tested out the patch set on
> 5.3-rc5 with multiple devices.
>
> This patch was proposed here by Adrian: https://patchwork.kernel.org/patch/10925469/#22691177
>
>  drivers/mmc/host/sdhci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..b0045880ee3d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -337,8 +337,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> +       u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> +
>         sdhci_init(host, 0);
>         sdhci_enable_card_detection(host);
> +
> +       /*
> +        * A change to the card detect bits indicates a change in present state,
> +        * refer sdhci_set_card_detection(). A card detect interrupt might have
> +        * been missed while the host controller was being reset, so trigger a
> +        * rescan to check.
> +        */
> +       if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
> +               mmc_detect_change(host->mmc, msecs_to_jiffies(200));
>  }
>
>  static void __sdhci_led_activate(struct sdhci_host *host)
> --
> 2.23.0.187.g17f5b7556c-goog
>
