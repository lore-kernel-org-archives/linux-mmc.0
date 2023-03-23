Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14138C6FD1C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCWMNb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCWMN2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:28 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B201C7EF
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:26 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-53d277c1834so391104647b3.10
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n4JThIvTj6PwMP8Tc+wbes5jB+9//DVarS0wUhW+9E=;
        b=YQV0ifFChMu+GzWnG+rbhqAGf40XMt4vuCpKsVheY+wiWYpZyRBLpaO4SFujLcWdNy
         P0s775M0CzMr5ghPG+Vt86ixzyiSJ8O8+kjI6fSGf9seP5Va3A9wdcbR/iAm+gxRpkXL
         6bHCpCWPcgwHfmXFhdIdG/7sJ2mEPxGNEVCmM1cA9F/JzxME8tdd5o8M4tvbz/dyCGaH
         sUNQ4EWqwJQR94p54LwwjvYeOULaidfYLVC7HGqgqGz5gd8h11qVSWNrB20fhmE8P38/
         KGMsFhJOs1h6n07rAtXOSPh6BmCQz8IXcCkLRdNTapFIJz7dvRptreXGESmvVL4CaRII
         nFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n4JThIvTj6PwMP8Tc+wbes5jB+9//DVarS0wUhW+9E=;
        b=CGBQAO3zdL+ROcHooisX/sWSWHOoisf1YFTkbZ3UXQjfwnSyg8apuuKQ3gv1yZE8wO
         oy4LMceQWtjYQAXe6qcSortBMbjfvC8ubXLUSDjKermdGWztUzQVaR4P8L+AtoF5p68g
         iliIjVzi9thEWN0NnLjFQx9OMXym3p2uiK4OqNBzZ5sQPjjuqEPu2spD8Abf6hPNS2k7
         0Ow15VLWIUoO/0HqOvhfLrGxWO2oj62nVQg8b03m9NOhnt8iVf8OqJmQ6BKc+cubmv+8
         xVgisW5krRs6easanwEuzApy5q7CYJ9Mhy9/BuypgpjdNhilleXwxD0xNkFm/2w75oAY
         ddog==
X-Gm-Message-State: AAQBX9eQkYd5mJ/z5U3IkZ1aPIFaV4QV0MryD3QH6Pv89huVjoIaLDgt
        F4PlpEkXRh99Rp6xJrMMoXbfG0mhkP0OPjlT7Ruaqw==
X-Google-Smtp-Source: AKy350aO1QSF9/2PBO4hdxQ8GSTVuWIPHxMlMcuBlCXl9q9h79YdWWP7wx9g9FVfJldi/WBStp4oDHkprcc5VDjjriM=
X-Received: by 2002:a81:ae1c:0:b0:52e:e095:d840 with SMTP id
 m28-20020a81ae1c000000b0052ee095d840mr1766782ywh.0.1679573605233; Thu, 23 Mar
 2023 05:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:49 +0100
Message-ID: <CAPDyKFq_ak_40PKm2SyuyZzHQkKJpUcLkGr_HZXTgcCfzZFjcA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: drop useless sdhci_get_compatibility() !OF stub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Mar 2023 at 21:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The sdhci_get_compatibility() uses OF functions which have stubs for !OF
> case, thus entire CONFIG_OF ifdef can be dropped.  This also fixes
> !CONFIG_OF W=3D1 warning:
>
>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for =
=E2=80=98sdhci_get_compatibility=E2=80=99 [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. Drop the stub (Ulf)
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 328b132bbe57..673e750a8490 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -54,7 +54,6 @@ static bool sdhci_wp_inverted(struct device *dev)
>  #endif /* CONFIG_PPC */
>  }
>
> -#ifdef CONFIG_OF
>  static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
> @@ -72,9 +71,6 @@ static void sdhci_get_compatibility(struct platform_dev=
ice *pdev)
>             of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>                 host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
> -#else
> -void sdhci_get_compatibility(struct platform_device *pdev) {}
> -#endif /* CONFIG_OF */
>
>  void sdhci_get_property(struct platform_device *pdev)
>  {
> --
> 2.34.1
>
