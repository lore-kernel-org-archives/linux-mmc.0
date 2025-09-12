Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5230F7E8
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684122; cv=none; b=NghcqoiQqkJvjnge0sg2t94vOP5X8EtcTPoLLk+nuMU0Mrw5rRoXbqRqS0AHaoScXnnuvRzezc2E18G0BtDp8bR/VNGghsuxutUT1vrmTOxDid060DOc+Pz96GIC9rcdwgCpS9+9UyWmvZq7iywIOOo3dMTpEw6CYcHajUeL6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684122; c=relaxed/simple;
	bh=Yuj0dCMkvav9WHfy5ImukjT8/21OfH9yESKsGBNcPlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgY1634IxiR0bnBOH5rv1LuoWq1eG6asWoxO9x7ItV5RYCma5JawbOyRxnBuQZ+Qp0IvnvIsCnvkvHQnqM42jeiHDkbgblzR6th3qa4Bi5rRpAeVShDwZ8fWi5PK9p3Uv4HBDoduJpZG6GZblEHchvjbrA/Hxz5+PioK9LIc77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SpBoYsq+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpBoYsq+"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931c858dbbso1314398276.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684119; x=1758288919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=viCunKHcSjp4mIJTo5Uk0cyhV9YFtEv+yvUT8lHfr80=;
        b=SpBoYsq+Z29erPwoglL08ezf0CVldCor3KzuDuY+og5u2ZKByWjMWpO9Vclx3qP9qG
         WVl0JcOjGHsKE05QkYWvxn8HtOrafb0m86B5pP24DeB3eNskyyZsx5GwWXxZdh4smQwL
         cW6UAKlrv3Us59oBa35YS8qMPeqXto7nIewMU+n77rn1DvrjRsZlHThroOIgmp722t6C
         myuSlRASvuhlCGnNxKLCDgnUow53lWJKbi/7x2ZPFiDdt7EEpr/txl8X2m24d0thyKmG
         EAdUzmC6G4c4zoteyEK5h9Hz/baFTfgoq5LdXz826kOcIrm/aoyZd0IfcVIDpXG0cNhw
         zj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684119; x=1758288919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viCunKHcSjp4mIJTo5Uk0cyhV9YFtEv+yvUT8lHfr80=;
        b=fBooNWOAROakhUvnPR0OCOdJAdFapD1HnRzMDuHrTebg2nyEUjM2MuxYD87LLq6znL
         OXR8J4OfsoWryAffkMusWRMMHJuA9Brj3vKpn1OBq7A4OpVtdMPTCWfKkEIIXsrwckrA
         YAAxhH4WcgvIYgraAtAu5O6EjlVy0f75Dc8hH2FbCey6sxgyU+I43zEdwx+NVPHC116C
         vGa+r2NEVfpr+z66QUhI7WgHSnjRrMiKEeTR7jmXxSbI6lcu/YYEEBFXYPJGTHR7qwWc
         xdTBrci5RV28+yBC1lenVnkMQ6mJrBnnfdpaXNPc6LqY8CIft2ZqqQcnsmT+O5pAaX7A
         JqOQ==
X-Gm-Message-State: AOJu0YziQcuWsdBm5+5tgWQhdmRp/rj7oxwo8fkXnKdAR7XbdxOkPUCD
	ccUsaGSHJoJVWTPRSeclc9DqwsmX8YuRHnJilaTeZ3gs1AUcWzAA5AuXqv7KfmJlOJKKgBWHwLF
	yNV3ms79WSAwZ2dncRlV9htUkwU64xgQdyGcXKpLtmV3FKKRNEhBE
X-Gm-Gg: ASbGncsHZoJU8+gd0B+pt7a6deeol4SE+7Mbjk+7mtae2MkYTGzeD2pKO18N4SmoJPb
	AQXesQAI9shq4hFzn6ZJLA9FxPsiNH/xr9vVkc10wsDXRDWACc/WRDI0IsbX3ftHn5IEExcyw6k
	fJRzM0fxiJ0Mb2O3mbpk2Mu1AW/cvlHErU1TspGUy4c+8kurH/ibLx7VNbohOJaV6IYnX88lN1v
	yLVeSbv
X-Google-Smtp-Source: AGHT+IHDbmDOSk1x5tniUP8G1DPljyA2PHVP+WKrAizjNq1KXf7wgFDw2mqlBgCFS08uqabKkLq+VXC+ZSZOVJcY76U=
X-Received: by 2002:a05:6902:4484:b0:ea3:d862:9ce8 with SMTP id
 3f1490d57ef6-ea3d9a381ebmr2203562276.16.1757684119116; Fri, 12 Sep 2025
 06:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911210606.446355-1-beanhuo@iokpp.de>
In-Reply-To: <20250911210606.446355-1-beanhuo@iokpp.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:43 +0200
X-Gm-Features: AS18NWDjq3XpJDCsSijg7FsA5PThX5uDIIk031SR6KQY2lWG_0Ivm4cms8HD2DQ
Message-ID: <CAPDyKFoEVZaL_mWZMkmOWu5pa-bsSYkKes_H-wNwWdMwAjis6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: core: RPMB code improvements
To: Bean Huo <beanhuo@iokpp.de>
Cc: linux-mmc@vger.kernel.org, jens.wiklander@linaro.org, 
	Avri.Altman@sandisk.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 23:06, Bean Huo <beanhuo@iokpp.de> wrote:
>
> This patch series improves the RPMB frame handling code in the MMC block
> driver with several code quality enhancements.
>
>
> v2--v3:
>     1. Previous version was mistakenly mixed with other changes, dropped them from v3.
>
> v1--v2:
>     1. Add fix tag
>     2. Incorporate Avri's suggestions
>
> Bean Huo (2):
>   mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
>   mmc: core: Improve RPMB frame handling code
>
>  drivers/mmc/core/block.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> --
> 2.34.1
>

Applied for next, but dropping the Fixes-tag from patch 1 (it's just a
nice improvement of the code, not really fixing an error, right?),
thanks!

Kind regards
Uffe
