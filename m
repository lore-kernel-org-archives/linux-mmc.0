From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: n900 needs MMC slot names for legacy
 user space
Date: Wed, 27 Apr 2016 07:17:03 -0700
Message-ID: <20160427141703.GW5995@atomide.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-2-git-send-email-tony@atomide.com>
 <CAPDyKFokkpF_-yxE+G2_nvC2q3uHkMCxZJHYU7y4KRRDWfvPTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52409 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbcD0ORI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2016 10:17:08 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFokkpF_-yxE+G2_nvC2q3uHkMCxZJHYU7y4KRRDWfvPTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

* Ulf Hansson <ulf.hansson@linaro.org> [160427 01:50]:
> On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> > Let's pass the slot names in pdata like the legacy code does.
> > Once we have a generic DT binding for the slot names we can
> > switch to that.
> 
> I am not sure we ever will get a DT binding accepted for the slot
> name. It seem far from being a HW description. :-)

Hmm it does describe where on the the device the MMC is
located though as in "external" or "internal".

> Instead, the long term and proper solution, is to enable userspace to
> be able to use UUID/PARTID instead.

OK.

> Until that happens, I guess this will have to do.

Yeah especially as that has been working with the legacy booting
for years.

Regards,

Tony
