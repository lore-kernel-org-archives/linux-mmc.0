Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8831DFCF
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jan 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493907; cv=none; b=HSW7zrXUgu2O4AqiecbWbS+Dh9Elo873j7/EQkZkX9b8lvuxWSKWkU8X2VITuT6QHXM6Ea38JfZAHnb+SppNWqU8ObqPsaK9SHgKsSIQpmwikl69SZdWzaX17ytS+QcWR/kZTT+IqKy3ktRGxVMN0Rf61CTHjxtUSv2BzFtTTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493907; c=relaxed/simple;
	bh=ozlp9MYLiFG0H/z5XT4qmI2n0HW8WEbtbc8XCfDnuXY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=Da4qzHyckDh7g6GoFoMCdkYxFkyrk0Ns8w82QAJO/zw3nEIEW23O+CIL/GVmDLeSNw1sZbk0X65/dV1b0jNAtUk3tYdUgYkK77sejgn0Xb0x38xaD2nWalA2kaQaEBuRay6TeOIcBzmihJzGjHyoLP3/3EXdcDvlMEdGhJy5tD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFxdxXfX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFxdxXfX"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc226bad48cso1457533276.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jan 2024 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705493905; x=1706098705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cl4Kd9OohLvkHDSeBNrFT+VNQtt1JqKCJVjVDZI4sS4=;
        b=EFxdxXfXtJlpT49DhZfUt1yiLpSv7r2EtlC0X2tJDQWnOpZDOXu58wQREXD8Sru9U1
         NRBr124DjV491itHgOXLklxu7QgiTju2AxMwjpAuBSejwn6ZGophrjg7p1/AKuPBALcc
         0wY+HISwoxcQgGn0V43ykNIGlI4AFBwhIdAvOW3OoqUkhpHVJXQreOC5VDu+w30oP0oS
         8aEaA0pLE6sBxiKv05TyvoOtByx9xLLKAEXRmJvsVR+k5edmeum3aHyj45T7ZrJhCPP5
         ebRrdpoPhgvEF2z0VvrmP0ALtzGg6x1eG1tVxpsqyHqgKl2OEzx75RmKZ7aYZaxm5+Pr
         S6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705493905; x=1706098705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl4Kd9OohLvkHDSeBNrFT+VNQtt1JqKCJVjVDZI4sS4=;
        b=sI6p0dyYCZmgm79Eaj26WMh5WhuuSrJwYBfd9tRBg7XSMAETh0KS5FoX6fBGGpyBHK
         IlNv9W4WTDu2fAzS//OqqEvoHFRXpvoLBw3fX3i7R4XWnCOzk2fys1EBeo7aTx+Bkeen
         9ERxZ3Izrw59KBzi2Jgz9DNrVeVFV7h7cRL+d7JXJLNGvOhgKv6w//a6QGCzmfo9WLS9
         IpaibAZB52RlnQpNk9Qcv5EMzlPK0+YGXjsfFxqECLW81cfWf0rUZeRwdJLz0DIm0pCu
         WQDzURry8+o5bycj+NHj1LhEtk3F2GqfYsIuOvOvKhynzmc++MQ0rx6bnKAMQMSbAjX7
         IsNw==
X-Gm-Message-State: AOJu0YxEdF1waqDTFZGAYdmBEXJo9qc7M9fYXhJQ/Ume5hrsMuWZXV8Q
	3xzG3AbD0n7TzKtylTglCtWrj0M7E+UvhpGG0APucK6AC5sQHA==
X-Google-Smtp-Source: AGHT+IHolaOGc5Eoev8VSekLK7+jZgqQCZR6qyRV+O0v5uDqHf5zAT9wzqYb+SJsEXCjVVJ3+J68Gd7vCTbRVK/EO60=
X-Received: by 2002:a25:ac57:0:b0:dc2:48af:bf05 with SMTP id
 r23-20020a25ac57000000b00dc248afbf05mr69881ybd.63.1705493904829; Wed, 17 Jan
 2024 04:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
In-Reply-To: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Jan 2024 13:17:49 +0100
Message-ID: <CAPDyKFqsRounzo1Ns0dDdCS9Qu0doq82ivYwEUNWgOiMtDS0Xg@mail.gmail.com>
Subject: Re: Regression in sdhci-pci-o2micro.c
To: Brent Roman <brent@mbari.org>, Chevron Li <chevron.li@bayhubtech.com>, 
	fred <fred.ai@bayhubtech.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

+ Fred, Chevron Li, Adrian

On Tue, 16 Jan 2024 at 23:18, Brent Roman <brent@mbari.org> wrote:
>
> Hi,
>
> I have an Intel Hades Canyon NUC (NUC8i7HVK)
> whose O2 Micro based SD-Card reader is no longer identified when its
> Linux kernel is updated past 5.12
>
> I "fixed" this by reverting a change from 5/9/21  (git
> efc58a96adcd29cc37487a60582d9d08b34f6640)
> that inserted proper error checking after all the PCI config space reads
> in the device probe.
> This would be code removed enclosed in #if 0 below:
>
>      case PCI_DEVICE_ID_O2_SEABIRD0:
>      case PCI_DEVICE_ID_O2_SEABIRD1:
>          /* UnLock WP */
>          ret = pci_read_config_byte(chip->pdev,
>                  O2_SD_LOCK_WP, &scratch);
>          if (ret)
>              return ret;
>
>          scratch &= 0x7f;
>          pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>
>          ret = pci_read_config_dword(chip->pdev,
>                          O2_SD_PLL_SETTING, &scratch_32);
> #if 0
>          if (ret)
>              return ret;
> #endif
>
>          if ((scratch_32 & 0xff000000) == 0x01000000) {
>              scratch_32 &= 0x0000FFFF;
>              scratch_32 |= 0x1F340000;
>
>              pci_write_config_dword(chip->pdev,
>                             O2_SD_PLL_SETTING, scratch_32);
>          } else {
>              scratch_32 &= 0x0000FFFF;
>              scratch_32 |= 0x25100000;
>
>              pci_write_config_dword(chip->pdev,
>                             O2_SD_PLL_SETTING, scratch_32);
>
>              ret = pci_read_config_dword(chip->pdev,
>                              O2_SD_FUNC_REG4,
>                              &scratch_32);
> #if 0
>              if (ret)
>                  return ret;
> #endif
>              scratch_32 |= (1 << 22);
>              pci_write_config_dword(chip->pdev,
>                             O2_SD_FUNC_REG4, scratch_32);
>          }
>
> Both those pci_read_config_dword() calls return -EINVAL on my machine.
> The driver had been working earlier precisely because it was ignoring
> these error returns from pci_read_config_dword.
> Have you seen this behavior before on any other hardware?
>
> The SDcard reader identifies as:
> 03:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller
> (rev 01)
> 03:00.0 0805: 1217:8621 (rev 01)
>
> I've been unable to find /any/ information on this chip.
> Do you have any you could share?  A datasheet would be ideal :-)
>
> Also:
> I've always had to operate this driver with debug_quirks2=4 to disable
> ultra high-speed support.
> Is this a known issue?
> Or, could it be a symptom of the failing pci_read_configs curing probe?
>
> Thanks for your attention,

Looks like the offending commit efc58a96adcd ("mmc: sdhci-pci-o2micro:
Add missing checks in sdhci_pci_o2_probe"), may not have been
thoroughly tested. Perhaps a revert is needed.

Let's see if Fred/Chevron Li has some thoughts around this.

Kind regards
Uffe
