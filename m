From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always
	have vmmc supply
Date: Tue, 21 Feb 2012 12:20:22 +0000
Message-ID: <20120221122022.GC22675@n2100.arm.linux.org.uk>
References: <1329818589-10062-1-git-send-email-rnayak@ti.com> <1329818589-10062-7-git-send-email-rnayak@ti.com> <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54803 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab2BUMUj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 07:20:39 -0500
Content-Disposition: inline
In-Reply-To: <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, cjb@laptop.org, linaro-dev@lists.linaro.org, balajitk@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Feb 21, 2012 at 05:43:54PM +0530, S, Venkatraman wrote:
> On Tue, Feb 21, 2012 at 3:33 PM, Rajendra Nayak <rnayak@ti.com> wrote=
:
> > @@ -324,8 +302,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc=
_host
> > *host)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).ocr_m=
ask =3D ocr_value;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(mmc_slot(host)=
=2Eocr_mask & ocr_value)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_er=
r("MMC%d ocrmask %x is not
> > supported\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 host->id,
> > mmc_slot(host).ocr_mask);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_er=
r("MMC ocrmask %x is not
> > supported\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_slot(host).ocr_mask);

You're dropping the MMC number from these error messages.  It would be
much better to fix them instead.  Use dev_info(mmc_dev(host->mmc), "bla=
h"
rather than pr_err().

Drivers should not be using pr_* unless they really do not have a struc=
t
device.
