From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 0/3] mmc: sh_mobile_sdhi: Add r7s72100 support
Date: Fri, 14 Oct 2016 13:14:22 +0000
Message-ID: <SG2PR06MB1165883EDC27C3C7994121EF8ADF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160912141507.6837-1-chris.brandt@renesas.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

What ever happened to this series of patches?

They didn't seem too outrageous, but they never got applied.

Thank you.

Chris



On 9/12/2016, Chris Brandt wrote:
> To: Ulf Hansson <ulf.hansson@linaro.org>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>;
> Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>; linux-mmc@vger.kernel.org;
> linux-renesas-soc@vger.kernel.org; Chris Brandt <Chris.Brandt@renesas.com=
>
> Subject: [PATCH v3 0/3] mmc: sh_mobile_sdhi: Add r7s72100 support
>=20
> For the most part, the SDHI controller in the RZ/A1 (r7s72100) is the sam=
e
> as other Renesas SoC...except for the fact that the data port register wa=
s
> widened to 32-bits and the 16-bit accesses in the current tmio driver
> aren't going to cut it.
>=20
> Also, the tmio driver allows you to pass in what voltages you support via
> the ocr_mask. For the RZ/A1, it's just simple 3.3v.
> So, I added the ability to pass that when using DT.
>=20
> Chris Brandt (3):
>   mmc: sh_mobile_sdhi: add ocr_mask option
>   mmc: tmio-mmc: add support for 32bit data port
>   mmc: sh_mobile_sdhi: Add r7s72100 support
>=20
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
>  drivers/mmc/host/sh_mobile_sdhi.c                  |  9 +++++++
>  drivers/mmc/host/tmio_mmc.h                        | 12 +++++++++
>  drivers/mmc/host/tmio_mmc_pio.c                    | 30
> ++++++++++++++++++++++
>  include/linux/mfd/tmio.h                           |  5 ++++
>  5 files changed, 57 insertions(+)
>=20
> --
> 2.9.2
>=20
