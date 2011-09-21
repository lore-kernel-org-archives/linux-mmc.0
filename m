From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2] arm: samsung: remove sdhci default configuration setup
 platform helper
Date: Wed, 21 Sep 2011 19:44:49 +0900
Message-ID: <001f01cc784b$7cbdde00$76399a00$%kim@samsung.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
 <1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
 <1314976702-19284-3-git-send-email-thomas.abraham@linaro.org>
 <001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
 <CAJuYYwT1tW0XEiwWWpX08OorZw2q2Wce2r0fUvxLmWC8uq6uhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwT1tW0XEiwWWpX08OorZw2q2Wce2r0fUvxLmWC8uq6uhQ@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Thomas Abraham wrote:
>=20
> Dear Mr. Kim,
>=20
> On 5 September 2011 10:46, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Thomas Abraham wrote:
> >>
> >> The sdhci platform helper function that sets up the default contro=
ller
> >> configuration is removed for all Samsung platforms since such defa=
ult
> >> controller configuration can be handled by the driver.
> >>
> >> Cc: Ben Dooks <ben-linux@fluff.org>
> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >> ---
> >> =A0arch/arm/mach-exynos4/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 47
-----------------------
> >> =A0arch/arm/mach-s3c2416/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 37 ---=
---------------
> >> =A0arch/arm/mach-s3c64xx/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 48
-----------------------
> >> =A0arch/arm/mach-s5pc100/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 42 ---=
-----------------
> >> =A0arch/arm/mach-s5pv210/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 41 ---=
-----------------
> >> =A0arch/arm/plat-samsung/dev-hsmmc.c =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 -
> >> =A0arch/arm/plat-samsung/dev-hsmmc1.c =A0 =A0 =A0 =A0 | =A0 =A02 -
> >> =A0arch/arm/plat-samsung/dev-hsmmc2.c =A0 =A0 =A0 =A0 | =A0 =A02 -
> >> =A0arch/arm/plat-samsung/dev-hsmmc3.c =A0 =A0 =A0 =A0 | =A0 =A02 -
> >> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 57
> > ----------------------------
> >> =A010 files changed, 0 insertions(+), 280 deletions(-)
> >>
>=20
> [...]
>=20
> >
> > Hi Thomas,
> >
> > The arch/arm/plat-samsung/dev-hsmmcX.c files have been changed due =
to
> commit
> > 61e62fcb ("ARM: SAMSUNG: Consolidate common function to set SDHCI p=
lat
> > data"). So if possible please make your patch based on latest my
for-next :)
>=20
> Sure. I will base these patches on your for-next, test and resubmit.
>=20

Hi Thomas,

I missed? I didn't get your updated yet.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
