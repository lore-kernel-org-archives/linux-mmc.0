From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/3] s3c64xx: Fix build without SDHCI controllers
Date: Fri, 11 Jun 2010 12:58:46 +0900
Message-ID: <000c01cb091a$675b2fa0$36118ee0$%kim@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
 <1276076345-24370-2-git-send-email-m.szyprowski@samsung.com>
 <000801cb0900$f64bbdc0$e2e33940$%kim@samsung.com>
 <AANLkTimPp36K_SmFm053cu9f9Znb8SFHVcKAn8bjD1PI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31729 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab0FKD6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 23:58:48 -0400
In-reply-to: <AANLkTimPp36K_SmFm053cu9f9Znb8SFHVcKAn8bjD1PI@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kyungmin.park@samsung.com>
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org

Kyungmin Park wrote:
>=20
> On Fri, Jun 11, 2010 at 9:56 AM, Kukjin Kim <kgene.kim@samsung.com> w=
rote:
> > Marek Szyprowski wrote:
> >>
> >> This patch fixes the following compilation problem if only NCP mac=
hine
> >> is selected:
> >>
> >> arch/arm/mach-s3c64xx/s3c6410.c: In function =E2=80=98s3c6410_map_=
io=E2=80=99:
> >> arch/arm/mach-s3c64xx/s3c6410.c:51: error: implicit declaration of=
 function
> >> =E2=80=98s3c6410_default_sdhci2=E2=80=99
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >>  arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm=
/plat-
> >> samsung/include/plat/sdhci.h
> >> index 13f9fb2..c2044e5 100644
> >> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> >> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> >> @@ -166,6 +166,7 @@ static inline void s3c6410_default_sdhci2(void=
) { }
> >>  #else
> >>  static inline void s3c6410_default_sdhci0(void) { }
> >>  static inline void s3c6410_default_sdhci1(void) { }
> >> +static inline void s3c6410_default_sdhci2(void) { }
> >>  static inline void s3c6400_default_sdhci0(void) { }
> >>  static inline void s3c6400_default_sdhci1(void) { }
> >>
> >> --
> >
> > Maybe missed in Maurus' patch 'S3C64XX: add HSMMC2 support'
> > commit 92b118f6968ae0788ac659af47b464acd9a754a1
>=20
> Which kernel tree do you use?
> it's against the latest kernel.
>
Of course, Linus' 35-rc2.
Any problem?

> >
> > Also need 'static inline s3c6400_default_sdhci2(void) { }'
> > Could you re-submit updated patch including s3c6400_default_sdhci2(=
)?
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

