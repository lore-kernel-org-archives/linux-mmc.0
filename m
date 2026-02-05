Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365712D8382
	for <linux-mmc@vger.kernel.org>; Thu,  5 Feb 2026 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262971; cv=none; b=NEN037CA11nUm+RKVcWLlJTIX8yfvWKQYMLFx9J2QcKH5mbOXaX7s8Fu6aBy2/ikS4Man5uN3eKZg/rQxE+fO5lSkT9WewNnj5NyNC+1QXfe4vPd2s1qwPrLUUtZvossPV6pzFPrxhLLXF1a6kJFDC0BZZBpRnctq3d+qwBB694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262971; c=relaxed/simple;
	bh=yTIiCoPaf2axh3yw/BOxlWdHS8hPHmnROAwOuIuJHy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YSxkOF4KPhrRgd9k49cw3h8RKDxJD4RFMmO7DVDhaxFWIKsWQzb7G2EA8fHeB1lht31KVFoyDsJNgUYCJqSaG9XRViB0SRA3JIssv/aZv44g+B25eQKdo6wdC7dMmESmzI3FEF9xb/1SGiKTuaiSnhi8aL6Kq9iLfAmGtvgp6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pLM6QYAQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pLM6QYAQ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cfca52ac2dso340055a34.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2026 19:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770262969; x=1770867769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8odmZP3AsmwWLVEEIesC2LXuxYRFDXqGBxQCRutSXw=;
        b=pLM6QYAQ5CfrvbDksf4Mmr3MPy2EfVQZ1L0qPsiGZtaGnPErGd/Ni6fr/653IYFbRp
         Kc8+qfHniWCFlpXqFTffcTgP1HTKOcT5CTLKCMOH0EUjOXdbJ5lCw6YH2NkQHNsnE4pX
         FWt882SOfdLZCaTdeHLU49v1/ZQ5D/lksOk12qEiN8Kxr4PVDSUrkGJf2D1P8gbEl6Lr
         DAXWfWNVOEgcyeuP/xwIvM9SO8F4NXvAV/GHIr5Eo9hLL3N7h3NJmK5sWt+J5bijidwJ
         lPGaxJg0sHTe2gyh2juXlV2b3xUuFVoGQ/wvG/nCpJ7wjAWihSngNyHrLD89/5Ap73uT
         ZxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770262969; x=1770867769;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8odmZP3AsmwWLVEEIesC2LXuxYRFDXqGBxQCRutSXw=;
        b=HWqRIjA4XxHHwQX3mUbn+XbiBXa9PBrm6v/LXOdIDp7NpHdUsrqmHdeK4sb7p9CreH
         1U1Pyn3FmJM5XisIdueWHWYQOnZgGlpIE5/dLW+LPggtFRTonYrhfP94tfd9dq64N4v4
         Zi/M4UqerIS43cvyhzAp5hY65RI8ozTy2FPcdDXB2vtx97kNqUKTtwm3j+nacsrPHXXl
         P9f7430Qk80TD8S6M8o/EtQFwKZQH/KJYZ6qjtN2qjBd9ApwV4BgiNX39vzBEWXIiHas
         rlakp3+gQ5jgX3+CaoNgBdEMypsQWDtmxaRAhoHL6rbHtCOpOjqOuvAbW3w7wmJfSG0r
         je8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoxIfOvHLd1tkyg1h6nUwqVH7ZhjeBYf6R0f9J7ea+PH4BNi9Lq6XFTmPzM1jqXl8z7Ofknxe6Wkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHuuE4XwM2SGoSl7apyOWcOSlBZXVr+3MLApQw7uAKkqrpmOd
	eZOmKZ/bxNPJXf+l2SP8CcynGBj4MC5KxKIOdzc5Auwd8CgD1xeUxLsBEuAOM0YK1I8f9exMIWF
	Oe+ktwJ0=
X-Gm-Gg: AZuq6aI6USQRM994Qj3nHbZua/ErCK9+zyZMwkjal0ewFvQdsvaOeXwkZQ935/051lD
	ZXoTc/lcrCOZiDkE56zT6W318eZPNw21z3rWZlwNa7adx6QqafMXmCWiKqEONECTQh7Nx3fnZaP
	eblEuPdNyVPnG/VQlDzDPDGZ2pFpotzTldqCx+scwms1OliUfaNyJt9cHDesMTNj1dflSXwTDGP
	kviC6Pc3SgoquHqHmOHkZQbYSV1hSC6dwei4wklhIr3/0ivJMsUjIMp7WIN4c5zRcHxjyJ+/gfq
	n7z32lKWrWknACrAWDdO9UYsa1BDMH92uT23uq+UDYyUvlxq7GG8rjpe1URPJApYNIZ8nGPXK27
	YaiI/2xEk8GY5PhHRBNkMqIaVKMjLP7cqkUJOWVMihsUkvbVg7FPXlCcQp/AkACbYlXz4t6zB4r
	RPKIi1Ockj1GLIl7LzZPmWWtpn6m/ym2eMrcto2RvqkFxIP5vK4YCou7fET6kh94ZFBd0/HDxLo
	sc=
X-Received: by 2002:a05:6830:3901:b0:7d1:4d71:95c7 with SMTP id 46e09a7af769-7d448abb460mr3043741a34.26.1770262969619;
        Wed, 04 Feb 2026 19:42:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f35b7sm2812181a34.1.2026.02.04.19.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 19:42:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ulf.hansson@linaro.org, hch@infradead.org, ziniu.wang_1@nxp.com
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
Subject: Re: (subset) [PATCH v4 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
Message-Id: <177026296860.37701.668895586539274878.b4-ty@kernel.dk>
Date: Wed, 04 Feb 2026 20:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 04 Feb 2026 11:40:01 +0800, ziniu.wang_1@nxp.com wrote:
> This patch series optimize secure erase performance for certain Kingston
> eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
> erase operation regardless of size.
> 
> Currently, a 1GB secure erase requires ~300 operations (limited by max
> discard size), taking ~10 minutes. With these changes, the same secure
> erase completes in a single operation, reducing time to just 2 seconds.
> 
> [...]

Applied, thanks!

[1/2] block: decouple secure erase size limit from discard size limit
      commit: ee81212f74a57c5d2b56cf504f40d528dac6faaf

Best regards,
-- 
Jens Axboe



