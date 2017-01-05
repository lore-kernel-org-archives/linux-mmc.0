From: Ziyuan <xzy.xu@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix some coding style
Date: Thu, 5 Jan 2017 15:30:56 +0800
Message-ID: <586DF630.5070104@rock-chips.com>
References: <1483534376-6521-1-git-send-email-xzy.xu@rock-chips.com>
 <1483554741.21292.9.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483554741.21292.9.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 01/05/2017 02:32 AM, Joe Perches wrote:
> On Wed, 2017-01-04 at 20:52 +0800, Ziyuan Xu wrote:
>> Let's fix the warnings from checkpatch.pl:
>>
>> - line over 80 characters;
>> - block comments should align the * on each Lines;
>> - statements not starting on a tabstop.
>>
>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 33 +++++++++++++++++----------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> []
>> @@ -94,7 +94,8 @@ struct idmac_desc {
>>   
>>   	__le32		des1;	/* Buffer sizes */
>>   #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>> -	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
>> +	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | \
>> +	 (cpu_to_le32((s) & 0x1fff)))
> Please look to improve code rather than just shut up
> the brainless checkpatch script.
>
> If this is really valuable, it'd probably be better as
> an inline function, or as it's only used once, just
> as direct code in that one place.

Fine, I get it. Thanks for the advice.:-)

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
