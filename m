Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2387C07E9A
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE4B613B2
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 11:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGNLwP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:52:15 -0400
Received: from smtp2.axis.com ([195.60.68.18]:44014 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhGNLwP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Jul 2021 07:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1626263363;
  x=1657799363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=132bNXd2CFbUt9KYv8y9sYjf5aFnD3ITjQqBDf11vlA=;
  b=XWDKI9O/Ehj5blDEF4UqcXmEB6dJ8yPRduCLblra7Jx5NFO3i88B6Jiv
   cLR35YC5ZKCe+E+qtWIwFKdVDaUQCrk5noswD7cm5i8QJEHFVHqeNap3C
   NmiN7SXuyBjU/XTXicxIqbr5FHL31PpI+dZjfuZ0tjYNM8ZnfXh6zvKZA
   USEWRWWD97OmmZritIVFqnn6883w0/ZgfeR0zMimbhXq2e7ILtfYeI5fw
   XSCG6EwF4dRxEzls0wvLw+9Y7KnMSDXMIdnsMTras+0AW0T6BelKdx1gW
   BUyFCtQM70njROSVkioLP1vE9FrtWtquMbLmZBfY09pR97gP+vnDeNgkt
   Q==;
Date:   Wed, 14 Jul 2021 13:49:21 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
Message-ID: <20210714114921.GA22706@axis.com>
References: <CGME20210630102240epcas1p33bbdffb5eb553a49badaffab756d482c@epcas1p3.samsung.com>
 <20210630102232.16011-1-vincent.whitchurch@axis.com>
 <81c1b56d-e1be-b3fb-6b44-fc8054f1dd8b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81c1b56d-e1be-b3fb-6b44-fc8054f1dd8b@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 01, 2021 at 12:06:31AM +0200, Jaehoon Chung wrote:
> On 6/30/21 7:22 PM, Vincent Whitchurch wrote:
> > When a Data CRC interrupt is received, the driver disables the DMA, then
> > sends the stop/abort command and then waits for Data Transfer Over.
> > 
> > However, sometimes, when a data CRC error is received in the middle of a
> > multi-block write transfer, the Data Transfer Over interrupt is never
> > received, and the driver hangs and never completes the request.
> > 
> > The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
> > DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
> > "before assertion of SWR".  Do these operations in the recommended
> > order.  With this change the Data Transfer Over is always received
> > correctly in my tests.
> 
> I will check with your patch. I didn't see any CRC error on my targets before.

Have you had a chance to check it?  You can use the fault-injection
patch if you want to trigger aborted transfers without getting real CRC
errors:

 https://lore.kernel.org/linux-mmc/20210701080534.23138-1-vincent.whitchurch@axis.com/
