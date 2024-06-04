Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D871459E0
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499662; cv=none; b=bt/a9TbosVRzmWHM3HFWHjK3VhvnMGKXgVVqW8BvrEzPeY5Zi+Z6m+wRiVO/7EECklf3stLAufRn9KuyruJhvrtwmDHsZc4nuzepfzjoYR/mGm2KzSFyZfgYVYDSOKqa1f3j5ip7TuT1PBvcD1WidJ+NTq6XseyM6jNREMidJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499662; c=relaxed/simple;
	bh=haMbgaVIsEsyr/UPAVi4Bnxb+AK3DC7n/7prdPRNVm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcHEdC3fDM3s/DjFR+bMC0bU7YZBKbt/v5wphX2gmlQaYxgFVLuWUK6eFtFGhYohu+1vs2OZwwJWMLGXkzH6j8577ZlMlzNxG0P8ulW79UxP7PJBsH0U6pMkqL7GRn7h7RQ1NYx+NivPtzABc0BsXxh+uCXl7IuJxW7M9rI4ZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPjRcIWD; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPjRcIWD"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfa79233c48so3877533276.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2024 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499660; x=1718104460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPnqJm8iFqpoLsOaTzcZDLycrj8bZIRNRvSny5a6E1Q=;
        b=CPjRcIWDImq0Wd0V3gBJthySYXZO0mxqkciAZhCjadmgyGF3uAXfS3DzKbhLI132xI
         xmslIcpN7BUherZvdJKCbItHW18fzRO5lRnCf4P815P+uXi4WTRJKNZSoNA9XuAmRE2T
         kJssEmjkGbctWhPJo25mJ6hRYNuax3yBg99pwkt+tWzlPe9TOMV/4Sr6TXzptpPBQ2C2
         Iomd+HTOgzYpcBDriYXMIy7JQWyoJU3UCEZg9bzayVnnlsNN86BOGZl+l1DKrhAO3Q7L
         ssWRnJy8c9BhCTwReKAbg35vWK6kNaM2aHYjUeRdCkg02RFJVc8Oitj+/p8mctAf1Neu
         l4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499660; x=1718104460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPnqJm8iFqpoLsOaTzcZDLycrj8bZIRNRvSny5a6E1Q=;
        b=T9acIs2kjN7s6PFEU2YQLXhdrgj1AeNMBWs+pJlVL0b6Xrrqp3R0lkvJkYI3Ac8iNg
         zU17FS3jVT9F9k1t/SDWLntMo0Q7vutqGesVRwXPd8LoPo41u1HZU84m/Apk7PSeDPW8
         y/748hfjzjeeEZCF1UYfy4Qso1dAgkFgmxFlx0sIuf9L3yQMk/HOS0lQlwYJ1b2x+d/2
         jgCV15GA3Tv1z8X4McWbe7Cc+mGpITRCwg7+kZhvpjs7U6mkmjNqEznb7DxXu7vXOAkR
         gT9ygQDOcUiP+x/lxuyCRD2w4CqyNEQVate70SDBWJDdmSWHqe5HApFysev8xD8h1Q82
         49Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUlUkvM1HnOIlL3bxKb9DstyO6Atvj60VUEsbbWwsZ9rKY4pbzrJHT/RaJXpzW4FKDDrho6c0ROPtKVfWg/faN23LnCIWWOZ+dW
X-Gm-Message-State: AOJu0YxHLofw/X/b7P+/JR17NBNsFdYwCvVf68pjlOSG+jDx6moV298v
	B5Sgo3PvJVNSg1MRJtx6i07vF1aE8T80ZnD/K6y94n0kesrE2GAyK7Mbxyt6JNwO//jmxAp9OSd
	ZlDBA6FnMJ3VV/EaCnyoSNNYlepyRqCkGaXXGZQ==
X-Google-Smtp-Source: AGHT+IHqiscP8khp5ZULf56iF+jRX5n/wA8/slPcj3pgkTkvRBD2pn5Q/QGyzDKGpr00CwDLyjPhF76bBw/18dRyrXM=
X-Received: by 2002:a25:b310:0:b0:df7:9681:39b9 with SMTP id
 3f1490d57ef6-dfa73be850cmr12727981276.18.1717499660432; Tue, 04 Jun 2024
 04:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717061147.git.andrea.porta@suse.com>
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:44 +0200
Message-ID: <CAPDyKFqtV6-XYfDSLd_2S31zXZc4ayvuVHWOpic7iXNuj0r7YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 12:11, Andrea della Porta <andrea.porta@suse.com> wrote:
>
> Hi,
>
> This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> console through uart.
> Changes to arm64/defconfig are not needed since the actual options work
> as they are.
> This work is heavily based on downstream contributions.
>
> Tested on Tumbleweed substituting the stock kernel with upstream one,
> either chainloading uboot+grub+kernel or directly booting the kernel
> from 1st stage bootloader. Steps to reproduce:
> - prepare an SD card from a Raspberry enabled raw image, mount the first
>   FAT partition.
> - make sure the FAT partition is big enough to contain the kernel,
>   anything bigger than 64Mb is usually enough, depending on your kernel
>   config options.
> - build the kernel and dtbs making sure that the support for your root
>   fs type is compiled as builtin.
> - copy the kernel image in your FAT partition overwriting the older one
>   (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> - make sure you have a cmdline.txt file in FAT partition with the
>   following content:
>   # cat /boot/efi/cmdline.txt
>   root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
>   console=ttyAMA10,115200
> - if you experience random SD issues during boot, try to set
>   initial_turbo=0 in config.txt.
>
>
> Changes in V5:
>
> DTS:
> - axi node merged into soc node
> - redefined the mapping ranges of the soc node to have proper translation,
>   and a narrower address and size cell number for child nodes.Child nodes
>   reg properties adjusted accordingly
> - augemented the comment in 'gio_aon' node
>
> sdhci-brcmstb.c:
> - removed unused 'base_clk_mhz' variable

Patch 1 ->3 from v5 applied for next, thanks!

[...]

Kind regards
Uffe
