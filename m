Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73772EEAA51
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbjINOsu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbjINOsc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 10:48:32 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9F212A
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8198ca891fso641802276.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702907; x=1695307707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHnyXM9iWun5gDg2V2UcdiXw8a0neXTJfRyHDyENrUw=;
        b=OJ+Dkgoq48x0rX0et23/2BxL55+cxwf939yZNbqYe0hN6w5JYD9RwkZpSB1aNL5dkd
         /QBclTmOfes2GdG497I/Jpw8A7kaG/u1T3VyDyc1nJO4qXDasQLYd+0kBhI/KyB7KhVz
         UyPNWYXWyhkPBkiFhN0jd5cqhG6VH1A8PoLrFAGR8H5tI0iGIAfMgM78U9rIjCapBkRZ
         RPqsHewH/Ru9tB69kVJaSPPlK9PRsH3cweZCfVT49lcp28k1wCOS3hkoJGNgMS8CkVvx
         T5fsYP6LDCYBB/T6oUMHVMUcdCZBNIJ/1nvibznP/MSo3H2wKCJTsWhYaAaKbjz+bWxp
         EVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702907; x=1695307707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHnyXM9iWun5gDg2V2UcdiXw8a0neXTJfRyHDyENrUw=;
        b=M+Yz7OBUDtQvllVIJN/LFVN6QJmdF9NrxlVerzz9eN4TU1IxdTMW6lLgI3ESMYbmYX
         PSPYuFT2Z4CIjtzkM+3X364HRCJ+WAQyS7QpQLLTfnFDT6m3yWpqBvxm4PaOUQY59UCw
         vbHfZbDH1Q2ZZsuGRsv8THjwHZ26ADxMW0dvi/iLk5x/6uyGnL7H3mpxN/7QbXqvKsbl
         GSyLqgVaP5D+Gb5PfEXI/pOYwRp9+8IEXMCSYCLHw3uCvmigirYD8BrZ+edHZdHO099L
         jgoMLk8cYVCmke/oQmZivpYXqgiKm8hQEzmEf6fWtPemcSOiWNYuUFtsWV2FCe4+dqwA
         5EHQ==
X-Gm-Message-State: AOJu0YxGoX7TwVacdhXVDbEMSV4Yjlk6uS2Si0YV+zR3ufrldQu76ga2
        Jlj4uJxt8CHdjMbtfm2sqrbbvLWnb1C5XNiCAmyh4g==
X-Google-Smtp-Source: AGHT+IFrBqJVFRhUjU+GOYR2KuKQmlRFYDg5GxyPhnCoeJo8mUD0Mo6bSjMZIABaCiOabng0W8DB1mJEYewu9KXfL7M=
X-Received: by 2002:a25:ca45:0:b0:d81:afb1:bf77 with SMTP id
 a66-20020a25ca45000000b00d81afb1bf77mr883782ybg.28.1694702907011; Thu, 14 Sep
 2023 07:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230911092540.76334-1-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230911092540.76334-1-balamanikandan.gunasundar@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:51 +0200
Message-ID: <CAPDyKFrGYiOUgfoHo1K2e+UyDmhVgyFX0xhr2mmmjiiBGhzx7A@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Add description for struct member
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     linus.walleij@linaro.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        aubin.constans@microchip.com, alexandre.belloni@bootlin.com,
        hari.prasathge@microchip.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Sept 2023 at 11:26, Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:
>
> Add description for dma filtering function in struct
> mci_platform_data. Fixes the warning: Function parameter or member
> 'dma_filter' not described in 'mci_platform_data'.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309020937.C5S2sRnr-lkp@intel.com/
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 535783c43105..33d02a7e72fb 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -227,6 +227,7 @@ struct mci_slot_pdata {
>  /**
>   * struct mci_platform_data - board-specific MMC/SDcard configuration
>   * @dma_slave: DMA slave interface to use in data transfers.
> + * @dma_filter: Filtering function to filter the DMA channel
>   * @slot: Per-slot configuration data.
>   */
>  struct mci_platform_data {
> --
> 2.25.1
>
