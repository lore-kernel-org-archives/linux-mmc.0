From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/3] s3c64xx: Fix build without SDHCI controllers
Date: Fri, 11 Jun 2010 09:56:38 +0900
Message-ID: <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
 <1276076345-24370-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276076345-24370-2-git-send-email-m.szyprowski@samsung.com>
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
> ---
>  arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pl=
at-
> samsung/include/plat/sdhci.h
> index 13f9fb2..c2044e5 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -166,6 +166,7 @@ static inline void s3c6410_default_sdhci2(void) {=
 }
>  #else
>  static inline void s3c6410_default_sdhci0(void) { }
>  static inline void s3c6410_default_sdhci1(void) { }
> +static inline void s3c6410_default_sdhci2(void) { }
>  static inline void s3c6400_default_sdhci0(void) { }
>  static inline void s3c6400_default_sdhci1(void) { }
>=20
> --

Maybe missed in Maurus' patch 'S3C64XX: add HSMMC2 support'
commit 92b118f6968ae0788ac659af47b464acd9a754a1

Also need 'static inline s3c6400_default_sdhci2(void) { }'
Could you re-submit updated patch including s3c6400_default_sdhci2()?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
