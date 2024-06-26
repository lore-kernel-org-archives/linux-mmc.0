Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48F192B62
	for <linux-mmc@vger.kernel.org>; Wed, 26 Jun 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431216; cv=none; b=czGAOGfFmpnNAc871eon9MbZMzXSzYASygI7BxindDZ7OeqkaobJ61pz5T09Bh/8GqKSkkVLg55ufg5sSliE0Yk/G7V2sV6RPgfauXQw7TfmIkyE7Q53ZM+kLPrt3lEYE/oXrIId5G72gxIl643FUrn0tD1m4uV0Q4Ge25ojh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431216; c=relaxed/simple;
	bh=90IFLVAimWlxflMq5YOSkklPtSnG+d0tK9j19/4wy+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=akKXQk6CiWRjssEKOxAsHgvEcoAin1Hm8hpTog+uw3eKJc9DMfQwLPqhvJ9ww+MERSzMrhfBWgOfJKnueHJykK0MKb1LuI1nhcv0nvJd4z9Lfe2eDZTIJLUXcAho+rmnjVKo9hKjpxJ+j0qZjWllVnN9Lt/nmmRT08rkGh4pSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J/HoTc6D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J/HoTc6D"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e3341c8767so209971a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 26 Jun 2024 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719431214; x=1720036014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFQCYxkTWkVTkeG4pmT0NAA774VOsw4t919VmGwibAQ=;
        b=J/HoTc6DvBbXkVC/M33JaTxGUpNOKP352At2Mv2yNXqE1bHJ7j79D2yD7IF40yBI1y
         7uFIbLOy1nNaAFBITORNneL3Qcn46H40YdqbvyCPbc3C59N9rY4a42IvQfXbS9k5YjJU
         lP0Aaz8sdqL9hBVBsakxI/xgNG9sYQO0q+t0iNDhXqIjDD3Wpk+WpVjB2/3VeI823FjC
         NiGE30Krk7uVFTPgOXM96z9jsCNYrPOYA6Dq3CAt+2mcvIVU/CPg4g7VhtCyOd1domlx
         OOXy0g/HeGHgeXnlNfKXK1l9atv/xIfkEoDmlmjtcArnZYlPSjfI1CWs1I2t7Et8mqA2
         HnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431214; x=1720036014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFQCYxkTWkVTkeG4pmT0NAA774VOsw4t919VmGwibAQ=;
        b=Zm9kVIITPpM6AgdQHAN1MlYqRvbBjFMvfwsnwv6tuH19Ak//1Qhxw8ZfNIuMicTze5
         cnsjjkcLR7nOh65LwGqEebtmyN0cAUPdDkOL/rdYSqvdSUL/fUAGfn8IPVUXau3lsbNx
         H9+7/zyIIMKISQ6OHnARcOpJBf3kdHzVkYpwdOxxafM3wGd5vAa+wnSynvSbu6Ev9deV
         pehbe7t2+iqgvVU/sxns7A44vtwudGSHrytT2qXWxR4T4b3lnb1H/R3wQq1ZCF0xOgr6
         NyfajxJSWVUS5ZlnKdxU7zGClopzv+ulBhYcKR0V1dpDoM0zGu4BwbwDOQehbxkuC3e0
         r9IA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GfZ8AqLfE9NKbkExMnLK7R/zzHZv2yfGYJiSI02cmCewQ874v4wonBVemuV9XUOASaQoQPK6kjaODDrxSZSfIUX0GHHBYqBH
X-Gm-Message-State: AOJu0YxA98S3kgQAOcwgPuJm2qxGm1z/2ZmMwLTNT+ikAI36P+xh4Trw
	DBp1tzMU0eUrClW8Q5UmG9uve9Sc+Y5gida8erwqxSPHQxAlyHaTs10wVYEAeyw=
X-Google-Smtp-Source: AGHT+IEsqyry2dKkQyVU+KqpfX7PK/KlBwJ1aJo473T1bK1fv3LN794lmHlDZiHq/jj1q1c90ArWNA==
X-Received: by 2002:a05:6a00:3e24:b0:706:7d86:487f with SMTP id d2e1a72fcca58-7067d864f28mr10467895b3a.1.1719431213873;
        Wed, 26 Jun 2024 12:46:53 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7069d65dfc7sm3287078b3a.133.2024.06.26.12.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:46:53 -0700 (PDT)
Message-ID: <58cc9e3a-bb69-4205-9f11-d262f811ea9a@kernel.dk>
Date: Wed, 26 Jun 2024 13:46:50 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] block: add support for notifications
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
References: <cover.1719368448.git.daniel@makrotopia.org>
 <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/24 8:51 PM, Daniel Golle wrote:
> +static int blk_call_notifier_add(struct device *dev)
> +{
> +	struct blk_device_list *new_blkdev;
> +
> +	new_blkdev = kmalloc(sizeof(*new_blkdev), GFP_KERNEL);
> +	if (!new_blkdev)
> +		return -ENOMEM;
> +
> +	new_blkdev->dev = dev;
> +	mutex_lock(&blk_notifier_lock);
> +	list_add_tail(&new_blkdev->list, &blk_devices);
> +	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_ADD, dev);
> +	mutex_unlock(&blk_notifier_lock);
> +
> +	return 0;
> +}

Nit: redundant newline.

> +device_initcall(blk_notifications_init);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b2f1362c4681..8d22ba03e3e1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1687,4 +1687,12 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
>  
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
> +
> +#ifdef CONFIG_BLOCK_NOTIFIERS

#if defined(CONFIG_BLOCK_NOTIFIERS)

> +#define BLK_DEVICE_ADD		1
> +#define BLK_DEVICE_REMOVE	2
> +void blk_register_notify(struct notifier_block *nb);
> +void blk_unregister_notify(struct notifier_block *nb);
> +#endif

Surely these helpers should have a !CONFIG_BLOCK_NOTIFIERS failure case
definition? Either that, or dummies. As it stands, any caller would need
to check if it's enabled or not.

-- 
Jens Axboe

