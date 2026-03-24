Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8C2E093E
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379828; cv=none; b=ZrcFnxS49GuNJxeHrXgXjn73OcIILwmsYOAA/EWkaPx/6wimANlQoKZTui+moBNNZZ1qugssm6FsiEiXU00lCoOUsYs4NSOvh8VRFD26UqW9ETsXmeVoG3EGsuSczXh1Zgt86u51At478bt1XkzyUe6u8kKHHVIVMo0ncRLvdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379828; c=relaxed/simple;
	bh=+TQM65BJY+ZSQkcGOKw5PuDnu4eV14pMO10FTP7QC+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRMZiw+HjAFjBXyk4HzSRDDWZeAjAIZmTCy9OL9FO9iK0YcGTC0bvU0giRwnit8Nc6shHWnpBxiBbLAR3RegRX0iM/RfU3OVVXSEvr24AZiKEAR3lr103QnGOwDtmMoTRX6EKTMKkk9cWAonVu5rAqR5aNWWkwZkp6lC2ib2QWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jlcrw8+8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jlcrw8+8"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40974bf7781so166678fac.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774379826; x=1774984626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZaGIAvsrvd38uW9A1YrhlXJ/4ABVVpctfYZycfo2o0=;
        b=Jlcrw8+8Q1A8srGeszFbTlnG1P1tZ+cqzjU/S8b4BpATKK1XuyzBEhZG6tsTRj8vql
         LbBF8skV0crL8LJMFVDZKEo/lWAaDMpGW/BzeRace4Flw+z5J0A8vXdIMUOVE5+vXIzT
         YD4fHM+l1paD8gamfgH2EhYg0RESLrOIx63Rgb339FeyLepemsOf0IJZ2qPb6c1P6t3Y
         zy/0a9CYt0UzLsX11LZ/2AOr6vBdOu/CuQnJq8nwMwZblsOAQAlpMHyoQPvDDj3fJf3G
         L6WzlUzezoBKeNndikG6JPASDEQggI8Clb4r6KXV+n6JV8ZIflc834kjqHbgFZgok45v
         wznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379826; x=1774984626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZaGIAvsrvd38uW9A1YrhlXJ/4ABVVpctfYZycfo2o0=;
        b=TZfXpyNR0LwwvSnUsOP+SkN0xJW3K3bh4L6UkqrvVBHAFKw0QiTD1+Of9l3kguRJ7u
         aYTjj1lty0LgibRekO3K1mNSYBRURUZkry5nAymz8UEY14yOupbeCiNG+icmx7aPLxG2
         3M6CgYWFLYj0Za87VdYJ6uChX0rpErH7EG72TsH5yBrPppHegugCEikEg4RzE9PH2KLv
         B4XDlKcohvjis6hXYJySqgk3rxkV+/6xphnBzcbXY0RWOwuVJ/Ix9bj0pTO6j/CQ6zTg
         MN+6tfxTTmNAtzMXOezXOmieyOndwrKUwzMstzIQuQy928Dhbq1iBr4CmWQ9/lAUwAv9
         2vwA==
X-Forwarded-Encrypted: i=1; AJvYcCU5MCfknTEO+qSk3d+680CO/LZIVD64YicwBBt3Ftg7YWBBbM4ziw+DrFVmJqybduKhV1/PIIPeAb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UqJrcYBJGQVtvpEpFCOrmqo33SUULuHyiAK1RDnpBL0VCkSE
	ETZmZBvyRuWfqSeFIQwfx9wgBO/4dAGNeozCo9arrgsp37KTcKG+gjzkUJAxqNqWnqeheQSvjd+
	fF1TR
X-Gm-Gg: ATEYQzw4TjyAI7EXxkiNXPKJsoSYxWgjwM8/40Ij3QMivKzvLefih3Gucvvy3+WGYwo
	cIJZGWGHfGAxRvXNZhY205wEDS0mHdsipYFSSojXIOBh2Pj/H2OWgL+xBvUTTxFRdAKns6IjqEs
	Q8qqNcAUrT6KXK4epFqIMRU+DrNIeHD/mOJ4aCOwTPbBMzKXrQciY7tM/SzF/6hw+lxFwcF2pS/
	preo8qv81gAIrYnEynDzm7IQDBRLpSGGqFlKFuGuN2GZUBHnYJHviSGMSjBlIolx0PDTNt6eCyN
	gpPunaS1bZMvJWwaVhbYgBXXAeWA5ohNpr3O7WTuAhlBV/QjIUYd2+6Wy0UC9FqGXlX9brsBqEA
	1z8fqPf08i8gsx82LDILdz0HmAbaYIdOw+dbHt+LKbQ+Y5Bpm1rezigwcamM0NKWSlC6dAzjQWZ
	QeN+abXS9x6GIOsjkTr/2et3Zi/ftv++7CHpWkIDLik70hyTc0Yo6PBaOU2HO7jpujyx9ba+GV5
	zolJNx3
X-Received: by 2002:a05:6871:e717:b0:40a:5870:98bb with SMTP id 586e51a60fabf-41c878610c6mr2712252fac.21.1774379826490;
        Tue, 24 Mar 2026 12:17:06 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5ca4sm13928550fac.3.2026.03.24.12.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:17:05 -0700 (PDT)
Message-ID: <0c11f560-f796-4ba6-a515-3a6d613f27dd@kernel.dk>
Date: Tue, 24 Mar 2026 13:17:05 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mmc: block: use single block write in retry
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 8:57 AM, Ulf Hansson wrote:
> Jens, if you think this approach is okay, feel free to take the series
> via your tree. Or if you prefer me to handle it, please let me know.

See comments on patch 1, I think that needs a rework. And then you won't
have any block related changes either.

-- 
Jens Axboe
