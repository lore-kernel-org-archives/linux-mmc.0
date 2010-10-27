From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 19:27:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53570 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761279Ab0J0N53 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 09:57:29 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

Hi Chris, Linus, Nicolas, Adrian and all,

It has been identified after several discussions [1], [2], that
MMC/SD/SDIO driver need to re-work on clock and power management.
I am trying to list all the design considerations which are part
of this study/discussion are following:
=20
1. Remove clock handling APIs currently implemented through claim_host/
   release_host

2. Ideally host-driver driver should not tell the core to shut down
   the upper layers, instead the core should decide when to
   "disabled clock or cut the power".=20

   Going in details of different state handlings - Clock disable,
   Card sleep, card power cutoff;
  =20
   2.a) clock disable:=20
     Option-1: can be handled in the host itself using a timer based
               on some idle period, OR
     Option-2: let the core do enabling/ disabling clks based on
               existing enable/ disable=A0provided in the host, OR
     Option-3: with the *existing* API calls, namely the set_ios()
               method as proposed by Linus Walleij =A0[4]

   2.a) Card sleep, Power cutoff to the card:
     This should be handled in the core where based on block layer
     activity, calling corresponding API's from bus layer:
     mmc_power_save_host/ mmc_power_restore_host=20

3. MMC_CAP_DISABLE - should not be a host capability.=A0 This should be
   a core feature that should be _transparent_  to all hosts with no
   changes to any of the host drivers.=A0=20

Also it's discussed that different groups need to work together [3].

=46ew Patches posted by Linus Wallej in July 2009 [4], but they are
not merged yet. They would require some rework.

Therefore would like to know -
a). if the work can be taken forward from where Linus Walleij left.
b). does anyone started working on it and need to do any shearing
    to make bit faster.
c). if anything else also need to take care at re-design.

Regards,
Ghorai

=09

[1] [PATCH 11/15] wireless: wl1271: introduce platform device support
    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31703.htm=
l

[2] [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
    http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg03532.html

[3] http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg03956.html

[4] [PATCH 1/2] MMC Agressive clocking framework v5
    http://www.gossamer-threads.com/lists/linux/kernel/1106880?do=3Dpos=
t_view_threaded#1106880


