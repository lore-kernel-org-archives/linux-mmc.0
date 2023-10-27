Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2366C25B47
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Oct 2023 09:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJ0JmO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Oct 2023 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0JmM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 05:42:12 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999B9C
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 02:42:10 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5af6c445e9eso7696107b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698399730; x=1699004530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VMb1Z6HehG+TXOkjUYAHp3oTZoMdVg1W7mdkCeYuVtg=;
        b=L8EOK2xDaoIiNDXh0VIqC4eWhinf1Y+3o2+w8wojXhvbyCw7/dFNQiOBe80mLKWaIS
         5jIldN/aDNfIbUcrujqrX09qCuegHD3q3cCeDK+JjwPJs0/ljQvW3i8oTtlCWgP3qCLi
         2G79Vtjq3h6yBfEP4zzdCEA2goHy/a4fcSQiKaxGrszEqbPKAacDTRjgurCZhvPaLXVI
         QwHC4ZoLCiwKkcurnzjSVOAVw6nDkR6u0FDcEVU81Xm6dzPzwhCGUDH+c6umlfRzFFge
         7Fajr6WMWCh5/GvaJskKYN/ZAAGhc7dSDbj4xfOb02ICQjzY6QgtGsDuFK0/L8uC/pjo
         BUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399730; x=1699004530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMb1Z6HehG+TXOkjUYAHp3oTZoMdVg1W7mdkCeYuVtg=;
        b=FJVHoYBoX0EJyP1wAIADw11AY0wqJSVRNRfC2utkq/VPvqI8x7oUuxoczpbYMRiUL5
         bOVXhkUSM1ii1NjNnmeQCKdgE+V7aI0t1G5PcGj1xHesIaekg1pMTHicEIF/ZR6dQOZZ
         YTtf4Dpfnfr8WB0HCOC6zdo9P8u1OxU39tVdSkq9BSWYXQ0uvOR1VLNJv8TaUWp2Btmw
         YAe/9R+HgSZhTGez8NbxXZEoKWUKALCyhHwNKEoJ13lc7drhm3UdtyB5TtIKIOXRqMKc
         e6bS3U92NT7mJ3marpkBgeBUUxN7ziPYtRKeFDYWfzFsl4X4+GbLNTngKB7QAaVS9f9l
         lI5A==
X-Gm-Message-State: AOJu0YyQgIbl2yd1nc94Qj0pX5FMPO1qUgxgylcUoUCRTX4/H3rmO/k3
        nUHLky387MVgqmirNwDzqxB2UaKt6mH3hLAocX4U3G34joasprP5tSk=
X-Google-Smtp-Source: AGHT+IHQTLXQx3T1kAo0uQ3Sx5G3oQYBdzSQOdEjZHuTzygp11cqth3wtZKcB2Iox1ye/qF9/3ylBP/sLE1GGLi9F9Y=
X-Received: by 2002:a81:bc03:0:b0:5a8:1058:5d97 with SMTP id
 a3-20020a81bc03000000b005a810585d97mr2048955ywi.45.1698399729832; Fri, 27 Oct
 2023 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231025113035.1881418-1-avri.altman@wdc.com> <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
 <DM6PR04MB6575743E1EBDC899206E9A9AFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575743E1EBDC899206E9A9AFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Oct 2023 11:41:33 +0200
Message-ID: <CAPDyKFqHV02EaSMDgLZHG51DT-smhWcc7=EvUG9+N5g7ns1HJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Oct 2023 at 12:07, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On 25/10/23 14:30, Avri Altman wrote:
> > > Field Firmware Update (ffu) may use close-ended or open ended sequence.
> > > Each such sequence is comprised of a write commands enclosed between 2
> > > switch commands - to and from ffu mode.
> > >
> > > Some platforms generate auto command error interrupt when it shouldn't,
> > > e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
> > > issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook
> > x2,
> > > a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
> > > sure it disable auto-cmd12 while close-ended ffu is in progress.
> >
> > I think I misunderstood this because I was thinking that auto-cmd12
> > was being used with an open-ended sequence, and that it wasn't
> > working with FFU.  However it seems mmc-utils is using a closed-ended
> > sequence.
> Yes, mmc-utils, fwupd, as well as others - uses close-ended,
> And unlike rpmb - it sends cmd23 as part of the ffu sequence.
>
> >
> > It looks like the the host controller driver doesn't know that,
> > because the ioctl interface does not use mrq.sbc and the
> > SET_BLOCK_COUNT command is sent separately.  Then when the
> > MULTI_WRITE
> > command is issued, the host controller driver treats it as open-ended
> > and will enable auto-cmd12 if the controller supports it.
> >
> > If that is the case, it would be better to fix the ioctl handling
> > and make it use mrq.sbc instead of issuing SET_BLOCK_COUNT separately.
> We can do that.
> On the other hand, this doesn't happen on other platforms.
> Fwupd has just recently switched to close-ended, but mmc-utils is using close-ended mode for many years,
> Performing ffu successfully on many different platforms.
> My understanding is, that the hw should realize that cmd23 has just sent prior to cmd25 and avoid this auto-cmd12.

Yes, in principle that's correct.

In fact, I think that most host drivers should already support this
behavior, although it relies on the CMD23 to be incorporated within
the same mmc request (mrq) as the CMD25. We use "mrq.sbc" for this and
the host driver uses MMC_CAP_CMD23 to inform the MMC core whether it
supports this or not.

>
> Going back to your proposal, we can ignore cmd23 in close-ended ffu, but eventually,
> we will need to change mmc-utils and fwupd to stop send cmd23.

This is not what we proposed, at least if I understood Adrian correctly.

Instead, the idea that could make better sense, is to fix the mmc
ioctl handling in the mmc core, so that it can discover that a CMD23
command is followed by another CMD18/25 (multiple read/write). And in
this case, it should boundle the commands together, using mrq.sbc so
that one request gets sent to the mmc host driver instead of two.

In this way, there should be no need for any specific changes to any
of the host drivers (assuming they have the CMD23 support implemented
correctly), they should just work.

[...]

Kind regards
Uffe
