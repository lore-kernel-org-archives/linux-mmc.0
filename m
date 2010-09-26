From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Sun, 26 Sep 2010 13:37:37 +0400
Message-ID: <20100926093737.GA24005@oksana.dev.rtsoft.ru>
References: <1285072210-10207-1-git-send-email-w.sang@pengutronix.de>
 <1285072210-10207-2-git-send-email-w.sang@pengutronix.de>
 <AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46848 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0IZJho (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 05:37:44 -0400
Received: by ewy23 with SMTP id 23so1060182ewy.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 02:37:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimcscR56u=-iT9v5V+Tsg2KNOqiuQ2DKojJ++6c@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Hello,

On Sun, Sep 26, 2010 at 05:02:29AM -0400, zhangfei gao wrote:
> On Tue, Sep 21, 2010 at 8:30 AM, Wolfram Sang <w.sang@pengutronix.de>=
 wrote:
> > +++ b/drivers/mmc/host/sdhci-pltfm.h
> > @@ -13,6 +13,11 @@
> >
> > =C2=A0#include <linux/sdhci-pltfm.h>
> >
> > +struct sdhci_pltfm_host {
> > + =C2=A0 =C2=A0 =C2=A0 struct clk *clk;
> > + =C2=A0 =C2=A0 =C2=A0 u32 scratchpad; /* to handle quirks across i=
o-accessor calls */
> > +};
> > +
> How about move private data to child driver, and one call back
> function alloc_host, then child driver could alloc private data,
> including clk.

IMHO, this sounds like a bit of overdesign/overcomplication.

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
