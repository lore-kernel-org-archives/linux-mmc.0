From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V7 1/2] mmc: core: HS200 mode support for eMMC 4.5
Date: Wed, 21 Dec 2011 14:28:55 +0530
Message-ID: <CAGxe1ZEVadh+OrRFiBPs0tB=qzaszcoCnJm+0Log432g3kk4mw@mail.gmail.com>
References: <1324440779-27843-1-git-send-email-girish.shivananjappa@linaro.org>
	<1324440779-27843-2-git-send-email-girish.shivananjappa@linaro.org>
	<09D55472-5E87-4B84-BA4C-8FD26DCD7AE0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <09D55472-5E87-4B84-BA4C-8FD26DCD7AE0@marvell.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 21 December 2011 10:29, Philip Rakity <prakity@marvell.com> wrote:
>
> On Dec 20, 2011, at 8:12 PM, Girish K S wrote:
>
>> This patch adds the support of the HS200 bus speed for eMMC 4.5 devi=
ces.
>> The eMMC 4.5 devices have support for 200MHz bus speed. The function
>> prototype of the tuning function is modified to handle the tuning co=
mmand
>> number which is different in sd and mmc case.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> drivers/mmc/core/bus.c =A0 =A0 | =A0 =A03 +-
>> drivers/mmc/core/debugfs.c | =A0 =A03 +
>> drivers/mmc/core/mmc.c =A0 =A0 | =A0142 ++++++++++++++++++++++++++++=
+++++++++++++---
>> drivers/mmc/core/sd.c =A0 =A0 =A0| =A0 =A03 +-
>> drivers/mmc/core/sdio.c =A0 =A0| =A0 =A04 +-
>> include/linux/mmc/card.h =A0 | =A0 =A03 +
>> include/linux/mmc/mmc.h =A0 =A0| =A0 66 ++++++++++++++++++++-
>> 7 files changed, 211 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index f8a228a..5d011a3 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -303,10 +303,11 @@ int mmc_add_card(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(car=
d) ? "DDR " : "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type);
>> =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s card =
at address %04x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: new %s%s%s%s card at addr=
ess %04x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->ho=
st),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_uhs(card) ? =
"ultra high speed " :
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(mmc_card_highspeed(c=
ard) ? "high speed " : ""),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) =
? "HS200 " : ""),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(car=
d) ? "DDR " : "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type, card->rca);
>> =A0 =A0 =A0 =A0}
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 027615d..9ab5b17 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void=
 *data)
>> =A0 =A0 =A0 =A0case MMC_TIMING_UHS_DDR50:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str =3D "sd uhs DDR50";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 case MMC_TIMING_MMC_HS200:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D "mmc high-speed SDR200";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str =3D "invalid";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f0a9f1f..4de3416 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -286,6 +286,27 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_=
TYPE];
>> =A0 =A0 =A0 =A0switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYP=
E_MASK) {
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_SDR_200;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_SDR_1_2V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_SDR_1_8V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 =
|
>> =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_CARD_TYPE_26:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hs_max_dtr =3D 52000000=
;
>> @@ -700,6 +721,58 @@ static int mmc_select_powerclass(struct mmc_car=
d *card,
>> }
>>
>> /*
>> + * Selects the desired buswidth and switch to the HS200 mode
>> + * if bus width set without error
>> + */
>> +static int mmc_select_hs200(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 int err =3D 0;
>> + =A0 =A0 =A0 struct mmc_host *host;
>> + =A0 =A0 =A0 u32 bus_width =3D MMC_BUS_WIDTH_4;
>> +
>> + =A0 =A0 =A0 BUG_ON(!card);
>> +
>> + =A0 =A0 =A0 host =3D card->host;
>> +
>> + =A0 =A0 =A0 if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1=
_2V)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->caps2 & MMC_CAP2_HS200_1_2V_=
SDR))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_voltage(host, M=
MC_SIGNAL_VOLTAGE_120, 0);
>
> if 1.2 volt is not supported should one try 1.8v signaling ?
>
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Host is capable of 8bit transfer, then switch
>> + =A0 =A0 =A0 =A0* the device to work in 8bit transfer mode. If the
>> + =A0 =A0 =A0 =A0* mmc switch command returns error then switch to
>> + =A0 =A0 =A0 =A0* 4bit transfer mode. On success set the correspond=
ing
>> + =A0 =A0 =A0 =A0* bus width on the host.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (!err && host->caps & MMC_CAP_8_BIT_DATA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_BUS_WIDTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_BUS_WIDTH_8,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0car=
d->ext_csd.generic_cmd6_time);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D MMC_BUS_WIDTH_8;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* If the 8bit mode fails switch to 4 bit mode */
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_BUS_WIDTH,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_BUS_WIDTH_4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0car=
d->ext_csd.generic_cmd6_time);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D MMC_BUS_WIDTH_4;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* switch to HS200 mode if bus width set successfully =
*/
>> + =A0 =A0 =A0 if (!err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->host, bus_widt=
h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_HS_TIMING, 2, 0);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>
>
> The fact the switch does not report an error does not mean the card s=
upports 8 bit or even 4 bit data.
> One needs to either run CMD19 to test the bus width or try to read th=
e
> ext_csd data (or its equivalent) to determine the bus width supported=
 works.
>
After setting the bus width, CMD21(MMC) equivalent to CMD19(SD) is
executed.  Are you mentioning CMD19 of MMC

> The best example of this is mmc card that does NOT bring out all the =
pins. =A0Some manufactures have
> done this in the past. =A0This is the reason when the bus test is nee=
ded.
>
>
>> +
>> +/*
>> =A0* Handle the detection and initialisation of a card.
>> =A0*
>> =A0* In the case of a resume, "oldcard" will contain the card
>> @@ -905,11 +978,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps & MMC_CAP_MMC_HIGHSPEED)) =
{
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_HS_TIMING, 1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0car=
d->ext_csd.generic_cmd6_time);
>> + =A0 =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr > 520000=
00) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_HS200)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_hs2=
00(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (host->caps & MMC_CAP_MMC_HIGH=
SPEED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_HS_TIMING, 1, 0);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>>
>> @@ -918,8 +995,15 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host=
name(card->host));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed=
(card);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->h=
ost, MMC_TIMING_MMC_HS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_=
max_dtr > 52000000) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 &=
 MMC_CAP2_HS200)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_hs200(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_timing(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0MMC_TIMING_MMC_HS200);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_highspeed(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_timing(card->host, MMC_TIMING_MMC_HS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0}
>>
>> @@ -944,7 +1028,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0max_dtr =3D (unsigned int)-1;
>>
>> - =A0 =A0 =A0 if (mmc_card_highspeed(card)) {
>> + =A0 =A0 =A0 if (mmc_card_highspeed(card) || mmc_card_hs200(card)) =
{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (max_dtr > card->ext_csd.hs_max_dt=
r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_dtr =3D card->ext=
_csd.hs_max_dtr;
>> =A0 =A0 =A0 =A0} else if (max_dtr > card->csd.max_dtr) {
>> @@ -970,9 +1054,49 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0 =A0* Indicate HS200 SDR mode (if supported).
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_card_hs200(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ext_csd_bits;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 bus_width =3D card->host->ios.bus_=
width;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For devices supporting HS200 mode=
, the bus width has
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to be set before executing the tu=
ning function. If
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* set before tuning, then device wi=
ll respond with CRC
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* errors for responses on CMD line.=
 So for HS200 the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequence will be
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1. set bus width 4bit / 8 bit (1 =
bit not supported)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 2. switch to HS200 mode
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 3. set the clock to > 52Mhz <=3D2=
00MHz and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 4. execute tuning for HS200
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_HS200) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tunin=
g)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->op=
s->execute_tuning(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_SEND_TUNING_BLOCK_HS200);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("tuning exe=
cution failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bits =3D (bus_width =3D=3D MMC=
_BUS_WIDTH_8) ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH_8 :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH_4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_powerclass(card, ex=
t_csd_bits, ext_csd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power clas=
s selection to bus width"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%d fai=
led\n", mmc_hostname(card->host),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 << bu=
s_width);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Activate wide bus and DDR (if supported).
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>> + =A0 =A0 =A0 if (!mmc_card_hs200(card) &&
>> + =A0 =A0 =A0 =A0 =A0 (card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) &&
>> =A0 =A0 =A0 =A0 =A0 =A0(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8=
_BIT_DATA))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static unsigned ext_csd_bits[][2] =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ EXT_CSD_BUS_WIDTH_8=
, EXT_CSD_DDR_BUS_WIDTH_8 },
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 6f27d35..a775131 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -661,7 +661,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card =
*card)
>>
>> =A0 =A0 =A0 =A0/* SPI mode doesn't define CMD19 */
>> =A0 =A0 =A0 =A0if (!mmc_host_is_spi(card->host) && card->host->ops->=
execute_tuning)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tunin=
g(card->host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tunin=
g(card->host, =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK);
>>
>> out:
>> =A0 =A0 =A0 =A0kfree(status);
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index b77f770..bd7bacc 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -14,6 +14,7 @@
>>
>> #include <linux/mmc/host.h>
>> #include <linux/mmc/card.h>
>> +#include <linux/mmc/mmc.h>
>> #include <linux/mmc/sdio.h>
>> #include <linux/mmc/sdio_func.h>
>> #include <linux/mmc/sdio_ids.h>
>> @@ -556,7 +557,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_car=
d *card)
>>
>> =A0 =A0 =A0 =A0/* Initialize and start re-tuning timer */
>> =A0 =A0 =A0 =A0if (!mmc_host_is_spi(card->host) && card->host->ops->=
execute_tuning)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tunin=
g(card->host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tunin=
g(card->host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK);
>>
>> out:
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 9478a6b..9f22ba5 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -216,6 +216,7 @@ struct mmc_card {
>> #define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* card is in ultra high speed mode */
>> #define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0/=
* card is SDXC */
>> #define MMC_CARD_REMOVED =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* ca=
rd has been removed */
>> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =A0=
 =A0/* card is in HS200 mode */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
>> #define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allow =
SDIO FN0 writes outside of the VS CCCR range */
>> #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_bl=
ksize */
>> @@ -374,6 +375,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> #define mmc_card_present(c) =A0 =A0((c)->state & MMC_STATE_PRESENT)
>> #define mmc_card_readonly(c) =A0 ((c)->state & MMC_STATE_READONLY)
>> #define mmc_card_highspeed(c) =A0((c)->state & MMC_STATE_HIGHSPEED)
>> +#define mmc_card_hs200(c) =A0 =A0 =A0((c)->state & MMC_STATE_HIGHSP=
EED_200)
>> #define mmc_card_blockaddr(c) =A0((c)->state & MMC_STATE_BLOCKADDR)
>> #define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSPEED_D=
DR)
>> #define mmc_card_uhs(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->state &=
 MMC_STATE_ULTRAHIGHSPEED)
>> @@ -384,6 +386,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> #define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MMC_=
STATE_PRESENT)
>> #define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READONLY=
)
>> #define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGHSPE=
ED)
>> +#define mmc_card_set_hs200(c) =A0((c)->state |=3D MMC_STATE_HIGHSPE=
ED_200)
>> #define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOCKAD=
DR)
>> #define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSPEE=
D_DDR)
>> #define mmc_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIGHSPEE=
D)
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 665548e..2c8cc69 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -51,6 +51,7 @@
>> #define MMC_READ_SINGLE_BLOCK =A0 =A017 =A0 /* adtc [31:0] data addr=
 =A0 R1 =A0*/
>> #define MMC_READ_MULTIPLE_BLOCK =A018 =A0 /* adtc [31:0] data addr =A0=
 R1 =A0*/
>> #define MMC_SEND_TUNING_BLOCK =A0 =A019 =A0 /* adtc =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
>> +#define MMC_SEND_TUNING_BLOCK_HS200 =A0 =A021 =A0 =A0 =A0/* adtc R1=
 =A0*/
>>
>> =A0 /* class 3 */
>> #define MMC_WRITE_DAT_UNTIL_STOP 20 =A0 /* adtc [31:0] data addr =A0=
 R1 =A0*/
>> @@ -339,13 +340,76 @@ struct _mmc_csd {
>>
>> #define EXT_CSD_CARD_TYPE_26 =A0 (1<<0) =A0/* Card can run at 26MHz =
*/
>> #define EXT_CSD_CARD_TYPE_52 =A0 (1<<1) =A0/* Card can run at 52MHz =
*/
>> -#define EXT_CSD_CARD_TYPE_MASK 0xF =A0 =A0 /* Mask out reserved bit=
s */
>> +#define EXT_CSD_CARD_TYPE_MASK 0x3F =A0 =A0/* Mask out reserved bit=
s */
>> #define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0 /* Card can run at =
52MHz */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 /* DDR mode @1.8V or 3V I/O */
>> #define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0 /* Card can run at =
52MHz */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 /* DDR mode @1.2V I/O */
>> #define EXT_CSD_CARD_TYPE_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_DDR_=
1_8V =A0\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| EXT_CSD_CARD_TYPE_DDR_1_2V)
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V =A0 =A0 (1<<4) =A0/* Card can ru=
n at 200MHz */
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V =A0 =A0 (1<<5) =A0/* Card can ru=
n at 200MHz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* SDR mode @1.2V I/O */
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0 =A0(EXT_CSD_CARD_TYPE_SDR=
_1_8V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_SDR_1_2V)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL =A0 =A0 =A0(EXT_CSD_CARD_TYPE_SDR=
_200 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_2V_ALL =A0(EXT_CSD_C=
ARD_TYPE_SDR_1_2V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_8V_ALL =A0(EXT_CSD_C=
ARD_TYPE_SDR_1_8V =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V =A0 =A0(EXT_CSD_CARD_TY=
PE_SDR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V =A0 =A0(EXT_CSD_CARD_TY=
PE_SDR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V =A0 =A0(EXT_CSD_CARD_TY=
PE_SDR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V =A0 =A0(EXT_CSD_CARD_TY=
PE_SDR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52 =A0 =A0 =A0(EXT_CSD_CARD_=
TYPE_SDR_1_2V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52 =A0 =A0 =A0(EXT_CSD_CARD_=
TYPE_SDR_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V =A0 =A0 (EXT_CSD_CARD_TY=
PE_SDR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_8V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V =A0 =A0 (EXT_CSD_CARD_TY=
PE_SDR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>> +
>> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_=
TYPE_SDR_200 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_52 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_26)
>>
>> #define EXT_CSD_BUS_WIDTH_1 =A0 =A00 =A0 =A0 =A0 /* Card is in 1 bit=
 mode */
>> #define EXT_CSD_BUS_WIDTH_4 =A0 =A01 =A0 =A0 =A0 /* Card is in 4 bit=
 mode */
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
