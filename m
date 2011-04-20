From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Wed, 20 Apr 2011 22:01:21 +0800
Message-ID: <20110420140120.GF1965@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
 <20110417164830.GE17935@S2100-06.ap.freescale.net>
 <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:25095
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755083Ab1DTN51 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 09:57:27 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Apr 20, 2011 at 10:01:22AM +0200, Per Forlin wrote:
> On 17 April 2011 18:48, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Mon, Apr 18, 2011 at 12:33:30AM +0800, Shawn Guo wrote:
> >> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> >> If not calling pre_req() before mxs_mmc_request(), request()
> >> will prepare the cache just like it did it before.
> >> It is optional to use pre_req() and post_req().
> >>
> >> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >> ---
> >> =A0drivers/mmc/host/mxs-mmc.c | =A0 75 +++++++++++++++++++++++++++=
+++++++++++++++--
> >> =A01 files changed, 72 insertions(+), 3 deletions(-)
> >>
> >
> > Here is the result of mmc_test case 37 ~ 40, which are designed to =
see
> > the performance improvement introduced by non-blocking changes.
> >
> > Honestly, the improvement is not so impressive. =A0Not sure if the =
patch
> > for mxs-mmc pre_req and post_req support was correctly produced. =A0=
So
> > please help review ...
> My guess is that dma_unmap is not run in parallel with transfer.
> Please look at my patch reply.
>=20
Got it fixed in v2 posted just now.  Please take another look.
Unfortunately, I do not see noticeable difference than v1 in terms
of mmc_test result.

Do you have omap_hsmmc and mmci mmc_test result data to share?

--=20
Regards,
Shawn

