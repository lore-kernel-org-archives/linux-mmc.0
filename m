From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Mon, 22 Nov 2010 23:27:43 +0000
Message-ID: <20101122232743.GA27895@void.printf.net>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com> <AANLkTika=H3EOA=WSdyuP9Mexrrh0z6-KjjTiNCj=mLc@mail.gmail.com> <AANLkTiniyy_rC4wUAhxN4i09d4GqhdnqPOqXMYNZyBXT@mail.gmail.com> <20101109035948.GA32119@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39238 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757774Ab0KVX1s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Nov 2010 18:27:48 -0500
Content-Disposition: inline
In-Reply-To: <20101109035948.GA32119@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com, Linus Walleij <linus.walleij@stericsson.com>

Hi Linus,

Trying out CLKGATE=y on my x86 laptop with sdhci-pci:

<boot, slots are empty>

[   10.080469] Registered led device: mmc0::
[   10.080595] mmc0: SDHCI controller on PCI [0000:0d:00.0] using DMA
[   10.107996] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[   10.122164] Registered led device: mmc1::
[   10.122237] mmc1: SDHCI controller on PCI [0000:17:00.0] using DMA
[   10.136067] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[   10.164089] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[   10.192076] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[   10.291095] mmc1: frequency set to 0 in disable function, this means the clock is already disabled.
[   10.319029] mmc1: frequency set to 0 in disable function, this means the clock is already disabled.

<insert a card, mount>

[ 1569.970580] mmc0: new SDHC card at address d555
[ 1744.842376] mmcblk0: mmc0:d555 SD04G 3.79 GiB 
[ 1744.845224]  mmcblk0: p1
[ 1745.312968] EXT4-fs (mmcblk0p1): mounted filesystem without journal.

<umount, remove card>

[ 1795.000070] mmc0: card d555 removed
[ 1795.029868] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.037021] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.037043] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.037065] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.037086] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.058904] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.086940] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.093011] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.093048] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.093084] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.093115] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.116854] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.120881] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.120938] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.120972] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.121001] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.121030] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.121058] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.
[ 1795.121083] mmc0: frequency set to 0 in disable function, this means the clock is already disabled.

Questions:

* Are we expecting mmc_host_clk_gate_delayed() to be called so often
  with host->ios.clock == 0?  There's a full log with CONFIG_MMC_DEBUG=y
  at http://chris.printf.net/mmc-clkgate-debug in case it helps you see
  what's going on.

* If you think the current behavior should stay, we would at least want
  to convert it to a dev_dbg so that it's only visible under MMC_DEBUG=y,
  right?

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
