Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD523C4FD
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767002074; cv=none; b=F512Nzlt/tbEkceo50Zu68gezVAXJrbrOT4rX87erEFQqNAjdSZ1WiDrdpXO61yRjF1WLclbswsCnE9AobnT/wnXlWLCB/zR8fL5S0IwX2vzd9Qyh9tA8zkUa+TFgUXB87p5J4OjUrM17RTo1kvYN7lqRMIm9nA6u/o8vjUQioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767002074; c=relaxed/simple;
	bh=iyn+7uVvVmlzVQr4OGw9gaA43U7J6DW0cM5nn14twVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=okQuxlG43UWtf4nvkwz5HiA5Rqq4G7uxPdSJJdvbDi0EeELShuWD8SK8Xs8Ju++bVCFYAZwJZeEtENWl3mTbXrkKfFHKtgs+vkwhiddfRsFOi13usmj8opVbgb5pyFg9tpH+yIByxNgAFFWVDjeETJYMZbEGlvOUoAvfWEfgFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuqviDIE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESbba3Cg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuqviDIE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESbba3Cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767002071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSWobni4I8/LRXBXCGLU3hHGBFzvV9k0DPL4VmrN5NQ=;
	b=SuqviDIE9+i5oTkJ2VU+BmLN9jGf8nbwZnyPYYd5YNEf1YtcJPEmM4AP8AZ7uVq5SWcSkZ
	QtTbKOD1fXdDgpHKzb3JlFcbuUTSG5y2fgKIvX5RSPFpTI5eWob+CRn4tdZUq91DDWFrd9
	qGaQMLg/kuHiQtzYGjP0FSYzwbIj4vs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Nkq1R5LoNZO4twEcZksFUA-1; Mon, 29 Dec 2025 04:54:30 -0500
X-MC-Unique: Nkq1R5LoNZO4twEcZksFUA-1
X-Mimecast-MFC-AGG-ID: Nkq1R5LoNZO4twEcZksFUA_1767002069
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fc83f58dso4982552f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767002069; x=1767606869; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSWobni4I8/LRXBXCGLU3hHGBFzvV9k0DPL4VmrN5NQ=;
        b=ESbba3CgGz+F65FYRaVXtSRl0X+nc5iy0w638631g/l62syU2PfFIdh1eoTaCGDqHI
         ClSK/DOVFnAf9dWlMsCxUOtZR22MpzwnmPiyTO6aVPiTDzyoGSbX3UIS+tqe5kXA9owQ
         OYGgdMYofX10ZFeKOel54OdB5fTiLif1m83YZumNncEytLYv1/TavyPa0DKRNOgbGJHw
         ot2iMbTYV8JWc0jhKQKh4oDEJ7/GEsQlQu33tuT8kZFHWGWBcZzeGTfM6UTTSwz7bpGL
         X+2G9ONetCxtpaynnDz0J/rpR/0QE8wCyRyn7B3nKPJZmhzz8WflzaYIA0+/VumZy0xD
         ouww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767002069; x=1767606869;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSWobni4I8/LRXBXCGLU3hHGBFzvV9k0DPL4VmrN5NQ=;
        b=fPy4/CzNUElNTLHawel3rtXtjBcZHAQ3CJNFzb3NuTvqZJCMslRQI8UZ/gPBFE9yJ0
         FIBVLq3+bQ2HHY7T5Mavq5F/5hWSfvIDbot8i0RTkCQnVS9zTYNyjvJsdpG494fvGbgi
         EcglCVpq/ChbKZfgvmVx4Mm5r0GALRQVh5vH+Tyv+MSsf77XNemBk80SEgup4hN2V3rx
         IKsQPAB+BF6dzO1Y1p3J2mvgMJLzkjjBb48HARi2VP+U72I71T9TrpTilLiLdCpeQT0c
         oq17Pz47Jnh811iDy9g7Lrp28vNY7N3D6HbdC4Fl2O3YYydHfCf+euQd0LVA4TBsTSuf
         U/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXqchhKuUx/HqLUSHxRNXWMWlMNEIMIO2COWaGzkdCGtUldzzeyOV0bnxXjJkLKt3/FEaDF/on9T5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sEN0RQWFaxWFNMlN7z/MtkAblSNLSBobFXpdDAAHIAsTpiL4
	HCdLaMctESZqLz0Y7VhaRw2+zPY7pjk7YVpDY8926fbWuT6aDbnqpkVSjjheSaZyyEoP1ZmK+Zt
	rOvNQIIJEBF0a8Xr4nAKdlpcTrKfEQqSOCp2Yy34ZJM7u/EUvlng5/E6L0YL7dQ==
X-Gm-Gg: AY/fxX5iRIpnvVoEkzf3dgHpktVmyCu55TUVqmk7Z1pl9JhZtoaKxI5ytZTsZqjUS7y
	bKwf++o24WrpVAyj3H+FiqEkLr2Jvf2ZFtH5Q/RBI2pVCd9FiP4OZRpoDxk3+3dnHkKT3D7ZEOU
	lz+YecKJvqngBOH4lyyB/Uo6ZE4E9Njmq8XOWn2JnnQ+naPsGOkL9KR+GLci3EJP7HZOUnBTBHw
	X/5iAoHrJZcE9MOtM9nbZ/Ps9+tZJkI7nRZ+xsHwzcKZwm/Ws1GK9g57YiESf6L+fa7qKNfTuV7
	YWENKU5uY6nyIVONIKcmvTrI+bsT6UFl7gzy9WTQ08xMeM0U0+ypx3uPvjW6VNODidFzTdEmWIB
	8V3zNOipnt8/QPSxsLB9vHWZhaKe0pOWUNSWbrz3NZJwzNfICdSC5mpWt8cPwUev/vYJm
X-Received: by 2002:a5d:5d09:0:b0:431:c60:c5ed with SMTP id ffacd0b85a97d-4324e4c1687mr36359698f8f.13.1767002069042;
        Mon, 29 Dec 2025 01:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsxoEoP95m6ReZSz6r1q2uhNFZf5kjQYBZyqztpeqeumiInWw6+7PbX5zUgH0PIl8ztva/+Q==
X-Received: by 2002:a5d:5d09:0:b0:431:c60:c5ed with SMTP id ffacd0b85a97d-4324e4c1687mr36359670f8f.13.1767002068663;
        Mon, 29 Dec 2025 01:54:28 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm62245404f8f.20.2025.12.29.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:54:28 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-of-k1: add reset support
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-2-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
 <20251223-07-k1-sdhci-reset-v2-2-5b8248cfc522@gentoo.org>
Date: Mon, 29 Dec 2025 10:54:26 +0100
Message-ID: <875x9phaul.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@gentoo.org> writes:

> The SDHCI controller of SpacemiT K1 SoC requires two resets, add
> support to explicitly request the reset line and deassert during
> initialization phase. Still using devm_xx_get_optional() API to
> make the request optional.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

