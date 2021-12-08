Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA401C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Dec 2021 22:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhLHWFS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:05:18 -0500
Received: from smtp2.axis.com ([195.60.68.18]:42852 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbhLHWFS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Dec 2021 17:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639000905;
  x=1670536905;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=VRt6/LjubwnNkpPYOgxI34z0OGVQF3Sie8iEQwlJ3so=;
  b=prnJ8F9BBJZO0uWpzTpMiGIc00SqYOUITLSLpPlni1aWrTGrf2PgcfaZ
   j79LQkxfHC9c5O41nJX3LPP9dW0Ort4V/DCtxm/NdvzEJP7kqfGhecqW/
   LSP5FhIULtOrDcs3R9Lnjhs6qtqu9Rp89592iLiodqg8byJV9LC61MErj
   IksL77EagIeB2SMxhiNC8Cx3hEOi0bE6eTyRjKDC7uh5v28YyzJN7ldJL
   cQAt4C2G14VbilnFDiVHJuUs0IFVrVBUZ9yEcFm8JffXYqyHzDh9Ey4zi
   KUUZwpCQwJPwKaPZOKdMkZyOdah+uVSWXSVhDKqtU57MZGzUqvkyYI8N0
   g==;
Date:   Wed, 8 Dec 2021 23:01:44 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] mmc: dw_mmc: Do not wait for DTO in case of error
Message-ID: <20211208220144.GA10156@axis.com>
References: <20211206142929.26729-1-marten.lindahl@axis.com>
 <20211206142929.26729-5-marten.lindahl@axis.com>
 <CAPDyKFojCipHMwmCZB3h7CdYP+eSSikA=d=G701Y5+9xeQKxgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFojCipHMwmCZB3h7CdYP+eSSikA=d=G701Y5+9xeQKxgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 08, 2021 at 03:53:54PM +0100, Ulf Hansson wrote:
> On Mon, 6 Dec 2021 at 15:29, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > When running the ARTPEC-8 DWMMC IP version, and a data error interrupt
> > comes during a data read transfer, there is no guarantee for the data
> > transfer over interrupt (DTO) to come within the specified data timeout.
> > This case is handled by the dto_timer handler which will complete the
> > request with the comment:
> >
> >  /*
> >   * If DTO interrupt does NOT come in sending data state,
> >   * we should notify the driver to terminate current transfer
> >   * and report a data timeout to the core.
> >   */
> >
> > But since the ARTPEC-8 DWMMC IP version, supports an extended TMOUT
> > register which allows longer timeouts than the non ARTPEC-8 version
> > does, waiting for the dto_timer to complete the request in error cases
> > may cause the request to take significantly longer time than necessary.
> > This is specifically true for the failing steps during tuning of a
> > device.
> >
> > Fix this by completing the request when the error interrupt comes.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 

Hi Ulf!

> Okay, this change looks a bit inconvenient to move into variant
> specific callbacks. So, maybe the "quirks" flag makes sense, after
> all. However, I would still look at using callbacks and library
> functions, for the part implemented in patch3.

Yes, I don't see how this patch can be easily made with callbacks, but
definitely for patch3. So then I move the definition of the quirk from
patch3 to this patch.

> 
> When it comes to the order of the patches in the series, I suggest
> flipping things around and making patch2 the final piece. Otherwise
> the support for the artpec variant will be broken between patch2 and
> patch4, right?

Ok, you mean there may be a risk that the ARTPEC-8 dw_mmc does not work
if the support is enabled in patch2, but patch3 and patch4 is not in
place? That is a good point, but it actually does work quite fine (most
of the time) without the extended timeout function. But it does not use
the full function of the data timeout, and the HW timeout is most often
set to full timeout (0xFFFFFF => 587ms with 200MHz), but the SW timer is
limited to a lower value (0xFFFFFF => 84 + 10 ms with 200MHz).

My reasoning is:
patch1 - dtbindings for ARTPEC-8
patch2 - adding ARTPEC-8 to dw_mmc-exynos
patch3 - implement ARTPEC-8 specific function for data timeout
patch4 - add quirk to abort the extended timeout in case of errors, used
by ARTPEC-8

so, this means patch3 and patch4 depends on patch2, and patch4 depends
on patch3.

Kind regards
Mårten

> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/dw_mmc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 45ea9fd97a6a..d6b76f47b1a2 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -2777,11 +2777,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
> >                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> >                         spin_lock(&host->irq_lock);
> >
> > +                       if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
> > +                               del_timer(&host->dto_timer);
> > +
> >                         /* if there is an error report DATA_ERROR */
> >                         mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
> >                         host->data_status = pending;
> >                         smp_wmb(); /* drain writebuffer */
> >                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
> > +
> > +                       if (host->quirks & DW_MMC_QUIRK_EXTENDED_TMOUT)
> > +                               /* In case of error, we cannot expect a DTO */
> > +                               set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
> > +
> >                         tasklet_schedule(&host->tasklet);
> >
> >                         spin_unlock(&host->irq_lock);
> > --
> > 2.20.1
> >
