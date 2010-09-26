From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
Date: Sun, 26 Sep 2010 16:25:11 +0100
Message-ID: <20100926152511.GA19772@void.printf.net>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com> <20100923120803.832975f6.akpm@linux-foundation.org> <20100925225324.GA30732@void.printf.net> <AANLkTikXX4eUEKmBMOH1PuioGgztGN4jKPnPBDqf=4zf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34277 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695Ab0IZPZQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Sep 2010 11:25:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikXX4eUEKmBMOH1PuioGgztGN4jKPnPBDqf=4zf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, ben-linux@fluff.org, w.sang@pengutronix.de

Hi Kyungmin,

On Sun, Sep 26, 2010 at 07:53:48PM +0900, Kyungmin Park wrote:
> On Sun, Sep 26, 2010 at 7:53 AM, Chris Ball <cjb@laptop.org> wrote:
> > On Thu, Sep 23, 2010 at 12:08:03PM -0700, Andrew Morton wrote:
> >> The patch applies OK to 2.6.35. =A0Is the bug present there as wel=
l? =A0If
> >> so, should we fix it in earlier kernels? =A0If so then the way in =
which
> >> we indicate this is by adding
> >>
> >> =A0 =A0 =A0 Cc: <stable@kernel.org>
> >>
> >> to the changelog.
> >
> > Marek, Kyungmin, what do you think?
>=20
> Of course my opinion is should be merged at this time.
> In normal case it's built as static module. so there's no complains.
> but it should be fixed.
> My SOB is already included at patch. so no need to ACK from me.

Andrew's question isn't whether it should be merged, but whether it
should also be applied to the stable kernel, since the bug appears
to be present in the 2.6.35 release as well.

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
