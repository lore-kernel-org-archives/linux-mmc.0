Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586845;
	b=pItRzAoqdk0ywSEODHTuDx+zs+/HUK3ueGXrwQu6ro0NJRSk7g6ISZ3ePvEZN7czcs6X
	 HmyPWemfjjXni5YIPEUkeys7d9s9juwk8nQNo1hFOy974CP9qZ4fE9gLdgRXnLSxYtxgE
	 9y3cdLbXly8wAtUeSbWED6T3+Zq/Syy/4IQGkaTG3EFJ8E5vKZxIIlfIfeZbSKYMfAy1p
	 r9mSFlmWQ2bS4oJvQq7wImg6+NxUwPVV0Zs77LkpnNMVmrPKcRUoI1aUo1oxAOAe8WQkZ
	 Zc3hy1jqCif6zAd2WWpn3rhfHg4ZCywGeqWFnB+lDbmiCajN0s3MEtfYEAEvR7fT0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586845;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=glRG5tlVhZsrjDdzfHaWbZnadWGxBJIspG1sxWXR8r8=;
	b=PteYchKOj+J6abzLP7E/COfaL6hTCt4N0cDa8SrJbqAlSfDqx+2zs6mt2CdWrAXJXFp/
	 AGtAhBkmRsCcYACWfMLbUJ/Li5966h7uDcUW34cpth15K6idSzrB39Fz0TpKd7MOtC7zo
	 aMGnP8PboPeATgJXrFGaHEfiDh065cyHDXa/op8BPO2Uhsb0mx0sCrTwz74yQhaj258kX
	 7G2fQrD+V+/EyZA3Gp6nEoq2DI2dDJ4GBCzNdSMhfXte/tRLauvKM1yT5hyr2cqwiTaoP
	 aupvFJS8gZYwn0By6QSPY0BCZ36jH+Nf2wEt6le6sBf1/brreafwvCZf6H9IZcGMXlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NChoCWA4;
	arc=none smtp.remote-ip=210.79.60.35
Received: from mail-m6035.netease.com (mail-m6035.netease.com [210.79.60.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1D606A326;
	Mon,  2 Nov 2026 02:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=NChoCWA4
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 531ca0c80;
	Mon, 2 Nov 2026 10:33:53 +0800 (GMT+08:00)
Message-ID: <f4313b18-4ce2-4a1c-ab03-512da50191f5@rock-chips.com>
Date: Mon, 2 Nov 2026 10:33:52 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>
Subject: Re: [RFC PATCH v2 2/2] mmc: dw_mmc: cancel the watchdog timer on
 remove
To: BeaCox <0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <20261102022924.51343-1-0xbeac@gmail.com>
 <20261102022924.51343-3-0xbeac@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261102022924.51343-3-0xbeac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19a1b27d603a4kunmd8a72fba3af66d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBodVh9NGEgfTk9JSExMTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NChoCWA4vKinVCnF928NUn8CjEkkVduGBfyK9x8kLs+Oe1ivkgKEdEWvmRJWjI9OaavDRfe9aux3cZgXdPJTOzDWpC1NNZn5j6Jlw8ErcxJnqQzgOKpH1Yk3ELfjGVmJAMi+4FagFbovFEMs8aQaynzwJKkmhRIofNQbJSlT3Zw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=glRG5tlVhZsrjDdzfHaWbZnadWGxBJIspG1sxWXR8r8=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/02 星期一 10:29, BeaCox 写道:
> The central watchdog added for command and data timeout handling is
> armed while a request is in flight and is only stopped when the
> completion is delivered.  If the host is removed with a request still
> in flight, the timer can expire after the controller has been disabled
> and its callback reads the controller registers and the host state.
> 
> Cancel the timer after bh_work has been disabled, so that a work item
> that is still running cannot rearm it after the cancellation.
>

Thanks for this fix,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Fixes: ce0043b9a302 ("mmc: dw_mmc: add central watchdog and convert CTO onto it")
> Signed-off-by: BeaCox <0xbeac@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 5b47643..dc3beab 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3410,6 +3410,7 @@ void dw_mci_remove(struct dw_mci *host)
>   	/* Stop the work before the timer that it can rearm. */
>   	disable_work_sync(&host->bh_work);
>   	dw_mci_stop_fault_timer(host);
> +	hrtimer_cancel(&host->wd_timer);
>   
>   	/* disable clock to CIU */
>   	mci_writel(host, CLKENA, 0);

