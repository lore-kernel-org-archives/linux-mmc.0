From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: fix the device-tree probe deferral path
Date: Thu, 4 Feb 2016 12:11:37 +0100
Message-ID: <CAPDyKFqD+X+2Dt3RT3uhsoXVknOySmjfn-tT9xX4C9QZiXqcrw@mail.gmail.com>
References: <1454537992-15839-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36067 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146AbcBDLLi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 06:11:38 -0500
Received: by mail-yk0-f176.google.com with SMTP id z7so39300443yka.3
        for <linux-mmc@vger.kernel.org>; Thu, 04 Feb 2016 03:11:37 -0800 (PST)
In-Reply-To: <1454537992-15839-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3 February 2016 at 23:19, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> When the gpio driver is probed after the mmc one, the read/write gpio
> and card detection one return -EPROBE_DEFER. Unfortunately, the memory
> region remains requested, and upon the next probe, the probe will fail
> anyway with -EBUSY.
>
> Fix this by releasing the memory resource upon probe failure.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/mmc/host/pxamci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 28a057fae0a1..405ec339a1b8 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -657,7 +657,7 @@ static int pxamci_probe(struct platform_device *pdev)
>         if (!r || irq < 0)
>                 return -ENXIO;
>
> -       r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
> +       r = devm_request_mem_region(&pdev->dev, r->start, SZ_4K, DRIVER_NAME);

I suggest you replace also the ioremap call, thus using
devm_ioremap_resource() is convenient.

>         if (!r)
>                 return -EBUSY;
>
> @@ -840,7 +840,6 @@ out:
>         }
>         if (mmc)
>                 mmc_free_host(mmc);
> -       release_resource(r);

This looks wrong.

>         return ret;
>  }
>
> --
> 2.1.4
>

Perhaps it's just easier to convert the probe function to use all
devm_* functions, as for example irqs isn't freed either.

In that way, you will solve all problems of also leaking memory in one go.

Kind regards
Uffe
