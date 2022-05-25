Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D33C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiEYQbX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245456AbiEYQbX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 12:31:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB053B68
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:31:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso1415805wmh.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8FV5JUaluu69LdsoN1T9bi2vXC2/Pwgc7627w+7IE0=;
        b=iiwDTfeN13tL6fGE8/O/41RxuguehByAsXlBv9b9A01c7ZAdTpYS5aHEDpDso1Bu8i
         kgxKRcKgKhgdGd2vhyTjOKPHBaEWdj2HpQSVJQGGYQQtqyCZteYEFylu+SAto+2sZGmQ
         TIMe4hYZkvCtphweI93uLlhDGw2X/mIXtW4rcrWnuB26scIT9PZTO9a/7nUydvxGGl/n
         Tg5m2jtF3h9nn+t8Z0Wj5O1upTZIQcgwL8hln0PFBx5MIgtzPoADsg5J67ysbfmAfhkQ
         nNjKl5AeJaAYUFQYiyK14bxuDtMDYvnrSSSZuzQIfiShrsucyeJYAgf1Of9gVi3ahuMf
         hgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8FV5JUaluu69LdsoN1T9bi2vXC2/Pwgc7627w+7IE0=;
        b=ZOosaDKOTrxR4ljlEfucGF18dIUxTOVZBSZ83ksfwuZw6wvd2ez3KyX3COBB9nKJMY
         F1AuBAnpURT4iSnUIlebSWQQGsOiW0nycxiq1O5MdbpH/dU2TjYZTuYDKpBEyZXIWqMM
         zGZnohjg8QWek3siG+wnNU0VI/HQ1jIWjrFQ4YKgE6Ro6du9aw2LSus1zHvGEutyX8ou
         VnuAMWNxdzwQsUPj9PfdqxhyHZSCxuMna9RqSfxJ4oTvtYLAJRaukTMGRp0+3VdNun/G
         eTzuBFRoP4T3VSbRsgsGDf1Gk9whYnnRQHy2AEN23+6qtfJXbTLzmjW6vxz5FuyMtK5g
         zShg==
X-Gm-Message-State: AOAM531e8JJGiian1m5zSAHiV/+nTvRzpnzJmyNt2kapyXmdW997OyZO
        8DUnQl8GDWtNorL4XaAEzSCAOMZo3C1mib8JPwUyug==
X-Google-Smtp-Source: ABdhPJwz1YBHr2nIviBFJqClOiHWUWpdPAd4Ni20+aGv2NLGkrG68huw8L/+YWlQH8LdBrC5DevZ27OB4Uat2ZkcfBM=
X-Received: by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP id
 v187-20020a1cacc4000000b003929dd4fbccmr8895701wme.78.1653496276038; Wed, 25
 May 2022 09:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-2-brad@pensando.io>
 <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org> <CAK9rFnyRrS_LvoZ_j66cKDHgecqcqzJN5krSxdCquBanViKyHg@mail.gmail.com>
 <49c1d200-8c07-b306-a400-86ee6a637bb4@linaro.org>
In-Reply-To: <49c1d200-8c07-b306-a400-86ee6a637bb4@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:31:05 -0700
Message-ID: <CAK9rFnw9+seK_j3gcMrDOqCWcj7C4-eKVGziFF5_J=TnxWx06Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Sat, Apr 9, 2022 at 3:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/04/2022 04:19, Brad Larson wrote:
> > On Thu, Apr 7, 2022 at 11:45 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>> Change from V3:
> >>> - Add description and board compatible
> >>
> >> That's a bit confusing... the subject is for v1.
> >
> > Goal was to identify in the cover letter patch the key changes from
> > the V3 patchset to this V4 patchset.  Then in each patch that had a
> > material change highlight that in the patch itself.  Will try and make
> > it more clear.
>
> This is fine, I am talking about the subject - it is marked as a v1, so
> it's confusing to see a changelog.
>
> One way to achieve this is: "git format-patch -v4 -11 ..."

That was the problem, thanks!  Missed including -v4 in last use of
format-patch.  Sorry for the confusion.

Regards,
Brad
