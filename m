Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD113F45E
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589681; cv=none; b=C4QhQ4CGSnjmCvyKaDYpE3/ZRMtHkxuibWoHcykX5llgcGbgVajLyQWPyIA7S3CyvpBLzfpOK0UK0JBnVmOXDPxsD/R8+c09WoQQb6uMoSAy+L3VU9zrakNYZoyFkQMNFslAsZZ0PqHTJ1VGMGg1kbTZ7c5xPG6ybunyUWoMvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589681; c=relaxed/simple;
	bh=xRX7Du9blnTAfBwvs8mvTy7AGpIida2PZ1jdh4KYdhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAlpvp4pVdur4TdkKkT5qSisPE+qtcNM9/AEyoOKqqbDUQfYYYgTVxKlb2YGKptRmuxjZ78j5z8eka0pClrfhrzqwq+tclcWF/l61w8cGWw8OVaSCLm2qXTFFdEiPEBjA+2N4+pZVXNhUmSsjtBssgCzSpeDNqaKRvlvsYaPlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng+QuAKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng+QuAKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712589678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lIYUivOQs3VpmE6PppO1CDu6nFOP+Sm9cgWK6DGDmE=;
	b=Ng+QuAKkSeenV29pPtE9OV433aU9zEtirVp2exgbwYViDlvaImVT31iiy9i6s4ilVPklB3
	DzRaUgDAsB6U7eTLKaLHp9LlP3mKQNbR6xjYwWlgiSaT6zb3U/+jLCTJwaQo6cJER4PZps
	vtxTFLbh4EbCO5ZKMqtAoK67pVUvevI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-udl5rkHnM4SObAFkVUdDXQ-1; Mon, 08 Apr 2024 11:21:17 -0400
X-MC-Unique: udl5rkHnM4SObAFkVUdDXQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56c1b105949so3701742a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2024 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589676; x=1713194476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lIYUivOQs3VpmE6PppO1CDu6nFOP+Sm9cgWK6DGDmE=;
        b=orTYfNpvUcmWUgQk90ZebKgbiqGamYoIyg6vW5DIt1Pyb5klKDkJBG+lhT6vDDWkZJ
         jknfYlDYSBFeTGQDUuXqZs5lyT33Y3NRoWHAB2FUnPzkSiuR8MOV3bv0ffM/1FdSs6m8
         tLqB5ZAx2EmLUrII44j9gJ8hPO3ZI5i4T94u8EGrFPEfI14gz83SEVttSDNCi30XN8/o
         h2pLMc1Q7p622qaxWTapOj65SVFkJGUSF/G2lRyEkLlfZxAlqg5euDFsLLuAw5kvWtbG
         TnIuoRTYwsIwKB24h12mSl5E27NZmKlFiddnuIJaUbJqHFDVSBtWHr2K4g48eOXlvIua
         005Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwePx8lVnjmCtbq2IYVwhInzALaQQR5l6bhXK67L9ycVGUWN8PclwFs4aSUSmBM3gFjIsn7INyjOXtKpyhwlC/qrOT3md9M1kR
X-Gm-Message-State: AOJu0Yw3+g9NWn0FwKoJNxnjKj0Rx7QaCHsBGnROeAZnCQpcMr7impUw
	TXfZpJ+w6SoKXXgQ2LSn4TizohInix5DS0Rt0HM7nCmfMGrjjjw2iOr+De3zpT26N6WoLPN8zll
	ccTNtjICzJorVTR/JvbJ8loXalDJxYE7vZpNkHd8TLjEzJ7hK6sMk0+WpyA==
X-Received: by 2002:a50:c016:0:b0:56e:de1:f427 with SMTP id r22-20020a50c016000000b0056e0de1f427mr6165745edb.25.1712589676127;
        Mon, 08 Apr 2024 08:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFclEsMdG4HFGsb27uvDAbaNntcdUuxw3pS18H0N3IVJd1lQHhJQS6chW9a4EqWJhtKYkFRSg==
X-Received: by 2002:a50:c016:0:b0:56e:de1:f427 with SMTP id r22-20020a50c016000000b0056e0de1f427mr6165688edb.25.1712589674443;
        Mon, 08 Apr 2024 08:21:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j7-20020aa7c0c7000000b0056e5306ca11sm2223797edp.53.2024.04.08.08.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:21:13 -0700 (PDT)
Message-ID: <94cfa198-cad6-47c2-81e0-1b33898bbc8e@redhat.com>
Date: Mon, 8 Apr 2024 17:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mmc: core: Add mmc_gpiod_set_cd_config() function
To: Andy Shevchenko <andy@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240407200453.40829-1-hdegoede@redhat.com>
 <ZhQKMpL3a24o1fjO@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhQKMpL3a24o1fjO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/8/24 5:16 PM, Andy Shevchenko wrote:
> On Sun, Apr 07, 2024 at 10:04:48PM +0200, Hans de Goede wrote:
>> Some mmc host drivers may need to fixup a card-detection GPIO's config
>> to e.g. enable the GPIO controllers builtin pull-up resistor on devices
>> where the firmware description of the GPIO is broken (e.g. GpioInt with
>> PullNone instead of PullUp in ACPI DSDT).
>>
>> Since this is the exception rather then the rule adding a config
>> parameter to mmc_gpiod_request_cd() seems undesirable, so instead
>> add a new mmc_gpiod_set_cd_config() function. This is simply a wrapper
>> to call gpiod_set_config() on the card-detect GPIO acquired through
>> mmc_gpiod_request_cd().
> 
> ...
> 
>>  int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>>  			 unsigned int idx, bool override_active_level,
>>  			 unsigned int debounce);
>> +int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
> 
> A nit, can we group it with...
> 
>>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>>  			 unsigned int idx, unsigned int debounce);
>>  void mmc_gpio_set_cd_isr(struct mmc_host *host,
> 
> ...this one, as request ops vs. set_cd ones?


I actually deliberately grouped it with mmc_gpiod_request_cd() since
it operates on the gpiod requested by that / since this is sorta an
alternative to just adding a config param to mmc_gpiod_request_cd()
mirroring the existing debounce parameter.

With that said I've no objections against moving it either. So whatever
you prefer.

Regards,

Hans



