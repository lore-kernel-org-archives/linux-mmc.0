From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2] s3c64xx: Fix build without SDHCI controllers
Date: Tue, 22 Jun 2010 21:29:09 +0900
Message-ID: <015c01cb1206$86bfeda0$943fc8e0$%kim@samsung.com>
References: <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
 <1276235941-12114-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276235941-12114-1-git-send-email-m.szyprowski@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Marek Szyprowski wrote:
>=20
> This patch fixes the following compilation problem if only NCP machin=
e
> is selected:
>=20
> arch/arm/mach-s3c64xx/s3c6410.c: In function =E2=80=98s3c6410_map_io=E2=
=80=99:
> arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of fu=
nction
> =E2=80=98s3c6410_default_sdhci2=E2=80=99
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied :-)

> ---
>  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pl=
at-
> samsung/include/plat/sdhci.h
> index 13f9fb2..2e263a8 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -166,8 +166,10 @@ static inline void s3c6410_default_sdhci2(void) =
{ }
>  #else
>  static inline void s3c6410_default_sdhci0(void) { }
>  static inline void s3c6410_default_sdhci1(void) { }
> +static inline void s3c6410_default_sdhci2(void) { }
>  static inline void s3c6400_default_sdhci0(void) { }
>  static inline void s3c6400_default_sdhci1(void) { }
> +static inline void s3c6400_default_sdhci2(void) { }
>=20
>  #endif /* CONFIG_S3C64XX_SETUP_SDHCI */
>=20
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
