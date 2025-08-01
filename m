Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15895236457;
	Fri,  1 Aug 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053431; cv=none; b=K32cRbno+DcilwQfvKhj4iOhdP5AGDf/VXzS/wFpvc4n9DMqSZpxD/ElcmJA2lsDtc1aXI6J8/8iTPjdQAAnhK3QSlUslytws9W/e3qJrZMt8WOCTZ5zraUID6g5W9ymDWm0+PHGXda00FmiBJOrmuH+TrseVDWaTNhYrUzZZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053431; c=relaxed/simple;
	bh=nLmqkVS9iQjauEy4rNIt9xm6IznauJc6LTLgt+KT0/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p866id5XfedQ0ntmnCdJwPEHZ7ghaRHC77A5Tlk3aucQD9VIsQ7wQzUufrVZXOV0uJjMCp8W3er07Trjm7G9yPbz0/buu97lk+rQRd/SmU2TCWUU9yOaKwHlxLUcHEygJgcLxzLvkL4IcQJzgxmLeJfG0MmlcPSopXAksIlwIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HXbUItXc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HXbUItXc"
Received: from [100.79.129.131] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AF0E2018F0C;
	Fri,  1 Aug 2025 06:03:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AF0E2018F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754053429;
	bh=k47eOFDtblZTXzV626qQ8FC8NdB08Nl0iHc9y8piA/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HXbUItXcptdZ0a55CSqNyeflST4IwBaAaATj+QdjdEiskHAWN6qxBeiU+Q0Vo3Rsn
	 CMWWlnB4ubqKeRLqNfrJWa9icwyvZzfyX4gvJwyhdW8l9c7lV1nrsGFuwHkPgG3+u/
	 OpHZSRpEAtopRXQg1v2wXggorwfrvJzEq5pzxhh0=
Message-ID: <300b5c01-33bc-4ce6-942c-e32b6e55e5c7@linux.microsoft.com>
Date: Fri, 1 Aug 2025 18:33:44 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
To: "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
 Adrian Hunter <adrian.hunter@intel.com>, "Simek, Michal"
 <michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
References: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
 <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
 <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sai Krishna,

On 25-07-2025 11:19, Potthuri, Sai Krishna wrote:
>> Will this work with all Arasan variants?
> Yes, this is expected to work across all Arasan variants that comply with the standard
> SDHCI register definitions. The SDHCI_CD_STABLE bit is defined in both the
> standard SDHCI specification and Arasan's user guide.

As SDHCI_CD_STABLE bit is defined in SDHCI specification, why are you 
making a driver specific fix? Is this problem specific to Arasan eMMC? 
If not, does it make sense to make this a framework level change instead 
of a driver specific change?

Given that you are planning to add a quirk, doing this in common code 
would be better.

> On Xilinx/AMD Versal and ZynqMP platforms, the CD stable bit is typically set within
> a few milliseconds. However, to be on the safer side and ensure compatibility across
> all Arasan variants, a timeout of 1 second is added.
> Please let me know if you prefer to increase the timeout or if this logic should be
> enabled by a platform specific quirk.

Thanks,

Prasanna Kumar

