Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4086C63798
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6498B207FF
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 05:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYKjmgHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKWFhD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 00:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWFhC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 00:37:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6DC0613CF;
        Sun, 22 Nov 2020 21:37:02 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so16111084wmi.0;
        Sun, 22 Nov 2020 21:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/fB1W1Zt+rZ7jX36vcQZT+VWt9aH5euQuD+7zN4FXI=;
        b=IYKjmgHb7xOKKcKPuzBBs9eeHj3G3RRCyPdXl1rtxq6GbmEGJjrEpexDrNaOudc3oL
         jxSVPLfk2wHDW97Wg5qvnkhtka5mr2JpgGF5zra/EjZIyYTlr6BftbCHF86TodZfP+wR
         IwVQZwfR4HmpG3xt0b+J0WywY05jmBC6VhFqGiMGJ5GtkOWDYfZ6tDs+3wDraQkH9/3/
         EfiHKhzIH9IGWZJow2vLJu1afaSYSAYC8oFrbEbzxRhYwW6fPh0zy5XoQWlJ1Km2e/ee
         gCNL+tFQPD2wtfzwh2FkUwRAQjh0U/KZS9VhAhcRmffkCQoKDv8Vy3AUJfsiQruh8Jen
         TwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/fB1W1Zt+rZ7jX36vcQZT+VWt9aH5euQuD+7zN4FXI=;
        b=U+yfeYihl05SxIR9i/vXxvz0qiWTy54cgz/Mtj/WIpEKXjbSTXBgSkDBJeVepWuEF/
         1TzU+Kkc8jqLGaGh70m85fhO1sUkOQdXpD9HtfyegR9wOwH5Ol4iUCsQMmRw9mZeCF2g
         cutK8bpDwfFvbfG28sO5d82PcptV0VdUqiVUqHRVjUN4T67Fco3ZTV/NzsYxZbmwJIL8
         3bHjmZyJD2QkdTNV80Pkz2vspwd6W7cgnkukVkuiCE4iLtuayfdhrEyEWmkspnoga3k6
         +U6CJ1Vkppv7BBwqqAtdL7J8Gq9DbwMsuFTUQA8DZRWrBHmwM2g/MFldFkr47drs9V1v
         bE+Q==
X-Gm-Message-State: AOAM531IFWyatn4Ph1Ft8SUgfg3VdzTnD1wRvijTxMzvttystlKA7N1W
        TfKj2FXlrNt2uCxb3dJjY3gyNh1dN5xugP8aJ1U=
X-Google-Smtp-Source: ABdhPJwIiaiTMV6Udgn/wNaMydsi2gdrSk/t4y4+fLTS5oZTs0pZJ94ETlojU7MeJxQrzc8uZQS2IiY1KLDBOHpaCXM=
X-Received: by 2002:a1c:e1c5:: with SMTP id y188mr21518204wmg.81.1606109821129;
 Sun, 22 Nov 2020 21:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20201120162344.485921-1-krzk@kernel.org>
In-Reply-To: <20201120162344.485921-1-krzk@kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 23 Nov 2020 13:36:25 +0800
Message-ID: <CAAfSe-viA0PqAjNcvbC8JgngVcDc1+06FqGtKAdaPT1ur7kHTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-sprd: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 21 Nov 2020 at 00:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
>
>     drivers/mmc/host/sdhci-sprd.c:723:34: warning:
>         =E2=80=98sdhci_sprd_of_match=E2=80=99 defined but not used [-Wunu=
sed-const-variable=3D]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 58109c5b53e2..f85171edabeb 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -788,7 +788,7 @@ static struct platform_driver sdhci_sprd_driver =3D {
>         .driver =3D {
>                 .name =3D "sdhci_sprd_r11",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table =3D of_match_ptr(sdhci_sprd_of_match),
> +               .of_match_table =3D sdhci_sprd_of_match,
>                 .pm =3D &sdhci_sprd_pm_ops,
>         },
>  };
> --
> 2.25.1
>
