Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03713B587
	for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526531; cv=none; b=u0QcLbmcfjcqz96GGaMAJO2ZHQWNGqgDs8C3R7fD6v8w26jBH8BRCM1mpCXyT0dnrNyxN9aAmhJa7agjoU8Lb+xsxgV+WIHa8eX9xVlMUGl1bJvGtPlOCYBdbBY3yfdG5F1MuH18BkdLmw1es4vCm3lZMSGOIEpydjr5EN4f75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526531; c=relaxed/simple;
	bh=4H4YR0/K52vVw0BEDoTImD+JL5bNhzc9m0ae+WYCdSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fQGTKfh6xKsLfvKjzVDsJgQ4E8lelW4BCnGTkQpmzgdnoM/DCertNkDUFcO00aHAyrhOI/x8oRpjTaDXyHvzeKkDemuG65MCLaGEyJBYGlqJZ9q/+PeCfia7aQbHf5gtY2DE0UEJooBZavNKvpGsGQE3Wynnhxek1rvD+pyU4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=diOMoWRu; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="diOMoWRu"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso4977825ab.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jun 2024 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719526528; x=1720131328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+U5P6sQtlqvHqVMqUmWBld5jM5RmHwrjJ1USH3XW9c=;
        b=diOMoWRux+Z5jH1wwm0MXZNVX/tmVkhOl7guHntKH7lzqUXRoNbmp33hz58EBXqMbs
         BuHixE2ObB+tc1UTBuO5VPVJ828uXPiC0xFEMKMvTETYAusX9d6Tk8eWdFPC53ecqegs
         DRvdCi2AL9QLL54d9lYhLlBZtuBfTfhsJXJzNjTYDyP0wR7/WGdn5dL2FfwuhCB+2ZBh
         J+3zm8JGsE1GXIHfBa1rznBytn/QlhZooK/d5nQb1DMP2C7B+/bg3rje7mBgoVmdb9fe
         AjoQDq6YXbRvYYV8497A9K4CcK1qx1+SHFD32qP/bOMfGBxTeY6HvG91ZNR5e86e/yNR
         c6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526528; x=1720131328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+U5P6sQtlqvHqVMqUmWBld5jM5RmHwrjJ1USH3XW9c=;
        b=ZdAqx28/UxI78kLoKAE5NIdkb6/oon/QykIJt1TSeeu40o4fuDFogRO1GR7hCjYGqF
         JDKC3VAQ4BtqQjsqbExJbWbStLVn038vpKUhDOjguOPjcpIZYQlPyuzW/ieX59COvYbh
         0DIIYL1R7uH6WGgsTkA0zuwTZo/xHuuGFqNy1/qHPevhjXnlFCjAVDTd2jg7tbIObiJD
         Y9UhOBuQJQw7fPasbFmxwQzD+RN/HLpk997ne8pmiEnmwmZRRu00RK/KxEVjf3luaci+
         lDQqpyAmlhG2AOqOB42BgTspMTHIJT3K4zjlrYpc+wY/PS91ygqi3THTzceDR8S3zCaT
         ChsA==
X-Forwarded-Encrypted: i=1; AJvYcCVKy+a4CovEV+5pHhT04bjUSPuWroMnTByk+lWmCwCApOpYWmO3MUhPEpBvElEPI8H4twImUWDS+Gh9R+IRiqGfm4oMRWu1oZTP
X-Gm-Message-State: AOJu0YwavD6c7Q1xgOjeauUTAWnrK+WYvG6aqeKvlARen5sThVL5BrF8
	0rsTPu7oGl+UTCD8imCkPBUSnbkRiWJgYlHaYXMt16BogjbiLMr89X9X9u+wXzI=
X-Google-Smtp-Source: AGHT+IE+c3oTCSG4DXvfFxRH7ZmI2eqlsqlemsaW1irAg97d62AxsEpde/+Ps9QA1t3PJ2h5vj0L4Q==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr658652339f.2.1719526528386;
        Thu, 27 Jun 2024 15:15:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e54936sm222787b3a.35.2024.06.27.15.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 15:15:27 -0700 (PDT)
Message-ID: <5ac45dc2-f434-4ec3-9f9a-dab6bb029deb@kernel.dk>
Date: Thu, 27 Jun 2024 16:15:25 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] block: preparations for NVMEM provider
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Min Li <min15.li@samsung.com>,
 Avri Altman <avri.altman@wdc.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Hannes Reinecke <hare@suse.de>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Li Zhijian <lizhijian@fujitsu.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1719520771.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1719520771.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 2:49 PM, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more (hw/sw)
> partitions on the eMMC are used to store MAC addresses and Wi-Fi
> calibration EEPROM data.
> 
> Typically the NVMEM framework is used to have kernel drivers read and
> use binary data from EEPROMs, efuses, flash memory (MTD), ...
> 
> Using references to NVMEM bits in Device Tree allows the kernel to
> access and apply e.g. the Ethernet MAC address, which can be a requirement
> for userland to come up (e.g. for nfsroot).
> 
> The goal of this series is to prepare the block subsystem to allow for
> the implementation of an NVMEM provider similar to other types of
> non-volatile storage, so the same approach already used for EEPROMs, MTD
> (raw flashes) and UBI-managed NAND can also be used for devices storing
> those bits on an eMMC.
> 
> Define a device tree schema for block devices and partitions on them,
> which (similar to how it now works also for UBI volumes) can be matched
> by one or more properties.
> 
> Also add a simple notification API for other subsystems to be notified
> about additions and removals of block devices, which is going to be used
> by the block-backed NVMEM provider.
> 
> Overall, this enables uniform handling across practially all flash
> storage types used for this purpose (MTD, UBI, and soon also MMC or and
> in future maybe also other block devices).

2-4 look fine to me now, but I don't know anything about the device
bindings so someone qualified should review that before it gets queued
up.
 
-- 
Jens Axboe

