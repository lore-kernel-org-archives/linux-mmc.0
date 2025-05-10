Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2751022;
	Sat, 10 May 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746897649; cv=none; b=I94PHBNG1BthXGuUupSRscUc/1s46Mb/nQof4o5wL9Vw33yHSOaQU5jZ58U1LPk6fXfrdEup2ly9DzSDv8SkbIDVe/26SGICENVbBonZ7s8kqO8cTjMjWDc8CQlK4fwIwzZQgNKKnccH2dvGzahTCkSniNzrmNgD96m9S5ufiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746897649; c=relaxed/simple;
	bh=q3eiTex1Caxf9IO4ImTo8aQWY5JusUh0pQVD3KAlQnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwrjIDHqCue6M2xhQKCErXA7S2CivOWg2AmwQ9QVe3EiEKFLhmSD7dqKLdTEbNblzE4cqGEv8od6sLwTzTyrHDp5ayW+A16FZ7srwDmY6lReD2hszqWZHILKivqFMgXh58qA7BXmqdOPlE15drGZYgFZhcDvwI70L234nDUHWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0b0loSu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0b0loSu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e3b069f23so31168655ad.2;
        Sat, 10 May 2025 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746897647; x=1747502447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrbQG8EFeF/6pwQUZJBfCk+p6E1aOkgOBFugu5p2OKk=;
        b=O0b0loSuwfXJ8fcML1ThN4jon12pMD/AX7OqnQAS0vfE8cGh0r/v7/vKUTwie4BcPq
         m8ZmA2F+VTgc1DHMcr0Isb8ysORcNErFjChK0z4To7J6fQ2KZOJtn2FU+9/s6gSrdf3r
         UYCmI3+Hwo+ZLZR/Ia4gNlm6ZNFaIqart1mh3Uq//yCWI3EokaawI9zk0ttTXeGhJVY8
         Ma5cmiSA3LJfc0+TJxkKzPB8D2C3MaAjAX6APMwLIaTO1T2+KnVenYyjmRQyB09GRIvv
         JrmXcvqjKyV1OxKUbPLrNQ9IV3X7LFRw5xor16HQm16MyTBXoZV+PO1cSgn2UHcJEiXj
         Kg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746897647; x=1747502447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrbQG8EFeF/6pwQUZJBfCk+p6E1aOkgOBFugu5p2OKk=;
        b=gReQwLmMta+uKtZAGyohX5fXNBbNdyh9/tk6rMBgf7G4sf1rJcLayGwuUxMcm23CXH
         2jEzyAanNzzJZiMibagL7jMatVRC7ha8DZAXT4k5eLuAGn6Q3DxugMu49wkcbevGjXP6
         ZwmPHn1uFr1pwjTN0GpxscLlPzGSxV8Tz18ypANWJAZy7fALgKcUImVJ/UU6Gv5SUypc
         iBf/LuayziVDZI1nxjJxwqD+IjKG1Bnraq8m5Hpih3GErSk1SMSFKs6EJ7AJpgVOwzA1
         hQMeyOH91CfzI3J6mmd46AAr+f6GL5iJ/1fq8IkFsQZg1byxlAEI9D2aIf5bzoLilsb3
         NtBg==
X-Forwarded-Encrypted: i=1; AJvYcCVDFu8vzq7iEyqwOusiNRkocFEtwrNsz2KSA9GObTRsTOBUM/KupOCWRD8XUUPT6L3DogrZiIyAZ4VZUpzq@vger.kernel.org, AJvYcCXB801iTKFoWv6vOfIG7u7ZAIHlfG7Fytl2OqmGkAx3IrYVAj30bL7zd44ZYk3pZp82tlhN1s2M46uO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyonin54/9JQv9keAseKbmWV9tfydVoiRfQiGqbEnndRwUibobh
	4eHGLuxCHdzFTpbk8gT4qU/IR4tmWUOXCcZYpb45VGpoW7VNzI6KlAG6HA==
X-Gm-Gg: ASbGnctQJVzwonF9hCgx4X0EVGSRd5lHD6hTuVgAUTRfDj4LiES6A1g6G+6Rqd1wj3F
	aeViqJEeBy8kdWhOALvJFztHyuLautbDzHSh7zkyfc/0IW8xAl2+oOBKssOxy1jEVNOvCXYCyX/
	Gh2w6kzbDhyEiJCY9nGdufYRnxhUGPzegLwnt2hMCQQARiGGmWtvzOVnNuaYLgpb368qbedkNA8
	9SYSFwLBJwnEzBP0KR8p/E4VV25oaW35WZeh+D3UVexuPgazLNhlU0bYg3giltFMVM6OTShZFSh
	8oZtoxwMYm7804QWdkM51dujCeqZ5AO8MNZHdkD32VWWyYMQWrksSJVpXiIuGdltviY1iM8kWos
	qTQ==
X-Google-Smtp-Source: AGHT+IHdd1itBgn8zaWroCmwk4p10HaAMsDE+3H5E0ouXn7FoUohnCOeOsuOyI2G0WcCLX23BbHgrA==
X-Received: by 2002:a17:902:e54f:b0:224:191d:8a79 with SMTP id d9443c01a7336-22fc8c7b6bbmr108714995ad.27.1746897647294;
        Sat, 10 May 2025 10:20:47 -0700 (PDT)
Received: from [192.168.1.5] ([136.185.237.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544e33sm35065975ad.16.2025.05.10.10.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 10:20:46 -0700 (PDT)
Message-ID: <b18bc629-6bf6-4490-be98-033b771ecda7@gmail.com>
Date: Sat, 10 May 2025 22:50:41 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: ti-omap: convert text based binding to
 json schema
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250510-ti-omap-v1-1-588b0ccb1823@gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250510-ti-omap-v1-1-588b0ccb1823@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10-05-2025 22:07, Charan Pedumuru wrote:
> Convert TI MMC host controller binding to YAML format. It's a
> straight-forward conversion of the typical mmc host controller.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
>  Documentation/devicetree/bindings/mmc/ti-omap.yaml | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
> deleted file mode 100644
> index 02fd31cf361d6ed893ec2f9eb8368b358ab2bae1..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* TI MMC host controller for OMAP1 and 2420
> -
> -The MMC Host Controller on TI OMAP1 and 2420 family provides
> -an interface for MMC, SD, and SDIO types of memory cards.
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties used by the omap mmc driver.
> -
> -Note that this driver will not work with omap2430 or later omaps,
> -please see the omap hsmmc driver for the current omaps.
> -
> -Required properties:
> -- compatible: Must be "ti,omap2420-mmc", for OMAP2420 controllers
> -- ti,hwmods: For 2420, must be "msdi<n>", where n is controller
> -  instance starting 1
> -
> -Examples:
> -
> -	msdi1: mmc@4809c000 {
> -		compatible = "ti,omap2420-mmc";
> -		ti,hwmods = "msdi1";
> -		reg = <0x4809c000 0x80>;
> -		interrupts = <83>;
> -		dmas = <&sdma 61 &sdma 62>;
> -		dma-names = "tx", "rx";
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.yaml b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..3660f54550e0ee46d3a7cfa3f531d95802f1e2fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/ti-omap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI MMC host controller for OMAP1 and 2420
> +
> +description:
> +  The MMC Host controller for TI OMAP1 and 2420 family provides
> +  an interface for MMC, SD and SDIO types of memory cards.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: ti,omap2420-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  ti,hwmods:
> +    items:
> +      pattern: "^msdi[0-9]+$"
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - ti,hwmods
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@4809c000 {
> +        compatible = "ti,omap2420-mmc";
> +        ti,hwmods = "msdi1";
> +        reg = <0x4809c000 0x80>;
> +        interrupts = <83>;

Forgot to include irq interrupt-controller header and use it for the interrupts, will change in next revision.


> +        dmas = <&sdma 61 &sdma 62>;
> +        dma-names = "tx", "rx";
> +    };
> +...
> 
> ---
> base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
> change-id: 20250502-ti-omap-12655fa9db3e
> 
> Best regards,

-- 
Best Regards,
Charan.

