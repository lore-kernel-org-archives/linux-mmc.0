From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: use SET_RUNTIME_PM_OPS() macro
Date: Wed, 3 Dec 2014 15:23:12 +0100
Message-ID: <CAPDyKFp8mgT3T=OnPJHjAKo662yzoVDc6PgeaNHo_qKaOYRJBA@mail.gmail.com>
References: <1417614194-28409-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:36005 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaLCOXN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Dec 2014 09:23:13 -0500
Received: by mail-qa0-f47.google.com with SMTP id s7so10423609qap.34
        for <linux-mmc@vger.kernel.org>; Wed, 03 Dec 2014 06:23:13 -0800 (PST)
In-Reply-To: <1417614194-28409-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

+Rafael

On 3 December 2014 at 14:43, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Use SET_RUNTIME_PM_OPS() since SET_PM_RUNTIME_PM_OPS() has been dropped.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> Hi Ulf,
>
> Can you take this patch which fixes a compilation error that has appeared only
> on next-20141203.

I would prefer if the fix could be done through Rafael's tree, since
it's a commit from there that causes the build error.

I have already shared an immutable branch containing the mmc commit,
which is in conflict with the change in Rafael's linux-pm tree.

Kind regards
Uffe

>
> Thanks
>
> Regards
>
>  drivers/mmc/host/atmel-mci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 62aba9a..03d7c75 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2561,7 +2561,7 @@ static int atmci_runtime_resume(struct device *dev)
>  static const struct dev_pm_ops atmci_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>                                 pm_runtime_force_resume)
> -       SET_PM_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
> +       SET_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
>  };
>
>  static struct platform_driver atmci_driver = {
> --
> 2.0.3
>
