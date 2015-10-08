From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add quirk SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
Date: Thu, 8 Oct 2015 20:01:23 +0200
Message-ID: <CAPDyKFp1+d1ouaq-ftheDn+fT1ssHDwde2orAndUrMW0iyqqww@mail.gmail.com>
References: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

+Russell

On 17 September 2015 at 10:16, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> The Atmel sdhci device needs a new quirk. sdhci_set_clock set the Clock
> Control Register to 0 before computing the new value and writing it.
> It disables the internal clock which causes a reset mecanism. If we
> write the new value before this reset mecanism is done, it will prevent
> the stabilisation of the internal clock, so a delay is needed. This
> delay is about 2-3 cycles of the base clock. To be safe, a 1 ms delay is
> used.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> Hi Ulf,
>
> Can you take these patches as fixes? I thought it was better to introduce a
> quirk instead of duplicating a part of the sdhci_set_clock function to
> implement my own set_clock function.

Hi Ludovic,

Sorry for the delay!

I have been thinking of how to address patches for sdhci that adds
more quirks/callbacks. To be honest, I am fed up with such patches as
I think it keeps the development of sdhci going in the wrong
direction.

Instead, I have been hoping for someone to have stab into turning
sdhci into a library as Russell King pointed out several times as
well.

Now, as my response too you had a big delay for these patches and
because it's a fix intended for the rc, I am going to apply patch1 and
patch2 anyway. Although, you and everybody else that contributes to
the sdhci development, please consider this as the *last* time for
adding quirks/callbacks, unless you have *very good* reasons.

Kind regards
Uffe

>
> Regards
>
>
>  drivers/mmc/host/sdhci.c | 2 ++
>  drivers/mmc/host/sdhci.h | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64b7fdb..fbc7efd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1160,6 +1160,8 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         host->mmc->actual_clock = 0;
>
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +       if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
> +               mdelay(1);
>
>         if (clock == 0)
>                 return;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7c02ff4..9d4aa31 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -412,6 +412,11 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN             (1<<15)
> +/*
> + * When internal clock is disabled, a delay is needed before modifying the
> + * SD clock frequency or enabling back the internal clock.
> + */
> +#define SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST      (1<<16)
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> --
> 2.5.0
>
