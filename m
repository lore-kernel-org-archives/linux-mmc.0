Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF813E88F
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590072; cv=none; b=lfIoLZO0ouELl8H9CPnb7obuxabkgB/P+PepjkuIBXjNl0rFq8o23m0gKlWmFDGNQ23An4aytfW8qy3ejU9+6c8AiDVtCnkI8B00t1VffACR686uhRw5QeUFbhR8zfV0XMqjrebFicO5jH1P1p1qG4dX6OFzGS/QvzVcOzxNObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590072; c=relaxed/simple;
	bh=mlVW9Me+XbweFyG9F25yRrb5gzakcJA4MSi16ccv36k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVcircL2LA9ATeqo+nBjgbSvpufhxbfM6UIrvz4aX/07eTtBtzgec/bHMz2TVi1Bp9Z0kPubSJlRB8806dVLmuJz0du2t0BSoyDoBbw4mhRoRlSiSrLUBOn0tDbnW+KWG8NzL5CwAIhJbimWQ3mUHj1b5WjQJGgqF9KIrJ+EkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJ4f8UKK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJ4f8UKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712590069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9lmgoGiJPBgqXYheNnhSIDVhxfqRrXJG/Rw0VMx+Zk=;
	b=bJ4f8UKK8x1yH9MPTrKgFmIRsGcZnxsFpI4ajXs0l3Xd9Z9Hazf7W54nVRYZ6aIKmshx11
	aICKQ8htF/ZzDtr/KOrnmOS8glikGPDI+RdBc2u3NVrBq+FO45BzZASUvUucNd/Tq9zLv5
	cpGo6UGBeRg5l6xZwq9mc5x7TPvbTNw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-a9MW7ZEcOoiJBcJyJDc3Tg-1; Mon, 08 Apr 2024 11:27:48 -0400
X-MC-Unique: a9MW7ZEcOoiJBcJyJDc3Tg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45acc7f191so295717066b.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2024 08:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590067; x=1713194867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9lmgoGiJPBgqXYheNnhSIDVhxfqRrXJG/Rw0VMx+Zk=;
        b=JONRwvnLwiMtoL/MRvHwwBh592aPpDB5OxfGcohTkdEbEY8XjsEk2jrtAa/b2RQjkR
         sKAdhJ8AL2qdidQt0h6jo6U1Cf8RFaqTIleOyNBlgjk4TtjlJhiAFREDctCVutcrii/J
         9ueznnwIBxjlqWS7ehwF9Ih7BOqiWmqZOOKb93H5DCrce0r/talyLWbTSVrb1FjlO1Ln
         9CdTpqSau6uPC+8/7zkZFkrorkRKwwEmZPVr8NmffsX2DDB6cEWwOZV6DJ7c5YFX0PQm
         1QO51KHh2t/MiT6loGKY3b+WTwMStfJqOXCZoFmr0qO68ZSvvoiVAmYrQs/E3Bg+rOl8
         6ueA==
X-Forwarded-Encrypted: i=1; AJvYcCX3NocP8oAyNAUd7NOqJh5TktMYRtPWTJpTwLGVN3p+fqiDG0AUtLNarUue1zqiakGgL3ynl/brwo18Xw5bLunF0DZlhyVtFuTa
X-Gm-Message-State: AOJu0YziUxmwehnzF00WCsSiUsD0tShZsKf/P1Tkz0L7vz8W7J9skXSU
	TeRKGfleUxKpBJxJHYDxKDDTAU9Iq2EgisVszz3oGjPQvaQOgy9/JVk5iO4Cze/2mYQTO39jXfj
	w3dTeSYPli3KS0EaOI7PMmnlZuwFNZp4qs9qr6HbV21KdSxnY8zG9rFpdIR3LI8+1liaq
X-Received: by 2002:a17:906:340f:b0:a51:d235:74cf with SMTP id c15-20020a170906340f00b00a51d23574cfmr2674300ejb.38.1712590067150;
        Mon, 08 Apr 2024 08:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI/VwBmMFdArbHeoBDZ2t7a+cc1SsBqXDZl12Lkul3tuzGYitmToVfeIox5n1MLEEUok7krw==
X-Received: by 2002:a17:906:340f:b0:a51:d235:74cf with SMTP id c15-20020a170906340f00b00a51d23574cfmr2674286ejb.38.1712590066822;
        Mon, 08 Apr 2024 08:27:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qb34-20020a1709077ea200b00a4df78425dbsm4496079ejc.36.2024.04.08.08.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:27:46 -0700 (PDT)
Message-ID: <01494b5d-b7de-48b7-b68b-69a32da9fa5b@redhat.com>
Date: Mon, 8 Apr 2024 17:27:45 +0200
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
 <ZhQL7KmvVYgRpz46@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhQL7KmvVYgRpz46@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/8/24 5:23 PM, Andy Shevchenko wrote:
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
> FWIW,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

for just this patch or for the series ?

> assuming you considered addressing nit-picks.

Ack will do.

Regards,

Hans


