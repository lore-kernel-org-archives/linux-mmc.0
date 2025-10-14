Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4221CC55
	for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467795; cv=none; b=HocufrUBwa4XAcQU0wZxJ50QaR0afdTsEHFV33/ed92/D1g5NnoYqkmP76EKOxmKcUJkcA3U7cMFqBOEReWNWJ6BuLREG1pkIdXNq8Qv7g+/bRcdImaGTDdCGvA49Mj1vhG0INpJwUOqm+YVLFRQIv0Ld/3MMi3DSByTII0Ca9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467795; c=relaxed/simple;
	bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX3J/y4e9xXPApwJYTF0+4hKo3RFT7Mq9uA2diGccaumPdLQT+a7sNQyPhc5zWTUsvwWWDIRV5tPaiUBHAdbUDlX9+SK7yblAkTJ/0/OjZdPJhWX9Q/Vp9kpTuxRfU1rCMLv78PO6Dod3z52taArjbQYugTBqOMt+ShNb6aXAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNfwhgNe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNfwhgNe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-279e2554b5fso1622075ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760467793; x=1761072593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
        b=fNfwhgNe3DbIEfn6BOmCsVlJitC+c3QxCEHdMmwfNvo2CXpu+3pP17H6Zf9COLt/3O
         w4aANowQIskdabSjDoKBSB+vREAFpTC7PpiH5JMpJsF/MpDm+xryH5qvNgUDTlANGt/S
         c7AnlPWursHQEMMZ2S/PQqy8MU7vHx6Q0dn05u6ASjUZD/E3CCdgJl2CuIQI7dz/X8Tz
         axMClWvXhQmkQYRQJzF42nHVL4Ww/NQwRmKO3btjLkiq7cOVquJ4biBQIH0xvnOuxuPo
         nCnL6s4Cs0M+iL8ObJ7ZwNmiBX6JZRrlvn2XP5rmYwgOOFQn/fHzwnhK7JFnwdiKCJh1
         TMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760467793; x=1761072593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8y1PCk7CyqsuON9JJ7jFfE0RrSjGfU19Q5yPhpqNjM=;
        b=Epcs8Oe5z/iA6bQVuRZL6LKS+v+fk2MmX9QcS6trb3RhYtYJQVsNnAFGe/UaY9D95R
         1th16iJbd/Ag05/XwXySkR35K3zTaH81zReXyxyK/P3cVg9tfOapLULey0qbJ03Hc4iR
         FJUpuRtBiozFjGyBDvs0OywQauyVxNQEM3EAd1fiWa22gCdkoYPUuwNAcpducDoRG4MF
         VaW/K3O+Xy+8826c7tsIvlsoixSxWKOVsShl4jBTW+2NrWbH6rMYVfmT0wdyaS6Dex87
         MaBYjSLpAYFCd0gqXGfdKcPt4JRNkBWOFDO8JbfGt9/ccsrvp7gUmnREFKLCrFoyYELp
         JItw==
X-Forwarded-Encrypted: i=1; AJvYcCU0GLCJLMgMiGzkLXIvwuK3EIJmoRVs4brEv/Ic5bbrgso4qg8vUIgwj/0WvrndsG4ZTAvA8w0tctg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTUmRKHgUmNYyTsz6iHAY4guSVPo1JIaTksjpBDoX+A+qtInT
	D+JvxdQV2DSGTKCpcKkDP6+GwPYC/r/orqDJFVpFrFFnyRU+8QubLwyi
X-Gm-Gg: ASbGncvA6xEqbRrjlkO3erz0vNohmzl9zCOVtgWAFNbYoabFnz3JBvo47M0exxyG0AU
	SshIWnXNgytKnEp6zcsfsFscF/NtmlYq/dA1VNnT2A5jDSe5Yf/Hn8q+fr3gnUaLGI4K6LX4PK6
	8Xf+aPzwgI/2bPupoJjR+nEXsi+wRF2phjeIxQAasZbGRtDjzD47P7GFTmncmDkZf4oi1gJXPvY
	cmkpGVFGvw6DgG5u6CAHbUKcky5QGEYWBQzKWRJP7M5mBsGfQA1pQWSlzR0GwSEl2KbapPD/SSw
	kcekNGrpstUYmHfE0a/+d6ia1Iy+NbHcvYvZ+7LNRPsKuUlV/QintVbKzc/I1REzk4pFoq+MyHM
	Ro2jM4/qxSI3dm6V531CsiQscwCCYIb/TAl9q8AYGu+LRD4n3ujCMSRc+wVcoF7uhLCLs/A==
X-Google-Smtp-Source: AGHT+IEH6d1IjfTea0ud2rPM+TRuMwjthPBgm8nzMRmg2/IrFgebaJBKQOOqZENx+bKdPBRqgq7kYw==
X-Received: by 2002:a17:903:38c7:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-28ec9cafcc7mr327649645ad.25.1760467793106;
        Tue, 14 Oct 2025 11:49:53 -0700 (PDT)
Received: from rakuram-MSI.. ([2405:201:d027:f04e:f00a:2e90:a424:4c03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm171560565ad.13.2025.10.14.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:49:52 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com,
	khalid@kernel.org,
	dan.carpenter@linaro.org
Cc: chenhuacai@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe() 
Date: Wed, 15 Oct 2025 00:19:41 +0530
Message-ID: <20251014184946.111325-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: ed5bcdca-9a6d-4144-acd7-1c1feeaadb0f@kernel.org
References: <ed5bcdca-9a6d-4144-acd7-1c1feeaadb0f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Uwe, Khalid, Dan, and all,

Thank you all for the detailed review and clarifications.

I’ve just sent [PATCH v2] with the suggested changes — adopting devm-managed
resource handling, removing redundant NULL assignments, and improving the
error paths using dev_err_probe(), as discussed. I’ve also updated the patch
title to better reflect the nature of the change.

Appreciate everyone’s feedback and guidance!

Best Regards,
Rakuram
