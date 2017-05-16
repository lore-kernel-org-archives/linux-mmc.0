From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 5/5] mmc: cavium: Fix probing race with regulator
Date: Tue, 16 May 2017 08:07:50 -0500
Message-ID: <CAL_Jsq+wMnNH0oOy7qpycm+4tTu=zYCVzDSuSTSpkfQY85kDEQ@mail.gmail.com>
References: <20170516093655.17746-1-jglauber@cavium.com> <20170516093655.17746-6-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdEPNIM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 May 2017 09:08:12 -0400
In-Reply-To: <20170516093655.17746-6-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 16, 2017 at 4:36 AM, Jan Glauber <jglauber@cavium.com> wrote:
> If the regulator probing is not yet finished this driver
> might catch a -EPROBE_DEFER. Returning after this condition
> did not remove the created platform device. On a repeated
> call to the probe function the of_platform_device_create
> fails.
>
> Calling of_platform_device_destroy after EPROBE_DEFER resolves
> this bug.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/mmc/host/cavium-thunderx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index fe3d772..257535e 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -137,8 +137,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                                 continue;
>
>                         ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
> -                       if (ret)
> +                       if (ret) {
> +                               of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);

What if this fails after the 1st iteration of the loop. It's only
cleaning up the current device.

Use devm_of_platform_populate or
of_platform_populate/of_platform_depopulate instead.

Rob
