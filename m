From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/1] mmc: of_mmc_spi: fix card detect irq
Date: Sun, 26 May 2013 23:13:14 +0400
Message-ID: <51A25ECA.2060001@cogentembedded.com>
References: <1369571337-9300-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:48297 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3EZTNS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 May 2013 15:13:18 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so6157054lbd.15
        for <linux-mmc@vger.kernel.org>; Sun, 26 May 2013 12:13:16 -0700 (PDT)
In-Reply-To: <1369571337-9300-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hello.

On 05/26/2013 04:28 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> set missing irq type the IRQF_ONESHOT
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: stable <stable@vger.kernel.org> # 3.4+
> Cc: linux-mmc@vger.kernel.org
> ---
>   drivers/mmc/host/of_mmc_spi.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index d720b5e..cfb2e61 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -74,8 +74,8 @@ static int of_mmc_spi_init(struct device *dev,
>   {
>   	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
>   
> -	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
> -				    dev_name(dev), mmc);
> +	return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
> +		IRQF_ONESHOT, dev_name(dev), mmc);

     Please don't change the indentation.

WBR, Sergei

