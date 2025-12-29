Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DD23D7C5
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001871; cv=none; b=giTbhxR3GQTz4Gb0YzXqGZPAWgTVmfAnNp+GweCDn8SiUBlZwf6NNGD9vPfhuXhscPF4Voo2k57Rlf9+YJ/75LhBglLH/sFgpB0dB2QPloAAx4BNhnKhHwynggiIsXItOEfCLDWKKrIQaczB/FYi4GAJ0PTl9IWfka3bihriY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001871; c=relaxed/simple;
	bh=S53nliDgDOBHyCHqekaIZd1yAS6cSB9PJP72bbGyW38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHGv8YDCwOooNaJ+9AdvqXA7Ky+kwGBmiwxNBnjlVgSrkYe4GaKM6XaoKFtloy1LXJNgSRdRGMasqRZok04civbCFEE+X0w81wf4xQbZVW+U/DvTmJfbcJ4gXRnCGfqCWO9pCzxJz47/cAOjwgymJsIA2FIzhgoYHrquYxsjWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4ovNVaC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ryawiXwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4ovNVaC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ryawiXwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767001869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBpgnCdgVjRyDFiA5DhH+bRquSZr5l4Vq9ipoB5aYAg=;
	b=U4ovNVaCnGlRGNHBFD19yephisqjREPmiqV5wNXg2Vi/VFCpT2AqHvD1h/cYR5RUCOfIav
	Du9GwbCb7UZc7MNDpLadFlo7jwdEn2GULCH4OsbELE+Zn7HEypr8w67mHM262spgaaWPMv
	1WdHDUOLgPyOJiQQ1mfE/4mKd4OIj7U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-8hI17RlxPoG_41P7lRKzkQ-1; Mon, 29 Dec 2025 04:51:07 -0500
X-MC-Unique: 8hI17RlxPoG_41P7lRKzkQ-1
X-Mimecast-MFC-AGG-ID: 8hI17RlxPoG_41P7lRKzkQ_1767001866
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fb8d41acso4587873f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767001866; x=1767606666; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBpgnCdgVjRyDFiA5DhH+bRquSZr5l4Vq9ipoB5aYAg=;
        b=ryawiXwx8tKhfkblOHDZmRkttLSEdjmh+IDD6jLGjsz39xZ2SbbK4aEaR7ELmz+seN
         iJch70KwdEvo4SRWnc00tUro4lFG8z9fSJeSz+YPXmPsIvfKOeVma1UhjV3OFQCyjjx+
         3BDDaKUeIbTuJkIxK5PVISo2NDcdSqL3pW8O1YbNPtziX/upbuLyY9FLhUs3aCEMEWA+
         /o0up03+tB0gIS3xZmyumvKm+dFJsajVgcugsEERH5788mkeg3F49gCtY5yfUI7u3/D7
         HLZHPoWxbgsSMj4no9zUmiEbPZHJMsp46kObdwl+BuZJqI0qu8JbbUIcoHy7jAhydms1
         wRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001866; x=1767606666;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBpgnCdgVjRyDFiA5DhH+bRquSZr5l4Vq9ipoB5aYAg=;
        b=T7SmeDKotSqn9075ZJcXLjJTI5P+7sBCGRoHVocf3Bnu3lhJp9WsE5uIET7ZV1PV8q
         gt7HVwTGATulmHTvk1799HEopi+WQKJ6ZZ4+zmzHchXKxOdBXlluTV6NBNlycteNsb61
         7WKStzthhAZFIJE8FQxp3L0DCTnhmPV9RC3RfAakyNN6gP8KgGrGdtCx91UhQwpfoJc7
         x9f+sSKthJYdc1bBfir4C1K2GcsHGi8Iaej1xWoXwN4odEMEgZQYlflCLndgLk/JjTya
         jSoJJBqAsNHKGw7yyoUwR8ySeTmAH7eWu1BV8AIAoH6aXZHSThl15Kpb3y9P8L+54dB6
         KEzw==
X-Forwarded-Encrypted: i=1; AJvYcCX5tOhU37j0dTpCqxE/nAeLmMqmPO9vANKZwhwvMs5u1EyBcnYnq3LrlMqxflse9CDZj/vGxHyeuPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aicqJdjl5vouQYJ6vBydzIYaXhknuhrgAjNgQ/2MvLYe6iGA
	4cN68Y3oPGKkwe0Z27sdN9SRnODnrt/RCIkOMpR6EsbxwdkJUjIhWYZwOOsU32w/5j2cmVbq76k
	+qk80uDNhWVWQA2SJaITFdBDx5oZ7fIQ3Hlj2nKGn6N3YMUSPjIdlEvKJvomkUQ==
X-Gm-Gg: AY/fxX42/QH0TyLbSQpy4Zdu5h0dm3PeioGtp8PPF3BT23wWZWqYp173a+g4VYrdmXl
	Ii8tlgjtJ9PeJRudUACd5k47GXMeiLmqaoncTpkPtcpei2twaDWxdpV5onvZBLsesE/Rj+/lt+8
	FazU8BunDUPxN+WIN51ECGwIKS1zWBFxFD4JH7CrH585CnshNRNXm/HDSnil3gF7GOKoRwpMgLi
	AWqvJGVWUj+DpaGHPJklO1t5zbSiLm4R6kJ4/JjU8f5fYbO3lb/kMcS5DpQEYk7narxFsRKu83G
	7m2hVkV8u9RKXvC8gKth1BkB2Q5+CIGknQH++ZZAeshyLbi5COn7+xcqfAM6qeEhjlA38/THVj+
	NUIAOnlauIQ53Xybuz4SrduK5UQGgczsp4FRfWIUsJcbJiV5yTMFgk4VxktdOYBo0f6A+
X-Received: by 2002:a5d:5f87:0:b0:431:a50:6e9b with SMTP id ffacd0b85a97d-4324e4fce39mr33803691f8f.37.1767001866442;
        Mon, 29 Dec 2025 01:51:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6G1jWYskSgvaXeS09XPL1OAXa1myU5ovRIkOqfBW3h9fMcLnWjubhvT9bqt7kVVsnsSU5PA==
X-Received: by 2002:a5d:5f87:0:b0:431:a50:6e9b with SMTP id ffacd0b85a97d-4324e4fce39mr33803665f8f.37.1767001866019;
        Mon, 29 Dec 2025 01:51:06 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82fa1sm59086626f8f.23.2025.12.29.01.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:51:04 -0800 (PST)
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
Subject: Re: [PATCH v2 0/3] mmc: sdhci-of-k1: add reset support
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
Date: Mon, 29 Dec 2025 10:51:03 +0100
Message-ID: <878qelhb08.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@gentoo.org> writes:

> This series try to add reset support explicitly to SpacemiT SDHCI controller.
> Previous it works well for eMMC due to it's already initialized at brom or
> bootloader phase.
>   The controller has two reset lines, one connect to AXI bus which shared by
> all controllers, while another one connect to individual controller separately.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

