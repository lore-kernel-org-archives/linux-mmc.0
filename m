Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817A191F8C;
	Tue, 20 Aug 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164865; cv=none; b=MOBGTZHCiehElGZOLw82Xwhd1csoWFxvLzNC4NK3o9Tyu0N7OEBF+jsnGXK76uB4NyQuIXvIqIozEpZ6cCIs8ETGm64QPEWeHd0HoKdGzFmTdy2X1nqeoPNQb/VpSqFkimLgIkSnwVjcpDVPW+3n5a6MssoX91AGxfQrwT4IuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164865; c=relaxed/simple;
	bh=zgR74iOZtWD47XmwOLrfOwY4VcoL1WMQEd5ytcTHtHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H7/ykuTSE4qn1d1WZhrxYHnh/msNkkLFwPr32rpXyhXh+c8rtIcmqCyv95dLSSEmK1P4Bcadwu8KZWGpB4aabVy8cMJlALXKFx+9GL+BLLlp0wfdM0XhMu3sPJP/AjvkUnCQJQ0228R0MvqCclZOuq7/nYY+gMoGIr6iIvGIZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o5IY3Zcm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o5IY3Zcm"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KEexbb074412;
	Tue, 20 Aug 2024 09:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724164859;
	bh=HO9vfNODmryMhdpoih1VLRk7fGKIBJsdsbmDrdrkPo8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=o5IY3Zcm9MS5hgiEzDeo+Q5NqsScEHgRgaiWSye+yzHMHp7d4LkY8OyMxnp46qDpd
	 gU+JgSjfePypM/hfwIxax+rQdLK03noVjsBOZ39sXBrDYcQXkp43pz2ZxuJX+IwCej
	 0C0WhQNXg9AIiWcngbxqwQsQxrUk0yEWymmgdbno=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KEexkT024708
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 09:40:59 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 09:40:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 20 Aug
 2024 09:40:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 09:40:59 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KEexKd130423;
	Tue, 20 Aug 2024 09:40:59 -0500
Message-ID: <acbf7997-6989-4de6-bf25-3b5589ad2eb9@ti.com>
Date: Tue, 20 Aug 2024 09:40:59 -0500
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
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPDyKFpb0o2w9=nRp98XnqoLKtFOCDssJzy+53mg1bW8y0UmUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Ulf Hansson,

On 8/20/24 6:33 AM, Ulf Hansson wrote:
> On Thu, 15 Aug 2024 at 22:15, Judith Mendez <jm@ti.com> wrote:
>>
>> Add debug prints to tuning algorithm for debugging.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index c3d485bd4d553..a909f8de0eabe 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>>
>>          if (!num_fails) {
>>                  /* Retry tuning */
>> +               dev_err(dev, "No failing region found, retry tuning\n");
> 
> A dev_err seems to be too heavy, but I am not sure at what frequency
> this could occur?

Having no failing region is what we call a corner case, it rarely 
happens. The one case where it did happen, it took a good amount
of time to discover there were no failing regions found. The tuning
algorithm had to be looped 3 times before finding a failing itapdly.

> 
> Why isn't a dev_dbg sufficient?

I thought about using dev_dbg, but based on some feedback after coming
upon this issue on a board bring up case, we think it would help
enormously if we make it as obvious as possible when no failing region
is found.

The one case where this came up, the dev_err print would only print 3
times... Now this is only one case and we are not aware of any more
cases like this, also we cannot replicate on TI EVM's.

> 
>>                  return -1;
>>          }
>>
>>          if (fail_window->length == ITAPDLY_LENGTH) {
>>                  /* Retry tuning */
>> +               dev_err(dev, "No passing ITAPDLY, retry tuning\n");
> 
> Ditto.

Same idea as above..

But with this print, the maximum amount of prints that could be printed
is 20, is this too many prints in your opinion?


> 
>>                  return -1;
>>          }
>>
>> @@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>          struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>          unsigned char timing = host->mmc->ios.timing;
>>          struct window fail_window[ITAPDLY_LENGTH];
>> +       struct device *dev = mmc_dev(host->mmc);
>>          u8 curr_pass, itap;
>>          u8 fail_index = 0;
>>          u8 prev_pass = 1;
>> @@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>
>>          if (ret >= 0) {
>>                  itap = ret;
>> +               dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
>>                  sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>>          } else {
>>                  if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
>>                          sdhci_am654->tuning_loop++;
>>                          sdhci_am654_platform_execute_tuning(host, opcode);
>>                  } else {
>> +                       dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");
> 
> The commit message only talks about debug messages, but this is an
> error message. Perhaps update the commit message a bit?

Sure will do, after we conclude the discussion above and in v2.

Thanks so much for reviewing.

~ Judith

> 
>>                          return -1;
>>                  }
>>          }
>> --
>> 2.46.0
>>
> 
> Kind regards
> Uffe

