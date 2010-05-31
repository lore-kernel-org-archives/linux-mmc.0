From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [RFC] [PATCH 1/2] mmc: split mmc_sd_init_card()
Date: Mon, 31 May 2010 17:58:46 +0200
Message-ID: <20100531155846.GA9493@rere.qmqm.pl>
References: <1-1000-12432-1274803827-7569@rere.qmqm.pl> <20100528144027.3c868841.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:51168 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938Ab0EaP6r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 May 2010 11:58:47 -0400
Content-Disposition: inline
In-Reply-To: <20100528144027.3c868841.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for your review!

On Fri, May 28, 2010 at 02:40:27PM -0700, Andrew Morton wrote:
> On Tue, 25 May 2010 18:10:28 +0200 (CEST)
> Micha__ Miros__aw <mirq-linux@rere.qmqm.pl> wrote:
> > This is needed to avoid code duplication in SD-combo support.
> hm.  Perhaps you could have told us a bit more about it than this.
> > +int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> > +int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
> > +int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card=
,
> > +unsigned mmc_sd_get_max_clock(struct mmc_card *card)
> > +void mmc_sd_go_highspeed(struct mmc_card *card)
> These are global symbols, but they are not exported to (other) module=
s.
> That's odd.  I'd have expected to see them either `static' or
> EXPORT_MODULE()d.

This is all contained in mmc_core.ko and needs not be exported to other
modules. A SD-combo card is a SD (memory) and SDIO in one package - the
only changes needed are in initialization sequence, after which both
parts are mostly independent.

> I'll take the lack of a signed-off-by: and the "RFC" as signal to not
> apply these patches.

I would like for this to get tested by other people first, but it looks
like not many kernel developers use SD combo cards.

I'll resend the patches after applying your suggestions from the other
mail.

Best Regards,
Micha=B3 Miros=B3aw

