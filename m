Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79784C4363D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433F620708
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CW+OlnYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgIXMuX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgIXMuV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:21 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F012C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:21 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g16so949760uan.5
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2mPAW56fKadViU5wZniYvwkuM/5bXXPrgkxeimyQo8=;
        b=CW+OlnYYf1kDTWmN3zq4fe88Ck689LBrfQqha85IBla3o7yw9aMI0PBxYqLuhTfaM5
         TlKOTSvAbNcklOMLvTZUDmb3sAth/Kov9hblt/mS4J73XZgHwVGBdUOy6YGLtTfFQilx
         wDYx5E5CWpAMLoRxZU/OUhpBco3NEDdrEg/gXTFn6OSEgIisHYQ4+OGWUmhmogqFLRxq
         8pofKiKCkn3g/2YdvDPLNqOciZLKxplwqe+o289w8E0uPeyxKNpULtdS2ayayC3CKUma
         /hZKR0jYzVENoLMuaiDIXzte7osGDDUgxl/kjgPiDWT9qUYfWGDXFjMVDpwnTDFmBK+5
         xBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2mPAW56fKadViU5wZniYvwkuM/5bXXPrgkxeimyQo8=;
        b=X616fuYL6suPduG+k995ln321MnNPWzq4L7O4AkFcc3dPt3bWBI/wwWPmGKRojE4Bi
         a89vxfKPV9N2kE6Q3wc5XS1Jlo1rRTcArnf149wSam+p/69EE2V7/gjyc81k6/Rp2NJg
         5KKVXmfaNSzgo6IPyEufGH3+GqDtahMviMxFOKHBrlEk3APfRGYXgspn9AThMuE4+VH/
         KdF1sdkKxoQcyVxHYExnOiSXybhMMQFJyetQVQpeC0dJEh6tYJzpOmRcKvezCH+DegW4
         tniUOmKE03Ppy+qSlLGhiKAaV4I+TuBMgSvCmKS3D0WB3dQ2rutNxxiRFoCEfH2x4ETM
         D5Gw==
X-Gm-Message-State: AOAM533ABA9X9Jq5tGnVufkaoI40xsrs7v382BihTovB+6QXY5IVIk+z
        6xnEtYffeoNI8lIANryOaupu33ZjXZFL4QxLuCiUTw==
X-Google-Smtp-Source: ABdhPJx7NfTkgqcsTMA8f0/VYZPA8fCdY2JFFwb90om5xipv+nvJ0DDwQJZTAnPOiNegCeLMOG6nAYrdXmKhjgWAIoI=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr2415949uam.19.1600951820686;
 Thu, 24 Sep 2020 05:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200921131042.92340-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131042.92340-1-miaoqinglang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:41 +0200
Message-ID: <CAPDyKFpF3+Dr3iJq1Yn2OSnpV4OZ9oVig3g3GzROiiPiiwJyrw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: rtsx_usb_sdmmc: simplify the return expression
 of sd_change_phase()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Sep 2020 at 15:10, Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 598f49573..5fe4528e2 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -579,7 +579,6 @@ static void sd_normal_rw(struct rtsx_usb_sdmmc *host,
>  static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
>  {
>         struct rtsx_ucr *ucr = host->ucr;
> -       int err;
>
>         dev_dbg(sdmmc_dev(host), "%s: %s sample_point = %d\n",
>                         __func__, tx ? "TX" : "RX", sample_point);
> @@ -601,11 +600,7 @@ static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE, 0);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1, SD_ASYNC_FIFO_RST, 0);
>
> -       err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return rtsx_usb_send_cmd(ucr, MODE_C, 100);
>  }
>
>  static inline u32 get_phase_point(u32 phase_map, unsigned int idx)
> --
> 2.23.0
>
