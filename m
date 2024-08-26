Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869161FEA
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657706; cv=none; b=qqwAHW3O6tbnRfH3/m4z1AiaziADVsg2u5N8OB/DMgshOIUna2jOVwVr8QTgObhn41j2eX+yl4NDGERZnqbc/SsyK4XdnWA0t6p1WlFD9V+N/SKozfhEsZr+x3Y8uVsQhE/iAhne8NrlhRLGxKBqMeRyNHv79uy13TA+qf0sPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657706; c=relaxed/simple;
	bh=ITyfnwGN2BoltRYjbHCUcLuGVQGBW/GiBTjPWYBG4o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxxImASOqhS1+AUkcXnB4QwxG2juGRxElNoNCNuSn50eANOj4tnZTbEQoZbHatV04WOSrQigtSc6f2j3kFEUFxAX3f2jzEg10PBVpz7oJuI42pl+eHGaFSsWGHiTsd6Y3WVWJdPgQ0QgD4GAVax9/gL+EtP10pycf/uby32Sbq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmpq8p+b; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmpq8p+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724657705; x=1756193705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ITyfnwGN2BoltRYjbHCUcLuGVQGBW/GiBTjPWYBG4o8=;
  b=hmpq8p+b+NqOl9gvbZsoxnb9oSPnR3qyILhB2SzHP9HNcx/YkfXgv1h+
   j6f+rNGXmv2a7qd9yL0m9ys0AgjGg+nU5wOtyIQ6IvRNgFQA0mo4jfL29
   3JV0aEpo5t3ZGLR4ud7hNXYcsXjhpSzPmDs5zWQg0ef7FqpvhGdVLng7A
   KUyNYEe+Dwt0cSwH0A0rgnEy8DVaenuhCS1sJ5T4ds9nk9rLcXSAI+gT0
   z7nWoFbWVHalAzbt2CX34N61ryLS1QNYqB6NZiWKfXYXJUNfPpdzManRT
   bbp/diSKsYUh0su1ESvn1CvXstvh+E8BvHbglajeAxOI40wDooh20PAMX
   w==;
X-CSE-ConnectionGUID: xBz1OFLDRZmKMmfQzx9+yQ==
X-CSE-MsgGUID: Lp0ZJivBQ76nmRR4oTmlkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="34437209"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="34437209"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 00:35:04 -0700
X-CSE-ConnectionGUID: tWat6IK5QkmCZjgXuiVKRg==
X-CSE-MsgGUID: oiMAf0DpTbyGszeTysYJaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="66600008"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 00:35:01 -0700
Message-ID: <21353874-2384-47f7-9a9a-bdaeec1ba13c@intel.com>
Date: Mon, 26 Aug 2024 10:34:57 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] mmc: core: Adjust ACMD22 to SDUC
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <20240825074141.3171549-10-avri.altman@wdc.com>
 <9e2bf183-17a6-42a0-ba60-4a2384e53ca8@intel.com>
 <DM6PR04MB6575F070F4F18224617209EAFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575F070F4F18224617209EAFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/24 10:26, Avri Altman wrote:
>>> +     /*
>>> +      * SD cards, specifically high volume cards, expect to be allowed with the
>>> +      * full 500msec busy period post write. Otherwise, they may not indicate
>>> +      * correctly the number of bytes written.
>>> +      */
>>> +     if (mmc_card_ult_capacity(card))
>>> +             mmc_delay(500);
>>
>> To get here, it should have had to go through:
>>
>>         /* Try to get back to "tran" state */
>>         if (!mmc_host_is_spi(mq->card->host) &&
>>             (err || !mmc_ready_for_data(status)))
>>                 err = mmc_blk_fix_state(mq->card, req);
>>
>> which would mean the card is not indicating "busy".
>> Either that is not working, or it seems like an issue with the card, in which case
>> it could be a card quirk perhaps.
> I was getting here on a setup with micro-to-SD adapter - I guess because of phy errors on one of the early card versions.
> On my other setups, the recovery flow wasn't triggered.
> What was happening is:
> mmc_blk_mq_req_done
> 	mmc_blk_mq_complete_prev_req
> 		mmc_blk_mq_poll_completion
> 			CMD13: 0: 00080900 00000000 00000000 00000000 = READY_FOR_DATA + ERROR
> 			mmc_blk_mq_rw_recovery
> 				mmc_sd_num_wr_blocks - bytes_xfered = 0
> 
> Consulting with our SD system guys, the 500msec must-have write timeout brought up,
> And fixed that.
> Shawn was interested in this as well - see the discussion in V3.

The spec reads like the timeout is for card busy.  If the card is
not indicating busy when it is busy, then that is an issue with
the card.

