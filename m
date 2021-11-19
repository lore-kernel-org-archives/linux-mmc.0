Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3EC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E46B61502
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 15:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhKSPjO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPjO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Nov 2021 10:39:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B71C061574
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 07:36:12 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p23so13263689iod.7
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 07:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o23UXjTT8GXJYoHFrOHXCcmeWs7b7LasqWpFtY9gidI=;
        b=jOqMSvLug8Fh3xIibbUaTDDMVArdi56HLsAqWlLGCKsKHZPS5XA8sQOcjpz89Mh1W6
         Ig1Kmn5e3QtCW96Z4joUnAfbmG0jh+LDHG6cLzVWcNtf3A04YrnIpntUEPXRoltibGTY
         GAiIo2D1B0FQGc2GoStIeTSy/FLc2cf3zxspg0fu8WdLQCdKWzES+bOKso7siD+wlWZz
         fa0ohk/kBkPWfebLHsWCURLpUp9kz256PLRepo/UCBlc1uM2cYzc5Vo5XttS6IfZ0ODl
         CuM0tmPQhQLRj5J32icOKMM0x/FlW/xMiy0P+LlxCDP5w+FiNDL77bhUgvApaZPCfHCW
         3MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o23UXjTT8GXJYoHFrOHXCcmeWs7b7LasqWpFtY9gidI=;
        b=wTMlvDROIEw37yGVnT+VclfDa50shNiw/HhncKrXWt9Q4kTQN+tcVg/l+ZySWxxEjF
         6T695mPiptULosc9z9TvT5uMlbrnZVd5Alq6iQL4/uhXzwAFjHK4PgPgIIM6Kj/GyJAD
         yAbgN9f+el+xEj2r1gSFxCY7AQP8gFlU4N56ucDjE9KmptRoPOZwnrZ0wkPOdBzZLgyO
         WVvX0cIlzEb/apfcGeL4Fr1Z68IlzYvvCbpsscUJTzUQvVoVG5qTHK9qiRT4cnrKeSQ/
         JfD4vc21b3kD5JuKEYruTXRFP9vAPslZlFfiuv+RQLzqafZEfdYhtxW01vG8ooVAF1st
         qRKQ==
X-Gm-Message-State: AOAM530Im0OS5Lgc4MBZwmSDbK09R0vr5c4PhG5q1cStWp9pyfRQqxvY
        XZvsg0HBRVb2snuvVqcjK46asnt7j44J0bF2XBfp+w==
X-Google-Smtp-Source: ABdhPJz2pxJ7Xq2YHOT1I1oi64bN5PzjB22HRMihNhisI/azUl3pWSkwZ03sDg4roMGck7p06XTqNrM0dFp4V7ITJdc=
X-Received: by 2002:a05:6638:2590:: with SMTP id s16mr28768695jat.93.1637336171535;
 Fri, 19 Nov 2021 07:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20211117160859.8732-1-marten.lindahl@axis.com>
 <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com>
 <20211118105113.GA3708@axis.com> <CAD=FV=Xkez1iEme2npVfz1MBXurz0Vm2L9akHTFAwr_Tec0X2g@mail.gmail.com>
 <20211119153037.GA20316@axis.com>
In-Reply-To: <20211119153037.GA20316@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 19 Nov 2021 07:35:59 -0800
Message-ID: <CAD=FV=UP6k14dbwa26ZT_k_JbRRTG7sPtO433rgETBhjWSPuQQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 7:30 AM Marten Lindahl <martenli@axis.com> wrote:
>
> On Fri, Nov 19, 2021 at 03:44:16PM +0100, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 18, 2021 at 2:51 AM Marten Lindahl <martenli@axis.com> wrot=
e:
> > >
> > > On Thu, Nov 18, 2021 at 12:29:46AM +0100, Doug Anderson wrote:
> > >
> > > Hi Doug!
> > >
> > > > Hi,
> > > >
> > > > On Wed, Nov 17, 2021 at 8:09 AM M=C3=A5rten Lindahl <marten.lindahl=
@axis.com> wrote:
> > > > >
> > > > > The TMOUT register is always set with a full value for every tran=
sfer,
> > > > > which (with a 200MHz clock) will give a full DRTO of ~84 millisec=
onds.
> > > > > This is normally good enough to complete the request, but setting=
 a full
> > > > > value makes it impossible to test shorter timeouts, when for exam=
ple
> > > > > testing data read times on different SD cards.
> > > > >
> > > > > Add a function to set any value smaller than the maximum of 0xFFF=
FFF.
> > > > >
> > > > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > > > > ---
> > > > >
> > > > > v2:
> > > > >  - Calculate new value before checking boundaries
> > > > >  - Include CLKDIV register to get proper value
> > > > >
> > > > > v3:
> > > > >  - Use 'if-else' instead of 'goto'
> > > > >  - Don't touch response field when maximize data field
> > > > >
> > > > > v4:
> > > > >  - Prevent 32bit divider overflow by splitting the operation
> > > > >  - Changed %06x to %#08x as suggested by Doug
> > > > >  - Rephrased commit msg as suggested by Doug
> > > > >
> > > > >  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
> > > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.=
c
> > > > > index d977f34f6b55..8e9d33e1b96c 100644
> > > > > --- a/drivers/mmc/host/dw_mmc.c
> > > > > +++ b/drivers/mmc/host/dw_mmc.c
> > > > > @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci=
_slot *slot, bool force_clkinit)
> > > > >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> > > > >  }
> > > > >
> > > > > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > > > > +                                   unsigned int timeout_ns)
> > > > > +{
> > > > > +       unsigned int clk_div, tmp, tmout;
> > > >
> > > > didn't notice before, but nit that I usually make it a policy that
> > > > things that represent cpu registers are the "sized" types. Thus I'd
> > > > rather see these locals as u32 even though the parameter (which
> > > > represents a logical value and not a CPU register) stays as "unsign=
ed
> > > > int").
> > > >
> > >
> > > Thanks, will fix.
> > >
> > > >
> > > > > +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > > > > +       if (clk_div =3D=3D 0)
> > > > > +               clk_div =3D 1;
> > > > > +
> > > > > +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, =
NSEC_PER_SEC);
> > > > > +       tmp =3D DIV_ROUND_UP(tmp, clk_div);
> > > >
> > > > I guess in some extreme cases you still have an overflow. Not sure =
how
> > > > many people really use "div", but...
> > > >
> > > > The case I'm thinking of is if the timeout is 80 ms, the bus_hz is =
200
> > > > MHz, and clk_div is 20 (register contains 10). I think that would m=
ean
> > > > you're feeding the controller a 4GHz clock which it probably couldn=
't
> > > > _really_ handle, so maybe this isn't super realistic. In any case, =
I
> > > > think the first statement would be the equivalent of 80 * 200MHz =
=3D
> > > > 0x3b9aca000 and that blows out the 32-bit "tmp" variable.
> > >
> > > I'm sorry but I fail to follow your calculation here. With 80ms timeo=
ut
> > > and 200MHz bus_hz, I get:
> > >
> > > 80000000 * 200000000 / 1000000000 =3D 0xF42400
> >
> > Sorry, it's just my brain not working properly. Yeah, I think you were
> > fine assuming it was 32-bit. It seems terribly unlikely that bus_hz
> > could be anywhere approaching 32-bit max. Even if it was, the timeout
> > is documented to be max on the order of 80 ms:
> >
> > /* data timeout (in ns, max 80ms) */
> >
> > ...and even if that's wrong and it's 800 ms _and_ bus_hz is the
> > absurdly large 0xffffffff then we still don't timeout.
> >
> > Sorry for getting that wrong. :(
>
> No problem. Reviews are for twisting and turning the code.
>
> To twist it even more, there is no real need to use DIV_ROUND_UP(_ULL)
> on the clkdiv division right? I mean the round up has already been made,
> and it shouldn't be needed twice?
>
> So,
>         tmp =3D DIV_ROUND_UP_(ULL)(tmp, clk_div);
>
> could be a
>
>         tmp /=3D clk_div;

I think you still need the round up, but I wouldn't swear to it.
You've divided by one value, but not the other and each division could
separately need rounding.

-Doug
