Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F31DC2D0D2
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EC922B48
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEf9Oy/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLJJvR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:51:17 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38074 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfLJJvQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:51:16 -0500
Received: by mail-vk1-f195.google.com with SMTP id e5so1298545vkn.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcOgayy9z/aBI2J3iHtRhOACGybXIm3aEUhJEwhAQls=;
        b=VEf9Oy/RRgF1tiaCcmB53O77DmqvJkBKqLxP0IpSlUwEAxUm2jSgp33Fzi8yDd/bSo
         UvmNU20JF6L3z7OXZMQkCE//tL1l7Ufml8oQdJ5HWKzIzuefyEyVKnIV+axY+bSExgJc
         4I56ZMwqsJDuIJ8blY5/QXluYaoDyu4js+zkfLbVCsdRv4vlvLDkEaxBO38xIR996pDR
         PZEKcPOaaOCB859PNkvsMwtbUmDOlTqnalPJWj7J7hvR5vSTZ6h/izB4CoZ1wyWgjh1t
         iKkrP4CAY0QriL1ykih9kiZjT1sSP/+SQbX5zpZOEqMeBZ0dnocwIbG65XOlL85sPB07
         wydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcOgayy9z/aBI2J3iHtRhOACGybXIm3aEUhJEwhAQls=;
        b=iZ7oEXFSDLVaJ0SNfY9xjNmI9w1GXKzHfpVyOlv7USvlQG+VFn3Yv4VQkIIMZL56qa
         cWGaVEwW8HXHM7LQ2AMeTec9fB+nEYOG/1CdQbrEzgjEYLvYdNINGqWtOKMsK+tTK4vl
         36oWu6PDWLbGjzWX7i4mh0tt+2Z4XIRRVCCSwEpOWMqDFWPU7ihCxneGEBktHUhCshFU
         F4ppt3E8YENfvLPOY7r7f+4HrEHToC2ziLxSUe5RyrK1aQ7e/O5IwiX1DC0MXPqqlLD9
         O+6/Z9hOvYpL0UOfUVTp7VvztiPFqqZ2yYBj6rXAy+ACJBhTlYWIvyutcjnhztcvZ+yF
         Pw9A==
X-Gm-Message-State: APjAAAXYM9pW6CsJ8JJ4vzDr11VOp/wKNuXKQvCG12O5xeB9kztcmXS4
        JykR7Xt+2BukS/+t9UQuQEeLMzOVBMlDWeCkxTOocA==
X-Google-Smtp-Source: APXvYqxzkz3LOZtzyNbuS6mvGvrUGFSaHG3D9TLCl6e41P4rm8M22wzl95/7soAZ90Ipy3g5cEzCsiuWU53RXMrP5ds=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr28846087vkm.25.1575971475476;
 Tue, 10 Dec 2019 01:51:15 -0800 (PST)
MIME-Version: 1.0
References: <0101016eacb256f5-89bd0ec9-5208-41bc-aafe-844c2178e4c1-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eacb256f5-89bd0ec9-5208-41bc-aafe-844c2178e4c1-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:50:39 +0100
Message-ID: <CAPDyKFovbLHe_HOLsjrW2arp1vh6uVoz9TWqcvzZvCtJ6j3P6w@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: mmc: sdhci-msm: Add compatible string
 for sc7180
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Nov 2019 at 12:49, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Add sc7180 SoC specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..7ee639b 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -19,6 +19,7 @@ Required properties:
>                 "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
> +               "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
>         but doing that should be considered a deprecated practice.
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
