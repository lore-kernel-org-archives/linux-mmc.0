Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831EC83010
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AEE20855
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTYklSsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgKPL1d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgKPL1c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2020 06:27:32 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D86C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 03:27:32 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id b190so3639190vka.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDNHwFPPdxrl0nz+LWmXWFCgZDDUSozRbaXai/sLCBk=;
        b=RTYklSsKvH2dj+pk8mdhPO8AeiCIp8mUtZ7fiX52V6DtquPF7dHz8Jd7qlF19jCJ4v
         c9oSrK6eYenT35Rz9R90IFdn7mDTQY1JhtFunDumpKF4FTaLTgMO8z+1nb82JXT+Bg9u
         sxPa2Y+fjpu0whq/kYiDUp1k+b7Amk4zC2Ir6QaEunVY3/5tXphz8TWlRKj2yTvN13+1
         ieMI++9QYdGa/UXrEIQE49B9cj3Inm8BeNh0hh2cVjqF5UOadnv5JMdjr0JpIWMJ5nTU
         DUbIl3L1uvmaLzATmvxJpEXPekXU75LOKo8oEgNPH9hHAzc7+kk2+j0WnNir4AeqYosu
         kfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDNHwFPPdxrl0nz+LWmXWFCgZDDUSozRbaXai/sLCBk=;
        b=uGB8ImlXbqlE47aZLC5E6Lz2LnU6j2f64Jd1vofLU16uIrz2coK4T4teQxsctLnGt8
         0jPMwZ3LKBzbqysbEfoWjz9clH4C7HGKmVFOeDYApgGaZOoMH+IxN0U5YKVlG0C9c3P8
         2cSfpcL1FfEFS8DEyHPjQ/g5nWvBnFuo+/oFASCyg7nq1+RWTV0nOPZdsMcGfA9OFnwM
         SVwn1m4X3Gj0XtD1szuGcpMInlPNTuQLYpS7vpKa1BklWZa5JOjebDjfjHKPEM++e7jl
         oTlD4kkPTTFbvJq/RTYO5G2SpeWXXvitL468LJUx8uxdHKCqZvWQadTe3CnJ46A2Kj6i
         ALJw==
X-Gm-Message-State: AOAM532cEc2oSxC3V1fTvI83F6RY1zPSqCOlhMx8TqDkVVW3t4f7tJeW
        ASoJge20AFxdNS6hFHGYjUpnv4Mk9pl/cxQb23tqTO5b7bivgg==
X-Google-Smtp-Source: ABdhPJyCSbfAB4BBrxcyuC4Zl7g2Kr50DI3LEJgES7xRdTtadX48ABGo+8GC7WaL1SuvE9cXZ1PR3JFSDNMYZb8pjRQ=
X-Received: by 2002:a1f:5e0b:: with SMTP id s11mr7356900vkb.8.1605526051945;
 Mon, 16 Nov 2020 03:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20201102071715.18057-1-yangbo.lu@nxp.com>
In-Reply-To: <20201102071715.18057-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Nov 2020 12:26:55 +0100
Message-ID: <CAPDyKFp9se67D-R0ay+77n9yg93APjDMvNvJATLJ7sFXn7RvfQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: export sd3_bus_mode to user space
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 Nov 2020 at 08:26, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> There was no way for user to know what UHS-I modes the SD card
> supporting. We might not know, even the highest speed mode
> failed to use and fell back to a lower speed mode.
>
> This patch is to export sd3_bus_mode to user space to check.

Well, even if the user would know, what can it do about it?

Sound like you are looking for some debugging feature instead?

Kind regards
Uffe

>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/core/sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f054c4..13409c2 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -689,6 +689,7 @@ MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>  MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>  MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
> +MMC_DEV_ATTR(sd3_bus_mode, "0x%08x\n", card->sw_caps.sd3_bus_mode);
>
>
>  static ssize_t mmc_dsr_show(struct device *dev,
> @@ -753,6 +754,7 @@ static struct attribute *sd_std_attrs[] = {
>         &dev_attr_ocr.attr,
>         &dev_attr_rca.attr,
>         &dev_attr_dsr.attr,
> +       &dev_attr_sd3_bus_mode.attr,
>         NULL,
>  };
>
> --
> 2.7.4
>
