Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B1C41513
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjHHTOq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjHHTOO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 15:14:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296135DF6
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:37:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so5836766276.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512601; x=1692117401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyDtqRMa+XeuHmfOHzoFQ2EBCRcPgUdz7VrLow00vho=;
        b=CMz4nKzE/Z/zx11wTmzJmtizIsBZHKsYhMQ8iBxmvUb/+AsNtCalWFohkIlz8j8NUm
         BEPR+KFy0yk+W9wtqKT9wzKDS+PxVvhRFRc6bGNmr8e64yxdRCj3BGp3dMzFN/ikNnwV
         OD02dpZIj/PKLj4zB/9hzXWJGqErC2eQ4UfkVrkmdB0lzhO3X7RK0tCB//u8oKefcEes
         patXrunPqUFZhW201BbVEI6ietx1JZkCt/KdO+lDCtUXp7QhoJnRZFc8e9zJUrdlVlDH
         BYdqmOsmZ0dtgwPNL5BhuhVyMKcgvrgdEeyYHsgo338vIKNe6q3s6iltl55GmCByr2O1
         HpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512601; x=1692117401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyDtqRMa+XeuHmfOHzoFQ2EBCRcPgUdz7VrLow00vho=;
        b=ZbwWPr5t4/FhXn/jk7nr8WVzE5leRpdlwih9MBUrCp3QRzylkxLfsjixSF4AXn3XUz
         jJN+YzlAIVUiVfMSUeJe9FyhgqJ3zhTsvSTb2M8bs6WchkI0+i7JDDeZ0SqPmeuyjeih
         krX2c6YHifCBaciQ3nEL8JQ50VKgnAL5esWbrvyyXOjJPs5GZCuZrHCv1YKV2WJc12YQ
         rk3BPz8kJ3BCZkcwdtt02Bw0GN7wapIMmBofsv2kM12Z7boNIt3sX95HHzbFEbVwr89A
         /1ad3u5ZO8Gqj1X+UAOXAuRrU3FlVXpIhofxDcVrBfbUH5kARVwYICEFXhUKlAPCFFcg
         BNog==
X-Gm-Message-State: AOJu0YyNP3MwJ+JG+f7IbkihvmxbgaVm+XdUSuu/Ov0O2I0n2H/7QGfV
        9akP0Q1MHQbEUs+aUrOsey3NwqJusXJlTZAnsNOKF3huoRG4Mjdm
X-Google-Smtp-Source: AGHT+IEyc7HHsMlkF2r9nll2T0yEWZZ5v0pKzIcru7d42nj6cqrIRE36KBIE7qFz1IaWZ2c38uHVZnZYbGIn7T2NF0c=
X-Received: by 2002:a25:8d12:0:b0:d1d:514e:27c6 with SMTP id
 n18-20020a258d12000000b00d1d514e27c6mr10881786ybl.6.1691492001963; Tue, 08
 Aug 2023 03:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
In-Reply-To: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:46 +0200
Message-ID: <CAPDyKFoQk+ETga2za3=pLdN+btKsy6tx70o3wsZGZFQ0XWmEVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: Add power-domains and
 iommus properties
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Aug 2023 at 09:23, Michal Simek <michal.simek@amd.com> wrote:
>
> ZynqMP SDHCI Arasan IP core has own power domain and also iommu ID that's
> why describe optional power-domains and iommus properties.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index a6c19a6cc99e..3e99801f77d2 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -160,6 +160,12 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
>  dependencies:
>    '#clock-cells': [ clock-output-names ]
>
> --
> 2.36.1
>
