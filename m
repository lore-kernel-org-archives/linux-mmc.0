Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAAB225413;
	Wed, 26 Feb 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598215; cv=none; b=IgiEY1twAqeCj8jJbVYKfW+34XxqPy15ublxFVPzXSQRHcUNK89ARer+cZ3p6bkcmoP8fQ31b8tRGRJEOwL4phVNpRt270yIR0TzzKJg/ejIoY1xXX2nRAPhjo0iQBj9S+pHivS0WRKPw14NSHv/7W0psqIyQdtj0rgEnnx788M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598215; c=relaxed/simple;
	bh=gWaTp9bD+OUcTj6NoK8/bNlesYJYBPDzTDOzvI75MYw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nClhtiNXXKfbhZIQG9xolj4HtwDzdXdDmGjqQUnx26t7kG9l45VXXyptAPDQDrYQ66g8RB5rXOicaBMjkH9uElc/8zhYmera1E7XSQ39Fz0SCSAhFsnIZhoCliacbYVX3r1+m2O5ul7vxhX0hXdZfL53CoX8AYNLlWYcQIE3xdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MUigq/IT; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MUigq/IT"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740598211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibDkt/YwZAslRM610E5YWbcK7AITUoO3iRtmaQFSdf0=;
	b=MUigq/ITvu7iFX7rXz6ixyHDpu3rpghRH8pKBBRhLIKb9hUY8zUX9JMV+kNmHDOAxvkGlr
	rYkfT7tdCzQdABfSzztIKkMsM95zBquukQ182YGMrN+POaaEJPBZDgAeAHcrQlNkTC00Ie
	Y+7udB3nHDnEo1w2uMWVOk2HP1+V9gqKpUsZ5BbAZIjEvo5DttroDSxm9SMuX5RK5uOSWx
	UWQrm24ypvFfGtuX9aqteep7UqlxpGzuazQJrsyPvt7RpnmODTHNbtn8sLrCyc5ftrkZhZ
	aNJ1nClICk4jhZ4Z78C6PqGh4Jr8GPDBnQsSNQaTwCrM966RO06yOKbMP6lkHQ==
Date: Wed, 26 Feb 2025 20:30:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, git@hrdl.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Trim trailing whitespace from card product
 names
In-Reply-To: <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
References: <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
Message-ID: <72e30ae1c761ef4a9d2c7ba9c7c8fc9d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2025-02-26 20:26, Dragan Simic wrote:
> Product names for some eMMC chips can include trailing whitespace, 
> which
> seems to be rather uncommon, but makes emitted messages and /sys 
> properties
> somewhat unsightly.  Here's such an example from a Pine64 PineNote, in 
> which
> "Biwin ", as the eMMC product name, contains trailing whitespace:
> 
>   mmc0: new HS200 MMC card at address 0001
>   mmcblk0: mmc0:0001 Biwin  115 GiB
>   mmcblk0: p1 p2 p3 p4 p5 p6 p7
>   mmcblk0boot0: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0boot1: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0rpmb: mmc0:0001 Biwin  4.00 MiB, chardev (249:0)
> 
> Trailing whitespace in /sys properties may even cause some unforeseen 
> issues
> with some scripts, so let's have the trailing whitespace trimmed in 
> product
> names for eMMC chips.  Although not observed yet by the author of these
> changes, the same trailing whitespace may appear in SD card product 
> names,
> so let's trim them as well, which can't hurt.
> 
> Touch-up one commit as well, by using proper capitalization.

Oops, s/commit/comment/, sorry...  Just saw it, a few seconds too late. 
:/

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  drivers/mmc/core/sd.c  | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6a23be214543..1522fd2b517d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/sysfs.h>
> @@ -66,7 +67,7 @@ static int mmc_decode_cid(struct mmc_card *card)
> 
>  	/*
>  	 * The selection of the format here is based upon published
> -	 * specs from sandisk and from what people have reported.
> +	 * specs from SanDisk and from what people have reported.
>  	 */
>  	switch (card->csd.mmca_vsn) {
>  	case 0: /* MMC v1.0 - v1.2 */
> @@ -109,6 +110,9 @@ static int mmc_decode_cid(struct mmc_card *card)
>  		return -EINVAL;
>  	}
> 
> +	/* some product names include trailing whitespace */
> +	strim(card->cid.prod_name);
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..8eba697d3d86 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -11,6 +11,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/scatterlist.h>
> @@ -95,6 +96,9 @@ void mmc_decode_cid(struct mmc_card *card)
>  	card->cid.month			= unstuff_bits(resp, 8, 4);
> 
>  	card->cid.year += 2000; /* SD cards year offset */
> +
> +	/* some product names may include trailing whitespace */
> +	strim(card->cid.prod_name);
>  }
> 
>  /*
