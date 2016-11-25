From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V7 25/25] mmc: sdhci-acpi: Enable Software Command Queuing
 for some Intel controllers
Date: Fri, 25 Nov 2016 16:15:01 +0100
Message-ID: <CACRpkdZZa8O3NPm3+1gDb=mfRDZqAjzgqdW5EZyrxGQn-_XbbQ@mail.gmail.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com> <1480068442-5169-26-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33572 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755008AbcKYPQO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 10:16:14 -0500
Received: by mail-qt0-f171.google.com with SMTP id p16so68070860qta.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 07:15:02 -0800 (PST)
In-Reply-To: <1480068442-5169-26-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Nov 25, 2016 at 11:07 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Set MMC_CAP_SWCMDQ for Intel BYT and related eMMC host controllers.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 81d4dc034793..95fc4de05c54 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -274,7 +274,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>         .chip    = &sdhci_acpi_chip_int,
>         .caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
> -                  MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
> +                  MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR | MMC_CAP_SWCMDQ |

Actually I don't see why SOFTWARE command queueing would need a cap flag
in the host at all?

Isn't the whole point with it that if it is available, we don't need any special
hardware support to use it with any host?

So why not just enable it if the card supports it in that case, why flag
it in the host at all?

Yours,
Linus Walleij
