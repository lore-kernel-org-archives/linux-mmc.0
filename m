Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB5CC61DA4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Mar 2023 12:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCMMuc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Mar 2023 08:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCMMuX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Mar 2023 08:50:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62630181
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 05:49:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d8so6819989pgm.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678711794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx8jF7FKGmBoaIt+aFf1/ouqS3HHqR+OXeKb+Cy9oZE=;
        b=HKEZDOm+mV1HAdL7ER3iR1vWEz+4AMwcB8/eiYzfDT6G3vlc/AaUcvMnA+QJ8TeT8y
         VFxsnjxJGqsNiwUpJ+hn81fvGKZv4x+d58+sjI9u4cMRSUA0YEmcNXr/ygpARwkw+f7/
         eAchNtNYJBBtn/PE4ARsywNpqb/J+N4HdfukwE8Mvc+YC+nrIxTOndCSaacbcVKRBN/3
         DBI2ew5D4qaoQmlBSUIF6ZG1KxARWrGfgil/kWwcGRNUbrJOfxigAjZTxycUfS7z1Wpf
         9kpY6jDanHkZIjl420k/BbT1PmWkmPeGFVFO3WSLSBbMcAU9MfOXdev+i0VBNBL/JRUj
         XQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678711794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx8jF7FKGmBoaIt+aFf1/ouqS3HHqR+OXeKb+Cy9oZE=;
        b=qf1QyE2LH2mHysNbx2Qjm6KogmB35Tss4FEwZJDefxqy8nPWkExAFMzet/himGFX3H
         6D8/duKSj/guvm4vqYMJtJy9HfSpGhcQTUw5ACUQb3ixf/ljvP27o33I7hzXlowEvq26
         F34/uXoovJ1pAUBmHUx+d9iFVnHuXPEbg6t3tRmaOZeDjQFvtfaEt6cfBoObhOJ55VZN
         0FdIY/zLbXygY36DpNAwo7KbrhED/1UttE8n58xysZXhQKyPbVIJk8vSi4cePSEDktdz
         /yoj25XNFWnmuWsGOvKGVkJUXcnTeliZF9aPL27cqqDewGiUazgNXRzB8Q2KGv5d31Uj
         9QZg==
X-Gm-Message-State: AO0yUKUwNbL3rj2vM+aLzc43VS6ojTFhxgJJ0qJNuIxTPjZtFWHH7z0J
        RGvXLYkW1Ufx1PKhHdXVWMr1TmRlp9pmmsCTM1ffRuC057TleehzJ5Q=
X-Google-Smtp-Source: AK7set+nraYkEbzD7lEiHtt/giSmKeJ3bPG/6dv6QjfYN2aLbyojc2xt8UY2wcR2r3heZo8J5ExHI7B2fVzTC6vEaTg=
X-Received: by 2002:a63:f91d:0:b0:502:fd12:83ce with SMTP id
 h29-20020a63f91d000000b00502fd1283cemr12062421pgi.5.1678711794210; Mon, 13
 Mar 2023 05:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Mar 2023 13:49:17 +0100
Message-ID: <CAPDyKFqaq5ysudyqOe0dB8fm=+p_ywpXdqQr33QUCq3j+Bqnrw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: add static to !OF stub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 11 Mar 2023 at 12:12, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The sdhci_get_compatibility() is not used outside of the unit:
>
>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for =
=E2=80=98sdhci_get_compatibility=E2=80=99 [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 328b132bbe57..245e56324dff 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -73,7 +73,7 @@ static void sdhci_get_compatibility(struct platform_dev=
ice *pdev)
>                 host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
>  #else
> -void sdhci_get_compatibility(struct platform_device *pdev) {}
> +static void sdhci_get_compatibility(struct platform_device *pdev) {}
>  #endif /* CONFIG_OF */

sdhci_get_compatibility() is using OF functions with stubs for !OF.

Perhaps a cleaner option is to drop the #ifdef CONFIG_OF completely
around sdhci_get_compatibility(), thus we can drop the stub too.

>
>  void sdhci_get_property(struct platform_device *pdev)
> --
> 2.34.1
>

Kind regards
Uffe
