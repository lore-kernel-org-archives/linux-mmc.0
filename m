Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F5C2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078A220786
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 12:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUVqGmj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635214AbgDPMRH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635213AbgDPMRC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 08:17:02 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA0BC061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 05:17:01 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id z1so2220088vsn.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rH9FNHKfAt+A1vHsUhr40PXb20A41+AkKVxM0KJ3IUA=;
        b=YUVqGmj/+GDGZBvHkZaAeyYUaCRpluZmazweWxd6ZTa1hCXJxkmgtRpeDTvGw5VNgw
         YENHKM8ub9JsSLNmhcXOjQxXDkG02vY9SW1cy5/5Y8B6DXqy11HiNhxWQRF74NPi98WC
         8hkPHF2sg8VzTIDNarYVAjdvoA5fGmKo0e+rdoHewmOZG1+42kAgfbhcrFUg8Z9kulkv
         q+rkXjNZV/6Ja/Ok6top274QmChv32s3aLm27Qrd+DaZFNI9ghZcBPRMgEpA7Up9fQUG
         nkrl9DjNvC02IDUfXElBurkhW6dU4Q4BXyQXbLoT+T7TxEhGqMSSjhOBRmrJvMVppIGc
         XOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rH9FNHKfAt+A1vHsUhr40PXb20A41+AkKVxM0KJ3IUA=;
        b=L3Oe8fiuP2KLoQhLSw1pgjcl9Eyo21EFxKzJttIKv/D89cdc0X5iAV2HC4/MEE9tXn
         G4hrE7s867/Ra3bjj10eWx/yqTHS/oANi1dykOP/75iKuRWtgZjhrWiDlMrRmR7JYI/3
         G6pAjhfO0Dp8xHGCxpcvTlZoJEWuUHrHaopONirlERRHUM6Br0/yROH7j7kdKgFID2V8
         xu+YtCpYeT3rVKOI6j4iZ4dUanMtNvBEPRGuDySV2gIgDn7XS4DURunCGjxKzCnCiYa7
         cgOBgVSb7jQbEnfDZhw8lK2/MBoSdVXEICqzVBNSnaPQXqeS5DUfw9Y8rL7FMlpfjUzM
         0rkA==
X-Gm-Message-State: AGi0Pub2+7fIFdSetBqYlf9p9PQWiSMmvz2NncNcXMra3e50c63msmz6
        82O9f3z8usjoSxuwGQxfaaAKewubfKTEVJ5Z1Ny3Lw==
X-Google-Smtp-Source: APiQypKimtohzaeLEMo41Jq2vIhngmFgs5gR9SEFIMKBisOybswa7H7HDo9Cz25Xudtsu4/Cr3AMFl9xkeaY4PUinE0=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr8636206vsm.165.1587039420609;
 Thu, 16 Apr 2020 05:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org> <1586706808-27337-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1586706808-27337-3-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 14:16:24 +0200
Message-ID: <CAPDyKFobBGDYMGmkpTcmKVrnT7MywM5=xaOx86f91ay6c7DUWw@mail.gmail.com>
Subject: Re: [PATCH V1 2/4] mmc: sdhci-msm: Enable MMC_CAP_NEED_RSP_BUSY host capability
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Apr 2020 at 17:54, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> sdhci-msm controller requires the R1B response for commands that
> has this response associated with them.
>
> So enable MMC_CAP_NEED_RSP_BUSY capability.

I assume this potentially should be considered as fix and tagged for stable?

Another question, if there is there an upper limit of the busy timeout
in the HW (cmd->busy_timeout) or does the driver use a software
timeout that is adjustable?

Kind regards
Uffe

>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 013dcea..d826e9b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2088,6 +2088,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>
>         msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +       msm_host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>
>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
