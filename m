Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6523563E8
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710314; cv=none; b=ibmOw6bwgGre5dsbXWvFjY4ujv0THAqyG0JrgbnxVnOdPxhq0kgPMdhz8+4tqKybvuIJhdmGeEnu+qZdTA8t8IKWut2qL9J1YtJFxAvqP4xjEaK0X6WQ3MX2NwrpSYG5/wapQyFMQTSRDVDI/mzZL/AGCov+ZUrTrDx52vXia9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710314; c=relaxed/simple;
	bh=htEuzEmbAANSd2NWd0gcoK1HL1K8b3dHWZLRLf1gSbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfDTrPRYL90dcR7dNNx+qremnQo35EnmluEJeg5PQE3Q2jXWlEbW7h8gqvCFQTy6NOXC5BvfzQysZf36ba7tqMK07JwmxcmfAjtK/bR9uzTUA3Tyr+AapGALNDGULOZzWopvhe9AZ16uFMXDdCVDtQukryvBTKMvxc0Ia0yt/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZDsshbN; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZDsshbN"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124b117776fso1020485c88.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769710312; x=1770315112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htEuzEmbAANSd2NWd0gcoK1HL1K8b3dHWZLRLf1gSbE=;
        b=jZDsshbNT3BXJsZMdMoOhjt8mJDXGgS3XhLJaQAb5OFfug+j+LrSW4MZIo+quswvvX
         65KsIBpER2Ev+Fa7sYHt+Ctcr2Td7hi59fzvRCltlp+FeJWopdCU9D0DVHJT1LCNL9nF
         u3UwaL2de9o8ZVIhtF2TxOI4DheiSNpbO3AmePAHBW1dux7b6dkbEsAvcghtHSDdimM8
         PehDWsL7wAvBlAwcvzfXFKXX2Jl3psBKXOqrOTgOqTLpD7W2vc8lkSZwdQpDvnpASIWr
         BZmY9Ug0MErNw/X2YrsJRJIKoqfqnM+p9irzxc71gVH636C35e7VuOdpybPE13ZtblPz
         YE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710312; x=1770315112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htEuzEmbAANSd2NWd0gcoK1HL1K8b3dHWZLRLf1gSbE=;
        b=azuZpOxUlZnx82w32zKGm6c4G97y9hIZUcPfxXANAesep/BH+fYVT8fNcbZPTZkQOz
         FbaKYb+G1lopX2VjRc65CnNITZx0rWHOXuxk05kXuR70jfA0GN0yn2jSWdX128BiobQI
         e9XEJ/cK6dYXzD7NaZyV0HRvFVmnihUG5sF+qhPihexHGZgzOlUM5p1XDqVUr2qsDUVl
         i7yrynkFcnxQPXUY40C0Rh217lyhHjYA3HfBCND1wsVHISd08uEAFyYCr30b+iTrMLtb
         FUdg9CiiFwh9qM1aZ5jAB/n02PUmifLSIaEjQZrwnLroBJbw//Q3YsTJYo8x7Ga41qXA
         oPJw==
X-Gm-Message-State: AOJu0YyV4KLitCDg94+0wUUn1rk5z/MHCt7hO01PlihhUNzJqgbgwgS5
	tgGYLFaZsApUHQfJLDJVqfIPnKAJxok5FZYttT96KdOLJ8n3oJY+t0tu
X-Gm-Gg: AZuq6aKp3M9iFgRvaYBU39ATuVw+l7w8vt6El95JfImvfghwgj4Btkul8uwK4ekLP6E
	EHWUTBluE+qbmhyXRmdc71TEVl70HiQwQmffjVAgEQw/6Cuw27C3AUGVlaSqGYYNHuT2XKYqBf9
	6/hqM5ASNTzGYpQrOHgLXgm1wJxoTvx97vrbDjIfVrOgcQrIAq2Yxx3y1k51j43DEe42XcARPgc
	GMixyRoYyCNFvY3OF3c1vaRPBndSLSe91+hKOP8tqi3Pc09ZZG0sdq3K2Ere1VS/c8/k9Nd96k4
	ryZ22C3w4VhpFtlUG0xQom55SVG7qIn0ql1Eo7NSAG+YZJIIhygDskylJby2BkD+Kttbnm+5KB6
	PsmB+CChv44M6xIVRo2HwpctM6gx6mEY4wh4gttfT0pdZ63NrETxVdgGWshDIcK1mNRuV0LUqJu
	a2cSm7Lsr5XGXubSPZtnHXWelwav3dCX+dLCA6Ebs7sg==
X-Received: by 2002:a05:7022:660d:b0:11c:b3ae:c9e9 with SMTP id a92af1059eb24-125c10055b6mr175235c88.43.1769710311679;
        Thu, 29 Jan 2026 10:11:51 -0800 (PST)
Received: from valhalla.localdomain ([201.75.187.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a17083dasm9731168eec.14.2026.01.29.10.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:11:51 -0800 (PST)
From: Andre Korol <andre.korol.dev@gmail.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: loongson2-mmc: drop redundant memset after dma_alloc_coherent()
Date: Thu, 29 Jan 2026 15:10:59 -0300
Message-ID: <20260129181059.2819-1-andre.korol.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAPDyKFpBq=UNLnMmW97Y0jLvu8eRwt_Y6gf3ZGkd8RBqS79yZg@mail.gmail.com>
References: <CAPDyKFpBq=UNLnMmW97Y0jLvu8eRwt_Y6gf3ZGkd8RBqS79yZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks! Appreciate the quick review.

Andre

