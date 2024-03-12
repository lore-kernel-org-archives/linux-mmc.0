Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCA79DDD
	for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246208; cv=none; b=eXcXRFbRf4uDq7tA756aKRWfjKdtIdYX94FiPsb79R7kBZUgpIeL34UigWKfP1OngdvsTRj/Qx6Oqoud+0TV/YGcf22CyAGFuKqHkgohVW3B/Al0e4rx4lz2EaE6/XAgHkp4Q/etxOogwKjwtc+RatbN6xnOPIyN9o1kfusVQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246208; c=relaxed/simple;
	bh=qjZk8e0DXnxZ7D8c82te4o3kYapYLIZySjx9Aa/vAjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8olUgRQea4CnZKh+rUcdqF+9+hiaUUuxyPd4mnqSHFitDU4G5Gf7ouogr6GSgv3PR9o0oemFyqy9DIg5VPloY3D+WptB9Ap2v+U7NwliJjI6rWb6g3o1NRBkuFCfdCbCG4OMpEXrL64WS3C8MQShm1pcy4NOuFDiyS3U+ppTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VezBtpf6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VezBtpf6"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso5008473276.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710246205; x=1710851005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjZk8e0DXnxZ7D8c82te4o3kYapYLIZySjx9Aa/vAjY=;
        b=VezBtpf6MbzmUquxNus+FxvG+Sd7Fvq4uQ3P1V7bQQtaST3ZQIW8DxiGN8MUa3diYW
         XDGo9QUzoAfXoVqtQpoTp1/zd0eioavkEjPS+4/nV44rt9MnHWTFJ/bpUAYPXmXvjApn
         Qe6tKe8hc7ZwoWbWJLm6touHZ66t6vbNA2f99QQqPQU7+/RQnQ+7fR9Swxr3N5BfNw09
         vTGkn0O3H3pN+3qtEuhtd5XDEVQNC4YVgt/iidMW5X6kAWeDTuqSC2MpigezmZ6m6uQC
         jbzk3rJHAzwYO8ciWdgGTM6YvihpeWlAGleSSvlW7Cid7wf+o0j/EPgIc2mYXHhT0gmM
         BMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710246205; x=1710851005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjZk8e0DXnxZ7D8c82te4o3kYapYLIZySjx9Aa/vAjY=;
        b=uZTRY8E/QcUZ/DHFcgbuhWvjb8udV8Th7sWyjub3DO3dlHEQvYYzlUtANrH5U1RRaF
         dzAleoI+6tw9VBbKD9tBmGBQYYD1ILfE28R0fRFPa3pVFRvMmrwecCUhLitLamDthv/d
         dY3ZfLkGaLJHvy7KwM7hSuoEK3G9JXYohKPcwvs4oBwfZqWIBg0oaE+SyKVK8NcKOe13
         SUCAJJdQKt7oDWmveKoOGXOuBsc8PNC5Z5efu35fvDnOSeedVGvXVWD3q/4x+MipjnlQ
         /IqT1+uazrwVybkphX1e34rgz6ULjeZuWFvrggNV4xcQymrSfkT1EImH+qgIokSKzAKc
         i2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXm9juTJu3se9fb+q+PU3/dl42pQ77HcktryVKl8KUzwtm4YSF12NoQqfNq5Gj67nlFW7f5DvqR3zklW6TkglzROdQVVptJn749
X-Gm-Message-State: AOJu0YwdKwEtZKIUAfUUn25VtQDy8uqpt1hRT1OCjmzQr+SRh2w/p872
	nyJLMdxNhRF7OKtXp0rdGRG6/TdXvZBUF/VIHKpo9IAmVCeYad9eJy2yqDixx1G3V6bo1AuK8iw
	EkU93w1uoa2ZTX7+A/53V4j1UseRAO3VQZPu0Kg==
X-Google-Smtp-Source: AGHT+IF2gNuqdneyeOK7heTOwlxyVd7ti+X+/+UyoI+K3w0WE6smlBrmYkyIybU+Ay4l6wMJhYPiybNO3wdfWJeM7CY=
X-Received: by 2002:a25:6ed7:0:b0:dcb:38d3:3c6a with SMTP id
 j206-20020a256ed7000000b00dcb38d33c6amr1438229ybc.46.1710246205535; Tue, 12
 Mar 2024 05:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709667858.git.daniel@makrotopia.org>
In-Reply-To: <cover.1709667858.git.daniel@makrotopia.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Mar 2024 13:22:49 +0100
Message-ID: <CAPDyKFpQfue5Fi0fFSnqHNg2ytCxAYfORVP_Y86ucz2k5HRuDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] nvmem: add block device NVMEM provider
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Christian Brauner <brauner@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.de>, 
	Christian Loehle <CLoehle@hyperstone.com>, Avri Altman <avri.altman@wdc.com>, 
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
	Diping Zhang <diping.zhang@gl-inet.com>, Jianhui Zhao <zhaojh329@gmail.com>, 
	Jieying Zeng <jieying.zeng@gl-inet.com>, Chad Monroe <chad.monroe@adtran.com>, 
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 21:23, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On embedded devices using an eMMC it is common that one or more (hw/sw)
> partitions on the eMMC are used to store MAC addresses and Wi-Fi
> calibration EEPROM data.
>
> Implement an NVMEM provider backed by block devices as typically the
> NVMEM framework is used to have kernel drivers read and use binary data
> from EEPROMs, efuses, flash memory (MTD), ...
>
> In order to be able to reference hardware partitions on an eMMC, add code
> to bind each hardware partition to a specific firmware subnode.
>
> This series is meant to open the discussion on how exactly the device
> tree schema for block devices and partitions may look like, and even
> if using the block layer to back the NVMEM device is at all the way to
> go -- to me it seemed to be a good solution because it will be reuable
> e.g. for (normal, software GPT or MBR) partitions of an NVMe SSD.
>
> This series has previously been submitted on July 19th 2023[1] and most of
> the basic idea did not change since.
>
> However, the recent introduction of bdev_file_open_by_dev() allow to
> get rid of most use of block layer internals which supposedly was the
> main objection raised by Christoph Hellwig back then.
>
> Most of the other comments received for in the first RFC have also
> been addressed, however, what remains is the use of class_interface
> (lacking an alternative way to get notifications about addition or
> removal of block devices from the system). As this has been criticized
> in the past I'm specifically interested in suggestions on how to solve
> this in another way -- ideally without having to implement a whole new
> way for in-kernel notifications of appearing or disappearing block
> devices...
>
> And, in a way just like in case of MTD and UBI, I believe acting as an
> NVMEM provider *is* a functionality which belongs to the block layer
> itself and, other than e.g. filesystems, is inconvenient to implement
> elsewhere.

I don't object to the above, however to keep things scalable at the
block device driver level, such as the MMC subsystem, I think we
should avoid having *any* knowledge about the binary format at these
kinds of lower levels.

Even if most of the NVMEM format is managed elsewhere, the support for
NVMEM partitions seems to be dealt with from the MMC subsystem too.
Why can't NVMEM partitions be managed the usual way via the MBR/GPT?

[...]

Kind regards
Uffe
