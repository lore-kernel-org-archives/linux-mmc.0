Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213AA19342F
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524839; cv=none; b=Lmv3tSuWzfcSqhjGcQ8aeb64N7kwyEYL9qy/tgX+MZbgjPW3Bi5+iU1WwEaNRKjO98GcbgMCIGf+5g35nNVxzszeaJEKK6LVHf4AHBgnjGnuDIFoeWstsgMiGjjJDwAn2HWngzB5xcqwyc6RDTev0Ybb/I94god0w37foQOFgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524839; c=relaxed/simple;
	bh=+znY4PgWdE0o/1mV+kkbTeIeEQEvG3ca7pN/m99Ea10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atw4oME/4tj+7G6oLGx6aFPLQzOmisDAMp4rAUnCzRBWDKWBzxXKjwqNZu7dEUblKUnWI+vhRnBVvp99HT6lzDGLqGA6yNYQHqCysxOOuFu77FfT6EMhkyCbIWJSsBnbhEzmJ9QTCWDW4xCWXW/hDPk/haZJFiYL3uOvbMknVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D1D9FEC;
	Thu,  5 Sep 2024 01:27:43 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E493F66E;
	Thu,  5 Sep 2024 01:27:14 -0700 (PDT)
Message-ID: <79dd252f-3e44-4459-bf64-4608eda377ea@arm.com>
Date: Thu, 5 Sep 2024 09:27:08 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
 <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 07:12, Avri Altman wrote:
> Thanks for having a look.
> 
>>>
>>> +     if (mrq->cmd && mrq->cmd->has_ext_addr)
>>> +             mmc_send_ext_addr(host, mrq->cmd->ext_addr);
>>
>> We should check that this was actually successful, right?
> Actually no, as errors in CMD22 are being carried in the subsequent command.

I see, sorry for the noise.

> 
>>
>>> +
>>>       init_completion(&mrq->cmd_completion);
>>>
>>>       mmc_retune_hold(host);
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
>>> f0ac2e469b32..41c21c216584 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -76,6 +76,11 @@ struct mmc_command {
>>>   */
>>>  #define mmc_cmd_type(cmd)    ((cmd)->flags & MMC_CMD_MASK)
>>>
>>> +     /* for SDUC */
>>> +     u8 has_ext_addr;
>>> +     u8 ext_addr;
>>> +     u16 reserved;
>>
>> Is there a reason for has_ext_addr being u8?
> Theoretically a single bit suffices, and since ext_addr uses only 6 bits, I had that bit to spare in ext_addr,
> but I see no reason to be cheap here - see the reserved u16.
> 
>> What's the reserved for?
> Not to break the packed 4bytes alignment of mmc_command.

FWIW, that's what it looks like so I was a bit surprised:

pahole -C mmc_command vmlinux
 struct mmc_command {
	u32                        opcode;               /*     0     4 */
	u32                        arg;                  /*     4     4 */
	u32                        resp[4];              /*     8    16 */
	unsigned int               flags;                /*    24     4 */
	bool                       has_ext_addr;         /*    28     1 */
	u8                         ext_addr;             /*    29     1 */
	u16                        reserved;             /*    30     2 */
	unsigned int               retries;              /*    32     4 */
	int                        error;                /*    36     4 */
	unsigned int               busy_timeout;         /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	struct mmc_data *          data;                 /*    48     8 */
	struct mmc_request *       mrq;                  /*    56     8 */

	/* size: 64, cachelines: 1, members: 12 */
	/* sum members: 60, holes: 1, sum holes: 4 */
};

has_ext_addr also should be equivalent to:
mmc_card_ult_capacity(card) && opcode in [17,18,24,25,32,33]
but the flag is also fine.

I'm a bit hesitant to put my R-b but it all looks plausible
to me FWIW.
