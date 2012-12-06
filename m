From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
Date: Thu, 06 Dec 2012 11:52:41 +0530
Message-ID: <50C039B1.8030004@codeaurora.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org> <1354620980-23764-3-git-send-email-subhashj@codeaurora.org> <477F20668A386D41ADCC57781B1F70430D13A09A1A@SC-VEXCH1.marvell.com> <0C8FBB70FF40A94D98BE847F9C171A98033FE4EE@SCYBEXDAG04.amd.com> <477F20668A386D41ADCC57781B1F70430D13A09DC6@SC-VEXCH1.marvell.com> <0C8FBB70FF40A94D98BE847F9C171A98033FE94B@SCYBEXDAG04.amd.com> <477F20668A386D41ADCC57781B1F70430D13A09FAE@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430D13A09FAE@SC-VEXCH1.marvell.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: "Shen, Jackey" <Jackey.Shen@amd.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 12/6/2012 9:03 AM, Bing Zhao wrote:
> Hi Jackey,
>
>> Hi Bing,
>>
>> sdhci_add_host() reads host controller's capabilities and initialize host->caps of function
>> mmc_host_uhs(). So mmc_host_uhs() only return this cached values.
> So, it does represent host controller's capabilities, not the capabilities of the card.
> What happens if I have a UHS capable controller and a 2.0 card?
> The S18R bit will be set in this case, which might cause problem for the card?
Hi Bing,

Why do you see an issue with setting S18R bit when sending CMD5 to 
SDIO2.0 compliant card? If SDIO2.0 card don't support it, return OCR 
won't have the S18A bit set.
We are already doing same thing for SD cards as well (check 
mmc_sd_get_cid function). There also even if we set the S18R bit which 
sending OCR to non-SD3.0 cards, they respond back with S18A bit cleared.

If non-SDIO3.0 card misbehaves after receiving the OCR with S18R bit set 
then it means card is not compliant to specification properly and in 
that case those cards can be handled with QUIRKs. But there is no need 
to add any QUIRKs as of now.

I hope this make sense.

Regards,
Subhash

>
> Thanks,
> Bing
>
>> Thanks,
>> Jackey
>>
>> -----Original Message-----
>> From: Bing Zhao [mailto:bzhao@marvell.com]
>> Sent: Thursday, December 06, 2012 3:14 AM
>> To: Shen, Jackey; Subhash Jadavani; linux-mmc@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org; Sujit Reddy Thumma
>> Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
>>
>> Hi Jackey,
>>
>>> Hi Bing,
>>>
>>> The function mmc_host_uhs() will return false and never set bit[24] (S18R) for SDIO 2.0 cards.
>> I thought mmc_host_uhs() will return host controller's capabilities, no?
>>
>> Thanks,
>> Bing
>>
>>> Thanks,
>>> Jackey
>>>
>>> -----Original Message-----
>>> From: linux-mmc-owner@vger.kernel.org
>>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Bing Zhao
>>> Sent: Wednesday, December 05, 2012 5:14 AM
>>> To: Subhash Jadavani; linux-mmc@vger.kernel.org
>>> Cc: linux-arm-msm@vger.kernel.org; Sujit Reddy Thumma
>>> Subject: RE: [PATCH v1 2/3] mmc: sdio: Fix SDIO 3.0 UHS-I
>>> initialization sequence
>>>
>>> Hi,
>>>
>>>> From: Sujit Reddy Thumma <sthumma@codeaurora.org>
>>>>
>>>> According to UHS-I initialization sequence for SDIO 3.0 cards, the
>>>> host must set bit[24] (S18R) of OCR register during OCR handshake to
>>>> know whether the SDIO card is capable of doing 1.8V I/O.
>>> In SDIO 2.0 spec, bit[24] is reserved, "shall be set to 0".
>>> Setting it to 1 might cause side effect to 2.0 cards.
>>> Perhaps using a quirk for S18R is more suitable for all combinations.
>>>
>>> Regards,
>>> Bing
>>>
>>>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>> ---
>>>>   drivers/mmc/core/sdio.c  |   22 +++++++++++-----------
>>>>   include/linux/mmc/host.h |    8 ++++++++
>>>>   2 files changed, 19 insertions(+), 11 deletions(-)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
