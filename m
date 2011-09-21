From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 3/3] arm/tegra: Move "gpio-names.h" into
 <mach/gpio-tegra.h>
Date: Wed, 21 Sep 2011 13:29:03 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173818019E@HQMAIL01.nvidia.com>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com>
	<1316633620-13184-3-git-send-email-swarren@nvidia.com>
 <CAOesGMhdkrtjvXWHhbLSj804s+CzTthn_hrGafp5K=Va5MTZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMhdkrtjvXWHhbLSj804s+CzTthn_hrGafp5K=Va5MTZ=w@mail.gmail.com>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Olof Johansson wrote at Wednesday, September 21, 2011 2:15 PM:
> On Wed, Sep 21, 2011 at 12:33 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>=
 wrote:
> > This centralizes all SoC-level GPIO-related definitions into a sing=
le
> > header file.
> >
> > Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >
> > =A0arch/arm/mach-tegra/gpio-names.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
247 -------------------------
> > =A0arch/arm/mach-tegra/include/mach/gpio-tegra.h | =A0225 +++++++++=
+++++++++++++
> > =A011 files changed, 226 insertions(+), 257 deletions(-)
> > =A0delete mode 100644 arch/arm/mach-tegra/gpio-names.h
>=20
> The main reason that gpio-names.h was only in the mach directory and
> not under include in the first place, is to discourage use outside of
> the base platform code and board definitions.
>=20
> There should be no need for drivers and non-mach-tegra code to use th=
e
> file, so doing a current-directory include of it should be OK. Or do
> you have other plans for it?

My primary motivation was to bring Tegra into line with what appears to
be common practice amongst other ARM sub-architectures; many of
mach-$x/include/mach/gpio-$x.h define the GPIO names there.

Still, your argument is valid; I don't foresee a need to anything other
than mach-tegra/*.c to need the GPIO names file.

So, feel free to take/drop this patch as you desire.

--=20
nvpublic
