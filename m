Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976319;
	b=oc/wnLzZZh33ny0P0/uOU00VDOVf8m+hfJz13YcHAeCVbj5Tx5mHJuUCd4LsU7A3zT13
	 vSC8RQIvL4s/XDj8ky7rR+RrHhVTNWGxZWw5ltQVJfLIXI9otNfM64HsF9S6fBusqTaUz
	 NhaKX0DZKt9xfESiNCiBX+49gVYEdWoFib8P/FM+zKUZzcS0TVHhmfwWQaxcEphbCtwBP
	 268kXukPVNkvwjKBXDtBJ1+sszsFGLfFb2BKX125jD6SwPHrxX/0BKX8VLHdtBZX04FDX
	 wmiiVFygzf+/QwKUW/6yTcYppJCcSn3UIb8ZieKjk2yFz8+BiUX0gPku069Xwck4h0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976319;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=ndzVmn65cOBuWVor3lRdzIgrEJdfaczyS9t22oR5j9c=;
	b=Ul8zdtKddXaozltR0JgbMBfgukaBMqpoEPKcguJA4Z0KBbfrUI9GQFqxjZ0LOnOSF6KD
	 LQVee+TOQv0MHSArqpv2O30/mnF3maND7e7TH1y9rTUeMb01i0RabYMXwIa/Gxz2bid2w
	 J3w2rBgDndBLlFCE3L/M+NRUd6yBVDLIqmsrRXODQU4CVgYLDgUiGTAAMitHQtx72vk9q
	 kbxSYB6IE5ZSi1Miu6u/g16TSpELWvDDzw34MkJH2EGdobfNDYpTX+H2GnurPOGRxXOWZ
	 vseEiZ+e2g/rcdklR8ElAZ8hczStQymtn1DUHm4S3qCE7SZ5hyYW6ViEMtwT/UKu7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=fx4pbgL4;
	arc=none smtp.remote-ip=103.209.128.33
Received: from mail-m12833.netease.com (mail-m12833.netease.com [103.209.128.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3B606A330;
	Mon, 26 Oct 2026 00:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E3B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=fx4pbgL4
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52486416d;
	Mon, 26 Oct 2026 08:58:27 +0800 (GMT+08:00)
Message-ID: <2155efb5-4d22-4a4e-8541-29f263f96dc9@rock-chips.com>
Date: Mon, 26 Oct 2026 08:58:27 +0800
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
 linux-kernel@vger.kernel.org, Jensen Huang <jensenhuang@friendlyarm.com>,
 Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH 1/2] mmc: core: sdio: retry without UHS if UHS init fails
To: Deomid rojer Ryabkov <rojer@rojer.me>
References: <20261023232813.2983368-1-rojer@rojer.me>
 <20261023232813.2983368-2-rojer@rojer.me>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261023232813.2983368-2-rojer@rojer.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa175b7450f03a4kunm9d88549f3c8782
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRkdQlZKTBoYTx0eSU
	1LQ0xWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fx4pbgL4725wbNIYiLeLMF/CuLrTtmOwGb09pgxKOTtDSj1xUf5/2BE3PTortC8CmAFNmbJTFqANSpNBW3qWihL5hvU/7680obcFqYNjfdPB96YYh/xBOpM1YgC0JXxS9Pu1Bsb6sPLGHpvcgk5fXEbTx43ZbNLETLMdsnpbDh0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ndzVmn65cOBuWVor3lRdzIgrEJdfaczyS9t22oR5j9c=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/24 星期六 7:28, Deomid rojer Ryabkov 写道:
> If mmc_sdio_init_uhs_card() fails, typically because tuning finds no
> working sample phase, card initialisation fails and the card is not
> usable at all, even though it would work fine in high-speed mode.
> 
> This happens for example on the FriendlyElec NanoPi R2S Plus when the
> SDIO pins of the RTL8822CS Wi-Fi module are left at their default 4 mA
> drive strength:
> 
>    dwmmc_rockchip ff5f0000.mmc: All phases bad!
>    mmc2: tuning execution failed: -5
>    mmc2: error -5 whilst initialising SDIO card
>    [... repeated for every init frequency ...]
>    mmc2: Failed to initialize a non-removable card
> 
> There is already a fallback for a failure to read the CCCR in UHS mode:
> power-cycle the card and restart the init sequence without

Nit: It doesn't power-cycle the card but soft-reset it.
Otherwise it looks good to me,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> R4_18V_PRESENT. Do the same when UHS init fails, so that the card comes
> up in high-speed mode instead:
> 
>    mmc2: UHS init failed (-5), retrying without UHS
>    mmc2: Skipping voltage switch
>    mmc2: new high speed SDIO card at address 0001
> 
> The fallback is taken at most once, as the retry doesn't request UHS.
> 
> Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
> ---
>   drivers/mmc/core/sdio.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 83085e7648..6787fdf1c5 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -867,8 +867,14 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
>   	/* Only if card supports 1.8v and UHS signaling */
>   	if ((ocr & R4_18V_PRESENT) && card->sw_caps.sd3_bus_mode) {
>   		err = mmc_sdio_init_uhs_card(card);
> -		if (err)
> -			goto remove;
> +		if (err) {
> +			pr_warn("%s: UHS init failed (%d), retrying without UHS\n",
> +				mmc_hostname(host), err);
> +			mmc_sdio_pre_init(host, ocr_card,
> +					  card != oldcard ? card : NULL);
> +			retries = 0;
> +			goto try_again;
> +		}
>   	} else {
>   		/*
>   		 * Switch to high-speed (if supported).

