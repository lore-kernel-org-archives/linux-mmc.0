Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E60C63697
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A970221D1A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gh8XjXmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbgKZPCp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389568AbgKZPCo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 10:02:44 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45112C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 07:02:43 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id v6so1080687vsd.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 07:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OqkXUBQ1i4Vmor4ADqr8LW41OTo4FFyxr1N6+Z/rA5s=;
        b=Gh8XjXmYgT4LldSMXq+eDAAJJpw9+ajrtOclQFMjho93UopgOYSwWmMfZN88qbnn26
         Nik7LSQ7REuIyVQ7fxRGiuZcBaqes3wRK2JQ10kCOh23GLRDycvOlg97xnzmhkugYdPV
         KmzeHc9Pt2T9xYCjwUEWtsuN2ccRc+NKG5V7Z3uxlUSnjE7ewPM9NNJKEHuQlzJHY2Tz
         YIE8FRx/qOeXbU4NC3VafWqKHfPkZ+VhUMmfvWJwMhwpO3QG1vPdOr2Dj2FPC0tzg36Y
         1ztZHIegTsaPgVDT0IOSNor/yjpsbO5wPNXCpOZg6iEJbSpcplcxlVxrHP4ppCkH3FAi
         xRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OqkXUBQ1i4Vmor4ADqr8LW41OTo4FFyxr1N6+Z/rA5s=;
        b=MCXK+G/tHmOlaJWe0H1yxEEDHu5dHh2erXmVmu/q/31kDiBlTDzcd0MDwYfS5jAAWL
         jbBW74b3YeJJm6jvaU+yLJtVmIS2mc/7KlMb+uNuhYFItnoWmQrDY9dlOAJtHyFL5CXZ
         kOHSoRXomrVCwh0w/l2akY8ZyY2cyzXqhWWkVaOxrVsvqEa9W19/iedTMkZTkdBW2rsC
         X95Kduhl4Ju7O2wAb44TYFjwcTV2q6nv9u2+iLPwtLKlLXzEs2OBNkkBUYBlBKjzZ+v1
         pNcpBOLhPunxFmvMedFcOjcE2IqTtyjFY/k401p7XLsUs2yxqKkFLg0Ish66qE4FCox7
         Ylrw==
X-Gm-Message-State: AOAM530WeDHELVMvsENualDogdlPgtj0Pzm3TEbdNl50NgpHYmz3BHeV
        3Vx48JOj3a5sa8hVpSctgSv3A0bqffD15u7N2w5B7w==
X-Google-Smtp-Source: ABdhPJytKgXCtMQjzdnzBaMHgZEdsYliZUdDBrFUZSCukRRaCw2+1Wea9rb3AivqdOw/P9snQqpJZoEWty8mGhoOa9s=
X-Received: by 2002:a67:8c44:: with SMTP id o65mr1942819vsd.55.1606402962450;
 Thu, 26 Nov 2020 07:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20201124060202.776-1-ricky_wu@realtek.com> <20201124204915.GA585306@bjorn-Precision-5520>
 <CAJZ5v0gt4aeC5S6RY2W98vmcMSs9gb_SBA8-eoq1NU3wPptL8g@mail.gmail.com>
 <6f721ea4d5a84f45b0249b932d742367@realtek.com> <CAJZ5v0ggtd3+YEo2nERhuTeurRx5OQrvLkAz3aEMPRmEfo_Rnw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggtd3+YEo2nERhuTeurRx5OQrvLkAz3aEMPRmEfo_Rnw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Nov 2020 16:02:05 +0100
Message-ID: <CAPDyKFohv9qC4Sp3ffGg9z6Bj7gKq3-iubaiuZqY2121amL2Bw@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: rts5249 support runtime PM
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        Doug Anderson <dianders@chromium.org>,
        "rmfrfs@gmail.com" <rmfrfs@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Nov 2020 at 15:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 26, 2020 at 4:07 AM =E5=90=B3=E6=98=8A=E6=BE=84 Ricky <ricky_=
wu@realtek.com> wrote:
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki [mailto:rafael@kernel.org]
> > > Sent: Wednesday, November 25, 2020 10:04 PM
> > > To: Bjorn Helgaas; =E5=90=B3=E6=98=8A=E6=BE=84 Ricky
>
> [cut]
>
> > > > > +static void rtsx_pci_rtd3_work(struct work_struct *work)
> > > > > +{
> > > > > +     struct delayed_work *dwork =3D to_delayed_work(work);
> > > > > +     struct rtsx_pcr *pcr =3D container_of(dwork, struct rtsx_pc=
r,
> > > rtd3_work);
> > > > > +
> > > > > +     pcr_dbg(pcr, "--> %s\n", __func__);
> > > > > +
> > > > > +     while (pcr->pci->dev.power.usage_count.counter > 0) {
> > > > > +             if (pm_runtime_active(&(pcr->pci->dev)))
> > > > > +                     pm_runtime_put(&(pcr->pci->dev));
> > > >
> > > > I'm not a runtime PM expert, but this looks fishy.  AFAICT this is =
the
> > > > only driver in the tree that uses usage_count.counter this way, whi=
ch
> > > > is a pretty big hint that this needs a closer look.  Cc'd Rafael.
> > >
> > > You are right, this is not correct from the PM-runtime POV.
> > >
> > > It looks like this attempts to force the PM-runtime usage counter dow=
n
> > > to 0 and it's kind of hard to say why this is done (and it shouldn't
> > > be done in the first place, because it destroys the usage counter
> > > balance).
> > >
> > > Ricky, is this an attempt to work around an issue of some sort?
> > >
> >
> > Thanks Bjorn and Rafael
> > I found when we boot up, our dev pcr->pci->dev.power.usage_count.counte=
r always is 2,
> > Don=E2=80=99t know how to make it to 0 because we need to support D3 an=
d run runtime_suspended callback function
> > Is there something wrong with us to enable runtime PM?
>
> That is possible.
>
> If you want it to be enabled by default, you need to call
> pm_runtime_allow() from the driver at probe time, in addition to
> pm_runtime_enable(), in the first place, but that only drops one
> reference, so question is where the other one comes from.

Yes, good point.

Moreover, I am wondering whether you also need to deploy support for
runtime PM for the child device (managed by
drivers/mmc/host/rtsx_pci_sdmmc.c driver), as to make the support
complete.

>
> Are the pm_runtime_get*() and pm_runtime_put*() calls balanced?

Perhaps have a look at how the drivers/misc/cardreader/rtsx_usb.c and
drivers/mmc/host/rtsx_usb_sdmmc.c have implemented this could help. I
know it's USB, but it should work quite similar in regards to runtime
PM, I think.

Kind regards
Uffe
