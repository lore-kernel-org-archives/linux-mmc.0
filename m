Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C5DCCA487
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbiFOReE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357092AbiFORdO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17B13D5B
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id g2so14086563ljk.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMuSLekSSDNOzbBz7Sbh7aqqxzs5y3shIYxAO3doGSk=;
        b=qvNZCeQMqQVpGhWZVY1GQ9GhteXrum7Z/JNalb/nIm5KhnAocVP4gi0+DxyR3MR63n
         UmZIfu0pU/TIeTMsTpbN7Ydq6blBXmXDVGT2Y0capm9K5XQhyW6O3h8m7xln4GMM2CU5
         fGdE3ZR8qQn6UD37LoVrYAdNa6pA+rZAzfCIIkBmFCHbKMuYbCRXF9+F/aXy8Yhwxhn7
         rQBV+5Zry8CveXJadLalCVj/8IwUBOMLRmyTwbHMW28T1uPUIwiztqBVQcG6G8zcaILy
         Q8grg+u5Ok3EfrBkqWYp0o/uGZBgBcNCWsPiXpUZ418Z9sX0/zuLNsUP1mELbPVd6bMR
         hUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMuSLekSSDNOzbBz7Sbh7aqqxzs5y3shIYxAO3doGSk=;
        b=Irp7g8BQW7Lh7088zq+oxLgB75boSVHx+WCrC4zg4ftCvAtWaXMoJ1xkfsCEQJdsnq
         FufbbTnyivs5s8NI+m4Nz2keP4H1nV15Wpy4vGj7ueYIs3DvjqII+olRwc6D7R9fBVtx
         r8/i8jemy3Ni2GqNw4jSJ1Yl72cKj5jAbdLfX0U4Py9n09b5jmJQz15PmPC5H56tMxSG
         n5cbrfabBGuESvkp40Ja+TCilClA8oD0oZ9dDqvnZ4gsD0DULXNLeJ41XGAOqKvsgFTM
         Ys/PdgKn84xRAkrZs04REiEgnl9f+bH548trB/H9TpVGg56rpr+Hbz1nMyj1Plq5mHdI
         XECg==
X-Gm-Message-State: AJIora8c4X6afGmpPtEo0rKtuECi2hpFr0yuXNCYDxj6ju3XOeJbRzAb
        zwHCw/dpZsjRfh+wSCxrkUrw6+3bN1md0mEpn7lwjA==
X-Google-Smtp-Source: AGRyM1tXDcwLXpmyoF8KuRCfA3Zr0Dlo6AshMRMmzjWQrYEcisjdOEoi9nssJs916SBnFZG36WvXq8GTGAvI8aPu0l8=
X-Received: by 2002:a05:651c:12c5:b0:255:9384:b385 with SMTP id
 5-20020a05651c12c500b002559384b385mr444680lje.229.1655314392197; Wed, 15 Jun
 2022 10:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608122344.3431-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220608122344.3431-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:35 -0700
Message-ID: <CAPDyKFqTkrGrQTzjO0PR9MD0VOetmQb+fKdEt563oAcORq9x6A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Add R-Car Gen4 clock requirements
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jun 2022 at 10:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The patch enabling generic Gen4 support forgot to add the clock
> requirements which are the same as for Gen3. Update the binding.
>
> Fixes: 6aa26be14d2a ("dt-bindings: mmc: renesas,sdhi: Document R-Car S4-8 and generic Gen4 support")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index d5b29728704b..14945ebc31d2 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -145,6 +145,7 @@ allOf:
>                enum:
>                  - renesas,rcar-gen2-sdhi
>                  - renesas,rcar-gen3-sdhi
> +                - renesas,rcar-gen4-sdhi
>        then:
>          properties:
>            clocks:
> --
> 2.35.1
>
