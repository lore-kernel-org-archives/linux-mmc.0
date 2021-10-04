Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C9C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15507611C0
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 14:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhJDO6E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:58:04 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33328 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhJDO6D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2021 10:58:03 -0400
Received: by mail-ot1-f41.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so21899479otu.0;
        Mon, 04 Oct 2021 07:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeUM07RhvrYbbVT4CwAvE71B5q6FutAaaYoosNs/OLU=;
        b=gREl8FImZj+BjLKP6VHE26BVUmJ7lhTqnKTfWupCrtowfNjR7pouOxowvpXjlG5tCU
         MmEpHky8tXV25XVjF6gRb3EtHa5D86SkAGw9kLazy6C6x2Bd+aHp3jWLe5BzUE/BwP+C
         0iD9JsZ/I3DkmyttPV7qQ5NK8xQf3SMyZ6WVuMBMiSWWBoiaSnNJCdFkqc2rVWtTBXzF
         DFeprGk8wqFMd3MHI8UleGyud++Gf6RJzUDE8jmLnfbCWwMQDsp82e6Zp2t99oMLVQhy
         nHYe8zEffK+icIqEiLsNAd6D9DO4lJkeT+UYAglzA42BgBQSov2twzcqcnVZSeFwEKxG
         kvEA==
X-Gm-Message-State: AOAM531nNqrzmIUfp4URfM3BmPfIxDDCLfOh4fItCFKuPw6gMzQ87qmN
        4a5yk1oxG+f/TgIRZv4m5A==
X-Google-Smtp-Source: ABdhPJwTiPCJqeC94GsV+hyfmUppbS17ludrZGocAWa2w3O5UQ8A31nIxZVYFfsCsgGx6QuxxwA6UQ==
X-Received: by 2002:a05:6830:922:: with SMTP id v34mr9365861ott.240.1633359374469;
        Mon, 04 Oct 2021 07:56:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k15sm2899685otp.68.2021.10.04.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:56:13 -0700 (PDT)
Received: (nullmailer pid 1285437 invoked by uid 1000);
        Mon, 04 Oct 2021 14:56:13 -0000
Date:   Mon, 4 Oct 2021 09:56:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells
 dependency
Message-ID: <YVsWDaC0TOSOrrxW@robh.at.kernel.org>
References: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 28, 2021 at 10:23:46AM +0200, Krzysztof Kozlowski wrote:
> The meta-schema already defines dependency between clock-cells and

You mean the schema already does.

> clock-output-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 23abb7e8b9d8..dd70431df0b7 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -158,10 +158,6 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>  
> -dependencies:
> -  clock-output-names: [ '#clock-cells' ]

The schema defines this.

> -  '#clock-cells': [ clock-output-names ]

But not this. That's because in the common case, clock-output-names is 
optional. But here it is required when '#clock-cells' is present.

Rob
