From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: remove comment regarding timeout during tuning
Date: Fri, 3 Jun 2016 10:32:54 +0200
Message-ID: <CAPDyKFqNJZXRm5LuO7KjdqQ7nUibJ33cohPFYTyrJhmckDynDA@mail.gmail.com>
References: <1463113471-14350-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38796 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcFCIc4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 04:32:56 -0400
Received: by mail-wm0-f48.google.com with SMTP id a20so96611368wma.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2016 01:32:56 -0700 (PDT)
In-Reply-To: <1463113471-14350-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 13 May 2016 at 06:24, Simon Horman <horms+renesas@verge.net.au> wrote:
> Since commit 7ce45e950624 ("mmc: sdhci: SD tuning is broken for some
> controllers") sdhci_execute_tuning() no longer includes a timeout in its
> loop counter(s) so remove portion of the comment regarding this.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e010ea4eb6f5..b7f9d4c5c925 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1909,7 +1909,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         /*
>          * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
> -        * of loops reaches 40 times or a timeout of 150ms occurs.
> +        * of loops reaches 40 times.
>          */
>         do {
>                 struct mmc_command cmd = {0};
> --
> 2.1.4
>
