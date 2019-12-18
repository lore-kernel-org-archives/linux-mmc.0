Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B150C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABE227BF
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIoDOfee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLROCS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:02:18 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33721 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfLROCS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:18 -0500
Received: by mail-ua1-f67.google.com with SMTP id a12so669568uan.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWfYBni5NvApXaQAN+Sc8AcAyWYbtB1RtpsTw1gA/Ig=;
        b=UIoDOfeeFGo8xJL7UOOA5AiHtOnoVYYX8uWUVSYGlN91z4GJFaIV3YUvfPbrkK6EaC
         kN+uw1xgypetPlU+ZEfU9QyIYqJy3XnYRf1RjpOeMfmO0rhb4J0O1iYnvCySqhlJ67hG
         pBmkr43dD5CdHdXH67Lr6LhaWtSPujA60xbFz71VAA7xD00Bmx0f37SXneXyo/tMTZnY
         wAokPjmzQ2ays98bjhWAL12sbuwFo4dkwmpPPg/isp7TCJVtyOcPNZXgOGZt6mQMSVPZ
         HLFnwFCGNYsQscjiVRnnABGHWMqY5ytLEZAzpE+/8TNkGb9R5VQhp9NsjuRb+GCX8Bq5
         Zfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWfYBni5NvApXaQAN+Sc8AcAyWYbtB1RtpsTw1gA/Ig=;
        b=P3ED6fdmBUVARanqvQKAvcNLt8fZn/6NcyYWtgfIWlM48mnYh6NB6aGimibsl8l63U
         +pO4uAFFUBATBS11j5iq4OrZ6fbjEuX+p6azBFgpA7V61HaLZ3X+Z2UFaK3Q++bz3gZa
         vSlCfrXgUABz0v7t3I2Vn/eHtXdO3oWBKb19cNvd+d5MS/8X7aNEQrZOarzSnzh8rmSv
         mV9rEOhBC6V+qIDKPXpS02slQMUEcLbIjae4RrFl1EtbHDL7KnmM4ifeP0lWECn4yRDr
         kn3/QGLUn431ckm7LMT+nKcbcT3Evurzq3iouTJr/2udmpg5BUeewFkw4yOF9zQg8BKu
         SReQ==
X-Gm-Message-State: APjAAAWuKnXplv8V1vvXovWpT5F59qu0h/ubX7iMCLa17obVV5IjziS9
        0IDOR9FMcOa4Q6p0bH9LxmL5dz7/A5EVZIWvl/gR3A==
X-Google-Smtp-Source: APXvYqzlW10cgVZlH4+ozp+d38GOPO+fFsjnBu+gNNFWD1IskWWWrLnsiB7uOFCa5PBl7aGksxtQ4pSl6TsVj61svpo=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr1519430uaa.15.1576677736310;
 Wed, 18 Dec 2019 06:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20191215175120.3290-1-tiny.windzz@gmail.com> <20191215175120.3290-10-tiny.windzz@gmail.com>
 <20191218063028.GC3755841@builder>
In-Reply-To: <20191218063028.GC3755841@builder>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:40 +0100
Message-ID: <CAPDyKFrNXqwHuTNkT-Q9=jswXyPXkNNg9eTWfzv-Rwd1P5JqEA@mail.gmail.com>
Subject: Re: [PATCH 10/13] mmc: sdhci-msm: convert to devm_platform_ioremap_resource
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-trimmed cc list

On Wed, 18 Dec 2019 at 07:30, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sun 15 Dec 09:51 PST 2019, Yangtao Li wrote:
>
> > Use devm_platform_ioremap_resource() to simplify code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-msm.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 3d0bb5e2e09b..6daacef4ceec 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -1746,7 +1746,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >       struct sdhci_host *host;
> >       struct sdhci_pltfm_host *pltfm_host;
> >       struct sdhci_msm_host *msm_host;
> > -     struct resource *core_memres;
> >       struct clk *clk;
> >       int ret;
> >       u16 host_version, core_minor;
> > @@ -1847,9 +1846,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
> >       }
> >
> >       if (!msm_host->mci_removed) {
> > -             core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -             msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
> > -                             core_memres);
> > +             msm_host->core_mem = devm_platform_ioremap_resource(pdev, 1);
> >
>
> This would now look better without this empty line.

Good point, I fixed it when applying. No actions needed.

>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

[...]

Kind regards
Uffe
