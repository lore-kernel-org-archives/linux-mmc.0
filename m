Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE51322A1C
	for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827502; cv=none; b=lhG4GtNs+e59d2MullBpdtDKF9VjhXfTNcYCGnPy+Tho7LRiuxOlYZx1bt62hi6xFIaLg7j+ooXc+V/lUsmn/E3Lbh092Rn3OW5lZSIZEWMGHr8Fo+HQJZcUGhm3z4VhkQrzS13LztRENemZY7Cm3D+6+NZP9PuFWi8j73R/bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827502; c=relaxed/simple;
	bh=PpslIjtfqdnivMU4+zxZKe2uCZBrq5qLNofJ1sx/HeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNPQW5K7hBAAlyrRcEo8lMkdlawlkpi0SNOSc+rq4HkwbvtkZw2+lErAx4AVp5xJIluaKJ8r3I+t+EUsieBApO2br1AMSAFlytPzXJD+GjBdxiqM7kSIDTn2w7JKY8ILGX3qXw8/KWB1VDUxHS8kG7fMSznpn51Mgqo7gbFcYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oGR+jQPf; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oGR+jQPf"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ecdeso1548126f8f.2
        for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 07:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789827499; x=1790432299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WVdtse4utFqdGo5H8fnCG1N9VsS3ll8DP5z6tgaWzw=;
        b=oGR+jQPfiTfptyCXAWBXQe9Cit7QtF8B6k3YHixtP+Pk9Z0zRWvKbPghLXi/Xg+yxQ
         OIbTKkOC9DJDl7ETC3kbR+2ZHFY5VN3wXDrQ7iUPfrVXr5Mhyg2O56nt5h/C85uL19Rh
         WQCAcDSG5pLi+NWCXKFNoewm+9p7UsAmOH1AmerEd+NIc4lNRHQe4MBIK5iJITHBzU3+
         Qj+ax8iVagCST2amDdNio1XJkCK3f9W/q6vPI3CAcBrC7ppXr/8xziCK7THezbyu1GY3
         8EcYV4BFWgCQy5R2YnzUSL0ChDxSTtKXkAxOuDtg9q6CstE9OueLX+ON8ZU746a24yKP
         lFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789827499; x=1790432299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WVdtse4utFqdGo5H8fnCG1N9VsS3ll8DP5z6tgaWzw=;
        b=XzjKpqtvypsTRla+ZUCawYHBpVNT6JYeLF5QXLYOpOTAki2T24R7Uel+u+qB2lUyLt
         mHVL0vQiqGD9OtgDdVBvvDdMwkeamHiQsEA3OnfxQfsMPGM0urmC5+zrsH+T7UqM7aYb
         fDBT+HT740LO3+Q+Ul8HuEArieFJ/CjH3uT+eHH+DmmUZ+o8sMmCN9SPKySl63/QZUrB
         yxyACATraX3mzkNuOZQrSwJI0vtLHnGzH/oUhogn5LLDuIDWC2AEyvnZmlEJYBS/zvBi
         OZO0Xkxx9clp7J66UGUk9uXvDkl3Jw4FbEs4s+mfc0iUTFOMMRveR5GkYcYnY9B87E9h
         i6vg==
X-Forwarded-Encrypted: i=1; AKwUvByn/80D8Bo1h8en09LK/OrT/4JvkdT3ze5k+0+tTbCUNpcUOekE73msrOLSJUmuPgWwUTYqg5lQcsA=@vger.kernel.org
X-Gm-Message-State: AFuF++kYtrvcqUGz2S7T4m/l/pTqAP/yn3nEhBpD1bthFcHYDI6PMONm
	9rOn7JNKTbWw2hZWg9Ig07Q89+BVvwsBjtS9xxGApQC2HRB5/jVxIDo9kcofDn6Qr1A=
X-Gm-Gg: AYBFou0XOQh+GyMikHxytXwselJ05zUM/KDNaux8F4hraNSWmbzZxUtUiFu7Oj9ZvJX
	PMaSclORF5MFgCdjAi91Vu5fYwGb7dn6v+8C2B1YWFUZ5Y6DOUx5qa6EOKy3U9jDagZCa98flxD
	eB6uXqkYBDxRzZLU0NSBN3jUSemqdiVdZEHFYTaXyiMQEeq0XpwuHoDouiXaY+hUVoFqP/DKW/a
	H8q3XAEvGO0Vu/mMllXmxzej82hVVCHLkz5rQrLmhzPR+2rEipU8VkRfLqWp+hOgM3kxZiIfs1R
	rQ8WbfWYloJQsNc8SlD8Ui3ljrwcc+DK73ROozz+UfZlsbEruI7eRNpOJ1mh5JFmgJ5mxgtbzmh
	rR1yx1B0Ph2GvIPtOEb7aA8ZWA+V8dreCNY7dyLnnS/i6r+LVKmA+y+CImC/ozJndMm/Xm55au4
	xlvWnyDp5yGav9BtxCbowUEqtQKoH91HCysob5FycMIJFPELhmyL1A9cVPNF7hGja/d+awTKD4y
	HPJh+G+L3H+MWvbtHJYWI8E0wh7bzVmDAnKhkusLyzX9pM0o2dCtiAs
X-Received: by 2002:a05:600c:c493:b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-49fc573603amr76055195e9.17.1789827499187;
        Sat, 19 Sep 2026 07:18:19 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd090f0csm106407185e9.15.2026.09.19.07.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 07:18:18 -0700 (PDT)
Message-ID: <5d09e717-a478-4c9d-b5b1-9f309edc064d@tuxon.dev>
Date: Sat, 19 Sep 2026 17:18:15 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: microchip: ev23x71a: enable eMMC
To: Robert Marko <robert.marko@sartura.hr>, ulfh@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, adrian.hunter@intel.com,
 aubin.constans@microchip.com, ehristev@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-7-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260907132617.1198548-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/26 16:25, Robert Marko wrote:
> Enable the non-removable eMMC connected to SDMMC0. Configure its 8-bit bus
> for 1.8 V DDR operation.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
