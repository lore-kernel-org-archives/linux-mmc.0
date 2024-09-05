Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE97464;
	Thu,  5 Sep 2024 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498651; cv=none; b=hGgwixy8IUvuQwvYbhGbsBdJnexsz/7RwwEIIdT0mMUZaWLIDBgYDOV0pQe+MAhQhbApAw/R1CV/xkkSuttByzhFWcwvUYYTREt6iEPaEaqar2MNfHTRXuRaPf544uiuFPgQJDiPS58+9gvUa9yAeH+HQv7z3rsLVQ9XrW20C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498651; c=relaxed/simple;
	bh=Mllb3Zb0RnpcuweYqv05vaH1l6kRferG1YAAtF1AVFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cTV3WpIZFOGPMqGNxsLA6PB6Vq7frkm2SoMZmZmiriQ9lUG1ZJPFe1kgsQ5hmvxobDsZSaWnFkDkPusNBjIYomiTvfbVqEqHwScBMhig3onE9mcFG2hZluYwS2211v4uleTu3xSuOlJVGl95ptsJ+mcp1y5JUW+W1ZdNvBrPR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wzh7p5xtkzfbgc;
	Thu,  5 Sep 2024 09:08:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D6821800FE;
	Thu,  5 Sep 2024 09:10:46 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 09:10:46 +0800
Message-ID: <1997c6a3-6548-47ef-bcaf-7bfa175f6421@huawei.com>
Date: Thu, 5 Sep 2024 09:10:45 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mmc: sdhci-cadence: Annotate struct
 sdhci_cdns_phy_param with __counted_by()
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <kees@kernel.org>, <gustavoars@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240904014636.2033138-1-lihongbo22@huawei.com>
 <42492aed-9b94-47cf-a5c2-a3fd44247f80@embeddedor.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <42492aed-9b94-47cf-a5c2-a3fd44247f80@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/5 8:16, Gustavo A. R. Silva wrote:
> [..]
> 
>> -    struct sdhci_cdns_phy_param phy_params[];
>> +    struct sdhci_cdns_phy_param phy_params[] __counted_by(count);
> 
> It seems there is no such `count` member in the structure[1].
> 
> Since `counted_by` hasn't been released in GCC yet. Please, make
> sure to build-test any `counted_by` patches with Clang 18+.

Sorry, it is nr_phy_params, I made a mistake with this patch.

Thanks
Hongbo
> 
> Thanks
> -- 
> Gustavo
> 
> [1] 
> https://lore.kernel.org/linux-hardening/202409042358.dwEQMShp-lkp@intel.com/
