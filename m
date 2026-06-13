Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561583A254D
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342555; cv=none; b=qUeLQBvNK+3nn1cnBCzxuq5MTD71MrFly+GVI87bOSePzCd5HelkWbkJxlJ/PfPP5RBgX4E7sZ43ZkJpy41BReXaNEL5IixrLv337h1jP3HELQ33OEe5Zf+MKlbuwAtcmsehphmuz2cD45dDdneoyPnqe3YpFB2jm5i5ShTv0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342555; c=relaxed/simple;
	bh=helDrwuxiWtrf/iPIy4Y9R/hkLMVrwdS0rRl6C7Dn4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6DES1QSFtSEwCK9prv6wpnJ0JHGsa2LTlo1n8e9+CbQ+xwnN+PGhWM3Jqh46cnXAjssXOcpp5GJpWwBYR9bjZ83/qFFI6udj4dAsfJSVdTXTmSyqzWvc5o6y3wliGHzqcYfDwzZr4MES8PAb/rH7Ytgx1CKnHp3Y5VggKxYpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUdzcura; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n7ACzOLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUdzcura";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n7ACzOLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781342553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
	b=ZUdzcuraVxN0tR4QJtHjX3fl/wRfhoqGYfDmhNfhjFRx2gXExTPMNgBprtslbgAJzh+/c4
	TOLfjmt5WBXgzFcjW54M/l23ro2DGJ5ZFlDZPKdKCesMClOCg3vFJSX+E/6jpnKEAF5gA/
	/VXzmmq3ib9yNhFnjChapll3X2dr9xQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-xVLaIxgUNYKUJQUeA9tBXQ-1; Sat, 13 Jun 2026 05:22:30 -0400
X-MC-Unique: xVLaIxgUNYKUJQUeA9tBXQ-1
X-Mimecast-MFC-AGG-ID: xVLaIxgUNYKUJQUeA9tBXQ_1781342550
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157f453a27so262523685a.1
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781342549; x=1781947349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=n7ACzOLv+WOrWvtffgBSHFCd1sqwAVcuLe0N4EwnK1hGqBRwEJdin2TthCBO/6a8mw
         Ht1esjvYudGXsl57gJWIQ8Hee9yAgEPB4Ij3+0wMZSrabFC3cWTlsDbmnlIipEnFXF9G
         FykR9mRnpzk2VNZf/fpDibTE10PTSfeF4A1DDIfeNJQZWpH5k/6sgq/XgkLVHJNOFOEv
         7ZLrzbYESpAmIEa+SkDTnPRpMLa41XZjPOyrpPNYEnO/HLnhNtjF0vzk9qvkUF/NSzZD
         ozyJz90OYTYAwjbO9dvhDpfJ/cuMy7EEEdTxY/cYMC9y2aOmf+tNYmjr2HI0ys22ctnP
         06CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342549; x=1781947349;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=fZ+IyAt3pZgzzLRDVjDCC0I3d4nhnYrLyJzfZaq65SR4EfVfR+GpQ/acN35SdHyGDV
         s2n0cLD+vnq3Kih8QnQNDvUveOwBWA7UoTZrc4zWUQSy1cbO6RUSq+GGD00yK0vjIVBH
         j8omM6+8ARMtkUZzBxevHUXXTjwcHKnrzygIYcsWErnge2MI+OSoDtMDG7kMeqmafRKt
         drpU+FjFx24yQsp2ekOQeahturTztT7RVDSQAFcQUGKN64VoghjofZcmyJBmt/pnZ2/x
         zqzp3KaFAOsvA1mw0HmcRv+ILFcFXaRYno4X9P7yMhLnyLyHtmFqEc2L5rpGyAm3fUWK
         pWgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N1kCDIX/92ncUiBcKeXbDKYwqgLqG31G0TMsfMDFlM++FQ7gnL9Hxqs2qLFKq83OvtXI/w9g8t4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdlib3ZVMyepVRlJta0ai8f2xYfhbx7GRHuzCJMvTp9/9Hf3q5
	HcyblK0ePNrjAAtDHJKONizfluvJW1ZUD07q+Bbuda1nkwgCuQNw/NxZsPkRcwhMdN5IcRaBc8G
	FGf4HLC8O/bK9rGXfX2c81pnVIeAHwd+WJB4Nji89B1S444rK3epFC5DMn8ykbg==
X-Gm-Gg: Acq92OFeMb6xbM6qLzgt7z4jvfZPGbfP9OF22mcGeE0s2DBjYxxuUBbkd6QC4vddOix
	uHWCalCLijG6reFdILXGyrZ9TfKzuXjfFnPC0Jvk/Z+w7000VX73YC4hNgtOw6LNyKjYMGomDHC
	tUUv4suAXIKwGXYACYj08/oi3nRSxZbNfhU4Pzmim/bXDJQKh0qtUXIZTKwkTW5gKh8m15uhwYg
	Ps474j5Ivga1eMmCTYUvOufzgYt64b8fQJN6bg7vz9kC8QTi3wC5GiRa6iMAW4tsZlwatFUKIz7
	Umpth6YALOaLNV8yx4126S82iI982prER61LLu4z8bi+RF+eX+VSb1mRGTAs+3bu0fIJLtXBW8j
	dz9Q3pIlG5S3rEPK6hArnlaSIcmvICsTT9qcPxDuKGVf+VTChobwHv3s=
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926952885a.45.1781342549618;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926950585a.45.1781342549179;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm454992285a.21.2026.06.13.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:22:28 -0700 (PDT)
Message-ID: <fe40891c-3fd1-417c-835e-6f1046db7844@redhat.com>
Date: Sat, 13 Jun 2026 11:22:24 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com,
 frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, nico@fluxnic.net, adureghello@baylibre.com,
 ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, olteanv@gmail.com
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 4:12 PM, Greg Ungerer wrote:
> This odd collection of patches is aimed at fixing the non-standard ColdFire
> set of readX()/writeX() IO access functions. Instead switching to using the
> asm-generic definitions in include/asm-generic/io.h. The difficulty comes
> in trying not to break any drivers with this change.
> 
> The implementation of the readX()/writeX() family of IO access functions
> is non-standard on ColdFire platforms. They either return big-endian (that
> is native endian) data, or on platforms with PCI bus support check the
> supplied address and return either big or little endian data based on that
> check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
> using the readX()/writeX() functions.
> 
> Patches 1, 2 and 3 in this series are specific driver changes that can be
> made independently of the final ColdFire readX()/writeX() change.
> 
> Patch 4 is the actual switch to ColdFire building using asm-generic
> readX()/writeX(), but also contains three driver fixes that are not easily
> handled independently.
> 
> Note that I don't have access to all supported hardware needed to fully
> test all these changes. I have tested what I have, a bunch of the standard
> Freescale ColdFire eval boards, and inspected generated code for differences.
> 
> Note also that patch 3 relies on changes that are currently only in
> linux-next, and are scheduled to hit mainline during the next v7.2
> merge window. Those changes are also available in an immutable git tree
> at git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
> cf-internal-io branch.

I understand that with this series you are targeting the m68K tree, am I
correct?

A possibly better option would be, after that the pre-req patches land
into Linus's tree, to share an immutable branch for this series, so that
both m68k and net-next could pull it.

/P

