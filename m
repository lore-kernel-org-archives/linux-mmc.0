From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: core: Fix voltage select in DDR mode
Date: Mon, 19 Dec 2011 09:19:33 -0800
Message-ID: <4B285605-295A-4C43-A60D-777C5D6EA4CB@marvell.com>
References: <1323950262-2160-1-git-send-email-girish.shivananjappa@linaro.org>
 <000001ccbb4b$e65ce250$b316a6f0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000001ccbb4b$e65ce250$b316a6f0$@org>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Arindam Nath <arindam.nath@amd.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org


On Dec 15, 2011, at 9:06 AM, Subhash Jadavani wrote:

> 
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Girish K S
>> Sent: Thursday, December 15, 2011 5:28 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org; Girish K S;
>> Philip Rakity; Arindam Nath; Chris Ball
>> Subject: [PATCH] mmc: core: Fix voltage select in DDR mode
>> 
>> This patch fixes the wrong comparison before setting the interface
>> voltage in DDR mode.
>> 
>> The assignment to the variable ddr before comaprison is either
>> ddr = MMC_1_2V_DDR_MODE; or ddr == MMC_1_8V_DDR_MODE. But the
>> comparison
>> is done wth the extended csd value if (ddr ==
>> EXT_CSD_CARD_TYPE_DDR_1_2V)
>> 
>> cc: Philip Rakity <prakity@marvell.com>
>> cc: Arindam Nath <arindam.nath@amd.com>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> drivers/mmc/core/mmc.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 006e932..f0a9f1f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1058,7 +1058,7 @@ static int mmc_init_card(struct mmc_host *host,
>> u32 ocr,
>> 			 *
>> 			 * WARNING: eMMC rules are NOT the same as SD DDR
>> 			 */
>> -			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
>> +			if (ddr == MMC_1_2V_DDR_MODE) {
> 
> Looks fine. 
> Acked-by: Subhash Jadavani <subhashj@codeaurora.org>

Acked-by: Philip Rakity <prakity@marvell.com>

NOTE:  standard sdhci controller (version 3.0) does not support 1.2v signaling.

> 
>> 				err = mmc_set_signal_voltage(host,
>> 					MMC_SIGNAL_VOLTAGE_120, 0);
>> 				if (err)
>> --
>> 1.7.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
