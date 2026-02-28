Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817120D4E9;
	Sat, 28 Feb 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271892; cv=none; b=uvuPHDwvYLYwF20NJ2OvMJeMVjin0sOrqqARGu3Q1Ty2um5qeSZBQ4G1TK8GuaAZB6WapApGhcrI+0KmfBHeyiiJ3rQx6gluaJxJFbwhaiRN6K595GMh2n6+iBbMcLb/R3C3n1peaaMhQ+5Dr5T9hvtmZDpUJEQCFV1fOGXs0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271892; c=relaxed/simple;
	bh=y6yGv+3xLq3mHF4HcTTFRg568IOhN9mbLfJF7QR8lgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeN70XvUdX61RXXZV8M26+ZeUgaaM9K97UPCDIHQ4f/WhVR+O5C7ACDSl8D8C/sehNEeNeZJww2evVTKMob6x1lbtW0sI/ksRByuANKAVEgPWMiQnv4M1Q6PY/k/1oCzHLRvwaWee9fgJFmnK7MGv6iP7u/9fSx3qaYwkCSliOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puwyPt45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puwyPt45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59028C116D0;
	Sat, 28 Feb 2026 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772271891;
	bh=y6yGv+3xLq3mHF4HcTTFRg568IOhN9mbLfJF7QR8lgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=puwyPt451zgA0zZON0ISKxzNH9BtSRyxJ0MVw3njH0LGH1Cbra/UEzoXEyZqH3hGg
	 8gRL+1+KJyHJi8kjMQEMozBeqBsJmHi3+bUOEqeT/TuSzZgMtnP2bSXXJbC5hyugWD
	 YQe7qqFakguPzXNyibNijFI0bmJgy0e6ShbAMJsSQQcPoQ95qjHADKs0MgH5WZNXnf
	 FhDfvynUWjWz0MtoRucT7AbRdEvjmRZmUzYInWa+LQc5I4nUaDO/WIZ+NFnmNZ/Jz6
	 GilJ16tJpaJpPVnoAvvrqJ2hQjc3DI7EfHfEupOJTi7muLo5afIJwIKL9DVTVhyEP7
	 c+J/3xlMrseMQ==
Message-ID: <b3352f81-89bf-4b9d-be96-2b45dfb3b9f3@kernel.org>
Date: Sat, 28 Feb 2026 10:44:47 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mmc: dw_mmc: Using devm_clk_get_optional() for
 biu_clk
To: "ping.gao" <ping.gao@samsung.com>, ulf.hansson@linaro.org,
 jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kwangwon.min@samsung.com, hy50.seo@samsung.com
References: <20260228062457.3210099-1-ping.gao@samsung.com>
 <CGME20260228062026epcas5p2389be640a10d12934ce8696fbf6286c7@epcas5p2.samsung.com>
 <20260228062457.3210099-4-ping.gao@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260228062457.3210099-4-ping.gao@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2026 07:24, ping.gao wrote:
> From: Ping Gao <ping.gao@samsung.com>
> 
> By using devm_clk_get_optional, if clk is optional for device and not define in dts
> it will return NULL, then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
> bail out internally.
> 
> before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
> not null,it will panic when call clk_prepare
> log is below:
> [7:   binder:436_2: 4998] Unable to handle kernel paging request at virtual address fffffffffffffffe
> [7:   binder:436_2: 4998] Mem abort info:
> [7:   binder:436_2: 4998]   ESR = 0x0000000096000005
> [7:   binder:436_2: 4998]   EC = 0x25: DABT (current EL), IL = 32 bits
> [7:   binder:436_2: 4998]   SET = 0, FnV = 0
> [7:   binder:436_2: 4998]   EA = 0, S1PTW = 0
> [7:   binder:436_2: 4998]   FSC = 0x05: level 1 translation fault


No, we don't support here your downstream kernel.

Start working on upstream instead, please.

Best regards,
Krzysztof
