Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3FEC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 18:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbhLWSsT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:48:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52364 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349902AbhLWSsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 13:48:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDDD01593E8;
        Thu, 23 Dec 2021 13:48:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=GQP+fb7ki0DT7/gypiWXs00zHpe+qshPJ6b4aV
        /54hE=; b=YP3Jaew0HhZmUXc6xS/jRkWGB3pldU+wyeVotd3YI+GMwQ5o8+3xAx
        hmg9q0SVIGEAJD6KujJ/OreH4qqNfKpws3uIjzjc0sNyRnhFYQC9gJ5cmvQEf1SO
        /IO6cs+zF55bv0AnCIKT8/6hfhr7T2mRVZ/usAj8gOK+CHp91ApPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6C9A1593E5;
        Thu, 23 Dec 2021 13:48:17 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=GQP+fb7ki0DT7/gypiWXs00zHpe+qshPJ6b4aV/54hE=; b=rWP2+B22nRAWRWW4bQY3ryj6SdpGfNr1tEZtlPC8xQwk6d8wW/xL9LEtjsRjfq28Km5oQ3DFTJQx0z9LwOHfYs84NAoBKsH76hO/5s45jWjqUAhxCLernwoa7zuwn+pUPUW+RWCBi3+V1/n/h6vs2lf8ydjOPFpEkKuVJvfjFxE=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B11EC1593E4;
        Thu, 23 Dec 2021 13:48:13 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 885E22DA0065;
        Thu, 23 Dec 2021 13:48:11 -0500 (EST)
Date:   Thu, 23 Dec 2021 13:48:11 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH RFC 04/13] mmc: mvsdio: fix deferred probing
In-Reply-To: <20211223171202.8224-5-s.shtylyov@omp.ru>
Message-ID: <337r530-or86-p158-p6n8-9760s8rp353s@syhkavp.arg>
References: <20211223171202.8224-1-s.shtylyov@omp.ru> <20211223171202.8224-5-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: E224301A-6420-11EC-AB3F-C85A9F429DF0-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Dec 2021, Sergey Shtylyov wrote:

> The driver overrides the error codes returned by platform_get_irq() to
> -ENXIO, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  drivers/mmc/host/mvsdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 629efbe639c4..b4f6a0a2fcb5 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -704,7 +704,7 @@ static int mvsd_probe(struct platform_device *pdev)
>  	}
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
> -		return -ENXIO;
> +		return irq;
>  
>  	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
>  	if (!mmc) {
> -- 
> 2.26.3
> 
> 
