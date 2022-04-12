Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DAC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 14:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353899AbiDLOVk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346504AbiDLOVh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 10:21:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B847ADC
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:19:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r2so8920698ljd.10
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQyhcpmuoxubOTeJc5FbJZSd/FqD2XuPIEYRCS1ggmw=;
        b=ydG+eEZexNQfagzFvxoj4FD97ilHqxwQqCPkORhS5G/hJ0xwxgXdQZbamWtyEwi1aC
         yOU7dgTfSLJUpRDyR7IedOV/kpj2RKsfEAJ8VnhCk/vmebRcBHjnQLmFARBt/57VbpZ6
         qple/wrZ7mV6dOki1hZPjlcMd9FDcXZJZb/ezzjKTbhtX4FgmdlT2hXEHu0MFk06qI2d
         m52WMMuSoMEwDIcuSIgVH/BUaCF+fKMFc0PDyiVrrqD+nPWzCIjCRhQSewtovaVV/Dah
         mxt41+nsFKqD4mCj75quu7rgmMmUfuScOGJC8LF8reSmu0cAZAd8u6SxxV4h/PbHNT3j
         fmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQyhcpmuoxubOTeJc5FbJZSd/FqD2XuPIEYRCS1ggmw=;
        b=cranuhAXXiX9BgSjAX6SuBaJn26pzPF0L6I9IN6SoRflj5bpSsBZBgshUmiVyEY1UF
         l7pi6pVzU4TmjX0mUPfwVMMDr8QtK5N0KKuyylT+HfaP8WeTGMBO0q+v+KVX/KAtY0RM
         ZjbH610zoJX1hhMVv6pYKHRfsCVCnNvoKIvFdOVqJb2DC0Uo5aL4WgoMiCQA2RFy4j9r
         xJpjcmZ1FdHF7U+gziswS8gLA5iLBf3KfLxvqQoO32cjxD1hgyduQdGk5nqC1VkuVYPQ
         wqMZIxpDVakuNDaAS+4ecFfu/qQluDEm82/QIBMIKX3M+pCGYX9wfdOn5xyjoYVgZpDb
         YMgg==
X-Gm-Message-State: AOAM531gZAZ+q4I8rmdjP6coQwX0wQE/tdF4NxYC7lxSlxAUhle8tMff
        7QOKjHdvmtmogHNqbGqi3Ef0xQMWN+8+OKKK9AqK0w==
X-Google-Smtp-Source: ABdhPJybcpvxTKB+Nbs/AV1PA14+uH0q480UoHl1NeG/zKAVRWlPeSSnikUgTyII0O0N9vSECYon0Eo8hlDT0BXQCos=
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id
 e10-20020a05651c090a00b002495d82fe9cmr23873129ljq.300.1649773157120; Tue, 12
 Apr 2022 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com> <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 16:18:40 +0200
Message-ID: <CAPDyKFrJDVBdyu4=0dXaBs8FhsF5jvcLKGgfjjbB-rVztxmgqg@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Bhupesh

On Tue, 12 Apr 2022 at 12:33, Shaik Sajida Bhanu
<quic_c_sbhanu@quicinc.com> wrote:
>
> Add gcc hardware reset supported strings for qcom-sdhci controller.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

As stated earlier, I would really like to see the binding being
converted to the yaml format first. It seems like Bhupesh is working
on the conversion [1].

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-arm-msm/msg107809.html


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..9f02461 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -76,6 +76,7 @@ Optional Properties:
>                 "cpu-sdhc".
>                 Please refer to Documentation/devicetree/bindings/
>                 interconnect/ for more details.
> +- resets: Phandle and reset specifier for the device's reset.
>
>  Example:
>
> @@ -98,6 +99,8 @@ Example:
>                                 <&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
>                 interconnect-names = "sdhc-ddr","cpu-sdhc";
>
> +               resets = <&gcc GCC_SDCC1_BCR>;
> +
>                 qcom,dll-config = <0x000f642c>;
>                 qcom,ddr-config = <0x80040868>;
>         };
> @@ -118,6 +121,8 @@ Example:
>                 clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
>                 clock-names = "core", "iface";
>
> +               resets = <&gcc GCC_SDCC2_BCR>;
> +
>                 qcom,dll-config = <0x0007642c>;
>                 qcom,ddr-config = <0x80040868>;
>         };
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
