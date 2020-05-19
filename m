Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D547C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271CF2075F
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 19:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="DIr2jVq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESThQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESThQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 15:37:16 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FCC08C5C0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 12:37:15 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 36so366113uaf.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nbrp/LAnuLBxSPtlONuQw444EY5ahg5VqvIIJlCXM2w=;
        b=DIr2jVq0KOhkpSdmZAgmC/qq+bcuWIyH47knuQh+KJx0s6VUooieZgl17R2zZPG8Ij
         jKmBiqqNJHrJEtLZSikNsYvJV7snZhC1hR0JBhiSrQPoxjt9k+jBsFr8h72Gf/2XPq1P
         fFI9ZIZUtmZD1dArWnfjyHo/2OR2KiIUcsX5RZC8vTyakb5W0jSQ67MZSZLk3s6S3gRr
         CVAl57+knQuFAuAXZSY88ukWCgnCyWH1HZItzJIF4IDNPGA6PXUM49CEu+5AoG6wHT65
         l8OtvXChAJ3ZJdNNYMXC67t6YqByXdrAxP5vGXnLLYoV0Xq8Smo6yUG56wwQZtblb0Y+
         K1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nbrp/LAnuLBxSPtlONuQw444EY5ahg5VqvIIJlCXM2w=;
        b=Zi9Ls5b41JR2clvXTmBlmeLZBW19IVZRpPwWBADjP9VJGQb3o97SuT6JYWgLXPL4OQ
         2vddePJGbxfxEMAB0Y6YyScd9wfymSJ9GZSGiVdUG2Dzpx28AsTgCtq8Lu1D4J6RgAGf
         rrktXHYTqvhtSdgFaJn93JC1KdLa3MFZq6FgcOUpgyyeD9+mdsfdpUMVpQmd+hsrkU4O
         nGDIOrMI9CWti6hszzMfXvHXkLpQ9gbRn/aXsGISs107o0+NXxFV18XlAMUY335E3fwx
         Jj1gb40DUVfRKCxTMHLSvlSYCMqRdVyTjjMcbGL3hglA0TXpsCCU4tRJVeuFeoNTUQck
         5Jmw==
X-Gm-Message-State: AOAM530B84cV0kRed3cXnW4wj4R3SoDpxeWeix5jGlYMYy1jmi2MmvvP
        bNsiC/f3jULEq1YpUWOL19oFx9NM5u3yOuhZPUHozg==
X-Google-Smtp-Source: ABdhPJyfp8AiLwJMIhMDCZy79oLE/+vFIfY5EQRGBQ54rMoDYSLIBkjAEcVJYs6GoTab1rxkKJ7IDpz+5FrBtLyOesE=
X-Received: by 2002:ab0:6713:: with SMTP id q19mr889699uam.114.1589917035031;
 Tue, 19 May 2020 12:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200518191742.1251440-1-angelo.dureghello@timesys.com> <CAPDyKFrj3Xh5uahMroWb7EMBh7bJ_yyambE+Yn3WQBHNB_CROA@mail.gmail.com>
In-Reply-To: <CAPDyKFrj3Xh5uahMroWb7EMBh7bJ_yyambE+Yn3WQBHNB_CROA@mail.gmail.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Tue, 19 May 2020 21:42:07 +0200
Message-ID: <CALJHbkD2PHF=nTvyeL9gz2sQChhUOB4tB7aF4qkJCW-h8yy86A@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] m68k: mcf5441x: add support for esdhc mmc controller
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hurra !

Thanks all for the support !


On Tue, May 19, 2020 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 18 May 2020 at 21:12, Angelo Dureghello
> <angelo.dureghello@timesys.com> wrote:
> >
> > Add support for sdhci-edshc mmc controller.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
>
Regards,
angelo
