Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3528C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F223159
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 10:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAMK6F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbhAMK6F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 05:58:05 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE312C061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 02:57:24 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id x4so866064vsp.7
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlE4fPTZ1yMnshdBRsyZKLSjOByns15jZAxSZW9F0Lg=;
        b=QfpVd28GcG0HkH3/PKKA/la56voRFGeZu5Ce6Q1TJ7Bzz0y5ewiZ5f9YmTAk1WSixe
         YNH5TRPXob2qrjPW0K7VoLghSv6wJHFHlgQfE+3E/ALD3uoM3iA9/VnhwoChJbdPrWmj
         rSmOt33UFT1Asfr5znQsk150w9qFZoY+7lWAVYuVV2FDKHVy2boDpyDG8vz1+f/sQHHr
         Sc8TqLqUEPadbq90jAv0MVclPwVGTTGUC0kPDkDxGm3AIHbzRQ9g2UAgkPvVCYhPwmvl
         1eXYIP+NWIiVUAaO/CM8zA8A4mNK8ryq1QrDkrLe6+kFgkBHwSEogvtlSIf7iCFDDjDC
         Fs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlE4fPTZ1yMnshdBRsyZKLSjOByns15jZAxSZW9F0Lg=;
        b=aaVU7IjPE24ILE5HhAdXClJ8B7TaHixhOlW7UrptJtvlRsFSrg0vJfmF93TMrHgx+8
         3Akc++9bT0gSN2Nx8ruIPzNRrkntQttUxqTsjWUBjNA6kgTfpu6IKIYrxlOmc3X5mueK
         ln/63b8rfeyMWepI2bspWxQzhHgWgueWxiy7LMvw29XJUqPTYWYXw5lFHLYJ/f9YCbbK
         hKTcy1ewAUZzmEVmmrLgY+jmWbKDv2MjPM8DVZXcQjEf0o9GKUj5WPkYc3xsL07ixLKZ
         Z/CFAdH4wWt6uthNsiml5q2oTH+9X1N9CRBkcmUS+oSUeRuDj7D/9Xc0L4He5wFb5bUq
         H/MQ==
X-Gm-Message-State: AOAM533PYYSQnSWcE63xugUBc04s6LO9M0zjMdUvictlMfeCJW3aHCyP
        bWIQqsDdSz1Z9p6qklqXG2Pfv45mxQk1ndaogY+OuQ==
X-Google-Smtp-Source: ABdhPJylCBk8ftDalZKJOD9fy3JQxTSSB7pmwmrknCJze8Lhe4wnZeHNWqQJp+zJi/SiAZF2g/ocboESwmRaDSO2Zcw=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr1118480vsr.19.1610535444038;
 Wed, 13 Jan 2021 02:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20210107055457.14948-1-a-govindraju@ti.com>
In-Reply-To: <20210107055457.14948-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 11:56:48 +0100
Message-ID: <CAPDyKFp89zPwr-SS9wgR6C5RM+KhSLWbkXivxAttRqTxtiVGDQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM64 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 Jan 2021 at 06:55, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
> module as the same IP is used.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Do you have a corresponding patch for the driver as well? I would like
to apply them together.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 1ae945434c53..34e53db29428 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -21,6 +21,8 @@ properties:
>        - ti,j721e-sdhci-4bit
>        - ti,j7200-sdhci-8bit
>        - ti,j721e-sdhci-4bit
> +      - ti,am64-sdhci-8bit
> +      - ti,am64-sdhci-4bit
>
>    reg:
>      maxItems: 2
> --
> 2.17.1
>
