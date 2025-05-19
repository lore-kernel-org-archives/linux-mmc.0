Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FFC27466A
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653469; cv=none; b=OGTerv7pJDFsG0EbEuUl2c0kmcphAX6iDYlCAw40kHb2kutbAiS1ycX4I+AyQjg0FPsmrQ3yAQaexYXSw1qAOZRWUFO1Ouo/I1tfUq/guV4oYZjYcV7avKe86OOvdUNQIEzoaEN5FEmYU2p42DwZzOfFEeBPzG48nMyR3r/k8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653469; c=relaxed/simple;
	bh=BBa1p+93rbInkHFD7cu4NFc1HnCPbuyMOY8gIKSTD6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJTUsIKKllDgWTgExYszNawOHyG/nttszBhl9AsV9nLUF/jJMKsJKraq57qWtxrm8Vp1RcGXnL6jqd0w6TkcM6Pdw+HFiiyBQPucCXot5a97tJa+5Cu3CqM7baFyfjcYgFWpooXV3ZZhLn38lbK4Y9moGUc+MmIBKH0uPrh+1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDJ05K+e; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDJ05K+e"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso3517611276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747653465; x=1748258265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ByMrX1Fxu6vn5FGyTRQj4KFvlAc0MJvBBAYMSrSilHY=;
        b=vDJ05K+eaEQ6xuWO5XObaku5f09p9BRwHpCT2+NHMF33dAm4Etu2i+PCAREKXMZTQ9
         kC4MzOyAKmh8Fy6sesZL8foWBx/SJF6a73mattmgM4yMz5dCshX66Mmcy2Md3IljGV2s
         RAkV0jIWXxaVjVcDCSdHxQkOleXGUyXCxnvKNbjEgUqjJ4veEgwyfhjpWWKbbbC9kJUp
         iN3mZQ7o8zQ+8q7hEMBJHJcBgisIie1hYQAVhtvqLL6QhcSK3hqaAx7yEbAKTuP4e7dX
         biL2l4lhE7rbkgfGiO8VsFl9fZoone8LkQCNuGR2TCBtByDJxdsebptkYDxwGO/+5WTD
         5wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747653465; x=1748258265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByMrX1Fxu6vn5FGyTRQj4KFvlAc0MJvBBAYMSrSilHY=;
        b=XPAHEYndaowxS8+UqWgapYObL3C4IsD97tvFCK3v4EFNXoWtcQtrG08DHwPEk7mPjY
         SWEY8qDKI3NKdPey55aevDJSY7xQFxKA7WW1KP7xqHGYFflr1Zs/TSULvZzTz8tazBB1
         25DsXOga1uN9eRSukVQPu17SGhUQ/uAxExB7oq62fRpvRsCtqnBm4OvmwoqYkOQP6kQc
         0vprMZgrNiXH/NgA4aA5egCgPhLvxy+7wkwSNVjZbK5wNpaxqcdi2b5Qurwtw/BVFIRr
         qmyziPbzT3ncrEADMzaJmcVGmmxcXyn2/11XV9fSNnxcr4JHU5+ACmPcpVs3S9LSlu2W
         Vamw==
X-Forwarded-Encrypted: i=1; AJvYcCU5V1sNJDGrE+kLswoSP6eOb0/g8M0yUxfleyyNzZ6QZAJNRHGgtHmDQLQwcC4mVMLls43k2jafhm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjNe/oTDqyXSbO0l6O3sWDxO80nCotktkmjOmjnEkTvjDs9Gd
	bCaMpDYTxF1cInJNtqwVbmQZV6uszzVToZffmNqKY5wMytcLE6SHi0LGqeZp6EqMcy5JUqesm9N
	Io7FVostFHD91MQc3JcxuiaCLPnI3Mn3q6gV4JKlNIg==
X-Gm-Gg: ASbGncuQiq1TozYN6iP+AUKMzNRtNNmq/QD90GBHP4ZFubws22H68Is1xwXn+QJoq6x
	1HqJ/Gzhjp9GgVWUUdxDqv+ixE5FazcqJ/zjCQh/zban7Eq52H5taMRHf6DXIMUGwEJuvbYW7+K
	7NAuOKH/wZ1mPIHgUQ8VDQ1z5OI6u8mRDy6w==
X-Google-Smtp-Source: AGHT+IEKnaIepG8Xu8dXigkseIQg2Elah7K+s02DVYBTys+Y3pqAA6EVTrbsP8cwn+bjFmdEtTTVIsP4u/Z11dsLsQ4=
X-Received: by 2002:a05:6902:2190:b0:e7d:3b61:e24a with SMTP id
 3f1490d57ef6-e7d3b61e544mr2112278276.32.1747653465642; Mon, 19 May 2025
 04:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746581751.git.zhoubinbin@loongson.cn> <704447268706b1b9f25bbe9d15459163d0ac3404.1746581751.git.zhoubinbin@loongson.cn>
In-Reply-To: <704447268706b1b9f25bbe9d15459163d0ac3404.1746581751.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:17:09 +0200
X-Gm-Features: AX0GCFveu0YoTJh4AI6kbpPNJ1GJA5WZq95nOMrbprGfHNrxs7iIBViE2fZiSTI
Message-ID: <CAPDyKFo4n=K5-SeKFpCm-0u4Bbk-E0XqUrx+KSK1yuZa35a7ug@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC
 controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 09:28, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> This patch describes the two MMC controllers of the Loongson-2K2000 SoC,
> one providing an eMMC interface and the other exporting an SD/SDIO
> interface.
>
> Compared to the Loongson-2K1000's MMC controllers, their internals are
> similar, except that we use an internally exclusive DMA engine instead of
> an externally shared APBDMA engine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

[...]

> +
> +static void ls2k2000_mmc_fix_cmd_interrupt(struct loongson2_mmc_host *host,
> +                                          struct mmc_command *cmd)
> +{
> +       int val;
> +
> +       if (cmd->opcode != MMC_WRITE_BLOCK && cmd->opcode != MMC_WRITE_MULTIPLE_BLOCK)
> +               return;
> +
> +       regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS, val,
> +                                (val & LOONGSON2_MMC_FSTS_TXFULL), 0, 500);

Can you please elaborate on what goes on here?

Note that, the mmc core uses a couple of different options to manage
busy detection monitoring on DAT0, for those commands that need it.

*) MMC_CAP_WAIT_WHILE_BUSY - if the host HW and the driver for it
supports IRQ based busy-detection.
*) host_ops->card_busy() callback if the HW can poll the DAT0 manually
for busy-detection.
*) Polling by using CMD13.

[...]

Kind regards
Uffe
