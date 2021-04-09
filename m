Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D6FC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 05:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D9D61177
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 05:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhDIFQc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFQc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Apr 2021 01:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C628660FED;
        Fri,  9 Apr 2021 05:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617945379;
        bh=b5Oti2a4V+5Z15WDny0T+uUWikQ579xwW2th+oYxSs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESbX2l7dMjCi22MdJvsGLVsCqHl9c2b3AuA1PBicz2Sc1Rx86FKnQs3kDyoqI7RPd
         /iTphUo8a6XSDcIyMQKi0idRloqe55vPIK4m+o2d3IjEVbvmHU/K9DTPyHAxxyOpv7
         oALr6czhuU6Tj2tc5xf+LbHH2lPJw8yASFqinstWMEEcCESAoUOe4xBU/kJityuZ2F
         ElArHdLdJt5Mwr6udBL4r4hzuCDWPc7euMxKVnRvJWHX55k/HzDLXIg6oHfWNM6hO3
         iUNrE8tmI1wP+ExyNIRKsU9jXQ5iBDssS7zf+FvQowZDmJThC89X6+ODCpgBuHlXY8
         PWueT9xxUTi3g==
Date:   Fri, 9 Apr 2021 10:46:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     ulf.hansson@linaro.org, afaerber@suse.de, yuehaibing@huawei.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mmc: owl-mmc: Remove unnecessary error log
Message-ID: <20210409051613.GA4376@work>
References: <20210409023349.3325907-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409023349.3325907-1-qiulaibin@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 09, 2021 at 10:33:49AM +0800, Laibin Qiu wrote:
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mmc/host/owl-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 5490962dc8e5..3dc143b03939 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -581,7 +581,6 @@ static int owl_mmc_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	owl_host->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(owl_host->base)) {
> -		dev_err(&pdev->dev, "Failed to remap registers\n");
>  		ret = PTR_ERR(owl_host->base);
>  		goto err_free_host;
>  	}
> -- 
> 2.25.1
> 
