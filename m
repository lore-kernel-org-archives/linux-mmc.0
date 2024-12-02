Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F620C009
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153078; cv=none; b=fPZ87F5KvTB3UtfhM1uvr74tV+KI52Eh0YJJPEbC4UoZyemVfLicOEeWjnoJdTZf6qXlViCCz3D9IKwtS3vpIZvL4VVon3negqYvVb06bMu7yu2Ur4+xqM9Xgk/dS6yu77Ytam6CCJ6w3p2D61lgmH/1pDT/6nLGQxlf2lxtEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153078; c=relaxed/simple;
	bh=AbvmyFF8iykoSM/f6TneHmi2O0lZAKUhiodIOq/hruA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWD8XOxdLi3PA8xVcbLF2VP5LHJ7iH3oPm0pjQNnU7aQNwml29KV84q+3dPdVr2eH4ig26DRuk09PKNXxWzuH6u7G/n7Qqy8E5XnNkc2ao7lkmwucCOmisEpTICGITpLzmxFTQNiHE0THllr87oH03Hw8b1ySJ2TyxOCq2ednVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAXxGGHG; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAXxGGHG"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e39779a268bso3126845276.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153076; x=1733757876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2UHD0+iG63sk9WQguvFbtnOatRFiHDDSI6F2s+sic=;
        b=JAXxGGHGsuc01Aj0jXxfWP3IExpkpjjWnviWdPBffjIAQoOh6/hTPQxXq1PNBFQsbQ
         9LuR/ADWNK220IhAw0D37MaXEWcRdMtCvIddDNNM/PF7mr95UYDaErclL3O9VGZDPjDM
         fYy1a17+gjL7jzTGf86eyt3PWI9bWoLncK5L5wSniTk/1odKMfTzzqAj0Am62rMIGr2+
         xhr4BcrFFJaYawmblp62P7Eu8So3DzGcN/LKKJI9FlxyszcJI5wR1Lke0FH1lxnvXQB1
         FA1GKOtSp1yU08q9owlA7IjkhxspxNcB6wYzcNdAXjxsVbsxN12hVpulnWEvL0dlaUw9
         215A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153076; x=1733757876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI2UHD0+iG63sk9WQguvFbtnOatRFiHDDSI6F2s+sic=;
        b=DQbeQxIL+DwkXA7FHb/6CFZB+1CFawUpEcgzr2QO1o4b0hwjQ/NGg1GJxZ8uVgtVBo
         hy4iJdIODmbH8WUNIZuoE++fIDX83+YYeJa0X49Un9k5v450U+IodhQC+cg29IP2qqUj
         g4GseCF8nBKSOS4Nk+KsLg9U5vl5DEf/TFGjAkONcSWcXqJlVm/SvYY5WPgmCzWWaRXc
         VtYAvcauAi9SLiEXFs6uWna1vbgMilAV9ctcQgVTp4lKB2zJB/jDZKZlpZr6agFvcSfG
         A/bqHOCBESC77i1xnu+/zq0KHgWvutQ2u8PBb5Y0AF+e9X/BMKFIITsHshZAvOi99bam
         N/bw==
X-Forwarded-Encrypted: i=1; AJvYcCXdFA4KPzvR5jUKAf6UESTRT8rj1oxFqGsekyWtmm8ckz6Lfv2yUTnFS3RUlx8xSzccYtLn/NU5tfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipqCLI3nYiI0gzeFtYcbJ2+VyZiYmQpIu5ngz5Kg58iZRp4dE
	bAo7LAl7+wavaqZvCAkwiPd2tmk6wCmA6LloLiRWxQgk2tEWSd8liDfcYD247TSoK6uQFqqMvzR
	4ydc0bqNBPW1hPWG4T8P4JpLY9Pn1EVc23vfxMw==
X-Gm-Gg: ASbGncvoLH/ZHnHs6muAZDqpG7Qrqgwmfua1cMiJYfY1VatSFWh+Wvko33s3JWsNA0r
	XB2OfFtT3izKpyDzNoAAEJBZR0ykvz0/9
X-Google-Smtp-Source: AGHT+IGyxw199x8a/NjiG9xXny4LctKmTAbUkVdDlG8lJAJId3wfy0XNCoiRv0MlIrGKEJpAZbdNecDuMiCwsnC9has=
X-Received: by 2002:a25:d690:0:b0:e38:2b99:7f2d with SMTP id
 3f1490d57ef6-e3971966a52mr17352002276.12.1733153076156; Mon, 02 Dec 2024
 07:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:24:00 +0100
Message-ID: <CAPDyKFqNKXRPT_QonnJ8frY_OvA6FkEMyj09Ywiqhtu0ZL34Xg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-acpi: A few cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few almost independent cleanups for the driver because of
> new available APIs.
>
> In v2:
> - added patch 1 to solve compilation error (LKP)
> - split patch 3 out of (previous version of) patch 4 (Christophe)
> - added patches 5 and 6
>
> Andy Shevchenko (6):
>   mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for exporting PM functions
>   mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
>     pm_ptr()
>   mmc: sdhci-acpi: Remove not so useful error message
>   mmc: sdhci-acpi: Use devm_platform_ioremap_resource()
>   mmc: sdhci-acpi: Tidy up ACPI ID table
>   mmc: sdhci-acpi: Don't use "proxy" headers
>
>  drivers/mmc/host/sdhci-acpi.c | 92 ++++++++++++++---------------------
>  drivers/mmc/host/sdhci.c      | 14 ++----
>  drivers/mmc/host/sdhci.h      |  2 -
>  3 files changed, 40 insertions(+), 68 deletions(-)
>
> --

This looks good to me, but deferring to apply it a few more days to
allow Adrian to share his opinion.

Kind regards
Uffe
