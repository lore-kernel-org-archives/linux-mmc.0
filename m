Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4606C25B47
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Oct 2023 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345667AbjJ0KD6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Oct 2023 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjJ0KDy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 06:03:54 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49035194
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 03:03:52 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e19cb7829bso1095411fac.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698401031; x=1699005831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zsWK1OgDjICTXVg+y2fnxE5fIMnUa5Iiz/sVKW4pjEI=;
        b=AjQtDNbL3Y5LL0A/UP5QJoWPZXnsCLfbohGC2fs3tSrqLYQyhgLiFe4E5xn8YuhtZ7
         xN/TJkCDIcOG8DVFXWuyOHcnMKRPkM4yzY6xl1Z2oHImZAbChwohgdKeQ5KQit6+h2MC
         aUt34fOPw98Qg+xaoFYSGyjeDfO7j9sf66OsCziwDVXC40X24M1e5EM3qKC/aDJz9DQz
         1RnO3xjezCDWpwlVG8nRAgcx72MyIjkCjSdaOibDm13wd+rmLCpfDb7HzAbDTDxqe7E6
         2oOmxQAN9oYX5y056QIOAw92EsJom1ffNTeqirrjdOfCfMC3XCCBK280w6cbLfxq07yN
         SE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401031; x=1699005831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsWK1OgDjICTXVg+y2fnxE5fIMnUa5Iiz/sVKW4pjEI=;
        b=Ib8NfwdAGBRhqOFeHRdh3XygH0mRDs0+Y6r04fd46hBkrAed/SEpWdz+DuETR5D1w0
         EyWRupJcm9dHwLboO3DlFnvdu+4obZeW9iX4lSyisQbGVVO/gCsdTB52XvHfo1yPLM8V
         S8Kb7LqI9QfaE6/hS7ZY/dPrGiHQo3CR7MEe/FI1tVKd9bDxDk9ExVkXkHtTWVirfqhs
         WNTo/+/Y37xSY53K5l2LzxyPKhuC7d6stFIWEdu3gdjOCcBmWWRWwtNgubcATY3D11IB
         6IBZL3x1dSRJ3uAWafTjGTJfn0fV8swMtSonJGkYqAFNm56UaASjP8Q9CK1GXsffItTG
         y4lA==
X-Gm-Message-State: AOJu0YyQIpo/7Wc1Oik6/vi6hANjtm6z+jcJ0wjmeOtUfROVeDTF9FKX
        1iE6HUkWVhOUn+dp+Kf8tOEGiHW65p2ngsZYaoW6jw==
X-Google-Smtp-Source: AGHT+IH7wI4TactJw4Ii9UHtb52uYCU7O9TJ6Nhj5u3wLFU+xns7qj5V3PuIa87IFs656AW02q6QPGJSuZZSsMoGVjY=
X-Received: by 2002:a05:6870:f619:b0:1ea:2506:3e90 with SMTP id
 ek25-20020a056870f61900b001ea25063e90mr2405935oab.35.1698401030962; Fri, 27
 Oct 2023 03:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-bindings-sdhci-v2-1-0406fca99033@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-sdhci-v2-1-0406fca99033@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Oct 2023 12:03:15 +0200
Message-ID: <CAPDyKFoeONhEK9BjEpmEvHXzHHxZZPU5TgmBu8dP-m8DsR3NGg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: sdhci-msm: document the SM8650 SDHCI Controller
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Oct 2023 at 10:28, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Document the SDHCI Controller on the SM8650 Platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
> Changes in v2:
> - Fixed typo in subject
> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-sdhci-v1-1-e644cf937321@linaro.org
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 69a213965089..86fae733d9a0 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -58,6 +58,7 @@ properties:
>                - qcom,sm8350-sdhci
>                - qcom,sm8450-sdhci
>                - qcom,sm8550-sdhci
> +              - qcom,sm8650-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
>    reg:
>
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-sdhci-3a47f07807ae
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
