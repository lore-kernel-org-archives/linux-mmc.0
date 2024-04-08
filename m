Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960B13F45E
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589736; cv=none; b=kRpwad1qE4V/4ACOgpiH8oGWVAxxONF+vX+7upnumR+Vi/xPsYe4g5QI2a7W8TO1Atxr9bSVezxRJ+m8gbpzCdgZJ3b78UPNZOtXbTChsbVJbmo4DdpfZuXxQmwZqvcKmaU6RpGNOq4t/QCsO0Tre5oe+5wKDTwel81FtkrV0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589736; c=relaxed/simple;
	bh=mdxRFDP/fJY9LNfVWpqv3bciV0awZTad/suM50GtTwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boRdIe/OFvI7ZbICrp08XyxkQkvSTyyW3s7bno5pOU6kwJubJE1Ed7KtjVioJcAX1IiQQUHXdYJcWEU5fZjrkltpWeJAHXIUcOLdBOK6/tDBEnC2+Ut4jUhVzlsNv01nwhsYNBC9CSBoNwrF7qbiXOO2hL6Futfaxo2/kZClX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnWNhcfk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnWNhcfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712589732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fq2QYO9X+TFapJRSM7+TRy2sSb2j5RewS6tFIyzbq00=;
	b=YnWNhcfkbrJGaDfRoabmDPoWFzBYnIhJJU447mH49xISp3K1nEwZ4kIPw4+xVoigepFK8N
	RBKnOz818CxZmcHOFjkGhlpl3b/e2Ks4xWCH5NmyGfhRkgpHBbTUweYj4h6Vw906mTWbkU
	twZP20vGsfmsgTumF9Hu5IUZQvJzYGY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-0hpNrWMfNeKhLtdA2ah_hg-1; Mon, 08 Apr 2024 11:22:08 -0400
X-MC-Unique: 0hpNrWMfNeKhLtdA2ah_hg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a45acc7f191so295364966b.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2024 08:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589727; x=1713194527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq2QYO9X+TFapJRSM7+TRy2sSb2j5RewS6tFIyzbq00=;
        b=YhyoM7egmDFJEM3YZgwhvqjAqGcS0xfeYPk0nj/311xcCaD3rFXnE1gQZz6wvoKDtj
         AdK4w8IJWFoLyrht+MTgBKhbxOe6DWb2ycBqKBqsfNXvhtXHWfUiU6wwMiq5NXKfE+d6
         Cy2ORjHyI5PffL/srLE28gzAsdn3Ij/1GM/E2JFR6RNXZE2jkgjmRStIIlJz9dmUMMIs
         1m8MmNSMdG5aEGt5YEZ6hTg+0mWKJsR9B5ZqX8SXYI0M1+G+KVTB5qmHjaqkPWaaP+wo
         qX0uNtGDIJfWQBlyOBE0aBjTim35gkU4b5gYdSJzZ9hv0lVM39aTiIyRC25BIGQRj6sG
         sesA==
X-Forwarded-Encrypted: i=1; AJvYcCVjwi8EL/XMi9ppc0EV+/nQRTAhRsdHLxac2M0ti6T725JfWCCyLlmNK8nqtSXvncHnglvok3LqIWn3lIkuLVGNMQ9JxZCClDkE
X-Gm-Message-State: AOJu0Yx7RMBrPeR+JjEgCyY+IkaVvi/zfr9VqDo7hSSrcJSWvLEQD1p9
	kQXc9KNcKY822JZXroMVHnN6EbVFLPYgEFR99H/pbFxUqwCgdJF9KfuyPpL0nrN3r7BsMTKznzT
	UVdjSR4BQS0v1FAZWRBoAG9V3iCn1jtmpeXxumYAew415OpjUQ47n87Q/eg==
X-Received: by 2002:a17:906:374c:b0:a51:7ff3:5d5f with SMTP id e12-20020a170906374c00b00a517ff35d5fmr5994133ejc.67.1712589727074;
        Mon, 08 Apr 2024 08:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2oOmlGwU/XEafe0tSNrYtXAq6rzCrYHM9CIvWLjh6DbVGjel4q9KmFr2qwKitxZ+aYMxG9A==
X-Received: by 2002:a17:906:374c:b0:a51:7ff3:5d5f with SMTP id e12-20020a170906374c00b00a517ff35d5fmr5994122ejc.67.1712589726832;
        Mon, 08 Apr 2024 08:22:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d4-20020a170907272400b00a4e5866448bsm4553639ejl.155.2024.04.08.08.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:22:06 -0700 (PDT)
Message-ID: <8e1e561f-3d34-4023-bae1-08bce71ebe55@redhat.com>
Date: Mon, 8 Apr 2024 17:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo
 Yoga Tablet 2 series sdcard slot
To: Andy Shevchenko <andy@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240407200453.40829-1-hdegoede@redhat.com>
 <20240407200453.40829-4-hdegoede@redhat.com>
 <ZhQK6K0OUrXmrtWQ@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhQK6K0OUrXmrtWQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/8/24 5:19 PM, Andy Shevchenko wrote:
> On Sun, Apr 07, 2024 at 10:04:51PM +0200, Hans de Goede wrote:
>> Unlike all other Bay Trail devices I have (quite a few) the BIOS on
>> the Lenovo Yoga Tablet 2 830 / 1050 and Lenovo Yoga Tablet 2 Pro 1380 (8",
>> 10" and 13") models sets the SDHCI_SUPPORT_DDR50 bit in the sdcard slots'
>> SDHCI controller's Caps_1 register which causes Linux to try and use
>> UHS SDR12 / SDR25 and DDR50 modes on UHS cards.
>>
>> These tablets do have 1.8V signalling implemented in the hw level through
>> the Bay Trail SoC's SD3_1P8EN pin. But trying to use UHS modes leads to
>> lots of errors like these:
>>
>> [  225.272001] mmc2: Unexpected interrupt 0x04000000.
>> [  225.272024] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [  225.272034] mmc2: sdhci: Sys addr:  0x0712c400 | Version:  0x0000b502
>> [  225.272044] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000007
>> [  225.272054] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
>> [  225.272064] mmc2: sdhci: Present:   0x01e20002 | Host ctl: 0x00000016
>> [  225.272073] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> [  225.272082] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>> [  225.272092] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000001
>> [  225.272101] mmc2: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
>> [  225.272110] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
>> [  225.272119] mmc2: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
>> [  225.272129] mmc2: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
>> [  225.272138] mmc2: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
>> [  225.272147] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000900
>> [  225.272155] mmc2: sdhci: Host ctl2: 0x0000000c
>> [  225.272164] mmc2: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x0712c200
>> [  225.272172] mmc2: sdhci: ============================================
> 
>> Since sdhci_acpi_slot_int_emmc sets SDHCI_QUIRK2_PRESET_VALUE_BROKEN
> 
> sdhci_acpi_slot_int_emmc()
> 
> 
>> I tried setting that for sdhci_acpi_slot_int_sd too and that does makes
> 
> sdhci_acpi_slot_int_sd()

These are not functions but structs .

Regards,

Hans


> 
>> things mostly work, but the above error still sometimes happen and
>> regularly access to the card simply freezes for seconds, which are
>> problems which do not happen with the non UHS SDR50 mode.
>>
>> Add a new DMI_QUIRK_SD_NO_1_8_V DMI quirk flag and set that for these
>> tablets to disable sdcard slot UHS modes by setting SDHCI_QUIRK2_NO_1_8_V
>> for the sdcard slot when this quirk is set.
> 

