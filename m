From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2 00/16] omap_hsmmc patches
Date: Wed, 13 Jul 2011 13:48:08 +0300
Message-ID: <CANOLnONWmYn4FpuF-UAKQR4rAA6LOgWdMfu2bMN46nna6rOxAw@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

Hello,

it seems this series got lost in time, at least patches 01, 02, 03,
04, 05, 06, 07, 08, 12 look like valid standalone fixes and
improvements to me, they don't touch other trees and still apply
cleanly, so would be good to have.

Chris, can you queue these for upcoming merge window?
These patches are also archived in patchwork here:
https://patchwork.kernel.org/project/linux-omap/list/?archive=3Dboth&pa=
ge=3D8


On Fri, May 6, 2011 at 12:13 PM, Adrian Hunter <adrian.hunter@nokia.com=
> wrote:
> Hi
>
> Here is V2 of some patches for omap_hsmmc.
>
> Changes in V2:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP: sDMA: descriptor autoloading feature
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- removed the =
feature entirely as per Tony Lindgren
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: fix few bugs when set the=
 clock divisor
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- added cpu_re=
lax() as per Grazvydas Ignotas
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: fix missing mmc_release_h=
ost() in no_off case
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- removed {} a=
s per Sergei Shtylyov
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP: hsmmc: implement clock switcher
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- changed to >=
=3D threshold as per Grazvydas Ignotas
>
>
> Adrian Hunter (6):
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: correct debug report error statu=
s mnemonics
> =C2=A0 =C2=A0 =C2=A0OMAP: board-rm680: set MMC nomux flag
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: ensure pbias configuration is al=
ways done
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: fix oops in omap_hsmmc_dma_cb
> =C2=A0 =C2=A0 =C2=A0OMAP: hsmmc: add platform data for eMMC hardware =
reset gpio
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: add a hardware reset before init=
ialization
>
> Andy Shevchenko (8):
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: move hardcoded frequency constan=
ts to definition block
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: reduce a bit the error handlers =
in probe()
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: split duplicate code to calc_div=
isor() function
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: introduce start_clock and re-use=
 stop_clock
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: fix few bugs when set the clock =
divisor
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: split same pieces of code to sep=
arate functions
> =C2=A0 =C2=A0 =C2=A0OMAP: hsmmc: implement clock switcher
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: adjust host controller clock in =
regard to current OPP
>
> Jarkko Lavinen (1):
> =C2=A0 =C2=A0 =C2=A0OMAP: hsmmc: Do not mux the slot if non default m=
uxing is already done
>
> Sudhir Bera (1):
> =C2=A0 =C2=A0 =C2=A0mmc: omap_hsmmc: fix missing mmc_release_host() i=
n no_off case
>
> =C2=A0arch/arm/mach-omap2/board-rm680.c =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
1 +
> =C2=A0arch/arm/mach-omap2/hsmmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0188 +++++++++++++++++-
> =C2=A0arch/arm/mach-omap2/hsmmc.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A02 +
> =C2=A0arch/arm/plat-omap/include/plat/mmc.h | =C2=A0 =C2=A09 +
> =C2=A0drivers/mmc/host/omap_hsmmc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0353 ++++++++++++++++++++-------------
> =C2=A05 files changed, 414 insertions(+), 139 deletions(-)
>
> Regards
> Adrian
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
