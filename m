From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: of_mmc_spi: Add IRQF_ONESHOT to interrupt flags
Date: Fri, 4 Dec 2015 15:56:12 +0100
Message-ID: <CAPDyKFrsa_+ygaaFV_BWLNLtCXc70-VXtZ7=9cSjFHHXFW1pQg@mail.gmail.com>
References: <1448475984-11332-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33040 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbLDO4N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2015 09:56:13 -0500
Received: by ykdv3 with SMTP id v3so126331378ykd.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2015 06:56:12 -0800 (PST)
In-Reply-To: <1448475984-11332-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 25 November 2015 at 19:26, Saurabh Sengar <saurabh.truth@gmail.com> wrote:
> If no primary handler is specified for threaded_irq then a
> default one is assigned which always returns IRQ_WAKE_THREAD.
> This handler requires the IRQF_ONESHOT, because the source of
> interrupt is not disabled
>
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/of_mmc_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 6e218fb..660170c 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -55,8 +55,8 @@ static int of_mmc_spi_init(struct device *dev,
>  {
>         struct of_mmc_spi *oms = to_of_mmc_spi(dev);
>
> -       return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
> -                                   dev_name(dev), mmc);
> +       return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
> +                                       IRQF_ONESHOT, dev_name(dev), mmc);
>  }
>
>  static void of_mmc_spi_exit(struct device *dev, void *mmc)
> --
> 1.9.1
>
