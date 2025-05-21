Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704762367D4
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821200; cv=none; b=CBxnH4s+JooLVAbRjGjdIwGZhL5SBaOVWhwFfw6I+Ci/WAN9xF5alIC4/JIPdrNqe3QKriGKEEPovKlumZSKnL2FnCXGQjBBxcsFvg+U3s1vnROUhlLLLS/QsJ+M3uWFHHvliCHKNsPDaGC3WL00v2aQTzB8HkbeYl4YoQAC7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821200; c=relaxed/simple;
	bh=NTJzN20q+36MQF1iYvGUm0Ef0xWHEEbxpCxDz/JhkEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdqwg6fVDFviEozb74NoXRwdDwUawlq2RcDnjcBj8GaCwuC1544+W7C0AKyPX8KjM669bsvkBVVjkepRFKwcInV5C1cZbqUAgMfZxdhS0gZj385glChC9eg6/jXOpEjUi+BWHUavyL17zvJZu5nbzWTr3zx/LY6AECageupMyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=hTyjUe3n; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hTyjUe3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1747820883; bh=NTJzN20q+36MQF1iYvGUm0Ef0xWHEEbxpCxDz/JhkEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTyjUe3nf0JY9MBFJJb5yLaTooYXDCKPuPWbbsVpzzAI5u89buBeJILTBCVrS9vO4
	 Qg1KiSJxMbDeSu7AzSpYhN4fHQHIAxrZfi8wX80/4C8oopFOz1UqUJN4o4s/cGqv5n
	 g99hJBh+FBk7Alro4vVceLtpN+7/7TYAGOULR6Dt05NQtEtPXWO9Pqbge5b/tiE/It
	 LGM+h3Py622fJmaTDLxTwIhbiXqQvkyiEJj96Z4gBGAOxoKQn6tNx0Meebj7IU7X9n
	 YxosR2l59ymuRKRFNvHXjIYFcJmBiUXAKX/JYyYG4ThNivG/L4yaEVvV1Z7GuraEjx
	 iZQ3RoaSjTLzg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4b2RS32hmKz6Q;
	Wed, 21 May 2025 11:48:03 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.7 at mail
Date: Wed, 21 May 2025 11:48:02 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 06/36] mmc: cb710: Use devm_mmc_alloc_host() helper
Message-ID: <aC2hUpVu8R7cPQTW@qmqm.qmqm.pl>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
 <4fa83917fec4ec648b12cb1ac1fc0626c15c0946.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fa83917fec4ec648b12cb1ac1fc0626c15c0946.1747739323.git.zhoubinbin@loongson.cn>

On Tue, May 20, 2025 at 07:45:07PM +0800, Binbin Zhou wrote:
> Use new function devm_mmc_alloc_host() to simplify the code.

Acked-by: "Micha³ Miros³aw" <mirq-linux@rere.qmqm.pl>


> Cc: "Micha³ Miros³aw" <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/cb710-mmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index d741c1f9cf87..8787e7f49e94 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -692,7 +692,7 @@ static int cb710_mmc_init(struct platform_device *pdev)
>  	int err;
>  	u32 val;
>  
> -	mmc = mmc_alloc_host(sizeof(*reader), cb710_slot_dev(slot));
> +	mmc = devm_mmc_alloc_host(cb710_slot_dev(slot), sizeof(*reader));
>  	if (!mmc)
>  		return -ENOMEM;
>  
> @@ -741,7 +741,6 @@ static int cb710_mmc_init(struct platform_device *pdev)
>  	dev_dbg(cb710_slot_dev(slot), "mmc_add_host() failed: %d\n", err);
>  
>  	cb710_set_irq_handler(slot, NULL);
> -	mmc_free_host(mmc);
>  	return err;
>  }
>  
> @@ -764,8 +763,6 @@ static void cb710_mmc_exit(struct platform_device *pdev)
>  	cb710_write_port_16(slot, CB710_MMC_CONFIGB_PORT, 0);
>  
>  	cancel_work_sync(&reader->finish_req_bh_work);
> -
> -	mmc_free_host(mmc);
>  }
>  
>  static struct platform_driver cb710_mmc_driver = {
> -- 
> 2.47.1
> 

-- 
Micha³ Miros³aw
