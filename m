Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFDAC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhL1Q6g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhL1Q6f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D961C06173F
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k27so31583589ljc.4
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy9VUEYl4Kb6sXtyR/nTB7egNd7gTmHgdkG/MaHFXvA=;
        b=GL0VLQrXiGhQGImNgxQpMrbaNhAUyee2YHUj2XdLz52818/oM4nASuvEQbs60RtxoI
         Vp3Qy51mMWRLWHwWhvGs3/zUCsLAu7oY1bao9P2vjd2t5zehJbtzqQh4Mj+MLgLTU13i
         YmiMG4PZ8yoSJY01xQIBBeSo6e0tXPLJyyKcFaOQ4zu2fm/lM82NyaknrJMJuCXHZZww
         aq4Xm82ENpk0Preh0pzjxWYjLKlxhNs0E9gI7sI1ixCM8OYCNWKvkwtTjv6jQAXlvr4Q
         CLynckOCF0Nwidi7PaBZ4dfuZhhYcrNp2xwcYVxBeFFm8nVqHcZPuc3VbT88UnwTQIp7
         otsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy9VUEYl4Kb6sXtyR/nTB7egNd7gTmHgdkG/MaHFXvA=;
        b=cTkOLOweaU9yo7mkzOsquO8ZnZR5DmroUEXENLIGmwExJte9EtMrxj63kYQYES8TWJ
         0z+hOrgmtS5bzp3dAvDvddSjxXcyorAIPDeUQ4DiXR+53UVo/4q8Yl4GNGO4uAaEGI42
         GbgVzjF6TgEUEDaQK3NE4J1fJ2C9eW+VcGx2dipKIdz4j8/tbLoV9BS3v+U5eUhRlnnC
         GFperOfGxXAN7t8NHoaDuFogHpfumulLc5ETg+3pMWkRqnxC5QQPOzaifjHOQJU+d8iC
         On+IN/F/K2xUC3g5CfVFeNbl5CKRstXf8WGYdcyXpt3jmxY/hkqR7EV/OlU4EzR8vQBj
         Pybw==
X-Gm-Message-State: AOAM532MapQQf4a+ZKoJHbcPW29VhFm5/WIzTT8vB1Pqml+OvqRj3lYI
        JBEGgZjwsyeptpDcDVrilV8py0Jz6wdGFy9YwoQEEQ==
X-Google-Smtp-Source: ABdhPJwvdTtR4FmGErwkbYhTLbQbxCt/6QlYm72hILG5gYjEAZ2gZhu0ybom8GS3sNmKRY5j1RxEY3xHXlbVOVRvycc=
X-Received: by 2002:a2e:a26d:: with SMTP id k13mr18569820ljm.229.1640710713333;
 Tue, 28 Dec 2021 08:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20211223225524.9860-1-pvorel@suse.cz>
In-Reply-To: <20211223225524.9860-1-pvorel@suse.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:57:56 +0100
Message-ID: <CAPDyKFpkpm3CoZ8jOwSV=-Y5wz7PZjwUKT6WR1e6vH5ymXhEqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Add compatible string
 for msm8994
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-mmc@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Dec 2021 at 23:55, Petr Vorel <pvorel@suse.cz> wrote:
>
> From: Petr Vorel <petr.vorel@gmail.com>
>
> Add msm8994 SoC specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> NOTE: resubmitted this single patch for linux-mmc.
>
> Kind regards,
> Petr
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 50841e2843fc..6a8cc261bf61 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -17,6 +17,7 @@ Required properties:
>                 "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> +               "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
> --
> 2.34.1
>
