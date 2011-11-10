From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Thu, 10 Nov 2011 11:24:02 +0530
Message-ID: <CAGxe1ZHyZStX1_ZjRx+C3kMuLVhg3W2T8LM0zOoAQWeXVvFg3g@mail.gmail.com>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
	<4EB8FAD1.7010606@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4EB8FAD1.7010606@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 8 November 2011 15:18, Sahitya Tummala <stummala@codeaurora.org> wro=
te:
> Hi Girish,
>
> On 10/18/2011 10:35 AM, Girish K S wrote:
>>
>> This patch adds the support for power off notify feature, available =
in
>> eMMC 4.5 devices. If the the host has support for this feature, then=
 the
>> mmc core will notify it to the device by setting the
>> POWER_OFF_NOTIFICATION
>> byte in the extended csd register with a value 1(POWER_ON).
>>
>> For suspend mode short timeout is used, whereas for the normal power=
off
>> long
>> timeout is used.
>>
>> cc: Chris Ball<cjb@laptop.org>
>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>> ---
>> Changes in V9:
>> =A0 =A0 =A0 =A0Removed the macros not related with the PowerOff noti=
fy feature.
>> =A0 =A0 =A0 =A0The previous patch with commit id
>> =A0 =A0 =A0 =A0bd3151f6c55c553bed2c0df72792841457b75bb5 should be de=
leted before
>> =A0 =A0 =A0 =A0applying this patch.
>> Changes in V8:
>> =A0 =A0 =A0 =A0Updated with review comments of Chris Ball and rebase=
d to
>> =A0 =A0 =A0 =A0chris-mmc/mmc-next branch.
>> Changes in V7:
>> =A0 =A0 =A0 =A0Rebased to chris-mmc/mmc-next branch. merged to patch=
es to single
>> =A0 =A0 =A0 =A0patch.
>> Changes in V6:
>> =A0 =A0 =A0 =A0Fixes checkpatch errors. The patches are generated af=
ter rebasing
>> to
>> =A0 =A0 =A0 =A0 chris's mmc-next branch.
>> Changes in V5:
>> =A0 =A0 =A0 =A0This patch version fixes the problem with power off n=
otify
>> function,
>> =A0 =A0 =A0 =A0 when called for the first time and card is not yet i=
nitialised.
>> Changes in V4:
>> =A0 =A0 =A0 =A0Updated with review comments of Jeon
>> Changes in V2:
>> =A0 =A0 =A0 =A0Adds poweroff notification handling in suspend/normal=
=2E
>>
>> =A0drivers/mmc/core/core.c =A0| =A0 34 +++++++++++++++++++++++++++++=
+++++
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 23 +++++++++++++++++++++--
>> =A0drivers/mmc/host/sdhci.c | =A0 =A09 +++++++++
>> =A0include/linux/mmc/card.h | =A0 =A06 ++++++
>> =A0include/linux/mmc/host.h | =A0 =A05 +++++
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A06 ++++++
>> =A06 files changed, 81 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 61d7730..b1eca96 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1212,11 +1212,43 @@ static void mmc_power_up(struct mmc_host *ho=
st)
>>
>> =A0void mmc_power_off(struct mmc_host *host)
>> =A0{
>> + =A0 =A0 =A0 struct mmc_card *card;
>> + =A0 =A0 =A0 unsigned int notify_type;
>> + =A0 =A0 =A0 unsigned int timeout;
>> + =A0 =A0 =A0 int err;
>> +
>> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>>
>> + =A0 =A0 =A0 card =3D host->card;
>> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
>> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>>
>> + =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
>> + =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D=3D MMC_POWERED=
_ON) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC=
_HOST_PW_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.generic_cmd6_time;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.power_off_longtime;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_POWER_OFF_NOTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not=
ify_type, timeout);
>
> During suspend, the device can already be in sleep state (CMD5) befor=
e
> mmc_power_off()
> is called from mmc_suspend_host(). As per eMMC specification, when th=
e
> device is in sleep state,
> it can only respond to RESET commands (CMD0 with argument of either
> 0x00000000 or
> 0xF0F0F0F0 or H/W reset) and awake command (CMD5). =A0So, how does th=
is switch
> going
> to happen (CMD6) if it is in sleep state?
> Thanks Sahitya. Will handle the situation of sending the switch comma=
nd  in mmc_suspend_host function before the device goes to sleep.
> Thanks,
> Sahitya.
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
>
>
