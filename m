Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3E4D5BF;
	Fri, 28 Jun 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557959; cv=none; b=kDLFP3D/HMBJdqyJDdqWFyS3sif38cirRxkHAQy5edw+i9QE7tKKxqj3KLadZyZVfkH3yWozmD/nxDjr+BmG+rIs++DceeMn2z9ZZoAlV9xf8EJ0GjPrRj/Z4IALdIzd26eEm+97Pn1+buQjQdWZoPVTfPr9EBNFZu1Tw8zIsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557959; c=relaxed/simple;
	bh=QQC8mM8KzUFN9L0wOySkjt2/ebpX1mB0JdVpvVNcCBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZDpVhCtMnLydrk08Ltob+co1ppOABp9IDu1l9KDzpwNbYCjxynlz5pzrVORxuAQnsuyuf16Km01YUqgaeqTl46okl07RRkbvLo3ayerajVg7sMRj2itmkb/UYif3vTixIO5dDIX4Aa/gVTqjYdLQK/5n8SDtZCFZZKhMLEK39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUsKGZN3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUsKGZN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557958; x=1751093958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QQC8mM8KzUFN9L0wOySkjt2/ebpX1mB0JdVpvVNcCBU=;
  b=AUsKGZN3llPWY7gXWHrxZXH47B7NGweW6R93NMLO0mdmJ2WNRSO6vgR8
   1DOiB71hgWj9nMbtwDMJZi++H84QYWM0tn301OILNYcBQ8rsRKQRKWbFR
   qv0Nm8X7THalcgVmZe1MrHuHk8awSmK2sdpFYPhVQpPHjxBLSB3LO1TV5
   276gYjzZIa0npuruZaZNjjl7yJVFS0PJX0b+2GjOXYqCIk2YeuuaBWER7
   4tik8d4Qly3EwFWrvW1xmJS6olx9WrX0kNspqHf8nGYqteCje5cw907aC
   2KQd3Ylz905xtJqo0UyUJxoSh0kn76Vh8k7Nr8Tv6eJ2JgT5Nd4/grB77
   g==;
X-CSE-ConnectionGUID: gxYqrqYMSOWNM1zp4uI8ZQ==
X-CSE-MsgGUID: 1WAizaDHQ7OOIPRX0YpALg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27348048"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="27348048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:59:17 -0700
X-CSE-ConnectionGUID: dtmeBPV7T/OIVno7LDDQew==
X-CSE-MsgGUID: sLYH1Di6QqiThiSPG2j5BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44759808"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:59:12 -0700
Message-ID: <8e633bf9-4891-4e5c-acac-187c7e7249f5@intel.com>
Date: Fri, 28 Jun 2024 09:59:06 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
 <216059e5-2160-4797-b431-b391ff69cd2c@intel.com>
 <f0ae92ec-ae2c-418d-9cfd-199e312e2c23@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f0ae92ec-ae2c-418d-9cfd-199e312e2c23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/06/24 09:30, Shan-Chun Hung wrote:
> On 2024/6/27 下午 05:40, Adrian Hunter wrote:
>> On 26/06/24 12:49, Shan-Chun Hung wrote:
>>> +    /* Enable INCR16 and INCR8 */
>> Comment would be more useful if it said what INCR16 and
>> INCR8 are
> 
> I will modify as follows:
> 
> /*
>  * Split data into chunks of 16 or 8 bytes for sending.
>  * Each chunk transfer is guaranteed to be uninterrupted on the bus.
>  */
> 

AFAICT, it relates to AHB bus DMA burst size, so maybe add
that if it is correct.

