Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE2C83F17
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Aug 2023 22:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjH1Wvf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjH1WvS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2023 18:51:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456C13E
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2023 15:51:14 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd045336c6so2847461a34.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2023 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693263074; x=1693867874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DIqwskK0oYqXSVa28hgr5U7LAJbKxCjHL8WYKkpGDQ=;
        b=ITw2jWGaLstQYHZ9c72vF7WGCcIAi19eDX3cFfRNLdrfimlVzgIXnxJl8E8LemmLJw
         gBq9DJpbixcO13fzBluyjR3E4nO1TUEm1DoAI3raq0fYmHI2k7BAc/MClLntR3pIj9Sm
         6W3wYpTON1B7JhNkVSddmHJCF0yCvYoWE0JIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263074; x=1693867874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DIqwskK0oYqXSVa28hgr5U7LAJbKxCjHL8WYKkpGDQ=;
        b=IxyIocA6hDQY+/7BhDQwDyngdL9tkPeMo9m108/Cn7GfnzhV5aQY2q6V4TKSs+T0ZZ
         LJfmy0bfoWNKkUDaKgjNaGMrwe5tALj8Sa1py+3Hh8tYLe92lI04TK528W/Nv3pNBdY/
         IDj2VUns9tcsfYYGoGFxs5wpyjZd4jU231oSqA50IfhL4F33amqMhhzLfXPjpp7lIFKv
         AUNFmZjhMSm7P4GflcITuJgjYcuydnqnzdtMWei0kVPu+lN5nA3VP0CDuxVx45U42Jyy
         sJ4MnC6i2vRL0iLou3wm76xQF/aWUU1xjy8h7GRSkLWApMtQeTZZJYCAQtF0ip7G0FXN
         2YtQ==
X-Gm-Message-State: AOJu0Yww8cj1LVEm29RDL4vPeAqyQjXWoI8MpcFnMblF+W8Z7BJ1tZGD
        Q9dztWEMC1Nvaekx+AXclIITRBE/TqnrYFtOg97cFQ==
X-Google-Smtp-Source: AGHT+IFhaBwbYY6NH5M8NCoCeXN2tAsEyjtJJk1uTx2T543prAKt6iO221j6wbVTc68tchaDYZOJGox5XoJSGcAlo+Y=
X-Received: by 2002:a05:6870:3906:b0:1c8:bf19:e1e4 with SMTP id
 b6-20020a056870390600b001c8bf19e1e4mr13435455oap.37.1693263074222; Mon, 28
 Aug 2023 15:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com> <20230828100313.3051403-1-benchuanggli@gmail.com>
In-Reply-To: <20230828100313.3051403-1-benchuanggli@gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 28 Aug 2023 18:51:03 -0400
Message-ID: <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, skardach@google.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ben, thank you for reviewing this patch. See below.

On Mon, Aug 28, 2023 at 6:03=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> There is a situation for your reference.
> If `allow_runtime_pm' is set to false and the system resumes from suspend=
, GL9763E
> LPM negotiation will be always disabled on S0. GL9763E will stay L0 and n=
ever
> enter L1 because GL9763E LPM negotiation is disabled.
>
> This patch enables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled -> (=
a)
> (a) -+--> idle -->  gl9763e_runtime_suspend() -> LPM enabled
>      |
>      +--> no idle -> gl9763e_runtime_resume() -> LPM disabled
>
> This patch disables allow_runtime_pm. The simple flow is
> gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled (no =
runtime_pm)
>
> Although that may not be the case with the current configuration, it's on=
ly a
> possibility.
>

Thanks so much for bringing this up. We have discussed internally and
as far as we know, the current patch will work correctly in all cases.
Could you verify our argument please?

The following assumptions are key:

1. If CONFIG_PM is set, the runtime_pm framework is always present, i.e. th=
ere
cannot exist a kernel which has PM but lacks runtime_pm.
2. The pm_runtime framework always makes sure the device is runtime
active before
calling XXX_suspend, waking it up if need be. So when XXX_suspend gets call=
ed,
the device is always runtime active.
3. if CONFIG_PM is set, runtime_pm can only be disabled via
echo on > /sys/devices/.../power/control, and then the runtime_pm framework
always keeps the device in runtime active. In such case LPM negotiation is
always disabled.

Using these assumptions, we get:

Runtime_pm allowed:
=E2=80=94------------------
gl9763e_runtime_resume() -> LPM disabled -> gl9763e_suspend() -> LPM enable=
d
-> gl9763e_resume() -> LPM disabled -> (a)
(a) -+--> idle --> gl9763e_runtime_suspend() -> LPM enabled
|
+--> no idle -> nothing - already runtime active -> LPM disabled

Runtime_pm not allowed:
=E2=80=94----------------------
gl9763e_runtime_resume() always called -> LPM always disabled
gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled

In all above cases the LPM negotiation flag is correct.

> >
> > sdhci doesn't know anything about the bus.  It is independent
> > of PCI, so I can't see how it would make any difference.
> > One of the people cc'ed might know more.  Jason Lai (cc'ed)
> > added it for runtime PM.
> >
>
> As far as I know, when disabling LPM negotiation, the GL9763E will stop e=
ntering
> L1. It doesn't other side effect. Does Jason.Lai and Victor.Shih have any=
 comments
> or suggestions?

Sounds like everyone assumes that you can freely change LPM
negotiation on the PCIe
bus after the cqhci_suspend() and sdhci_suspend_host() calls, so we will as=
sume
that too.
