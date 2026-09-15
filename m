Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2584B541D
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487723; cv=none; b=aQ7O67EcfclpFFGWMhzDv8X7TzBwLaoV3lPUAguhmtovJJroMXZ5Q//zWk2orEPMRiiQwri+WFW9Rc7+d5OaiD6goNRKfbUOnbHGzLulRWypOcmUjyiUUiA52ccrwTErUVcKw913zoUqKR35oaiUXwAVYEX+NCddrPgeUuf6CPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487723; c=relaxed/simple;
	bh=+HzaoJJ1ZNqvWhVTWzsvw+MglRBrJ30uE/Z5FYqCy0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doeN7q7fUCMn/SFQYqwNc6Z+jii+m7GdB/6De7ayEqvtqzIvyOS8rOgOFFB87oyq8j7FXizcFJbVKh9LC1WpdZaqF2S8iNUXKDEfAM2j/sCIsIhIKZBFMWEAo1ZqBMjQseBc+sGQ1rQioM7IARj3da6dmwyFVG59g6/+MIGJXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so107719866b.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 08:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487719; x=1790092519;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wp7WIPM4acbNtx/6GioAbRHdq+dUssBIHTJbsJvHyw4=;
        b=GR586e4UXVF16OwuJS7lUq7rDQtuAP2s90lbc98aT3T9iFXbRE/RXep8cQTT/csyFL
         m28tmlQFDb7U2C6BsRSaoI0NnfXrn8pKEQjGs3kYn/pYpP1fBZhH8VASRmkOdLSQ07ZD
         uZrtVq7clBjKiXYD6vXk+q7CgeLhO5oDwarvLkFXIbSlbT+U8tFm1hBlgY8cn1a0u5zD
         KqestBsKYWQ2TdUi+EfWSuQssYORBPK04EcJCbTLbQfERs4HGvimFkfdDe+olk+nfVK8
         cxc2Ox18jsxcVvngDNVJ0kWKvkgI77JZEfvSPb0sDcv+GnzL2GNhZgfQxszw+kxYiJhX
         EJmw==
X-Forwarded-Encrypted: i=1; AKwUvBy8ajjlOVe0MZ589PXsLB/MVWYvAbua/zJAj0MdHYjPP24T7+BUBOCmPwYVyTOyAwElTkxS7LrpTs8=@vger.kernel.org
X-Gm-Message-State: AFuF++kqUEiErPfiIcLK5d2gKNRRRWBTkDfVizFLXEui7VbQAC6Rh16R
	zXx1mV46HlV+VK54dx7FWSPbHtxHMaTUnwLaleNKzmCa149Sv3jSR16s
X-Gm-Gg: AYBFou18fN2j1hy+o5Mdm2wPoUTIbJ7l26QYCp3tFJaGCbNA/jPaJ7xlA2hTAwhWrsI
	gII5IegmeKXE9xrX7TAbL8w4R7iQ5A4w+ACFX9La6r3SMSQSlPtYZgPO9/Iw/xrm39hZZ/ai7s8
	PdRnGO+ReLfXtI0H3/viCxaKYaPjR5XnDTKnK5B7NXzsnS7MDAAKafGSd2LV3GC6CpGsKr64oXI
	iWVePnYd4VFiTUv0N1ZiCsdE8cCWB8//rzcd7ezyFoQIrnVJF83lrSeWcNnfmj6s8AI9Q4gKBQ9
	ZDemBJ1gzrhChnpYbSK7i0EgExyk0m1ms2uqZ1CibCaFcSFHHm2khvus239uET+Zj6tJxt2jcP8
	WR6zkZzVqAQoyJam2URC90LrWcHIfWEpi/r8Oz5rW5W6yFEwFiuYUtmT+X7BIBslAEkNWRCdEop
	o6pABldoVZH8LPg8KGNFcD4q1zLtz7d1irhS3QMLJ0ox9fMGphTtpZQBYDcKfpwwZSx5GI/13ao
	cnvH8n2eHvS2mbUH91eHQlZ/56IDdQ=
X-Received: by 2002:a17:906:4795:b0:c26:2f09:f2d8 with SMTP id a640c23a62f3a-c29d790987bmr118615366b.36.1789487719226;
        Tue, 15 Sep 2026 08:55:19 -0700 (PDT)
Received: from [192.168.1.135] ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966125543sm610972266b.55.2026.09.15.08.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 08:55:18 -0700 (PDT)
Message-ID: <dbf50a87-cf43-452d-8a82-6d7ee9af02a6@linux.com>
Date: Tue, 15 Sep 2026 16:55:17 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] amlogic: t7: give the MMC bus pipeline clock real
 consumers
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260905153234.133217-1-tanure@linux.com>
 <CAPx+jO8oWZxgkWTv3v5odp8K2oWMY-KhJVR3U+iqY4mQ9LrG9w@mail.gmail.com>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <CAPx+jO8oWZxgkWTv3v5odp8K2oWMY-KhJVR3U+iqY4mQ9LrG9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/09/2026 16:40, Ulf Hansson wrote:
> On Sat, Sep 5, 2026 at 5:32 PM Lucas Tanure <tanure@linux.com> wrote:
>>
>> The previous series for the intermittent boot hangs on the VIM4
>> marked sys_ampipe_nand as critical. But as Chuan Liu from Amlogic
>> explained, sys_ampipe_nand clocks a pipeline stage that the
>> hardware design inserts in the bus path between the SD/eMMC
>> controllers and the NIC_MATRIX fabric to help timing closure.
>>
>> So the clock has real consumers: reference it from the three MMC
>> controller nodes and drop CLK_IS_CRITICAL instead.
>>
>> The series crosses three trees; patch 4 (clk) must only land after
>> patches 1-3, otherwise the DMA hangs fixed by 43e1705ecab9 come back.
>>
>> Changes since v1 [3]:
>>   - Dropped the Fixes: tag; this series is an improvement and should not
>>     be picked up by stable (Jerome Brunet)
>>   - Moved the patch 4 dependency note below the --- so it is not kept
>>     for posterity (Jerome Brunet)
>>   - Dropped the e-mail address from the Assisted-by trailer, see
>>     Documentation/process/coding-assistants.rst (Jerome Brunet)
>>   - Fixed the space-indented error path added to meson_mmc_probe() in
>>     patch 2, it did not pass checkpatch
>>   - Dropped the CLK_PIPELINE() macro from patch 2; has_pipeline_clk is a
>>     capability flag, not an SD_EMMC_CLOCK register field
>>
>> Thanks,
>> Lucas
>>
>> Lucas Tanure (4):
>>    dt-bindings: mmc: amlogic,meson-gx-mmc: document the T7 pipeline clock
>>    mmc: meson-gx: enable the bus pipeline clock on T7
>>    arm64: dts: amlogic: t7: add the pipeline clock to the MMC controllers
>>    clk: meson: t7: don't mark sys_ampipe_nand as critical
>>
>>   .../bindings/mmc/amlogic,meson-gx-mmc.yaml    | 29 ++++++++++++++++++-
>>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 15 ++++++----
>>   drivers/clk/meson/t7-peripherals.c            | 10 +++----
>>   drivers/mmc/host/meson-gx-mmc.c               | 20 +++++++++++++
>>   4 files changed, 62 insertions(+), 12 deletions(-)
>>
>> --
>> 2.55.0
>>
> 
> Patch 1 and patch2 applied for next, thanks!
> 
> Kind regards
> Uffe
Hi Neil,

Any chance you could queue patch 3 for this cycle? Patch 2 is already in
next, and until the DTS lands the MMC probe fails on T7 with "missing
pipeline clock".

Thanks
Lucas
