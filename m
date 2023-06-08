Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E616C7EE25
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFHVj5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFHVj5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 17:39:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797242D7B
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 14:39:55 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvJwN-1pq7aO1WPx-00rGMj; Thu, 08 Jun 2023 23:39:41 +0200
Message-ID: <13fd5204-4670-264d-5553-1475af3b203e@i2se.com>
Date:   Thu, 8 Jun 2023 23:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/12] mmc: bcm2835: fix deferred probing
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-2-s.shtylyov@omp.ru>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230608194519.10665-2-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fKVW1rSYgvHG7LqI8zcNuFf32oiMHK/6x8XgMt8c29LehE+2hC4
 3VsnBIXRxTh4vw8hirLs0+ljbgV/tmdgXlkNZtdUHlrecCaweLzxappcX/hBjQRBnoG2tkd
 6VnAblH0B/wgV0em7BsGCrr7ITFtWMWFBhoIiOjtqAEXlXdY7A05EJUMFquG/s8mtLxDKv8
 3RRv/OQxpxJ0vR9tQvinA==
UI-OutboundReport: notjunk:1;M01:P0:pK5VfF5H3Yk=;eueny/g8neKs75jjcYYGQ0+Mab+
 4wMB7a9aO6/bq47UYEcZ+2+qMMA9C/x+8Z6xWB8+HDb5aSlaBcDMfPUPWWKf6HS2YixMKjzk6
 TnjrgDLBAZtUsgYcp+mKKTFqK2ifG9iT1MAMjTiJV72CYHRjEiB9Ylpkcu+e35PO2cV8UpktI
 UTE6pxRiiRX0fUMTOfRcxL3dJa4KHKUFT4G957eRcdqOE8KvYMehhFbzLRDmHELfpbn9nB/md
 TXdOqAXUsB/y6EdQhSbRP/zkyEyBw6XK9L1bNWxvDRKPvJq2X319W05KcO/2JGF9lEm0Co4dH
 CY+YKIoEGS2rioyePtsqMhkMR15jpSDSaemvqa55Gjj9xCoWvVvD4IEaJk7oSh/bA6x+mZjeL
 ZFOWIuiXr5jHKwASJdNiXGDwEj5LIzJ1BinQQOhGepMKt9Ln9YY3eaINNNJyFLBzbLSC3ZrSM
 PEiVX7Yql6I1MES1hydJq2MGmPwhshV8HcJ6tKQM1TQgFnD2ET+6DtKsK8konYXsomN3dxPMx
 XkQpGRkZB04we+iZeu/7orAE2/cNZXlnoWwhSoj7wAZx8a5/mMypZQN6JU7fQKoi2ryCFgODn
 HlzKECglk0NcxRDeiYD2SzVy1NHVVHzv4G5Q5rtu0oxFzq3UFWs+P6fBrtATGGED2Y8uwOF5U
 HBM8VdB09xA6h6czxv7hZUVc5A1s072ddXPo2R4VyA==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sergey,

was there a cover for this series, since the RFC series before had one?

Am 08.06.23 um 21:45 schrieb Sergey Shtylyov:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")

I know this is very theoretical, but does the statement "IRQ0 is no 
longer returned by platform_get_irq()" also applies to the time of the 
fixes commit?

I'm asking because the fix could be backported to Linux 4.14.

Best regards

> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 2:
> - refreshed the patch;
> - slightly reformatted the patch description.
> 
>   drivers/mmc/host/bcm2835.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 8648f7e63ca1..eea208856ce0 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1403,8 +1403,8 @@ static int bcm2835_probe(struct platform_device *pdev)
>   	host->max_clk = clk_get_rate(clk);
>   
>   	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq <= 0) {
> -		ret = -EINVAL;
> +	if (host->irq < 0) {
> +		ret = host->irq;
>   		goto err;
>   	}
>   
