Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F1C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 08:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355706124C
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 08:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhDLIOP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236973AbhDLIOP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Apr 2021 04:14:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DB61600EF;
        Mon, 12 Apr 2021 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618215237;
        bh=zJ9B0tdx+ksI9mLzw8BO6mI9yoCohgZXfXlee3SApTI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OFna0Igb//8CZdkFuB0IOOdSZy2dDUQec+H9u4nAH8gfY7FwJhQKhG00J4OVjt0rF
         4zWib6BTzVbZBY+IOs89jovGQQBB/GTN2veBLb91wGDkVqRUN4gzJrT5iUg8wQJA0C
         RRlcAmKy6s01gyfmQh/dJAS+vQy/WeyCkYxb83BDU+P02oLVxZZ7K2TdHvtPLfRVjT
         y9VTFoiSTFGx7Tl5fTjeXiKlYjACTILnRYe4+BTtmULdcXgFUuoD6je1CMTSSKxlZk
         V2Yv/FFiObSZjh92iJe+V4WPdi16+eyW8gRSu8MPuqddTFH5987TXkcUzhsJEpvgFe
         w7hdUr+NTVBfQ==
Message-ID: <dbcfcc97abbedc154485b6975d6456c5cf31668a.camel@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: iproc-sdhci: Convert to
 json-schema
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Apr 2021 10:13:48 +0200
In-Reply-To: <CAPDyKFrBSVooaNNiVgr12o9OLZ_3_0OExKBoW+QyLXftzR+8cw@mail.gmail.com>
References: <20210406104802.20898-1-nsaenz@kernel.org>
         <20210406104802.20898-2-nsaenz@kernel.org>
         <CAPDyKFrBSVooaNNiVgr12o9OLZ_3_0OExKBoW+QyLXftzR+8cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2021-04-12 at 09:52 +0200, Ulf Hansson wrote:
> On Tue, 6 Apr 2021 at 12:48, Nicolas Saenz Julienne <nsaenz@kernel.org> wrote:
> > 
> > Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> 
> Applied for next, thanks! (I guess patch2 and patch3 needs a re-spin?)

Yes, that's right. Thanks!

Regards,
Nicolas

