Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D2265CDD
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077060; cv=none; b=TJoTWuBPlvTpHxXAc1KXrzwcHKiWTbHA2Q5EFApo3/li4l9PCp+vJLERl4BiYpWOlyH5D5IgSj7Y3HkOqHOTSzE8Yft11h0QucAdHeLJQ2bxzinNeAHdTeDFJQ7Ia9VMdPR82JGScwmFn+W9xy8iYYuUzecoNfEXfaOnIuuZ5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077060; c=relaxed/simple;
	bh=XhPPWWRci/Vy+fx9PB9/njvtsc1N5VdPYC1T8x5yWSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drUZywOoUEkTreA2mBPSQ1Msi6doxo1vTAlVX33prU+rp1DHHh48PM0KFwoRaUwPktSYU4/n/r/sS8ur71j4xHBi1r0HgkltppVg2ZKtxVZulWoDQLd6G7po08fKxSJWHdLRgEm8PA4purb39XA8uEEFEptPqIHcSZg2N5Y4U8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjF+PNJr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjF+PNJr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-474975af41dso9611725e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077057; x=1761681857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQzRxP70PLLgRI/lGvNNccN0nmOHhv5bSnfp1ZsL9lA=;
        b=HjF+PNJreqIPb83Zc5DYQGf+p/erVruOmiTVGfS1u1DD2EWkHUHq6y6osVfzjzHfUX
         tCF2xPsyKdFGVA07c3SDEIcTKQG2y8uJk1mvf++/aeBZsrP6iBS8ax+OaXMymGpL42yV
         ihY3rMgI+XeuIuTUOOD6Y0MOcRgHFANrKE56L6n+N4KbZNYbE8VWCmeK6++PfORrFDcA
         t3RjtSD4q6h9WwMb3yQ+su/E7Listd8NRbZiezAHdBJCJJGfzsOoZUawTLdxHwteJCzW
         AeMTLcnRvvmHPD/EhsYbDmxHzz13V0F4YsVxt8BsK9Qp8InLJBGXWAssjV93vkMZgRwu
         yIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077057; x=1761681857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQzRxP70PLLgRI/lGvNNccN0nmOHhv5bSnfp1ZsL9lA=;
        b=Q/5pdffZ4faZkjXVP+J+wKYeqvPK6DK20z1ZRkXppQV4yaMaDMoHDKZo04jHYpri5t
         3XI9bMIgc3Sm+qnHYcjp7/v7FciC9rkH7OvkEl5Ne1ZFeA3Z0LYJ8vuYKoe5xirG3yt6
         Qi2ytxH/8VNui8EqtouRXPXUCQgQVQ573GBjNDpWnHTUZqdcQJuaPW5twEiPjqdWjTuS
         TnBDBYL7Ri2LFEDWgIT1f+B93v2Hr0pzSiKNGWlXAGAfRN6NoCSQXWyQP28SLhUJXlu1
         EY6rdp/gWNUqd3btOwAo4BoWFbr318l/nB5LVUaeLiRpYdAIiyQuPDAgihiZ9YE9rn5M
         Gj3A==
X-Forwarded-Encrypted: i=1; AJvYcCW/8o0L4S/fjwDEh7cnlSibhVWCMWomWwMJZm6mGY3ixPn7jALf68FRVo6TfnY4nOy8ZL16yVkL9dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIrxenxgaXF+t6jZRDRWZ4nxACdU0O1ZK1NEWR4bUX6a8bQeC
	Ma/TbQUKKAUh5rHkvJHjl3ofwVwAjrZ5uHIf2DH+gVujDwL3S7G/qpT9
X-Gm-Gg: ASbGncvhlNeh4xgYQgcr0czY9YiNli4MDULEUmNzZV1Yw43RaYs97zIJsxzDc/2z6jN
	9SqX7lG0ykCLlOi59iPGOr6nPJDz4sBBTdqAu4cCfvWitzk0LGuzKV7Fnn4DJedets5735XEXnI
	H5J3ne07OiEu8HQPVJCu3zSGwwh/fajn1CbC8Bx8zR4iA/C2MWrFqCnWZATAykN6+yqtJYyrTAs
	hRLwj2Xq7livVh4q6Wrft4xEnyagGmAdOeQvGxz5NdrgM3z2fUthz5bDcvI/qY9j9GApFqD/Bo9
	cgqqIa3KuqZhqQaG5h1nRp4VeyUbGCaMszhVrhrr2iR3kdkedp9yuFmkRX6Cjt2ESK30qcDV9eA
	K8fAG4yc6jHygYxuIEn70R3tqJK5QtRmmQgUNrl0TZUrsWPl05xZgsC2YRJ0GWdAdhapxjXseII
	nDaxTU5S3rY/39w8hgdndxcaMU+b/6GGeLvX/+zzYOl8gojbSbyTBbjfXUTVF1KSM=
X-Google-Smtp-Source: AGHT+IGgH4ctz7p2J/ZEdFVFtj3TJqVhCdGBRWMOn5stZShMySDMLrVW8iVCPrKMdAhubupHZGM/EQ==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr134048625e9.15.1761077056673;
        Tue, 21 Oct 2025 13:04:16 -0700 (PDT)
Received: from ?IPV6:2a02:8010:6606:0:a968:3f3a:bae8:f51d? ([2a02:8010:6606:0:a968:3f3a:bae8:f51d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf4cf7sm22165465e9.8.2025.10.21.13.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 13:04:16 -0700 (PDT)
Message-ID: <1066e578-f543-4233-b556-ae458c9327a1@gmail.com>
Date: Tue, 21 Oct 2025 21:04:14 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-GB
From: Hugh Cole-Baker <sigmaris@gmail.com>
In-Reply-To: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shawn,

On 20/10/2025 02:49, Shawn Lin wrote:
> strbin signal delay under 0x8 configuration is not stable after massive
> test. The recommandation of it should be 0x4.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd453..5b61401 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -94,7 +94,7 @@
>  #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
>  #define DLL_TXCLK_TAPNUM_90_DEGREES	0xA
>  #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
> -#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
> +#define DLL_STRBIN_TAPNUM_DEFAULT	0x4
>  #define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
>  #define DLL_STRBIN_DELAY_NUM_SEL	BIT(26)
>  #define DLL_STRBIN_DELAY_NUM_OFFSET	16

This patch gets the Foresee A3A444 eMMC on my NanoPC-T6 board to work reliably
in HS400 Enhanced Strobe mode; before this patch it would suffer from I/O
errors in HS400 mode as discussed in the other thread [1].

Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>

Thanks,
Hugh

[1]: https://lore.kernel.org/linux-rockchip/52537005-b8a3-c202-770c-599efc6a4d17@manjaro.org/T/
