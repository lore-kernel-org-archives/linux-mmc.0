Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5606CC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2B2615E2
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Nov 2021 14:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhKSOrb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhKSOra (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Nov 2021 09:47:30 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F531C061574
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 06:44:29 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x9so10418683ilu.6
        for <linux-mmc@vger.kernel.org>; Fri, 19 Nov 2021 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8M7T/9hIHi+vY8J076wcFRiweC2iqEzOuRzO4bB3xUs=;
        b=WXlvKjZV3HBh90e6D+lL/3CXfNiYZt5V67X6F7KQ2qCVFHF74kaynkcRfoqQn+NVnu
         6fJVezaFUqmsc9niE78AXKR/UGgw8jaMxzML7S1TQ+MxoDxFXbwa/pg2VRaB/l9ZNyZ9
         PkvNN9l4IGPpaoGmVXxLCrqI4Scwx2D6WIlcbRau505Dt/jFD8PrS5yOAb/5MujJ8cZC
         qZJM68TQ8tC1n0Rg6bbZvkfvkEOwzJeYKRXiq5cPJR0YXjZePXga8ndnyyTPrl6c/cyo
         gmRMPtWTGHhpenO0D5Qt/ArFx2wqDQ3uPe7S48zybqq6qqPfAJsFrb1UzoIvrZ/3Q8hU
         6TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8M7T/9hIHi+vY8J076wcFRiweC2iqEzOuRzO4bB3xUs=;
        b=P8DTigEn9lUlKXNhvAM3CzdBkYcMqXSVfseGFJmM1CpX+SrbMES32KP4Ah4Gur8Sey
         eQVJKyBZZ32rjK7154a559q+yR0QiI/R/JVBAacjOPN4/4Jr+Ksnr2oAYej9VzkrpzQJ
         YBODGNG+Fo3HmwgtVQgj273I/uQzMN86XURcsqRy89AnGrirLOI9/XDdPDxXmkPZGs+K
         6/YnavfmjxylmsSRPkDlaUiFCBnu7gXK0gwElKgoY6747emvVdMUBRuGQmTn4MDIWVDZ
         6cLU+02BwYvPe/fIXpk6yYUEhO+4uEnwNjvDF5+Fn6PJpxjL0fFNuB/Tb93KtgJiub6m
         7R8w==
X-Gm-Message-State: AOAM531LPrAjV6XGltksyP9io+MJ7CwQTTTuNAt3gQOxjprFOIdNt6oZ
        BsUC8yG5KFgRRm7kH9gvwjZ7n/PORhGsjW5yR1gi1g==
X-Google-Smtp-Source: ABdhPJxxWm7d3ZkWfy8PMGtiI9JQ6snFz6Vpty+QbvdBLWhPs0biiuBzxlyleHjI68J1WimPLxbxTcP5F2FjpEpyGyM=
X-Received: by 2002:a05:6e02:144e:: with SMTP id p14mr5204343ilo.180.1637333068317;
 Fri, 19 Nov 2021 06:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20211117160859.8732-1-marten.lindahl@axis.com>
 <CAD=FV=WWF9W=cXQWkcvQAgXjGZjBzgvV3jB90nZ35JYdi8YA-w@mail.gmail.com> <20211118105113.GA3708@axis.com>
In-Reply-To: <20211118105113.GA3708@axis.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 19 Nov 2021 06:44:16 -0800
Message-ID: <CAD=FV=Xkez1iEme2npVfz1MBXurz0Vm2L9akHTFAwr_Tec0X2g@mail.gmail.com>
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

On Thu, Nov 18, 2021 at 2:51 AM Marten Lindahl <martenli@axis.com> wrote:
>
> On Thu, Nov 18, 2021 at 12:29:46AM +0100, Doug Anderson wrote:
>
> Hi Doug!
>
> > Hi,
> >
> > On Wed, Nov 17, 2021 at 8:09 AM M=C3=A5rten Lindahl <marten.lindahl@axi=
s.com> wrote:
> > >
> > > The TMOUT register is always set with a full value for every transfer=
,
> > > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds=
.
> > > This is normally good enough to complete the request, but setting a f=
ull
> > > value makes it impossible to test shorter timeouts, when for example
> > > testing data read times on different SD cards.
> > >
> > > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> > >
> > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > > ---
> > >
> > > v2:
> > >  - Calculate new value before checking boundaries
> > >  - Include CLKDIV register to get proper value
> > >
> > > v3:
> > >  - Use 'if-else' instead of 'goto'
> > >  - Don't touch response field when maximize data field
> > >
> > > v4:
> > >  - Prevent 32bit divider overflow by splitting the operation
> > >  - Changed %06x to %#08x as suggested by Doug
> > >  - Rephrased commit msg as suggested by Doug
> > >
> > >  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > index d977f34f6b55..8e9d33e1b96c 100644
> > > --- a/drivers/mmc/host/dw_mmc.c
> > > +++ b/drivers/mmc/host/dw_mmc.c
> > > @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slo=
t *slot, bool force_clkinit)
> > >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> > >  }
> > >
> > > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > > +                                   unsigned int timeout_ns)
> > > +{
> > > +       unsigned int clk_div, tmp, tmout;
> >
> > didn't notice before, but nit that I usually make it a policy that
> > things that represent cpu registers are the "sized" types. Thus I'd
> > rather see these locals as u32 even though the parameter (which
> > represents a logical value and not a CPU register) stays as "unsigned
> > int").
> >
>
> Thanks, will fix.
>
> >
> > > +       clk_div =3D (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > > +       if (clk_div =3D=3D 0)
> > > +               clk_div =3D 1;
> > > +
> > > +       tmp =3D DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC=
_PER_SEC);
> > > +       tmp =3D DIV_ROUND_UP(tmp, clk_div);
> >
> > I guess in some extreme cases you still have an overflow. Not sure how
> > many people really use "div", but...
> >
> > The case I'm thinking of is if the timeout is 80 ms, the bus_hz is 200
> > MHz, and clk_div is 20 (register contains 10). I think that would mean
> > you're feeding the controller a 4GHz clock which it probably couldn't
> > _really_ handle, so maybe this isn't super realistic. In any case, I
> > think the first statement would be the equivalent of 80 * 200MHz =3D
> > 0x3b9aca000 and that blows out the 32-bit "tmp" variable.
>
> I'm sorry but I fail to follow your calculation here. With 80ms timeout
> and 200MHz bus_hz, I get:
>
> 80000000 * 200000000 / 1000000000 =3D 0xF42400

Sorry, it's just my brain not working properly. Yeah, I think you were
fine assuming it was 32-bit. It seems terribly unlikely that bus_hz
could be anywhere approaching 32-bit max. Even if it was, the timeout
is documented to be max on the order of 80 ms:

/* data timeout (in ns, max 80ms) */

...and even if that's wrong and it's 800 ms _and_ bus_hz is the
absurdly large 0xffffffff then we still don't timeout.

Sorry for getting that wrong. :(

-Doug
