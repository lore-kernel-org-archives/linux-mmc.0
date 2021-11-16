Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB7C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C98661A58
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhKPRCw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 12:02:52 -0500
Received: from smtp1.axis.com ([195.60.68.17]:28449 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhKPRCv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Nov 2021 12:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637081994;
  x=1668617994;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=r7cz12LBBcE9Y7fTwL1uyNNrj5IfFOMQp8u4uUQc8X4=;
  b=HgtlMF2rXKaI/H13ygRT8fKB53kbSXjaKae6k1kk1OsZbK7XsY0AegTZ
   cNXCgPLphdusuoyjbRc310N9SgElp/jK4oXJioc7fyoiJbtXdFSbHj7Jg
   dUbeT/QWRtkksn+O0W0P8xKE67s8A2Ne3Kr02kQxcpdOky7X76XfOW1nk
   U/5cqMTwrnzrBhzQJ4p4869Zh0vv4+48s9HYDveT019lcKFyiHoeNsW+I
   H+DYsFEAsjxqHjrgANDH+AIlh2AkYB+mQEcftyrT2kEK+jFx0hdUeDsKR
   r/SqfYg/xsmEt9on2O7oYUyn4mXpmHEQr6N9ALeWVqbxR091ZTK0qHaiA
   Q==;
Date:   Tue, 16 Nov 2021 17:59:53 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
Message-ID: <20211116165949.GA32249@axis.com>
References: <20211110110500.4105-1-marten.lindahl@axis.com>
 <CAPDyKFpKbKEePYyb1fQ_cxjtJS6JuF1qFKh2KKfXpM23nvkH+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpKbKEePYyb1fQ_cxjtJS6JuF1qFKh2KKfXpM23nvkH+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Nov 15, 2021 at 03:54:19PM +0100, Ulf Hansson wrote:
> On Wed, 10 Nov 2021 at 12:05, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > The TMOUT register is always set with a full value for every transfer,
> > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> > Since the software dto_timer acts as a backup in cases when this timeout
> > is not long enough, it is normally not a problem. But setting a full
> > value makes it impossible to test shorter timeouts, when for example
> > testing data read times on different SD cards.
> >
> > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe
>

Hi Ulf!

During tests on some units I found that there is a potential overflow
of the 32bit divider in this patch (if clk_div > 4).

Is it possible to stop this patch, until I created a new version of it?
I guess it's better to update this patch, in favour of sending a new
correction patch for it?

Kind regards
Mårten

> 
> > ---
> >
> > v2:
> >  - Calculate new value before checking boundaries
> >  - Include CLKDIV register to get proper value
> >
> > v3:
> >  - Use 'if-else' instead of 'goto'
> >  - Don't touch response field when maximize data field
> >
> >  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 6578cc64ae9e..637ae2aea9fa 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> >         mci_writel(host, CTYPE, (slot->ctype << slot->id));
> >  }
> >
> > +static void dw_mci_set_data_timeout(struct dw_mci *host,
> > +                                   unsigned int timeout_ns)
> > +{
> > +       unsigned int clk_div, tmp, tmout;
> > +
> > +       clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> > +       if (clk_div == 0)
> > +               clk_div = 1;
> > +
> > +       tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
> > +                              NSEC_PER_SEC * clk_div);
> > +
> > +       /* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> > +       tmout = 0xFF; /* Set maximum */
> > +
> > +       /* TMOUT[31:8] (DATA_TIMEOUT) */
> > +       if (!tmp || tmp > 0xFFFFFF)
> > +               tmout |= (0xFFFFFF << 8);
> > +       else
> > +               tmout |= (tmp & 0xFFFFFF) << 8;
> > +
> > +       mci_writel(host, TMOUT, tmout);
> > +       dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
> > +               timeout_ns, tmout >> 8);
> > +}
> > +
> >  static void __dw_mci_start_request(struct dw_mci *host,
> >                                    struct dw_mci_slot *slot,
> >                                    struct mmc_command *cmd)
> > @@ -1303,7 +1329,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
> >
> >         data = cmd->data;
> >         if (data) {
> > -               mci_writel(host, TMOUT, 0xFFFFFFFF);
> > +               dw_mci_set_data_timeout(host, data->timeout_ns);
> >                 mci_writel(host, BYTCNT, data->blksz*data->blocks);
> >                 mci_writel(host, BLKSIZ, data->blksz);
> >         }
> > --
> > 2.20.1
> >
