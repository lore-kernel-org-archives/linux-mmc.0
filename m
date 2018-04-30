From: Liming Sun <lsun@mellanox.com>
Subject: RE: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
 description
Date: Mon, 30 Apr 2018 14:57:28 +0000
Message-ID: <AM2PR05MB075369C92FE1416271895F51A1820@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <7505274f8d82642fd08e874160acd45be2418673.1524497286.git.lsun@mellanox.com>
 <20180427195049.ycjmhes4qj4n3myq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427195049.ycjmhes4qj4n3myq@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks. Updated in v3 2/3.

- Liming

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, April 27, 2018 3:51 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
> description
>=20
> On Mon, Apr 23, 2018 at 11:32:21AM -0400, Liming Sun wrote:
> > This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> > extension on Mellanox BlueField SoC platform.
>=20
> "dt-bindings: mmc: " is preferred subject prefix.
>=20
> >
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29
> ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-
> dw-mshc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt
> > new file mode 100644
> > index 0000000..ee0dd61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> > @@ -0,0 +1,29 @@
> > +* Mellanox Bluefield SoC specific extensions to the Synopsys Designwar=
e
> > +  Mobile Storage Host Controller
> > +
> > +Read synopsys-dw-mshc.txt for more details
> > +
> > +The Synopsys designware mobile storage host controller is used to
> interface
> > +a SoC with storage medium such as eMMC or SD/MMC cards. This file
> documents
> > +differences between the core Synopsys dw mshc controller properties
> described
> > +by synopsys-dw-mshc.txt and the properties used by the Mellanox
> Bluefield SoC
> > +specific extensions to the Synopsys Designware Mobile Storage Host
> Controller.
> > +
> > +Required Properties:
> > +
> > +* compatible: should be one of the following.
> > +  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefi=
eld
> SoC
> > +    specific extensions.
> > +
> > +Example:
> > +
> > +	/* Mellanox Bluefield SoC MMC */
> > +	dwmmc0@4,0 {
>=20
> mmc@...
>=20
> Doesn't look like a correct unit-address either.
>=20
> > +		compatible =3D "mellanox,bluefield-dw-mshc";
> > +		reg =3D <4 0x8000 0x400>;
> > +		interrupts =3D <32>;
> > +		fifo-depth =3D <0x100>;
> > +		clock-frequency =3D <24000000>;
> > +		bus-width =3D <8>;
> > +		cap-mmc-highspeed;
> > +	};
> > --
> > 1.8.3.1
> >
