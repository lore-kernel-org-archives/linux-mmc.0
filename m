Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A91C233D;
	Wed, 18 Sep 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671147; cv=none; b=bptHz40G2FJih/t5CcNGhjx9dSzQEvYPAO/H11zicmWH6UeKnIgRn7wIeuanyRZS8D9KcFpWxYZpIGu+tDp/wvN4BfAf3irPMlAc8sDLLMvjCb3z4muwgxuMOgMjvWRarxjAww48K4oGL+UZkB/sDYmt+zz8sJhHfE5to4vactc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671147; c=relaxed/simple;
	bh=mfN2DniJzGyQnvzX5jdac8Ty83Jtdx/9QJzOTBacA1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQCIuYqGwtFm9p/Z6tGlzKZGaklNfH2fG97iOejtGZIrsw3LNHLW2noB+tYl5F3CXNZ7wDwvmSVxDI2NQPaNYLoaKTitF2DH/EVu0EfqaGrB+/RHGeaAxBbFV+VS3uWCO8mbHwJlBzEWMj5WJLDVKQuOHLVvlK5wG5yu05BJTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUciZoU6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUciZoU6"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4585e250f9dso46039861cf.1;
        Wed, 18 Sep 2024 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726671144; x=1727275944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G3UqcqiJStniDz8ouIeMn2j4w8oVsWRLj7dQqF5BGg=;
        b=QUciZoU6CaS7KhKJS7Bc4olNTKpQe6zLC8xeAfCli/7/RdmCjwQemBqVwrhQ6sqDyo
         UK95/VQnPpO0lWp91wFVZ2UgnvwlbfX4MXNG0+/0Hi/tz73Qum8UOUYVxmIqcEBR/MpI
         Irv0uyIPgRTeHzNRCe9kMnu1D7EaHrD3q2uyh0RRW3qH101k2nogYNoMBIITe08/9tVj
         fwj+kA+DMlTId3lxOhM0OCaMcaclVBfnCIbhHzX5qVA4bWYhi9FIRHAwsq8GWQ8vZ5Tc
         836VbgZvbfndBgTD8vUzcCC+FNzzo2XMOBNGPxRGRaQefqS5GKDX6YqRwWhKe0XoPYXC
         oJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671144; x=1727275944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G3UqcqiJStniDz8ouIeMn2j4w8oVsWRLj7dQqF5BGg=;
        b=ezWZh/HNC1ZyawuKeL0fbIhxZsB0TzZul6xVUtdqKDFPY3PRs7Ms01WJ1Kw03umx3G
         24sjG/LnA++bsv82J097Z6VkGvybqXS1rtbnDbatXOv/MVUYSnDl1lP9fp/kKz3yMDhF
         WpXBDdRQhKqEOb/cvgBsOyL7Vov984lZ5KsU3NYpBGLf1HLPDywx5zohvZSD9ygeGYaW
         pfPZ0889BNZUlcwFu3WZhUbAzHGDLPGHKNjBLHhRdNOpXEnsY1uV1w582HJ+Dn9Q+0fC
         wS5zFg/HMbaLd05fuwYc0jAPEhOs/O05PbpsN1/59DVxla9ArqrBRtN8B0XjfBgretJ8
         M6+g==
X-Forwarded-Encrypted: i=1; AJvYcCUKnrnjwSIUQP7LSNmG81ngefQaxeriAULIoG6D161gsrPm8BtRepSZP/DTvnPzYKcwJ/waxbD3MTmAWH8=@vger.kernel.org, AJvYcCWRBpczXabq3bEZgtF4Ms7euCigpOLAcqncL7oKNichyG5zfpV3zO4YV0By8z6iX+/a2V6fuhpTiFIr@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZMjr3tI89na8V0owLouCc6tbcUDRYxMbmL2nN8ohJjwn4bTp
	E+7gA07CqKfJGRnE4zOCevs5Cg1qn1HKBs4lMkAUpPrAVJYiXQ4+
X-Google-Smtp-Source: AGHT+IFIL/32etJe0v6sSG7H0lQqshBBcTL4IRYyceTivDTN7x9yX3xJpZbfQWfbl7kK2dY0Zv5mxQ==
X-Received: by 2002:a05:622a:1b90:b0:458:3cc4:74fb with SMTP id d75a77b69052e-458603da6c4mr347857571cf.37.1726671144148;
        Wed, 18 Sep 2024 07:52:24 -0700 (PDT)
Received: from localhost.localdomain (206-47-13-49.static.dsl.ncf.ca. [206.47.13.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad2363bsm49717001cf.86.2024.09.18.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:52:23 -0700 (PDT)
From: Olexa Bilaniuk <obilaniu@gmail.com>
To: keita.aihara@sony.com
Cc: Masaya.Takahashi@sony.com,
	Shingo.Takeuchi@sony.com,
	Tim.Bird@sony.com,
	jonathan@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Subject: [PATCH] mmc: core: apply SD quirks earlier during probe
Date: Wed, 18 Sep 2024 10:51:33 -0400
Message-ID: <20240918145133.18480-1-obilaniu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802032121.GA4019194@sony.com>
References: <20240802032121.GA4019194@sony.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..92905fc46436 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,19 @@
> 
>  #include "card.h"
> 
> +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
> +	/*
> +	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> +	 * This has so far only been observed on cards from 11/2019, while new
> +	 * cards from 2023/05 do not exhibit this behavior.
> +	 */
> +	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> +		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> +
> +	END_FIXUP
> +};
> +

By happenstance I have just such a Kingston Canvas Go! Plus card, but
in standard SD form-factor and not microSD, and dating from *08/2021*.
I had heretofore-inexplicable filesystem corruption problems with this
card that may well be attributable to a failure to flush the cache.
Despite diligence in issuing an explicit "sync" before ejecting, the
filesystem would reliably appear corrupt after reconnecting it, and
would require a "fsck", but no bad blocks could be identified.

The vitals of my card are:

  type:   SD
  name:   SD64G
  date:   08/2021
  manfid: 0x00009f (Kingston)
  oemid:  0x5449
  fwrev:  0x1
  hwrev:  0x6
  csd:    400e00325b590001cf9f7f800a400001
  ocr:    0x00300000

I think the quirk here can be safely broadened to all variants of
this card and to the date range 11/2019 - 08/2021 inclusive.


Sincerely,
Olexa Bilaniuk
