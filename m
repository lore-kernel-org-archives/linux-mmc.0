Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D700AC64E69
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781D02078E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwsLqXy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbgKWQHs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbgKWQHs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:48 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031AFC061A4D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:48 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id y73so9391553vsc.5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h1uRxI+FAxlFdCzQqRhFzGu/VFJH9a8yX1Pv1mpupxY=;
        b=nwsLqXy/5k+8M/TiI8Ak9AnCg9omfJmI0EXqQiMHYdHOZAusx11RgBB1ILtlsnLJQH
         CAz+48vmGYPdJEZbUwlyU0fSa2ugIM9AZo/V7fPvvAs86hP+tKQV5AB+rTy86Y0GQRj8
         KTLVS4UbhQgdCJCYzKoT2fv/P4WBMFU6ZYEC96nqyzEyyqI1O0v0Et0E0g9TcLbHEvPY
         lyMJNcf0C6kW1ahr9Aji+PtITR3pjfFoH9Jwl+Ujl0F1c6KAWOfYEnZ0qA6C15pYK8wt
         9ruYbuPnIcvRAgYO8L5SSe+QsagozKtyPQqI7sOVpc2M7FyaT857NOl3nwsenxcviEhi
         EWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h1uRxI+FAxlFdCzQqRhFzGu/VFJH9a8yX1Pv1mpupxY=;
        b=P8a3u28sbow7SMwAVCkq+r9PyXOotgOgtGlNU9+i0jyhVpHwnMkrT3CY10OMyLa1YD
         gzIk2ntcDWgQAlC41JP/luBx67rDdvQvHVnDdv01bGZT+h1LCs2/rLG4QrHLsOQYG6m7
         evPdXfMsKFfkWqhIgGN6yJar2dv+QFnxXXajr9lIWkS7e20mL/dFEHrptg+K8aKB6JcA
         wgnwdg+roX5bBfdNCoZpzp2x2x9tvPJNnokdYrrrNywxnYEvAKnAb2dYVF+V/++ttJNa
         wXHorrkL8egxtOWGYQfDMwFKEOHeswZXh9XSMwBX4Nl88IaUxmMBiOiQgqW69LyXtbko
         pO+A==
X-Gm-Message-State: AOAM531BfU7qY5j9jx/7KSHj1txxchmTmbh6HD5qsiFOmcCYsDpVmKd5
        MV49T2EsrDdbGiySK8kP7WJIPMkcWEl5DW15S3QNKg==
X-Google-Smtp-Source: ABdhPJzm3rcFOegJPTrbS+PyxshN7G6VRkXDMBv85G4d+Xd0s4bXDt0IBRyKr5R7NMXAoktvK0uDNc1N6R5tq7L/GQU=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr20204149vsd.55.1606147667002;
 Mon, 23 Nov 2020 08:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20201120162344.485921-1-krzk@kernel.org> <20201120162344.485921-2-krzk@kernel.org>
In-Reply-To: <20201120162344.485921-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:07:10 +0100
Message-ID: <CAPDyKFre-8=tTShjRF+Pm2cQkGnN3HHcO42SgmCEfRzLoHDNTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-st: drop of_match_ptr from of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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
>     drivers/mmc/host/sdhci-st.c:512:34: warning:
>         =E2=80=98st_sdhci_match=E2=80=99 defined but not used [-Wunused-c=
onst-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 4e9ff3e828ba..962872aec164 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -523,7 +523,7 @@ static struct platform_driver sdhci_st_driver =3D {
>                    .name =3D "sdhci-st",
>                    .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>                    .pm =3D &sdhci_st_pmops,
> -                  .of_match_table =3D of_match_ptr(st_sdhci_match),
> +                  .of_match_table =3D st_sdhci_match,
>                   },
>  };
>
> --
> 2.25.1
>
