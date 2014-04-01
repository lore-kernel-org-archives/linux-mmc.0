From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Tue, 01 Apr 2014 15:26:07 +0400
Message-ID: <533AA24F.8050705@cogentembedded.com>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk> <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:34698 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaDAL0J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 07:26:09 -0400
Received: by mail-la0-f44.google.com with SMTP id c6so615184lan.17
        for <linux-mmc@vger.kernel.org>; Tue, 01 Apr 2014 04:26:08 -0700 (PDT)
In-Reply-To: <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

Hello.

On 01-04-2014 14:25, Ben Dooks wrote:

> Start tidying the probe/release code by using devm_ioremap_resource() to
> map the IO registers.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/mmc/host/sh_mmcif.c | 20 +++++---------------
>   1 file changed, 5 insertions(+), 15 deletions(-)

> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index c48df98..be6be2b 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1379,22 +1379,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "Get irq error\n");
>   		return -ENXIO;
>   	}
> +
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "platform_get_resource error.\n");
> -		return -ENXIO;
> -	}
> -	reg = ioremap(res->start, resource_size(res));
> -	if (!reg) {
> +	reg = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(reg)) {
>   		dev_err(&pdev->dev, "ioremap error.\n");
>   		return -ENOMEM;

    Should propagate devm_ioremap_resource() error instead.

[...]

WBR, Sergei

