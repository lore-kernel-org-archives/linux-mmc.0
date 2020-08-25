Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF78C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 11:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7074720715
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 11:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aGppIgky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgHYLYQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:24:16 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:30835 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgHYLYP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 07:24:15 -0400
IronPort-SDR: l4Vuf8WTzX9BgJf23Fn9jXkHwyuqj30PyE4qjAY+TlCPBQUvILt43cbreN2GTOsCn3quVNVwCG
 br/BPtKLP9o41EXJrGEvPBAJf8c9k9/1+ykxc0h7Q5f6tCGcgmtx4Hm1DlFzIBl92r3lyrHRJ8
 b0v+JgLeUkrjaNlJXUwo1j0O4PnAlU00awgvxmBPyYjNa4FJXZcsajHRapjtomFr/Ak3X3DEzy
 9cel1uGAQS/NwT2gEucRtB6qHABOQA2ai/X4yR0VwNRRwqQCA6Ma8ss1qNpz//fNBs90SYBc4Y
 bjQ=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13589397"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 13:24:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 13:24:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 13:24:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598354653; x=1629890653;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EE2R5sLmnj/yzSqma8+AXL+jr4yYEH7vlKI8ggnnb50=;
  b=aGppIgkyoJmoBnEMOfaEdyLY/pVhj4tFBSy3TMDoxR59bYtGNxQ8Xxst
   ThipZxTgXMlj0Md0TyxePMAqpLK81Q/bM+PML/FB03V9yDjHKcOV3Cj5X
   IxjSIXNej2O4j0nKg4v4d0cOaDKwiuxZYz1A1sGeTRDffq8haUE3rwy+T
   5OcQKiZqkkTPhUsE1uWLvBXoIpW4cTsLi4ilRz17eYEK0Oc7gTJXFhNkT
   msZopCgrGww0oJipaJyyLItosZgmSg4iAjVMeAsV8UUBVIVRt8S5FxnI5
   +zmL9MZnka0LJtf3TPcNwa4a7aXM2GEyPAEzyFtYqA7hpjgKJB0LNCtRx
   g==;
IronPort-SDR: Nd1N5rubAGnAH8MP8Ey/6MF4/cj4EQqY967yrHgvky6U1P5ZlW6WWTvT9Jzqs5IpunIXH9MVxr
 9k//jsnpzPGH2V/2CsiUIZs+DtTyCzqpkVEd02gxFi6Vj7W9chE4kTPsooTmap5OVHraGd34yf
 NT0KRMBAJlQ4UWQA7qaFXeoTNkHIASLkMcH0aeGcTxYHwVrdRIjnsHbPSV22qdXRtsjsalWp/2
 545IEs3EcafVaI6JJsyp4cmOofyRrXlO0z8AgPq83OKliiDVlBX8ZEqRMBdnECh4D377Pxhk9m
 2rM=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13589396"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 13:24:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 01841280065;
        Tue, 25 Aug 2020 13:24:12 +0200 (CEST)
Message-ID: <50b5b51e31d9497dbb84c52e11d0d1547d4804f4.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH mmc-next v2] mmc: allow setting slot index via
 device tree alias
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 13:24:10 +0200
In-Reply-To: <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com>
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
         <CAPDyKFoi7KghuBqu7YVS4GH4Bp1puhgb=PcwBVDvaTesLujrrw@mail.gmail.com>
         <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2020-08-25 at 11:39 +0200, Matthias Schiffer wrote:
> On Tue, 2020-08-25 at 11:14 +0200, Ulf Hansson wrote:
> > On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > > +
> > > +static void __init mmc_of_reserve_idx(void)
> > > +{
> > > +       int max;
> > > +
> > > +       max = of_alias_get_highest_id("mmc");
> > 
> > Is calling of_alias_get_highest_id("mmc") costly from an execution
> > point of view?
> > 
> > If not, we might as well call it directly from mmc_alloc_host()
> > each
> > time a host is allocated instead, to simplify the code a bit.
> 
> It's not particularly costly (it just walks the list of aliases once
> and does a string comparison for each entry), but it does so while
> holding the of_mutex.
> 
> Both variants exist in the current kernel: The I2C core stores the
> hightest index in a global variable, while of_alias_get_highest_id()
> is
> called once for each registered SPI controller. I have a slight
> preference for the global variable solution.

Looking at this again, it's pretty much the same as of_alias_get_id().
I'll remove the extra functions and global variable.

Kind regards,
Matthias

