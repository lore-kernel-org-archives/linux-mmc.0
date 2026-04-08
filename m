Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE620347FE1
	for <linux-mmc@vger.kernel.org>; Wed,  8 Apr 2026 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616249; cv=none; b=Cw/3AoHAz0zR63z1ZrpWAZlq3HsOdafAhEq+Jj5Tc8rMjiYzOCYXuaaPZ/XDy/erCezJfLVQopY2DwRJCCAD3ccKt7AS+o/iE0Jrw93sb1G0z8Egy89yZeG1Q8t9nE98jsD7coII8Asj0L419C+DmwJjO0KT6qoL8NDJC1j+C0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616249; c=relaxed/simple;
	bh=VcM5fLHD7TrCBeF0O85OmJSI7q00mW8caga5IBh8usI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Otn5Afx3GXCPHhmkamMEJAdU4PuEb3wEwxHrHPV6PryzDYvzycOlFcDLKKlLHP19s3wqjrnKpkMEkKSIUgNY6RKqv9TCd4RwptwC182M6xPFu0vKM/FBc9Q1yD7ukbvtUHnoM4SKxCbzzGYoNb1JhMUKccsBoUJEkbO4E8q+9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXT6GQUg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXT6GQUg"
Message-ID: <3c81c802-ecdc-85e5-fcdf-aecf295f90b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775616245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FsEC0/7UqJuLluM8xnbTXU3i4yZl9YDCKBnR8P7Fdg=;
	b=hXT6GQUgc0WaxU2OfgPpF5zhLz6OWWco0+J+6h2cNMMY0ZBRdy2WUxuJ144+BLto5xrrC5
	m2y+T6gcgHJLhBoxBV6mEW6/OxKf6R57R4TjD/yHJRZ6mI/yy6mIUhCbGBYPoiPPjDlDXV
	Nt0LzgqAtWsULHAQUs+/yo0/zBgpAMo=
Date: Wed, 8 Apr 2026 10:43:58 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: shawn.lin@linux.dev, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc: Simplify with scoped for each OF child loop
To: Hans Zhang <18255117159@163.com>
References: <20260407014033.1305033-1-18255117159@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20260407014033.1305033-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/04/07 星期二 9:40, Hans Zhang 写道:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 

I think the key point to use scoped version is to ensure the
device node reference is automatically released when the loop scope
ends. It'd be better if you could highlight this in the commit msg.

Reviewed-by: Shawn Lin <shawn.lin@linux.dev>

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/mmc/core/quirks.h | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..93bf79d79cec 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -213,14 +213,9 @@ static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
>   static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
>   						 const char *compatible)
>   {
> -	struct device_node *np;
> -
> -	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
> -		if (of_device_is_compatible(np, compatible)) {
> -			of_node_put(np);
> +	for_each_child_of_node_scoped(mmc_dev(card->host)->of_node, np)
> +		if (of_device_is_compatible(np, compatible))
>   			return true;
> -		}
> -	}
>   
>   	return false;
>   }
> 
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> prerequisite-patch-id: fcb16f319f35ddb88e1668bbe7a8811d88235672
