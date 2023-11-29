Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBFA4DD
	for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2023 07:04:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470951FB;
	Wed, 29 Nov 2023 07:05:22 -0800 (PST)
Received: from [10.57.73.180] (unknown [10.57.73.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D2B3F73F;
	Wed, 29 Nov 2023 07:04:33 -0800 (PST)
Message-ID: <62f5d748-e817-43f2-b390-dd57ad6ad8d9@arm.com>
Date: Wed, 29 Nov 2023 15:04:31 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Content-Language: en-US
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, avri.altman@wdc.com
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, CLoehle@hyperstone.com,
 linux-mmc@vger.kernel.org
References: <20231129094350.2605322-1-jorge@foundries.io>
 <e159b627-22d4-489d-89a0-4de3be9af99b@arm.com> <ZWdNu5l8U++Z6h6t@trax>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZWdNu5l8U++Z6h6t@trax>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 14:42, Jorge Ramirez-Ortiz, Foundries wrote:
> On 29/11/23 10:32:41, Christian Loehle wrote:
>> On 29/11/2023 09:43, Jorge Ramirez-Ortiz wrote:
>>> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
>>> re-tune before switching to the RPMB partition would randomly cause
>>> subsequent RPMB requests to fail with EILSEQ:
>>> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
>>>
>>> This commit skips the retune when switching to RPMB.
>>> Tested over several days with per minute RPMB reads.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
>>> ---
>>>  drivers/mmc/core/block.c  | 6 +++++-
>>>  drivers/mmc/core/card.h   | 7 +++++++
>>>  drivers/mmc/core/quirks.h | 7 +++++++
>>>  include/linux/mmc/card.h  | 1 +
>>>  4 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index 152dfe593c43..9b7ba6562a3b 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>>>  				return ret;
>>>  		}
>>>  		mmc_retune_pause(card->host);
>>> +
>>> +		/* Do not force retune before RPMB switch */
>>> +		if (mmc_can_retune(card->host) &&
>>> +		    mmc_card_broken_rpmb_retune(card))
>>> +			card->host->need_retune = 0;
>>>  	}
>>
>> Is this just an issue for rpmb switches or did you try other non-rpmb
>> partition switches, too?
> 
> I only tried the reported failure case (ie, RPMB switch).This failure
> case came from a product verification team so I believe all the other
> scenarios should be functional - other than RPMB accesses (these tests
> started a few months ago), no other issues have been reported from eMMC
> validation in the last couple of years.
> 
> Is there some additional check/test you would like to see done? if so,
> please could you let me know how to trigger them?

That's fine with me, probably just a very interesting bug then.

> 
>> And only HS200 or that's just what you tested with?
> 
> Yes that is just the product configuration; so the only one I tested.
> 
> The host controller is sdhci-of-arasan for xlnx,zynqmp-8.9a. I inspected
> the driver history and auto-tuning was extended to support ZynqMP (DLL
> reset) some years ago so I believe tuning itself should be fine.
> 
> I am referring to commit 8d2e334377dbe645415fbe031711324bc2281907 "mmc:
> sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms "
> 
>>
>>>
>>>  	return ret;
>>> @@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);
>>>
>>>  MODULE_LICENSE("GPL");
>>>  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
>>> -
>>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>>> index b7754a1b8d97..1e1555a15de9 100644
>>> --- a/drivers/mmc/core/card.h
>>> +++ b/drivers/mmc/core/card.h
>>> @@ -85,6 +85,7 @@ struct mmc_fixup {
>>>  #define CID_MANFID_MICRON       0x13
>>>  #define CID_MANFID_SAMSUNG      0x15
>>>  #define CID_MANFID_APACER       0x27
> 
> I had to add another ID for SanDisk - maybe 0x45 is for Industrial
> controllers? do you know?

I don't have access to JEDEC internal docs anymore, but since Avri
probably wants to ACK this potential bug anyway, he should confirm.

