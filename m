Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F91361
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495421; cv=none; b=my38ekaqZIe/It+dQM4l4M4CYaMGdq6MmKLoa8+Q2LLj+0syx7kTpRO0f/mhCTJhTui+YTgW8HrdsUetNiM2phZNSRRsAAH0ZEILpuO8iSxwU3i6IbLo4n2SbY8pedSxoeTRkg8cncb1hrdai/hj/p0CcMSQhR6yW9Z4aSman0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495421; c=relaxed/simple;
	bh=z4hwOPo5qMRWD/RRoCd7kHi664YWzL63fCRv/1dnaOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuypfKW3bq41eQIrIGSRZXt1SdeaiOFJ7Jalo9lzRWCXBnvxM/gnhaefJKCZ5iZ2lLZvEmsp5+uLzLL2dQe9fsxyu16h3AFoIZqUxCr3wr8jdqj5AcDmqJyB36D8aHabFI3Q7yUe0q75bvpUdjfIFEs0DhDjnJr2yKNI5SDvrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Yaz4Bq5E; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Yaz4Bq5E"
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id ly33sgdO9umtXm0BGsWitc; Thu, 05 Sep 2024 00:16:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id m0BFsnEq0r1Jum0BGsCwag; Thu, 05 Sep 2024 00:16:58 +0000
X-Authority-Analysis: v=2.4 cv=VPjbncPX c=1 sm=1 tr=0 ts=66d8f87a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=BvawdAvfLtWoXhSBC6EA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VJwTMiyYhSmnvnSQwhZpCJmhNaRCnkDEKdkuXTvWVFs=; b=Yaz4Bq5Eq7hvYxwcG9DtEHmxIp
	hf6SuFUkoSaA9f3Db5VC4Q3ZcU9Vpkkhd9EqPb6Xhbqf5vZySHN77CNP0QO+ncTtnOBnk9Zr7Dtxf
	nSTddWL9S+jCjPRqNS/g3Jfd4lQvCxzL3+LcxGfrl80RqbXw+k2euSYC5FSnDkEWPYSWnN+ThZhRP
	McwJJnSab7xJ+hViZtESpH+CFYzkqd/bpGQi/AYB1kod/hE/FpNkgjztv+f9pv3GGnseXwmRZxlt5
	VClrGEyyBFXNUfPTblv8Jll6TNCLIM97qrppE8R0z27uyuShw+VZnr+W8oKy2jP0jMg6yimYyiO6o
	ISMRSOvg==;
Received: from [201.172.173.139] (port=36672 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sm0BF-004GQk-0D;
	Wed, 04 Sep 2024 19:16:57 -0500
Message-ID: <42492aed-9b94-47cf-a5c2-a3fd44247f80@embeddedor.com>
Date: Wed, 4 Sep 2024 18:16:55 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mmc: sdhci-cadence: Annotate struct
 sdhci_cdns_phy_param with __counted_by()
To: Hongbo Li <lihongbo22@huawei.com>, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, kees@kernel.org, gustavoars@kernel.org
Cc: linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240904014636.2033138-1-lihongbo22@huawei.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240904014636.2033138-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sm0BF-004GQk-0D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:36672
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLSWiKR+gH21A0w/ORL7OYgiuJr5mj9G7KDfOZZuesXBL88JJ0gg0M3/2Iwg/fyYXaYGt5QbAhhZAeYbrBTbg3tl96NRkXmwO1+UKdT8kWBHWLMvAERl
 KRCu6TNE7dRQ+EA3UIbjBb+XNJGb4vSIm4YUFd7LeR+9qCKEcMS83SKf85zSEbk4JjVtNIngPNBXkRIvqDlac96jKJCgJtqcGjw=

[..]

> -	struct sdhci_cdns_phy_param phy_params[];
> +	struct sdhci_cdns_phy_param phy_params[] __counted_by(count);

It seems there is no such `count` member in the structure[1].

Since `counted_by` hasn't been released in GCC yet. Please, make
sure to build-test any `counted_by` patches with Clang 18+.

Thanks
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/202409042358.dwEQMShp-lkp@intel.com/
