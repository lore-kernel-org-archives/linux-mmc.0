From: Chris Ball <chris@printf.net>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
Date: Thu, 22 May 2014 13:05:16 +0100
Message-ID: <86zjiaqarn.fsf@void.printf.net>
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58093 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbaEVMFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 08:05:20 -0400
In-Reply-To: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 22 May 2014 12:49:11 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>

Hi Ulf,

On Thu, May 22 2014, Ulf Hansson wrote:
> Here are a third and final collection of patches for 3.16.
>
> I have as you and I discussed (off list), collected the patches from
> Russell's sdhci patchset. I needed to resolve some conflicts while
> applying them, but it was manageable. I also omitted the patch which
> was reported to caused problem with eMMC, (mmc: sdhci: hack up driver
> to make it more compliant with UHS-1).

Pulled, but:

drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_set_uhs_signaling=E2=
=80=99:
drivers/mmc/host/sdhci.c:1432:12: error: =E2=80=98ios=E2=80=99 undeclar=
ed (first use
in this function)
  else if ((ios->timing =3D=3D MMC_TIMING_UHS_DDR50) ||
            ^
drivers/mmc/host/sdhci.c:1432:12: note: each undeclared identifier is
reported only once for each function it appears in
make[3]: *** [drivers/mmc/host/sdhci.o] Error 1

- Chris.
--=20
Chris Ball   <http://printf.net/>
