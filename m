From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
Date: Tue, 2 Jul 2019 05:03:35 +0000
Message-ID: <MN2PR02MB6029CA4163882081D7B8C255C1F80@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-10-git-send-email-manish.narani@xilinx.com>
 <BYAPR02MB599224BA6280EDF56870E1D8B8F90@BYAPR02MB5992.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BYAPR02MB599224BA6280EDF56870E1D8B8F90@BYAPR02MB5992.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jolly Shah <JOLLYS@xilinx.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, Michal Simek <michals@xilinx.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "christoph.muellner@theobroma-systems.com" <christoph.muellner@theobroma-systems.com>, "philipp.tomsich@theobroma-systems.com" <philipp.tomsich@theobroma-systems.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "scott.branden@broadcom.com" <scott.branden@broadcom.com>, "ayaka@soulik.info" <ayaka@soulik.info>, "kernel@esmil.dk" <kernel@esmil.dk>, "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>, Rajan Vaja <RAJANV@xilinx.com>, Nava
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jolly,


> -----Original Message-----
> From: Jolly Shah
> Sent: Monday, July 1, 2019 11:36 PM
> To: Manish Narani <MNARANI@xilinx.com>; ulf.hansson@linaro.org;
> robh+dt@kernel.org; mark.rutland@arm.com; heiko@sntech.de; Michal Simek
> <michals@xilinx.com>; adrian.hunter@intel.com;
> christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com; Rajan Vaja
> <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> mdf@kernel.org; Manish Narani <MNARANI@xilinx.com>; olof@lixom.net
> Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> rockchip@lists.infradead.org
> Subject: RE: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
>=20
> Hi Manish,
>=20
> > -----Original Message-----
> > From: Manish Narani <manish.narani@xilinx.com>
> > Sent: Sunday, June 30, 2019 10:30 PM
> > To: ulf.hansson@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> > heiko@sntech.de; Michal Simek <michals@xilinx.com>;
> > adrian.hunter@intel.com; christoph.muellner@theobroma-systems.com;
> > philipp.tomsich@theobroma-systems.com; viresh.kumar@linaro.org;
> > scott.branden@broadcom.com; ayaka@soulik.info; kernel@esmil.dk;
> > tony.xie@rock-chips.com; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> > mdf@kernel.org; Manish Narani <MNARANI@xilinx.com>; olof@lixom.net
> > Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org
> > Subject: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
> >
> > Add APIs for setting SDIO Tap Delays on ZynqMP platform.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 48
> > ++++++++++++++++++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 15 ++++++++++-
> >  2 files changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> > index fd3d837..b81f1be 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -664,6 +664,52 @@ static int zynqmp_pm_set_requirement(const u32
> > node, const u32 capabilities,
> >  				   qos, ack, NULL);
> >  }
> >
> > +/**
> > + * zynqmp_pm_sdio_out_setphase() - PM call to set clock output delays =
for
> SD
> > + * @device_id:		Device ID of the SD controller
> > + * @tap_delay:		Tap Delay value for output clock
> > + *
> > + * This API function is to be used for setting the clock output delays=
 for SD
> > + * clock.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_sdio_out_setphase(u32 device_id, u8 tap_delay)
> > +{
> > +	u32 node_id =3D (!device_id) ? NODE_SD_0 : NODE_SD_1;
> > +	int ret;
> > +
> > +	ret =3D zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> > +			      PM_TAPDELAY_OUTPUT, tap_delay, NULL);
> > +	if (ret)
> > +		pr_err("Error setting Output Tap Delay\n");
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * zynqmp_pm_sdio_in_setphase() - PM call to set clock input delays fo=
r SD
> > + * @device_id:		Device ID of the SD controller
> > + * @tap_delay:		Tap Delay value for input clock
> > + *
> > + * This API function is to be used for setting the clock input delays =
for SD
> > + * clock.
> > + *
> > + * Return: Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_sdio_in_setphase(u32 device_id, u8 tap_delay)
> > +{
> > +	u32 node_id =3D (!device_id) ? NODE_SD_0 : NODE_SD_1;
> > +	int ret;
> > +
> > +	ret =3D zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> > +			      PM_TAPDELAY_INPUT, tap_delay, NULL);
> > +	if (ret)
> > +		pr_err("Error setting Input Tap Delay\n");
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct zynqmp_eemi_ops eemi_ops =3D {
> >  	.get_api_version =3D zynqmp_pm_get_api_version,
> >  	.get_chipid =3D zynqmp_pm_get_chipid,
> > @@ -687,6 +733,8 @@ static const struct zynqmp_eemi_ops eemi_ops =3D {
> >  	.set_requirement =3D zynqmp_pm_set_requirement,
> >  	.fpga_load =3D zynqmp_pm_fpga_load,
> >  	.fpga_get_status =3D zynqmp_pm_fpga_get_status,
> > +	.sdio_out_setphase =3D zynqmp_pm_sdio_out_setphase,
> > +	.sdio_in_setphase =3D zynqmp_pm_sdio_in_setphase,
>=20
> Are these eemi APIs? You are using ioctl eemi api to set the delay.

Yes, I am making these eemi APIs and calling ioctl API from these. This is =
to make the SD driver code more readable.

Thanks,
Manish
