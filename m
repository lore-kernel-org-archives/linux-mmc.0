Return-Path: <SRS0=AGpe=AT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A3C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 13:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C81720720
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jul 2020 13:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtWyJuBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgGHNdt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgGHNds (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jul 2020 09:33:48 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE81C08C5CE
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2020 06:33:48 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j21so2459033ual.11
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2020 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1GTsvB1sENuLYTitDg+4KJVrg9ZAbmGFqqoF3A8ork=;
        b=dtWyJuBqyJLR1bSeZKeSipNjWrOFaLi6Et+BtwiwCKDNFw0+FIShvW+J/3Zd9/eNMQ
         9YJVXSlhQXbXA8jaAqde+sMEJLnyaXWSUoidNhNR+NmVMmPmxA6kF+JBBmh2Ydq8HuEy
         EmKgvmg8Qjh3GVaZ2Rtl+p2ZbohNCy71uE5htKD2NCCSgiOetnmxfHQyjUYCx3sCvxRe
         rRoeYQMCKVqz8JnhgKN41bBr3vjWxhJMH0t5Pc0xkEPmQ+UQ+B6D5GMLvfs5XjyqLtt2
         VnRcoB7+ZHiUYClGpfXYVVTCNBLDg5LARAre3p2R55W91wq/SbA6N2DIn0D5j6l9XqoZ
         /Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1GTsvB1sENuLYTitDg+4KJVrg9ZAbmGFqqoF3A8ork=;
        b=YdpH0IDnJkj5qN3X4dZbC2srM0Z/FjtwE+8KJ0zDL8XN47Sy2Q3QanFJxE3Pv7Ll3w
         Z5iT0sKscjXcWNPnatBfuA2nd4omXbEW3PXEUNA8hdXoNGCiUNZb+X5pWas340XFbwPb
         NBMnpESXlvkLpcxTJHp4ypguSNF3WwJPPosS/dARx7YHAi4Z0oMGoNIPCyjlN093iWxG
         ArsgqGbFhiRYb8FpfMLxTo68PkvOOtr2j49KLM6VDvyvpIH13J8see60+7kzrqAQZRan
         6eihjMcLOpP2R0M6fitZeBy2aHADlFYQMhztbT5Vsae04hbVXtvlBTEsWzyL97z5oJHS
         3Y8w==
X-Gm-Message-State: AOAM531k+KPedwfTdwsh5kc6M3YjxDcbWULpO+J9XYu3rGIjfJyVlKcM
        oMOpQUrSzWtOzzyP3M7HYSeRf/HFsif3PMEkzVG7IQ==
X-Google-Smtp-Source: ABdhPJw+0z3dQW3AcfspoIM8itefwk3QY2ggPT+DFUkCpMKHpkWyXEKW3t8CCIUcJ8Mn3muqMEBQNOiJv4qt/ZeKuu8=
X-Received: by 2002:ab0:6f0a:: with SMTP id r10mr49334442uah.100.1594215227202;
 Wed, 08 Jul 2020 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 15:33:10 +0200
Message-ID: <CAPDyKFqiAeQYcqkb=Wv2stgTb9yvGwFfHv-BGtd5VuyJxfJXAA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Override DLL_CONFIG only if the valid
 value is supplied
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jul 2020 at 15:12, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> During DLL initialization, the DLL_CONFIG register value would be
> updated with the value supplied from the device-tree.
>
> Override this register only if a valid value is supplied.
>
> Fixes: 03591160ca19 ("mmc: sdhci-msm: Read and use DLL Config property from device tree file")
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index efd2bae1430c..93d67a3a899f 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -626,8 +626,9 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>         config &= ~CORE_CLK_PWRSAVE;
>         writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
>
> -       config = msm_host->dll_config;
> -       writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
> +       if (msm_host->dll_config)
> +               writel_relaxed(msm_host->dll_config,
> +                               host->ioaddr + msm_offset->core_dll_config);
>
>         if (msm_host->use_14lpp_dll_reset) {
>                 config = readl_relaxed(host->ioaddr +
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
