Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7DC636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 11:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBPLNf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBPLNe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 06:13:34 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB22E0D7
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 03:13:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id ct17so1200962pfb.12
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2023 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+kR6wh9kwB/E7vRE8CyQpd6LBLK+EqxdavmtcVlfOZ4=;
        b=Sg+fQUNTyvr2FucvVuiPGyKptOmkutRklwZcQ74bdCjoB9dKmwUe+O3dHg1bLL+WbM
         GLPXT2Oc1YhiCN9bgWt87QXsZKMzqs17B5ZeOxieV8XDjAghFZ7kj89SMUk1tGTSVVLS
         cqgsFggPkidPlijzDql9Bvzljqp6ILWyqSrcH7KmXSaCAmQDqlxaRTsoper6rS+554Pm
         arcq3zT/m5Ag2IUxtufCw0B0kqN3hjcsXJAj1gOIBUtGTJX3XMPyAQi6BrsajIHRS89c
         GKGLBn4dER1Z42cJLAcUF48Jwzb1eHHaomFk7FJ0WFQ1tCdUt0QVD7tmxYdn0NaWChIl
         N0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kR6wh9kwB/E7vRE8CyQpd6LBLK+EqxdavmtcVlfOZ4=;
        b=h/rRbZOXu6j4K6UuHnVbiraisHMFBlpKXq7WQLX7aoqkKK2D6UbFBwxsI7aUNR0W8b
         NyZQliMLlJ5xZ65JJUM74y9mPuxlFFHbMdAeeBWBUF+2qmKrO9KOaX5ObJ1v8DTHTP8M
         qFLO9YaJLRH52NLUUTfT/6tVW+1KyLNequDcPGzCb9OytZ/1cZls93iMXJjGi8aUCUW7
         lW3v0DZoQhkizFS/vdtRme/6+n8mtB43ETQNTvfvAc+yoxX6g24vEXBQMOTbIuI3iNGB
         JM+s/bizRnvptv0KzTVp3vcfyYCSoq91cDrwl1VeDcdwkep6NAREFIl48RObk3JSBSjq
         nbdw==
X-Gm-Message-State: AO0yUKXD/ekgW6W9MGNEg2tLod2zLXNB/bvqjsuEtxpK+xumsI0c8Xjl
        md5nPBZfMZ9DpAuqvmLdVQmD36rNwLn2hvauZgAxyw==
X-Google-Smtp-Source: AK7set8RryQsbu+Kkw2qXt9myeqZ9YL9Pbk5ABXe5VqKD9hgnrBVz34nN6cjKsGVChY53slLb8UDby66Y68qOCd2T+k=
X-Received: by 2002:a62:820f:0:b0:5a9:b28f:626c with SMTP id
 w15-20020a62820f000000b005a9b28f626cmr71691pfd.56.1676546012974; Thu, 16 Feb
 2023 03:13:32 -0800 (PST)
MIME-Version: 1.0
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
 <1c5996a5-491f-39d6-b120-bbef86473729@gmail.com> <b87003f6-02a8-64fc-80fb-b90ca6bec37c@linaro.org>
 <723119a3-7c7f-6447-254e-bc340a1fe2de@gmail.com> <8e9d4c8a-40e0-65ef-ba72-ee8d1114ce97@linaro.org>
 <eef6172c-6d74-16e2-bde2-324227ca174c@gmail.com> <bcd24667-731d-8a6c-82aa-4763d033741a@gmail.com>
In-Reply-To: <bcd24667-731d-8a6c-82aa-4763d033741a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Feb 2023 12:12:56 +0100
Message-ID: <CAPDyKFr4aczSaAWdaX0VS+v5sGyGgktYzUGxQKdwvCfWFj8AVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd interrupt
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Feb 2023 at 10:49, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 16.02.2023 10:41, Heiner Kallweit wrote:
> > On 16.02.2023 10:34, Krzysztof Kozlowski wrote:
> >> On 16/02/2023 10:29, Heiner Kallweit wrote:
> >>> On 16.02.2023 10:18, Krzysztof Kozlowski wrote:
> >>>> On 14/02/2023 22:42, Heiner Kallweit wrote:
> >>>>> Support passing a second interrupt as card detect interrupt.
> >>>>>
> >>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> >>>>> index 46e235bf2..c8c30300d 100644
> >>>>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> >>>>> @@ -28,7 +28,7 @@ properties:
> >>>>>      maxItems: 1
> >>>>>
> >>>>>    interrupts:
> >>>>> -    maxItems: 1
> >>>>> +    maxItems: 2
> >>>>
> >>>> Wait, you now *require* (not support) cd interrupt, so this looks like
> >>>> ABI break.
> >>>>
> >>> The second interrupt is optional. If not provided MMC core falls back to
> >>> cd polling.
> >>
> >> It is not. Your binding requires it. Did you test it on DTS without the
> >> second interrupt?
> >>
> > You're right, the binding misses a minItems 1. I'll add that and the
> > interrupt description.
> >
> Ulf,
> do you require an add-on patch that fixes the binding issue or a
> replacement patch?

Please send an incremental patch on top, I would like to avoid any
further rebase at this late in the release cycle.

Kind regards
Uffe
