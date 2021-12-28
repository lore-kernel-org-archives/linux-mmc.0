Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE15C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhL1Q62 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhL1Q61 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:27 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BEC061574
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:27 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h21so19684627ljh.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3CvtlT0BwdiYZtYf5zAYBlhNadT+rkm8lHN2U5rFr8=;
        b=jG2i3n2SC/FZUvprc4b2cVWUfe+do11pVydfgCl0IMGpj7zPt1Jng0K+vEi+/gEu+G
         tHFdCi4Qedi/DS7MHiR/omhP+BCklBUNXQBqZyNkFwf+Hj9zdy/QWrVgqRrkzej+VJqF
         SQxUXmDcSb3VQZpkNJ82qR3sRiXmOoFD+Xtl3Kw+AT49RCVxf5l62KQ2hqPmsMM0WDoR
         r+QqnYqQk55GazbAD67OImyE4eXDjrrKN8Uc8gq5E5efGk83X87uzOueRz41rnPoCZ8O
         2Wbzz64IgJtVQ4tEzJt0nzwaa0HbzuhTbAQA/KcYSPXGkWdqFeh6PJh5ZceC5OeiUkQV
         gISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3CvtlT0BwdiYZtYf5zAYBlhNadT+rkm8lHN2U5rFr8=;
        b=cTRZpeB9vPO/ZcdiPzDGCT8mCvYcBToWsbRhLp9mPcfMUP5MaAvKOk2Q99QpseaIl6
         W8MSTwjFbyO1XhciBMx6Ce/1CJsNqSnIvvF1gw/Zabiuu/T4vw+I/r8QzRdcig8gK65w
         Mjh0tyztXRbGffDHVE2nUL4tASZ/MEkd3YZL+/AFdvl9JjdjFXm0/1c85sJDz605vusN
         wEF8JqnF0SvG9T5Rs/mfP1jWkbNrr/093pGmE9hZ/VsaU67iV0MIlnHFFCnuxzNNIDPE
         K59tNK9lHrv296OnuusMmITt2N86k0jYuN3RE4LXkjEwMPtU8e25gq97AhWKPYAKn5lA
         ztNw==
X-Gm-Message-State: AOAM5316i/NPkZ9tkjn3v46yt4NbIZ679lp8PMRS7CKwAjuoISAZvIc2
        Uv33Ab1ZpRO5Wy3QJtRJtb2sGxn1HDsxrvIVax/7fw==
X-Google-Smtp-Source: ABdhPJwpj4W80uJatLfluq0OzkrKNiWNUXfaFm6PnCFkz59rRTrtfNOj1S+SIGJ4cjtY6ZlT8G4q/q9h2UdTLHAJ76c=
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr14765884ljc.273.1640710705507;
 Tue, 28 Dec 2021 08:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20211216060824.357-1-fred.ai@bayhubtech.com> <20211216060824.357-2-fred.ai@bayhubtech.com>
In-Reply-To: <20211216060824.357-2-fred.ai@bayhubtech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:57:49 +0100
Message-ID: <CAPDyKFpyU8SfkyXB+UiySiH_=8oHb9Hfo6NRTNS_X+nctvO+ZQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc:sdhci-pci-o2micro:Make the SD clock's base
 clock frequency correctly according to different card mode
To:     fred <fred.ai@bayhubtech.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Dec 2021 at 07:08, fred <fred.ai@bayhubtech.com> wrote:
>
> From: Fred Ai <fred.ai@bayhubtech.com>
>
> Remove SDR104 card, SD clock's base clock
> frequency is not right when insert SD2.0/SDR50 card
>
> Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in V3:
> 1.Set SD clock's base clock frequency to 208MHz when card mode is SDR104/HS200.
> 2.Set SD clock's base clock frequency to 200MHz when card mode is SD2.0/SDR50.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f55602609f8c..4ca1e8c5b631 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -577,6 +577,11 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>
>                 if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>                         o2_pci_set_baseclk(chip, 0x2c280000);
> +       } else {
> +               pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
> +
> +               if ((scratch_32 & 0xFFFF0000) != 0x25100000)
> +                       o2_pci_set_baseclk(chip, 0x25100000);
>         }
>
>         pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> --
> 2.32.0
>
