From: NeilBrown <neilb@suse.de>
Subject: How to manage SDIO interrupts with a runtime power managed host.
Date: Tue, 27 Jan 2015 22:47:22 +1100
Message-ID: <20150127224722.53f4ac83@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/_4sV.wlUWVgapMTP_JtdLOZ"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48161 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbbA0Lrd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Jan 2015 06:47:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>

--Sig_/_4sV.wlUWVgapMTP_JtdLOZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


The (libertas) wifi chip in my GTA04 is connected to an OMAP3 HS_MMC port as
an SDIO card.

When I configure it (via devicetree) to respond to the SD interrupt line
(rather than polling for SD interrupts) it doesn't work well at all.

After lots of experimenting and beating my head against a brick wall I have
finally discovered why.

According to section 7.1.2 of=20

http://www.sandisk.com/media/File/OEM/Manuals/SD_SDIO_specsv1.pdf

    In the case where the interrupt mechanism is used to wake the host while
    the card is in a low power state (i.e. no clocks), Both the card and the
    host shall be placed into the 1-bit SD mode prior to stopping the clock.

The omap_hsmmc driver doesn't appear to be aware of this requirement (and I
cannot see that other host drivers are either). It will turn off the clocks
for a 4-bit device without first switching to 1-bit.

(The mmc core does switch to 1-bit mode for system suspend, but not for
runtime suspend).

This requirement exactly explains my observations.  The chip is configured
for 4-bit mode, and once pm_runtime turns the clocks off, interrupts stop
being delivered.  Note that the "reconfigure DAT1 as a GPIO" magic is prope=
rly
configured.  When something else wakes the chip, the GPIO interrupt handler
will sometimes run in the small window between the clocks coming back and
the DAT1 pin being configured back to the default setting.

If I configure the chip as using a 1-bit wide interface, it works perfectly.
In this configuration it is significantly faster than 4-bit polled mode, but
somewhat slower than 4-bit interrupt mode with runtime_pm disabled.

I'm open for suggestions on how best to fix this.
I tried putting code into the pm_runtime_{suspend,resume} callbacks in
omap_hsmmc.c to switch the bus width, but that doesn't work.  The callbacks
aren't allowed to sleep, and telling the card to use the new bus width is a
sleeping operation.

I imagine I could possibly do something similar to MMC_CLKGATE to switch to
1-bit mode after some idle time, and have the pm_runtime_suspend abort if it
is still in 4-bit mode.  Would that be a good idea?
Would it make sense to get mmc_gate_clock to switch bus width (if it is an
SDIO card with interrupts enabled) rather than having a separate timeout
thing?

Thoughts?

Thanks,
NeilBrown

--Sig_/_4sV.wlUWVgapMTP_JtdLOZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVMd6yjnsnt1WYoG5AQJ71Q/6Aw7OqJWFY2vb3iGnvTLEgfBpHOPn5s+5
PXBwxh4IO4oCiEg4/f9aitPhflvtZE5kz+Ka+iSCchFLWvafGEz+8QTNi1Cxb880
XxQnlRzWqZJP7b9Wp3cCtvKaFqzAp5pJyvfZVVM6sIdTaqrzakxpfHfnDxL9O1jd
gXWy7HbCFNw5TSyO9rVLod5HNfvQUvrNWvA1rae7ggg/YuYauviLv/XqIDpcIfXI
U5pL9KhevjXSLRRm+7uxhdvkjYLMkwJrtFD+YtkpcCqUekmw1Cm5tMW7pnJ3RSLj
dErUkLnlgatKVkY8uOgzKFMvwsVBhhdKCIm2f0HPTv1VRaKDlD3nUJ/BdY4814Yk
+CDgDxH1XjoSGw9Jdq60xCLdZPx64xcMDpBcTp934SJE7jgUPRO8JuXgz231HXZB
ixumJl5A/HkbVR1d91tRf/xq569oaoYav5M8I/cTfxo34O+KtZgrB17aEPGi0ffr
xSZWLpYaAuh/5tq17vu84ps2GepFTbf5TczRmDJxhkTgJkD6VGqaaggPW7s0rM4l
H1e0jPmqUsV439vCK8TvriR1auDX34HmixfamYznlRfLnYfqMVd0W5AAnAln6dIk
9khKsM9epwXv5fnIt3zPJJbYgxMh52Ldi9Kf3ydRGWUdkYcAT+EnhQqQsJui1Ma3
kGHTC3buleE=
=fLA1
-----END PGP SIGNATURE-----

--Sig_/_4sV.wlUWVgapMTP_JtdLOZ--
