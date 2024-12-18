Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC11B0422
	for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537349; cv=none; b=WL9WjewbLpisRzyPfss5TAd6WYF6A5TpG/+XPIhHcWn3iIFQd+v1Tg2KZzxBUj/cX8cDxnUI/ht4gGaJPZVQlaeOc+RD+dLtvv1PUR5k3HwmlZIyDL253vjb8w8XTyyZlXZpvHmKF63KC9ZMsW4Dhs/rGUi7vZIoBuz1zPrBpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537349; c=relaxed/simple;
	bh=gZ5m57L5U5XCiSV3mFo+liw5gKplOAmS+vECxEiy2zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN3CdY0iQuAHSO0ng4CuRn7WHqFa799Mcb+hyO2EsYXDXZBt5A2iWKi2jpgT1ZiclavH6PyfqEG/8ilXlfvLfb+4eTqQmTVD2uJaruZ/ZrD073WzwpY/oW2HmTJjl9CPB4mARzH8heCXFvyw6pCBBZ0vpz656twMJqcVIG+FjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sfj+9LDM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sfj+9LDM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eff5ad69a1so54682837b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2024 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734537346; x=1735142146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pddenGwcz7M3MrEI0yXL0KIp7d3Q/c43PV2fUhsrj7w=;
        b=Sfj+9LDMJ4R2+YtyWVP2+tsOzNqM9zDEgp4t6UXs7k0Jr8+AXhZMlH5xgBLwARSFHb
         85IzDx2iaQ6iFTcXrvSLf7Dqj6hhHk3oqlsbuwDr4nP9opHzEgP7pB8EWTKC9JMe4IqW
         D480KxY/3wxuYzs3ELTG/jleTGJp9yRpjjsDWro7Sjq0zKRNFd0sQHR2P2jeziW69+4I
         97iUcNMft4QbHNAWcSF+1IhMbvsclRrzp7UAWzIqSSwo9Y07TCuw+vWvvrdlynT5+d0m
         4UHYdmY5S2jWmWj+z0EkQ59CX8iD99yVphXd+bnH+syra1KcUT4JGp4TM7wzFXTqyd51
         4zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734537346; x=1735142146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pddenGwcz7M3MrEI0yXL0KIp7d3Q/c43PV2fUhsrj7w=;
        b=GrxQ4qIsv5cA/LiiUHH648dM1SSE9gzJ2KdK18u5v98QbQ/PI/YJqbM+tS92b1qkVO
         SqenOv9HrNlVi+v7w1Gca1Qt55tCt3UYQQZ5E17JOWiUyi0xnemqqQPf6rAjwWPDG9MK
         OdUQiGWB/RtXUL/wAs/3ctYHVinuH+q4gV76TuSolgRxgGC9Gvmd98UGstx58EUwaSmQ
         KEdNjiEwjQlRa0jEqgKzXot5fjkXS/7tuS4Xikntra6yOTjEOgdXqFEgCNFZLN11ulHX
         OJ1IZFPNs8JMofV1uhlK4X5oSbQ1YlebDEjf5bc/NoaAAeFg3LA5jd08xkk+Z/Bj2FU/
         71Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUNzAZE85z52NaqUGMQWL9gJw+3pbHu0PArqchglY1kWljaNLhxJBJW80eZgNFLs9WcPAmAAr2bqY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo16xiE24FPjDNHA03aG6mCaKgx634O8fDvstXab9kBnjUDlJ4
	QqiJb0Pz0i6f3hEgpgU9FEnaIBrAYfQqipt41kefZG6TnE/yCMzjECsUEuT+t1GesVdpSHY+YVW
	0aj9hUi284o8DgQTw1JwpHXAT8fHeYtgVrMoD37EeEDSEAR5i
X-Gm-Gg: ASbGnctA3CTU1Vzy2rhcDTORcbLKkx0tycJh8RBSBlE1s5C0iqBpPL1mppzaaxKZrIX
	/XNIYPEyyeGfRL6IG5XO4KOxdO9DyDTF/REeV0DA=
X-Google-Smtp-Source: AGHT+IFlLxr+sdfeNBlPnv8qKgK5PaQT8LMr0mE/4KEXuXLb5HJjLnmdIPTOCXKsricCmYr0GcAF1KrSVpEnJcPjJf0=
X-Received: by 2002:a05:690c:6187:b0:6ef:5ca3:d0d9 with SMTP id
 00721157ae682-6f3d11206bemr27337927b3.20.1734537346366; Wed, 18 Dec 2024
 07:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Dec 2024 16:55:10 +0100
Message-ID: <CAPDyKFrzqSGUHy-Ee5uDGsumEn-yYEPDG3SdrK9HjPQQjt-6-g@mail.gmail.com>
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

Patch 3 and 4 applied for next, deferring the others.

Kind regards
Uffe
