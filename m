Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7711862;
	Tue, 20 Aug 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185076; cv=none; b=qgqa7EldCgzaDPuanJkHc+aFjQBJiPaQPS5q9/PhTN6dFkPXq9wRtaIwbnL2gY/3/uFThh4BjhkcjcqESg5PKL5owMW4j9zfQbpue5yP0df01M705heYqScWuJM/eYjOCiXtfLzzgDuyuc3Hhsx93hZyxy+sA+1P4s5M2lBufl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185076; c=relaxed/simple;
	bh=zNkTj2ONdT+YIIgcflqyZRIDXJCRIU/9yZu8uEEuhRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qgX8+VMK5q2n5HAYq7/AUJ20SrowLZQANdpfkb/jMoXNlMvWkgjdGS/hSHZMkduQKFNhi0/9vyjpOWPqcnAtDLXBRjEI+VHx/6XkrwW7yxR1PY/1yQNt82gSBo+gQa5/AlD9vX5kZcvLppJYjTeiHv3SKv9TeIZkaueMe2UPoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qDSEFonB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qDSEFonB"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KKHn3O040772;
	Tue, 20 Aug 2024 15:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724185069;
	bh=JssVpm1+7QeQwBFb9zZV+4dPocHbmkvDKb8l4/dubas=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qDSEFonBwxjyvK4OsuBn75sCtTQS94eZDeSYVIoxsEAYnrMK69GBUUd5O3YaIcGoG
	 /JTFWo7O69vLRG5pw9SpUHdMM7M1SziFvuHAvowiB25tFMxGoOPzAVJb6T0hU6mnby
	 cWsjYccLTW0ExuhOBz2w/zDVzZ8UolEnnqIC/C0k=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KKHnEb016243
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 15:17:49 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 15:17:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 15:17:48 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KKHmpV105652;
	Tue, 20 Aug 2024 15:17:48 -0500
Message-ID: <6a8fd4ac-4322-4031-90c7-9ebb23796a4c@ti.com>
Date: Tue, 20 Aug 2024 15:17:48 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Add tuning debug prints
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240815201542.421653-1-jm@ti.com>
 <20240815201542.421653-3-jm@ti.com>
 <CAPDyKFpb0o2w9=nRp98XnqoLKtFOCDssJzy+53mg1bW8y0UmUw@mail.gmail.com>
 <acbf7997-6989-4de6-bf25-3b5589ad2eb9@ti.com>
 <CAPDyKFoekvs1XLGVewB8vA=rsGN4ikB9uw80AVw6NVRF-rgffA@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPDyKFoekvs1XLGVewB8vA=rsGN4ikB9uw80AVw6NVRF-rgffA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Hi Ulf Hansson,

On 8/20/24 10:03 AM, Ulf Hansson wrote:
> On Tue, 20 Aug 2024 at 16:41, Judith Mendez <jm@ti.com> wrote:
>>
>> Hi Ulf Hansson,
>>
>> On 8/20/24 6:33 AM, Ulf Hansson wrote:
>>> On Thu, 15 Aug 2024 at 22:15, Judith Mendez <jm@ti.com> wrote:
>>>>
>>>> Add debug prints to tuning algorithm for debugging.
>>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>>    drivers/mmc/host/sdhci_am654.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>> index c3d485bd4d553..a909f8de0eabe 100644
>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>> @@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>>>>
>>>>           if (!num_fails) {
>>>>                   /* Retry tuning */
>>>> +               dev_err(dev, "No failing region found, retry tuning\n");
>>>
>>> A dev_err seems to be too heavy, but I am not sure at what frequency
>>> this could occur?
>>
>> Having no failing region is what we call a corner case, it rarely
>> happens. The one case where it did happen, it took a good amount
>> of time to discover there were no failing regions found. The tuning
>> algorithm had to be looped 3 times before finding a failing itapdly.
>>
>>>
>>> Why isn't a dev_dbg sufficient?
>>
>> I thought about using dev_dbg, but based on some feedback after coming
>> upon this issue on a board bring up case, we think it would help
>> enormously if we make it as obvious as possible when no failing region
>> is found.
>>
>> The one case where this came up, the dev_err print would only print 3
>> times... Now this is only one case and we are not aware of any more
>> cases like this, also we cannot replicate on TI EVM's.
> 
> What happens if/when we fail here? Do we fail to detect the card or do
> we end up running it in some degraded mode?
> 
> If the latter a dev_warn, the former a dev_err(). Does that make sense?

What was happening was, we enumerated to HS200, but then cqe error was
triggered and this re-triggers the tuning algo repeatedly until the
failing region was found.

After thinking about this some more, I think I will switch to dev_dbg,
if we fail to find failing region and we re-run the tuning algorithm,
don't want to confuse people by printing error logs if we are re-running
the tuning algo anyways. Thanks so much for your feedback!

~ Judith


> 
>>
>>>
>>>>                   return -1;
>>>>           }
>>>>
>>>>           if (fail_window->length == ITAPDLY_LENGTH) {
>>>>                   /* Retry tuning */
>>>> +               dev_err(dev, "No passing ITAPDLY, retry tuning\n");
>>>
>>> Ditto.
>>
>> Same idea as above..
>>
>> But with this print, the maximum amount of prints that could be printed
>> is 20, is this too many prints in your opinion?
> 
> This sounds like dev_dbg to me. We are not really failing, as we are
> making a re-try and will most likely succeed then, right?
> 
>>
>>
>>>
>>>>                   return -1;
>>>>           }
>>>>
>>>> @@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>>>           struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>           unsigned char timing = host->mmc->ios.timing;
>>>>           struct window fail_window[ITAPDLY_LENGTH];
>>>> +       struct device *dev = mmc_dev(host->mmc);
>>>>           u8 curr_pass, itap;
>>>>           u8 fail_index = 0;
>>>>           u8 prev_pass = 1;
>>>> @@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>>>
>>>>           if (ret >= 0) {
>>>>                   itap = ret;
>>>> +               dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
>>>>                   sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>>>>           } else {
>>>>                   if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
>>>>                           sdhci_am654->tuning_loop++;
>>>>                           sdhci_am654_platform_execute_tuning(host, opcode);
>>>>                   } else {
>>>> +                       dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");
>>>
>>> The commit message only talks about debug messages, but this is an
>>> error message. Perhaps update the commit message a bit?
>>
>> Sure will do, after we conclude the discussion above and in v2.
>>
>> Thanks so much for reviewing.
>>
> 
> Kind regards
> Uffe

