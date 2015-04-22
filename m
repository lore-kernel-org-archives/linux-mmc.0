From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 07/10] brcmfmac: fix sdio suspend and resume
Date: Wed, 22 Apr 2015 11:38:01 +0200
Message-ID: <55376BF9.9050600@broadcom.com>
References: <1429035033-14076-1-git-send-email-arend@broadcom.com>	<1429035033-14076-8-git-send-email-arend@broadcom.com>	<CAPDyKFqGb81m9ExECL1ZCea8OuhekH+aWiXC=8zafnLN2T02Vw@mail.gmail.com>	<55376165.8030904@broadcom.com> <CAPDyKFqefO1L-UVEH9iyFgwsXtZG3ueH=Z-Vwx=56YSO0-uXgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:18094 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934349AbbDVJiE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 05:38:04 -0400
In-Reply-To: <CAPDyKFqefO1L-UVEH9iyFgwsXtZG3ueH=Z-Vwx=56YSO0-uXgQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 04/22/15 11:18, Ulf Hansson wrote:
> On 22 April 2015 at 10:52, Arend van Spriel<arend@broadcom.com>  wrote:
>> - wireless list/maintainer
>>
>>
>> On 04/22/15 09:32, Ulf Hansson wrote:
>>>
>>> On 14 April 2015 at 20:10, Arend van Spriel<arend@broadcom.com>   wrote:
>>>>
>>>> commit 330b4e4be937 ("brcmfmac: Add wowl support for SDIO devices.")
>>>> changed the behaviour by removing the MMC_PM_KEEP_POWER flag for
>>>> non-wowl scenario, which needs to be restored. Another necessary
>>>> change is to mark the card as being non-removable. With this in place
>>>> the suspend resume test passes successfully doing:
>>>>
>>>>    # echo devices>   /sys/power/pm_test
>>>>    # echo mem>   /sys/power/state
>>>>
>>>> Note that power may still be switched off when system is going
>>>> in S3 state.
>>>>
>>>> Reported-by: Fu, Zhonghui<<zhonghui.fu@linux.intel.com>
>>>> Reviewed-by: Pieter-Paul Giesberts<pieterpg@broadcom.com>
>>>> Reviewed-by: Franky (Zhenhui) Lin<frankyl@broadcom.com>
>>>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>>>> ---
>>>>    drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c | 18
>>>> +++++++++++++-----
>>>>    1 file changed, 13 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>>> b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>>> index 9b508bd..8a69544 100644
>>>> --- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>>> +++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
>>>> @@ -1011,6 +1011,14 @@ static int brcmf_sdiod_remove(struct
>>>> brcmf_sdio_dev *sdiodev)
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void brcmf_sdiod_host_fixup(struct mmc_host *host)
>>>> +{
>>>> +       /* runtime-pm powers off the device */
>>>> +       pm_runtime_forbid(host->parent);
>>>
>>>
>>> That you need this, clearly shows that something is broken in the mmc
>>> core/host layer.
>>
>>
>> This patch only moved this. The patch introducing this is here [1].
>
> OK, thanks for sharing the information!
>
>>
>>> Could you elaborate a bit on what configuration you are using. Like
>>> what mmc host, which SDIO bus speed mode.
>>
>>
>> Not just one. My test setup is a dev board hooked up to a card reader slot
>> using sdhci-pci driver. Another setup I have is a chromebook with our device
>> integrated with dw_mmc-rockchip driver. It is an arm platform with dt entry:
>>
>> &sdio0 {
>>          broken-cd;
>>          bus-width =<4>;
>>          cap-sd-highspeed;
>>          sd-uhs-sdr12;
>>          sd-uhs-sdr25;
>>          sd-uhs-sdr50;
>>          sd-uhs-sdr104;
>>          cap-sdio-irq;
>>          card-external-vcc-supply =<&wifi_regulator>;
>>          clocks =<&cru HCLK_SDIO0>,<&cru SCLK_SDIO0>,<&cru
>> SCLK_SDIO0_DRV>,
>>                   <&cru SCLK_SDIO0_SAMPLE>,<&rk808 RK808_CLKOUT1>;
>>          clock-names = "biu", "ciu", "ciu_drv", "ciu_sample",
>> "card_ext_clock";
>>          keep-power-in-suspend;
>>          non-removable;
>>          num-slots =<1>;
>>          default-sample-phase =<90>;
>>          pinctrl-names = "default";
>>          pinctrl-0 =<&sdio0_clk&sdio0_cmd&sdio0_bus4>;
>>          status = "okay";
>>          vmmc-supply =<&vcc33_sys>;
>>          vqmmc-supply =<&vcc18_wl>;
>> };
>>
>> I think card-external-vcc-supply is property that chromeos kernel handles to
>> power the device.
>
> Should then likely be moved in a mmc pwrseq node and handled by the
> mmc core, right?
>
> The same might apply to "card_ext_clock"!?

Guess so. I was not involved in these DT changes and my focus is more on 
upstream.

>>
>>> And have you tested different configurations? Like what happens if you
>>> use a different SDIO bus speed mode?
>
> In the dw_mmc case, the host controller driver doesn't implement
> runtime PM - only system PM (unless you are carrying some additional
> out of tree patch :-) ).
>
> So, are you sure the bug exists in this configuration at all?

Forgot to mention the most applicable setup. I also have a Sony Vaio Duo 
13 with wifi sdio chip integrated through sdhci-acpi driver, which is 
doing runtime-pm. I had a number of people contacting me and I had them 
disable runtime-pm through sysfs to get working wifi. That was the 
reason for adding pm_runtime_forbid() to brcmfmac driver.

Regards,
Arend
