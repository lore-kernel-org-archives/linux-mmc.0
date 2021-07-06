Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BAAC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186C6619A5
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 10:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGFKLZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhGFKLZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 06:11:25 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A67C061574
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jul 2021 03:08:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id o7so11570468vss.5
        for <linux-mmc@vger.kernel.org>; Tue, 06 Jul 2021 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEeLkirnfCYQuHYnsGsdZPBzkk8jMtMxsiPF74aFxoU=;
        b=lV08qaQEyrd56tWjENCu7ugufvgUr7HBL7oNTdTFz0/BrRJr1meUQ1LdLQm3dBXuki
         Z0dpOKR7iFK7UxVMCCBvuKM3DW19IyWJKqMEfc09wqrbrDrmeVymbMJIcZrITV9YZUUf
         Wlr6Rm0RsRZO++QhT5U6M6fD66yMlGWzCW4d4VRzUUEIKXMCgvDBxYFfiofbfESYgolm
         GeCtUWklFwr6xz3pOUDO714+v5NgLt5PFcHs+LZACSdYSRePXOVVM+P8gFBb50yoxkio
         VHvDBDAtM1FSYb/GjzAtwbwT9fIg/YsMrF8vBiKdO56Zs1osEYr6iIHe/p5fm7pmrdaz
         IJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEeLkirnfCYQuHYnsGsdZPBzkk8jMtMxsiPF74aFxoU=;
        b=BEhEDif4hCUpy3eb4Bdp/m1p2ws1vbpWeFnlo/SvXWFYlWRYLe8QSX1m+QZ4W2yk4g
         Uxtzzo8oE0u9gV7IPKtsYavzAgL5FzwpWvz0NGCVUsOc+g7psanMaQPryOV1E9mIfi1i
         vFoIecwzr4dI04b4rSFzejXRnadEhYYhQhV+S92epIuKjilpq/poFfMIzsgHy1yx/nOb
         WKD8PzesIW79K/2SZtdkKDE61afKkywk+igDMNknkb6NrMGh5rUyBrL1Qa3nJAe8JPJA
         +KfIPUQDW3Srw+UkVVX1zab38JBJVHuxND1yxzLjiEZx2znwyMpHCbjI3riJrIPfYqxE
         FAzw==
X-Gm-Message-State: AOAM5301vHk8Tafok8cBXYK0jPZ4SHqUPX2zuknob4gW+ezB/ggWkucp
        BmwpQmRE83PNNIVbVTkJIgUNIkP61PJYle0y59acYQ==
X-Google-Smtp-Source: ABdhPJzpIivUn9UvwbUvVupnSMxfes8KAUG1L6DuN/3A5ndBfwCuMDkJBSZ1u8lYbldRIQOX0G6wA92ucPASKf925XM=
X-Received: by 2002:a67:8095:: with SMTP id b143mr14129643vsd.48.1625566125254;
 Tue, 06 Jul 2021 03:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com> <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
In-Reply-To: <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Jul 2021 12:08:08 +0200
Message-ID: <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> > > Thanks for your explanation.
> > >
> > > I think there may be some misunderstandings here.
> >
> > I fully understand what you want to do.
> >
> > >
> > > Our purpose is to avoid our GL9763e from entering ASPM L1 state during
> > > a sequence of 4K read requests. So we don't have to consider about the
> > > behavior/performance of the eMMC/SD card and what eMMC/SD card that is
> > > being used. We just need to know what kind of requests we are
> > > receiving now from the PCIe root port.
> > >
> > > Besides, the APSM L1 is purely hardware behavior in GL9763e and has no
> > > corresponding relationship with runtime PM. It's not activated by
> > > driver and the behaviors are not handled by software. I think runtime
> > > PM is used to handle the behaviors of D0/D3 of the device, but not the
> > > link status of ASPM L0s, L1, etc.
> >
> > Maybe runtime PM isn't the perfect fit for this type of use case.
> >
> > That still doesn't matter to to me, I will not accept this kind of
> > governor/policy based code for use cases, in drivers. It doesn't
> > belong there.
> >
>
> Hi Ulf,
>
> The behavior of this patch is to set the value of a GL9763e vendor
> specified register. Why it doesn't belong to GL9763e driver but other
> common codes?

Let me try one more time.

The code that is needed to put the GL9763e HW into low power state
(writing to GL9763e specific register) certainly belongs in the
driver.

The code that monitors for a specific use case does not.

>
> > >
> > > I agree that the policy of balancing performance vs the energy cost is
> > > a generic problem that all mmc drivers share. But our driver of
> > > GL9763e is a host driver, the setting in this patch is also only for
> > > GL9763e, could not be used by other devices. It depends on our
> > > specific hardware design so that it is not a generic solution or
> > > policy. So I think to implement such a patch in our specific GL9763e
> > > driver to execute the specific actions just for our hardware design is
> > > reasonable.
> >
> > From the use case point of view, the GL9763e hardware design isn't at
> > all specific.
> >
> > In many cases, controllers/platforms have support for low power states
> > that one want to enter to avoid wasting energy. The difficult part is
> > to know *when* it makes sense to enter a low power state, as it also
> > introduces a latency when the power needs to be restored for the
> > device, to allow it to serve a new request.
> >
> > To me, it sounds like you may have been too aggressive on avoid
> > wasting energy. If I understand correctly the idle period you use is
> > 20/21 us, while most other drivers use 50-100 ms as idle period.
> >
>
> Yes, according to our customer's test for the GL9763e, if the ASPM L1
> entry delay of GL9763e, which is the idle period you mentioned, is
> larger than 20/21 us, it will not pass the PLT test. The PLT is
> requested by Google for evaluating the product's battery life. The
> product won't be accepted by Google if it fails the PLT test. So we
> set the ASPM L1 entry delay to 20/21us.
>
> With such a short idle period, during 4K reads, the idle time between
> the read requests will be larger than 20/21us, so GL9763e will enter
> ASPM L1 very frequently to impact the performance.
>
> The bad performance of 4K reads was highlighted by Google, too. Our
> customer has to pass both the PLT test and 4K read performance test by
> Google's request. So after some discussions with our customer and
> Google, we decided to submit such a patch to get the best balance to
> satisfy Google's requiremnet.
>
> The function and the register is vendor specified of GL9763e, so we
> access it in the vendor driver of GL9763e. Add some functions in other
> mmc general codes to do something only for GL9763e and can not be
> applied by other devices might be a little bit strange and difficult
> to implement and design?

I haven't said implementation need to be easy, but suggest a few
options to move forward.

What did state and I am not going to change my opinion on this, is the
governor code that monitors for use cases, don't belong in the driver.

Kind regards
Uffe
