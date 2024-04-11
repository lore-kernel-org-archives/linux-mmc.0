Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA614B081
	for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837779; cv=none; b=kIRlDTmITGA+GvKAIhoRMb1WFoYcSupA66J+bjhUdYa+e3imK7QbWDqFaYVY79Ca7pvJLuj7fI16YPM6wSRATw6iPYlqAyAImefG7USRcaJ+74bqtAhfJym30ozCRsmFjLS05Y+nUQv1qY5DgDyp32BaLuQ7yLwmaHfd5VbUmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837779; c=relaxed/simple;
	bh=RsWSzvqfRrvQGDUZSked2pWIzCaGfGyUajfHMTKBnfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQ/p3pwPkZfwByJ+evWs47aLQb/r2ZU6vGJEMyGJFmstspLX3OyaSq0ToG4mv1p30s45aQzOL8VNeJ5eG0pcbOtm/1ah/4JZBXrKpn99L+FkXEwQvZtyco8EoqqbDD3HU0+RUIp4hLfIAR3WraTARl4HrsmvFoeLNAlZ1xUnBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iefl028Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iefl028Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712837776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fpb1PA6lu+VHUNPqG85Lr6dBe/adZWkbu+51rmdO4Pg=;
	b=iefl028QbHiAgeI7sdbw+m4r3JLf3DG6o/1JkJ/v6jPI774MuUpjHdorBpDXYwngj1UHsB
	O65j5J15pAvNvK8j6V28LQ+UZa30YDQKiucEHiOsZpLF9sgP3Z3ahKCBmiKIXfN1AUZVk8
	QnLPhpgwCeoAtRVOwbI/hZ4xLv90Otc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-LgnH8PbnN_u12fP8EvziPw-1; Thu, 11 Apr 2024 08:16:15 -0400
X-MC-Unique: LgnH8PbnN_u12fP8EvziPw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d87f5937fcso42369251fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2024 05:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837773; x=1713442573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpb1PA6lu+VHUNPqG85Lr6dBe/adZWkbu+51rmdO4Pg=;
        b=aRwISSlMUJe3PldFPCEWQ/jQkSiubdVEqf+RS2v32AZpDtFFtwbVKDexdmhRiKG72b
         GKI5sCwAKHkNxCjR8Qv0XpgEKuQKb1PxOkxib9z7Mzr0c2XUy6FRkT+jIEqj46cJUoZq
         N7laIFhfGAvNtXcS5ggPx220Ae2+8z0CjfwLQi8TRtB92E+8Eq6tyhZqJ5s1FHNX2/tO
         pPSOlb+RN0Rzr9wCQ/xEy3lHKck//oC2YLtYAXarTl8T6L5QIBYxvhyyW2yhg2s5lbNf
         N66m161eBqxHRl9HWMrSqL4wXxtZko18PkguYDLOWsDV96TcdG7S3EcM98SwzkNFK7hG
         vtPA==
X-Forwarded-Encrypted: i=1; AJvYcCUxSkPRS6LQhLdAPhthWulxGW+V3qC7CGAuhA0v1Yfp8UEcztK6o9LKO+XmSFV0MPdKyxSSQTfM+SYNYaXnk0Tquqsb6lrAB90y
X-Gm-Message-State: AOJu0Yw2CPerCSRc+/LIdDIdwZdnbGSnavEe5/8WsCVt5sSwUV421UqA
	xKLLD9KmLzQp6ZDyCeVIOjWgDvJ+Fpd49FuuZaVHMmhzMUWSbDRDFEAPzfRvZMa2j3zmZib2zZH
	6CkU0eCSGWAkzJWRyaN0qp9bb6n6ULPaqaz1Ekz/RX9nOs/F9oYzWoyiwt3pfWxQt2fjS
X-Received: by 2002:a2e:bc23:0:b0:2d6:c23f:7dff with SMTP id b35-20020a2ebc23000000b002d6c23f7dffmr4329190ljf.44.1712837773509;
        Thu, 11 Apr 2024 05:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Kb6ndMMgsnlXZOXRSCmDhjhTY2JLx8jmfc+5fD4WKLaHk6hFxOJ4qGTxegeljAvujYRgQg==
X-Received: by 2002:a2e:bc23:0:b0:2d6:c23f:7dff with SMTP id b35-20020a2ebc23000000b002d6c23f7dffmr4329172ljf.44.1712837773170;
        Thu, 11 Apr 2024 05:16:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b0056fe7e308c3sm572339edb.0.2024.04.11.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:16:12 -0700 (PDT)
Message-ID: <fa9deb3f-5d07-486e-965e-fb5f998c9868@redhat.com>
Date: Thu, 11 Apr 2024 14:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mmc: sdhci-acpi: Add quirk to enable pull-up on
 the card-detect GPIO on Asus T100TA
To: Andy Shevchenko <andy@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20240410191639.526324-1-hdegoede@redhat.com>
 <20240410191639.526324-7-hdegoede@redhat.com>
 <ZhbxNdf0mGB4zbzA@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhbxNdf0mGB4zbzA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 4/10/24 10:06 PM, Andy Shevchenko wrote:
> On Wed, Apr 10, 2024 at 09:16:39PM +0200, Hans de Goede wrote:
>> The card-detect GPIO for the microSD slot on Asus T100TA / T100TAM models
>> stopped working under Linux after commit 6fd03f024828 ("gpiolib: acpi:
>> support bias pull disable").
>>
>> The GPIO in question is connected to a mechanical switch in the slot
>> which shorts the pin to GND when a card is inserted.
>>
>> The GPIO pin correctly gets configured with a 20K pull-up by the BIOS,
>> but there is a bug in the DSDT where the GpioInt for the card-detect is
>> configured with a PullNone setting:
>>
>>     GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x2710,
>>         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>>         )
>>         {   // Pin list
>>         0x0026
>>         }
>>
>> Linux now actually honors the PullNone setting and disables the 20K pull-up
>> configured by the BIOS.
>>
>> Add a new DMI_QUIRK_SD_CD_ENABLE_PULL_UP quirk which when set calls
>> mmc_gpiod_set_cd_config() to re-enable the pull-up and set this for
>> the Asus T100TA models to fix this.
> 
> ...
> 
>> +			mmc_gpiod_set_cd_config(host->mmc,
>> +						PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 20000));
> 
> 
> Just noticed, the PIN_CONF_PACKED() is a helper for pinconf-generic.h. It seems
> unusual to use it directly, and AFAIU documentation, it's for static
> initialisations, however it's not explicitly said.

I saw the static vs runtime comment, but I assumed that applies
to the parameters passed to PIN_CONF_PACKED() being determined at
runtime (not the cases here) vs the parameters being static / const.

Regards,

Hans



