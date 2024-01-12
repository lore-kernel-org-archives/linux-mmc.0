Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4A6DCE7
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SHwdzSz7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db1bbfe67cso403497b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705069339; x=1705674139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ajV3IIot/GpVHonghkLx4zchKYqa5OxQWlzkeczIpc=;
        b=SHwdzSz7U77Q+XU386Ov4TDVVOKW2UvoxKDC/hmfreyGJb8hDuifBLOHCom1h8pQoK
         kxmRlp19EBKDzD5k5SxA217UGLfJhOgsEZ4vySzBo+cfm10hMcegYR3tG1yDITqVmAlD
         a6bUWk1aw8OXn0OIsoLR4HHZdmIgKZOT43tNt6GEifjM+euffyDTWFgpMdZROPxidKHc
         hDBhSYvIFpHb8XzKZBD1nOSMdTrw5YGeOYn9QiBQvxgduuyoQcOBXoXvpVTfnnF9iBsK
         YGKDMj+gcOpnBWLAK/FHVH4AAJTjzrg4XPgORfFNvEI7POKdg7hN/z7+DIPpOtqqDzPQ
         UAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705069339; x=1705674139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ajV3IIot/GpVHonghkLx4zchKYqa5OxQWlzkeczIpc=;
        b=u1FHX3M/HkeaSvg1B/NKqpFTHAVeQyxZfjhheach/XGJ9bAmGnM9qN5DXCIXZpqbAo
         q6ExunDGruSZxL0qWcJiCPTWy4kG+h+99rZeE1K06xAF6IPZoI8nPW8W7kA4yPehOtwV
         Ij6Y7xa8izjWvkEQqKzZ5frT65J9CyXKh5SPUSsqCTywFJRxPQKoAF4vtl4XGRXr50fb
         N80zZyhRdcWA9L48tvOqz0NRXIxmps35JcGXA9wst10flMz6lWzRuNpLjxfNU15v6nUM
         48zruW0vo/JggZgB3Ez+dM4m6B7dmTo5j3qn0vnq5L5itD0r119ZWHgGaxVnpcyA875B
         pRxw==
X-Gm-Message-State: AOJu0YyIY15n9Ta5VQG/ozSQPj/dBwGsCxNuzAeg3Z/sNxCHfXJNNshl
	2Jwvs57jUjkxtvagu/uQ3pK3AZGLjfoG7A==
X-Google-Smtp-Source: AGHT+IEVOCC92o0YswNVmvPB8eII668AcHtWTgt2sHen9v5t5x1j3TpiT4iwJJD69NCgEN1RdO2ZUw==
X-Received: by 2002:a05:6a00:939d:b0:6da:83a2:1d9a with SMTP id ka29-20020a056a00939d00b006da83a21d9amr2109577pfb.1.1705069339637;
        Fri, 12 Jan 2024 06:22:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e3-20020a056a0000c300b006da14f68ac1sm3238620pfj.198.2024.01.12.06.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 06:22:19 -0800 (PST)
Message-ID: <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
Date: Fri, 12 Jan 2024 07:22:18 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20240112054449.GA6829@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240112054449.GA6829@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 10:44 PM, Christoph Hellwig wrote:
> On Thu, Jan 11, 2024 at 01:06:43PM -0700, Jens Axboe wrote:
>> Something like this? Not super pretty with the duplication, but...
>> Should suffice for a fix, and then we can refactor it on top of that.
>> ioprio is inherited when cloning, so we don't need to do that post the
>> split.
> 
> Yes, this could work.  It'll get worse with anything we need to do under
> q_usage_counter counter, though.  I mean, it is a perpcu_counter, which
> should be really light-weight compared to all the other stuff you do.
> I'd really love to see numbers that show it matters.

Yep it is pretty cheap, but it's not free. Here's a test where we just
grab a ref and drop it, which should arguably be cheaper than doing a
ref at the top and dropping it at the bottom due to temporal locality:

     5.01%     +0.86%  [kernel.vmlinux]  [k] blk_mq_submit_bio

>> Should
>> be set at init time and then never change. And agree would be so nice to
>> kill that code...
> 
> I wish we could see some more folks from the mmc maintainers to do
> proper scatterlist (or bio/request) kmap helpers.  The scsi drivers
> could easily piggy back on that or just be disabled for HIGHMEM configs.

Maybe we just nudge them that way by making them depend on !HIGHMEM...

-- 
Jens Axboe

