From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: Add poweroff notify handling feature
Date: Tue, 6 Sep 2011 13:49:37 +0530
Message-ID: <CAGxe1ZGU4k+2brPWKLWyGopCEYY0H2asz7Rp8gix0a8yG875AA@mail.gmail.com>
References: <1315223399-21599-1-git-send-email-girish.shivananjappa@linaro.org>
	<1315223399-21599-3-git-send-email-girish.shivananjappa@linaro.org>
	<CAH9JG2X-nZp0nfmmm93jCuknA56yFWDRYzSobDXFz6wHAea0rg@mail.gmail.com>
	<CAGxe1ZGyPCRHbYhk-7b9Aad76zbVaoORQcLZbu2MT5Yn05sxEQ@mail.gmail.com>
	<000301cc6c62$d55c42d0$8014c870$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000301cc6c62$d55c42d0$8014c870$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hello Mr Jeon,
i have modified the patch to handle the poweroff in suspend and normal
condition.
during suspend it is be short
and during normal poweroff it is long.

I will update the V2 patch with Mr Parks changes updated.
regards
Girish K S

On 6 September 2011 12:31, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Girish K S,
>
> I think short type is proper rather than long type by default.
> Long type seems to be unacceptable in suspend regarding long timeout.
> One question,
> Is this patch considered for system power off besides suspend?
>
> Beset regards,
> Seungwon Jeon.
>
> Girish K S wrote:
>
>> Hi Mr Park,
>>
>> On 5 September 2011 18:03, Kyungmin Park <kmpark@infradead.org> wrot=
e:
>> > Hi Girish,
>> >
>> > I think it's still incomplete, does power off short function is ca=
lled
>> > at suspend properly?
>> > there are some comments below.
>> >
>> > Thank you,
>> > Kyungmin Park
>> >
>> > On Mon, Sep 5, 2011 at 8:49 PM, Girish K S
>> > <girish.shivananjappa@linaro.org> wrote:
>> >> This patch adds the handling of the poweroff notify feature
>> >> during powerdown phase.
>> >>
>> >> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> >> ---
>> >> =A0drivers/mmc/core/core.c =A0| =A0 29 ++++++++++++++++++++++++++=
+++
>> >> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A03 +++
>> >> =A0drivers/mmc/host/sdhci.c | =A0 11 +++++++++++
>> >> =A0include/linux/mmc/card.h | =A0 29 +++++++++++++++++++++++++---=
-
>> >> =A0include/linux/mmc/host.h | =A0 =A07 +++++--
>> >> =A05 files changed, 73 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >> index a65e1ca..37b09d7 100644
>> >> --- a/drivers/mmc/core/core.c
>> >> +++ b/drivers/mmc/core/core.c
>> >> @@ -1130,9 +1130,38 @@ static void mmc_power_up(struct mmc_host *=
host)
>> >>
>> >> =A0static void mmc_power_off(struct mmc_host *host)
>> >> =A0{
>> >> + =A0 =A0 =A0 struct mmc_card *card =3D host->card;
>> >> + =A0 =A0 =A0 unsigned int notify_type;
>> >> + =A0 =A0 =A0 unsigned int timeout;
>> >> + =A0 =A0 =A0 int err;
>> >> +
>> >> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
>> >> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>> >>
>> >> + =A0 =A0 =A0 if (mmc_card_mmc(card) && mmc_card_powernotify_on(c=
ard)) {
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D =
MMC_POWEROFF_NOTIFY_SHORT)
>> {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT=
_CSD_POWER_OFF_SHORT;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->e=
xt_csd.generic_cmd6_time;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powern=
otify_short(card);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT=
_CSD_POWER_OFF_LONG;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->e=
xt_csd.power_off_longtime;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powern=
otify_long(card);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CM=
D_SET_NORMAL,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT=
_CSD_POWER_OFF_NOTIFICATION,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 not=
ify_type, timeout);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "De=
vice failed to respond "
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "within %d poweroff time."
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "forcefully powering down"
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "the device\n", timeout);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_off(card);
>> >> + =A0 =A0 =A0 }
>> >> =A0 =A0 =A0 =A0/*
>> >> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible volta=
ge supported
>> for
>> >> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next =
power up.
>> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> >> index 2f06b37..b369c6f 100644
>> >> --- a/drivers/mmc/core/mmc.c
>> >> +++ b/drivers/mmc/core/mmc.c
>> >> @@ -720,8 +720,11 @@ static int mmc_init_card(struct mmc_host *ho=
st,
>> u32 ocr,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_POWER_OFF_NOTIFICATION,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_POWER_ON,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ca=
rd->ext_csd.generic_cmd6_time);
>> >> +
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_on(card);
>> >> =A0 =A0 =A0 =A0}
>> >>
>> >> =A0 =A0 =A0 =A0/*
>> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> >> index 0e02cc1..a24a31b 100644
>> >> --- a/drivers/mmc/host/sdhci.c
>> >> +++ b/drivers/mmc/host/sdhci.c
>> >> @@ -2566,6 +2566,17 @@ int sdhci_add_host(struct sdhci_host *host=
)
>> >> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_DRIVER_TYPE_D)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_DRIVER_TYPE=
_D;
>> >>
>> >> + =A0 =A0 =A0 if (mmc->caps =3D=3D MMC_CAP_POWER_OFF_NOTIFY) {
>> > It should be if (mmc->caps & MMC_CAP_POWER_OFF_NOTIFY) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If Notify capability is enable=
d and
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* platform data is not initialis=
ed, set default to
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* long power off notify timeout =
value
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->power_notify_type =3D=3D M=
MC_POWEROFF_NOTIFY_NONE)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_t=
ype =3D MMC_POWEROFF_NOTIFY_LONG;
>> >> + =A0 =A0 =A0 } else {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_POWE=
ROFF_NOTIFY_NONE;
>> >> + =A0 =A0 =A0 }
>> > What's the goal of these statements?
>> =A0the goal of the statement is to set the notification type to a de=
fault
>> value.
>> if host doesnt have the capability then notification type is none.
>> If the host supports the capability and the notification type (wheth=
er
>> the short or long is not set), then default is long type.
>> >> =A0 =A0 =A0 =A0/* Initial value for re-tuning timer count */
>> >> =A0 =A0 =A0 =A0host->tuning_count =3D (caps[1] & SDHCI_RETUNING_T=
IMER_COUNT_MASK)
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_=
RETUNING_TIMER_COUNT_SHIFT;
>> >> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> >> index 2bf2843..d40b7b3 100644
>> >> --- a/include/linux/mmc/card.h
>> >> +++ b/include/linux/mmc/card.h
>> >> @@ -179,7 +179,12 @@ struct mmc_card {
>> >> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card=
 is in high speed
>> mode */
>> >> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* card is in
>> ultra high speed mode */
>> >> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0=
 =A0/* card is SDXC */
>> >> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0=
 =A0 =A0 /* card quirks */
>> >> + =A0 =A0 =A0 unsigned int =A0 =A0poweroff_notify_state;/*eMMC4.5=
 notify
>> feature =A0*/
>> >> +#define MMC_NO_POWER_NITOFICATION =A0 =A0 =A00
>> >> +#define MMC_POWERED_ON =A0 =A0 =A0 =A0 1
>> >> +#define MMC_POWEROFF_SHORT =A0 =A0 2
>> >> +#define MMC_POWEROFF_LONG =A0 =A0 =A03
>> >> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0=
 =A0 =A0 /* card quirks */
>> > Don't modify the meaning-less change
>> sorry my mistake.
>> >> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* =
allow SDIO FN0 writes
>> outside of the VS CCCR range */
>> >> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func-
>> >cur_blksize */
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* for byte mode */
>> >> @@ -192,9 +197,9 @@ struct mmc_card {
>> >> =A0#define MMC_QUIRK_BLK_NO_CMD23 (1<<7) =A0 =A0 =A0 =A0 =A0/* Av=
oid CMD23 for
>> regular multiblock */
>> >>
>> >> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0=
 =A0 /* erase size in sectors */
>> >> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0=
 =A0/* if erase unit is power
>> 2 */
>> >> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0pref_erase; =A0=
 =A0 /* in sectors */
>> >> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0erase=
d_byte; =A0 =A0/* value of erased bytes */
>> >> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0=
 =A0/* if erase unit is power
>> 2 */
>> >> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0pref_erase; =A0=
 =A0 /* in sectors */
>> >> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0erase=
d_byte; =A0 =A0/* value of erased bytes */
>> > ditto
>> >>
>> >> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_ci=
d[4]; =A0 =A0 /* raw card CID */
>> >> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raw_cs=
d[4]; =A0 =A0 /* raw card CSD */
>> >> @@ -325,6 +330,22 @@ static inline void __maybe_unused
>> remove_quirk(struct mmc_card *card, int data)
>> >> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTR=
AHIGHSPEED)
>> >> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD=
_SDXC)
>> >>
>> >> +#define mmc_card_powernotify_on(c) =A0 =A0 =A0 =A0 =A0 =A0 \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D =
MMC_POWERED_ON)
>> >> +#define mmc_card_powernotify_short(c) =A0\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D =
MMC_POWEROFF_SHORT)
>> >> +#define mmc_card_powernotify_long(c) =A0 \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D =
MMC_POWEROFF_LONG)
>> >> +
>> >> +#define mmc_card_set_powernotify_off(c) =A0 =A0 =A0 =A0\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC=
_NO_POWER_NITOFICATION)
>> > Typo, NOTIFICATION
>> >> +#define mmc_card_set_powernotify_on(c) \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC=
_POWERED_ON)
>> >> +#define mmc_card_set_powernotify_short(c) =A0 =A0 =A0\
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC=
_POWEROFF_SHORT)
>> >> +#define mmc_card_set_powernotify_long(c) =A0 =A0 =A0 \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC=
_POWEROFF_LONG)
>> > What's the purpose the these defines? it's not used at patches.
>> These macros have been used in the mmc_power_off function. Before
>> calling the mmc_switch command
>> in mmc_power_off its required to know whether the card has enabled t=
he
>> POWER_ON_NOTIFICATION byte
>> in the extended csd register. mmc_switch has to be called only if
>> POWER_ON_NOTIFICATION =3D=3D POWER_ON
>> so these macros have been defined to set the state variable in cards
>> context.
>> i will delete the remaining unused macros.
>> >> +
>> >> =A0/*
>> >> =A0* Quirk add/remove for MMC products.
>> >> =A0*/
>> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> >> index 21c85e1..354752a 100644
>> >> --- a/include/linux/mmc/host.h
>> >> +++ b/include/linux/mmc/host.h
>> >> @@ -229,10 +229,13 @@ struct mmc_host {
>> >> =A0#define MMC_CAP_MAX_CURRENT_600 =A0 =A0 =A0 =A0(1 << 28) =A0 =A0=
 =A0 /* Host max
>> current limit is 600mA */
>> >> =A0#define MMC_CAP_MAX_CURRENT_800 =A0 =A0 =A0 =A0(1 << 29) =A0 =A0=
 =A0 /* Host max
>> current limit is 800mA */
>> >> =A0#define MMC_CAP_CMD23 =A0 =A0 =A0 =A0 =A0(1 << 30) =A0 =A0 =A0=
 /* CMD23 supported. */
>> >> -#define MMC_CAP_POWER_OFF_NOTIFY =A0 =A0(1 << 31)/*NOtify powero=
ff
>> supported */
>> >> +#define MMC_CAP_POWER_OFF_NOTIFY =A0 =A0(1 << 31)/*Notify powero=
ff
>> supported */
>> > Please update the #1 patch first
>> sure
>> >>
>> >> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0=
 =A0 =A0/* supported pm features */
>> >> -
>> >> +#define MMC_POWEROFF_NOTIFY_NONE =A0 =A0 =A0 0
>> >> +#define MMC_POWEROFF_NOTIFY_SHORT =A0 =A0 =A01
>> >> +#define MMC_POWEROFF_NOTIFY_LONG =A0 =A0 =A0 2
>> > You already define the similar, please make one defines
>> ok will make the necessary change
>> >> +#define MMC_NO_POWER_NITOFICATION =A0 =A0 =A00
>> >> +#define MMC_POWERED_ON =A0 =A0 =A0 =A0 1
>> >> +#define MMC_POWEROFF_SHORT =A0 =A0 2
>> >> +#define MMC_POWEROFF_LONG =A0 =A0 =A03
>> >> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_notify_ty=
pe;
>> >> =A0#ifdef CONFIG_MMC_CLKGATE
>> >> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_re=
quests; =A0 /* internal reference
>> counter */
>> >> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_delay; =A0=
 =A0 =A0/* number of MCI clk hold
>> cycles */
>> >> --
>> >> 1.7.1
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >>
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
