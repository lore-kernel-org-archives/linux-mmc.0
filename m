Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F5C4332E
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D623233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbhAML1Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbhAML0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:52 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEDC0617A7
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:47 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id u67so429011vkb.5
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZjBC9IS3ALIShgw1ZhhoVFP1AZzmhy3hY6ZT3+U1ss=;
        b=V2uMbNbhNZst+H/TYGRgtysleA3JPsjdK4sECoBkAvVuDCXwiRjcheJf8Lo78ew8D6
         xWx8cZgq0zq0eOta627uTeJZX8LPBS3qJi/o20ewOXSGjsj9F8LoJNZCq24zU2hlmqwF
         /Ol2P4F/1CUI5h2bFH0AR+1sgecOluUjKHzktJZoN5Vr9s9Ece6rkMZ9RWQc+tF+kU/l
         CIco4YwTX37KwW8JHRmD73XnMq+zVVz0Iwp4wNZzdlJM8AMy1lI++03Bte0XB/gsm4Tv
         /AXoPZ+8UZK5gIRqY+2ZRU8JxOUzzHXs8gEYijpk9iZHZBK3b3ati00kaRBt9xPMv7+n
         kO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZjBC9IS3ALIShgw1ZhhoVFP1AZzmhy3hY6ZT3+U1ss=;
        b=tBY7ICEwEPAOtgdb7T23d/HABiBuqFPNmmHAhKlSR+u7cMRvabKyL6gWFt3Gr0RQk0
         OJf4i6gzEOjmWVDkTFQeU3Zv8JAM7urbg5Eu71UVBya839fopQmLu3VFpAUfHstZEKTH
         9p65+NerGJi0mOtJe7UdWopk3g9havn2EzjcjXODs0Oh05MEEcODG8D5jVhouNvqBvRW
         d53lmckNvn50ixNZqfZ53oj6NZyIAxZtdHdBwRe/vdSVEpqyecT0z1egzNaC1DPVWizc
         17igvSdSJz74ke2gQSqk/fX/lmiTUoFKOaKpo831MDjd1YUcjaJWBuaWlVrz/0LI+ft6
         CvQw==
X-Gm-Message-State: AOAM532j02HuoLC83RD2sIeHc6mO61xybKJqbKcPX24dewtcMEjGRp4W
        e3bc09N1FRZYjr7vGOOLH6lLv2tjGaOnHLdB9hkCtsLGO3iypA==
X-Google-Smtp-Source: ABdhPJxE0pjNPFnk6j4rT66SlZyUcOMUI+HVkflRZ3WAqPhd0uZgXyN8uFdovzRTWPocXRoEK+SywdQ3L6hunKqmNUk=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr1477335vka.7.1610537146860;
 Wed, 13 Jan 2021 03:25:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608714110.git.hns@goldelico.com> <b6f2168b863e4273c6bca5a22fbd4a3a8ddf68d6.1608714110.git.hns@goldelico.com>
In-Reply-To: <b6f2168b863e4273c6bca5a22fbd4a3a8ddf68d6.1608714110.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:10 +0100
Message-ID: <CAPDyKFpe5v=05rgUAjC7vSyE-GJjbS_Yvk+65G067Y7dR=XcVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: omap: remove unused struct component card_detect_irq
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Dec 2020 at 10:05, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> I have not found any user for this struct component.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/platform_data/mmc-omap.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
> index f0b8947e6b07d8..91051e9907f34e 100644
> --- a/include/linux/platform_data/mmc-omap.h
> +++ b/include/linux/platform_data/mmc-omap.h
> @@ -108,8 +108,7 @@ struct omap_mmc_platform_data {
>                 const char *name;
>                 u32 ocr_mask;
>
> -               /* Card detection IRQs */
> -               int card_detect_irq;
> +               /* Card detection */
>                 int (*card_detect)(struct device *dev, int slot);
>
>                 unsigned int ban_openended:1;
> --
> 2.26.2
>
