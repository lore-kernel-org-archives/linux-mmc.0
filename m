Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD8C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CC2239EF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 05:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAOFsS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 00:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbhAOFsQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 00:48:16 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91FC061575;
        Thu, 14 Jan 2021 21:47:36 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b64so10712401qkc.12;
        Thu, 14 Jan 2021 21:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZuuCndbOtvm58/vkKrBedKYmsIRrJvREo1b8S1ptqFQ=;
        b=et1CTe3omLNz4hbwGZr0zd/j9fOt9f4QTMhnEZJ8KBseCh7DgfR4LQN29AKoaSeJ0Y
         TlvpcDN2DAVkQ5j+rW4WJZX2VtAiXr7sMsAnM9SQr7udUKDSbuEOIv72OORl4MGl8ODF
         Ejjwus5n7N4523970dAvJuE5/Ga0sp1PGUS6EUUdlrUcF7jdOiL3ZfjbcIvGqHWthnro
         DaK02h3iVYhzj7FwtV8n7ghXpwy8wuVaKR3G5Pn426YDFAZZGSkzFu6PKFCeDbQJEl6X
         dcLucluwpfPtw6qreSANlBnmRXV0nvl6UskP6ACUeMbdWDQ1/FXOC4rKvSHOEPBJCTGN
         HjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZuuCndbOtvm58/vkKrBedKYmsIRrJvREo1b8S1ptqFQ=;
        b=gqdaY+kyC/NI/LmLoV0jypFmAQThbA1ctwXRa8CJjVd/ZcZSV4o54MzTl/ztIM9FzH
         1++6lCU0hcw736SAhB7Jb86g0myBg4CuO/0KGT1Nr5M2GyMIVGwReDoVj+75QEXCqH/C
         mHad8LPkFANomv59ec9hiv7JOcQNvns4RLymtitn3Ca6zPb9RTMy+D/3EFX7vLssH+hc
         xPAIaun+WbXYcOjx4Vna1DMfbR9HT/Vksy7sA8wyc7Cy6REJykKn+L6ujNuKIa50gg3l
         1n49+ewBDm7eI81UNs+oe+brDKlkZ2lHCJ08zdAnrss/FWRVlLzb0lbC9Us6ePP5rQEl
         pgmg==
X-Gm-Message-State: AOAM531GDQX2lF7y0tfNoVRFJzDwNEX8stvB40rNRVyvcthc+4eyAZdK
        lpkMxLHj3XDjmhF2N4bi2S6pg7FfVC1Kb49ori0=
X-Google-Smtp-Source: ABdhPJwmHHW5taNBY8omsDPfDQakRE+VuaRoi+8DmQ0LHMYt39pdtsqNaGWk/EZZX2cBFFFV5vK4HFEdek7pAfTw8Ec=
X-Received: by 2002:a37:a7d0:: with SMTP id q199mr10846239qke.217.1610689655854;
 Thu, 14 Jan 2021 21:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20210106092740.5808-1-reniuschengl@gmail.com> <CAPDyKFq1EVVfU4HU_=-7TmSRinkTCA41pKWtrMD4C+yCUPYECg@mail.gmail.com>
 <CAJU4x8uKHQy_hbMhsErzWb2U5USjMRhAZv=+14a9zDn068vHmw@mail.gmail.com> <CAPDyKFrgHgkxFjG5X6v6jx6LYAwx4m5pGROrVY2a42wTPeTKiQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrgHgkxFjG5X6v6jx6LYAwx4m5pGROrVY2a42wTPeTKiQ@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Fri, 15 Jan 2021 13:47:24 +0800
Message-ID: <CAJU4x8urzOdFSS=auDSGzxM2Dt1KfMviRiBvKZeeQyyRxRxweg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8814=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Thu, 14 Jan 2021 at 07:25, =E9=99=B3=E5=BB=BA=E5=AE=8F <reniuschengl@g=
mail.com> wrote:
> >
> > > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:53=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > On Wed, 6 Jan 2021 at 10:27, Renius Chen <reniuschengl@gmail.com> wro=
te:
> > > >
> > > > The R/W performance of GL9763E is low with some platforms, which
> > > > support ASPM mechanism, due to entering L1 state very frequently
> > > > in R/W process. Enlarge its ASPM L1 entry delay to improve the
> > > > R/W performance of GL9763E.
> > >
> > > What do you mean by frequently? In between a burst of request or
> > > during a burst of request?
> >
> > GL9763E enters ASPM L1 state after a very short idle in default, even
> > during a burst of request.
>
> Okay, then it certainly makes sense to extend the idle period.
>
> Would you mind extending the commit message with some of this
> information, as I think it's useful.
>
> >
> > > I am thinking that this could have an effect on energy instead, but I
> > > guess it's not always straightforward to decide what's most important=
.
> > >
> > > Anyway, what does it mean when you change to use 0x3FF? Are you
> > > increasing the idle period? Then for how long?
> >
> > Yes, we considered that having high performance is more important than
> > saving power during a burst of request.
> > So we increased the idle period for 260us, by setting 0x3FF to the
> > ASPM L1 entry delay bits of our vendor-specific register.
> > Anyway, GL9763E can still enter ASPM L1 state by a longer idle.
>
> Most mmc controllers that uses runtime PM autosuspend for the same
> reasons, uses and idle period time of ~50us. 260us is in the same
> ballpark, so I am fine with that, if that works for you.
>
> However, can you please add a comment in the code (and preferably also
> to the commit message) that 0x3FF means using a 260us idle period?

OK, I'll extend the commit message with some of these information and
add a comment in the code to describe that the idle period is set to
260us.

Then I'll submit a newer version: mmc: sdhci-pci-gli: Enlarge ASPM L1
entry delay of GL9763E (v2).

Thank you.

>
> [...]
>
> Kind regards
> Uffe
