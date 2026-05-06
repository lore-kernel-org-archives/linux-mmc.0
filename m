Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E6466B65
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086194; cv=none; b=W4BYX2ZCtz1tv33VyqnzmNAfZN1BAwvOEVBnOsOjQzNG1+xboGzWvLROkakZeExE1Lmir5P/lkoW+c28fq7WN/Bxm3WdJkcPlqJ66fO7EYsLXbouMlRdxEx0NLs222r5P6/OgeXolGRbR9JdxtXgZSNhZ6Xz2TnDRM5Lw+XpAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086194; c=relaxed/simple;
	bh=kn9yUR5L8jCXo/DBV2TWcE63THy0ofUBhNmaN+e8/ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpvAqhsv2SJ0uizrwJj6tA7/fe7k9MmTXS7fk/3dYFN9Fp+NhT7Uk1jE7TFJAGR8zRKy9gXxVzrS33YqtBi0yACoW4F0PBHI5l8KRtDUR4i49YWyh1Lz+zbiyFdlb0RiQyA0eZ1pKl95mF8QHyyl4G07AHuEgUwwurUvoJ6Lz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JOmKJpfJ; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOmKJpfJ"
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso871504eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 09:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086192; x=1778690992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sB7mtWocGmvZN23abDTH8pp+JG0MqXg0lzqYGcepnjM=;
        b=SOVU+cMUzorsMMk8ZJ9LRdYj+Urqy1dKWqJvgOjo6VyHsGCJ663DAZbkFccMoIrHiT
         te/d9fqQN84kZgFNCECjUjeKM09pQ1wKCGQb8YkRUZn0OrgE+NVN4t+j2X3fs7maC6oY
         Jask/zbzW0SgIVZzNT9UvChKjp3wn0leEltXoM5SIMuCeRGlNLnwKoR9bv9vo39FP1IJ
         0aRsfcQQw+G4A4B03A+2mt9DP8YiV9d/PT/Cb1ig2OYpTTTr17SBJ1HRBqfUPYtA6/q9
         LFy4X1GryiPY1+cizEuZHzr6RnfBohcSueiP6W7aJtVu0EeO3EDPRrwYL0riMfsSzR+O
         h+Dw==
X-Forwarded-Encrypted: i=1; AFNElJ83IqUKx/l2RSuv3+rDOXU5M2NiXoTwjWhqOJI6+yGCKggunrKfJMkQ6fKlUwTTT3tnD25qeUZ10pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6zhovohL1Zl3de2UXrnQJxmXRliRADM9iNPIKUuWA3bmdT2H
	Ysugxf2awNtwREQgonUFQlK1XfvDYy2q18SQgCyKNN6HCb16DAP5UpjTGJbrWl7Wa3Dt3r8G2B4
	RHgEd94RQnNjSMR42HdtNgMUOV2fAM6Vsadoolf67rbW7Cc2kf5ttllrj6uYpStrNEtaA2/hRp/
	UmuyVB2k1Wx9A1ulym7w2r6Cs1uQBSKgwUvZgHhNaFqc2OWNg0utsSttbkkNtbVYUecHAtr9HCb
	h1+rQ+lqJaCSjGYc/6p
X-Gm-Gg: AeBDievksvofLVrAzSMJDhOn0DEFh6vXldpfAUcWYj40zZb2DXFieuY3hxYD0yj4k/K
	TJCz84crhEfYFAaHmRIEHSRQMNJqaqfeAX0mot2gY3VZdEC/4AKY/z3Ohc1infS1ExSf7Uh0EvB
	XdDYlI/CjKfk2Aktp+j4H2+KBzYxyIOC0HIU7IDl3FOUkkTefxpxL/kI2CwHKLQzU9SZ8KctEv3
	9sEVxbvnT79jnZEz45UGgi8l0hqWMFMBfh6WIgvmDxIY2cIPOqxlGy5ZxH6If9+F5mzY3aK+28U
	kHPFi8DMeKQ3w0uJsf9hZ3xwARjyUoeW+Ikwvj7RMnJHUBIWJpoC2BJ14sTcOEt0TX4IBCN6NjK
	g5kZvogBRSHQj8RM4VqrIZeCv9HM/0yUiBXU9yEFmTFId4MnUDSh97scBSuRgy1dY2BScoQVvJ8
	ZcRLETvtqZcegNU+hQcJg2
X-Received: by 2002:a05:7301:2c05:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2f3d16bbb71mr3323446eec.18.1778086192040;
        Wed, 06 May 2026 09:49:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2f569f895d5sm239926eec.0.2026.05.06.09.49.51
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 09:49:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso632468eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778086190; x=1778690990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sB7mtWocGmvZN23abDTH8pp+JG0MqXg0lzqYGcepnjM=;
        b=JOmKJpfJIVGr+ptSsP5FJPt3IHE9T8gOCTNY72V1JuWHsrB7C2KA3r9HdLP6jj58WE
         p2juMO2zVOLhu5YwE/dTWpyHyX3PqayxxeG7CIJPHFr7hKzeeXwcFzpMjgarBvz7XgB3
         75PPWrmOGzwcV9Rr3MQlmDTxz5PAwsiGZTL/o=
X-Forwarded-Encrypted: i=1; AFNElJ8fCDXG7GwaZZ9vW+VzdD237KyZOLz7448tP+jSwB+mb6ja6r8Ld0IJyDDHVw580L2I7yGMue/vMx8=@vger.kernel.org
X-Received: by 2002:a05:7022:4189:b0:123:3c24:b15 with SMTP id a92af1059eb24-130a9feb611mr3791290c88.19.1778086190054;
        Wed, 06 May 2026 09:49:50 -0700 (PDT)
X-Received: by 2002:a05:7022:4189:b0:123:3c24:b15 with SMTP id a92af1059eb24-130a9feb611mr3791275c88.19.1778086189410;
        Wed, 06 May 2026 09:49:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f548sm4551972eec.18.2026.05.06.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 09:49:48 -0700 (PDT)
Message-ID: <737a7feb-6573-4c77-8102-08653b3ae9f4@broadcom.com>
Date: Wed, 6 May 2026 09:49:46 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after
 SLEEP
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Avri Altman <avri.altman@sandisk.com>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Erick Shepherd <erick.shepherd@ni.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/13/26 11:05, Florian Fainelli wrote:
> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
> which prevents the system from properly resuming from S3 warm boot where
> the eMMC is necessary to pull in the boot components.
> 
> Add a quirk which prevents that specific device model from entering
> SLEEP mode. There are no differences in the power consumption observed.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Any feedback on this?
-- 
Florian
