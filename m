Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93631421F1B
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927140; cv=none; b=earVoKMYGYyUhnShOvilKS7BybdHoAP4uucKkbGoygb077+KqP57SGvDH6cTJ0gFVeuZU4eL9duoOpk+kZFcC6qVIJLHwHKRTFk8K6UZr/XFJvWIVgRFBF3H62RO91ZvymJKvZbBrQousN5UzVWVwcvIXAhjOxxaDWQ+1YzMwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927140; c=relaxed/simple;
	bh=eP5zT19otmavZYh5jnGMqz0ktdAeVJgmyjcd+gz8ImY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJeG7t3uDnR6CCBVOhlapGQ/cXzFUDI8J1R9J+zEMrDAgxNrqtKxqVmEsH1GYOqDO534fESa9H6I5/VyKwXEofZwS8gQMf5kbe0+30b9IXXPBhqgVxf+BL5/ptK11MHWmneN/od4UD478S52+FDX9Cn5DPcRf77Bmhcvz3zVFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V0u4IeNp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0u4IeNp"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca12086c06eso677913a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785927138; x=1786531938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=V0u4IeNpm0UBpYa8FDO0F7/a5R1KA1+Wpn44fLWP5imSktgLrFafUz1pXukG5ttxWk
         GHqaKugXaJ4P1Jl6HLJztnU/JpxaghXo59+7I5THv0zLn8Y7ZPTkT2yhpMmdoCxmM/0d
         8l5uUACRbbpoNAzbMoSEZcYrsjh8HTLLRLIxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785927138; x=1786531938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41H3P09sKw8wwkKnWV642RHA7jFSxWcxJqByp/NmDs0=;
        b=jl+gY5YbJSqoVftqKKsBR6VvUrHazTBp+sGt8osbTavnJiYggQftWSyQYk9kkg94Sb
         DM2h6esN+OGXTdMsA+5S6cmwJD+/os/SN5OFvWyOUe59VfmHbvVZFMWyS3bPmAQ0swBw
         fI6vUj3U3ObLiMeIQf1Qww1cxHGYmuuDxJANMiad5I4MuyvlEj/E3YtxDiJAgcAOnOh5
         7uRLiMSCSe2bNpTCeJgQqNfYrra8VwAzaijcBVM7p8t1Sctu4bCdsnMA9WvHoue6oyfi
         Jxu9F1uNbLpR9a3/FZJ4HaXM9koNw3x8zxwUX9z0GcFF3AFbMCmqRtDtA9o40VFzYJvv
         PfFg==
X-Forwarded-Encrypted: i=1; AHgh+RoR6TA0teZvd28KWBNaUi8UqleA5l6yhpYLJI2qkto7wGic1153+lm296QqK99ps9CWYJtiLRKpuiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Mdns5Ly0plz9M7QVnCx4cuBY6XIRFGqvRy2STcmcDyL6yE0I
	0SWEmB6b8X62Rdv1jMTzOHN96RJ1FWtqimNlOvrsEAEpCyWixeKh4nLAEs7HyvyqiUOvDP5Ot91
	AU3Q=
X-Gm-Gg: AR+sD11cnkwfWp7JKWa1nv1/oQFGQAC3Y4sBk00X3qChilgFFrf+pnQI/a8KeaVn5yF
	NxhBw6wCJFpgGR66fXC7qFJJVPqQB8N3EZRMa8jKxRoslZTuHsVUyn3G0utkuC+hUsfbPqOEHbC
	KB/aHWAbCI/BwxLZYWOn9mtfxb/6xNZZAu4nLmSu7BcEZJ7cEs7Lo12+JB5+KqaJbyuTO40aWPb
	uwb2y+N3xrUXal/DwHUsK/CgT5PE3mTI1vhCobQX8bazkhkSpwC62Usf5G2N9098AosA+FfaqTT
	07IIqSdJSNflMTqOPSOAzLPSDoj/sHv7Q/peSDxOnIzzWqJpnVt3sPRv7nfqsfxPqIZGm2RRWKb
	6yORlFEo4twtLTywHWlZHlktO93APQ8+2ruvonsOaq45QFOklLuzP17u2QFjbMghn5hdqWLwpVR
	umpubm7zOCLKOp9gVbVsNEBH1OtdX+XoIQq/lBtReGqdHVa8N3aMZ1FC5z7QHMtGhf6Cjv8TxN6
	AJr76/Uy3ojWokqi2dfoGDVYw9S2rHFWpZkYKQ=
X-Received: by 2002:a05:6a21:4685:b0:3c4:3321:4fe8 with SMTP id adf61e73a8af0-3cb85dbd1ffmr7117853637.14.1785927137918;
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708c0e7fsm1281577a12.21.2026.08.05.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:52:17 -0700 (PDT)
Date: Wed, 5 Aug 2026 19:52:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: freeze device queue before device reset
Message-ID: <anMVoqIwmubZj3wY@google.com>
References: <20260805021854.1057715-1-senozhatsky@chromium.org>
 <anMQTJeiBZUHX2Y_@google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anMQTJeiBZUHX2Y_@google.com>

On (26/08/05 19:29), Sergey Senozhatsky wrote:
> On (26/08/05 11:18), Sergey Senozhatsky wrote:
> > Device reset does not take into account in-flight async IO
> > requests so we can free meta table and reset device concurrently
> > with those requests being executed. The block layer guidelines
> > indicate that queue state should be protected by blk_mq_freeze_queue()
> > during teardown.  Freeze zram queue before device reset.
> > 
> > Fixes: cd67e10ac699 ("zram: promote zram from staging")
> > Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> lockdep doesn't seem to be happy...
> Let me look into it.

Actually I need to look at the report again.  I suspect that we
maybe don't even need any patches for that "async IO vs reset"
sashiko report.
