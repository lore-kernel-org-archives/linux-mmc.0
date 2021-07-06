Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD08CC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 10:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B800A619D1
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGFK7s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhGFK7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 06:59:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E9C061574;
        Tue,  6 Jul 2021 03:57:09 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w22so8181810qtj.8;
        Tue, 06 Jul 2021 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JkSvEYz3RxmiVyBOaotyMVwPxMuIkXjED/WpnZlsv+k=;
        b=TPKj95Aa52oFXx0y5cdAHDIljPwLgZyBeIv/qOBghV/G9AC5Hv2sw7lUAhpcFDdAv8
         o818pDv1lchuG1X27vjIaG+8iIDf9mpxtrSalZbqkBKYKG8vlNc8a9AK4DaLtnA4vsx6
         VKYQCywDFwk5FDGb9bNcBtmcd505k89e4LuGfikBmwLyrumYv0r880Vksay7VZYui07y
         pPvlVZhfnUdgToHec4g2AJfDoN7r83J0Iykydf4JbZfafO/v5vJpnFN7kcoopljKHAKZ
         eUOO3c3XA96rEXYrT0HVgvLJtW8pWkMYgiXBz2OtfaaglcC8rxyx+paiYliUEnvIPf/j
         dSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JkSvEYz3RxmiVyBOaotyMVwPxMuIkXjED/WpnZlsv+k=;
        b=C+ywF16x785m2EZAMiBs5sP0daKPQozB/QLm+divkl7nwzzLTQnMPtlh3JmbZga2sK
         dZIq5uF22qliNcuCopMg13Wz6kDSULfaBGWq+KpTWKz0TE9aaYI6xdAlYM+u+0bxyUN5
         CvqAfQhEPfnJ7tqWf4jTmYQw6eENjmT2viYyk0a9tAX5wKKv2Z1VOtfMn8SJuJE24Jfz
         o9TOQKmaplxApH71Q5piwzk17e69BGI8ynrR8D21wA1MeDWFkbUYbGV7tAkgvFtQmEkG
         t/5EubJ5tYCSpe2kA4RmpvnMXLp9DqEW/ueo5clD0tcEUfRhL4Nw6yzxV0bYgrMeRxSq
         ow+w==
X-Gm-Message-State: AOAM533BGAAGQnP65jJjDOcyVVIY64TVaGw05IerDJEpqp6YiXN0MSrC
        GG3X6FnzBp3gxv3ncmWir+eIUYrcGwRO9V5Dnl8=
X-Google-Smtp-Source: ABdhPJzmLnm8I7wyX9zaibyB+BPknknkHo+oqt2anOVAN47jt+UVptfYzh7OOv9dfZV67itQZOtotQ+7OyAGFM/bAvI=
X-Received: by 2002:ac8:5806:: with SMTP id g6mr16710670qtg.112.1625569028356;
 Tue, 06 Jul 2021 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com> <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
In-Reply-To: <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Tue, 6 Jul 2021 18:56:57 +0800
Message-ID: <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [...]
>
> > > > Thanks for your explanation.
> > > >
> > > > I think there may be some misunderstandings here.
> > >
> > > I fully understand what you want to do.
> > >
> > > >
> > > > Our purpose is to avoid our GL9763e from entering ASPM L1 state dur=
ing
> > > > a sequence of 4K read requests. So we don't have to consider about =
the
> > > > behavior/performance of the eMMC/SD card and what eMMC/SD card that=
 is
> > > > being used. We just need to know what kind of requests we are
> > > > receiving now from the PCIe root port.
> > > >
> > > > Besides, the APSM L1 is purely hardware behavior in GL9763e and has=
 no
> > > > corresponding relationship with runtime PM. It's not activated by
> > > > driver and the behaviors are not handled by software. I think runti=
me
> > > > PM is used to handle the behaviors of D0/D3 of the device, but not =
the
> > > > link status of ASPM L0s, L1, etc.
> > >
> > > Maybe runtime PM isn't the perfect fit for this type of use case.
> > >
> > > That still doesn't matter to to me, I will not accept this kind of
> > > governor/policy based code for use cases, in drivers. It doesn't
> > > belong there.
> > >
> >
> > Hi Ulf,
> >
> > The behavior of this patch is to set the value of a GL9763e vendor
> > specified register. Why it doesn't belong to GL9763e driver but other
> > common codes?
>
> Let me try one more time.
>
> The code that is needed to put the GL9763e HW into low power state
> (writing to GL9763e specific register) certainly belongs in the
> driver.
>
> The code that monitors for a specific use case does not.
>
> >
> > > >
> > > > I agree that the policy of balancing performance vs the energy cost=
 is
> > > > a generic problem that all mmc drivers share. But our driver of
> > > > GL9763e is a host driver, the setting in this patch is also only fo=
r
> > > > GL9763e, could not be used by other devices. It depends on our
> > > > specific hardware design so that it is not a generic solution or
> > > > policy. So I think to implement such a patch in our specific GL9763=
e
> > > > driver to execute the specific actions just for our hardware design=
 is
> > > > reasonable.
> > >
> > > From the use case point of view, the GL9763e hardware design isn't at
> > > all specific.
> > >
> > > In many cases, controllers/platforms have support for low power state=
s
> > > that one want to enter to avoid wasting energy. The difficult part is
> > > to know *when* it makes sense to enter a low power state, as it also
> > > introduces a latency when the power needs to be restored for the
> > > device, to allow it to serve a new request.
> > >
> > > To me, it sounds like you may have been too aggressive on avoid
> > > wasting energy. If I understand correctly the idle period you use is
> > > 20/21 us, while most other drivers use 50-100 ms as idle period.
> > >
> >
> > Yes, according to our customer's test for the GL9763e, if the ASPM L1
> > entry delay of GL9763e, which is the idle period you mentioned, is
> > larger than 20/21 us, it will not pass the PLT test. The PLT is
> > requested by Google for evaluating the product's battery life. The
> > product won't be accepted by Google if it fails the PLT test. So we
> > set the ASPM L1 entry delay to 20/21us.
> >
> > With such a short idle period, during 4K reads, the idle time between
> > the read requests will be larger than 20/21us, so GL9763e will enter
> > ASPM L1 very frequently to impact the performance.
> >
> > The bad performance of 4K reads was highlighted by Google, too. Our
> > customer has to pass both the PLT test and 4K read performance test by
> > Google's request. So after some discussions with our customer and
> > Google, we decided to submit such a patch to get the best balance to
> > satisfy Google's requiremnet.
> >
> > The function and the register is vendor specified of GL9763e, so we
> > access it in the vendor driver of GL9763e. Add some functions in other
> > mmc general codes to do something only for GL9763e and can not be
> > applied by other devices might be a little bit strange and difficult
> > to implement and design?
>
> I haven't said implementation need to be easy, but suggest a few
> options to move forward.
>
> What did state and I am not going to change my opinion on this, is the
> governor code that monitors for use cases, don't belong in the driver.
>

Hi Ulf,


Thanks, I understand what you mean.

I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
drivers/mmc/host folder, and found that in some SD/MMC host controller
driver codes such as alcor.c, cavium.c, ...etc, there are also
behaviors for monitoring the request in their driver. What's the
difference between theirs and ours?

And if the code that monitors the requstes does not belong the driver,
where should I implement the code and how to add some functions only
for GL9763e in that place, in your opinion?

Thanks for clarifying my questions.


Best regards,

Renius

> Kind regards
> Uffe
