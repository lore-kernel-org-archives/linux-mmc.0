Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ACC7EE2D
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjEVJuF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjEVJuA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 05:50:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149EA3
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 02:49:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-309d3e8777cso1407962f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684748997; x=1687340997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYDTRQ3Z+kp4Z7bD3A9FTH/4o0GFqdJBXFfGhyiCeNM=;
        b=nE0JX8ZMTTQ5g0zlQTtrTgBkHXhIXT+ZxuDqrV6vUXsajL/ZaaFCmTc4UtkmlnIR26
         QZawwCLEsJLkxRlEdAOWDXThy25B+FrNSeHNxSxStrUWo44tSix1Fy/3+knXdEob3pDm
         eqyRLrZDhya90byJDGIHpPgSL25m86fJmVewzx36RtHa8diNw3QFM8gRiVTE4pLPFKB/
         eL8Y7EJx/En+erz1PI3zYfpQwStuDppDjHdr0LVsqKDXz2alUJf+dMRaTaWxnQvLMzyU
         ajg7T2gw920r5qBPzmY/Iq15EExfoTigB1qwkdBtYXVnyCS3YpM+ZbGD9UcsvuYMILzc
         dXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684748997; x=1687340997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYDTRQ3Z+kp4Z7bD3A9FTH/4o0GFqdJBXFfGhyiCeNM=;
        b=VdtP1kmQLnW9XY/7yIM9GfA+C1hQhAwu+5eCLaYlw11QNiJxwh4bIft76bUL8AadHr
         5CGkfGncs24GoZIWLiNMbWnxKpJUBugieBycF3UWFPenxHw2A8RHj13uUE8tt96EknfA
         CsP+F52BrnJ2XsxLoBl6lOTHps3lrEsS6+j/4NJCBHADTvsBFG/fTZPyEc6NAioWB3bi
         H0rm6KvsxLJN7ildXhtMW4Zz+0DNwPNHFo1jpvqVY/CaCNdu2FGceAErVUBDhtNURR8G
         Q6K9KgDPzuOWg7zfHcSHTDg7bEXIMSgY8GQuXnap6fejIbM65wwwZdtqUrQhfV0lM1kA
         uX3g==
X-Gm-Message-State: AC+VfDwGa+jH2baCnLM3+IUTEHlPObv8T1CY3ifvvrLh77nCal/SFTlw
        2CkZ3pmlAmO2mTeUVegu/QWrfSTHTRp/3OLrQVW+KQ==
X-Google-Smtp-Source: ACHHUZ7lnvos8gjXPExW9Hu+ML+UsOruMb/Lyv03oJkHB6x0mrot9YE+05pfJIMz5t/KRfj9tdu6ehuJN5klDvrLf+8=
X-Received: by 2002:adf:fa01:0:b0:306:3163:2b76 with SMTP id
 m1-20020adffa01000000b0030631632b76mr7090443wrr.15.1684748997248; Mon, 22 May
 2023 02:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com> <20230522093620.3568-4-quic_kbajaj@quicinc.com>
In-Reply-To: <20230522093620.3568-4-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 22 May 2023 15:19:45 +0530
Message-ID: <CAH=2NtzBWjAuJ2mvtnBzDkhMXk+MZX_KwE-8U9CW42fQL+SBGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qdu1000: Add SDHCI1 pin
 configuration to DTSI
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 May 2023 at 15:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add required pins for SDHCI1, so that the interface can work reliably.
>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>wq

Err.. an extra wq .. I think this can be fixed while applying, so
should not require a new version.

Thanks,
Bhupesh

> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 38ee7115a35f..6f23cbfc024c 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1151,6 +1151,56 @@
>                                 pins = "gpio31";
>                                 function = "gpio";
>                         };
> +
> +                       sdc1_on_state: sdc1-on-state {
> +                               clk-pins {
> +                                       pins = "sdc1_clk";
> +                                       drive-strength = <16>;
> +                                       bias-disable;
> +                               };
> +
> +                               cmd-pins {
> +                                       pins = "sdc1_cmd";
> +                                       drive-strength = <10>;
> +                                       bias-pull-up;
> +                               };
> +
> +                               data-pins {
> +                                       pins = "sdc1_data";
> +                                       drive-strength = <10>;
> +                                       bias-pull-up;
> +                               };
> +
> +                               rclk-pins {
> +                                       pins = "sdc1_rclk";
> +                                       bias-pull-down;
> +                               };
> +                       };
> +
> +                       sdc1_off_state: sdc1-off-state {
> +                               clk-pins {
> +                                       pins = "sdc1_clk";
> +                                       drive-strength = <2>;
> +                                       bias-disable;
> +                               };
> +
> +                               cmd-pins {
> +                                       pins = "sdc1_cmd";
> +                                       drive-strength = <2>;
> +                                       bias-pull-up;
> +                               };
> +
> +                               data-pins {
> +                                       pins = "sdc1_data";
> +                                       drive-strength = <2>;
> +                                       bias-pull-up;
> +                               };
> +
> +                               rclk-pins {
> +                                       pins = "sdc1_rclk";
> +                                       bias-pull-down;
> +                               };
> +                       };
>                 };
>
>                 apps_smmu: iommu@15000000 {
> --
> 2.17.1
>
