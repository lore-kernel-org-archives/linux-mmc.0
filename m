From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v4 2/8] dt-bindings: mmc: arasan: Update Documentation for
 the input clock
Date: Thu, 31 Oct 2019 08:52:59 +0000
Message-ID: <MN2PR02MB6029A5A7D65C8360B55A1E93C1630@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
 <1572345042-101207-2-git-send-email-manish.narani@xilinx.com>
 <20191029184014.GA837@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029184014.GA837@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, Michal Simek <michals@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, October 30, 2019 12:10 AM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: ulf.hansson@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Manish Narani <MNARANI@xilinx.com>; linux-
> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: arasan: Update
> Documentation for the input clock
>=20
> On Tue, 29 Oct 2019 16:00:36 +0530, Manish Narani wrote:
> > Add documentation for an optional input clock which is essentially used
> > in sampling the input data coming from the card.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions.
> However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.

That was mistakenly not added. My apologies.
However, Uffe has some comments on this version, so will send out v5 with a=
ddressing them and will include the 'reviewed-by' tag.

Thanks,
Manish
