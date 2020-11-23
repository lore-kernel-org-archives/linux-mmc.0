Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B39C6379D
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F1320782
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4/ndsvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbgKWQHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbgKWQHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:47 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F43C061A4D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:45 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id r14so9368758vsa.13
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=neKh8lc/wWos/iNaP8WSL7zrCvHB4dIxwGX7kKDy85c=;
        b=X4/ndsvPJR55zi/T+mrVut+IzMdLDitkajGBydN3gJteOBSqBgcIuZH9mF45Y67vaq
         1gKccgOB62Z9XgsNCq/Ay2OvAOrOR6s/TcaHSuDNO7brAhgYvEHfd84S30mfqLArc4/E
         8C+43j7OMYCOe0x+Au0GlRkL1kjSgSej0a7T6LCa2VKXxLW0CufbYDiblEGpC+VMIDqu
         aejy2CYw9dx+irfcuMvUp2sC3aSknWuGzIJ8FhqUUrc7he4sltOqHUDmdPap8OuF1Eid
         OpQwUzTZkaYjTbZ6U3ocwwE2jfCfJTLvV47TlnvZeG81gCuC8yb7BeVwfs3ismfeKx3k
         jBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=neKh8lc/wWos/iNaP8WSL7zrCvHB4dIxwGX7kKDy85c=;
        b=D2IwGnSN8FvaaKUhBRPeRs8YSr/c0/9/f4EPeKXdGL0XaQ+j9/vWXR+F5cemonI47X
         0FuwbliVZ1YVB1Xi9/GKigxVQgOgNZvsI41qB17a1HORtDiWI2g/lCtzurCIsziyQzlu
         6dI3buyerm8rIv5sy/VkxaYRaQAOSS70EYocDbUPbfjhq3FbNsl1UGmXkgHZFhdSpMcW
         wCa41wAB/48rJ96J5IDqyJuTBaVnqUv++i6s1jiArKjM2ofrXMoQYf4qpGnBtDM+VVVF
         kxe0DL2uu/NfVXvxW6qtw9WYKwWMdxh4IvyIqumJWJlo+qglXKPs+RzEROMqU5atyxBa
         RNkA==
X-Gm-Message-State: AOAM532HfV0eupHScqqllX1Iz3l38NyND2V8g5i1KVyhlrq7YIm2/s7H
        ahg/N3iqVUrgSmLhvf1Jg61OO4sJsVBqvFVUxYCaBQ==
X-Google-Smtp-Source: ABdhPJzFbhfleAS+9gkcRzDUsZi7EZdlN+F5L/n8QkIAsP4Pj4lw3JGZlZwy+vVUWrPBZ8jTWJW+IeLLgwIS3Iosfqw=
X-Received: by 2002:a67:ce8e:: with SMTP id c14mr375404vse.42.1606147662757;
 Mon, 23 Nov 2020 08:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20201120162344.485921-1-krzk@kernel.org>
In-Reply-To: <20201120162344.485921-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:06 +0100
Message-ID: <CAPDyKFoqpmSWh5-m0m_XB14w7w5RLCYZmYSkuNv1pCiQgYKWVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-sprd: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
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

On Fri, 20 Nov 2020 at 17:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


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
