From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] MMC updates for 3.16-rc1
Date: Thu, 12 Jun 2014 08:17:44 +0100
Message-ID: <20140612071744.GA11421@lee--X1>
References: <86ha3so84o.fsf@void.printf.net>
 <CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxBwteZeUHG+Z-cdLU_YCO4f8TDuYvGmXc0-v9M1H11+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 10 Jun 2014, Linus Torvalds wrote:

> On Tue, Jun 10, 2014 at 12:51 PM, Chris Ball <chris@printf.net> wrote=
:
> >
> >  These patches have been tested in
> > linux-next, and there are three minor conflicts which I've resolved=
 on
> > my mmc-updates-for-3.16-rc1-merged branch.
>=20
> Your merged branch is incorrect as far as I can tell, and dropped
> commit a8246fedacad ("dmaengine: omap: hide filter_fn for built-in
> drivers").
>=20
> And I'm not sure why the sunxi driver (by David Lanzend=C3=B6rfer) an=
d the
> Realtek driver (by Roger Tseng) got merged in two different trees.
> It's clearly the same patches and drivers, but I got them first
> through the MFD tree (Realtek) and the clock tree (sunxi) trees and
> now the MMC tree.
>=20
> Don't you guys talk to each other? The Realtek driver is even marked
> as Acked-by Chris Ball in the MFD tree.

Yes, we do talk to each other.  Branch ib-mfd-mmc-memstick-3.16 was
created as a result.  Based on no facts at all, I'm guessing that the
shared (immutable) branch wasn't applied correctly in the MMC tree.

> Also, that new drivers/mmc/host/usdhi6rol0.c driver is one f*cking
> noisy compile, and knisr certainly has never been tested in a 64-bit
> environment. Please either fix it, or make it depend on BROKEN.
>=20
> Grr.
>=20
> Anyway, pulled, merged correctly, and pushed out..
>=20
>                 Linus

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
