Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9DE13AE2
	for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375231; cv=none; b=mfB0AhfzXRp3f9mLfhwPO065eBPqArKuyHgATHL3H5CcnBuCiv0AARThfW4vv8Cwr1I0xsv4zyEvV3fdZ8rWvd6Wku5+SI90iR2xJ7K+waxb2uqFtvLGiQLq/O+zjR/jvPfInPsnmgikoKM4FDrYSWhrjkFfhyuh0GqGbrYY3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375231; c=relaxed/simple;
	bh=GGMaTm9f389aHXQG7hfMxnjoPUkhIhLc2CSshWQ7P6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKD1UvHck7zQ5BfmrHBcC58mEuINaTtt9hbErc8XKZlaHpCNl287cYgzeW3B7/AyAF837FGGywfPFhN62gmoJaSQ0lyGAXOcqen+BJXvjF23VdERvG2kC+TAEmICQ9nAzdkzFisJ9z4CALuvUmiqISwx1OAoa0KumT/v7qXntp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MTpFQ5Tk; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MTpFQ5Tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=aIdng4Q8edw7b3LWlDAaMv5+R35hrdLK29tfJJWLdZE=;
	b=MTpFQ5TkYhaJsY+UwWrea6UiOfiQK/u/ogFXrfV4nQIB4H4AUKGDGStlX9mVEg
	4tlr2/XRBh4zI4jdLciufjRfDNGohtlh+oGEyxjUR9Mah76JLjqko6g5lTIx0/Kg
	S5CTlUuLXs8Zfst2KqpK6I+u8RsIDc+cfuV7ijPkTlXG4=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3Py7zSS9mHF5DBg--.2502S2;
	Mon, 29 Apr 2024 15:19:17 +0800 (CST)
Message-ID: <34190ce8-622c-4dd7-9686-1d53b1a343ce@126.com>
Date: Mon, 29 Apr 2024 15:19:16 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
Content-Language: en-GB
To: Dragan Simic <dsimic@manjaro.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 Avri Altman <avri.altman@wdc.com>
References: <20240429063847.162247-1-xiaokeqinhealth@126.com>
 <a8d9ed3ae3b6d884235594e31baa28ff@manjaro.org>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <a8d9ed3ae3b6d884235594e31baa28ff@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Py7zSS9mHF5DBg--.2502S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW8CFW8ur47uF4kKF1Dtrb_yoW8AryxpF
	40gFyYkr48AF45Ca47X3Z09FySqw1qkFWjkFWrXw1YvrsxWryrWr4a9F1Y9F9rZw4DuFy2
	vFnFqw1UWas8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j04E_UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbi6BfP1WVLbGixXgAAsg

Hi Dragan,

On 2024/4/29 15:09, Dragan Simic wrote:
> Hello Felix,
> 
> On 2024-04-29 08:38, Felix Qin wrote:
>> Extensive testing has shown that some specific SD cards require an
>> increased command timeout to be successfully initialized.
>>
>> More info:
>> Platform: Rockchip SoC + DW Multimedia host Controller
>> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
>> Note: The SD card is custom-made by the customer in collaboration
>> with the wafer foundry.
>>
>> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>
>> Acked-by: Avri Altman <avri.altman@wdc.com>
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Huh, the v3 looks nowhere like the v2, so please consider
> my Reviewed-by tag revoked until I get some time to check what
> actually happened to the patch.
I apologize for the inconvenience caused, and I will resend the patch.
> 
>> ---
>> v2: Add more info
>> v3: Based on the __mmc_poll_for_busy API for modification
>> ---
>>  drivers/mmc/core/sd_ops.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>> index 3ce1ff336826..a1c028303ba7 100644
>> --- a/drivers/mmc/core/sd_ops.c
>> +++ b/drivers/mmc/core/sd_ops.c
>> @@ -19,8 +19,13 @@
>>  #include "sd_ops.h"
>>  #include "mmc_ops.h"
>>
>> +/*
>> + * Extensive testing has shown that some specific SD cards
>> + * require an increased command timeout to be successfully
>> + * initialized.
>> + */
>>  #define SD_APP_OP_COND_PERIOD_US    (10 * 1000) /* 10ms */
>> -#define SD_APP_OP_COND_TIMEOUT_MS    1000 /* 1s */
>> +#define SD_APP_OP_COND_TIMEOUT_MS    2000 /* 2s */
>>
>>  struct sd_app_op_cond_busy_data {
>>      struct mmc_host *host;

