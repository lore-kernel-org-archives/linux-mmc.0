Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9F2D839B
	for <linux-mmc@vger.kernel.org>; Fri,  3 Oct 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511537; cv=none; b=bUTX8xEsCb/xqUH3XmlkjWNjVco6MB02wT6kRptccKYwiEaAwHutSYSApwXb9F8xL9MyNP2ZRCg0UUGRL9YckvvVFHzS60RPvJTPg7eFX9VUlCjTDCv4JfEJnkzrtb4U5cNNC2Bl/2gtoIPKxh3Kn8HGDdHwxqo7SGnvFzzIbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511537; c=relaxed/simple;
	bh=9SlwudKfjm2H6CDBihaHiwrvhvQGx05mbbKqjmzJGt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXR7kNWGg3/fNP36l0tAroakH1N4JrocMigbf6inEC+w1Y/InYyJZSnh+H2uiAgGpSQX9M/ZY5ITX/fWBFvRUaWWgwbKcrQnSn4QM3NVCtbiYx4tYSkzLDRun9uc8zH6ILkNJVwIOGS57+Zzj4AtVVELCV1yRNtPY+s9YP1l74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NYINhqs+; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NYINhqs+"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-91122373653so101036439f.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511534; x=1760116334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+rEM9+wzhaFVPN9JNs7nDiRdjo8ZbQobpK1PNdub44=;
        b=wgNrwQ6KU7IObzbko8ftqhDW8KME/F7JNPn6820g6K7bvQ3pOeLKek8cF5ZGM2lz2h
         EZxuR+HOkGL3gjGpypXKk2pUPU//85l1i3igRDaZuetmSqMH8NwgN/ga1QkWr2uSLdnY
         1Z4fg5lSh1v5olJwvj1zb6wrvfAMOeNL4xs3aoqkjgPjy3N4WAbmD0M4YJ7rOZcEa+6r
         QpyYqVNq+2eaY/VvjTqRmz3zTjGndoUq5+nyGl5oHPoz29pGqHS1mCHkR1HkYfGbvkT5
         T0vED1udzAzFTYR8OrFL7E9TyTljM+GhNOW28D85nUuBMfyJZxE0Ca6riAQbx8/mqctt
         w+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4b/5MZG2Uv+6MQshWxsbRaGrhpq1FbTSv4JPhyB6yFnCc0SXfn99Ypf3w7TlHCbBt5baCDNWjZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+eOBUVurIPCRV465vTVuwT+o9ZynnJCs9RihhHlT8+ETHEQX
	udrdG4a6ZwiNmZzqAI62gFFPfWoDAOpq9LnJt1uqDlEgFsF/fGSu122CIypfHvm1T0DNZEcXlK7
	2+v3LutEJSOxd1boY1HKmQ3Mcszr4BjAb8yt+y7ZOIus8mY4jUuAJAeH5RsKiGOqNYZJBOJbbvl
	+EdC0UHAnRlaU+71d/NXChpIHQDxvA9LANx9rKF2dve5qcnJEwn8zHmnWkry2pV5g1rDsWoWOLT
	Vjgo8n5qNp7FQaWChEx
X-Gm-Gg: ASbGnct2xVw4zgZ6ll3CgU4bGabXtuLykvMTqMd7M8zZNqVLRbG3AH4abiHcD4HLGTm
	bVGDEeT2KjV/zmUOV5Wuf36o/C+cr+R8/qa1XSjft/A+46+CXG2njxJ/QsTWYFXM0LLFSeCm4sQ
	EYKqxAtI2hw8dL/hMKE75srypj7XNIwzPxN84HNKtWlQBv0cbc5tHqQeTBzUbvbbmjgYnVyI3K7
	C4ddU2ZiovR2O8r7WFa+udYKMMqY8jxqm5/f5JQes0me5xmgOHcIJMLB8C2gcPRME12GgFWjYOR
	3P1smnDHHwPD3U5wwec7Af+NDmhScypUJQWn+YQ4SeMWuNktQ2CDFj7SNJcOqp12bSAHFdKQ7Z1
	3mkttGhoSw18JuPqZRR9otwLfPM69LE03SINxR3RTnEPrBQ1Jow5g46qt7/0L2pp7209iO7EvTo
	+EZByYGo4MgD5n
X-Google-Smtp-Source: AGHT+IEh/EmvidMY13Z7Y7yQlC3BdZBbsv4lpcuBlwojR5QpYewude32fujBUpCknoTZ2YOybp7tU5gbP183
X-Received: by 2002:a05:6e02:216e:b0:42e:7426:7cc5 with SMTP id e9e14a558f8ab-42e7adc8906mr47141545ab.31.1759511534352;
        Fri, 03 Oct 2025 10:12:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42d8b1fddfbsm4241395ab.3.2025.10.03.10.12.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:12:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eca7298d9so47365335ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511533; x=1760116333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+rEM9+wzhaFVPN9JNs7nDiRdjo8ZbQobpK1PNdub44=;
        b=NYINhqs+6dDF1OLfX75bQPD7k3YogbGvBygDhXYak8GJGSzPJ79GRnBGhTlqMvkJqN
         69tEOhf8e9wm0pWMYIjk9aYWiFiY3RnyL2f08uZIXTQqAMBxzEfcHCc5r0fhBO5mpdV2
         1PSMx3GaMdyV0A4x9q8QYUxtCMkvtp25y4fSo=
X-Forwarded-Encrypted: i=1; AJvYcCW4TNXqto7Cqn0OoNumfLeKS5beLE+ST9qvk+GzfcjOjiwTZ4dn6HocmmJCwkHxddGZtspM/WkNZX4=@vger.kernel.org
X-Received: by 2002:a17:903:2f04:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-28e9a67faadmr48169855ad.47.1759511532904;
        Fri, 03 Oct 2025 10:12:12 -0700 (PDT)
X-Received: by 2002:a17:903:2f04:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-28e9a67faadmr48169525ad.47.1759511532505;
        Fri, 03 Oct 2025 10:12:12 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba1e3sm55227475ad.75.2025.10.03.10.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:12:11 -0700 (PDT)
Message-ID: <196ccd66-18fc-4e0b-9672-7adaec550449@broadcom.com>
Date: Fri, 3 Oct 2025 10:12:10 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-4-kamal.dasu@broadcom.com>
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
In-Reply-To: <20251002210426.2490368-4-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/2/2025 2:04 PM, Kamal Dasu wrote:
> Added support to save and restore registers that are critical
> during PM.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

