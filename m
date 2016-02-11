From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix card detect when using runtime PM
Date: Thu, 11 Feb 2016 16:10:54 +0100
Message-ID: <CAPDyKFpPE31maSEVxLZx6BXD5i1Ugs79+OVQojpUCR2EzMeM3A@mail.gmail.com>
References: <1455198537-21791-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455198537-21791-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 14:48, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Add quirk broken card detection to enable card detection polling. It is
> a short term solution until reworking PM stuff.
>
> If the card detect signal is connected to the sdhci controller and not a
> gpio, when runtime PM suspend happens, we have no way to wake up on a card
> detect event since these irqs are no more enabled.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support")
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 9cb86fb..efec736 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -45,6 +45,7 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>
>  static const struct sdhci_pltfm_data soc_data_sama5d2 = {
>         .ops = &sdhci_at91_sama5d2_ops,
> +       .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>         .quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
>  };
>
> --
> 2.7.0
>

According to the below commit, SDHCI_QUIRK_BROKEN_CARD_DETECTION was
invented because of unreliable card detection mechanism inside the
sdhci controller.
Therefore it required polling to be used, but also to make ->get_cd()
to always return 1 in these cases.

Although, as I understand it that's not the case here. You can still
rely on card detection to work, but as you don't have wakeups you
can't fully make use of card detect, when combined with runtime PM.
I am not sure we should add more users of
SDHCI_QUIRK_BROKEN_CARD_DETECTION, especially since in this case it's
not reflecting the capability of the hardware.

Can't we think of another way?

Kind regards
Uffe


commit 68d1fb7e229c6f95be4fbbe3eb46b24e41184924
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
sdhci: Add support for card-detection polling

This patch adds SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk. When specified,
sdhci driver will set MMC_CAP_NEEDS_POLL MMC host capability, and won't
enable card insert/remove interrupts.

This is needed for hosts with unreliable card detection, such as FSL
eSDHC. The original eSDHC driver was tring to "debounce" card-detection
IRQs by reading present state and disabling particular interrupts. But
with this debouncing scheme I noticed that sometimes we miss card
insertion/removal events.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
