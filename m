Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED530F932
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813472; cv=none; b=iainC/g6+hfqEhLkRFmak13f2xKIJXi57hB6x0B25gW9GbVP70gs3JcIyB9q5Kvz6/AyTawoFBsSOypmPtQfrUk344fIaxCi11q8lB4BkkBJdbzfcoH+lK/vvkAM8JPZRynpb/BCO5k+cipzelrXbHzaFFP2oHPj9IvJi+qk2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813472; c=relaxed/simple;
	bh=oh7t7Y1UKT4NrOUIgsCpbOBE6egrCN/cSMBdHQPp5KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUUrk7U4v2JGVvYmOL+TL8xHCWDfQq2Nd88yXYgg/JvO9fqBEkjbFDWDp0GqKS0IztokCsbCjzKnRMw13hBHuBvnteSQtkV4LOF1WmMsSoO4uF3c+V7jkMQ/6iQIAvL0G7hmKm5VqKzwQSpowkijA1uymwnpZjIcKIzds2VvRv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBTv6a//; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBTv6a//"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64471fcdef0so2569724d50.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813470; x=1766418270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ord/Jy3WahxWv6+pZLQ5784ppmb+r7KH+dg1CMH4bX8=;
        b=uBTv6a//eNOPW02GH743Vz9K9or/ldEtLOc+fGZe35zLYaNaYn3grXkFo4CSV1b5EK
         xOWii2DjsA+4ktQub9GmyV9ewbe8Eh5j3MxHndrYpxveuo6W1GQbsqnXyWmK13WlmbvR
         dresDLEWbuVvEzyUZL3IIUeVRawIhV76ZT3+zt+m7nTjfBJEq87AeQjcVf7z/GT7VGVk
         5+I8/nfTK3Wt5lA83d5E/c6rgiewrAP2jjTQVUcTiJKg+q4OUmmbHGlw/Za3CnuCueEJ
         hIGjl4gwz/DKcgJ3gzTKSCV/Sa35vPpTkWhNBRExaoGmvBwUk41R4qR+n31aZh1PnLEA
         EbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813470; x=1766418270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ord/Jy3WahxWv6+pZLQ5784ppmb+r7KH+dg1CMH4bX8=;
        b=t/FBsElEPerLt/2hKJtU4LWnplJf8F47+QIevlFjNs+fSOF6gqJPTz4Q5EufMBjbaZ
         glyiWap09W+mwUWHXn4z1v1WH2TXRwWaaadcMopJvNyuRAEAIDDoy/zgAH9jkFWy292g
         uiadnP074E7ZX04PQthOKZCx1LeY71D8f/8SJCEC2e1ud81q6iHl9pg1fgbiC6OuQfpZ
         X4O9shHOcasBNm4HgX4+Lku0yeFRA26dgHkQBy2NfmeTxFAY0AnEpRKbt18aU1Pjs5Kf
         cgl5EAyQn0PZ6fUdA04bAfXKD7UFqExBwqMyVsTo3OuQPlOrum9S/hez6x2afQsEzVsH
         ywUg==
X-Forwarded-Encrypted: i=1; AJvYcCWt/v7Qs2Gpg2L6OuCVbK/mSnvp/1DMhrI0s+3wX1vhnbLInwondissihULhAbO/MADoiK7cFnfmSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWKP4cJGIWfHm9fZohg/nhTYuyhivPYRu3nZWrR5rk8K/8K1N
	Rc6t3jN9AwxnU7eVr+dcJAM65DCz6d6Id8GS84gAMOQI/ej7QRjSzYRi/NgYgth5Sm21xKQsHgR
	+QNiD3tv+7taosY8PYhcZs1T/+BU9ODzCblqnlHQ39w==
X-Gm-Gg: AY/fxX43gvC/y2s8h67MNKNzn+Lsk8gW4eO7reoAsF7Pchc0uoqf0kMic9vUgnwxVar
	8C/yRAQ7+rh0/NKrP3sXw4j4gBeF4gUnh6b9rKnsKYzwZVdvoSq2RjCLeVVVJuv/S9KFwpjGDQ2
	loCn0fwFy6iB3GjCTnKQ5Nj102IiPKmnRVpxqaT2bCGp68yrFjzR5tEi6AgQXRyt1PrW5qpmUlY
	bOZygaFc1sYhNLqU3yDzL2SzKvF5M3MfEzbsgtkwdMgkzQk9YjrrHkr2t7sTzfTwfckn8LjLXFB
	pXpBolo=
X-Google-Smtp-Source: AGHT+IGxCBxLGLcpkIj+jez6ANmJ4exNQ8Wr/4dDc0WAdU190RCcv+pOqA12XWUdU8Vjc9SvszOHHjoOqEIbTFqx89I=
X-Received: by 2002:a05:690c:6e13:b0:789:2e24:b786 with SMTP id
 00721157ae682-78e66e070d3mr187460127b3.52.1765813469661; Mon, 15 Dec 2025
 07:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211075603.533033-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20251211075603.533033-1-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:43:51 +0100
X-Gm-Features: AQt7F2qa6bOsFFPkIXDOILPIyziznpqvGTVPwjQsBL7LP2bNagwnbWCy9hfeguc
Message-ID: <CAPDyKFo4o=V9H-U+HBGTtog58=0QkDzepBR2HFqU7Giede8xAg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 08:54, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus)
> cause system hangs and reboots during manual tuning. These cards exhibit
> large gaps (~16us) between tuning command response and data transmission.
> When cmd CRC errors occur during tuning, the code assumes data errors even
> tuning data hasn't been fully received and then reset host data circuit.
>
> Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
> make sure no active data transfers. Previously, resetting while data was
> in-flight would clear data circuit, including ADMA/SDMA address, causing
> data to be transmitted to incorrect memory address. This patch adds
> polling for data transfer completion before executing resets.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Reviewed-by: Bough Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v3: add define for timeout value
> v2: amend commit message
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673b0f..97461e20425d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -216,6 +216,8 @@
>  #define ESDHC_FLAG_DUMMY_PAD           BIT(19)
>
>  #define ESDHC_AUTO_TUNING_WINDOW       3
> +/* 100ms timeout for data inhibit */
> +#define ESDHC_DATA_INHIBIT_WAIT_US     100000
>
>  enum wp_types {
>         ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
> @@ -1453,6 +1455,22 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> +       u32 present_state;
> +       int ret;
> +
> +       /*
> +        * For data or full reset, ensure any active data transfer completes
> +        * before resetting to avoid system hang.
> +        */
> +       if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
> +               ret = readl_poll_timeout_atomic(host->ioaddr + ESDHC_PRSSTAT, present_state,
> +                                               !(present_state & SDHCI_DATA_INHIBIT), 2,
> +                                               ESDHC_DATA_INHIBIT_WAIT_US);
> +               if (ret == -ETIMEDOUT)
> +                       dev_warn(mmc_dev(host->mmc),
> +                                "timeout waiting for data transfer completion\n");
> +       }
> +
>         sdhci_and_cqhci_reset(host, mask);
>
>         sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> --
> 2.34.1
>
