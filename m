From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Thu,  8 Apr 2010 01:12:00 +0200
Message-ID: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

This is the fifth iteration of this ever growing patch set
for PrimeCell DMA support, reposting the entire series.

This now depend on stuff pending in Dan Williams async_tx
(DMA Devices/Engine) tree and Andrew Mortons tree where
the new DMA40 driver for U8500 is queued.

I suggest putting these into Andrews tree now, since:

A) 4 of the patches it touches MMCI code which is hanled
   by Andrew

B) It extends the DMA40 driver which is now pending in
   his tree as well.

C) Since there doesn't seem to be any consensus of whether
   this is the right way forward, it needs some wider
   testing I believe.

OK?

Yours,
Linus Walleij
