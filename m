Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594FC4167B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1852522B39
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLDOkh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLDOkh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:40:37 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99FC08E9AA
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:39:06 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s27so7930883lfp.5
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCvgf9SsePfgxYMuD1WNMKjq/viyendYVg7MdniZolA=;
        b=VeTyCc9cXxNLbp1W4GPY73r1xI0NKKLDr84XjBcpHqLokqbvULGt9MwbbkPly0tSu6
         29+65aa8KGh0MGS5C+EZdKq33GMRLQKua8u3yLZAKNEUGogjVYeHaaSfAfWN6h1aRUqh
         lG6q4IIMR//hI1DZKGIvDJXWtYDBhq5fAxvENZVaFRFzWpuHGK7ce6beir0KJuXcEJ90
         YwSI4aZJpkdQ41QXopHfLQGWz1c3Il9UrRXfmaPSbfsizkF9AxPz7dEPHon37TaJ4K2v
         dnLkWZpWyLGYC4OhbPg5YfQ7SvGXZxL3dhbd5IfoW3LbjOAnwoQWv+UmcTcJu+RnrprB
         m5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCvgf9SsePfgxYMuD1WNMKjq/viyendYVg7MdniZolA=;
        b=iepZfHVV8THzIpGsvrm4UPWPvV+eUaDcRZh2NU3UuBELR5AmUBfv6g+yNt/Gs5kgtM
         oB2SdK0oShSP5nUcqqUSj4vnnqo+e8dw1w37TtXxv6NrFnzQBJzUkRfVhxTob6d4nlrS
         n85N0wHRx3MYorHt6vmC+TeZne//QlzIbAyQ2V90TxNrrDkKcb6kzNPHH+lD/s8UfdN0
         OBo4uQh1MdF4LpQDxLuSABzK7rtOhNcXldjx7eqP8BF0O+kpnxX00E9BeyJEfMk7zq/C
         2Hog+87WfyG/3sZSpb/25l9CGqsPSjac8MDIxoaD5MfWYKMpW9Qxj2HnTXj2PS+Nbhuc
         wDzg==
X-Gm-Message-State: AOAM531WFx7Z6Z84ep394FsIMcZb0BpL1kJOeaPJHj8NHasF2xRHfAfe
        rBH0A+cb1eM7cI7GEJ9WtrN+/ZIvsKjurQuCl6l4Hg==
X-Google-Smtp-Source: ABdhPJyXme2sn852/oSVQ2LSWRFUTlW9YLFL6WModQ4nu/BipCDYdbPjNCrjJI2L4cpLI/5sXGDNK7CadH2SUm1+x7I=
X-Received: by 2002:ac2:498e:: with SMTP id f14mr3229359lfl.59.1607092745405;
 Fri, 04 Dec 2020 06:39:05 -0800 (PST)
MIME-Version: 1.0
References: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
In-Reply-To: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:17 +0100
Message-ID: <CAPDyKFqTqKeV0kjqddQVQkdJg4iu04Yq+aT=4A6_bVxMZzwYeg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix xlnx,mio-bank property values for
 arasan driver
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Dec 2020 at 14:16, Michal Simek <michal.simek@xilinx.com> wrote:
>
> Xilinx ZynqMP has 3 mio banks and all of them are valid. That's why also
> list the first one which is missing. Property is enumeration not range.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 58fe9d02a781..8958e54e522d 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -147,7 +147,7 @@ properties:
>
>    xlnx,mio-bank:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [0, 2]
> +    enum: [0, 1, 2]
>      default: 0
>      description:
>        The MIO bank number in which the command and data lines are configured.
> --
> 2.29.2
>
