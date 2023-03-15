Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810EC7618E
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCOICA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCOIBv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 04:01:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCA6FFDC
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 01:01:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so16430362wrh.9
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678867303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wswi1DyAuYzJFWHWsqSArP17cSfb+M+N1FHnH+AfhA=;
        b=bXvkz/yX64lIDsHFesL+52hM15LEw2hh1hd9XLiSKXK5vxE8pVYfQHdqOkZ0FMGcXc
         F4R5ESNK1Tk/rqBaN0eR6oFsui0szxNHXCWqekofsh7DM5r+IptlZ9qE6WEFyLlaf6Hl
         KyYDpbpee/rxB5EBAcwllKXsRlAQjufynXVfD1GFQI7wSV+pAvgHZ/75PWUPIUueSqqe
         X8oXiF17AMiftJmvXhVXWltm3IFGEYPlkPuMRzwSea4ejcU7QjVql4IPqo5vAqru7CPX
         VBlxrDOKNoKvMyfxoC+fMZHuoZV9ch6sgrWqlaARYDZJfBWMuQOEw47ZkZv/mCkjtBDH
         sFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wswi1DyAuYzJFWHWsqSArP17cSfb+M+N1FHnH+AfhA=;
        b=ZKFUJcxknQ6gG0Elk90V8VIDQx8OF7rI6AUrBpbNZtaI0YG6EJ04FgMp9mAQk7Sf5m
         yqXhTGHbbRjV3pMUvjmy8cLubixcNU8eF1XXJn4/E1lNQpnIr3Lj+XgQGvxzZ2fe0kZc
         JcW0cm6z+X4L4ANZH1QrLrxsYJivFglT519gSKcOIbkgUnriWGCIytQfDnS16XW0rCvr
         rm+J7xPqQt9sqKawdP2s+O/bfC+LY/IHPQsQ2rF3zdkJ40h5TX6XUd/k0VPCL1PKpMon
         lCqiDtvmpk6V8lxq+p7OKl/aJ7Ovf5OPwTbaASVGZJm3uLyeLpHHf8wCz3LE8qRAkOra
         486g==
X-Gm-Message-State: AO0yUKW6n98wVSWiYXN0ZWLoCtOWs3lILYC4/OQxOtNGjLVG2gUku3y4
        0rnwFXIMijMwGm5cnfqmc/RgAn/+ieSGDyv2uYDpdg==
X-Google-Smtp-Source: AK7set/zDwpw5tmgpQkQE93auoU6m0X9eMFuTR84C2UImSDMGqPTyR5wis50nno6pRellvCAciITc3dcaQs8FlsxmTE=
X-Received: by 2002:a5d:65cc:0:b0:2ce:a3a6:79f6 with SMTP id
 e12-20020a5d65cc000000b002cea3a679f6mr365503wrw.4.1678867300640; Wed, 15 Mar
 2023 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 15 Mar 2023 13:31:29 +0530
Message-ID: <CAH=2NtxHrk4XnFAzUD82ngqihsEPHKztz_7OJJ36U4X=DA9wGQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] QCM2290 compatibles
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Mar 2023 at 18:23, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Document a couple of compatibles for IPs found on the QCM2290 that don't
> require any specific driver changes
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (6):
>       dt-bindings: watchdog: qcom-wdt: add QCM2290
>       dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI DMA
>       dt-bindings: nvmem: Add compatible for QCM2290
>       dt-bindings: mmc: sdhci-msm: Document QCM2290 SDHCI
>       dt-bindings: usb: dwc3: Add QCM2290 compatible
>       dt-bindings: thermal: tsens: Add QCM2290
>
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml       | 1 +
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml      | 1 +
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml  | 1 +
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml      | 2 ++
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml  | 1 +
>  6 files changed, 7 insertions(+)
> ---
> base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
> change-id: 20230314-topic-2290_compats-5bec96afeeb0
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for posting this, for the series (with the assumption that the
board dts will follow soon):

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
