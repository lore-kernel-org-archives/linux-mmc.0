From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: Check if MMC slot name is passed in
 pdata
Date: Wed, 27 Apr 2016 07:17:53 -0700
Message-ID: <20160427141753.GX5995@atomide.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-3-git-send-email-tony@atomide.com>
 <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52419 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbcD0OR5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2016 10:17:57 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

* Ulf Hansson <ulf.hansson@linaro.org> [160427 01:53]:
> On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> > The legacy user space for n900 relies on the MMC slot names.
> > Let's check if those are passed in pdata and use them.
> >
> > Then when we have a generic MMC slot name binding we can
> > switch to use that assuming it works for the n900 legacy
> > user space too.
> 
> I dropped this section, because I don't think it will happen.

Yeah fine with me.

> Thanks, applied for next!

Thanks!

Tony
