From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH 2/2] tmio_mmc: fix CMD irq handling
Date: Fri, 24 Sep 2010 10:13:28 +0200
Message-ID: <4C9C5DA8.5080904@arndnet.de>
References: <4C9B5BF4.3070109@arndnet.de> <AANLkTi=B=pcxVTMSxk2Orftp8zH7o8jebL1hbQ52dyzH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=B=pcxVTMSxk2Orftp8zH7o8jebL1hbQ52dyzH@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Added MLs into CC

Am 23.09.2010 21:28, schrieb Ian Molton:
> This looks good - what testing has it had ?

Tested with the SDHI hardware block in sh7372 (on AP4EVB).
Both with PIO and DMA. Tested with MMC and SD cards.

Regards
Arnd
