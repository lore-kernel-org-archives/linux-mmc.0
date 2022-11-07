Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01613C4167D
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiKGUOi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiKGUOI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:14:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4372B628
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b62so11460814pgc.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=DLbUXpx5BGpG1DMQLOiBzekr6LKIQl3xNK69EzWu9cBTt0IhkdmZEwISLEFENb2XyY
         F6/uOEAYvPy0pCsiKqNfvo+OIfm6SIX23KDx3yvMgH3sgSWchQIKDJE3GlzipiOCntXn
         /clhW8ucjAP0zT0zof+RkYMmEXv6b4ZGsStnqT8oNHT2Ijc8ADMZhCAzlI2lH+fr1/YO
         x8c4BelTxgBcJGxLGvn23wE5GsMamdtb7aMOLH1Yng9pUzNmTj0K1sanTKJko582ilbk
         F/TgKqkz4ALp59zsfD87HDFQgUw9Nn7h4v9gTInuzb4aaEecdA3lo3c7rkliEi2oPP/4
         KM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=QLfbtBES/Xfq5XV6p0rnmQe1d464jvX8TzK+oKPJ8tsBjYAqfLF7gqMrdLXE/pM4vf
         bHzvTH5Y4rSj9eoIRbs/8ob48COsxeKltsoWG0zWDDHkMGWYRslXzdep+YaJaMqiSZK1
         dZUqPI9rdKNcqVoTFLt4F/YYFi0KVVBMOJNM0edfkEJVDE5yctj+MEUGm4WZ9KHR3sFE
         ciGSHYIzxveQ3QiyTqM9HDyr3W1Vy5atFFYWHxNcKvP2lmHO0rvcPdD9t8K2y8AaOe5e
         7anxAJvsZN+F7g8wI30eWzeVqAp6qjXPmaM6VwlS7OjWsnhyyrJ7xB1NFWPSToVa6gg3
         oTcQ==
X-Gm-Message-State: ACrzQf1DJ7e+JK2SslDH94jxzhcabkbFP3bmbgQdqBIJZ2hN31MxQLvq
        li/QgEQn8Pj4e1vgBT6oYRhI2dQJUz6E7j5fy6QdAw==
X-Google-Smtp-Source: AMsMyM74vaf7W54OL8zd+LH6la1LzG3+QlIhG7MtdJ/FbfqblOiiJopqiebGx/275JBCdBk/+joGXH2EXp7Nnh5kKbs=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr46115918pgk.595.1667852038821; Mon, 07
 Nov 2022 12:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com> <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:22 +0100
Message-ID: <CAPDyKFramrp3gvOCCULC6anTh9ZfFbdtSgrmE_iGCJgbT0vYLQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Nov 2022 at 18:22, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Document the compatible for the SDHCI controller(s) found on MSM8976.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index a96f143479c7..fc8a6b345d97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,msm8226-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
> +              - qcom,msm8976-sdhci
>                - qcom,msm8916-sdhci
>                - qcom,msm8992-sdhci
>                - qcom,msm8994-sdhci
> --
> 2.37.2
>
