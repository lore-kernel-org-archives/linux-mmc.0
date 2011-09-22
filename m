From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Thu, 22 Sep 2011 09:37:08 +0530
Message-ID: <CAGxe1ZFnc5bpv7Ys4Tq5D=XkMxZuJ7mxkM2NXR8hug9Hs6_OSA@mail.gmail.com>
References: <1315918652-14340-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2hb454voa.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2hb454voa.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi chris,

On 21 September 2011 23:36, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish,
>
> On Tue, Sep 13 2011, Girish K S wrote:
>> This patch adds the power class selection feature available
>> for mmc versions 4.0 and above.
>> During the enumeration stage before switching to the lower
>> data bus, check if the power class is supported for the
>> current bus width. If the power class is available then
>> switch to the power class and use the higher data bus. If
>> power class is not supported then switch to the lower data
>> bus in a worst case.
>>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> =A0drivers/mmc/core/mmc.c =A0| =A0 77 ++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A0include/linux/mmc/mmc.h | =A0 13 ++++++++
>> =A02 files changed, 90 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 63cc77b..a4004da 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -536,6 +536,81 @@ static struct device_type mmc_type =3D {
>> =A0};
>>
>> =A0/*
>> + * Select the PowerClass for the current bus width
>> + * If power class is defined for 4/8 bit bus in the
>> + * extended CSD register, select it by executing the
>> + * mmc_switch command.
>> + */
>> +static int mmc_select_powerclass(struct mmc_card *card, unsigned in=
t bus_width)
>> +{
>> + =A0 =A0 u8 *ext_csd;
>> + =A0 =A0 int err;
>> + =A0 =A0 unsigned int pwrclass_val;
>> + =A0 =A0 unsigned int index =3D 0;
>> + =A0 =A0 struct mmc_host *host =3D card->host;
>> +
>> + =A0 =A0 BUG_ON(!card);
>> + =A0 =A0 BUG_ON(!host);
>> +
>> + =A0 =A0 /* Power class selection is supported for versions >=3D 4.=
0 */
>> + =A0 =A0 if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 /*Power class values are defined only for 4/8 bit bus*/
>
> Spaces between /* */ and the comment itself, please.
OK
>
>> + =A0 =A0 if (bus_width =3D=3D EXT_CSD_BUS_WIDTH_1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 switch ((1 << host->ios.vdd)) {
>
> Extra parens unnecessary.
OK
>
>> + =A0 =A0 case MMC_VDD_165_195:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ios.clock <=3D 26000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D EXT_CSD_PWR_CL_2=
6_195;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->ios.clock <=3D 52000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D (bus_width <=3D =
EXT_CSD_BUS_WIDTH_8) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_52_195 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_DDR_52_195;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->ios.clock <=3D 200000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D EXT_CSD_PWR_CL_2=
00_195;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case MMC_VDD_32_33:
>> + =A0 =A0 case MMC_VDD_33_34:
>> + =A0 =A0 case MMC_VDD_34_35:
>> + =A0 =A0 case MMC_VDD_35_36:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->ios.clock <=3D 26000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D EXT_CSD_PWR_CL_2=
6_360;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->ios.clock <=3D 52000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D (bus_width <=3D =
EXT_CSD_BUS_WIDTH_8) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_52_360 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_DDR_52_360;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->ios.clock <=3D 200000000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D EXT_CSD_PWR_CL_2=
00_360;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>
> BUG() is a huge deal -- it will take out the entire MMC stack, so it'=
s
> not appropriate here. =A0How about just a pr_error() that notes an
> unexpected VDD and then returns an error value?
Will change it
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 err =3D mmc_get_ext_csd(card, &ext_csd);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto ret;
>> +
>> + =A0 =A0 pwrclass_val =3D ext_csd[index];
>> +
>> + =A0 =A0 if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WID=
TH_8))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D (pwrclass_val & EXT_CSD_P=
WR_CL_8BIT_MASK) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_8BIT_SHIFT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D (pwrclass_val & EXT_CSD_P=
WR_CL_4BIT_MASK) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_PWR_CL_4BIT_SHIFT;
>> +
>> + =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_POWER_CLASS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
>> +ret:
>> + =A0 =A0 mmc_free_ext_csd(ext_csd);
>> + =A0 =A0 return err;
>> +}
>> +
>> +/*
>> =A0 * Handle the detection and initialisation of a card.
>> =A0 *
>> =A0 * In the case of a resume, "oldcard" will contain the card
>> @@ -802,6 +877,7 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D bus_widths=
[idx];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bus_width =3D=3D MMC=
_BUS_WIDTH_1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ddr =3D =
0; /* no DDR for 1-bit width */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_select_powerclass(card=
, ext_csd_bits[idx][0]);
>
> Since you're returning a meaningful error value above, we should do
> something with it here -- if you don't expect the error cases to be
> hit, you could pr_warning() the return value here so that we can
> investigate.

This patch is the first version. If you check the V2 its already handle=
d.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
