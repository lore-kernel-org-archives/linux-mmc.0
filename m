From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Wed, 2 Oct 2019 04:50:03 +0000
Message-ID: <TYAPR01MB454431DC0DE9F2DDA2DB2AA5D89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191001180834.1158-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180834.1158-1-geert+renesas@glider.be>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Wednesday, October 2, 2019 3:09 AM
>=20
> As platform_get_irq() now prints an error when the interrupt does not
> exist, a scary warning may be printed for an optional interrupt:
>=20
>     sh_mmcif ee200000.mmc: IRQ index 1 not found
>=20
> Fix this by calling platform_get_irq_optional() instead for the second
> interrupt, which is optional.
>=20
> Remove the now superfluous error printing for the first interrupt, which
> is mandatory.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

And, I tested this patch on R-Car H2. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
