From: Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] mmc: sdhci: fix DRIVER_TYPE_D handling in sdhci_do_set_ios()
Date: Tue, 19 May 2015 11:12:14 -0700
Message-ID: <CAGXr9JHCsOYH7xDkjBwB=ychJWMnu_sHpxp8pmi5ZiR0eRq5cg@mail.gmail.com>
References: <20150514045500.D88EC220492@puck.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34958 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbbESSMP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 14:12:15 -0400
Received: by qkdn188 with SMTP id n188so10732627qkd.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2015 11:12:14 -0700 (PDT)
In-Reply-To: <20150514045500.D88EC220492@puck.mtv.corp.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

Any objections to this patch? In my opinion, this is a must-have fix
for sdhci_do_set_ios() when host->preset_enabled == false and
ios->drv_type == MMC_SET_DRIVER_TYPE_D.

To be complete, I could also add handling for ios->drv_type ==
MMC_SET_DRIVER_TYPE_B, i.e.:
else if (ios->drv_type == MMC_SET_DRIVER_TYPE_B)
    ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;

but that's not absolutely necessary since:
#define  SDHCI_CTRL_DRV_TYPE_B  0x0000

On Wed, May 13, 2015 at 9:55 PM, Petri Gynther <pgynther@google.com> wrote:
> sdhci_do_set_ios() doesn't currently program SDHCI_HOST_CONTROL2
> register correctly when ios->drv_type == MMC_SET_DRIVER_TYPE_D.
>
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  drivers/mmc/host/sdhci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..fe6094d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1564,6 +1564,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>                                 ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
>                         else if (ios->drv_type == MMC_SET_DRIVER_TYPE_C)
>                                 ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
> +                       else if (ios->drv_type == MMC_SET_DRIVER_TYPE_D)
> +                               ctrl_2 |= SDHCI_CTRL_DRV_TYPE_D;
>
>                         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>                 } else {
> --
> 2.2.0.rc0.207.ga3a616c
>
