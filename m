From: Liming Sun <lsun@mellanox.com>
Subject: RE: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Date: Tue, 1 May 2018 14:36:06 +0000
Message-ID: <AM2PR05MB07537F51DC0670BF67E79AD2A1810@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525099868-45094-2-git-send-email-lsun@mellanox.com>
 <20180501124800.GA6206@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180501124800.GA6206@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Sorry, my mistake. I missed the last one in the v3 comments.
Fixed it in v4 2/3.

Thanks,
Liming

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, May 1, 2018 8:48 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField S=
oC
>=20
> On Mon, Apr 30, 2018 at 10:51:07AM -0400, Liming Sun wrote:
> > This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> > extension on Mellanox BlueField SoC platform.
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
> Still the same issues.
>=20
> mmc@...
>=20
> And the unit-address looks wrong.
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
