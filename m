Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE2DF6C;
	Wed, 18 Sep 2024 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726634843; cv=none; b=Z0aRv0jjtcZFrVytsw8FNf/p1akXrDJSWkK0c+JHsnkLKUbZtZQpdmMzZdLgLiIMSLHjqp34jTG/UutYfj1GrVAmgpYhnElAIi4DAa4cIjgCmbcyXY8fUZtFrtLpgDVKl3ehwqfNHIJoMrr7KudA2cXfa0+Ec1meVt+EZl4ZL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726634843; c=relaxed/simple;
	bh=lfe6CIfsEmIhyxvtIKmf4VMGfqsG/BCrr0mgzjINUGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWlclMzZSVTuacTAAhx+86fASPRZASdTn9I00sChq0LtDRFrwIyLa2EdfhdRH4FfDxxIw4xo2ViJDOiNGW+X3qbLcqjxSp0THvVQLe60I5flrE7dzZ+Xa1S98b4Wvzj/IlqxQh+1UeOubgr9PluMn8YQmklP/yuxldPeI1VmJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgXzLo3B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgXzLo3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726634842; x=1758170842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lfe6CIfsEmIhyxvtIKmf4VMGfqsG/BCrr0mgzjINUGg=;
  b=FgXzLo3BrRwz0qEV+ZXXnorGVisUsMQHaZesWG9b6uGtgwEUTWweSBxs
   hCxt3wespuxx19SAoIlieWvVJ5jrS6/23dY0QZNfR9SNUJzMHvpzE/e5n
   TdXbPBTfrddKQcbVtklXBDOEGnAkFmVCa/Ht2CVlrQJX/kXOdBEGSgyRy
   CJ2+43iuTnnhXlsY2ncIRVtjlVvDPG1MLFM2z2JuGMioVt3lD/twkSWOA
   LjdxrBhT2OIIlW3qFScMLVpT2dzagICLzVQMszYOUKGz3EInrRtpfSK5B
   HTPuF43cmf31uE3OFl3D89h5IV2JwPCJlo0tgvkukFz+W+zKqGNdKUK3+
   A==;
X-CSE-ConnectionGUID: SksGDqzvT/egTCuj3xMQqw==
X-CSE-MsgGUID: c9vvA5XtSNSt6f7kNIwwbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="29270354"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="29270354"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 21:47:21 -0700
X-CSE-ConnectionGUID: Qc0nLWXrTpW1wpXlQiI0rA==
X-CSE-MsgGUID: y+21O7oWTeK2JR19Ufk3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="70216233"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 21:47:17 -0700
Message-ID: <dfde5172-c1b7-4c22-94ab-87a1d5d5ee9d@intel.com>
Date: Wed, 18 Sep 2024 07:47:12 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/24 13:28, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
> 
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
> 
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
> 
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
> 
> Patch structure
> ===============
> patch#1-#7:  for core
> patch#8-#20: for sdhci
> patch#21:    for GL9755
> patch#22:    for GL9767
> 
> Tests
> =====
> Ran 'dd' command to evaluate the performance 3 times:
> (SanDisk UHS-II card on GL9755 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 85.5MB/s 56.3MB/s
> UHS-II enabled         :  182MB/s 75.5MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 86.7MB/s 52.1MB/s
> UHS-II enabled         :  179MB/s 77.6MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 85.8MB/s 49.1MB/s
> UHS-II enabled         :  181MB/s 89.8MB/s
> (SanDisk UHS-II card on GL9767 controller)
>                              Read    Write
> UHS-II disabled (UHS-I): 81.9MB/s 49.0MB/s
> UHS-II enabled         :  186MB/s 87.9MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 80.8MB/s 53.5MB/s
> UHS-II enabled         :  192MB/s 87.3MB/s
>                              Read    Write
> UHS-II disabled (UHS-I): 81.0MB/s 53.9MB/s
> UHS-II enabled         :  199MB/s 73.6MB/s
> 
> Test command
> =====
> Read: dd if=/dev/mmcxxx of=/dev/null bs=4096k count=2000 iflag=direct
> Write:dd if=/dev/zero of=/dev/mmcxxx bs=4096k count=2000 oflag=direct
> 
> Changes in v22 (September. 13, 2024)
> * Rebase on latest mmc/next.
> * Adjust patch order to avoid defined but nt used warnings:
>   v21 patch#18 to v22 patch#14.
>   v21 patch#14 to v22 patch#15.
>   v21 patch#15 to v22 patch#16.
>   v21 patch#16 to v22 patch#18.
> * Patch#14: Remove unnecessary code to avoid defined but not used warnings.
> * Patch#15: Add necessary code to avoid defined but not used warnings.
> * Patch#16: Remove unnecessary code to avoid defined but not used warnings.
>             Modify commit message.
> * Patch#17: Remove unnecessary code to avoid defined but not used warnings.
> * Patch#18: Add necessary code to avoid defined but not used warnings.

For SDHCI:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


