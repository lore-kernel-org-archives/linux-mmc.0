From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count
 interrupts
Date: Wed, 2 Oct 2019 04:49:35 +0000
Message-ID: <TYAPR01MB45447ABA9739F32FB2F672DBD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191001180703.910-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001180703.910-1-geert+renesas@glider.be>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Wednesday, October 2, 2019 3:07 AM
>=20
> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing
> of scary messages like:
>=20
>     renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found
>=20
> Fix this by using the platform_irq_count() helper to avoid touching
> non-existent interrupts.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a fix for v5.4-rc1.
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

And, I tested this patch on R-Car H3. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
