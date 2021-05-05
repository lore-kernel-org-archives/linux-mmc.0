Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB55C433B4
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACEC61029
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 14:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhEEOWU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 10:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhEEOWT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2021 10:22:19 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36582C06174A
        for <linux-mmc@vger.kernel.org>; Wed,  5 May 2021 07:21:23 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id s2so617501uap.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 May 2021 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Wu8vERRRHj1yfHNyqIZ+kRPILPBuDDMmiP0sI9Ob1U=;
        b=pENhDxjMvrSRzMPuhjbacNdKdYJ72YA1v9v0Z0whgh7BTf476C7y7StlKeUkdzxAae
         FHowL7xqeqnM25IM116+IjEyBKR8BJpIm9N6IKq2BLNegqMykNjuQHGDA7Y3HDWfpBac
         qBCxnRHU7RKFN5vEkxH0aVnB0lQK5PKpCC1Vtd0qwgKf6JsHQgxKB71rTm79H1Py1eQf
         3wpnazxlxQzp+pldM9X6q8uV+LpyTCocXyIh9SBYct3PyWJnN2U1uhrkaHcokGsTlNnD
         QSSB/GAsU+e7uTICyCyrAXnyTSUoryJOq8YhUTlRywMUl18DHjdXdSZL9cocHjtVgaEc
         oP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Wu8vERRRHj1yfHNyqIZ+kRPILPBuDDMmiP0sI9Ob1U=;
        b=UCMChDNU0cFmsoUyQruxIRBihd43g83rfep5MVu6Cfnb43XBLxz0sMMqFoy/i4QV23
         InQY1DNaUezbnOmw4S8dMS7g4FnxpoqTp5gdUPfDdVK735doXsW6heITImmAmJKB/T1C
         2VS8KxlHwCRpCnEoICj1VbA6BM0pCLHGl3JbSu+GibPWexbt4vPPrweXedbMVNmzy8I9
         JFaTroMR+Z0g8pKEop14nuhMCs8wKUZ0Gf7kpV+exb7dD9LvSMW9zGH5uGoC2TfKP+qx
         jAWCtE5vWt59MMfFon9b0vYCXFXtjgWQFt7mlHYRm/AGu7Ditc6r47UEh+Hib9mvscLj
         ECFQ==
X-Gm-Message-State: AOAM533SrjnCa0+rlDE5RzQJP0DQbp/4/p0WZsTXbFCKRWAjJXGBw+5S
        s5ilfuhY9lCZ0s0fwjKTzdFBYwFbfdfhrXPlAOjcsA==
X-Google-Smtp-Source: ABdhPJzAWoFEJUmSWxg4AyDlsdoyNVvtBfuivPA5CSNlOvVlhVTuqEnC6EZZbrgwOILBcrqWK3cXNnX23NMnNYfDqRI=
X-Received: by 2002:a9f:37c8:: with SMTP id q66mr25624095uaq.129.1620224482345;
 Wed, 05 May 2021 07:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com> <CWXP265MB26802E4E0F1AE7B6FE2836AAC4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26802E4E0F1AE7B6FE2836AAC4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 May 2021 16:20:45 +0200
Message-ID: <CAPDyKFrAS8SP5AMX2fi_ZbsmGm49ZFo4YKcczwYZOmN-AnPn7A@mail.gmail.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 May 2021 at 14:13, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> So two cards that advertise UHS:
> https://www.euric.de/de/flash-speicher/sd-microsd/sd/
> Model SDI790
> and
> https://na.industrial.panasonic.com/products/storage-media/industrial-sd-=
cards/lineup/industrial-grade-2d-nand/series/71695

Thanks for the links!

Are these the ones that you have been using for testing?

> Hopefully that suffices as a couple, otherwise I would buy some
> that do not advertise it and actually check if they support it anyway.
> But 2GB SLC listings are kind of rare these days, so it's not as
> easy to find many that are still sold and available.

Right. I have a whole bunch of old SD cards that I can test. I will
let you know when I have got some time to test some of them.

The main worry (but I may be wrong) I have with the patch is that it
could cause problems for other older SDSC cards, which happens to
incorrectly set the S18A bit. I mean, before UHS-I was introduced in
the SD spec, this bit was just being reserved and potentially it could
have *any* value by the card manufacturer. As I said, let me do some
tests of my older SD cards.

>
> My point about deviating from the standard was that these cards
> are already initialized as UHS, they just don't do the voltage switch.
> So anything reserved for UHS-I (e.g. CMD23 )is already being done
> by the host with the current linux-mmc,
> so the standard deviation is already there.
> Just the voltage switch is missing.

Ah, yes you are right!

We call mmc_sd_init_uhs_card() no matter whether the CCS bit is set.
Certainly this is a bug. Both the card and host aren't designed to
work under these conditions/timings.

>
> Regards,
> Christian
>

Kind regards
Uffe

>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, May 5, 2021 12:09 PM
> To: Christian L=C3=B6hle <CLoehle@hyperstone.com>
> Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
>
> On Thu, 22 Apr 2021 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.co=
m> wrote:
> >
> > Ignore the reported capacity if the card otherwise reports UHS support.
> >
> > Currently SDSC cards reporting UHS support except for the CCS do not ru=
n
> > through the voltage switch.
> > While strictly speaking a SDSC card cannot support UHS in compliance
> > with the standard, there is no good reason to throttle them that way.
>
> Maybe not, but I think the code just tries to conform to the SD spec.
>
> > Especially for pSLCs in practice such cards benefit greatly by this pat=
ch,
> > as they can be new and UHS supporting, but must not lie about their CCS=
.
>
> Can you provide some concrete examples of SDSC cards that support UHS-I?
>
> > The behaviour of linux-mmc for SDSC is deviating from the standard anyw=
ay
> > in such a case, as the card is treated as UHS card not supporting the
> > voltage switch in general.
> > Such a card will come up as
> > mmc0: new ultra high speed SDR25 SD card at address 0001.
> > Thus the subsystem will support CMD23 and others to the card.
> > But if we deviate from the standard anyway, then we might as well
> > not throttle SDSC to 25MB/s.
>
> Not sure I understand this correctly? Can you elaborate a bit more, so
> I understand how we deviate from the SD spec here?
>
> As far as I understand the spec, SDSC cards shouldn't support UHS-I.
> If we decide to deviate from the spec to support this anyway, at least
> we need to know about a couple of cards that actually supports this.
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > ---
> >  drivers/mmc/core/sd.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 6fa51a6ed058..281ca2da8e0b 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr=
, u32 *cid, u32 *rocr)
> >                 return err;
> >
> >         /*
> > -        * In case CCS and S18A in the response is set, start Signal Vo=
ltage
> > -        * Switch procedure. SPI mode doesn't support CMD11.
> > +        * In case S18A in the response is set, start Signal Voltage Sw=
itch
> > +        * procedure. SPI mode doesn't support CMD11.
> >          */
> > -       if (!mmc_host_is_spi(host) && rocr &&
> > -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> > +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
> >                 err =3D mmc_set_uhs_voltage(host, pocr);
> >                 if (err =3D=3D -EAGAIN) {
> >                         retries--;
> > --
> > 2.31.1
> >
> > Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> > Managing Directors: Dr. Jan Peter Berns.
> > Commercial register of local courts: Freiburg HRB381782
> >
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
