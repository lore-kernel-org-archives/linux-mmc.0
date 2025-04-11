Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BFF507;
	Fri, 11 Apr 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376642; cv=none; b=A30UoBYDUFd1stmYjky54rsqIncnzj928d5SYEe/WeDvX5EHRVXmhDVL47vbt8v6NEn6AXCymPd+kK7Wcg6Ylr2gjmE70+wuMYKzfVnbSuDe0guA/YTegUwb6eDHt7uaiv5P6zLGDC4bSFpnNFxrnCAySvB/VYX2qcDFxho8trs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376642; c=relaxed/simple;
	bh=vbc6ZmWyf+jriZz7JjhFNLIzxydbUNT0CCpHcuBbacI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTgjgDfR8qsF2QSVY0MuIY4qIM4Ktq7b3zoO8QdF36X08xYpaOX67n+ycVqeW/3tWO31VEeN4RJ4rI2iL3i6Q5sLr6290lP9aAKjPVhdPsZOtor4YxCCWcfz9rjeo27igPYjz8CfQb74D/r4Jrjh9T/m2TdPWrCGIcYQkXiCk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJKIaJ21; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJKIaJ21"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22a976f3131so20613355ad.3;
        Fri, 11 Apr 2025 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744376640; x=1744981440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDx/ZAMBg1+kC52mKLqsxpIV3ktRutOE6TDlgFN8gTM=;
        b=KJKIaJ21LSDIagiUGUjbArjXIL/KWNSrFJxPXJyNCJ6RtKo+V1k3sfbmg3k+E6qK1B
         hTUlklyX2vYdqqCYXsb/URyC0whDNwbjj7hPie5n+IDk2UBz5TeobgdS+uOM/Sm9axPo
         f/gq6DZpW7pLFJp4GjYkBS2y7llT33ckQS1+Dr7rUay4Iqx5mrm9rcHqHFn5c/BtE5WN
         UzxVjr32T4c1C3ywE0FLz4K4E2xM2/jVnNflcRh+FW1nFxhcto2u3/O9NnCjGukK7mMF
         AlxG0M82CXuRhYwIzsSBprcFSSRmjs7fKCd2a3v8mjha8wgy7AxnF9IGXLARpa0h1qQH
         N1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744376640; x=1744981440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDx/ZAMBg1+kC52mKLqsxpIV3ktRutOE6TDlgFN8gTM=;
        b=RoTBLRYdyT03kg/9tkpXHcytaI+ZtZ3YewrTsqHX0TgyDBxNGJOwUU5rGoIdRfEYwg
         w7bFVgp4qodXV8VMRnOYhJSBWbXF4BVFGCnoIaVVKl23liZspjX4NKxDz7alRsiWmH7u
         kYCX5KB4WVHfjaNvFn4OFCcI87/04zC4K9ook8U45L9Kyvd/55N6O3v1ZYTYbR6Vi71c
         VrfKL42+OEM6k3Lh/hWtlRCvOEo0b+FEzQYQbVWDzBrztXe6dkRUZrrMwlarVsKCsb2W
         dtRAZ7Q2FrLY2u7LkDAQEfnE4RHeA7kJ+ba3mAsjtDlqAqaeR8Q6AiapLRlnzDXdSc7O
         4DLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSN2ik2u+6d315dLTNAL2/GjhQAUfwNTfAOBQ1rprsSy+3zwJP1aR4P4OyJHrQXtW2xbfb+HJ42CqY6P0=@vger.kernel.org, AJvYcCWDQio39FpNRM1g/QizrZLZihKYmJUswuDdcEp2irMgKMHuWdeEDWJx5/dpjlBEjyWQkShzJe6BaJxy@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ78UfdAVVY9+1Fm14aS+2YZAN9IDMAmpdGnREthj+NY0DnDzZ
	jBcqQBMv+y7IiZIYASC29ULiNLVeE+/Mww8KQ8GrD3DV6MbBTHf7
X-Gm-Gg: ASbGncvcVRs3LTowYDqfomcqEj8tXu5Mo13JajjQHZWq5f1jQiAHBmcNCBV9AHgy5bZ
	W9IaEG3yuLogUDdAjpfJKoI3WYva9ZSXV7fIL5PppLE4Zj/aYj+K+F2cxawN+l95p8KlCICnXhR
	+ZhWlcJaQQw8lPGwByGy1I89K4jdiNsTT3dLbm3Ep94i/KsF33XA1ZgA5STTVz5y5fuWdde7y4T
	3+QXmYVP7KOKhkpq51qI0KDDE1Fr7z4o2khTIEwlhh68EdxxTgLbJYpvJapdmSKCUlQ8/QW633m
	aYOvk4HytBuW7n7CJg9NUuWqp/f81ZV7nzSSjUg=
X-Google-Smtp-Source: AGHT+IFFi8JWAgq5wOqZtji/k7J0vMYGZAG2gd6+p+0IwD6TF71Ar7ISQaduUvALS+2LnqeWQzG0BA==
X-Received: by 2002:a17:902:ce8f:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22bea501532mr35861515ad.41.1744376639096;
        Fri, 11 Apr 2025 06:03:59 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c3:a964:9277:4e8:b712:66e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb554bsm47982875ad.199.2025.04.11.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:03:58 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:03:54 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
	Moteen Shah <m-shah@ti.com>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Message-ID: <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
References: <20250407222702.2199047-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407222702.2199047-1-jm@ti.com>

Hi Judith,

On Mon, Apr 07, 2025 at 05:27:00PM -0500, Judith Mendez wrote:
> For all TI devices, timing was closed For Legacy and HS modes in
> half cycle timing, where data is launched on the negative edge of
> clock and latched on the following positive edge of clock. The
> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
> 
> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
> requirements for TI devices so add a .set_hs_ena callback in
> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
> 
> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
> specific Kingston eMMC due to the sequencing when enumerating to
> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
> the kernel, but was reverted due to the "heuristics for enabling
> the quirk"[0]. The new implementation applies the quirk based-off of
> bus width, which should not be an issue since there is no internal
> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
> effect timing for MMC0 interface.
> 
> [0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/
> 
> Judith Mendez (2):
>   PENDING: mmc: sdhci*: Add set_hs_ena to sdhci_ops
>   mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
> 
>  drivers/mmc/host/sdhci.c       | 55 +++++++++++++++++++++-------------
>  drivers/mmc/host/sdhci.h       |  2 ++
>  drivers/mmc/host/sdhci_am654.c | 48 +++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 20 deletions(-)
> 
> -- 
> 2.49.0
>

Thanks for the patches. We are currently experiencing this issue on the
AM62 Solo SoC (hardware: Toradex Verdin AM62 Solo 512 MB), with the
latest kernel 6.15-rc1. I tested your patches (added both on top of
6.15-rc1) and I can still see the issue, when the kernel boots:

root@verdin-am62-15412807:~# dmesg | grep -i mmc1
[    1.912123] mmc1: CQHCI version 5.10
[    1.985262] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
[    2.186954] mmc1: error -110 whilst initialising SD card
[    2.620625] mmc1: error -110 whilst initialising SD card
[    2.997642] mmc1: error -110 whilst initialising SD card
[    3.337071] mmc1: error -110 whilst initialising SD card

This does not happen if I use commit 941a7abd4666 ("mmc: sdhci_am654:
Add sdhci_am654_start_signal_voltage_switch"), as you described.

Is there anything I missing or should test to make it work?

Cheers,
Hiago.
