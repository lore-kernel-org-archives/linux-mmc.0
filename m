Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BACC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 17:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiB1RHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbiB1RG4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 12:06:56 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575688781
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:17 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t14so18282008ljh.8
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkgJmYWsxxX8GKsmbGt82wZ7b3wAVJNNPIloWB2f2s4=;
        b=HCLEmUwrEqrJi0ppiaxXqWmPfGfsydaam/+z+wysWiUTTe5KqNq1wtBG4rDGDoTSdN
         O+DPpuI9OXryZwTxiOJVlZRKm9h0962gJ5LzaMY/O7W7ic2oSXzzM108ivmPzEYpJZVS
         luEYxenVRYRC0pHnTxlgA7AbqQOhPAamJOqtAxwPZIDhWp8uXItcdiFcJ1/4n/bmvFNU
         r3sdaWbFRjMT4v7uDFZtjN4iB6NYfIsUuMxi16eYu89Sh5J2uL7daTJlHdBcFHJZh8Z7
         s8fahXDQPZf2uihzLtbkOO4tspfaLkkjPEcEOeEZ0S/F/0oic0rLXF2atI+ibGVY8SoK
         8exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkgJmYWsxxX8GKsmbGt82wZ7b3wAVJNNPIloWB2f2s4=;
        b=B2aeZRQ69OLpt2G09B48ANT8QM5cGyWa/Jb/cWSuy/NEDY8Viw3IyPbWVMFYEpB2yM
         591Md33TCAn1mCMheGGupzlTi9DSrHm9hOi+sTJ9Zn6KrKQUp73hPre3oLkgxyXS2oJ1
         KOXUpq9YcAJk+tQepOAwsa+YlnYRtdMAEiv1viZF2nsPcOIfKzjQvZ/sd+B4zRjI4V7d
         8wfv+PgNCkwRMJuYL5XWYfB/aWWfYMM1l5QpfWCA8zOdaQn6BYtjtC0rVdOiLEPUQzrt
         e34qEhNb5pvYKKSdzOYQWoWralx/BlR669Gtf2SiInoF6WGzo9JJ8/BLVWA+eGO91abj
         9QlA==
X-Gm-Message-State: AOAM531j/cFst/lhxMkTqtpEb2+hdryA5P55dxpmICw0vKpVKYjPUBPE
        KeGhzR1IDQ56lHSIPdDvU5/+rZXBYmq49/0haUHDeA==
X-Google-Smtp-Source: ABdhPJyzkSKhXA60OHanuWXlRZ8bSWkpJGNlUvjDxqTOiifPHmBuKItm0KSRmdlvfgee+3l21QrsjfQmWlw7XQxs/2U=
X-Received: by 2002:a2e:9c94:0:b0:233:82df:a3b8 with SMTP id
 x20-20020a2e9c94000000b0023382dfa3b8mr14963194lji.229.1646067975445; Mon, 28
 Feb 2022 09:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20220218072840.5629-1-a-govindraju@ti.com>
In-Reply-To: <20220218072840.5629-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 18:05:39 +0100
Message-ID: <CAPDyKFrwTOM3b5j268bN0OxR_z9WLDN-yO1LpiRzAXxxHmUJYg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Add Support for TI's AM62 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Feb 2022 at 08:28, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Add support for the controller present on the AM62x SoC.
>
> There are instances:
> sdhci0: 8bit bus width, max 200 MBps
> sdhci1: 4bit bus width, max 100 MBps
> sdhci2: 4bit bus width, max 100 MBps
>
> The PHY used for 8 bit instance is same as the PHY for the 4 bit instance.
> Therefore, introduce a new bus width independent compatible for AM62 SoC
> that uses the driver data required for 4 bit instance.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b4891bb26648..e54fe24d47e7 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -745,6 +745,10 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>                 .compatible = "ti,am64-sdhci-4bit",
>                 .data = &sdhci_j721e_4bit_drvdata,
>         },
> +       {
> +               .compatible = "ti,am62-sdhci",
> +               .data = &sdhci_j721e_4bit_drvdata,
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
> --
> 2.17.1
>
