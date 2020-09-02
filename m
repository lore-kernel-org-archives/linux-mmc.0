Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCCC433E6
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CBD2072A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2dRUJAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIBIA2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBIA0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 04:00:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C46C061245
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 01:00:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y194so1140247vsc.4
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3qiLLTJ163ZezFQOxUyBEfpH7dZSEHY07BrmQjwQ10=;
        b=J2dRUJAPRKJNZ6kjeClaDcg8FKQISjKTsyV0IqNvkvm8oIXRMKwc6++nEInJ+FAveJ
         71m9Ez4u84ucU7qpERks04v46tmMbHTLPozpbT0X1FYShE717LQb2XUaJx5pLPymeaDh
         wZsH/7JEcwOgoVL0+ZrQGK4jckM20x7KUn3D1um4VzuPTLMDV+zyuHBGvre0Q+eaibo+
         mgHGmsLsHLFV7+9b16jZfSsq4tTpPrYz8G79xrbkelHwwBcVYoibDuMUMFrVQAXFYEW1
         BWiBE4mX+i++2+ffjaWlxMLNoXSxV19jB3Q+/wNp7nAB+ESwG6ys85d/DVJNrhZkRcnw
         7XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3qiLLTJ163ZezFQOxUyBEfpH7dZSEHY07BrmQjwQ10=;
        b=ARXhqZZkN0otI5xzYJl9U3BpPriHgOtpsjEFx9KrOIpceIPNb+ddUJ3a9yiSKfAVg+
         l/67Jb1azsQZi2K/pU8Ifmcl7CSzKIiUk+WE9rq5twPXxeNZrWkApDIm0iZtiRjMGuEi
         B4xKQ05QlcnOB4CzSF9/bptjXZtAfQeoAg1K2+XCAfCGMS4GGPlYA6oRUEmfkZZ9PjcK
         lvjPZk8JmBDRAQKnZdr1wTB/FiZi0XURb5E3oLldQi7f69e5GtvyRowaEOUcotwXZz77
         ezSeku3JGJuHBOTIzZfsh6enkE04vUBH3E6fDBvEk5VuWejW4h57PjmcLnz3pjh6nENs
         uyMQ==
X-Gm-Message-State: AOAM533QiiOg8cjbFa13HSqWtHriBx5dkDtjgV/OXR7bv3K4U5d89K+L
        Xj+jX/q6r810CfdKazy4cOhL6DDrbzQdwGw1+OPOdg==
X-Google-Smtp-Source: ABdhPJw4pxYBoyAjPOpy9jjnp1tb5bFMcMQ31LSjfmXEH97ZZKGyzx6vQNEQypQldO3MGSOSxfvwRaddzBysnkXFvP4=
X-Received: by 2002:a05:6102:3105:: with SMTP id e5mr4594053vsh.87.1599033625321;
 Wed, 02 Sep 2020 01:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200902040623.17509-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200902040623.17509-1-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 09:59:49 +0200
Message-ID: <CAPDyKFpbK72utA0O1gTR30NzKzmtGCFbAKL6BJA+rUVdDhOstQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Yinbo Zhu

On Wed, 2 Sep 2020 at 06:06, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Commit b214fe592ab7 ("mmc: sdhci-of-esdhc: add erratum eSDHC7 support")
> added code to check for a specific compatible string in the device-tree
> on every esdhc interrupt. We know that if it's present the compatible
> string will be found on the sdhc host. Instead of walking the
> device-tree, go directly to the sdhc host's device and use
> of_device_is_compatible().
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Thanks for the patch. Indeed, this isn't the way we should implement quirks.

However, could you perhaps do the OF parsing in esdhc_init() and
assign a quirk flag that you check in esdhc_irq() instead?

Along the lines of how we do it for "quirk_delay_before_data_reset".

Kind regards
Uffe

> ---
>
> I found this in passing while trying to track down another issue using ftrace.
> I found it odd that I was seeing a lot of calls to __of_device_is_compatible()
> coming from esdhc_irq() (the fact that this interrupt is going off on my board
> is also odd, but that's a different story).
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7c73d243dc6c..11c8c522d623 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1177,10 +1177,11 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host,
>
>  static u32 esdhc_irq(struct sdhci_host *host, u32 intmask)
>  {
> +       struct device *dev = mmc_dev(host->mmc);
> +       struct device_node *np = dev->of_node;
>         u32 command;
>
> -       if (of_find_compatible_node(NULL, NULL,
> -                               "fsl,p2020-esdhc")) {
> +       if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
>                 command = SDHCI_GET_CMD(sdhci_readw(host,
>                                         SDHCI_COMMAND));
>                 if (command == MMC_WRITE_MULTIPLE_BLOCK &&
> --
> 2.28.0
>
