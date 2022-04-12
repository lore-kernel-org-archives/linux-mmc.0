Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3485C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 14:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356573AbiDLO23 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356522AbiDLO23 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 10:28:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA458E51
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:26:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m8so6819249ljc.7
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
        b=twWeTn+wbEgNDoLKArv4PJZiTp6oZnld1mH8i8kfifUjKs0iQRcaZ+kHoABKm7/Scd
         3US+3G/CYRtfNcu/VWgVjD/mESRcSvcIiq5CsdjiRaS38+bj+pDt7bnKHFiZZyy820Iy
         aZmrwQNZT0Cu/zCKNZ/XbB/VTX3yMBgV3zXiAj/E2WNiWAicWfSc75KIq+78hwogMpYJ
         ar+m0WvCjAayOJzwqk4Bqj093B/gBIHVlORyh3lXABeP2HsUVwwix5DW5QTogpeQrC+D
         CGX3bGHd2uSBpxWDWvtTv2aV5r8qht5nyXVwZlMD8pbXO7nAPZ1j77itunZ4WducbwKT
         zxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
        b=xEmyaaysngURZF9hiau9FQLd3iVUhw+MYKoFAmfyaraQu6ceHD+WKZe7MsYK24Wf1c
         v4o+ptHO4x0myYcyjltSG96FmdWmMrJ5zgLD0pilMXJeKBPcMX8N8FdBthG4mEIbiyFh
         Koj1YotaXY8KHnUSo9BbagRNsYMhRK9N0CplCy0qYern7Ygl6DTWN1e6zl4Y/4uvLmw6
         HFrCP92tiRRRYU36WkqlfZE1BIwpu9lPP3T+dcWryiXMjmqg6FA+PMN7BhYmm9Au20DL
         JY92BZk7By7ieLRk2Qdni2lLb8WQxVYjEka0F3b+C/SJkNQB6mh1/fCdPzF95kDtb+cm
         2YiQ==
X-Gm-Message-State: AOAM532E4Stcnzl5EvfRf174QPBnosaSvRoJZLucmcvv0zqkzEaUez5h
        GgC050C7t73kjKWY5sErAi90OxHn9AnzuIx/DtkGZQ==
X-Google-Smtp-Source: ABdhPJyaj7tFxdrLYCr2zY8LfreX76pb3X9XmGkW2cSHqy2L9vVwR4doSIMzzrLhQfMLm15Cp7vZ1XdvlfGpOmv0uxY=
X-Received: by 2002:a2e:3e05:0:b0:24b:5df0:6388 with SMTP id
 l5-20020a2e3e05000000b0024b5df06388mr8356865lja.367.1649773569043; Tue, 12
 Apr 2022 07:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com> <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 16:25:32 +0200
Message-ID: <CAPDyKFrU0hQzs3xL8Jf1E22cS9DWuorLgcVF9+m80+Osw8=odg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Shaik, Bhupesh


On Mon, 11 Apr 2022 at 11:50, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

As stated in a couple of other threads for patches extending these
bindings, I would really like to see the binding being converted to
the yaml format first.

It seems like Bhupesh is working on the conversion [1]. If not, please
help him to get this done.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-arm-msm/msg107809.html

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..e7dec8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,7 @@ Required properties:
>                 "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> --
> 2.7.4
>
