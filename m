Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14525C33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC7E2075B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2BorqGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgAPPrJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:47:09 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42504 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgAPPrJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 10:47:09 -0500
Received: by mail-vs1-f66.google.com with SMTP id b79so12941999vsd.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8GCNZcg16saTrMZk9XDpdMaVZPA9De2RuDrXztHKIQ=;
        b=k2BorqGRv1qecoewrZRof15MBjeX/nLBmpC89UNAKjqBpUv+vsGetaEEc4jezRDpdc
         tlj4QgYXN3P22IEUxfsuDvBx37inTng/nxtGxBE0uDgAkYoys5WL44o6fJBqJZKzADl/
         wRsNZ7d3SnQ+tO4x9wkExC9KeBWArdwGKnMYfESx1zC0Sc1O6zgxDycMQ72JyMIGlqPc
         7tbyenglNkIrRS7BtwiS2TxSU0yE+SG+E1GdWaQol11w/7wje3jRk8+fbtn3OnpY54Ie
         IbXpyQGy3tsPShbYWkAtOaOEHLh1RdWdaDJ1WEzaNuE1xOK7wydpA2OwNRJEGqTP5Ca9
         ewng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8GCNZcg16saTrMZk9XDpdMaVZPA9De2RuDrXztHKIQ=;
        b=UqE+FcDpdJoAkI1oEHhFSB8dWlhGPzDNVR2u9n11BwLlpA1kbr9ob7PI9wo/ePXA88
         jm3IxzkySs4J1rPFd42zOnjCVUkOzxCzIXn0hxcyA5yJ8ZIcjFrFhPDd3GxF18Ev+rA+
         XxBtLNhG9OPuB5bstqxyIz50sBz4WKQp0xdKPpjZ/JoSaVIqlxfJBG7ZwbaalSF9EjGa
         FgvV1/92VukxD/AbA+m1RhvvewugNuMWyatO8PyqDaDAiTTNA6Htc8OhJArsITwNr7Fn
         CF8m+AKl5Ka8/hoOJqu0EF/4OfmXTfc5IOwaxYaI2GTubqGZCz37T6YISEdwIHxyluyx
         NLHg==
X-Gm-Message-State: APjAAAVWfObqHsNDW/0IyDj+qSJkcHTKJpduZOaFT1vdOEpwJO2zmzEA
        N/kHic4YE0sZHT0iyOq6vT+2VUqdhcM+ZGnER9AGv49j
X-Google-Smtp-Source: APXvYqyuDnkVyDWBsgR/JhVT3EpQFHRk0GcoPe4/kJeb0QWiOtiYIF2f+u6CXLSRJ5THanvBhvUpWQ7nIc+twQygCcY=
X-Received: by 2002:a67:e9da:: with SMTP id q26mr1979547vso.34.1579189628280;
 Thu, 16 Jan 2020 07:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20200108093903.57620-1-hdegoede@redhat.com> <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com> <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com> <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com> <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
In-Reply-To: <a9ab8946-c599-5f83-7527-2387a9e82e8a@xenosoft.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 16:46:32 +0100
Message-ID: <CAPDyKFoydOuSE=Eaq168=2_Ycouo7hzyw+RZXhGq7q4D4Qe8TQ@mail.gmail.com>
Subject: Re: [FSL P5020 P5040 PPC] Onboard SD card doesn't work anymore after
 the 'mmc-v5.4-2' updates
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>,
        Julian Margetson <runaway@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Jan 2020 at 12:18, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>
> Hi All,
>
> We still need the attached patch for our onboard SD card interface
> [1,2]. Could you please add this patch to the tree?

No, because according to previous discussion that isn't the correct
solution and more importantly it will break other archs (if I recall
correctly).

Looks like someone from the ppc community needs to pick up the ball.

>
> Thanks,
> Christian
>
> [1] https://www.spinics.net/lists/linux-mmc/msg56211.html

I think this discussion even suggested some viable solutions, so it
just be a matter of sending a patch :-)

> [2]
> http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=20#p49012
>

Kind regards
Uffe
