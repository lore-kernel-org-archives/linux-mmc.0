Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46895C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Jan 2022 11:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiADLAb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiADLAb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2022 06:00:31 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF628C061761
        for <linux-mmc@vger.kernel.org>; Tue,  4 Jan 2022 03:00:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 243C11F42FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641294029;
        bh=juylbfZmAjF6gpbipCeMx9kVpup2ivKUb1IhlYABCOQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ccrTjfAv6ZJuQeCwHm5IXXzz0Ew5v4e0mHY+mIX6jx6G+AufJvcz5kdjH2xQRyJbs
         ah82SvukeNZGrjE3doovW6i38jQLuBdTQRXlmK8Jqo2q6uobpI2Q99L0VbPd9pj3mr
         g2bkogmOgRcwDkmyyeoj0Lof7EkY4Ia3sjA+O9UG2kM9t5X9V0irLHll0K72tWBADk
         kPDwHAeRJlU12b1v206JTsRSeWK3/JVdaWiEe/siMbJ+9GCY3KXVKhaipSp56ypy5i
         hw8fpIe4i8tPEc3TfOIp0tpdERbSygM6OoCt7P4iCuvzZgDAinr9NZ07qZxOkRCEFG
         Ay/6TVByKjhMQ==
Subject: Re: [PATCH RFC 03/13] mmc: mtk-sd: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-4-s.shtylyov@omp.ru>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <669ea14c-d6e7-ebaa-891d-ad30b82dae49@collabora.com>
Date:   Tue, 4 Jan 2022 12:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211223171202.8224-4-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Il 23/12/21 18:11, Sergey Shtylyov ha scritto:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mmc/host/mtk-sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 632775217d35..4bd070a458e9 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2590,7 +2590,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   
>   	host->irq = platform_get_irq(pdev, 0);
>   	if (host->irq < 0) {
> -		ret = -EINVAL;
> +		ret = host->irq;
>   		goto host_free;
>   	}
>   
> 

