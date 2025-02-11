Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0925A321
	for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2025 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293315; cv=none; b=Zs9Bkr2C6xS1L/e2IxuizERwKaTQERjFCyVh03hmLhXzPPR/TZ3NKHmY69zSLYsIWTQBqzmIoZnhMXyqCzhL9Lkuz0Rlw9GyM8sxHyO3TqQTxmBiIBb+BzqfG9CJFGLpZ/cQwzIFP2A6tJBjf7nkKB9Zst29YEsWSY6PcTmxsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293315; c=relaxed/simple;
	bh=FaMMiq33KOR87qeW3SCsjRwxO/aIZ6NrsgAW5KRtCHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mj5qblZrzXLjdnR//cC+4Xv06LOEWKHkIkUEnLMnkklrBvVBPW9n3NaZXOjFGbkH+571YP3rR+v2VIfghudHB5fQaBy0KRpCK9Usct4dglWjMXXmQVcb7XFq38IAqkXV9RIf7SJ64L9H4gt3A5FwGT42C1E+mbqYUalWzmI3lB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b30W2HGG; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b30W2HGG"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2b86794e3abso1642873fac.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2025 09:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739293313; x=1739898113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w0W62oH9ZYC+ChuytZaOkEvSh/GddcFQV97qyWKWaew=;
        b=b30W2HGG0qs0xb0m7heI8K+Evc1vBiT1E7SopfxtdraNBIzgPfAueLZ/WQDIZX4vX8
         sJoxNzEQqGhzadYjFFuUhxoK/0prZyBgImc2M3onm5Uir7E6DSgELTAQUVSjbImCoRaQ
         cu0CLYlPgLc6nnTxyPfNKP7SByyfe4GGUc+p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293313; x=1739898113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0W62oH9ZYC+ChuytZaOkEvSh/GddcFQV97qyWKWaew=;
        b=TFtGC2gKc9EWAE3aMgu1A/AJFkkliWzmImhxwIZnrU5MQFt9tst2Q25RSpJCi4JOak
         V4Gl6jXDs+K0ZiDebwJOpqGRUN4iikTNzs3mfU9fgP1ozPAyWZlQ4SBR/vm+JQwuHKkk
         PnutxEfO2j5lQgLzWRDg61VHKhugEwLSuq76qTpYNESua9R8YyRs0wZm55GzZUvkEJjn
         0+0UFi22HnkAmNeViEdnX5ABVOj+T6u8SGwzkONHtIumU2NkNSd1mn3QESFgOfxBmvJB
         Zuq+WNdV5t+rLPEKxQ6KaVsPFJv8a5T3rvm0BHxmjS6Dkj39UaOj2siMS4ZVPC7fMCSi
         Q0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXwElRHSzKujHjxLEm7I7jCxngEY1TzC+0ETe78OEraIxhiUO/fsCBWbyiUji0WzB7ICKb6rnEzIhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0l7OXOEwS7ogBKkygkYkgMo2i+KgcLxe5+mO5MLNiMxPo4mv
	PrWMfUytRdd9dE3kSXR1pS33rCIUxQVKn4C46YKLikIKoaNkLv4SNaXJbdKFRg==
X-Gm-Gg: ASbGnct3aD+vte9fXGzmT+YDWGH3EIXu04/46aKpLmOfzanN20UbNCt9BQkCElLrkPG
	RJEGGUOc/pirPjxJtCDfwa2akSp0AHtuAlLGQO6/ZV3+jb/kW8JpqOEGr0Sfkt2FYATrd3MtO9f
	VHvJ3dVZHD494oglK0zqn45XnAggFpB9UDngbRXVyv01tmtGBhe+8b10lYpGKcjuu3EJccc9xjm
	3TLAReNQSz8G8aUBqnkIHLZj4yvZL0tjJQFUbsBiOrkHSy5f+x1LTYI/vnXkYHCttT9CBfDmU7p
	sMLJreQJj4NrCiWunbGjQ4bNDgVDdvJxaeSkCaOY0WjXrHL9eOx+yBo=
X-Google-Smtp-Source: AGHT+IFLUtEuCEYnU4d6LJDB60jbPIoB9QcAeA9sHYAh0/XpHftNJgrbC98faKY5+xCzyk8GsJguEQ==
X-Received: by 2002:a05:6871:687:b0:29e:4985:fef with SMTP id 586e51a60fabf-2b8d644c7e4mr108219fac.3.1739293312808;
        Tue, 11 Feb 2025 09:01:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b82626f8b6sm3642741fac.38.2025.02.11.09.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:01:51 -0800 (PST)
Message-ID: <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
Date: Tue, 11 Feb 2025 09:01:49 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Avri Altman <Avri.Altman@sandisk.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
 <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com>
 <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Language: en-US
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
In-Reply-To: <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/25 00:13, Avri Altman wrote:
>>>> This patch set adds support for Broadcom TZOS to read and write to
>>>> RPMB partition using synchronized access to the controller hardware.
> Practically it establishes a communication channel between the trust zone and the host controller regardless of the rpmb protocol.
> Or did I get it wrong?

Rather than communication channel, I would describe it as an arbitration 
scheme between N participants, with guaranteed forward progress and 
fairness between all participants.

The interest here is for one of those participants to own the eMMC 
controller for a certain amount of time and indicate when it is done 
with it. This is not specific to eMMC as this could scale to virtually 
any piece of HW that is driven by transactions from a CPU, but the main 
application is for allowing the Trusted OS to own the eMMC controller 
for a short period of time in order to do its RPMB access, and then give 
it back in the same state it found it to the next participant.
-- 
Florian
