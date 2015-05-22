From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] dw_mmc: insmod followed by rmmod will hung for eMMC
Date: Fri, 22 May 2015 15:21:26 +0200
Message-ID: <CAPDyKFrqsTN50V-WqbPWnYTs3QoWEHz=iBiGpxXAwLwsrS4SQQ@mail.gmail.com>
References: <705D14B1C7978B40A723277C067CEDE245182CD0@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33243 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbbEVNV1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 09:21:27 -0400
Received: by qkgv12 with SMTP id v12so11049178qkg.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 06:21:26 -0700 (PDT)
In-Reply-To: <705D14B1C7978B40A723277C067CEDE245182CD0@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

On 18 May 2015 at 16:23, Prabu Thangamuthu <Prabu.T@synopsys.com> wrote:
> Removing dw_mmc driver immediately after inserting the dw_mmc driver is

I guess it hangs even if you remove it after a couple of days? :-)

Perhaps makes this a bit more clear?

> getting hung for eMMC device. Root cause for this issue is, dw_mci_remove
> will disable all the interrupts then it will call dw_mci_cleanup_slot.
> dw_mci_cleanup_slot is issuing CMD6 to disable boot partition access and
> it's waiting for command complete interrupt. Since INTMASK was already
> cleared by dw_mci_remove, command complete interrupt is not reaching
> the system. This leads to process hung.

/s dw_mci_remove / dw_mci_remove()

>
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>

This patch looks good overall, but please send a new version with
updated changelog. Moreover, please use "mmc: dw_mmc:" as prefix for
the commit message header.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 5f5adaf..f0a0aff 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2941,15 +2941,15 @@ void dw_mci_remove(struct dw_mci *host)
>  {
>         int i;
>
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> -
>         for (i = 0; i < host->num_slots; i++) {
>                 dev_dbg(host->dev, "remove slot %d\n", i);
>                 if (host->slot[i])
>                         dw_mci_cleanup_slot(host->slot[i], i);
>         }
>
> +       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +
>         /* disable clock to CIU */
>         mci_writel(host, CLKENA, 0);
>         mci_writel(host, CLKSRC, 0);
> --
> 1.7.6.5
