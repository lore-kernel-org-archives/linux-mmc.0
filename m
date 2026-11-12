Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450780;
	b=FGF1If2DBet1u7Yi+hh7kZvd1lfKOecNduMfXMYkDcwAsDUrAMis4Gk26PEhXBpW6Izq
	 +QYMidmMNUg3sIJA1u84F+dAeYEqFJJRWyF9hm/aS7z2pn3DJ5rkoL93UsZchI61QhuPO
	 JqaTwFhDPOL0FNc8DnKFsKC8vYL1A1k8W9BebMY/fN98WayJKOf7cGCPFgknQNtsGAMgW
	 /75y5aEx79MJiVnA8cti6OoUFuvovcnfV6t4vaKeeET5PIdXah/iqJCeLWHhftUKok/AO
	 n/ZW8dAFpwPX31+Td6QIojWOrVjOTURG3+b8HFXpj7W5kTVQsrwpzroqk7GEudManCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
	b=IiXpvF8QDcHICZ93BBzMlsrYqR5vMIfMBpLd/ZcnoTGL+oKdF5Hv7uSBqgpNi597cMf4
	 Pum0hq6Sm8+fy8GwOF9fsMWi1SoIbI+fQV0+aOchh79qHleCt6YFP+9RNEuSzvwvAsBbh
	 SdAcIr9wHt/qsDNaObjvw01tElSzZ5dKgnwKsJgoPH2EOtMzibwZNZfqdZ6N5ytt0/GRx
	 exYGLdM++wyn8p1ULJ/GB9WBjud+8tKFVk6AIHvGDCAxfeisD4B8uCDrMbzopqRbN5k82
	 r3iDY14a/SsTrgofFLTmiS5xUnsvT7pLyH6+qzE42vJuqI9H9O3nXWSXeDMLCKTeGjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sf1ye8c0;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF40606A324
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF40606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sf1ye8c0
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e946155442so30574965ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 18:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794450780; x=1795055580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
        b=sf1ye8c0sYH4D0xHSeFLJxtpIO8jYTtz8n+aCV9WLa2DhH7wECKLKrebKKCVoWtJN1
         XGDXn6GnRtwi0LFCkr5wcuX1LiSqzArhl5OwTuIsjrLsgEvzwPOpsSUmcAve7cyy6RWn
         n7b2ddRE5kWsPfU8zCVrQh4I4H2MYJf+a120kMCM1Q0eNu1zj3kSuJA0MGoEFAbndMfv
         /s1djguR280b44OTKyZ9pxBwsRBlDEey6tRTGXTNXUafQh2jyBFBo/3/YWktc+tZcBDC
         2In3z9t3Y88yQ8U5dBYtfgb4neN+C8mfjmz7hYjnzm4MMpAq8UFO4Y/IAZbhHjdyd+98
         BwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794450780; x=1795055580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+BRgZi/ru4kt6Z44lXsT8xtnCbwbkOnntJWrR5mZ6uk=;
        b=VYae1bKouoz9s7s4JANu0z/yaO7Hnhnz22lC+NA16JQL1tBGXKvKEPfHfxpNWvAiGs
         MDWktYnwHVsU7U/X/muJw4aZ0asvD/jDkF3fMmSJJUCGUDVc5AFy4av8ZdgnKbwrNhb6
         nhmaTRcE5goSMIqZkCULJX7m95BqAh/1Wl03ufEUns8amLhyLh4P9uEfr9j6M5IkW2l0
         IfGP32UhN3Zjz1NTOAj40mEL9Syh51WE0UVPQEGEOfVjHaNj7RO53MdBl86lTAClkLC/
         WBiAxDIVXa06er26gF+pWLPQ7cfpq2leV6lyNF5lSWu/ZmkvmcnUaUkk1WO0F/PMBHEa
         UMJQ==
X-Forwarded-Encrypted: i=1; AL+hErEIifSURiTuif7ZbCpuTESfBiFHghGCf8yq19uXL6v3mRsXZTpwCMsOK6eeYt6N/R4YWJUmfdcDiPM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oZoqX7z/hsifI9gluweWPoG5BLtOIg8af47gaOlVuTk0tnAyk
	MShMGrOXHSW53+N8dNC3qxoy57XF5VBoweoo0t8uzQc+RV7sm8YkrHwb
X-Gm-Gg: AYBFou3gw3FTkegWz1JluVjaIP7MMTxm2vX5Cg8c65Q4vx3jjEPROp/HNkjR4Y52FNr
	uYmd8ydg1MycXv5o9t5IU0lU7zHthBfn07MXWYkUgahiKsnIaJpK93baZj613upENieKkRsoDSJ
	ozcmb8FZUSTZR25W9ouUcNE2ZZPTCOU0SCK7gAuM0tn8MdJMc+r5K6fe9T2UcJEgZ4o2EMDGabf
	eiIQL8hygV7nirKg7t4QEOyFKe945BdHNClp1dfPzYjlfS6xjyEtn/y4pAJA3YF3qK+92luGHTO
	T5ZglMKms8WY2SldnkRZXIhd2dIsK1f1yLqS3WOUVAukMJgMdhbb3EPRfVlQEsRZLdduQYtuLMa
	89VJA65ecmowFpHdi6ZuGIEJMNfWCz5DuvTzpj9NWf7c5iR/gnLnYuebs95KbWLGfTvbv0ZV6n/
	PxbgWNw+J1b+Leu1f+GE2YSz2M0qx9o/vgpyP5HbVJm5OVdWVmuKj2dTn/WcMt7Go2WA/vhbdli
	WLX4r/kMbfqEonYdRdtXVKA4HPcKS1C3hsSuh7DCyt0AuRtGGgIxiHEVcNUuCGdywaC73x9QpOt
	UBFFuEWAG6+/IyeH+wZirofqgQ8/be1Aobq7SLUAO8MwZ+11
X-Received: by 2002:a17:903:32c6:b0:2e8:1910:e398 with SMTP id d9443c01a7336-2edd76d5e01mr46318665ad.9.1794450779567;
        Wed, 11 Nov 2026 18:32:59 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb68204d4sm26378855ad.0.2026.11.11.18.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:32:59 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing DMA
Date: Thu, 12 Nov 2026 10:32:53 +0800
Message-ID: <20261112023253.7607-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avRXf6SJuXxslsbx@ninjato>
References: <20261101063739.89331-1-0xbeac@gmail.com> <avRXf6SJuXxslsbx@ninjato>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wolfram,

Apologies for the handle in the Signed-off-by.  I have resent the patch
with my real name, Yuansheng Yang, in From: and Signed-off-by:.  Only the
author identity changed; the code is identical to the RFC.

Thanks,
Yuansheng Yang
