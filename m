Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22AC3F65FD
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378097; cv=none; b=eTXfDnrZuwLhNDdldFOjEUCCxI8Uqp1tpmkUQFIJc2IKaJFRu2bKG1OnBnX4vZhIAu88IFBaRKcPOvMHk7BtpgyVAdAxHOpLheVVbKfjCdFv8keetnW1V6ZiK9hxubDKx/Z6IL9WP7xe8L0+zoPN00zLAYZTlbDcuuCWTUDYZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378097; c=relaxed/simple;
	bh=u6oOk1X0S26SCObLglImxKOc7Oz481CGlkuridd3b6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL5pmcnffIcq3XCnRinGjDUkZ6hbCf4ovbRHlKwBdG4w0BIyH2NUiK1kftRlXJU0soaSRoG/0GEEpedTqiyxjHZmglEvX5vu4pjrCquuS0Dl5ukJ8NXhmR+a/xVaMiru+Q/dgGLy/OS4Xj04V4/8S07+Y+j4lGuD5UxaQUhW8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JSWuw/Fe; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JSWuw/Fe"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d751ef36ccso2225999a34.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774378093; x=1774982893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmJZ2IWyqe9C+y8W974uEjXLq2yLBMVnY6/rqpsVLYU=;
        b=JSWuw/FeNBtzQtbW4Bdnh2QvwNj89+LGzfnG3X/NI3RoXCyZKcr92JSH+2DdCYGnvg
         8cWyjHTq4eGYdRcxJ/0oC4dxBiXoIMzrlQ9IadW7uwOsIHvLzRKkNlN3mod2hMbFQIAy
         yZYoeFPw+NBj3GBYoSVSPRGf6JjRQzgiDUT25HnMtJmnPqByEJhlCbbf4RJyucN5Eqn6
         2cbKQ2SEBuJ3aZ+UmuP9GdSzsX3sn3OeIfNKExtlblyiN5DvW0tltXnO5j/e+R6bO27W
         SPmKHtATr4oPRM15UjcDwF2bVsdbnYxbz6klBL7866RQDJ7CdGfNhcuAv1/HpldYlAGA
         lZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378093; x=1774982893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmJZ2IWyqe9C+y8W974uEjXLq2yLBMVnY6/rqpsVLYU=;
        b=Qgk/lEaG39kLFq3EEb4iffgZaiNLfG/Z3DC0DpXBDUVhUj51a4CCVAbyixbRt6FHRj
         DHk7OresDOw4xJPYvn8jJc/eBqePv61bNE+uELeLxgzOPqgu9EAY2sUCUe8Qlwb8sqTj
         tJpIUXH2JZH4uoGA8DNB1pGACSnLbxJCdvHLbcd9nTv272J0GBvDz6EufhjL2W2X1LwI
         BAU3xGeI0qwuwLD1m/VfA9iE562bUlcWGv4tyJ/6hSD0B0x4QsfngtGuo8HYQhQEHeAA
         npL6+3oY5qf/2Xl8mtR2blgph2IsNDSTRndtiDATKsCpsUW2+r1DB4hZLZlyEHPYRI8c
         KboQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYxo3ZX1b1ZPDv+vaGDQ6St2EEvcMEbzWSFmj4w2T9weW2lE8fkLqYKdWVv7XuObqAXUshNBV8cU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuCzULrNX5O+HpXN/37ntPaWyd55fRQyH6vZZx5Vyoh55jgMW
	l9EV29YQjfQUAo4C9KqP7vqtQxTb/BGVVyHo+drSytJkGVRNiRSwib7QVEB5WhYBXCk=
X-Gm-Gg: ATEYQzwEgZC5cTr7P/HXIjT5pQs1NdnTG9Phsn4xLf8BbH6TtYOUMfbj+WnI++PZZXo
	WBlQw0IdZzZ4HHesXq2YqLc/vYl9awGzsZc/AhNvmSMuntaYdHLy8eFlZU7NW06btisy9V4GcY9
	Q0FAjLLAFLLL1OVJxApPQZoDN+wxcdNgjEUKHX/9UJ1sLcjo/w/wR9p8HqxM1iqjkMdx2gdXHxN
	DZZ6FCpO1cypZGRYDKugRStFVloELHh1NDdNNvXokIPeznTIJECjxmbcHrRN47z97XEN/jpzGS1
	3J+g2UbpG+OU5OCnnaV9CLSUuypkF5qXYFnLsMVa058Pbu/JIAADYWOuk7aaqbANbR74jD3tQ3I
	WKeVCFZkkVlhaUQhc31blTdz2aPu/i6V9XdrVeXXPbiVRxg4+avbHcv62zBWdlxaxy2c0Oc1wuS
	LCFDSr/CHp/R0/e7H3W5H9ybKyTVJmdmCt5v3DeECNVerf1+x2J6QPyvop5DmCvy8PpTipWtf34
	ArMWKi7OURfiZ4azBg=
X-Received: by 2002:a05:6830:258d:b0:7d9:9e43:b8c2 with SMTP id 46e09a7af769-7d9d68fce31mr269547a34.22.1774378093231;
        Tue, 24 Mar 2026 11:48:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae1c959sm12274619a34.23.2026.03.24.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 11:48:12 -0700 (PDT)
Message-ID: <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
Date: Tue, 24 Mar 2026 12:48:11 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
To: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324143448.2631888-2-b-liu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 8:34 AM, Bin Liu wrote:
> This new flag will be used to handle multi-block transfer failure, in
> which case single-block transfer will be used.

Maybe I missed this in previous discussions, but why can't this flag go
into struct mmc_queue_req?

-- 
Jens Axboe
