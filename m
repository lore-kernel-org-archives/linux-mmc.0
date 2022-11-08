Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74184C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 16:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiKHQEl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiKHQEi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 11:04:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F858BD7
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 08:04:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l6so14244201pjj.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4L0lpxFgO08elzxEtFZTCq5Rc3ge2xMVqe4z2m5l5wc=;
        b=A0oz87VXTZAnhZ0m8CQYGaqCJt7I/iJ8VMWO7Ia8ixaAVV/jaPgBA8zDBTUNOjQnor
         3uaqGwKOL+9R7cp5RIWfK8Afcv5w4MyShRoWwpc0ne358Y9HQ1qNykYG+u9bgM4Y7y2C
         bfGtaHk+YPidVzxOFydB83w26Enpi9jWnWJFiucubh1PtHx8DeURE3jfDqwGPkKr4sn3
         +HscKsItoi4gn5ym3DhSG1E57kcMGHsRLjN79ss3cj9omuT/hNhnbXn9JJen57WUW/OG
         2w6pTXB/65shmdOKkoEI++p+Y6FX9L89/ds+2xZS+31CJY9FEMxLDaTJ6PANfyTdJUQn
         aOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L0lpxFgO08elzxEtFZTCq5Rc3ge2xMVqe4z2m5l5wc=;
        b=Ig5J3kPgI2+An9umQPAGgdYNAYGee4+gbCnaPI1MZxfckglhAlDetezQ5e7uTg49LS
         FUo/YtQOmilb4A8Z4CbsdVpUZ363TXvb6JdMRiJxz9SS3M1zq2ZfRZjS9OiWZO11QjQZ
         E9axL8+ZhFWuORe9Jf+I/R5kH07twLwrjJDFGcxl4ZwqJ6wQ3G26baxHSEDQpBzEvdZz
         5CGdK3dbuM8S/qMh4P3n13NMrnGaUrFv6hR9DfDH5EX0bht/Hf2gva+BRx2EOorKBsK5
         2qifgsFVL0b+wUmGyZq599IE7inNpPdFlWTRuiIKQf1QzxiHp9mtB2Cw9T938QCgFrV6
         R7Cw==
X-Gm-Message-State: ACrzQf0NmCX60cgBONGffNqeawwV2MzTC97ZgOzXp4bnmyFPvfn9z2CB
        +onwweDDKNDRTxZyac4iAjxVym5WUMuqXBMFdZgUWW3C2KWp8g==
X-Google-Smtp-Source: AMsMyM7TbT/aYwtVR4cqz4woE5o/71SJRXngQtG6YCrAh1dB18sTimWfSWV0k2qjNcC6qDEuFLBx2IAPwVGpiyKgIDA=
X-Received: by 2002:a17:902:8c92:b0:178:29d4:600f with SMTP id
 t18-20020a1709028c9200b0017829d4600fmr57171112plo.40.1667923417870; Tue, 08
 Nov 2022 08:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com> <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-5-hayashi.kunihiko@socionext.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 8 Nov 2022 10:03:27 -0600
Message-ID: <CAJe_ZhfMq1ET+TonauySxfCUv2n=xrsEf9T4o9zePwS5feeGMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 02:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
....
> @@ -228,6 +229,7 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id f_sdh30_dt_ids[] = {
>         { .compatible = "fujitsu,mb86s70-sdhci-3.0" },
> +       { .compatible = "socionext,f-sdh30-e51-mmc" },
>
This also needs to be specified in the dt bindings, not just in the driver.
And if this patchset is for the "e51-mmc" type controller, introduce
the compatible first and apply the changes for that controller.


> @@ -258,4 +260,5 @@ module_platform_driver(sdhci_f_sdh30_driver);
>  MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
> +MODULE_AUTHOR("Socionext Inc.");
>
Socionext now is what Fujitsu was when this code was written, so this
addition seems ok.
So may be add it as
    MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD., SOCIONEXT INC.");

cheers.
