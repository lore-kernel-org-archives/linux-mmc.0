Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D1C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA0424655
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEnT1vFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBRXiu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:38:50 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44201 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgBRXit (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2020 18:38:49 -0500
Received: by mail-ua1-f65.google.com with SMTP id a33so8142429uad.11
        for <linux-mmc@vger.kernel.org>; Tue, 18 Feb 2020 15:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STt86kT4bIomqkWX7kK7v+xFHLMvCO0zF5ALqd2qVx8=;
        b=qEnT1vFyTK7eaXgmzlPUVdSAiKuY8xrrhI2Z2il5i3x7u9Z7eNdil1N1YK972yxMRU
         Pq78PZY4iyE1lERtE9Hg+RF6s4AqyI/aQwUvXJaSi/DX6ynP108DL6EM2AAM/m+Wlgto
         uVeV8DkZZosrpYDwWPGEed5Wpa5dYDqsSwV7iUsiWgK/dp0dhLryM2ZTaA6ZKxcMyV91
         iQaP5QHBD3eYnG0G1xEmbvx51wYfPBg3bTGCeLLx1XCmFelc4Ffn50OaJ16U1eyXIi5n
         BvDbb/QmBS9VRVql8KDQppgQ4hYqVLsmxksGE6ChdCphxutANv0fX0iRWPSvyS2E8kB1
         3Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STt86kT4bIomqkWX7kK7v+xFHLMvCO0zF5ALqd2qVx8=;
        b=ePkORvgLrGG8DALc8OIWLS+YiCn95b3sFCafQRhou7AOGPCTl5zpt4VhuBRDLc6ynA
         91s8F9jIOlOq0cjJ9m8gQ40NUuNadCO7L9udBQ+pLwKlpRgvJS/zV3w0FJxnnsN9q9Wr
         1H8CpBt51wBiNjpF/MS5s9bt37Fbr+39YV3DMldFrCxCdRtXzvA6OOToEqikBzNIWsuI
         97A0GMA2UUX+2g1miiEE23DgoEQ8C9LMnii/iCvH5WTVl4gXIQ28Y1iAAwVrdRCvv06w
         Tyq30rTnRgWFOyo46tyZAQy2dIN/95xn/YwulB+OKgrM3VjgCChJ8TFdc45YhqEJGDlR
         vcNA==
X-Gm-Message-State: APjAAAWJKYQH2ZM3rNazBXB5ZAJoi6H7zVaHuTahc+taFSmT2q7BFsFq
        VqTkNVKsrtOE7lRPEefs49bcIml75ttoDeAvbMowNQ==
X-Google-Smtp-Source: APXvYqw9nAEG4kehq3otvKosRpBxqlAYUQpULzm3ZrGhrEPplUrNSJAyvqsnKDebS1ASeoR3ujqz2wpKnBvfEneuHNE=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr11762057uas.19.1582069128757;
 Tue, 18 Feb 2020 15:38:48 -0800 (PST)
MIME-Version: 1.0
References: <1581062518-11655-1-git-send-email-vbadigan@codeaurora.org> <1581077075-26011-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1581077075-26011-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 00:38:12 +0100
Message-ID: <CAPDyKFo8eDAwE70FNhsiZ6mRRKi6gkx+VtmJ9SJ0mAWuVFjKzA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-msm: Don't enable PWRSAVE_DLL for certain
 sdhc hosts
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 7 Feb 2020 at 13:05, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Ritesh Harjani <riteshh@codeaurora.org>
>
> SDHC core with new 14lpp and later tech DLL should not enable
> PWRSAVE_DLL since such controller's internal gating cannot meet
> following MCLK requirement:
> When MCLK is gated OFF, it is not gated for less than 0.5us and MCLK
> must be switched on for at-least 1us before DATA starts coming.
>
> Adding support for this requirement.
>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> --
>
> Changes since V1:
>   Condition was not correct in V1, which is corrected in V2
>
> --
> ---
>  drivers/mmc/host/sdhci-msm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c..aa5b610 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -977,9 +977,21 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
>                 goto out;
>         }
>
> -       config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec3);
> -       config |= CORE_PWRSAVE_DLL;
> -       writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec3);
> +       /*
> +        * Set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3.
> +        * When MCLK is gated OFF, it is not gated for less than 0.5us
> +        * and MCLK must be switched on for at-least 1us before DATA
> +        * starts coming. Controllers with 14lpp and later tech DLL cannot
> +        * guarantee above requirement. So PWRSAVE_DLL should not be
> +        * turned on for host controllers using this DLL.
> +        */
> +       if (!msm_host->use_14lpp_dll_reset) {
> +               config = readl_relaxed(host->ioaddr +
> +                               msm_offset->core_vendor_spec3);
> +               config |= CORE_PWRSAVE_DLL;
> +               writel_relaxed(config, host->ioaddr +
> +                               msm_offset->core_vendor_spec3);
> +       }
>
>         /*
>          * Drain writebuffer to ensure above DLL calibration
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
