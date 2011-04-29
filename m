From: Chris Ball <cjb@laptop.org>
Subject: cjb traveling May 1 - May 10
Date: Fri, 29 Apr 2011 16:35:08 -0400
Message-ID: <m339l03if7.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35228 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab1D2Ubm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2011 16:31:42 -0400
Received: from pullcord.laptop.org ([18.85.46.20])
	by void.printf.net with esmtp (Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1QFuLl-0000mD-7R
	for linux-mmc@vger.kernel.org; Fri, 29 Apr 2011 21:31:41 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I'll be in Uruguay for OLPC from May 1st to May 10th.  I'll be online
there but won't have as much time to reply to list mail as usual --
I'll catch up on mail properly after I get back.

I'm going to push the changes below to Linus early next week (after som=
e
more time in -next), and I'll push the next revision of Arindam's SD 3.=
0
patchset to mmc-next once it has a few Reviewed/Tested-by tags attached=
=2E

Thanks,

- Chris.

=3D=3D
Ben Dooks (1):
      mmc: sdhci: Check mrq->cmd in sdhci_tasklet_finish

Chris Ball (2):
      mmc: sdhci-pci: Fix error case in sdhci_pci_probe_slot()
      mmc: sdhci: Check mrq !=3D NULL in sdhci_tasklet_finish

Guennadi Liakhovetski (2):
      mmc: fix a race between card-detect rescan and clock-gate work in=
stances
      mmc: tmio: fix .set_ios(MMC_POWER_UP) handling

Michael Buesch (1):
      mmc: omap: Fix possible NULL pointer deref

Micha=C5=82 Miros=C5=82aw (1):
      mmc: core: mmc_add_card(): fix missing break in switch statement

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
