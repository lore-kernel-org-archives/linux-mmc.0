Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B57346E46
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955724; cv=pass; b=AIsCkZoSgYMDGPY9HSyoKmM0ODzkai1PYDHkKwKKS3/PR77701+8wF8G+srMQUMriG/RkH2RC4/q63yvrDFpMHPutvRER2zJjUu6Gp8VSsRrCPKiF2571dnIPvAwTrMbh3szQLXh8Qyi27c2gHCYvWDGghrtvZPsgOcs7ozCtpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955724; c=relaxed/simple;
	bh=SqM+D38e4npH5Og+8sABl9qdMTXE4ZyoXCT3tfKY62Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpLlWrfagBDdiQ0dcsSaPQFT/KP0uRA4MpC7fr/XOafUJkM5OEK+TJv93Z28nUQdub10z7bCKyScYz0GT4wO6m+7KKkQLhA6bOHGyTiCdnOh4VAlWy+nRjn0Tg638M8ZuFB+nzXMoWNWPyzELJfzltUH8F/dk1y3bBFTfiUZa+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ukk/v8qe; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ukk/v8qe"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dea72099eso6847952e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955721; cv=none;
        d=google.com; s=arc-20240605;
        b=hzMnbq/6Y30XmjzLXBrNodKLANwPm1+YGrlCe6tK0khXG9a/30AmTI4lk33rQtwi6g
         fQBtcVtcBaTh9B5NIUcNCdUt4rx1sOQiutYLO0Xkb5awxFasFK1Nf0QHF0hAiaP1tjI0
         EwjmwBhoF1axbl6RxC21M2oI6wFJUVuCE11+DX7bZaDsbROS40xlnpaBihDO2mk94oOA
         hQLUpb/zkE2Vt9J15BH3uMdFsu6KRskmiWwr2e4+bL1oV0swsz2O9jWhUZtTQ1g0jQPw
         YEJAwmyXacqPoUp58qCIrC0eWjyysDqcJVSaOo/a0ss+ByKxuWeHS0yaOfhM/FIJy3/o
         dHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VC5HIEfRWsJIBaPvsIz30IBQIR/uRPijKElw8OaepUU=;
        fh=F09gXjuBfAinjRGqtSdI7PBlpEv7aCugp05ZKB1d0tc=;
        b=FAeaTLD6xU7tuxEYt10ESlGmnSc/zBQxJlV2G4wCgH9zxi11CnslK9E20ZGHC/4Mgr
         elKKioEAXO+7+DG4+fKm6LCy5K0bS3ONuRa0dlLYLc2XZGAsveTsfijkmJfq3T4p9CLN
         Af43wPMqXY9lMjL9/HY47pszfIrlZV/dMrad1gNCcSud11Bohn2OmUbIq3G3TMC0gG2R
         kBXZcFJxE781s3LrAhhGwKkBh3TVJgm4aF7q82bA8gL3fKzFiac+vqOt4oor+jn2pT92
         hBbfBzMXtqt+3fgTCSkQZWu4j7o6DwE9on4YL85UC7oy6pDiA2DfEOLorO3//HKC1lpk
         xzIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955721; x=1775560521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC5HIEfRWsJIBaPvsIz30IBQIR/uRPijKElw8OaepUU=;
        b=Ukk/v8qex6djOkZopnx10JSy3D9Hz9OaxwpXyunnIyUhravd0eZ2sKgralwoNemp37
         g0HCY1N9Vl4Gzghw8gZVNrcE5Uc13DSPgXYpVX2xpe3jFPHXdG5rx/S2xwaAIArlbk98
         yKG+0fW+1iX9iv9wP0zUSfrkzKLd2gC8C91Ouq1YdDNKfBpQrbo1Ud6jdcrp5OANBFKC
         FnuIEhL7Hf6rWUXSkCaOHKiDAo8xHaqYyq3iRit2dJ5dRV2+nE3XW8uEZHwlDHdNDu1N
         prO5I51NYdTNnhaqmKCl5jcuuP9LaHRZsgw46/B/RALwWuvOsy6xyXRJQMvHY86qhbg5
         tt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955721; x=1775560521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC5HIEfRWsJIBaPvsIz30IBQIR/uRPijKElw8OaepUU=;
        b=Haxv6dFlaOJePJycBZT5M6YXUOIAqY5cwg6HWCu8AQJTWW3n3IsX736j+GRBdqBtc+
         in0vTFZEtcLbpPOAU4mjO/qjU4apFBGTw1tBIlgCegYxUuznbNtcn0hpiXZtSJycVtvu
         tX6t1VYoB07TjQjqC3ViabIcT/7dCYcmSxF+QtPCbShg5kpmcHjy0+vXt2JkQ1W5CZm0
         CYOAr3eacfSm5oie0U46oNF6zC1QkcAyADOeAQJCxSc8hNksZZ9S246tOMwlPpv6eIJz
         cBT0lF/jRG4VTSJFQsNY8VHSSBNop4P6jo3llP8ttf5LYl1lfJwyMhUTzh+Y7d74KmNK
         OWBw==
X-Gm-Message-State: AOJu0Yz9cF/9HruuLeCOqbQk5OzVsHQiQN9WEGoldueNGX0i55NSnQXO
	wBp846MI58o9zNVzgJcgHLrpehLoEvphRb4BrfYmeOdkNmOHzmKvltmYilsFiU55/d5NNoIAUJZ
	VDblHRnHmRNR13EJZZBr8OLqIMfbSpwpytu+Vk6HqIQ==
X-Gm-Gg: ATEYQzze1icg4Q6cJgdVIBlRwakVFOB9gCvL+I7gOQhoW06HLUffBC1Y2JJWRk4wYi3
	T72Fn4dEwNm/D8EyEinIeS5YxHFr02gIvP5LOTQfkR11GydOc1sw76XjVvWj3X9AE0QKXXvfbUa
	19zzs9zKFVW7cnOdNswhcAE1uUzd0lRqKlhbD4syNZ1tFInLKP3o+RH8D5NplDVrIsHL2FdokEy
	gqhiXXsqDqNPTU4iF6c2O9hxuC3DWRqqTGmxU+7sl7KvTijj5Tf5gDoBlGCWWL1RA9GJg/R1cz5
	l03v9wxH
X-Received: by 2002:a05:6512:3c9c:b0:5a2:bb0f:e28b with SMTP id
 2adb3069b0e04-5a2bb0fe473mr1138850e87.18.1774955720754; Tue, 31 Mar 2026
 04:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:14:43 +0200
X-Gm-Features: AQROBzDcLbHZKCieP6hV8Yki5mmbBYGS-BOw2hgq7rtYtgoBZ6c0E94jqcIcDmY
Message-ID: <CAPDyKFoHjHD3idh+07u+cQ1RY=m4iAURp8uvBWWaBGF0ugnQKA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Extend MQRQ_XFER_SINGLE_BLOCK to Support Multi-Block
 Read Failures
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Mar 2026 at 05:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> Background and patchset description:
> Currently, the MMC driver handles multi-block read/write failures through
> two separate mechanisms:
> 1.  For read failures, the native retry mechanism is triggered internally
>     within the MMC core.
> 2.  For write failures, the corresponding request is re-queued with the
>     MQRQ_XFER_SINGLE_BLOCK flag for single-block recovery. This separation
>     creates inconsistency in error handling.
>
> To improve code uniformity and reliability, this patch series consolidates
> both read and write failure paths into a unified recovery model by enabling
> the use of MQRQ_XFER_SINGLE_BLOCK for handling multi-block read failures as
> well. Patch 1-3 are small improvement while reading the code. Patch 4
> implements the conversion of multi-block read failures to MQRQ_XFER_SINGLE_BLOCK
> mode.
>
> Testing Details:
> 1. Platforms: Tested on RK3576 with both CQE and non-CQE modes.
> 2. Methodology:
> - Background dd test continuously reading from eMMC.
> - Physically interrupting the eMMC data line during tests to simulate CRC errors.
>
> Testing Result:
> On CEQ mode, CRC error triggered on slot 4 (blkaddr 734208). It successfully
> transitioned to single-block retries using tags 25, 27, 24, 25, 26, etc.
> (see logs below):
> mmc0: starting CQE transfer for tag 4 blkaddr 734208
> mmc0: CQE transfer done tag 9
> mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
> mmc0: 524288 bytes transferred: 0
> mmc0: starting CQE transfer for tag 5 blkaddr 735232
> mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
> mmc0: running CQE recovery
> mmc0: starting CMD12 arg 00000000 flags 00000019
> mmc0: req failed (CMD12): -110, retrying...
> mmc0: req failed (CMD12): -110, retrying...
> mmc0: req failed (CMD12): -110, retrying...
> mmc0: req done (CMD12): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: req done (CMD13): 0: 00400900 00000000 00000000 00000000
> mmc0: starting CMD48 arg 00000001 flags 00000019
> mmc0: req done (CMD48): 0: 00000900 00000000 00000000 00000000
> mmc0: CQE transfer done tag 4
> mmc0: 0 bytes transferred: -84
> mmc0: CQE transfer done tag 5
> mmc0: 0 bytes transferred: 0
> mmc0: starting CQE transfer for tag 25 blkaddr 734208
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: starting CQE transfer for tag 26 blkaddr 735232
> mmc0: CQE transfer done tag 25
> mmc0: 512 bytes transferred: 0
> mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
> mmc0: starting CQE transfer for tag 27 blkaddr 734209
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CQE transfer done tag 26
> mmc0: 524288 bytes transferred: 0
> mmc0: CQE transfer done tag 27
> mmc0: 512 bytes transferred: 0
> mmc0: starting CQE transfer for tag 24 blkaddr 734210
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CQE transfer done tag 24
> mmc0: 512 bytes transferred: 0
> mmc0: starting CQE transfer for tag 25 blkaddr 734211
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CQE transfer done tag 25
> mmc0: 512 bytes transferred: 0
> mmc0: starting CQE transfer for tag 26 blkaddr 734212
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CQE transfer done tag 26
> mmc0: 512 bytes transferred: 0
>
> On non-CQE mode, a CRC error occurs during a multi-block read
> operation (CMD18) targeting sector 0x0002d000. Subsequently,
> mmc core initiates a single-block retry using CMD17, starting
> from the same sector 0x0002d000(see logs below):
> mmc0: starting CMD18 arg 0002d000 flags 000000b5
> mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CMD12 arg 00000000 flags 00000095
> mmc0: req done : 0: 00000000 00000000 00000000 00000000
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0: 0 bytes transferred: -84
> mmc0: (CMD12): 0: 00000b00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: <starting CMD23 arg 00000400 flags 00000015>
> mmc0: starting CMD18 arg 0002d400 flags 000000b5
> mmc0: blksz 512 blocks 1024 flags 00000200 tsac 150 ms nsac 1000
> mmc0: CMD12 arg 00000000 flags 00000095
> mmc0: req done : 0: 00000000 00000000 00000000 00000000
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0: 524288 bytes transferred: 0
> mmc0: (CMD12): 0: 00000000 00000000 00000000 00000000
> mmc0: starting CMD17 arg 0002d000 flags 000000b5
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> mmc0: 512 bytes transferred: 0
> mmc0: starting CMD17 arg 0002d001 flags 000000b5
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> mmc0: 512 bytes transferred: 0
> mmc0: starting CMD17 arg 0002d002 flags 000000b5
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> mmc0: 512 bytes transferred: 0
> mmc0: starting CMD17 arg 0002d003 flags 000000b5
> mmc0: blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
> mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
> mmc0: 512 bytes transferred: 0
>
>
>
> Shawn Lin (4):
>   mmc: core: Replace the hard-coded shift value 9 with SECTOR_SHIFT
>   mmc: block: Convert to use DEFINE_SIMPLE_DEV_PM_OPS()
>   mmc: mmc_test: Replace hard-coded values with macros and consolidate
>     test parameters
>   mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write
>     recovery
>
>  drivers/mmc/core/block.c    | 82 ++++----------------------------------------
>  drivers/mmc/core/core.c     |  3 +-
>  drivers/mmc/core/mmc_test.c | 83 ++++++++++++++++++++-------------------------
>  3 files changed, 45 insertions(+), 123 deletions(-)

Nice!

>
> --
> 2.7.4
>

It looks like you could have split this series into separate
standalone changes, but let's proceed this time.

The series applied for next, thanks!

Kind regards
Uffe
