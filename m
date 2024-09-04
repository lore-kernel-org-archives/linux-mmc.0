Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA01CEEAB
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448284; cv=none; b=XhntD0jCe5YzCsnBKpTyCAbml/0QlWsfg6kL7kaS/QimP5mEfndaSdcxIIeJR5xxt9czlPhureP5iFM4h4dNPzUgZ5S8CA6PNl4JZsqEK9HdthEpIp+8ebSCGCoUX9JqcR18T8QP8PRD/J9H3XylJbq7H1CIY+I5FOOuVYoOtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448284; c=relaxed/simple;
	bh=+mD3R5jv0tNaAEI2zOQ9rq9Rbn9s6X37jZX2Oc+Vn1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqrOTjmy1lVr8sLaob0GTSmC1zCwyaOqPEbx22XghbJNxRI+TQEO48O5nxuGgtGCOxpPfY7JeKpOhusX8b30y3fKeOlTaNY1zId/X15KK3kENa9N+juufPqanhwGE1Pw4Of/e7tHf/XDzPIhr3F6dU8QauRg2UY6gB+fFQOgYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJP+PBPS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJP+PBPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725448282; x=1756984282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+mD3R5jv0tNaAEI2zOQ9rq9Rbn9s6X37jZX2Oc+Vn1o=;
  b=mJP+PBPSx9bRW0C9IfMCGoMyNpj5g9lBW2B0Olzxag/L3KqBuxQL2Pwa
   1aNGzWs7mQYcNyA+tncDZzwkxw4XR8eFvrFwCKzoQkkniMVGdeqj2T33F
   MC6+v+PgCGdzBRVNknc6/KHDAWMiO7UzXbipY7OrGTav+PfKHeVcS2Rzr
   TeS1M6wQCtt9AFWkFFGsQh5gGybsqeTQFOn/g8fEzIw8mKpJkq8aSl6UH
   S8hv7dgTA5R2tdQZRrF5fz6B8/kHbWg/emlYejRCChwVNLY5uU1PW7jEb
   dvqsH83V9FBDcm20ghbrUtgLfEqBPw53259xAK5kDwhc3DOszlf6fMTKo
   A==;
X-CSE-ConnectionGUID: KNDThVPiQTKMe4+Fyn5SPg==
X-CSE-MsgGUID: cl8cvjIHSQmuEwOSStqGCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35260393"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35260393"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:11:21 -0700
X-CSE-ConnectionGUID: +jL9YfimR52mye5tNjXt0A==
X-CSE-MsgGUID: nUAlP91BRIyx32U2UP7Q1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="64891008"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.26.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:11:20 -0700
Message-ID: <6eb58d1d-8306-4c1a-bd01-c727299aa1d0@intel.com>
Date: Wed, 4 Sep 2024 14:11:13 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
 <20240827122342.3314173-4-avri.altman@wdc.com>
 <8c040805-e3cf-43d3-b806-206c3147052c@intel.com>
 <DM6PR04MB657547F546A2FF09FF839176FC932@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575D8B74C3FFE15B9AA8F9AFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575EAFF1D517456F9808EBFFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575EAFF1D517456F9808EBFFC9C2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 12:55, Avri Altman wrote:
>>>>>                       (do_data_tag ? (1 << 29) : 0);
>>>>>               brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>>>>>               brq->mrq.sbc = &brq->sbc;
>>>>> +     } else if (mmc_card_ult_capacity(card)) {
>>>>> +             mmc_blk_wait_for_idle(mq, card->host);
>>>>> +             mmc_send_ext_addr(card->host, blk_rq_pos(req));
>>>>
>>>> Did you consider having mmc_start_request() send CMD22?
>>>> e.g.
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>>>> d6c819dd68ed..22677a01c0e3 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host,
>>>> struct mmc_request *mrq)  {
>>>>         int err;
>>>>
>>>> +       if (mrq->cmd && mrq->cmd->ext_addr)
>>>> +               mmc_send_ext_addr(card->host, mrq->cmd->ext_addr);
> Oh , and yes - To state the obvious: async reqs are working fine now.
> Not sure why it wasn't when I was calling it from mmc_blk_rw_rq_prep.
> 
> Thanks,
> Avri
> 
>>>> +
>>> Will give it a try.
>> In the proposed form, this doesn't work.
>> Mainly because mmc_send_ext_addr eventually calls mmc_start_request by
>> itself:
>> mmc_wait_for_cmd() -> mmc_wait_for_req() -> __mmc_start_req() ->
>> mmc_start_request().
>>
>> Also, since need to call CMD22 for any address, it is ok mrq->cmd->ext_addr to be
>> 0x0, Then need it to be a little bit bulkier,  e.g.:

Sorry about that

>> by adding a "check_sduc" argument to mmc_start_request, if (mrq->cmd &&
>> check_sduc)) And make it true in mmc_blk_mq_issue_rw_rq and
>> mmc_blk_read_single, false otherwise, But this seems to be an invalid option to
>> me.

Probably better to put has_ext_addr flag into mmc_command.

>>
>> And there is that thing of adding dword to mmc_command.
>>
>> What do you think?

Adding to mmc_command should be OK.  If you want to save space,
it looks like 'flags' has many unused bits.

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f0ac2e469b32..ceb521e3598f 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -17,7 +17,7 @@ struct mmc_command {
 #define MMC_CMD23_ARG_REL_WR	(1 << 31)
 #define MMC_CMD23_ARG_TAG_REQ	(1 << 29)
 	u32			resp[4];
-	unsigned int		flags;		/* expected response type */
+	u16			flags;		/* expected response type */
 #define MMC_RSP_PRESENT	(1 << 0)
 #define MMC_RSP_136	(1 << 1)		/* 136 bit response */
 #define MMC_RSP_CRC	(1 << 2)		/* expect valid crc */
@@ -76,6 +76,10 @@ struct mmc_command {
  */
 #define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_MASK)
 
+/* For SDUC */
+	u8			has_ext_addr;
+	u8			ext_addr;
+
 	unsigned int		retries;	/* max number of retries */
 	int			error;		/* command error */
 

>>
>> Thanks,
>> Avri
>>>
>>> Thanks,
>>> Avri
>>>
>>>>         init_completion(&mrq->cmd_completion);
>>>>
>>>>         mmc_retune_hold(host);
>>>>
>>>>>       }
>>>>>  }
>>>>>
> 

