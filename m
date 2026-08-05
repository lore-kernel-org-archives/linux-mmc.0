Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9084403E89
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925748; cv=none; b=jPy7obdTGovuH3GRFWaJk9RClyMpl9dWiB0W8SMg7jX5lqVST/UCN/PSi1yEzJJm6fh89U7M3/tk7D0FMXyYSjc/BFWCSomxithmPpN+Nl9wPQwC3MEUCCSypLh66xefGkFx5n75R4c/EK6zwPT0IiIv6nhkY/UzxSVRpyBsU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925748; c=relaxed/simple;
	bh=StromziW+40JYZDwey68lBv5UX9Ghm/SOb7iQ63o/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFU3QRR7PJU2tBte2IzC7UZ1B1w/t8gaoc2AQeEHOWJ4F0Fvjj8ICPB2dbSY40FFiRTD5FzhrmCgUsiUGODYWb2qE7ehvL+eOaI8HDD0e7wRbH7zGky7FO2U5tpJZLo4gYetySuzQYfHGp5Mk7QGYpzWL9F0/scB/6kDJPrY124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y/u9Sp6n; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y/u9Sp6n"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so859918a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785925746; x=1786530546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=Y/u9Sp6nltKRLaeAjg5iuymnnM4YPfvxH+qMT2AxrXuXWBvE+0NvZIKkATFM/nj9ki
         MOeQUz5ZdqIkcTDamsgY5lMJPwmbruITBZguLulvcF8JRviXEjZablTihBEMgeE52i3v
         3paA2LSTCseiVqAqg1s1qcPsYfE3BOKXg62Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925746; x=1786530546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxmm2cjRCk3GSE4g/lkjj6zw4WWlmgAbO/trdtnK1C4=;
        b=QPCxUIasifGYXHH1F0nhYYn7yajRBUmUi+eWtUsYGHbzzwaTu27h/Kwh9kX6EsmnGa
         XVz3sgPX1DHjHa0ghhOKb1XmR00D2KW6TtVvnod+2+gJQhE+9xWuyCI8yb7EFAm1nk3f
         Q4yKfwjfyK8JLlvp7n8Aq76Nbe1JGPD/FMa7cl8HvjnaPvdMS8MhEV7wD5YdJz1xGi5i
         eKSKB6bkycCi+5C2e+tnw0q5p7vep8bu8jA6/wVimwcwNOMiBtvhB9VRsUtYeMi2+ppH
         UVMhYSmMLCU7bnz3GMnqjJ3grWfEysN0lDqJo/Xa2JmsC/wnDTm1bkBsetK7vnJDvEyk
         mz5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbUpOTotRFcXKnwGqromqhtT6Rmzzqy7YBBgTd9arg1GKQXgiJxwnZETX9biKfygoS8LdkWXrL6Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0CKoo63dpjfHQXL0ZFoj2FfL+r4lt95wIu2jkDyQjJicyO0z
	YVTeyiXk8kr8PR54Db2cL+C+csBWGZeVpYkfHZpmR67gawYBGonSCJ4MLhi653gZsw==
X-Gm-Gg: AR+sD10kztkZ4ASd3tdUPhwIzCTSWJbAQNKpwBQL/HVmq7cu/FZyY+8llJGxHpdH9Ed
	Zl7qW/OhQD6Y6ApsBsWAlIE2Fo2DcuAbCFHF7T21gtortEc53q8V1VPcdfx5cPCuqhkBUqfm/KE
	OM7Yh8q3XsNdkg1rCF4ymYTJsNVAfjOOmXwUQ+slGWA+SSyieewZBaI1sn+f+wwhGzdb6bwu99C
	u9l+AADf2Fj7a1bca8NIo0H1zrHL4jVRdrec1xKFT1yBgPCcAz4vHJFUPRYRAWIsCsxBL7aLCck
	/uoO4mAwVW4Wlb0Ix0zhaovY7X3XjdgVItqilCVJXyE2yBKQhEyE5WSHZdNaQ3+k1Iko7WixL8b
	nITGgYKlBUErJ7sAcipCH9BY0Hx7cOxwzFtR8GFg15sTtTc9Z5HQTVUToVc+HMX0EBYRslG30tO
	ec1rOIOCzGkPvSf6QFY6JR9g/vkTiUrjQNIWVIxW47FlQA45N4UpdQg7WNuJDXRpSzWyyVAfoHo
	ffEMTiBD0wiYxplDimIxww43ILb
X-Received: by 2002:a17:90b:2d84:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-3903c538263mr5818956a91.8.1785925746154;
        Wed, 05 Aug 2026 03:29:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903914186esm2780030a91.1.2026.08.05.03.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:29:05 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:29:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMQTJeiBZUHX2Y_@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805021854.1057715-1-senozhatsky@chromium.org>

On (26/08/05 11:18), Sergey Senozhatsky wrote:
> Device reset does not take into account in-flight async IO
> requests so we can free meta table and reset device concurrently
> with those requests being executed. The block layer guidelines
> indicate that queue state should be protected by blk_mq_freeze_queue()
> during teardown.  Freeze zram queue before device reset.
> 
> Fixes: cd67e10ac699 ("zram: promote zram from staging")
> Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

lockdep doesn't seem to be happy...
Let me look into it.
