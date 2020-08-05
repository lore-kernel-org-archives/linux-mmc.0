Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CDC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CCC207FC
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHytMXqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHEG3w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEG3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:29:51 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA311C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:29:51 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z26so7403025uaa.4
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjNhelQQyiKCsHNy53pVLNqVZpYJ7b8kkO6RZtTdzSE=;
        b=LHytMXqw7/0w/JfsLNPXr+3EqqrXaOHP3dV16dKVtbPGAetjmErBAaLEWHXRPGyBfr
         ongnNoW4/sSjaUXtUF1uphqlqbw21ONEGF6pIiuOLBRGxbWavO/Iq6nqfPqX3RD9eNJk
         CFywKUv0qBnvom69h/q+Ltg5Rkce6D4c8M0onhPvxMYOP7VHk4xkc/tDDpGl0fZIdbs7
         801YscPb4v/bMtTVAgL1Y/gg9I4tsC0ujzExgZ4FnHrLq1MRGubnhSNz+fTDqc4jniO+
         c+Bu3yYeViiQQj5+Vci55K5c1aRLUokv5MoEb8hKrxKJdc2nL77lUCNQHH4u19E83D2U
         fm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjNhelQQyiKCsHNy53pVLNqVZpYJ7b8kkO6RZtTdzSE=;
        b=fnjpyTWYtZVKzVMuL6fb/3F1WA8dihxx54QX5T0p0ZDiPck2neRap2dmn/zAToemE4
         NLhFjYosNIt8+Izuh9aPA262YpBLQ3G0RH8W8i8EFm0O96cYwrJgAkAA65fvhjxG0lBi
         xaR/pRP0Cx78bniF54W9Ph9OrVB55cNFYntSLtweo+xvz9lmDzhUHSqU5kQsIgfnFx+k
         yAzkYT62Ja9bNrMdUdraHDFuL50G830s3dihAk5uUIwuHGsxFRANOcGQ7oQuG1EWE+4P
         xkatlnZeaFCfG8Oz9GJ+nsbaWIzO6i2SK1f939L8okKAaSec7rZAdJsDu0sY+VIhMv5V
         RsVQ==
X-Gm-Message-State: AOAM530DbrflBMuTKlX0Tau2kxPcOZWktB8i6FYXPZ3oZCWBVXeTqh9o
        pfQaZjCMUkMUOf3YdmJIx8eTSGXBMVmBFhBFCj02VQ==
X-Google-Smtp-Source: ABdhPJyg/gyFFdtv0bAgkfJPoZ/9JJ4GAm/W/LvXxWoV3OniXIX8ntkRR6+tL3JUWlnKXfP36JpmCA6ovNiWexVMeFQ=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr985385uay.15.1596608990883;
 Tue, 04 Aug 2020 23:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200709085331.8145-1-ludovic.desroches@microchip.com>
 <CAPDyKFq5gCA1f=XVVepi93wotn4uR8JHcRh4JoFt-Preg4ATjg@mail.gmail.com> <9528a121-2f14-2cc4-8610-6561f4e1a31c@microchip.com>
In-Reply-To: <9528a121-2f14-2cc4-8610-6561f4e1a31c@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:29:13 +0200
Message-ID: <CAPDyKFoZ7gyKFsx1oQwgguPF8gt_g-pJrhhvSsGQLZ8xi3-rwg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to
 Eugen Hristev
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Jul 2020 at 13:02, <Eugen.Hristev@microchip.com> wrote:
>
> On 24.07.2020 12:40, Ulf Hansson wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Thu, 9 Jul 2020 at 11:03, Ludovic Desroches
> > <ludovic.desroches@microchip.com> wrote:
> >>
> >> As Eugen handles the software for bootloaders and new products, handover
> >> the maintenance to him.
> >>
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> >
> > I am okay with this, but am waiting to apply until I receive an ack from Eugen.
>
> Acked-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


>
> >
> > Kind regards
> > Uffe
> >
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index c87b94e6b2f6..dafcfa626c76 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -15376,7 +15376,7 @@ F:      drivers/mmc/host/sdhci*
> >>   F:     include/linux/mmc/sdhci*
> >>
> >>   SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
> >> -M:     Ludovic Desroches <ludovic.desroches@microchip.com>
> >> +M:     Eugen Hristev <eugen.hristev@microchip.com>
> >>   L:     linux-mmc@vger.kernel.org
> >>   S:     Supported
> >>   F:     drivers/mmc/host/sdhci-of-at91.c
> >> --
> >> 2.24.0
> >>
>
