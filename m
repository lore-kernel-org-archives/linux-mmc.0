Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD98E56E;
	Fri, 23 Aug 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397727; cv=none; b=hRCdkNz9n0ec3TVEwOiPnPcJWaVQgjfqPHu9hCi2FmXdgh2mgybPi9fC/psrPIoGYv6Ia6+d6G2lIsyPxskCnsQsEmss9RDdR6mxyWw+X+Y+KhCSytaYUqWjCyKp1/almQMbFB7WuZQJKyCSgqoHpGk5xCXriA4VmWEnT67rMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397727; c=relaxed/simple;
	bh=TIhiMy37UXgKyfiupijbGue46YJqQNN2t6xwa8W4IhA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F0jnU5bsiO1zWG9CHCWG8e+wF9ISqiVDcSiLucguOb898WjPPI3u5IRi4TB35PMEnM0zpS+e8gSgzw7DBBGZZ9j8XyN26usuQeZarFXF33Ow0OsBYhymI4GaALBrCAWHfH/7P04Zzg0mj7zRRB4wgp6dXpzTyAN32SeMzE2tyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ld2mHF8m; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ld2mHF8m"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724397723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btD3xt9L+P3h8tgsm3JGoQDXmgAphYNLsFz5HBadb34=;
	b=Ld2mHF8mJCL4JXA55cv/rVFBBq7GmeD0QtkO5FbP04zltw3Xf2zUKlA1vFnsFnKFJLbeYF
	xcf7qaRtczw95FAq5q9MNWkZ2ogWuFcOy1pAOVuhNQUAtbj/Pjgheslz2be7W3n9In+3lp
	VrF/jOE3f9SK7jtSEBNrphMN8/J/uREKqS8zA0nO9pjT3mRsJipKrLWkjpvHpQB1F1IFQl
	ncqKpWTWWDo9W/TiBJrSJljKe9MCx0SgBfkpv2TPndzxB20zwOji7V/EzqzAfyvkIOpUDW
	GitOPhO//5Za5zWkz/uxQI0Ans4REvLVXVynXAnAIltqhdPKfL4T/cJXsmn5TQ==
Date: Fri, 23 Aug 2024 09:22:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, ritesh.list@gmail.com, grant.jung@samsung.com,
 jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com,
 jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com,
 wkon.kim@samsung.com
Subject: Re: [PATCH] mmc : fix for check cqe halt.
In-Reply-To: <20240823071025.15410-1-sh8267.baek@samsung.com>
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
 <20240823071025.15410-1-sh8267.baek@samsung.com>
Message-ID: <7f81eb0943674983f771bbb292e0566f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Seunghwan,

On 2024-08-23 09:10, Seunghwan Baek wrote:
> To check if mmc cqe is in halt state, need to check
> set/clear of CQHCI_HALT bit. At this time, we need to
> check with &, not &&. Therefore, code to check whether
> cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
> 
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Looking good to me, thanks for the patch.  I'd suggest that you
resend the patch with a proper "Fixes" tag, together with the
"Cc: stable@vger.kernel.org" tag.

Maybe also reflow the patch description a bit, to use the 78-column
width or so fully.

> ---
>  drivers/mmc/host/cqhci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c 
> b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..3d5bcb92c78e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host 
> *cq_host)
> 
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> 
> -	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +	if (cqhci_halted(cq_host))
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
> 
>  	mmc->cqe_on = true;
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +		if (cqhci_halted(cq_host)) {
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
