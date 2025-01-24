Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6F1CDA04
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715023; cv=none; b=Kkz6yr4R2MuOjB6iQBSTZj4exhklePNxx7/T8w+CB6/PHZjvMsDyQrt5ne+aH9dBf0j5QYzpawnbSyP2O+ojXE69AIx/ekzdw2011GFsIINjWBybP1U+AzJwEE4L1OBYWIku4JiqdgFl1XtpJw7BCRII+qQzvhPv3/S65P5Ooc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715023; c=relaxed/simple;
	bh=ccIvxLHoKpTx1/8tkfp7al9tb1JQeF8Qm0KkvCLRzAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv1968xlaGYaBS06B+9MkQBfXp7PbTua4V3n+NYdDMyBBO2vx/KfwHv8sr4JN3UtUKOTHHIq3mZbHzFT488LjhI3YE/UA4YrGiLJG0XI1GnJip7IsLDBe6b+sRy3XxpzrqVQvjNPLyqFfIv+0/hY1vmL6HfSlrI6eKkn4qKSuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=yGSQ+xHO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="yGSQ+xHO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so19861975e9.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2025 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1737715017; x=1738319817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfzXbiuWN/qhkMVLVFhWWFAL+nq4OjChZkKMOhzHSGw=;
        b=yGSQ+xHOX9jj0HvENfBa/+kGFNQdAxtI5fadH06SmeIMteNyUKhPtU5oLnUGzUypIF
         IdJJRKKdPmQ6xaFCv0o5NCS0lkUfc95OUm9f4T8sTpvT/by7vHeCS//VaedMGjs7W6pb
         +w1PttrFZgB7Ta7nNEhxfz+wlQP2wzx3N2r6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715017; x=1738319817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfzXbiuWN/qhkMVLVFhWWFAL+nq4OjChZkKMOhzHSGw=;
        b=HQD9DOqs4rUY5TOnQ11nV9Iv8diUExzDFHCzK+tAvpDzMo5r3c1nVWnYzbTM2pR7Hx
         gNutlbdH5luZIHQNFSzO61rD9A2lfu/EdCZs2rlCca5GnpJ76+OjV4Silk7BE3C/0Avm
         gz1WgTCTiNCe0WBCrED5L3ino3IidOEDgq86i6XxHHVo0usE323ZGg+ssWpcN04BTAhs
         rX0HT6/tLckEjNL+FS2TK+UM0UPT521Y2JsfeSm/N5XyAiX02iMCnGM0RTPRSromC1jY
         DxcM8dW3hrf+/ixJZmXo8bETQq3G+iI7BY0mbsEvpaale/mgheJG5SWo7PxN0/vwbtv6
         4t7Q==
X-Gm-Message-State: AOJu0YxvOzD8698N1btWo08owNP+T422/0pJk8XcnIElkxLGF1G/i+Xl
	a0CFDeAP9/VKrlwcMayomnwvlwlThknMb2lTkx+mgY28WrzPQYh+n1OoF48SzIS9UepB8ZNz2DZ
	e
X-Gm-Gg: ASbGncsVTaymcFZi/fOvVs+Q6+1FWQen+ZH6b0V1BV5YWKmUKq1WQ/qcbyXlyLNpeCr
	akcCx5y7T5lgCv795xQVQ3gYx80Z0dtVjwxligkVcgMUlxEC7BbUt3oJ12uNqcjm7troqZNhuvU
	AWTkB+ILuK9vI/3c8gNC2TSGQUiHurx5pXJV5f26sDTOBmvkN6jG7P7rCbNbduI+fmvK9X14OKL
	NuCS/cejMIZ9D2tbL+wPusQoRmto+EtBbIRxOA7pnaSikaBuh0SB5M6XtExs92tnW5LergH7cqb
	MR3g9yUQ4T31gdUEzKrG3PUwm1LljNB5A+VKoN/Y+065NHxefST9S04H9UIpf+vBAZJg04g5bhT
	xeWwZDWk0BnYFivhEJNAVmxQO8ioRWAFTp47QYBQl
X-Google-Smtp-Source: AGHT+IHPrFf82v6k6SzKmhhNFnGZ+58JJbF3E156m6NSbU27wCHC8adaDkce/j7KdTcAIdd5H30LEg==
X-Received: by 2002:a05:6000:1a8c:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-38bf56639c9mr25899644f8f.20.1737715016810;
        Fri, 24 Jan 2025 02:36:56 -0800 (PST)
Received: from ?IPV6:2a01:cb05:949d:5800:e3ef:2d7a:4131:71f? (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3994sm2212888f8f.81.2025.01.24.02.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 02:36:56 -0800 (PST)
Message-ID: <f6732c49-a5b1-4a13-b9f6-c2d552b5e7e8@smile.fr>
Date: Fri, 24 Jan 2025 11:36:55 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sdhci-omap: additional PM issue since 5.16
To: David Owens <daowens01@gmail.com>, linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
References: <1c5f72c4-3d55-4d62-b690-8c68b76a15d2@gmail.com>
Content-Language: en-US
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <1c5f72c4-3d55-4d62-b690-8c68b76a15d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello David,

Le 23/01/2025 à 23:09, David Owens a écrit :
> Hello,
> 
> I have a AM574x system and encountered an eMMC regression when upgrading from 5.15 to 6.1.38.  The eMMC is using mmc-hs200 powered at 1.8v.  Reads from /dev/mmcblk1boot0 will return expected data except when a delay of several seconds is inserted between reads.  With a delay between reads, the read will occasionally (~50% of the time) return garbage data.  Using hexdump, I was able to determine that the "bad" data is actually coming from /dev/mmcblk1, not /dev/mmcblk1boot0.  The same thing happens when reading from /dev/mmcblk1boot1.
> 
> Much like a previous report in the linux-omap mailing list [1], I too was able to correct the regression by reverting the commit "mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM" [2].  Unlike the previous report, applying the sdhci-omap patch [3] did not resolve my issue.  Only reverting the original commit allowed for reliable reads from /dev/mmcblk1boot0.  I also don't see the same I/O errors mentioned in the previous posting.  Reads always succeed and return the correct amount of data, its just from the wrong device.

Interesting, can you share a test script to reproduce your issue?

Why 6.1.38? nowadays the 6.1.x stable is 6.1.127 already.
Can you test with the latest stable release?

I believe this issue could be reproduced on the beaglebone-ai board (I don't
have it).

[1] https://www.beagleboard.org/boards/beaglebone-ai

Best regards,
Romain


> 
> [1] https://lore.kernel.org/all/2e5f1997-564c-44e4-b357-6343e0dae7ab@smile.fr/
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=3edf588e7fe00e90d1dc7fb9e599861b2c2cf442
> 
> [3] https://lore.kernel.org/linux-omap/20240315234444.816978-1-romain.naour@smile.fr/T/#u
> 
> Regards,
> 
> Dave
> 
> 

