Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCCC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Jan 2022 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354828AbiALPyD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354837AbiALPyB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2022 10:54:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559BC06173F
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2022 07:54:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e3so6900506lfc.9
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2022 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYyAFRh5SH+tLzoheRlgRObQr9ySLLxzRHYNcd0Wi9A=;
        b=B36PhTv/y8ot87FGyfAV1Yd6KPZB23C1lyP86PPF+5ai1WrzwKI6fZmYLGRUvyXROc
         z+DtPrzs47GkFxIWthszxAsOfaB3HwPwUyBithnSN5n6HjtUxWuobuTybM+vOcbkGCTy
         q/V11w+dEZO7uYjqyu+zlltLdk9V4as2mbvvteojCdMxO2Bdr04DcKcSkkUHVxkdulUV
         jVPzLkVaSF66R//RjqsFkTvRSdIejm+SlDpip4MTO/9GvItDIp+uNmnkzp2+MLLDKa5T
         F4KfH+XV4LOCFc7bok4rYKRi27wxFzupogOiE3uNcZHOFM62+fsVUWwSPE3Z4e6heRag
         4DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYyAFRh5SH+tLzoheRlgRObQr9ySLLxzRHYNcd0Wi9A=;
        b=KAIha8I4LaQ8zjV9sHfFXcmIb7dBmDluIz32XUqPmxZsAZhfNQXo5xPaKrqawEdQ56
         wvsEpdumbKgJkvWHlWT71j6ge1v6meiUipRpE5TRoCtWNcg+N4DlWANqnqsbEU3e6Vv1
         kOaIwhBcqqH3XwiyIp8SCAe4ryPki7xJpEqnJAL8FsZy9uTuyBcx2nJ3a2AMhEpv2NUf
         lTy8D/ubck57X32oMxFCdPTVqso2Iwwnwig2ZCPWo6RogagMEnUA92emjQWS7pQIMjsT
         qH3mdftjjzlMo285X6kSt8CaH5GkR7nVgT83KIUmU6EnGeM5SbhOjP///+Rbe916atb8
         qJWA==
X-Gm-Message-State: AOAM533Glj6xiRnsTWTNuvhPKBcsK2hLnrvJsiiWMWIQbQHayqP8az82
        H2yEXjGzDFgQqz3Y79kHeDAZkXFXxwi2nQA3ogr7LMJqcOQdwq/H
X-Google-Smtp-Source: ABdhPJyT5N+fvFdyup4mAZDsy3JB2ZdGP72gxWL3G0mv3BYxXraTgkwewGOtgs9KgUsffMZR1dhFciJjLkS2otqrF4k=
X-Received: by 2002:a05:651c:98f:: with SMTP id b15mr97912ljq.367.1642002839063;
 Wed, 12 Jan 2022 07:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220112135453.5927-1-quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220112135453.5927-1-quentin.schulz@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jan 2022 16:53:22 +0100
Message-ID: <CAPDyKFqJ2N9EipyqL9C_5FnrsJ7B++QQYMGBS-PXV+fUJT58bg@mail.gmail.com>
Subject: Re: [PATCH] add README
To:     quentin.schulz@theobroma-systems.com,
        Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Avri

On Wed, 12 Jan 2022 at 14:56, <quentin.schulz@theobroma-systems.com> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This adds a README to the project so that the contribution process is
> explicit as well as the licenses that apply to the source code.
>
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks for doing this!

> ---
>  README | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 README
>
> diff --git a/README b/README
> new file mode 100644
> index 0000000..47f436b
> --- /dev/null
> +++ b/README
> @@ -0,0 +1,32 @@
> +MMC tools (mmc-utils)
> +=====================
> +
> +mmc-utils is a tool for configuring MMC storage devices from userspace.
> +
> +Contribution guidelines
> +-----------------------
> +
> +The project works using a mailing list patch submission process, similar to the
> +process used for the Linux kernel itself.
> +
> +One can document themselves by reading how to submit a patch in the official
> +Linux kernel documentation:
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> +
> +Not all sections apply but it should be a good way to get started.
> +
> +A patch should be sent as a mail (not as an attachement, see documentation
> +abiove) to the linux-mmc@vger.kernel.org mailing list with maintainers as

/s/abiove/above

> +Cc recipients.
> +
> +Maintainers
> +-----------
> +
> +Ulf Hansson <ulf.hansson@linaro.org>

Please add Avri here too:
Avri Altman <avri.altman@wdc.com>

Avri, can you please ack this so we know that you are okay with this?

> +
> +License
> +-------
> +
> +This project is licensed under:
> + - BSD-3-Clause for lsmmc,
> + - GPL-2.0-only for everything else,
> --
> 2.34.1
>

Kind regards
Uffe
