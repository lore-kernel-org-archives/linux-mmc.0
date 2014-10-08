From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Wed, 08 Oct 2014 20:28:31 +0200
Message-ID: <1819182.VPTrtc9d2P@wuerfel>
References: <2750153.I3nVqzmXTP@amdc1032> <1998495.eXa2FjeVGo@wuerfel> <CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55464 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbaJHS3O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Oct 2014 14:29:14 -0400
In-Reply-To: <CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>

On Wednesday 08 October 2014 08:29:16 Doug Anderson wrote:
> 
> On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Why does it cause a regression though? Does this mean you are breaking
> > any boot with an old DT file and a new kernel? That would be very
> > bad, the driver is supposed to keep working with an existing dtb.
> 
> The old dts file specified completely the wrong regulator.  It
> happened that the old code didn't really care, but when the code was
> fixed to care then things broke.  If we need to keep old dts files
> working then the most sensible place to do it would be in a "fixup old
> broken device trees" stage somewhere in kernel boot.

Ok, got it. I guess it's better to apply this one first then.

	Arnd
