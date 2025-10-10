Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF07274FC1;
	Fri, 10 Oct 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119198; cv=none; b=bPmYeOtz1ONohrXM3be0H7dCqnUBRL8eh9c4KvWQ9OAsW343mGo0ysrzmsBuxqj+Cq79wDmjNwu23A+NYhKLzyl2+9hlllXV+i10q0j1/RwARfsLILWBhMfeU05FyIn3F2G+T5/SMTJGirLE38qH1REKy3SOkxZ1kU0Iaz0ioLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119198; c=relaxed/simple;
	bh=8ZOhmmUB47BnRVmcH9m8RmR0JD3HaFwGwUMxxXUZHg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dffYsOiOcGoaua8fMkT4cJqcoOAtCoe1nERteilRcGPsqQYEHcLUAnwy2hrTEXHGvPwDzrkI2TOuoMIzYX2S2IjjHY0zOR4yRWcUI5y6qIxXjC849EaDpP0n37u7DWKqy9HgKljUsktnOkHqJAxOE0QHARgjkNwMggc2nYqPpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxiYfyNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxiYfyNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCA6C4CEF1;
	Fri, 10 Oct 2025 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119197;
	bh=8ZOhmmUB47BnRVmcH9m8RmR0JD3HaFwGwUMxxXUZHg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nxiYfyNc9fO0TMEyIim7GKmK2/+Kaik9d56v7dKDdlRLyZ+sp24ytvC4pcodiwI0U
	 amTpguZUYzPjj8eQkWyhwVKNMp9l7GyRNya4/yy7z7Qo6huqPrUWg0JvCDYp/4Cute
	 +f4UJznliM5nXpJwNpzLW2l3NtQ95xBWBpAMV5uwFrC0WnywCsk/vmPuikS+zdraqy
	 AOfQT9Hn0Hh83TOUM5BoQPqlmVAEU6GIVEWBe/NRH9OXxfflgHjd4GZs+euhl05fvO
	 xPyBcm9D1dFJ0yq05WjFw2r1sclWKz82yDIXEIKa6w02e5n81SLDRKhNsEDjoJpAsj
	 S1sHzwFtCzQOw==
Message-ID: <3a73daeb-1353-463d-a1f1-22cdece1326b@kernel.org>
Date: Fri, 10 Oct 2025 11:59:57 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com,
 skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
 <20251009152744.9734-1-rakuram.e96@gmail.com>
 <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 3:59 AM, Uwe Kleine-König wrote:
> Hello Rakuram,
> 
> On Thu, Oct 09, 2025 at 08:57:38PM +0530, Rakuram Eswaran wrote:
>> Your suggestion makes perfect sense — since host is devm-managed,
>> explicitly assigning its members to NULL has no effect.
>> I’ll remove those two redundant lines in v2 as you suggested.
>>
>> I had one small clarification regarding the remaining host->dma_chan_tx = NULL;
>> in the TX DMA error path. Since that branch uses goto out,
>> the cleanup section below may call dma_release_channel() on both RX
>> and TX pointers. Setting TX to NULL there seems like a defensive step
>> to avoid accidentally passing an ERR_PTR() to dma_release_channel()
>> — is that understanding correct?
> 
> Ah right, so either keep host->dma_chan_tx = NULL or improve the error
> handling like:
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..e5068cc55fb2 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -715,7 +715,7 @@ static int pxamci_probe(struct platform_device *pdev)
>   		dev_err(dev, "unable to request tx dma channel\n");
>   		ret = PTR_ERR(host->dma_chan_tx);
>   		host->dma_chan_tx = NULL;
> -		goto out;
> +		goto out_dma_tx;
>   	}
>   
>   	if (host->pdata) {
> @@ -765,10 +765,11 @@ static int pxamci_probe(struct platform_device *pdev)
>   	return 0;
>   
>   out:
> -	if (host->dma_chan_rx)
> -		dma_release_channel(host->dma_chan_rx);
>   	if (host->dma_chan_tx)
>   		dma_release_channel(host->dma_chan_tx);
> +out_dma_tx:
> +	if (host->dma_chan_rx)
> +		dma_release_channel(host->dma_chan_rx);
>   	return ret;
>   }

I do not see the need for this code change. "if (host->dma_chan_tx)" 
will skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is 
already NULL. This code change does not add anything.

--
Khalid


>   
>> Also, I noticed that in the build configuration downloaded from the LKP report
>> link (CONFIG_DMA_ENGINE isn’t defined), the kernel uses the stub inline
>> version of dma_release_channel() from include/linux/dmaengine.h,
>> which becomes a no-op.
>>
>>  From what I understand, when the DMA engine framework isn’t enabled,
>> these APIs compile as no-ops through their inline stubs.
>> Please correct me if I’m misunderstanding how this works.
>>
>> Please let me know if this reasoning aligns with what you had in mind.
> 
> Sounds right.
> 
> Best regards
> Uwe

