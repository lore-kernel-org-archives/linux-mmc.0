Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DEC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiEDKmO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348371AbiEDKmG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:42:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595652AE12
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h29so1608947lfj.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYZZJ2RGWR4j938/XSjxsXX/60h4AxrLG5sI5Y987hY=;
        b=fdzBEJ6SFRCb7lwT03+s2FLMl65CCztPC2XYsZgju7u64bW6VBtAKc6qb8q0t4IhWq
         3Q+OdboG897r1ttwSDzTapKM2d5TryFr6PI8YqgF+ASvcbYqlXFFWBpCqX5wUZZL/Bbd
         tLKOZyGvWTeK/fpUurJISfy7107/e5gPxTIW1lhKrDCj0YsqgTIYLErtB6MlRTYt4l60
         oJHaKC5RU+pxgeBZMfl4IeP/Gp08t/+kHHUDI7Hx3/xzaesdZIfZszBFLNojscZ2Phlo
         2GRN97TPy/ss2hMQuIHCp/5JDY1er1uxPrMgD5HHBMImXPYjXab88iUyU7P/rOka/M2Q
         uJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYZZJ2RGWR4j938/XSjxsXX/60h4AxrLG5sI5Y987hY=;
        b=GWpkvfSxNrTrS+TSofholPw4TY3BZHKopqwhoDvktq2GiUAXNLSaJsXgzdCJHpRdN0
         1kAw79p/59Fq9sgo/EBIfKAamchq5jo9hk5VlKq/d8rPyEzps0VrLGAxqX2Go5BATcVe
         +2UnQwvbF+5evmcD1hZ8WYRBz1rkFx7CtIbAjHeoL8z5KAG5DpH21c2BTz2mrrw3oYA4
         fRG1z6cBnK0Nm7Kj+Pns0gUNy3K3ASf6YVNZvFzRYCZOKqhRGNqqYU534EtWY4vaKa2V
         63evTX9GPe/rAzoYapA28X1zPvS+/hOj9vlivl2699Kg0eqF8VIw1yEf5RWrllJ2nkjr
         Y7+g==
X-Gm-Message-State: AOAM531qqqwm/+SqpbA6gUyC9PVtG8av3YxmWbZWe880T1CdRQC5BrnS
        WAfRC1ljBeZ9rm8N+y1x/IxijcHw71dxpSqm+Eq/Sg==
X-Google-Smtp-Source: ABdhPJxjiemVetoJfIr6tRJ3te8pbVvcqd5V0ltf1SL2oo79ntfHWl46nNgx8/fVPMPOajXBx8ZGY+gKKpTJvr1k/Ds=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13186045lfo.358.1651660705671; Wed, 04
 May 2022 03:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com> <1651480665-14978-3-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1651480665-14978-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:49 +0200
Message-ID: <CAPDyKFoJcbbbUEMCX7QyfRLLYPjqnb6UL1QNv8jnh-pWa39EGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: host/sdhci-msm: Add compatible string check for sdx65
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, bhupesh.sharma@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 May 2022 at 10:38, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add sdx65 SoC specific compatible string check inside qcom
> 'sdhci-msm' controller driver.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index fd8b4a9..65661ad 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2453,6 +2453,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>          */
>         {.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
> +       {.compatible = "qcom,sdx65-sdhci",  .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
> --
> 2.7.4
>
