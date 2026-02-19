Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EE24729A;
	Thu, 19 Feb 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771543747; cv=none; b=sHdqkBp6XOb7f1BC/tksxJHPkakGsKqHVOB4juaJpAokGbXAhPK0VVRTsiSXbXoywGKlt7OR3Bka9gBLjWgqYNvuY8KrnN+Ta7I/Cjr3BHQSFIwZ6hjsRodGjjdcgJb7kFZgzbSyF7Ro9/lqPqmLNzDxU0kT7YfkdCEZ4qrAh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771543747; c=relaxed/simple;
	bh=sV2UXXPMhdToewWgdtQM4yenBbM61DaHKUGynnxXxJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLxWHph+OvGhtivTZfplPgrroLuB5Nqjtv7TYLPb54ZUt7M41iT3OmC2u61bAMUDWxuBDGnKHvnodbUURnBPN3EmjiRfJQ34EN99eBSo6JTwO0uCmNQjLVd3VrX6KRqqpWS0ElUxn6pXB0sHvOHXe20GGQt6Cr5tV0BPMlrH83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af0dc.dynamic.kabel-deutschland.de [95.90.240.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D5224C28871A0;
	Fri, 20 Feb 2026 00:28:35 +0100 (CET)
Message-ID: <0cb6c45b-a5a4-46bf-a73d-97c482da9339@molgen.mpg.de>
Date: Fri, 20 Feb 2026 00:28:30 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ulf.hansson@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mmc@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sean,


Thank you for the patch.

Am 20.02.26 um 00:16 schrieb Sean Wang:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.

Tested how?

> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   include/linux/mmc/sdio_ids.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..97cc834fb3d5 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -112,6 +112,7 @@
>   #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
>   #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
>   #define SDIO_DEVICE_ID_MEDIATEK_MT7961		0x7961
> +#define SDIO_DEVICE_ID_MEDIATEK_MT7902		0x790a

Please sort it.

>   
>   #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
>   #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347


Kind regards,

Paul
