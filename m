From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] Support SD UHS for hikey-mainline-rebase
Date: Wed, 20 Jul 2016 09:09:45 +0800
Message-ID: <1c131523-36c0-bcb8-f3e1-96bf27b5488c@rock-chips.com>
References: <CGME20160719075706epcas1p169dc5e5e0f7179f71f92a56e57e373c4@epcas1p1.samsung.com>
 <1468914713-63347-1-git-send-email-kid.jin@hisilicon.com>
 <578DE10D.3020401@samsung.com>
 <e7262e5d-a15c-8cb4-dc8b-c0e391f2a88b@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:44635 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbcGTBKL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2016 21:10:11 -0400
In-Reply-To: <e7262e5d-a15c-8cb4-dc8b-c0e391f2a88b@hisilicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jinguojun <kid.jin@hisilicon.com>, Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, arnd@arndb.de, rmk+kernel@arm.linux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linuxarm@huawei.com, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, CPGS <cpgs@samsung.com>
Cc: shawn.lin@rock-chips.com

=E5=9C=A8 2016/7/19 20:28, Jinguojun =E5=86=99=E9=81=93:
>
>
> On 2016/7/19 16:13, Jaehoon Chung wrote:
>> Hi,
>>
>> Removed the unnecessary CC'd.
>>
>> On 07/19/2016 04:51 PM, Jin Guojun wrote:
>>> From: j00226943 <j00226943@notesmail.huawei.com>
>>
>> What is j00226943?
>>
>> When you send the patch for dw_mmc controller, plz use the prefix "m=
mc: dw_mmc: ".
>>
>>>
>>> Two more changes:
>>>
>>> Before we send cmd,we need to set CMD bit29 to
>>> 1 so that CMD and DATA sent to card through the HOLD Register,
>>> This is the explication in synosys host:To meet the relatively
>>> high Input Hold Time requirement for SDR12, SDR25, and other MMC
>>> speed modes, you should program bit[29]use_hold_Reg of the CMD
>>> register to 1'b1; the output data is then registered again in the
>>> cclk_in_drv domain by using the Hold Register as shown in Path B
>>> of Figure 10-8. However, for the higher speed modes of SDR104, SDR5=
0
>>> and DDR50, you can meet the much smaller Input Hold Time requiremen=
t
>>> of 0.8ns by bypassing the Hold Register (Path A in Figure 10-8,
>>> programming CMD.use_hold_reg =3D 1'b0) and then adding delay elemen=
ts
>>> on the output path as indicated
>>>
>>> We have no tuning function in our drivers,so we must do the
>>> Function piling when we init UHS card.
>
> 1.For hikey we cant support UHS for SD card in https://github.com/96b=
oards-hikey/linux/tree/hikey-mainline-rebase
> 2.I have no SDMMC_CMD_USE_HOLD_REG in Dw_mmc-k3.c
>
>>
>> Sorry..this patch is NACK.
>> SDMMC_CMD_USE_HOLD_REG is already used by default in dw_mmc.c
>> Which kernel version did you use?
>>
>>>
>>> Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc-k3.c | 6 ++++++
>>>  drivers/mmc/host/dw_mmc.c    | 2 ++
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc=
-k3.c
>>> index 63c2e2e..2cbfcc7 100644
>>> --- a/drivers/mmc/host/dw_mmc-k3.c
>>> +++ b/drivers/mmc/host/dw_mmc-k3.c
>>> @@ -125,10 +125,16 @@ static void dw_mci_hi6220_set_ios(struct dw_m=
ci *host, struct mmc_ios *ios)
>>>  	host->bus_hz =3D clk_get_rate(host->biu_clk);
>>>  }
>>>
>>> +static void dw_mci_hi6220_prepare_command(struct dw_mci *host, u32=
 *cmdr)
>>> +{
>>> +	*cmdr |=3D SDMMC_CMD_USE_HOLD_REG;
>>> +}
>>> +
>>>  static const struct dw_mci_drv_data hi6220_data =3D {
>>>  	.switch_voltage		=3D dw_mci_hi6220_switch_voltage,
>>>  	.set_ios		=3D dw_mci_hi6220_set_ios,
>>>  	.parse_dt		=3D dw_mci_hi6220_parse_dt,
>>> +	.prepare_command        =3D dw_mci_hi6220_prepare_command,
>>>  };
> Hi,thank you for your review
>
> 1.We do the prepare_command in dw_mci_prepare_command before we send =
CMD in dw_mmc.c

please clone Ulf's tree[0] and rebase your any patches on its next
branch, thanks.


[0] git://git.linaro.org/people/ulf.hansson/mmc

> 2.I can find the same drivers in dw_mmc-exynos.c
> 3.For hikey we do the initialization from Dw_mmc-k3.c,so I need to do=
 the prepare_command in hi6220 drivers
>
>>
>> There is no "prepare_command" hooks.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>>  static const struct of_device_id dw_mci_k3_match[] =3D {
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 9dd1bd3..047e116 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1564,6 +1564,8 @@ static int dw_mci_execute_tuning(struct mmc_h=
ost *mmc, u32 opcode)
>>>
>>>  	if (drv_data && drv_data->execute_tuning)
>>>  		err =3D drv_data->execute_tuning(slot, opcode);
>>> +	else
>>> +		err =3D 0;
>>>  	return err;
>>>  }
>>>
>>>
>>
>>
>> .
>>
>
>
>
>


--=20
Best Regards
Shawn Lin

