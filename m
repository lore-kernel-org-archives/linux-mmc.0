From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: renesas sdhi driver and DMA
Date: Sat, 28 Oct 2017 11:16:47 +0000
Message-ID: <SG2PR06MB1165908BCD32615AA0A9CDBE8A5B0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <SG2PR06MB1165F16A63D6793DBEC419688A750@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171010203229.rrwxkrczuk7piqh6@tetsubishi>
 <SG2PR06MB11658C446725E77967BF22598A5A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171028080234.GB28431@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171028080234.GB28431@bigcity.dyn.berto.se>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: =?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Niklas,

On Saturday, October 28, 2017, Niklas S=F6derlund wrote:
> > All was fine until that patch you submitted (52ad9a8e854c) that now add=
s
> > a wait_for_completion() in the SDHI callback.
>=20
> This is a interesting finding, I did some bisecting a while back to try
> and understand why a known problematic SD card started to have more
> issues then last time I tested it. That investigation also ended up
> pointing to 52ad9a8e854c.
>=20
> >
> > Now I get the "BUG: scheduling while atomic".
> >
> > The R-Car driver uses a threaded irq to call the callbacks, not a
> > tasklet.
> >
> > So I hacked my code to also call the callbacks from a threaded irq like
> > rcar-dma.c.
> > And....that works (no more scheduling while atomic).
>=20
> Can you post that hack or just send it to me privately if it's to
> hackish for a mailinglist :-) I'm still interested in my problematic SD
> card and would just like to see what happens with your hack applied.

I hacked my RZ/A DMA driver, not the SDCARD driver. I assume you are=20
using R-Car, so that driver already uses a threaded IRQ handler (not a
tasklet).

But, what I did not try yet was rewriting the patch for SDHI=20
(52ad9a8e854c) so that instead of using wait_for_completion() in the callba=
ck, it=20
creates a kernel thread to do the waiting. In that case, the DMA tasklet=20
would complete immediately and my DMA driver could remain using tasklets
instead of threaded irqs.

I am worried about the scheduling latencies of using a kernel thread for
the SDHI callback, but, I guess that's no different than using a=20
threaded irq handler.

However...I'm wondering if I'm missing something obvious here and doing=20
extra work for nothing.


Chris
