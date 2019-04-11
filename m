From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 05/10] arm64: tegra: fix default tap and trim values
Date: Thu, 11 Apr 2019 12:11:38 +0200
Message-ID: <CAPDyKFqwESQ9_gDxLXhzBzu236+8p6rnqricULA7GrZguVZQWQ@mail.gmail.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-5-git-send-email-skomatineni@nvidia.com>
 <CAPDyKFq4ZVaMmvefuVqGs84E7xg5VgvU-Ecq1MYJdmBhuEm7xA@mail.gmail.com>
 <BYAPR12MB3398F91B190D9B1C56FDC4F7C2420@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR12MB339845B4C5A37468841E256AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Harjani Ritesh <riteshh@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Aniruddha Tvs Rao <anrao@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 1 Apr 2019 at 19:43, Sowjanya Komatineni <skomatineni@nvidia.com> w=
rote:
>
> > > >
> > > > Default tap and trim values are incorrect for Tegra186 SDMMC4.
> > > > This patch fixes it.
> > > >
> > > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > >
> > > Is this a fix and/or for stable?
> > >
> > > In either case, I am leaving this for arm-soc.
> > >
> > > Kind regards
> > > Uffe
> > >
> >
> > Thanks Uffe. Yes this is applicable for stable.
>
> I don=E2=80=99t see any confirmation of this being applied by arm-soc.
> So thought to re-check if this is applied?

Perhaps repost it to remind the soc maintainer to pick it up.

Kind regards
Uffe

>
> > > > ---
> > > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > index 97aeb946ed5e..472f55fe9488 100644
> > > > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > > @@ -317,8 +317,8 @@
> > > >                 nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D=
 <0x0a>;
> > > >                 nvidia,pad-autocal-pull-up-offset-3v3-timeout =3D <=
0x0a>;
> > > >                 nvidia,pad-autocal-pull-down-offset-3v3-timeout =3D=
 <0x0a>;
> > > > -               nvidia,default-tap =3D <0x5>;
> > > > -               nvidia,default-trim =3D <0x9>;
> > > > +               nvidia,default-tap =3D <0x9>;
> > > > +               nvidia,default-trim =3D <0x5>;
> > > >                 nvidia,dqs-trim =3D <63>;
> > > >                 mmc-hs400-1_8v;
> > > >                 status =3D "disabled";
> > > > --
> > > > 2.7.4
> > > >
