Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113339;
	b=ZPf8PcrvmoL9dreupuS6UuP3A6DDFz3pcujqugpmdw2u0G3txZPRXSo+gddTKA/zU+Gu
	 ifUqLXoBTDVsop/1jajhZuN8aYCkH+9V5zhgfaQBSNhUwuPxnKnuWq0otv0+lFmr7zsgz
	 rzFLavXSVk8rD17FH1cW2FvVSsuRfMoEfPxtHD5axMNVX/TmgjGdzngKD9aFcUTbR0HUW
	 ZgGhxrqdeuemzs/BBNKjEXa01e99TcUw/4N8M7UHucTeisrb1ojoP5LpBGWyrQxWVMDAv
	 uIiFPyLBDIBlxtm//DI4sRpYjWmpq9buspqBRWzwDyW1U0HY8Pj40aoOZK2Q9offgbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113339;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WHO1mAqmrPk8OPKBUEwgsF2j51VFPDAfdswqDjCD/dY=;
	b=O+4bqXdpykS47qukqwv6Tm3rJWWjbBnjrqMnbEi26QbrDHMShV7qpDPa32Njv0+YDGAF
	 HEQZKuVC3GyRlpX3D+/NKiYHyIR3AMFqbDQ1a0DrNFlih1soVj3Nb8cQ/BrhEKENenXox
	 tcU8X+U4yPaTEf2VLXt5REH726/uKx2txurvev2d50uqNCOILoW01Ej4r9DSepqjyy931
	 +Aq32OcfbThvGk4ThPrE/3jhQFuS29QWvk1/zfO0VtH5hAmoP8yMzgbxiXLguyr/K0/sj
	 pFBbElUXa7Z0CldIta+qJT288pbXIk0tz29B6M7WV2/Fp/WNg+0oTRI7RAwIZdk3I9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KvMw9MC3;
	arc=none smtp.remote-ip=91.218.175.141
Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFD606A320
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2FFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KvMw9MC3
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W7XcvJkjNj1nyOBP5NzQSVWrTpXkf5ocgz66HM61XFE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793113330; v=1; x=1793718130;
 b=KvMw9MC31Y/L0S1rypRHPgd7wWl1nFk8q9UKmdXV+4qLictwBjXdkSJt1XRqizykqV9vhjpI
 wZMBF2KyNUnvgv8PLw54mLViYo6OCZV3WzGsSo69sx93nkTdTmIM9z27owaZBtvFdizZZ5E3eyB
 KiORmKqT9+XYDGxZFlWkuyTE=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55b435fb15f6a4a2;
	Tue, 27 Oct 2026 15:02:10 +0000
X-Mizu-Trace-ID: 55b435fb15f6a4a2
X-Migadu-Flow: FLOW_OUT
Message-ID: <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
Date: Tue, 27 Oct 2026 23:01:52 +0800
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
Cc: shawn.lin@linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

在 2026/10/27 星期二 22:40, Ulf Hansson 写道:
> From: Kamal Dasu <kamal.dasu@broadcom.com>
> 
> keep-power-in-suspend is currently documented as SDIO-only, but the
> requirement it describes -- preserving card power across a
> suspend/resume cycle -- applies just as well to any card type. Drop
> the SDIO-only restriction so eMMC and SD platforms can use it too.
> 

I don't see how SD could use it from the following patches. Perhaps we
should still be more strict here to say SDIO and eMMC only, unless
SD part is implemented later.

> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> index 8b9b3b036129..2fc8e06d5ec9 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -301,7 +301,7 @@ properties:
>     keep-power-in-suspend:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description:
> -      SDIO only. Preserves card power during a suspend/resume cycle.
> +      Preserves card power during a suspend/resume cycle.
>   
>     wakeup-source:
>       $ref: /schemas/types.yaml#/definitions/flag

