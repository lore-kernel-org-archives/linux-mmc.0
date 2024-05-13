Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2584A2E
	for <linux-mmc@vger.kernel.org>; Mon, 13 May 2024 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576340; cv=none; b=TffYezLHhdUf/2cElgykBgi0uK65y19AYSqaErsIVnFnIWvrdpWZdbUXcrcQ8q5r6DNKOSWRW9NuwnS+BOispNlNqBI8y8a1RfIf+odZwrRuVj0zYonVHGKW6faldiJ4ZFAYgsISJiTFW1J3mcnU1ATUORNm0nve9hTxlVo3YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576340; c=relaxed/simple;
	bh=khSbDcQ+tM5Z70reSGyjmd5dr8DxXA/wGby5IjdVvSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gLsD7ynEHexyE8wkJuHOuRwALF/fQkbeXhj9+yJ23K+wubzPhEIQKml+OdVcAJu+3vn0Zw9wLZeuLxIexFYQG8TR3xEMeB10O3JKOV9cnsTlcazPzVQmjXubdogyVW6wbw7kz2stK6F4NEQGOZjyN7oCXYGg7my24GjzXMC2QJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnTu75k1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnTu75k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715576339; x=1747112339;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=khSbDcQ+tM5Z70reSGyjmd5dr8DxXA/wGby5IjdVvSo=;
  b=OnTu75k1BsOF1zuUCR9Dr0ftVSi2W/QyFdC3X7j4cVeF/0FAehbcgFZw
   hQcMdLvYQBUsG9DKGxG1V36Gzguxbc4bqj2QW0mJm+92oTzhusqKHsZNj
   3KuIpTcgbSl3tLvRWx+hlIKBbuc0Hl140U/3gvWTTkrXT6ArTnJHlD9vr
   ajRQ2Q4nsJOTTT7/LfGzZ5pMSk8qpq1/P1D8RSBCOD8PZ+6zlzRgGeG9o
   okSpopRZ8JG24QJVxUtXWSZbnQ4UV/tYL0eOH0S+Ekr7cENbXHRZI0KkA
   ZKcXNlYUIuycePAwa5JsDgup0MYRNLZGVKWnha/u2/7IR0eEyY+k/u3Ea
   Q==;
X-CSE-ConnectionGUID: zlEbkm/7SFebtGMCnk8RfA==
X-CSE-MsgGUID: 92EZyJi0QSeqr71k/w6sGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11649388"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11649388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 21:58:58 -0700
X-CSE-ConnectionGUID: 9Qa0chamQ0upJd31dkG8cw==
X-CSE-MsgGUID: QeJk4YWHQAWsPNbkkvBmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30294181"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.248])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 21:58:56 -0700
Message-ID: <579d5e7a-0745-4598-9d1d-ac951992a549@intel.com>
Date: Mon, 13 May 2024 07:58:55 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about mmc_blk_issue_flush() failure and recovery in
 Linux kernel
To: Liming Sun <limings@nvidia.com>
References: <BN9PR12MB5068667F4108339D4B140274D3E22@BN9PR12MB5068.namprd12.prod.outlook.com>
Content-Language: en-US
Cc: linux-mmc <linux-mmc@vger.kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <BN9PR12MB5068667F4108339D4B140274D3E22@BN9PR12MB5068.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/05/24 05:47, Liming Sun wrote:

Please cc linux-mmc mailing list.  Others may be able to help
or have similar issues.

> I saw that Linux emmc/block has recovery mechanism, but somehow a path like below doesn’t seem to trigger it.
>  
> [  285.858838] mmc0: cache flush error -110

Cache flush error means any data in the cache will be lost.

Generally, this is already unacceptable i.e. recovery from
here is not a priority because we shouldn't get here.

Also the file system may be corrupt, and there doesn't seem
to be anything the mmc subsystem can do about that.

> [  285.862776] blk_update_request: I/O error, dev mmcblk0, sector 42002577 op 0x1:(WRITE) flags 0x29800 phys_seg 1 prio class 0
> [  285.874006] XFS (mmcblk0p3): log I/O error -5
> [  285.878369] XFS (mmcblk0p3): Log I/O Error Detected. Shutting down filesystem
> [  285.885489] XFS (mmcblk0p3): Please unmount the filesystem and rectify the problem(s)

To recovery from here probably means
	unmount the file system
	fix it
	unbind and rebind the eMMC host controller

> From the code, it might be called from mmc_blk_mq_issue_rq() à MMC_ISSUE_SYNC/REQ_OP_FLUSH à mmc_blk_issue_flush() which fails.
>  
> Would it make sense to trigger emmc recovery for this path or any suggestion how to do it?

Generally the priority would be preventing the cache
flush error.  To start with, identify what is causing
it.

