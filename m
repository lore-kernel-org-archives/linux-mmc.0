Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541403CEBAC
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025279; cv=none; b=gsDAPBDmp1vQ/TYScM0uGHLgJ127DULf+303DPU1RRTNPjAf98DX0981LqhLnbkH30BiceFkK1Ff2i5vjD8qJpzBjXL/QSykFi7p4zdOQUQ75QtdrDXmmtf+Dz0MkspYoRasfcTZN2m4emX0dLjSfb2wT5DasP9yBHrfR9Fm0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025279; c=relaxed/simple;
	bh=W1GOM04l1mi8I+C4Bl31veWLfmy/KBGCNzBCVbPDDHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxPw3HRORjdX3fXzoU+Pi1fIEzf+JWe3CHhjWruWJy97+bDI3WacqpXAu7gJ72L8viZRf9nTkCbOtrboW0MTTOobCIhsnqQKUB9SzObtd6J3IX0jD72MzB59oxL/tafCCKH9twHvQ2oOZuFchtvYLFCTiZ03324OQH8ZwTF5ChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nf2/3JKo; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf2/3JKo"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79800183233so27932207b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025277; x=1774630077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEsLt4UseGRWoaPSn0cyl2B9W2M3YJu0Bn9/HhQjwcI=;
        b=Nf2/3JKoS63kewGMfsEdkppXSwltn/aktyzkG7LNLjPQb8XToOoM+Acauxzwwt8GHN
         k2UcyAa2YqrkR2q/XuL8D3Ki2B5jIUg3rg8nf9/iMIfe/MquspAotEDaIesLmpFv0QXa
         oBIRPW4EEUr7a6PUelO5dt2VhzfPS3GeAYP4VrLJVJV+gEq1bNnP9PLkh+5SdMk9nt9H
         sVuTyjRGRyD597tYD/VdRRZjLiik9z22xErpfSRl6iehIGRJNfrhZasDE7F7E1iaLyW2
         iwUoTPCVqfUQoIlKCo4ciO6jeWDZQvojQx7YgsNMP/TVNTmF15il/hiIwqN3gXTZcf0i
         NSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025277; x=1774630077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEsLt4UseGRWoaPSn0cyl2B9W2M3YJu0Bn9/HhQjwcI=;
        b=W/wQB6UWGJhrrU0tkaqWbKdDMH7HeU9G9ZPeUTvEGinJ2i4MjjU118YJgbWOYmu4Tf
         E2zo6mbDl7f94Lw2FMznL00Hp/6MHz4J2T9Y2cZEM9RwulbkPCtmrXKLCmwT6QXYRjMO
         wVdNx2tWhYVjN/mVwOuej+EwNSl3cAMuecUz/x5v5WiHkVuFWApsd5Sr/Ry/TB/PQsbF
         pWmvUkBJk8yJbHyPBOkHoj/CEJ/4xzyZZRY/poL5rrFwsRLIU4s5mMQgCGmGesg2q0un
         vc9HBkLbzvlSrYc+hAvePjyqjmB0xbkAl995k9DObc+AGtmE/NBdk2Iyl3SVGnkowmrZ
         09vA==
X-Forwarded-Encrypted: i=1; AJvYcCVJVypCIPvY6cPVZwIxk2VdRTWOm/Mh/P//vPU8z9K4TGBtvTzLpZLP7u29kkd69kRQlkauQcMj1CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmZJk5ZSMDqfMAo4pvpbT/tauaKEwnL6qF+qkyLylAj3hQQTb
	M4E1IH/CX6PvWN4vbKXcmwcZ8HTEIgB0MOor+FK3o1Rszmb7BFLe31gu
X-Gm-Gg: ATEYQzx1xrv16IwsTGK7qxI4ev0bHGNji1n/SicopUqWDCMJ9EGmrVHgGIdDfPxJdgW
	fS5hfgn2rkg2yeUqotXVi9agGgrnPPxzCtZ5KarLZqHJDYMmc+08AraNtXi0ZmM8ejBuMyIAdx6
	SYJH42VmKg12ax8tktblJOhoqpFIS8+tOpQzXVX8TH2W23juHRkepZlMclip9hma1AV7G4857qO
	Hbd2fa5X1g0nM2zpoFjDYnE2zGd1sPOIXWjeMt0ulbfyeJsaIFwWOw8wN1/hqb4abZBFo8NCmO/
	MEL3NBbgkaT66/8/6/IKxBrgwn5Hb+1IeaP7CIasfZctrvtEZhSCmuYL5K5iXPasiW2pZ9oUIOR
	tn/4/pXGq+27UrlHgHzx7JMOpioFLH6HiSUZfPIxRrDpRTlEYs1Hs8sUJGvZqxIxyuLguFPz6xX
	tNCfVWYeob0sChAr2rZmsUKRyMcORwFidwPjc26tY=
X-Received: by 2002:a05:690c:91:b0:794:c02e:f617 with SMTP id 00721157ae682-79a81a9018emr77614877b3.12.1774025277259;
        Fri, 20 Mar 2026 09:47:57 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a9057b4ecsm18839507b3.35.2026.03.20.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:47:56 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	andriy.shevchenko@intel.com
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Fri, 20 Mar 2026 11:47:53 -0500
Message-ID: <20260320164753.536-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
References: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Mar 20, 2026 at 8:27 AM Adrian Hunter wrote:
> These changes seem more like they work around the problem rather
> than fix the problem, but you say it worked OK in v4.14? I see also
> mention of v4.9 in patch 1? When it was working, was it using the ACPI
> driver or the PCI driver?

You are right that this series is a workaround for a firmware-specific
problem rather than a generic root-cause fix.

My confirmed working baseline is v4.9, and on that kernel the
controller was owned by sdhci-pci, not sdhci-acpi. The INT33BB:00
ACPI node was present in firmware but did not prevent the PCI path
from working. I should have been more precise in the cover letter.
What I can state from testing is:

  - v4.9: slot works via sdhci-pci
  - current kernels: slot is unusable
  - current kernels with this series applied: slot works again via sdhci-pci

> In patch 3, you say the SDHCI ACPI driver repeatedly defers. Is that
> because it is waiting for the GPIO driver for the Card Detect GPIO?

Yes. On this machine INT33BB:00 defers waiting for the card-detect
GPIO dependency, and that dependency never becomes available. In the
broken state the ACPI path does not successfully probe and the slot
remains unusable. Excluding INT33BB:00 on this DMI match allows
sdhci-pci to own 0000:00:12.0 and restores card detection.

I am not aware of an existing generic ownership-arbitration mechanism
between sdhci-acpi and sdhci-pci for this dual-enumerated firmware
layout, so I chose the narrowest fix available: a DMI-scoped exclusion
on the affected machine only. That approach is consistent with how the
subsystem has handled similar firmware defects elsewhere. sdhci-acpi.c
already carries a maintained quirk table covering the Lenovo Miix 320,
Acer Aspire Switch 10, Lenovo Yoga Tablet 2 Pro, Toshiba Encore 2, and
ASUS T100TA, all firmware defects fixed with DMI scope and accepted
with stable tags. sdhci-pci-core.c follows the same pattern, as
jsl_broken_hs400es() immediately above the new helper demonstrates.

> Note Lenovo N22 seems to date back to 2017. Is it really worth
> spending time on something that old, especially as no one seems
> to have worried about it before?

My argument for upstream is mainly that the quirk is small and
low-risk, and that PCI ID 8086:2296 is part of the wider Braswell SD
controller family rather than unique to this one machine. Although the
Lenovo N22 is an older platform, Braswell systems remain in active
secondary use. The Lenovo IdeaPad 100S-14IBR carries the same
controller and has a documented bug report showing sdhci-pci not
binding on kernel 4.10 after working on 4.8, the same symptom pattern.
The commit documents the failure mode, the correct driver ownership
decision, and the workaround approach in a place where anyone dealing
with a similar Braswell platform can find and reference it.

That said, I defer to your judgment on whether this serves value to
the wider community. I am happy to carry it as a local patch if you
feel it does not belong upstream.
