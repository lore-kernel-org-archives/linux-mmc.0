Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40311C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Apr 2022 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiDAWLu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Apr 2022 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346020AbiDAWLt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2022 18:11:49 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC82552B1E
        for <linux-mmc@vger.kernel.org>; Fri,  1 Apr 2022 15:09:59 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-df0940c4eeso4181580fac.8
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2022 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6rY8NKT6m0nS75suQ+nFywMY6wDIOo3ms5SeTbFXvxM=;
        b=kwfOWInOCRYECvlHmEdCMRxg6iXPB40US4o+rR7nBbVs4TK8Xd3fhTJVHZw+Ipy+5/
         vZLKw3rgc3fV8tqsLjXS82Y9etsT89es+YtpxzQ62EcKTU8JmT299mEE+wiMZ9GzeJh6
         76DuwhxuZgF3SbR9FuuEqZa/f3t/o6hTNJ450=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6rY8NKT6m0nS75suQ+nFywMY6wDIOo3ms5SeTbFXvxM=;
        b=oE8UaSg6oa+ri+US4GSZlrJWzrle/3BZC9SIjadN18qtwv0ujN5HvItSwFjCt7f6vQ
         isaq+eqEDlEkSMPCBCMftgpdZOIDI4dw0cL2aZmZJbs96cS0Gmieew2Gx4m7kMNi9lMs
         A0TEbSFYzoVBogwEZcxi0KA5S3H216rsf4+BYkv+DjkyHIG9KqKb1+BQwjBGGzZYHtkq
         o2j5OZeT5h/Px0vnpgwml5wGBlvVSwIexohnHiQaH/Sif3y6zNa1wk77yJk06+woTMOn
         jzHShtHUR1dbw91FfyZmJLw6EUlwBeopnWQPLlgklHMFTqASmGbFcoqEmr1dx4hto3ON
         r3dg==
X-Gm-Message-State: AOAM533EU9e57ZoCyIJTHjzUSsmGaCBVvJZfyffJ1L4M4bxkV+E0mseZ
        X9dgJ+v+0Si4ibjfwnrBo8vK3g1XgA1DEcWbm9QlqA==
X-Google-Smtp-Source: ABdhPJxQSBjHCimqKqmmEHvxpus5i7XPHVv6wtC8jb98htsIgcr/Uv9JRMFkIVcC3CNZ/kGzLXUj7+8PEY7X3yjZuXE=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr5768834oab.193.1648850999220; Fri, 01
 Apr 2022 15:09:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Apr 2022 17:09:58 -0500
MIME-Version: 1.0
In-Reply-To: <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1647532165-6302-1-git-send-email-quic_c_sbhanu@quicinc.com> <1647532165-6302-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 1 Apr 2022 17:09:58 -0500
Message-ID: <CAE-0n53BBzgU6AJ70JNUBBkDZ1c9ZmpX8ZXLcxLxmmg1=UnSLw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Add reset entries for
 SDCC controllers
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Shaik Sajida Bhanu (2022-03-17 08:49:25)
> Add gcc hardware reset entries for eMMC and SD card.
>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c07765d..cd50ea3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -881,6 +881,10 @@
>                         mmc-hs400-1_8v;
>                         mmc-hs400-enhanced-strobe;
>
> +                       /* gcc hardware reset entry for eMMC */

Please don't add this worthless comment.

> +                       resets = <&gcc GCC_SDCC1_BCR>;
> +                       reset-names = "core_reset";

A "_reset" postfix is redundant. In fact, reset-names shouldn't even be
required.

> +
>                         sdhc1_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
> @@ -2686,6 +2690,10 @@
>
>                         qcom,dll-config = <0x0007642c>;
>
> +                       /* gcc hardware reset entry for SD card */

Please don't add this worthless comment.

> +                       resets = <&gcc GCC_SDCC2_BCR>;
> +                       reset-names = "core_reset";
> +
>                         sdhc2_opp_table: opp-table {
>                                 compatible = "operating-points-v2";
>
