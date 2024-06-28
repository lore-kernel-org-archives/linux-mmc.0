Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739D7EF10;
	Fri, 28 Jun 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559081; cv=none; b=gT2fyoUXCk8nNEBJlBUq9k4YxtFzX4ZYcpOSYQKDd4L2d66FIka5D/KcehQtez8h3pLrxAbzd9vRuVG286/AUo2MoF2J7jn/gx1hI1jo72vISKF5vVlYGyueyi1Jm5Ge93lUa0MMqD6Zgidvdiyunl6gqpKcoCxeyLPC7BoX5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559081; c=relaxed/simple;
	bh=0RZPHCsU4i+1vrvYWab6QVG+YOkmC5+uqu8sWSbOTvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdJxMHyJnUm1+Uhz6S6p9yklB8uTODM80Chmf+76qXgV15eqG464nvfze5v+H/k7+f5zBtJSIrp6oiu3w0duhmXWXb+zgsq/o5vUs/v/Eei/d0sptpxRtObD+lictVjnFCRrBskaf+NNP986Ibl8I7FIvt3OFd2nlzipWX4zpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpmUfmU3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpmUfmU3"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d55e963db5so169594b6e.2;
        Fri, 28 Jun 2024 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719559079; x=1720163879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihtavBzq8pdcbr377xAX4xq7trLirF46FWhb4Rl5dvA=;
        b=SpmUfmU3tMZSwaoq7fHjk/Oa3vLuIW2qPCvN85FPREz9OjTWRa9X5eSZVN5sr5ndpU
         TvPEm/LIlkSBl/lV43r+iCkeMmfXwNqCRe0pwp7BAF+PUebahLU/J8wmY9qItU9Un3rh
         qOOXag2sJMBTJlARZiLbVFnmbzpKeLj3o2x7AO0E1Ra+RxEGM457+kO4EtbhKPnMqH3H
         tWQfKRdCOTD28pmav1R502HM26tGV9BAXDK/gFH2jvTdRrjr3aXtBVpyDnZSRQoV23Kk
         MIregEd/8WNGuO0PL41/15iZ3b22Aq7HWHn/bhi2LdSuxUzAJ39KGmWBYYM+r8upMEYy
         pwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559079; x=1720163879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihtavBzq8pdcbr377xAX4xq7trLirF46FWhb4Rl5dvA=;
        b=ENIHzG11tHjRsTC9smjOrlIEMYAF7+GDYM9QT7Ryaad3BqViwzkRelPGNZEeeAly0N
         kgtaQElFvqap12KqG1idg8FxMe2RzB5G8JZFOci7YQ0JYAttsltyIndbGIJPyc9PppRO
         Udzr4n05pBNDEluBU+MUvJ33xeOtjdE8/Lh+iD6xr7NWjVFp6D1baFobKkAjqKp5XYN/
         JToeexarP+RR+D1VS29SN8WYGKNgpjPg6GF7kQGN4h1/Aka9LNfQrg1H2O7zO0n8tW8g
         CYivdP+WNrP8Ca85IN+Y2Os9TYdfZIQzAwf/6e3Z7xicrfylZdyUHhXQ9epj+RwRqiVT
         ntoA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y1Mwm3uUzw1uIMjLzT3iQj93a9urPjU8nWoadAm7Sjkar8g7in25X5Y0BjqnGMlMDB5Ix03aBxn4V9Ct5i6SOzXSAXqLyl/uEoIX0gaFlu6DW02Hgvqlp+tX7Pdwc3lFXfqvE0gyQXLiI54a3eQHvf3PtO+dRSl2vdfqi1ENjI3Yaw==
X-Gm-Message-State: AOJu0Yyhne3PBOdYhwU9grqvlQggfLLRV8nJbQ9S0RnK3ks8D51+V+1x
	H3w662fDJ283TYN6sAV9g6RujzJ8Mo1wHfz6oC9AxuN603GUpS5jvVVXHb+9r9c=
X-Google-Smtp-Source: AGHT+IFRIoBQG3lK79wL64nahydZiVGcshjIkJCabX0xCJPwNakHf8vLho5MT+pOLeZP9d8Q05SeWQ==
X-Received: by 2002:a05:6808:1287:b0:3d5:5f49:86ea with SMTP id 5614622812f47-3d55f498a3dmr10255017b6e.22.1719559078686;
        Fri, 28 Jun 2024 00:17:58 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf9d0sm876772b3a.115.2024.06.28.00.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:17:58 -0700 (PDT)
Message-ID: <bc609725-9201-49e7-bb34-3b3b4077c0e6@gmail.com>
Date: Fri, 28 Jun 2024 15:17:53 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
 <216059e5-2160-4797-b431-b391ff69cd2c@intel.com>
 <f0ae92ec-ae2c-418d-9cfd-199e312e2c23@gmail.com>
 <8e633bf9-4891-4e5c-acac-187c7e7249f5@intel.com>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <8e633bf9-4891-4e5c-acac-187c7e7249f5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Adrian,

Yes, that is correct. It relates to the AHB bus DMA burst size.

     /*
      * Split data into chunks of 16 or 8 bytes for sending.
      * Each chunk transfer is guaranteed to be uninterrupted on the bus.
      * This likely corresponds to the AHB bus DMA burst size.
      */

Best Regards,

Shan-Chun

On 2024/6/28 下午 02:59, Adrian Hunter wrote:
> On 28/06/24 09:30, Shan-Chun Hung wrote:
>> On 2024/6/27 下午 05:40, Adrian Hunter wrote:
>>> On 26/06/24 12:49, Shan-Chun Hung wrote:
>>>> +    /* Enable INCR16 and INCR8 */
>>> Comment would be more useful if it said what INCR16 and
>>> INCR8 are
>> I will modify as follows:
>>
>> /*
>>   * Split data into chunks of 16 or 8 bytes for sending.
>>   * Each chunk transfer is guaranteed to be uninterrupted on the bus.
>>   */
>>
> AFAICT, it relates to AHB bus DMA burst size, so maybe add
> that if it is correct.
>
