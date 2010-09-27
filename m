From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable
	case
Date: Mon, 27 Sep 2010 09:43:54 +0100
Message-ID: <20100927084354.GA27290@console-pimps.org>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org> <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org> <4C7F65A1.60105@samsung.com> <20100902091424.GA12456@console-pimps.org> <4C86E672.1030807@samsung.com> <20100915151142.GB21538@console-pimps.org> <20100915203855.GA6620@void.printf.net> <20100916022008.GB7939@void.printf.net> <20100916090210.GA1887@console-pimps.org> <AANLkTikWSya8b+dGQ0CMwhYy0ST7tQDo1zAwwe44qj6J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57514 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758911Ab0I0Inz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 04:43:55 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikWSya8b+dGQ0CMwhYy0ST7tQDo1zAwwe44qj6J@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>

On Sun, Sep 26, 2010 at 03:31:22PM +0800, zhangfei gao wrote:
> On Thu, Sep 16, 2010 at 5:02 PM, Matt Fleming <matt@console-pimps.org=
> wrote:
> > On Thu, Sep 16, 2010 at 03:20:08AM +0100, Chris Ball wrote:
> >> Hi Matt,
> >>
> >> On Wed, Sep 15, 2010 at 09:38:55PM +0100, Chris Ball wrote:
> >> > On Wed, Sep 15, 2010 at 04:11:42PM +0100, Matt Fleming wrote:
> >> > > Chris, are you OK to pick this up (including Jaehoon's change)=
? Or
> >> > > would you prefer me to resubmit?
> >> >
> >> > Thanks, that's fine, I've applied both patches to mmc-next:
> >>
> >> This (patch 2/2) doesn't resolve symbols properly, so I've dropped=
 it:
> >>
> >> =A0 Building modules, stage 2.
> >> =A0 MODPOST 448 modules
> >> ERROR: "mmc_assume_removable" [drivers/mmc/host/sdhci.ko] undefine=
d!
> >> make[1]: *** [__modpost] Error 1
> >> make: *** [modules] Error 2
> >>
> >> There's no EXPORT_SYMBOL(mmc_assume_removable) in core/core.c, yet=
 it's
> >> being referenced in host/sdhci.c.
> >
> > Bah! That'll teach me for not compiling an allmodconfig kernel. I'l=
l
> > fix this up and resubmit.
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
> Any new patch of this, then we could re-use SDHCI_QUIRK_BROKEN_CARD_D=
ETECTION :)

Thanks a lot for the reminder! I've just re-sent these two patches.
