Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F669C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8472074A
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REJluwrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHYM16 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHYM15 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 08:27:57 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29873C061574
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 05:27:57 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v20so3653369ual.4
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXAcAxTseaWXVy3WA8AWto61i26TH0B4opiA6dfddGw=;
        b=REJluwrnwOyg2hOD/lgPsJOFIGqFpdv0IKUZme3doE38OQXHd0VIfkGsPuCEJexbGa
         D7Zqyh9JY1pB44T3q6baobQJZELLWRWxUll8aWStnKMK+5Wql1/P8qxFDbzVWFhYReHX
         fUpvoxH54sYVH9KWUy1Rm/VoVLYTo/pJiKPlu3gIN4nRhNgEUOv2YBZXHmjSTn5+ovP6
         tI6shmuCor8/eCccyme5YdprEPlu+8wY11x2XUVV5PiPCDp9adu++Yoov4ddxNimGwcO
         jjynYMs3NCUlyFRiVXSaPY4ar5vsla0daVD0BACONpDT0FQXD5Qu/1TmA3k0IVMYLyzx
         BZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXAcAxTseaWXVy3WA8AWto61i26TH0B4opiA6dfddGw=;
        b=FPQv3ShAafXoJEjMqqQDSSb2aG3Cj+r7KhqAP0X8QBMrthTxF9wDiWMEZ4AZn3ru2G
         Sehqu8tUhSWW9GbgX1cLpJQ0XS/+oyJN0qUvsoDm0LNGZ12R+O9zX1Lt1kVisLWiRDfF
         CwzBTBNy8bTuy9zk9N2yylkReEM9g1YSU4Ykf672VXh47Gg82uzjXHgOIhMdDKz685EC
         VjoHgFygwA9sSr5Tdt+nVxrGk26Gpr7jSUXwUoeeTjcS0twFdglQezygejj+u3yy4kOB
         HgpDVgZJLTc+/BtAH4EvjDXazFcX3oHD9jgaiZ24RLYMcu+QrQ6kFXxRKXiOARSKERvg
         f6XQ==
X-Gm-Message-State: AOAM530hCWPeamFYWqQt5lyQsr0xAmo30+BDya5dhcSrmHGMG8yLr1mx
        BpBLIXDwcrnO7EwA16GLWdJE+Nw8i/r9ZMKKIvlU+w==
X-Google-Smtp-Source: ABdhPJyLD5TMe3bvBPeNhQui6keXl4ZOWJKGePb3ny5juTl/wKzNH4RrbWJFDr6RTwjFtF6g6pilavh9D7uTVri/BRc=
X-Received: by 2002:ab0:3a85:: with SMTP id r5mr5450357uaw.100.1598358475874;
 Tue, 25 Aug 2020 05:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
 <CAPDyKFoi7KghuBqu7YVS4GH4Bp1puhgb=PcwBVDvaTesLujrrw@mail.gmail.com>
 <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com> <11654b05dd8fb87e195aed20cbdaa22d8856b072.camel@ew.tq-group.com>
In-Reply-To: <11654b05dd8fb87e195aed20cbdaa22d8856b072.camel@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 14:27:19 +0200
Message-ID: <CAPDyKFrBj2RO3jqgrQ5qhYpMOFfjufBnr2y8McdgJXR-Z_618g@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH mmc-next v2] mmc: allow setting slot index via
 device tree alias
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Aug 2020 at 14:00, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> On Tue, 2020-08-25 at 11:39 +0200, Matthias Schiffer wrote:
> > On Tue, 2020-08-25 at 11:14 +0200, Ulf Hansson wrote:
> > > On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
> > > <matthias.schiffer@ew.tq-group.com> wrote:
> > > > --- a/drivers/mmc/core/host.c
> > > > +++ b/drivers/mmc/core/host.c
> > > > @@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int extra,
> > > > struct device *dev)
> > > >  {
> > > >         int err;
> > > >         struct mmc_host *host;
> > > > +       int alias_id, min_idx, max_idx;
> > > >
> > > >         host = kzalloc(sizeof(struct mmc_host) + extra,
> > > > GFP_KERNEL);
> > > >         if (!host)
> > > > @@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int extra,
> > > > struct device *dev)
> > > >         /* scanning will be enabled when we're ready */
> > > >         host->rescan_disable = 1;
> > > >
> > > > -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> > > > +       host->parent = dev;
> > > > +
> > > > +       alias_id = mmc_get_reserved_index(host);
> > > > +       if (alias_id >= 0) {
> > > > +               min_idx = alias_id;
> > > > +               max_idx = alias_id + 1;
> > > > +       } else {
> > > > +               min_idx = mmc_first_nonreserved_index();
> > > > +               max_idx = 0;
> > > > +       }
> > > > +
> > > > +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx,
> > > > GFP_KERNEL);
>
>
> One more question I came across when reworking my patch: Do we need a
> fallback here for the case where the reserved index is already taken?
> To handle an SD card being replaced while still mounted?

Removal/insertion of an SD card should be fine, as that doesn't mean
that the host is removed. In other words, host->index remains the
same.

Although, for a bad DT configuration, where for example the same
aliases id is used twice, a fallback could make sense. On the other
hand, as such configuration would be wrong, we might as well just
print a message and return an error.

[...]

Kind regards
Uffe
