Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733ED1EB2F
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393053; cv=none; b=YfsQ1sdmXUT0XBsOdb2iFNLwpEkC0lwafTj2jGLjwptfPqUEG3R2T52a/6ImTPGksY+9+gbsh0BPvQUNCWy0kgHx1b+41mMGWu23/GbjXoRVZr/N3GT2SW6/DoukBaeQzEaLa8reiarsQ3E4sRdbbTORlsOfRiqbWCdBA9Hr8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393053; c=relaxed/simple;
	bh=bW4crBIy9PqA9JTflIEcujZLjdIxJW8V1rpT69gqPkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=esQgjMJN87USlbQafMF76xIwYHFFsAogMdrYJ2txX93MprMwEiKg5dQYb9YGFEpvqLFaJIrLR/TvU3WdLN8RMJFtEXvTTPR0eCmr0cvEV9fmkDeJ18AjSgLuImlUbIJOkuDxyHF6AhafyCR1njkC7zcBfmJQlrFNc5fArl2SMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aDrfu7Ua; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aDrfu7Ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1748393043;
	bh=bW4crBIy9PqA9JTflIEcujZLjdIxJW8V1rpT69gqPkM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aDrfu7UaYHEsGM5716KG0K+1v8ehAR+fHjDkTlTL9OlVwzHZqwZoUuqC8qfIs766z
	 MBeP9oD7moryEudsoNWE4xMLYoa2TUmleQY0TtBxqcjlkS4tykuSS83O7fFUWZLxmj
	 qLitCvUfZCcEvqpahC14pyyJs0TkKvdEw4vKDc8djXf+lRm7xb/w4zDLqDDYzCxIdO
	 V9t0qvSktbdHf5lK67zwCYoL0Jar/hESdviRfPQZ/1X2HbkKJnnR6kLhLn9UyoEdXP
	 I3ZjXhu/cDF2CeIfwTjbTOFWPlTI3aLJ/gb+eh2N4dNSqbvPtLjKg+nKI8lMcO+T3c
	 geXWB+/rlA9MA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9BE6C832CD;
	Wed, 28 May 2025 08:44:00 +0800 (AWST)
Message-ID: <753cd65ebf659972c8a33e5f8e579b9fa8738682.camel@codeconstruct.com.au>
Subject: Re: [PATCH 18/34] mmc: sdhci-of-aspeed: Drop the use of
 sdhci_pltfm_free()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
 <zhoubb.aaron@gmail.com>,  Huacai Chen <chenhuacai@loongson.cn>, Ulf
 Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, Joel
 Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
Date: Wed, 28 May 2025 10:13:59 +0930
In-Reply-To: <dfc7e01a6134e421ae3aa8da3221f67d59706d0d.1747792905.git.zhoubinbin@loongson.cn>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
	 <dfc7e01a6134e421ae3aa8da3221f67d59706d0d.1747792905.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-26 at 14:06 +0800, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in
> use,=C2=A0

This doesn't appear to be true? aspeed_sdhci_probe() calls
sdhci_pltfm_init(), and following that through eventually we call
mmc_alloc_host() (the non-devm_ variant).

That said, there are some error paths in aspeed_sdhci_probe() where we
leak the object. Improving the code would be helpful, but my
understanding is this patch isn't right.

Andrew
