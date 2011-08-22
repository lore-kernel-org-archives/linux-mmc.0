From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: Re: [PATCH v1 1/1] mmc: sd: Handle SD3.0 cards not supporting
     UHS-I bus speed mode
Date: Mon, 22 Aug 2011 02:44:39 -0700 (PDT)
Message-ID: <3f99dd036fb7c56c252e1dd27ccc965a.squirrel@www.codeaurora.org>
References: <1312955161-24844-1-git-send-email-subhashj@codeaurora.org>
    <m2k4ajpran.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <m2k4ajpran.fsf@bob.laptop.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Nath, Arindam" <arindam.nath@amd.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

> Hi Subhash, Arindam,
>
> On Wed, Aug 10 2011, Subhash Jadavani wrote:
>> Here is Essential conditions to indicate Version 3.00 Card
>> (SD_SPEC=2 and SD_SPEC3=1) :
>> (1) The card shall support CMD6
>> (2) The card shall support CMD8
>> (3) The card shall support CMD42
>> (4) User area capacity shall be up to 2GB (SDSC) or 32GB (SDHC)
>>     User area capacity shall be more than or equal to 32GB and
>>     up to 2TB (SDXC)
>> (5) Speed Class shall be supported (SDHC or SDXC)
>>
>> So even if SD card doesn't support any of the newly defined
>> UHS-I bus speed mode, it can advertise itself as SD3.0 cards
>> as long as it supports all the essential conditions of
>> SD3.0 cards. Given this, these type of cards should atleast
>> run in High Speed mode @50MHZ if it supports HS.
>>
>> But current initialization sequence for SD3.0 cards is
>> such that these non-UHS-I SD3.0 cards runs in Default
>> Speed mode @25MHz.
>>
>> This patch makes sure that these non-UHS-I SD3.0 cards run
>> in High Speed Mode @50MHz.
>>
>> Tested this patch with SanDisk Extreme SDHC 8GB Class 10 card.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> ---
>>  drivers/mmc/core/sd.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index ff27741..e2dcf23 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -306,6 +306,9 @@ static int mmc_read_switch(struct mmc_card *card)
>>  		goto out;
>>  	}
>>
>> +	if (status[13] & 0x02)
>> +		card->sw_caps.hs_max_dtr = 50000000;
>> +
>>  	if (card->scr.sda_spec3) {
>>  		card->sw_caps.sd3_bus_mode = status[13];
>>
>> @@ -348,9 +351,6 @@ static int mmc_read_switch(struct mmc_card *card)
>>  		}
>>
>>  		card->sw_caps.sd3_curr_limit = status[7];
>> -	} else {
>> -		if (status[13] & 0x02)
>> -			card->sw_caps.hs_max_dtr = 50000000;
>>  	}
>>
>>  out:
>
> The patch itself is fine, but please could one of you add some #defines
> for the status response bit names and their possible values inside
> mmc_read_switch()?  It's looking a bit opaque.
>
> (I know that this patch doesn't introduce any of these magic numbers;
> I just think that now is a good time to add documentation for them.)

For UHS-I bus speed modes,we already have macros for bus speed modes under
include/linux/mmc/card.h:
#define UHS_SDR12_BUS_SPEED     0
#define UHS_SDR25_BUS_SPEED     1
#define UHS_SDR50_BUS_SPEED     2
#define UHS_SDR104_BUS_SPEED    3
#define UHS_DDR50_BUS_SPEED     4

There are only 2 non-uhs-i bus speed mode options:
      high speed and default speed.

So,
status[13] = 2 => High speed mode
status[13] = 1 => Default speed mode

If you want, i can add 2 more macros for HS and DS modes. Do you want me
to define these macros within mmc_read_switch() or under sd_switch_caps
struct in include/linux/mmc/card.h file?

Regards,
Subhash


>
> Thanks very much,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
>


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
