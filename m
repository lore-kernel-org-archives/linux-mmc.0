Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BECC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CB920767
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 12:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="X2TFKHrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHYMcn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:32:43 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:34172 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHYMcm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 08:32:42 -0400
IronPort-SDR: 3x1e3Pz1wwgpI9X+zYjsp9iXbYNiCGl6869zS6wKdQlry6UZ/QchFDCnrbItKQ+Vj5mwNn73fY
 byJi0Cffvj6It9fidoVSnaFFCBWKd2afRv5/mDfZQv1SiI9lyShuLUx5gQE588CqzErvIoI6cy
 7Kq5KOv+gwTbrFo94qPj8mssP87LEkQbBEoSD2lIugvY+KHxPFbbk4ztRClaMWjAMS0VVAiSAr
 PtnDaCIGZe/BMmwhAInG4XzAvde97QvTIz/fCZ4Qr5KHCHrAfZjZxLTrbQ1ViYsJfCIavZK3pc
 acg=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13590729"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 14:32:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 14:32:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 14:32:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598358760; x=1629894760;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//UX+6dtDsOUhxAY7i7j/5wz0r3N+fBK+XOosoJPu7c=;
  b=X2TFKHrYtkCTYBCwj2Tz1QOT9Ld6aw4ZVo7Ky2Hz3m1fRxYfd930e874
   dlCsgaPZv/5RsWw71Jflo4f/hU43VstavrYDkKiRnoQnA7sHZArxJzOaT
   QooIvqWfOqv6fLss6u7199on/eGrT6E5OmeeaL4avxvaw+sLjq89N3v+D
   iHsTTS9p0cj47T5xXuW+1p+Gj4xYRSGCdeLnTn+r3ffzeKNT84QuuLmyv
   TKL1bX1cI3PBxj+MPlgUqcDsFFOwQVVT91huR3kf3HcZhb7mOih+6gxQu
   ktJDZjs1YNsACgKNwXUgjhWmSv8ol2qm7AvUtK8fvmvWKCdBUxtokwEBc
   g==;
IronPort-SDR: U8bM6z9Do0ynMVDiZZr75f3Wt1TQ80iR8iTg4Zpzn4MSYaMYvxaXQWguiRy2D1M0xaiIA+xRfw
 QIB6ZKrPXlqJPzGNUB37NTBVovbPRQ1cgrxqWN/m1pLAerVydGwddVk+w/VK6mYozdVQY5T3UJ
 BEeP1kG5h0zLWKcGd1TGUsKnQiNP5Bm/igIWEUk7vDjqUouwfuhRipm8QYkvvpdegkAt4A932p
 e8wehn69XnqkCMjdQeexCE4EUpSbnZ95QBlY4kaIH5mlRJYnxeJVINdNwJKitjpk1BgqFhDrMq
 2zc=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13590728"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 14:32:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 54326280065;
        Tue, 25 Aug 2020 14:32:40 +0200 (CEST)
Message-ID: <936a2a0d85b9bd8455cc1844e264a0d9fc86c5ac.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH mmc-next v2] mmc: allow setting slot
 index via device tree alias
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 14:32:38 +0200
In-Reply-To: <CAPDyKFrBj2RO3jqgrQ5qhYpMOFfjufBnr2y8McdgJXR-Z_618g@mail.gmail.com>
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
         <CAPDyKFoi7KghuBqu7YVS4GH4Bp1puhgb=PcwBVDvaTesLujrrw@mail.gmail.com>
         <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com>
         <11654b05dd8fb87e195aed20cbdaa22d8856b072.camel@ew.tq-group.com>
         <CAPDyKFrBj2RO3jqgrQ5qhYpMOFfjufBnr2y8McdgJXR-Z_618g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2020-08-25 at 14:27 +0200, Ulf Hansson wrote:
> On Tue, 25 Aug 2020 at 14:00, Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> > 
> > On Tue, 2020-08-25 at 11:39 +0200, Matthias Schiffer wrote:
> > > On Tue, 2020-08-25 at 11:14 +0200, Ulf Hansson wrote:
> > > > On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
> > > > <matthias.schiffer@ew.tq-group.com> wrote:
> > > > > --- a/drivers/mmc/core/host.c
> > > > > +++ b/drivers/mmc/core/host.c
> > > > > @@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int
> > > > > extra,
> > > > > struct device *dev)
> > > > >  {
> > > > >         int err;
> > > > >         struct mmc_host *host;
> > > > > +       int alias_id, min_idx, max_idx;
> > > > > 
> > > > >         host = kzalloc(sizeof(struct mmc_host) + extra,
> > > > > GFP_KERNEL);
> > > > >         if (!host)
> > > > > @@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int
> > > > > extra,
> > > > > struct device *dev)
> > > > >         /* scanning will be enabled when we're ready */
> > > > >         host->rescan_disable = 1;
> > > > > 
> > > > > -       err = ida_simple_get(&mmc_host_ida, 0, 0,
> > > > > GFP_KERNEL);
> > > > > +       host->parent = dev;
> > > > > +
> > > > > +       alias_id = mmc_get_reserved_index(host);
> > > > > +       if (alias_id >= 0) {
> > > > > +               min_idx = alias_id;
> > > > > +               max_idx = alias_id + 1;
> > > > > +       } else {
> > > > > +               min_idx = mmc_first_nonreserved_index();
> > > > > +               max_idx = 0;
> > > > > +       }
> > > > > +
> > > > > +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx,
> > > > > GFP_KERNEL);
> > 
> > 
> > One more question I came across when reworking my patch: Do we need
> > a
> > fallback here for the case where the reserved index is already
> > taken?
> > To handle an SD card being replaced while still mounted?
> 
> Removal/insertion of an SD card should be fine, as that doesn't mean
> that the host is removed. In other words, host->index remains the
> same.
> 
> Although, for a bad DT configuration, where for example the same
> aliases id is used twice, a fallback could make sense. On the other
> hand, as such configuration would be wrong, we might as well just
> print a message and return an error.

I don't think this can happen as long as we don't have DTs changing at
runtime: Each alias is a DT property name in /aliases, which can only exist once.


> 
> [...]
> 
> Kind regards
> Uffe

