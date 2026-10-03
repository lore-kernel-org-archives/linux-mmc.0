Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE321E9919
	for <linux-mmc@vger.kernel.org>; Sat,  3 Oct 2026 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015068; cv=none; b=secKMQt1wcQ1ONAaw34MzJ/CY6YQedAdCxWuVw/nqQt07xHGnQbjPZDybhxoGj6GLo05E9PjCVs92Xcjq34ma5AWWIAWHoteSb7VX3jPY37eahltafUV5AayHEJECUs2Qk++TUfPJ2Ukovug/30XbGNgpn87zJ3eLNBfFpM9egQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015068; c=relaxed/simple;
	bh=wtwQ6JzEMapAlW6zEvQWmul06EKyW5l8OOrIKIXFqHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7bP4w8wtz0W7xvwvacTQFQllqvggrkbVXr8GUOWBiJtWB78v1s1FGg4Gc61ZnItv6ghsN5shh66Tt+ZDziBfH4A7VgECVE2JOPIHoIhmeht3+pS5wvuKzC61beyFY4gW1z0kUZst+/MHwfGq3zIPEi2qfReNHWmc6EU+xQl3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a169d33ef6so1160595e9.1
        for <linux-mmc@vger.kernel.org>; Sat, 03 Oct 2026 01:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791015065; x=1791619865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UOj4UBtpSDtB1u/mynjbblWtbQNRWQi1yFF6YRu1C8=;
        b=NV16n3H0oH5tztr2qC8TY0pNiNF+Hr3M1q5BNAGwDAQqoH6UV4jL9SZI/8sRlQXGCX
         kQu/QUbq5LankeYIr5srA3fKHTYcNG416wNReEl0uo+3jlvrhMHTyXzxz1XX+1DGM41s
         J9O9Bl6wktnLjBMzvyApyZJnb/vuXsUUOE2N2HGXolzA/M7YToyyCpxzFHbpchExHTNg
         kUIaUZRGu2GkDNB+FtThxK+Nqr+VuAy3H/QHjEvL8JIGYj78FjXeJQnj17wSu46VQXmr
         L96vFycuZUfvQxrhHrGXqQ1KfGdlEaBOZ5SrbgOLEFUeC+SYfB0ANBRp35x6LmHUBRfx
         9iqA==
X-Forwarded-Encrypted: i=1; AKwUvByzlk86GanhfepAvvzKpli+FqIklGIXQzDla0jbG5aV92v5T+m/t9RmUau2b6wT0VNe9YqziPUY2BU=@vger.kernel.org
X-Gm-Message-State: AFuF++ncSIONHl7lKyO4/+WO9eMcJwhoSpUhV2WEPWlh3d4vG+owMKCn
	yBY9Qpy7tSBK//vEgyIo4h2rbEzut9U6FgFBICaGg+23lyh69aHOgorX
X-Gm-Gg: AYBFou2oFncc6zA4xxw4CbGOFTcBLRcpuga7e9iq6nEDP4lPDx7BHA6N/o/MClUUJM9
	6KO8o0ZJtKxwXE6RkWaf/J8V3fUA0tIiHSQfARCdsnWsNmmKUd89daS+mim08kuNuxbngD/yuLY
	yRYvGWE2OB2QzS8Pq/zm8o7snZVQv40AbFi6DJWQ2iW4P9p5sOg6gAP/2o4TLsTobRyk71s2TDS
	uUvd8J5OSaM/wcKcqMG7pfnn2xBPqSeqNSBVLqGeTpwXGSrnrBCXbnLMqPjct9kFKaEdinswHt2
	uuxxbqG8OjJy6ie6y9v9w2ljHsGDy3ch1Z11e2UX8uYSmDlFkKt6TaIlVazvZsuc97XL7vrOnS3
	cZKnqa/MTEpJY83Vj8gzpAx5TKrk8riQGiMhQ5g4iD6nQ0dntRRKaJaw7e1bMzufFRwFvWIJUlB
	hT0e4/o5w89xLi1VqE0RwZqLuHPwuvpS4fhB9+FEKz5KeMtCowWklfdTM2ailKMBrqNDSvAsWm5
	iiT9/pNVoIPcjycWQ4eyt+xuuWx
X-Received: by 2002:a05:600c:a011:b0:49d:4ef:bf70 with SMTP id 5b1f17b1804b1-4a02756716amr80264645e9.10.1791015064857;
        Sat, 03 Oct 2026 01:11:04 -0700 (PDT)
Received: from [192.168.1.135] ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253e7esm10140636f8f.0.2026.10.03.01.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 01:11:04 -0700 (PDT)
Message-ID: <b3ed6eb7-2d32-436f-a984-45366389d0da@linux.com>
Date: Sat, 3 Oct 2026 09:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: amlogic,meson-gx-mmc: document
 the T7 pipeline clock
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260905153234.133217-1-tanure@linux.com>
 <20260905153234.133217-2-tanure@linux.com>
 <20260916203701.GA1463751-robh@kernel.org>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <20260916203701.GA1463751-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 21:37, Rob Herring wrote:
> On Sat, Sep 05, 2026 at 04:32:31PM +0100, Lucas Tanure wrote:
>> The SD/eMMC controllers of the T7 SoC are physically far from the
>> NIC_MATRIX bus fabric, so the hardware design inserts a pipeline stage
>> in the middle of the bus path to help timing closure. This stage is fed
>> by its own gate clock and, when that clock is disabled, a controller
>> that starts a DMA transfer can never complete it.
>>
>> Allow a fourth clock entry, named "pipeline", and require it for the
>> amlogic,t7-mmc compatible. The other controllers of this family keep
>> the existing three clocks.
> 
> Did the SD controller not work without this clock? If it did, then this
> is an ABI break which is evident by the current warning in linux-next.
> 
> Rob
Yes, the SD controller doesn't work with this clock, so I don't think is 
a ABI break, as the current code doesn't work and the board crashes a lot.
And a few patches got merged from my work, so I will resubmit a new 
series for this.

Thanks
Lucas
