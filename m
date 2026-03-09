Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E013D75B7
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068826; cv=pass; b=tVQRMyVjDlAn6Q4Y9RRyY6i8i+z4FNLIvNAzbKII57Fd0798q44Y1/MkS/A6qluVVnpgfeE3NrBmXfFauR3WSy3EmoLZVHEOrpCKhHmHQ0WpkQ88zYZOumqxKYAMVzQmROmeKgoI7jogTRT1mMV2rxSqGVzpsebvYieZMa/k4Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068826; c=relaxed/simple;
	bh=qFM6CNejT4/x2PsTY7g3d31KNjCWnVMll1bNFh52yVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksX5i7gctv404eX0SnNA2AgNOhLFGOEyb/KglCgAC5CaD9RtJ7jBwIeQENA0XRtC2UkrrhwFVL6GaFplwxaNDl2LtJqa3sp+/WMSzluMXTpf3y3hEeKSvRyeCzkAdR3ZIXKnOtxGx+PHTykWDkkBRlNHd2xScDRX8FS3GisAO0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EW7GAu0g; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EW7GAu0g"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so3457976e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068823; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3kqAePNHj18D1jauNE0IrjJ71R3sBd6j0gUpPAjIaT/Hq+s3MDb0rwj1RyPVSWZqj
         9ttdHMsJpq1185TyXRr81eqrUAGK0bg1T4MzWDBJtmTnBNOMmcHyEnV9hlPcSqQBzV+b
         I4mjRbjkvNVDcjmDxvaFy2me7u/U3h8wPrDYBNl9k2UtVjeQKngWvkubjfbdCkswy8VQ
         oHQEWvdJi7nS0rDJT7hZA2dZZvb4fnWBexniR8slsyjvScENGMCswp6uPjpi/E9rvLTA
         ho0BkvC6vxJRwZbEn2lsbZXbwHckuSO55STa/3NllSM9fRASseXLQM0jmodT6KSAiRU+
         oiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=537JRIZC/LSxbuaPx2Afp8DiB6T1dTDgqpkX2JrxqlU=;
        fh=0mKH/IbysHiooRlxgS+lLsiZ+Xg4+451JTcsDrHySnc=;
        b=lLna3l5tgb/+s5A5FjIm/ZlJQEnwE6Fu7QUhrx/TH/bkyJ0+AcyV0X7qW1ndZvsxsN
         F3EEoxkgSQ85yw/e6xMLwrzgc68XefdL5C8WZJLjsxHobI55hBqqGNHzxlBNJjvYZgtg
         jrCogUHDRBS2izvrCgY5EuOTQQzbXSS+sNljf939TgBUYTStP3QCPnf9nenNi3eHcbJM
         ARMogIfU0A8acQtd3ZQFVFI57DpWGcPjwcFJsIu3GgYzVmfpFjJhopuBFFEP7t3jq8pB
         gyrVxTRh/fcItEqy77S9C1F5jdVinCwxpPvSqt34oQnjeY/gRp2ttJpTEMbiszYcBV2F
         8rqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068823; x=1773673623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=537JRIZC/LSxbuaPx2Afp8DiB6T1dTDgqpkX2JrxqlU=;
        b=EW7GAu0gb8gRnZtPCQzz4ZqYyjyhH3+SJs4WXmlIUz2cW3gEEDUuqcM6MqhYFa9Q7S
         tMpGvQKfb7JxKlB6YolG2pMXgh8QMFrvO2rGgvcEugBV8UNWkW77p8Eab79UZdDzJBAF
         NB3j5n5aaeh0X1sPfEvIgj/fbhbSWN1q1ehM5VT1KnUOpRvSbfOkQY+QK9p/bPdg3e9o
         tN86gJ1E2mK7wFEXBs9p7Sh1qs3To3+5E5slr8HJa1RqZ8AKxla7OXVsy9i+msGeJUbi
         HGe3V7ApvSTZ5SE4V/Pm63OXSZceRRb6RoGQov8724D1t5mPpBqO8GCdzjx8UXB7/H07
         Harw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068823; x=1773673623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=537JRIZC/LSxbuaPx2Afp8DiB6T1dTDgqpkX2JrxqlU=;
        b=ZJrqYH4FurFKYxR/PNnjzZWpMiwpQpDMs5n5GiGDZOT+JlLJoVLFgWTWjHKLviJnvR
         CdomLzMsXnHamXYyNAu6S1z+HIXDqwjN/jPRxgnfBk7rPzLy6xPBtXUg7gJs46nqnSQT
         QIQ96Fzxki82e0TxoBfUn/mMGog1pHJJ4f7fB80ZVgQTKG2rnzMi/9/w8/M//auTHShP
         nxysiQDfJjROtGJkENFUYut69yxGb/AsUK8FwOoifUOZd+kVgiM+BbsQl2bNobKtxnrD
         U2yPiiY2DYhzMwr4BGMEB18ZHInOeIN/uuPCJaMXFHtUnN+vOyKMEnBJMGv2wSIBCwBh
         Sfcw==
X-Forwarded-Encrypted: i=1; AJvYcCUARBEKnMQxiKvcB8zb4szRa7/VZxjDQN0lv+qgzZzKrg00ziotBcVaKMfAgorowtkXY1X3lJmZtuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreJUhT1KFo83TGnVI7KZ45CPM49kByxDSDCDOoNTF9AFR03o6
	csjsZcizE5EYOF8v4W7xBWPlV//MwB8mLPUXjMHzEDlEfoAmG9QwFVrCbEhDMSGEZ13FnXytM7A
	rSLoIOm62k/V0S6lUlLvpLkaXKyIFtfjcyGizhSxv0g==
X-Gm-Gg: ATEYQzwawvCKSO9mKxt81W+LCwyHFAcx753bxxPEW9/VybinWs2XVkGShUfZf8kr1Tj
	brAfiF3Uq4a9QDkth6c+ozCU0JaA8Thqq0AqmPw5T2hD891rlkO6AufRd1Qcx4nL6FQF7MQf44k
	zQbGHSHIVAReTdzf52HvUfoPR5SFG9CrjJNK1dTy825akJlaQa7Qy5PzefLq4Om0xUbXstnTcKO
	7M5EYo8femt9Lz1ANCkzhFdGd+fzdXdHr+ukXDZOET7XbZ/MCY9KjNVEPUCXBmdXi0Su/d4qRnK
	XTNYFhvD
X-Received: by 2002:a05:6512:1050:b0:5a1:427d:93cb with SMTP id
 2adb3069b0e04-5a1427d98a9mr2810827e87.3.1773068822670; Mon, 09 Mar 2026
 08:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772529875.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1772529875.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:26 +0100
X-Gm-Features: AaiRm500LV8TdcWOE41CkNJVMFJZsV23MQAFkPUmS9M5shGF6D8S5Byz54gpLEA
Message-ID: <CAPDyKFqi_p0YDDebvjhAeC8fiq0KidE_pmbvBcvGDiUEStWvrA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: Add Loongson-2K0300 SD/SDIO/eMMC controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 at 12:27, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> The patchset describes two MMC controllers of the Loongson-2K0300 SoC,
> one providing an eMMC interface and the other exporting an SD/SDIO
> interface.
>
> Its hardware design is similar to that of the Loongson-2K2000, but it
> suffers from hardware defects such as missing CMD48 interrupts.
>
> Thanks.
> Binbin
>
> Binbin Zhou (3):
>   dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for
>     Loongson-2K0300
>   mmc: loongson2: Gathering all SoCs private data together
>   mmc: loongson2: Add Loongson-2K0300 SD/SDIO/eMMC controller driver
>
>  .../bindings/mmc/loongson,ls2k0500-mmc.yaml   |  1 +
>  drivers/mmc/host/loongson2-mmc.c              | 59 ++++++++++++++-----
>  2 files changed, 44 insertions(+), 16 deletions(-)
>
>
> base-commit: 6a4a4c1cc0012590b8bebf6c95d51687d39b420c
> --
> 2.52.0
>

The series applied for next, thanks!

Kind regards
Uffe
