From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V8 1/2] mmc: core: HS200 mode support for eMMC 4.5
Date: Tue, 3 Jan 2012 11:44:02 +0530
Message-ID: <CAGxe1ZGA6biMJLpptgvPC2Ex=xRfk7MYq40So0-GHbACNPXxPA@mail.gmail.com>
References: <1324624322-2189-1-git-send-email-girish.shivananjappa@linaro.org>
	<1324624322-2189-2-git-send-email-girish.shivananjappa@linaro.org>
	<m2ty4dpvjr.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2ty4dpvjr.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Philip Rakity <prakity@marvell.com>
List-Id: linux-mmc@vger.kernel.org

On 3 January 2012 04:21, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish, small style comments,
>
> On Fri, Dec 23 2011, Girish K S wrote:
>> This patch adds the support of the HS200 bus speed for eMMC 4.5 devi=
ces.
>> The eMMC 4.5 devices have support for 200MHz bus speed. The function
>> prototype of the tuning function is modified to handle the tuning co=
mmand
>> number which is different in sd and mmc case.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> =A0drivers/mmc/core/bus.c =A0 =A0 | =A0 =A03 +-
>> =A0drivers/mmc/core/debugfs.c | =A0 =A03 +
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0163 +++++++++++++++++++++++++=
++++++++++++++++---
>> =A0drivers/mmc/core/sd.c =A0 =A0 =A0| =A0 =A03 +-
>> =A0drivers/mmc/core/sdio.c =A0 =A0| =A0 =A04 +-
>> =A0include/linux/mmc/card.h =A0 | =A0 =A03 +
>> =A0include/linux/mmc/host.h =A0 | =A0 11 +++-
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 66 +++++++++++++++++-
>> =A08 files changed, 242 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index f8a228a..5d011a3 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -303,10 +303,11 @@ int mmc_add_card(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card) =
? "DDR " : "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type);
>> =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s card at a=
ddress %04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: new %s%s%s%s card at address =
%04x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_uhs(card) ? "ul=
tra high speed " :
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_highspeed(card=
) ? "high speed " : ""),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) ? "H=
S200 " : ""),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card) =
? "DDR " : "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, card->rca);
>> =A0 =A0 =A0 }
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 027615d..9ab5b17 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void=
 *data)
>> =A0 =A0 =A0 case MMC_TIMING_UHS_DDR50:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D "sd uhs DDR50";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case MMC_TIMING_MMC_HS200:
>> + =A0 =A0 =A0 =A0 =A0 =A0 str =3D "mmc high-speed SDR200";
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D "invalid";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f0a9f1f..583cb42 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -286,6 +286,27 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_TYP=
E];
>> =A0 =A0 =A0 switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_M=
ASK) {
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_T=
YPE_SDR_200;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_T=
YPE_SDR_1_2V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
>> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_T=
YPE_SDR_1_8V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
>> =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
>> @@ -700,6 +721,79 @@ static int mmc_select_powerclass(struct mmc_car=
d *card,
>> =A0}
>>
>> =A0/*
>> + * Selects the desired buswidth and switch to the HS200 mode
>> + * if bus width set without error
>> + */
>> +static int mmc_select_hs200(struct mmc_card *card)
>> +{
>> + =A0 =A0 int idx, err =3D 0;
>> + =A0 =A0 struct mmc_host *host;
>> + =A0 =A0 static unsigned ext_csd_bits[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_8,
>> + =A0 =A0 };
>> + =A0 =A0 static unsigned bus_widths[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_8,
>> + =A0 =A0 };
>> +
>> + =A0 =A0 BUG_ON(!card);
>> +
>> + =A0 =A0 host =3D card->host;
>> +
>> + =A0 =A0 if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V)
>> + =A0 =A0 =A0 =A0 =A0 =A0 && (host->caps2 & MMC_CAP2_HS200_1_2V_SDR)=
)
>
> A continuation (&&, ||..) should go on the end of the first line.
> Also, & has higher precedence than &&, so parens are unneeded.
>
> =A0 =A0 =A0 =A0if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_=
2V &&
> =A0 =A0 =A0 =A0 =A0 =A0host->caps2 & MMC_CAP2_HS200_1_2V_SDR)

Will Update it

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_set_signal_voltage(host, MMC_SIGNA=
L_VOLTAGE_120, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_vol=
tage(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_SIGNAL_VOLTAGE_180, 0);
>> +
>> + =A0 =A0 /* If fails try again during next card power cycle */
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> +
>> + =A0 =A0 idx =3D (host->caps & MMC_CAP_8_BIT_DATA) ? 1 : 0;
>
> Wouldn't "idx =3D host->caps & MMC_CAP_8_BIT_DATA;" do the same thing=
?

 host->caps & MMC_CAP_8_BIT_DATA will assign (1 << 6) or 0 to idx. But
i want to assign 0 or 1.

>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Unlike SD, MMC cards dont have a configuration regist=
er to notify
>> + =A0 =A0 =A0* supported bus width. So bus test command should be ru=
n to identify
>> + =A0 =A0 =A0* the supported bus width or compare the ext csd values=
 of current
>> + =A0 =A0 =A0* bus width and ext csd values of 1 bit mode read earli=
er.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 for (; idx >=3D 0; idx--) {
>
> I don't understand the purpose of this loop. =A0idx can only be 0 or =
1,
> right? =A0Why would you go through the loop more than once? =A0Why no=
t say
> "if (idx) {"?
>
idx value will only indicate whether host is capable of handling 8 bit
and 4 bit mode.
To validate whether card supports 8/4
1. the driver code should switch to 8 bit mode (highest bus
supported), execute the bus test. If successful then continue with the
8 bit mode.
2. If bus test fails for 8 bit mode then continue step 1 with 4 bit mod=
e.

due to this reason we need to go through the loop for more than once.

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Host is capable of 8bit transfer, the=
n switch
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the device to work in 8bit transfer m=
ode. If the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* mmc switch command returns error then=
 switch to
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 4bit transfer mode. On success set th=
e corresponding
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* bus width on the host.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_BUS_WIDTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd=
_bits[idx],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->e=
xt_csd.generic_cmd6_time);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->host, bus_widths[i=
dx]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_compare_ext_cs=
ds(card, bus_widths[idx]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_bus_test(card,=
 bus_widths[idx]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* switch to HS200 mode if bus width set successfully */
>> + =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_HS_TIMING, 2, 0);
>> +err:
>> + =A0 =A0 return err;
>> +}
>> +
>> +/*
>> =A0 * Handle the detection and initialisation of a card.
>> =A0 *
>> =A0 * In the case of a resume, "oldcard" will contain the card
>> @@ -905,11 +999,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Activate high speed (if supported)
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 (host->caps & MMC_CAP_MMC_HIGHSPEED)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_HS_TIMING, 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->e=
xt_csd.generic_cmd6_time);
>> + =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr > 52000000) =
&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_HS200))
>
> No need for these parentheses.

agree will update in next patch

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (card->ext_csd.hs_max_dtr > 5200000=
0 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->caps2 & MMC_CAP2_HS200)
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_hs200(c=
ard);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->caps & MMC_CAP_MMC_HIGHSPEE=
D)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, E=
XT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EXT_CSD_HS_TIMING, 1, 0);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>>
>> @@ -918,8 +1016,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostn=
ame(card->host));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(car=
d);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->host,=
 MMC_TIMING_MMC_HS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_=
dtr > 52000000) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC=
_CAP2_HS200)) {
>
> Same as above.
>

agree will update in next patch

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_s=
et_hs200(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_ti=
ming(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0MMC_TIMING_MMC_HS200);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_s=
et_highspeed(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_ti=
ming(card->host, MMC_TIMING_MMC_HS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> @@ -944,7 +1049,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 max_dtr =3D (unsigned int)-1;
>>
>> - =A0 =A0 if (mmc_card_highspeed(card)) {
>> + =A0 =A0 if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_dtr > card->ext_csd.hs_max_dtr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_dtr =3D card->ext_cs=
d.hs_max_dtr;
>> =A0 =A0 =A0 } else if (max_dtr > card->csd.max_dtr) {
>> @@ -970,9 +1075,49 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> + =A0 =A0 =A0* Indicate HS200 SDR mode (if supported).
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mmc_card_hs200(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ext_csd_bits;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 bus_width =3D card->host->ios.bus_widt=
h;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For devices supporting HS200 mode, th=
e bus width has
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to be set before executing the tuning=
 function. If
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* set before tuning, then device will r=
espond with CRC
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* errors for responses on CMD line. So =
for HS200 the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequence will be
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1. set bus width 4bit / 8 bit (1 bit =
not supported)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 2. switch to HS200 mode
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 3. set the clock to > 52Mhz <=3D200MH=
z and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 4. execute tuning for HS200
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_HS200) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuning)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->e=
xecute_tuning(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 MMC_SEND_TUNING_BLOCK_HS200);
>
> One less tab here.
>

agree will update in next patch

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("tuning executi=
on failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Add the mmc_hostname().
>

agree will update in next patch

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bits =3D (bus_width =3D=3D MMC_BUS=
_WIDTH_8) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_BUS_WIDTH_8 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 EXT_CSD_BUS_WIDTH_4;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd_bits =3D (bus_width =3D=3D MMC=
_BUS_WIDTH_8) ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
>
agree will update in next patch

>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_powerclass(card, ext_cs=
d_bits, ext_csd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class se=
lection to bus width"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%d failed\=
n", mmc_hostname(card->host),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 << bus_wi=
dth);
>
> I think using one line for the format string is okay here, even thoug=
h
> it will go past 80 chars. =A0It's easier to grep for strings that way=
=2E
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: power clas=
s selection to bus width %d failed\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostn=
ame(card->host), 1 << bus_width);
>

agree will update in next patch

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Activate wide bus and DDR (if supported).
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>> + =A0 =A0 if (!mmc_card_hs200(card) &&
>> + =A0 =A0 =A0 =A0 (card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) &&
>> =A0 =A0 =A0 =A0 =A0 (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BI=
T_DATA))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 static unsigned ext_csd_bits[][2] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { EXT_CSD_BUS_WIDTH_8, E=
XT_CSD_DDR_BUS_WIDTH_8 },
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 6f27d35..a775131 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -661,7 +661,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card =
*card)
>>
>> =A0 =A0 =A0 /* SPI mode doesn't define CMD19 */
>> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && card->host->ops->exe=
cute_tuning)
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(ca=
rd->host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(ca=
rd->host, =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK);
>
> \ is unnecessary here.
>

OK agree

>>
>> =A0out:
>> =A0 =A0 =A0 kfree(status);
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index b77f770..bd7bacc 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -14,6 +14,7 @@
>>
>> =A0#include <linux/mmc/host.h>
>> =A0#include <linux/mmc/card.h>
>> +#include <linux/mmc/mmc.h>
>> =A0#include <linux/mmc/sdio.h>
>> =A0#include <linux/mmc/sdio_func.h>
>> =A0#include <linux/mmc/sdio_ids.h>
>> @@ -556,7 +557,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_car=
d *card)
>>
>> =A0 =A0 =A0 /* Initialize and start re-tuning timer */
>> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && card->host->ops->exe=
cute_tuning)
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(ca=
rd->host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(ca=
rd->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK);
>>
>> =A0out:
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 9478a6b..9f22ba5 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -216,6 +216,7 @@ struct mmc_card {
>> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* card is in ultra high speed mode */
>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0=
 =A0 =A0 =A0/* card is SDXC */
>> =A0#define MMC_CARD_REMOVED =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* car=
d has been removed */
>> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =A0 =A0=
/* card is in HS200 mode */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0 =
=A0 /* card quirks */
>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0 =A0=
 =A0/* allow SDIO FN0 writes outside of the VS CCCR range */
>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func->cur_blk=
size */
>> @@ -374,6 +375,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> =A0#define mmc_card_present(c) =A0((c)->state & MMC_STATE_PRESENT)
>> =A0#define mmc_card_readonly(c) ((c)->state & MMC_STATE_READONLY)
>> =A0#define mmc_card_highspeed(c) =A0 =A0 =A0 =A0((c)->state & MMC_ST=
ATE_HIGHSPEED)
>> +#define mmc_card_hs200(c) =A0 =A0((c)->state & MMC_STATE_HIGHSPEED_=
200)
>> =A0#define mmc_card_blockaddr(c) =A0 =A0 =A0 =A0((c)->state & MMC_ST=
ATE_BLOCKADDR)
>> =A0#define mmc_card_ddr_mode(c) ((c)->state & MMC_STATE_HIGHSPEED_DD=
R)
>> =A0#define mmc_card_uhs(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->state & =
MMC_STATE_ULTRAHIGHSPEED)
>> @@ -384,6 +386,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0((c)->state |=3D MMC_S=
TATE_PRESENT)
>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READO=
NLY)
>> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGH=
SPEED)
>> +#define mmc_card_set_hs200(c) =A0 =A0 =A0 =A0((c)->state |=3D MMC_S=
TATE_HIGHSPEED_200)
>> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOC=
KADDR)
>> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHS=
PEED_DDR)
>> =A0#define mmc_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIGHS=
PEED)
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 9a03d03..606c8c3 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -56,10 +56,13 @@ struct mmc_ios {
>> =A0#define MMC_TIMING_UHS_SDR50 3
>> =A0#define MMC_TIMING_UHS_SDR104 =A0 =A0 =A0 =A04
>> =A0#define MMC_TIMING_UHS_DDR50 5
>> +#define MMC_TIMING_MMC_HS200 6
>>
>> =A0#define MMC_SDR_MODE =A0 =A0 =A0 =A0 0
>> =A0#define MMC_1_2V_DDR_MODE =A0 =A01
>> =A0#define MMC_1_8V_DDR_MODE =A0 =A02
>> +#define MMC_1_2V_SDR_MODE =A0 =A03
>> +#define MMC_1_8V_SDR_MODE =A0 =A04
>>
>> =A0 =A0 =A0 unsigned char =A0 signal_voltage; =A0 =A0 =A0 =A0 /* sig=
nalling voltage (1.8V or 3.3V) */
>>
>> @@ -148,7 +151,9 @@ struct mmc_host_ops {
>> =A0 =A0 =A0 void =A0 =A0(*init_card)(struct mmc_host *host, struct m=
mc_card *card);
>>
>> =A0 =A0 =A0 int =A0 =A0 (*start_signal_voltage_switch)(struct mmc_ho=
st *host, struct mmc_ios *ios);
>> - =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc_host *host);
>> +
>> + =A0 =A0 /* The tuning command opcode value is different for SD and=
 eMMC cards */
>> + =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc_host *host, u32 o=
pcode);
>> =A0 =A0 =A0 void =A0 =A0(*enable_preset_value)(struct mmc_host *host=
, bool enable);
>> =A0 =A0 =A0 int =A0 =A0 (*select_drive_strength)(unsigned int max_dt=
r, int host_drv, int card_drv);
>> =A0 =A0 =A0 void =A0 =A0(*hw_reset)(struct mmc_host *host);
>> @@ -242,6 +247,10 @@ struct mmc_host {
>> =A0#define MMC_CAP2_CACHE_CTRL =A0(1 << 1) =A0 =A0 =A0 =A0/* Allow c=
ache control */
>> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0/* Notify powero=
ff supported */
>> =A0#define MMC_CAP2_NO_MULTI_READ =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0=
/* Multiblock reads don't work */
>> +#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0=
/* can support */
>> +#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =A0=
/* can support */
>> +#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_CAP2_HS200_=
1_8V_SDR | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP=
2_HS200_1_2V_SDR)
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 665548e..2c8cc69 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -51,6 +51,7 @@
>> =A0#define MMC_READ_SINGLE_BLOCK =A0 =A017 =A0 /* adtc [31:0] data a=
ddr =A0 R1 =A0*/
>> =A0#define MMC_READ_MULTIPLE_BLOCK =A018 =A0 /* adtc [31:0] data add=
r =A0 R1 =A0*/
>> =A0#define MMC_SEND_TUNING_BLOCK =A0 =A019 =A0 /* adtc =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>> +#define MMC_SEND_TUNING_BLOCK_HS200 =A021 =A0 =A0 =A0/* adtc R1 =A0=
*/
>>
>> =A0 =A0/* class 3 */
>> =A0#define MMC_WRITE_DAT_UNTIL_STOP 20 =A0 /* adtc [31:0] data addr =
=A0 R1 =A0*/
>> @@ -339,13 +340,76 @@ struct _mmc_csd {
>>
>> =A0#define EXT_CSD_CARD_TYPE_26 (1<<0) =A0/* Card can run at 26MHz *=
/
>> =A0#define EXT_CSD_CARD_TYPE_52 (1<<1) =A0/* Card can run at 52MHz *=
/
>> -#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0xF =A0 =A0 /* Mask out =
reserved bits */
>> +#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0x3F =A0 =A0/* Mask out =
reserved bits */
>> =A0#define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0 /* Card can run =
at 52MHz */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* DDR mode @1.8V or 3V I/O */
>> =A0#define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0 /* Card can run =
at 52MHz */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* DDR mode @1.2V I/O */
>> =A0#define EXT_CSD_CARD_TYPE_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_D=
DR_1_8V =A0\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V)
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V =A0 (1<<4) =A0/* Card can run at=
 200MHz */
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V =A0 (1<<5) =A0/* Card can run at=
 200MHz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 /* SDR mode @1.2V I/O */
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0(EXT_CSD_CARD_TYPE_SDR_1_8=
V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_SDR_1_2V)
>> +
>
> Normal kernel coding style is:
>

 Will update it as per feed back. I had taken above
EXT_CSD_CARD_TYPE_DDR_52 as reference.

> =A0#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0 =A0(EXT_CSD_CARD_TYPE_SD=
R_1_8V | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_CARD_TYPE_SDR_1_2V)
>
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL =A0 =A0(EXT_CSD_CARD_TYPE_SDR_200=
 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_2V_ALL =A0(EXT_CSD_CARD_=
TYPE_SDR_1_2V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_8V_ALL =A0(EXT_CSD_CARD_=
TYPE_SDR_1_8V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V =A0(EXT_CSD_CARD_TYPE_S=
DR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V =A0(EXT_CSD_CARD_TYPE_S=
DR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V =A0(EXT_CSD_CARD_TYPE_S=
DR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V =A0(EXT_CSD_CARD_TYPE_S=
DR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52 =A0 =A0(EXT_CSD_CARD_TYPE=
_SDR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52 =A0 =A0(EXT_CSD_CARD_TYPE=
_SDR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V =A0 (EXT_CSD_CARD_TYPE_S=
DR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V =A0 (EXT_CSD_CARD_TYPE_S=
DR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52 =A0 =A0 (EXT_CSD_CARD_TYPE=
_SDR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>>
>> =A0#define EXT_CSD_BUS_WIDTH_1 =A00 =A0 =A0 =A0 /* Card is in 1 bit =
mode */
>> =A0#define EXT_CSD_BUS_WIDTH_4 =A01 =A0 =A0 =A0 /* Card is in 4 bit =
mode */
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
