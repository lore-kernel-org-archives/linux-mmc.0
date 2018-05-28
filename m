From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date: Mon, 28 May 2018 13:03:21 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9B65FC@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
 <CAHp75VcT+HEb67q0XbMvi9xQ4s0nyVKnoYRm5KN42z8h2FSu1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi Andy,=0A=
=0A=
Thanks for pointing all. We will fix it.=0A=
=0A=
Regards,=0A=
Prabu=0A=
=0A=
On 5/28/2018 5:49 PM, Andy Shevchenko wrote:=0A=
> On Tue, May 22, 2018 at 9:42 AM, Prabu Thangamuthu <Prabu.T@synopsys.com>=
 wrote:=0A=
>> To enable Synopsys DWC MSHC controller on HPAS-DX platform connected usi=
ng=0A=
>> PCIe interface. As Clock generation logic is implemented in MMCM module =
of=0A=
>> HAPS-DX platform, we have separate functions to control the MMCM to=0A=
>> generate required clocks with respect to speed mode. Also we have platfo=
rm=0A=
>> specific set_power function to support different VDD of eMMC devices.=0A=
>> + * Authors:=0A=
>> + *    Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
>> + *    Manjunath M B <manjumb@synopsys.com>=0A=
>> + *=0A=
> Redundant last line in above excerpt.=0A=
>=0A=
>> +#include <linux/pci.h>=0A=
>> +#include <linux/delay.h>=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/moduleparam.h>=0A=
> This one is effectively included by module.h.=0A=
>=0A=
>> +/* Default emmc vdd is set to 3.3V */=0A=
>> +static unsigned int emmc_vdd =3D SDHC_EMMC_VDD_330V;=0A=
>> +module_param(emmc_vdd, int, 0444);=0A=
> This looks weird. Why do you need a module parameter?=0A=
>=0A=
>> +    u16 clk =3D 0;=0A=
>> +    u32 reg =3D 0;=0A=
>> +    u32 vendor_ptr =3D 0;=0A=
> Why do above have assignments?=0A=
>=0A=
>> +MODULE_PARM_DESC(emmc_vdd, "VDD to configure eMMC device supply voltage=
");=0A=
> This better to be near to the parameter declaration. Though, as I said=0A=
> above, it feels wrong to have it in the first place.=0A=
>=0A=
>=0A=
>> +/* Synopsys Vendor Specific Registers */=0A=
>> +#define SDHC_GPIO_OUT                          0x34=0A=
>> +#define SDHC_AT_CTRL_R                   0x40=0A=
>> +=0A=
>> +#define SDHC_SW_TUNE_EN                   0x00000010=0A=
>> +=0A=
>> +/* MMCM DRP */=0A=
>> +#define SDHC_MMCM_DIV_REG               0x1020=0A=
>> +#define DIV_REG_100_MHZ                   0x1145=0A=
>> +=0A=
>> +#define SDHC_MMCM_CLKFBOUT               0x1024=0A=
>> +#define CLKFBOUT_100_MHZ               0x0000=0A=
>> +=0A=
>> +#define SDHC_CCLK_MMCM_RST               0x00000001=0A=
> Do you need these all in the header file? Why?=0A=
>=0A=
>=0A=
>> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xC202=0A=
> Absent blank line.=0A=
> Broken style of the value.=0A=
>=0A=
> Who knows what else wrong with this patch? Please, pay attention to=0A=
> the details and check twice before submit.=0A=
>=0A=
=0A=
