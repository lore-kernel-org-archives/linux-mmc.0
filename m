From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V8] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Mon, 17 Oct 2011 10:34:58 +0530
Message-ID: <CAGxe1ZHgHMEzBq=eDiPUhPmQZSM33WGA9HLs_ejWnsxpLC1mTQ@mail.gmail.com>
References: <1318487656-8566-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2lisofsov.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2lisofsov.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 14 October 2011 03:41, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish, just trivial changes below.
>
> Does anyone have a Tested-by: to add to the patch?
No not yet.
>
> On Thu, Oct 13 2011, Girish K S wrote:
>> This patch adds the support for power off notify feature, available =
in
>> eMMC 4.5 devices. If the the host has support for this feature, then=
 the
>> mmc core will notify it to the device by setting the POWER_OFF_NOTIF=
ICATION
>> byte in the extended csd register with a value 1(POWER_ON).
>>
>> For suspend mode short timeout is used, whereas for the normal power=
off long
>> timeout is used.
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changes in V8:
>> =A0 =A0 =A0 Updated with review comments of Chris Ball and rebased t=
o
>> =A0 =A0 =A0 chris-mmc/mmc-next branch.
>> Changes in V7:
>> =A0 =A0 =A0 Rebased to chris-mmc/mmc-next branch. merged to patches
>> =A0 =A0 =A0 to single patch.
>> Changes in V6:
>> =A0 =A0 =A0 Fixes checkpatch errors. The patches are generated after
>> =A0 =A0 =A0 rebasing to chris's mmc-next branch.
>> Changes in V5:
>> =A0 =A0 =A0 This patch version fixes the problem with power off
>> =A0 =A0 =A0 notify function, when called for the first time and
>> =A0 =A0 =A0 card is not yet initialised.
>> Changes in V4:
>> =A0 =A0 =A0 Updated with review comments of Jeon
>> Changes in V2:
>> =A0 =A0 =A0 Adds poweroff notification handling in suspend/normal.
>>
>> =A0drivers/mmc/core/core.c =A0| =A0 36 +++++++++++++++++++++++++++++=
+++++++
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 23 +++++++++++++++++++++--
>> =A0drivers/mmc/host/sdhci.c | =A0 =A09 +++++++++
>> =A0include/linux/mmc/card.h | =A0 =A06 ++++++
>> =A0include/linux/mmc/host.h | =A0 =A06 ++++++
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A08 ++++++++
>> =A06 files changed, 86 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 61d7730..db368b2 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1212,11 +1212,45 @@ static void mmc_power_up(struct mmc_host *ho=
st)
>>
>> =A0void mmc_power_off(struct mmc_host *host)
>> =A0{
>> + =A0 =A0 struct mmc_card *card;
>
> struct mmc_card *card =3D host->card;
>
>> + =A0 =A0 unsigned int notify_type;
>> + =A0 =A0 unsigned int timeout;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 BUG_ON(!host);
>
> Not necessary.
OK
>
>> +
>> =A0 =A0 =A0 mmc_host_clk_hold(host);
>>
>> + =A0 =A0 card =3D host->card;
>> =A0 =A0 =A0 host->ios.clock =3D 0;
>> =A0 =A0 =A0 host->ios.vdd =3D 0;
>>
>> + =A0 =A0 if (card !=3D NULL && mmc_card_mmc(card) &&
>
> !=3D NULL is unnecessary.
This is required. Let me explain the scenario where i felt it is necess=
ary.

The card resource will be allocated when the delayed work is scheduled
i.e.(on invocation of the function mmc_rescan)
The call trace for card instance creation is given below in the called
sequence. mmc_rescan->mmc_rescan_try_freq->mmc_attach_mmc->mmc_init_car=
d.

Before the above card resource is allocated, the power_off function is
invoked in the  function mmc_start_host (invoked by the add_host)
At this point of time the card =3D=3D NULL and system crashes. So i che=
ck
for NULL first and then the card state.
>
>> + =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERED_ON=
)) {
>
> Extra set of parens unnecessary.
OK
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_HOS=
T_PW_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
generic_cmd6_time;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_stat=
e =3D MMC_POWEROFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
power_off_longtime;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_stat=
e =3D MMC_POWEROFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_POWER_OFF_NOTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_=
type, timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed to r=
espond within %d poweroff "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time. Forc=
efully powering down the device\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notification a=
fter the poweroff */
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO_POW=
ER_NOTIFICATION;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Reset ocr mask to be the highest possible voltage s=
upported for
>> =A0 =A0 =A0 =A0* this mmc host. This value will be used at next powe=
r up.
>> @@ -2208,6 +2242,7 @@ int mmc_pm_notify(struct notifier_block *notif=
y_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_SHORT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->detect);
>>
>> @@ -2231,6 +2266,7 @@ int mmc_pm_notify(struct notifier_block *notif=
y_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_LONG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, 0);
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 4e869d3..f8ea938 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -458,10 +458,12 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>>
>> - =A0 =A0 if (card->ext_csd.rev >=3D 6)
>> + =A0 =A0 if (card->ext_csd.rev >=3D 6) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 10 *
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_GENERIC_=
CMD6_TIME];
>> - =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.power_off_longtime =3D 10 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_POWER_OFF_=
LONG_TIME];
>> + =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 0;
>>
>> =A0out:
>> @@ -846,6 +848,23 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> + =A0 =A0 =A0* If the host supports the power_off_notify capability =
then
>> + =A0 =A0 =A0* set the notification byte in the ext_csd register of =
device
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if ((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) &&
>> + =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_NO_POWER_N=
OTIFICATION)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_POWER_OFF_NOTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_POWER_ON,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->e=
xt_csd.generic_cmd6_time);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_POWERE=
D_ON;
>> +
>> + =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Activate high speed (if supported)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2cc3ffa..91fdaed 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2739,6 +2739,15 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If Notify capability is enabled by the host, set noti=
fy to
>> + =A0 =A0 =A0* short power off notify timeout value.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_SHORT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_NONE;
>> +
>> =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>> =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIMER_C=
OUNT_MASK) >>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RETUNI=
NG_TIMER_COUNT_SHIFT;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 30d493c..fce88b3 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -54,6 +54,7 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* Units: ms */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0 =
=A0 =A0 =A0 =A0 /* Units: 100ns */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time; =A0=
 =A0 =A0/* Units: 10ms */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_off_longtime; =A0=
 =A0 /* Units: ms */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
>> @@ -209,6 +210,11 @@ struct mmc_card {
>> =A0#define MMC_QUIRK_BLK_NO_CMD23 =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0=
 =A0/* Avoid CMD23 for regular multiblock */
>> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) =A0 =A0 =A0 =A0/* A=
void sending 512 bytes in */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* byte mode */
>> + =A0 =A0 unsigned int =A0 =A0poweroff_notify_state; =A0/* eMMC4.5 n=
otify feature */
>> +#define MMC_NO_POWER_NOTIFICATION =A0 =A00
>> +#define MMC_POWERED_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
1
>> +#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 2
>> +#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A03
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0 =
/* erase size in sectors */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index aed5bc7..65c47fc 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -239,8 +239,14 @@ struct mmc_host {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0caps2; =A0 =A0 =A0 =A0=
 =A0/* More host capabilities */
>>
>> =A0#define MMC_CAP2_BOOTPART_NOACC =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0=
/* Boot partition no access */
>> +#define MMC_CAP2_CACHE_CTRL =A0(1 << 1) =A0 =A0 =A0 =A0/* Allow cac=
he control. */
>> +#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0/* Notify poweroff=
 supported */
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>
> You can align "power_notify_type" alongside "pm_caps" here.
OK
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
Thanks for the comments. please let me know if something wrong with my
above justification. Or any alternative for the same

regards
Girish K S
