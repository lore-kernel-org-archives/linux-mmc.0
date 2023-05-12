Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29CC77B7C
	for <linux-mmc@archiver.kernel.org>; Fri, 12 May 2023 07:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbjELHcX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 May 2023 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjELHcV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 May 2023 03:32:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF818C
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 00:32:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so45287244276.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2023 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683876739; x=1686468739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8navad4OSgKq/Cal1ln2V1VPxHyWrfIGvSuaNP0g5Q=;
        b=nQw8rTaKgB57y8oppoonsCuXZJPk+m2bKkN3CiK7BTGUiSRDXYha0voYeV4UtT1bNT
         dsGN+5E+xIEGVWJTqNhuC7m7IcnMenbE/O0ZIwf326dz8dRpqjdYQ+UqxdQqKMwWVvsb
         GsXvFyssY6lggmOQ8hhpr7u19TPqcGF3IXToavwqNB71t5P7JS9wJBBcLgkIl3WNAW1S
         Wi1NTdWrhwdf8jXd3c8HWYOm/+Fv3w3cxZQ1q7l24v5HL5jS0QlrP/BsWJhijKg9eDgC
         PJ0/7vW96uLnHBv1ulb93dvvGm73gqwv5pGtkQAnUu4R1s6wPjPLXr2mb7wMNFYizgPw
         szcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876739; x=1686468739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8navad4OSgKq/Cal1ln2V1VPxHyWrfIGvSuaNP0g5Q=;
        b=EyG3twVCc9WTP/e1B+l3PfO3zjOYdBiVskN8Coh6hRDhaKIaVYtveInv3AlqnGsLjL
         HXcuypanqaXJWDyLHf05DxUqKnzcSOptEvj3OifRa1isbaQGhzgWp/DD4qysBbLIl/Ik
         u3ZzA1dSvXi2iklLtDZrFkVjd2fLcXwz7SvDpmJ5oS+FSPjZZpIBWZBO77l9cORtTk2j
         ykrd2MARFvyfmPPrs/ekV1N3gpPJy2KTPU0p4cAXUW9b7qyhzPqlUWm30GesBG0jSTp9
         8VvNqGEtf/de/1Gnl1AAgM5KNbHeDIwQXnw6g9r8v+G3w3k2OIHbmfvF9ZwrSJOM+q/5
         b+vg==
X-Gm-Message-State: AC+VfDy4HdmO3H+2nMMs9HpFBSXg330rUb/AWpS5V0O1AIo41AWfv9ew
        Iez86uRmv4TMHhvTleVDLvl6vO8xKt56/ozw2yXs5Q==
X-Google-Smtp-Source: ACHHUZ5DPE9vnUPSQmL5/mvCIB3AirApiexK/F9G5jV6SpZmI3ubKKBebo8S1ULd32w6kIkiBQt7xK3Fb6yGIE3G0U4=
X-Received: by 2002:a0d:e690:0:b0:559:d78f:db64 with SMTP id
 p138-20020a0de690000000b00559d78fdb64mr22150772ywe.3.1683876739525; Fri, 12
 May 2023 00:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <043d49e37e254eb8aa8a2c5fc56a028b@hyperstone.com> <f4434f3226404d0cae470886832b05d6@hyperstone.com>
In-Reply-To: <f4434f3226404d0cae470886832b05d6@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 May 2023 09:31:43 +0200
Message-ID: <CAPDyKFpFYbCrttfdnN35a29V5_Y0x2v2tpZ28UQs48i4A3-R6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 May 2023 at 13:46, Christian Loehle <CLoehle@hyperstone.com> wrot=
e:
>
> Did anyone find the time to look at this yet?
> Any comments?

Hi Christian,

It's been a busy time, my apologies for the delay. I will soon come to
review this!

Kind regards
Uffe

>
> -----Original Message-----
> From: Christian L=C3=B6hle
> Sent: Wednesday, April 5, 2023 1:58 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter <adrian.hunter@in=
tel.com>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Subject: [PATCH 3/3] mmc: block: ioctl: Add error aggregation flag
>
> > Userspace currently has no way of checking for error bits of detection =
mode X. These are error bits that are only detected by the card when execut=
ing the command. For e.g. a sanitize operation this may be minutes after th=
e RSP was seen by the host.
> >
> > Currently userspace programs cannot see these error bits reliably.
> > They could issue a multi ioctl cmd with a CMD13 immediately following i=
t, but since errors of detection mode X are automatically cleared (they are=
 all clear condition B).
> > mmc_poll_for_busy of the first ioctl may have already hidden such an er=
ror flag.
> >
> > In case of the security operations: sanitize, secure erases and RPMB wr=
ites, this could lead to the operation not being performed successfully by =
the card with the user not knowing.
> > If the user trusts that this operation is completed (e.g. their data is=
 sanitized), this could be a security issue.
> > An attacker could e.g. provoke a eMMC (VCC) flash fail, where a success=
ful sanitize of a card is not possible. A card may move out of PROG state b=
ut issue a bit 19 R1 error.
> >
> > This patch therefore will also have the consequence of a mmc-utils patc=
h, which enables the bit for the security-sensitive operations.
> >
> > Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> > ---
> >  drivers/mmc/core/block.c       | 34 ++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/mmc/ioctl.h |  2 ++
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index =
35ff7101cbb1..386a508bd720 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -457,7 +457,7 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_io=
c_cmd __user *ic_ptr,
> >                        sizeof(ic->response)))
> >               return -EFAULT;
> >
> > -     if (!idata->ic.write_flag) {
> > +     if (!idata->ic.write_flag && idata->buf) {
> >               if (copy_to_user((void __user *)(unsigned long)ic->data_p=
tr,
> >                                idata->buf, idata->buf_bytes))
> >                       return -EFAULT;
> > @@ -610,13 +610,43 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *c=
ard, struct mmc_blk_data *md,
> >               usleep_range(idata->ic.postsleep_min_us, idata->ic.postsl=
eep_max_us);
> >
> >       /* No need to poll when using HW busy detection. */
> > -     if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> > +     if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp =
&&
> > +                     !(idata->ic.write_flag & MMC_AGGREGATE_PROG_ERROR=
S))
> >               return 0;
> >
> >       if (mmc_host_is_spi(card->host)) {
> >               if (idata->ic.write_flag)
> >                       err =3D mmc_spi_err_check(card);
> >       }
> > +     /*
> > +      * We want to receive a meaningful R1 response for errors of dete=
ction
> > +      * type X, which are only set after the card has executed the com=
mand.
> > +      * In that case poll CMD13 until PROG is left and return the
> > +      * accumulated error bits.
> > +      * If we're lucky host controller has busy detection for R1B and
> > +      * this is just a single CMD13.
> > +      * We can abuse resp[1] as the post-PROG R1 here, as all commands
> > +      * that go through PRG have an R1 response and therefore only
> > +      * use resp[0].
> > +      */
> > +     else if (idata->ic.write_flag & MMC_AGGREGATE_PROG_ERRORS) {
> > +             unsigned long timeout =3D jiffies +
> > +                     msecs_to_jiffies(busy_timeout_ms);
> > +             bool done =3D false;
> > +             unsigned long delay_ms =3D 1;
> > +             u32 status;
> > +
> > +             do {
> > +                     done =3D time_after(jiffies, timeout);
> > +                     msleep(delay_ms++);
> > +                     err =3D __mmc_send_status(card, &status, 1);
> > +                     if (err)
> > +                             return err;
> > +                     idata->ic.response[1] |=3D status;
> > +             } while (R1_CURRENT_STATE(status) !=3D R1_STATE_TRAN && !=
done);
> > +             if (done)
> > +                     return -ETIMEDOUT;
> > +     }
> >       /* Ensure RPMB/R1B command has completed by polling with CMD13. *=
/
> >       else if (idata->rpmb || r1b_resp)
> >               err =3D mmc_poll_for_busy(card, busy_timeout_ms, false, d=
iff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h=
 index b2ff7f5be87b..a9d84ae8d57d 100644
> > --- a/include/uapi/linux/mmc/ioctl.h
> > +++ b/include/uapi/linux/mmc/ioctl.h
> > @@ -8,9 +8,11 @@
> >  struct mmc_ioc_cmd {
> >       /*
> >        * Direction of data: nonzero =3D write, zero =3D read.
> > +      * Bit 30 selects error aggregation post-PROG state.
> >        * Bit 31 selects 'Reliable Write' for RPMB.
> >        */
> >       int write_flag;
> > +#define MMC_AGGREGATE_PROG_ERRORS (1 << 30)
> >  #define MMC_RPMB_RELIABLE_WRITE (1 << 31)
> >
> >       /* Application-specific command.  true =3D precede with CMD55 */
> > --
> > 2.37.3
> >
> >
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
