Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02703C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94EA238EE
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhAVJte (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbhAVJqt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 04:46:49 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F334C0617A7
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:45:40 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id k9so1206873vke.4
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvHhaTPdznpDywUc/uYNd5dQxldk3088mJzvH+35Vbg=;
        b=TDs126xEQJD1ti8VqWb0+VqNx/qwF6Y8zwl+j7PLiLc6mf7oovLlt1p8RFh+lAQbvy
         ijAuFHwBj021707lZGfQ6vyJ2G5f6L6VpvUpZ0brnUhfYtnizZ2ao/ZRyqejzo9SOu4W
         hxceFYmGWpMkkDq7fmarku07kdNN8JHa2JfRpWwC0tjx5QKYzFgaYm98UMnEvmxsDp1z
         HTMspjQjREDEmSzsxMW5isx9W5DY1DZE3y6TKe1hmVo2webk4rw/9xeySiotGM2stjls
         GKqlwSyov0o2EcYRwDNwxhClYqTRgvQDoiCx2gbnHzNTVrFxLHUE66gB6gBgEUV8IrB0
         H4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvHhaTPdznpDywUc/uYNd5dQxldk3088mJzvH+35Vbg=;
        b=kHdrwhl/ERDWdQ016nEhmk7MgOWzHZx68/cWz9jEf+QkFy0UakWq0L6VSo89CMrruN
         MIrmHyyV9BhPFA57mnAP766imWuP1UD46LTmHNLB1HdOPB0eAcN5iweX8ZSz/YsfuGJH
         wUqLK+M6wtL25X/rVuvU9CuZevR2sJb5PkoJzmNpVmU90Uj4epotNMel3exdo7nXWoI+
         wSeNWWX2x6NHMl665xmCNZd9h/k8NAEPvQ6BK607JoEIiDI2Qos/k0J9IGGTak+SjDwJ
         byRbKJB1tVIdnyL8lQ7A6HZDmI9IoO2uDnXrnrGS6JVCZ1p8q2wobLkKpPIiZ4pagw7/
         mgvg==
X-Gm-Message-State: AOAM533X0KKh+6XYMzORe3pxQ5vMDNNv22roQvZ09PK5zE4JGAn23QHn
        kyqAzuAL10Hstf2t7pkuwRqmoC6atN9ya3s7e3I+eQ==
X-Google-Smtp-Source: ABdhPJxFInzjt2t5iWXw+hGyhslaf/WF/hZSmKFuEeyY+Xur4Qh4zP1WtRcrELumIEDLg5G+gprwzRd6e+FBoI2Nutc=
X-Received: by 2002:a1f:aecb:: with SMTP id x194mr2282842vke.6.1611308739834;
 Fri, 22 Jan 2021 01:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120142801.334550-1-arnd@kernel.org>
In-Reply-To: <20210120142801.334550-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:45:03 +0100
Message-ID: <CAPDyKFq+R44LCE0OshYL39aoPPcYv4-iXudKDGZ3Q=wwL+0u8A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: remove obsolete drivers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Jan 2021 at 15:28, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding mmc drivers.
>
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
>
>
> Arnd Bergmann (2):
>   mmc: remove dw_mmc-zx driver
>   mmc: remove sirf prima/atlas driver
>
>  .../devicetree/bindings/mmc/sdhci-sirf.txt    |  18 --
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt    |  31 ---
>  drivers/mmc/host/Kconfig                      |  21 --
>  drivers/mmc/host/Makefile                     |   2 -
>  drivers/mmc/host/dw_mmc-zx.c                  | 234 -----------------
>  drivers/mmc/host/dw_mmc-zx.h                  |  32 ---
>  drivers/mmc/host/sdhci-sirf.c                 | 235 ------------------
>  7 files changed, 573 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
>  delete mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>  delete mode 100644 drivers/mmc/host/dw_mmc-zx.c
>  delete mode 100644 drivers/mmc/host/dw_mmc-zx.h
>  delete mode 100644 drivers/mmc/host/sdhci-sirf.c

Applied for next, thanks!

Kind regards
Uffe
