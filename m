From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/9] mmc: mmci: don't pretend IP variants with only one
 IRQ to have two mask regs
Date: Thu, 19 Jan 2017 17:44:21 +0100
Message-ID: <CAPDyKFozzCGjyxSDv7ZPVZVsD8iMseF9aMUNT1yqOiuFEx7uiQ@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com> <1484552238-23171-2-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37306 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753516AbdASQoY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 11:44:24 -0500
Received: by mail-wm0-f47.google.com with SMTP id c206so1805138wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 08:44:23 -0800 (PST)
In-Reply-To: <1484552238-23171-2-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, bruherrera@gmail.com

On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
> Currently the driver supports both devices with one and two IRQ lines.
>
> Two mask registers are used in order to select which events have to
> actually generate an interrupt on each IRQ line.
>
> It seems that in the single-IRQ case it's assumed that the IRQs lines
> are simply OR-ed, while the two mask registers are still present. The
> driver still programs the two mask registers separately.
>
> However the STM32 variant has only one IRQ, and also has only one mask
> register.
>
> This patch prepares for STM32 variant support by making the driver using
> only one mask register when only one IRQ is available.

The approach as such seems okay to try out!

However, I think a minor re-work is needed, but in the end achieving
the same goal. Some more comments below.

>
> Tested only on STM32 variant. RFT for variants other than STM32
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/mmc/host/mmci.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 01a8047..597fab8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -404,9 +404,9 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
>                 mask0 |= mask;
>
>                 writel(mask0, base + MMCIMASK0);
> +       } else {
> +               writel(mask, base + MMCIMASK1);
>         }
> -
> -       writel(mask, base + MMCIMASK1);
>  }
>
>  static void mmci_stop_data(struct mmci_host *host)
> @@ -1274,12 +1274,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>
>         do {
>                 status = readl(host->base + MMCISTATUS);
> +               status &= readl(host->base + MMCIMASK0);
>                 if (host->singleirq) {
> -                       if (status & readl(host->base + MMCIMASK1))
> -                               mmci_pio_irq(irq, dev_id);

We want to enter mmci_pio_irq(), *only* when some of those bits are
set, which we have written to in MMCIMASK1.

This changes this behaviour, which I don't think is a good idea!

> -
> -                       status &= ~MCI_IRQ1MASK;
> +                       mmci_pio_irq(irq, dev_id);
>                 }
>
>                 /*
> @@ -1287,7 +1285,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                  * enabled) since the HW seems to be triggering the IRQ on both
>                  * edges while monitoring DAT0 for busy completion.
>                  */
> -               status &= readl(host->base + MMCIMASK0);
>                 writel(status, host->base + MMCICLEAR);
>
>                 dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
> @@ -1710,7 +1707,8 @@ static int mmci_probe(struct amba_device *dev,
>         spin_lock_init(&host->lock);
>
>         writel(0, host->base + MMCIMASK0);
> -       writel(0, host->base + MMCIMASK1);
> +       if (!host->singleirq)
> +               writel(0, host->base + MMCIMASK1);

No, this is wrong.

In the case when we use only a single IRQ, we also need to clear
MMCIMASK1, as to make sure it don't contains some "garbage" and thus
triggers spurious IRQs.

>         writel(0xfff, host->base + MMCICLEAR);
>
>         /*
> @@ -1800,7 +1798,8 @@ static int mmci_remove(struct amba_device *dev)
>                 mmc_remove_host(mmc);
>
>                 writel(0, host->base + MMCIMASK0);
> -               writel(0, host->base + MMCIMASK1);
> +               if (!host->singleirq)
> +                       writel(0, host->base + MMCIMASK1);

Ditto.

>
>                 writel(0, host->base + MMCICOMMAND);
>                 writel(0, host->base + MMCIDATACTRL);
> --
> 2.7.4
>

Overall, by looking at this change I think an alternative approach
would be start with some clean-up/micro-optimizations for how the
driver deals with the MMCIMASK1 and MMCIMASK0.

More precisely, add two new variables in the mmci host struct, used
for containg a cache of these two registers. The cache needs to be
updated when new values are written, but more importantly, we don't
need to go and read the corresponding registers to know their content,
when masking/unmasking bits. Instead we can use the cache, which is
more optimal.

Following patches, similar to what you suggested in $subject patch,
can then make use of the cached values. Depending on whether
"singleirq" is set or not, the cached values can be used to write the
correct mask(s).

Kind regards
Uffe
