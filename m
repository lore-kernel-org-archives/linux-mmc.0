Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DA1C8FBE
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617456; cv=none; b=sZ8vZX+6kusOtex/7meXNoUlbwmEUDw2tKtH4OqtFtxrI+c3Oj8dmZ4jt0JtjLnrJId1DvGAb+EbsL8bv8h6eaAxmu07qMH0XBzwAc3eBHdi5XszbMr0dJGGMzRfGB7biTJxsd7/0esxZ7K/qeym90g3jSPA4pz3fKGleQric5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617456; c=relaxed/simple;
	bh=27vAhPToNilbWnbpRk4NEQmTu4h4gwtsNd3tZFl4npo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBNkJtrsa5nhrR24ko3Z7K401Zz+x9DRM1Ry5s7tQrDGYGZWavw6Et9kcVy2PAsqnGkqC0HWAIxAMrK1haS61cYzBPCoxom7N0ACTMREk82ms+r2Jku8YaefFFsavdqH7bKlLxcV9NeXQEp6CrVkywosAtVpgRSccrOTNm6mD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJspC+Do; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJspC+Do"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725617454; x=1757153454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=27vAhPToNilbWnbpRk4NEQmTu4h4gwtsNd3tZFl4npo=;
  b=eJspC+DoCID02m00mKZvQAOe3uo3Ft7kxWcLCdbJdOo9mb6wx2KG/q8+
   bSSA/A20xmhxXegZiKY2zDki6zYE5OnQi5QUc/wUBwKqHMLcXt6FYJuAM
   aKUUdQPU8In5GXE7eqMJ4BTegJTJN1/dPv0kwt/6Fij6+DVkuzTWaxibY
   JtPuUG3y5BgV26xiu9Gr3sPgV4Aq0YalmaLa7smJTY0h/4DNHiArYuPPZ
   AUwGJJggJkMuuomrn3lhxIxPEbGIsr1X7neKki9DdxWZUt3jv2xNu2jbC
   A75zSsBVtvzwq6fBPSgAtUCGDVVUt/H3l6I2ExBjJN5KDZ9hziyv3aECa
   Q==;
X-CSE-ConnectionGUID: yswi5UXVTYyyNahMuKQ/ZA==
X-CSE-MsgGUID: 2hgGJEnOSK2OMduXWDUb2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24533128"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24533128"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:10:54 -0700
X-CSE-ConnectionGUID: tW+4coxJQqiWeWsvmxyAOg==
X-CSE-MsgGUID: o+es1PWeTEOkLDEYaIoPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96623145"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 03:10:52 -0700
Message-ID: <a8103403-caec-4fe0-a2cb-6ef262e0e400@intel.com>
Date: Fri, 6 Sep 2024 13:10:46 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] mmc: core: Disable SDUC for mmc_test
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-9-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-9-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/09/24 17:52, Avri Altman wrote:
> Panning to ameliorate it in the very near future.

Panning -> Planning

> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/mmc_test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index b7f627a9fdea..a28e1a1aded3 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3218,6 +3218,13 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
>  
>  	mutex_lock(&mmc_test_lock);
>  
> +	if (mmc_card_ult_capacity(card)) {
> +		pr_info("%s: mmc-test currently UNSUPPORTED for SDUC\n",
> +			mmc_hostname(card->host));
> +		ret = -EOPNOTSUPP;
> +		goto err;
> +	}

Probably simpler to put the check in mmc_test_probe()

> +
>  	ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
>  		&mmc_test_fops_test);
>  	if (ret)

