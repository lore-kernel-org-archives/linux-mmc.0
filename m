Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B697EC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B2D20776
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIS4CIHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgE1KQD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgE1KPV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:21 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EFBC08C5C5
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:13 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b28so13399942vsa.5
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rp6VELEot9Fh++h52iKmHeZNSHE0a8VpGXtPuU77ouA=;
        b=XIS4CIHKq3AMwVi4GNpccYFQT9B38RwLHxe1YO+64hWrshFIyCUC2TkmMxHRtka9N5
         yB6spHmkxSfvHdZOVh9W1XS69boECsGVmX9Rk1vOhTAK93AWS3fUsAy0Pzff7z+5BXLw
         aYnew/VoVgnW+l3shObem+nG1JjlLsxxz5Ij5s7GfBZuVQ0d3dZL7Wfhgb5w6hdO+yDF
         8OWopu7AH/N9Bzkks/FRMAKpfrWkVWBHqgctof2lzVZOaLM9ByjxDpAhIROdI89KGJ3U
         KVoXUO192xqAM8wQdhd90J3Zc+wi3wSGwps4gOKLiB/KkGIOvTo1+8Vum87DZtSqjK00
         WuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rp6VELEot9Fh++h52iKmHeZNSHE0a8VpGXtPuU77ouA=;
        b=ruDE7GDaMr2yQKLN3DHvuHOoVbCEO9/rdIWiwGyw+I7kuD3mImeCNADH1/donvuoSg
         czrjaWBQBqc0gwk75HwsWkAe5Ozi8wTrYMlh81eycAUkhXoHkQe5zz+JJeBLbF2VWMvw
         t3sJotxoyD+pwwXrz9NCWd0122x/NZ/9hqjliafDzdjlwHZDIC0kfXibYcFA3VxY04/N
         82dcEDx4nzThQtXADQ3tq9EiL6Cdi15xZI8jNYrHzhN9Y9b79FX+g/hEFST03Od2hEi9
         YXx8wwNnWZ6dE72u9joViSwZgFxj9F1XwmtIRI+J0PLE568QPZFqq3p4nhettACDA1Ix
         ET5w==
X-Gm-Message-State: AOAM5318nf/kiTW0Aa34HvB9Z4ZpGk0ADC/5Rwu1sfpHNDzn95xigApE
        Q8h4iQGWJ8cMUD1mxcNBt2OSb5KxrZT0EeE4K3/Ujky6D/4=
X-Google-Smtp-Source: ABdhPJz8Lyr0h+KpC1LgxKtbui1gTuJgkW0ioM2HznQIBM+b283Sbc9RHXn6MtlB4SpBUS8IsbhDgcSZyQYuK0uaWMo=
X-Received: by 2002:a67:1486:: with SMTP id 128mr1266900vsu.191.1590660913116;
 Thu, 28 May 2020 03:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:36 +0200
Message-ID: <CAPDyKFpg+buor=shmPPMAbEei3HpUo+epoM+0OwuveXjk0WXLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix the mask for tuning start point
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 12:32, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> According the RM, the bit[6~0] of register ESDHC_TUNING_CTRL is
> TUNING_START_TAP, bit[7] of this register is to disable the command
> CRC check for standard tuning. So fix it here.
>
> Fixes: d87fc9663688 ("mmc: sdhci-esdhc-imx: support setting tuning start point")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Should we add a stable tag or it doesn't matter?

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7af9d87d4245..2cf7fa59270e 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -90,7 +90,7 @@
>  #define ESDHC_STD_TUNING_EN            (1 << 24)
>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
>  #define ESDHC_TUNING_START_TAP_DEFAULT 0x1
> -#define ESDHC_TUNING_START_TAP_MASK    0xff
> +#define ESDHC_TUNING_START_TAP_MASK    0x7f
>  #define ESDHC_TUNING_STEP_MASK         0x00070000
>  #define ESDHC_TUNING_STEP_SHIFT                16
>
> --
> 2.17.1
>
