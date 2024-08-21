Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAD18C348;
	Wed, 21 Aug 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249450; cv=none; b=jUKg7bbOIDeF89PWwHzz1HRJ1Sgj+oiwaV8JMhHQxHB4xIWPWCbfEle5hX9a7ZpRBZtz7jJxDZ0b6JxPLKGzVNgfWOyxOlSgnEP0aR7hk05Sb8ffz/nw/51RAvhx9PUWB+ESMyvye52edJS8ZZWSfHmhR8yJyWMn7p1YfpCNcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249450; c=relaxed/simple;
	bh=FJvSAZoa/G9daqhBWPSRYjXQ41A4i+OJsroAB+kaINA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRyuSm13KASoOeEVxHh/mxqn7y6dSNheej3nnbxaFzN1ZU837DeYDCJ+RNHgKaMy9pm31wev3HEJUkn9zkNMwHKzWcUtid6ytSaN2Vy8MdpIYi9sz1YVlHQgJ1RzUf/7WVJOZRbRIRshD0xNaVafwvxJrut7JndKF+N1KeFiHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=dBC4bobw; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=dBC4bobw; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="dBC4bobw";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="dBC4bobw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724249125; bh=FJvSAZoa/G9daqhBWPSRYjXQ41A4i+OJsroAB+kaINA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dBC4bobwA+qZKrll3S+Foao5aav1o8u3vSL+TmA0saWM9k2Jm8MgVdWsfFoc0pHuE
	 EH3RQmK4RqvMtZtaKKGFvaUFc6BWDKeIgTIQDBK2hnU6szSNcISr1sv0VI8AEzJ77l
	 +pFZ2/47G5L/3UyYLjVegaq7feETY+gZU1irbVRfx6cigzK+Zr1XrWyjBvL0d0+aad
	 Ai1XM3YUQwcLeLRcY/WqDShimec+flDL2f3dew/mK1CmpczJ6I37mzLLUrI19DsWxy
	 LbnGghBeP9Yf1ODcf06q0SLRkeRFGLcsZc9jLDqx6ef8nDe7LKUpAOGeSyVd0it58o
	 htabwRF0rQnHQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 70E7D1192;
	Wed, 21 Aug 2024 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1724249125; bh=FJvSAZoa/G9daqhBWPSRYjXQ41A4i+OJsroAB+kaINA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dBC4bobwA+qZKrll3S+Foao5aav1o8u3vSL+TmA0saWM9k2Jm8MgVdWsfFoc0pHuE
	 EH3RQmK4RqvMtZtaKKGFvaUFc6BWDKeIgTIQDBK2hnU6szSNcISr1sv0VI8AEzJ77l
	 +pFZ2/47G5L/3UyYLjVegaq7feETY+gZU1irbVRfx6cigzK+Zr1XrWyjBvL0d0+aad
	 Ai1XM3YUQwcLeLRcY/WqDShimec+flDL2f3dew/mK1CmpczJ6I37mzLLUrI19DsWxy
	 LbnGghBeP9Yf1ODcf06q0SLRkeRFGLcsZc9jLDqx6ef8nDe7LKUpAOGeSyVd0it58o
	 htabwRF0rQnHQ==
Message-ID: <87d5904b-2211-4c12-8057-bc251ca34e89@mleia.com>
Date: Wed, 21 Aug 2024 17:05:23 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Remove struct mmc_context_info
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <232106a8a6a374dee25feea9b94498361568c10b.1724246389.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240821_140525_490964_D94D5BA1 
X-CRM114-Status: GOOD (  14.29  )

On 8/21/24 16:24, Christophe JAILLET wrote:
> The 'mmc_context_info' structure is unused.
> 
> It has been introduced in:
> 
>    - commit 2220eedfd7ae ("mmc: fix async request mechanism for sequential
>      read scenarios")
> 
> in 2013-02 and its usages have been removed in:
> 
>    - commit 126b62700386 ("mmc: core: Remove code no longer needed after the
>      switch to blk-mq")
>    - commit 0fbfd1251830 ("mmc: block: Remove code no longer needed after
>      the switch to blk-mq")
> 
> in 2017-12.
> 
> Now remove this unused structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested in drivers/mmc/ only
> ---
>   include/linux/mmc/host.h | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 49470188fca7..545bddfd7e1f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -292,20 +292,6 @@ struct mmc_slot {
>   	void *handler_priv;
>   };
>   
> -/**
> - * mmc_context_info - synchronization details for mmc context
> - * @is_done_rcv		wake up reason was done request
> - * @is_new_req		wake up reason was new request
> - * @is_waiting_last_req	mmc context waiting for single running request
> - * @wait		wait queue
> - */
> -struct mmc_context_info {
> -	bool			is_done_rcv;
> -	bool			is_new_req;
> -	bool			is_waiting_last_req;
> -	wait_queue_head_t	wait;
> -};
> -
>   struct regulator;
>   struct mmc_pwrseq;
>   

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
