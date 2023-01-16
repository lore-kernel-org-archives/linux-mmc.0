Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB315C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjAPMRa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjAPMR0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:26 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87A1E29E
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w2so5405739pfc.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6O6s+/Jt2HoabvH6cuHS9xSwRe0NVzIqCZ/LeG/LHY=;
        b=pGYFC/99nJry9sCOIIEhVPMiFJI2cPOyFjxJ+CQredOPjfvSiLV/gFUzpcP5iemlFV
         VU7uweWcbuErhIP5Q2+eJIVUyc2AiAKNOqFKNasT6LF0fbulicGAEFrG/8eYuDebb/wR
         v0LSXKCNkynVx37AqCZnEFCtfiF4H5eG44hmFBkiNrMPWnlNUdr+3BP9lRQe09smS7LP
         0gf28va4QB9FcMfnh898iYbLkW/4dhFIdwwU3cs98WcHGNOEURwIC9Kq9ej8CTC9ZJPr
         TC9vXSyjtJnS3iUPJgqeA/aPh8fpyYaK/jo+r1tS0IsGbQPbVtjLjFwnkC65bdZ67Qmx
         3cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6O6s+/Jt2HoabvH6cuHS9xSwRe0NVzIqCZ/LeG/LHY=;
        b=zdxRfaHgkPjrVWZb/YbSkQj19Y6sMknxhFwITuYimY+eGCU/EbXRN/3qpC4J56n9qn
         GihHtT2WWVDJpPIAb/GZ3X87FlvQdwMG1AV+GhcYiXeKQ88tW3KFbmQZxNl96dH8ms6o
         JJ2uDi6fhp2/I4J3AvyuykvTWGcAHiJgjr7BP8YM1qp6BVXBKfSwrHHUSGx+nI07iO4l
         tTGABwJJthO7HcK0QOyHQtdEDJ5znx6r0wijXMPW5cNb8bRsvOanEaH8UBGxTmN07tjm
         oRhbB9HzpMu6nSofSsOXvTlkJu3frYWir1EdpNAEuL6Fwshjai+pFpFVM4aGh6/X7T7X
         bKqw==
X-Gm-Message-State: AFqh2koskjgynTIXxM49Rgtyom+jNzRnafrmMzSOVnQ/nRzgxSvhAF9M
        Cjybe/4/0C2qXMOMsTXUN5w82KBuHIVVbAmtSoBLNA==
X-Google-Smtp-Source: AMrXdXv42heKSjxH9IbMlW2WEJ0jJ2oxbDDcd/9dL4HfNDG3mX+fT4ukYrCn9Kuo4Szve/3TM1B13jKJi/moHSsz+II=
X-Received: by 2002:a63:104f:0:b0:4ac:d14e:2d01 with SMTP id
 15-20020a63104f000000b004acd14e2d01mr2089863pgq.595.1673871433402; Mon, 16
 Jan 2023 04:17:13 -0800 (PST)
MIME-Version: 1.0
References: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
In-Reply-To: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:37 +0100
Message-ID: <CAPDyKFrzxCKa__v_GFQg2p9cvYKaGaN4kWCEuTM9zvL_tOOAsQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: enable host V4 support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 11 Jan 2023 at 19:15, Liming Sun <limings@nvidia.com> wrote:
>
> This commit enables SDHCI Host V4 support on Bluefield-3 SoC to be
> consistent with the default setting in firmware(UEFI).
>
> Reviewed-by: David Woods <davwoods@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a7343d4bc50e..49338670c89f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -528,6 +528,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
>                         goto err_clk;
>         }
>
> +#ifdef CONFIG_ACPI
> +       if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +               sdhci_enable_v4_mode(host);
> +#endif
> +
>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>
>         err = sdhci_setup_host(host);
> --
> 2.30.1
>
