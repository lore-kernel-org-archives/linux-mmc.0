Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C612AAD1
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372729; cv=none; b=fV/4cxgAu8P49FWRzE3agZ2kRFXc9wqJhp/oDxoAdNhov5nTwi1Lf2eDxa01oXoe6Hd/Q19l61wrOdrtRA8tKfiF8pzZQJ0EOK8jB6oIucd8ysWFLq4iwTiWQtshvge/XlikM3/LSOJDuMIjarAkBkipgwREz2YG0xhDiXldgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372729; c=relaxed/simple;
	bh=/jRdDNHwSEGE3CvNzenljKZrdw33DtVzFmmgraXk5cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ0vkVbktIHvMDta5fuhl9ESfEsrRDucQedDDjMXtLNtOO0j/oJC/4Ad9hY+ztaXEAGWlQ1fCTz3n4c5I7X05l66Uzk67F+Z0Uh3ySI5PeT4z/fS99gtb4N1zUIrtyfeqI+CxTrI7DEqVUXVJpie+E3MKvIEEfIu8ByDMyjE0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wp5VY1Wf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wp5VY1Wf"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4740185276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372726; x=1711977526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYNXzQvnM81GzIL8Aewj9RD25qOiiYInoW3gilEhTKQ=;
        b=wp5VY1Wfm70k4P17Tw+z04AGasIDMo8le8mXybAqh7q05xF6b43soDEJche7GjyrGk
         ZdVTSLKAdhBfd51jqnssMcnm+YmiMOpF9E0L7M1ub951czdx2t8RepjY8Hl1c1NsL7ut
         kQOW9b2X9J+Luf8uRCqfF96Esywug2hJIrN5lnGqtYVI6nl4fxeOD7gl6uaPAFsSivzZ
         CGahPOSapX95UdRhxHxq7qbRv/rz+nAAgnKeMp/lWkt+Cm+Z1djEt23gyIINv9ihsnO/
         0+TeRZvfqYnf5EeWVAAS27varXrirHOfVkmmY1d6Saahrf6VjxdAydZdhHoV8gbT0qsO
         PSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372726; x=1711977526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYNXzQvnM81GzIL8Aewj9RD25qOiiYInoW3gilEhTKQ=;
        b=hBkHYMNJ0e8+UH7NqynUIo9DUmdbDA8mFr/aVH/M/aGQdrm5bX0FNcVbvFDoz57BWJ
         SXK4irwGtLTXMUrQJ3i7KxxJdncuE8mh+NshYT2bJV0F/Ffp8cRAz9V+N0MxXNuTPO8K
         GtrOyR6U1UVRNNUQEm//rXijI02zctaeinmtx6cWZf6cgZ1NTMrV/uXK8SFPxJ0yY0aK
         F7Cxi+e/ytO9APmTmJLEOVkOWvdgu6+jwOBQhxiqOEK7Ai3SsuIsHYm1/pKwBJCrajnS
         oxzAnBET5DA+YTGDqFmKywJv3Cmg28Aq0Uy1WA/RCzq+fB6CaXBINrSlWKhCU4qyfhvN
         L57A==
X-Gm-Message-State: AOJu0YyKX6Gfmrcel/3c1UJHHY8wo2n9pu5zBeys9Zy3YJzLq48j93ln
	6ImeZBXot7pUIQp+Y6ok8jf9mCPSeymbKFlKHMke+Xqs/lx1P1heOtOklSA6qg/qh1P/3hScdon
	im8JCjqXm2LCykrrrBGmcKoC5Wv4iNnFBnqTmog==
X-Google-Smtp-Source: AGHT+IGozDfzk/PpYVV3Podxdbcg3FDTwqthJMX3zLNj8qanWGweFd7Xrq4deF/MtbEaepC9/bmv1+SARlRLK2BDQog=
X-Received: by 2002:a5b:5c9:0:b0:dc6:ab85:ba89 with SMTP id
 w9-20020a5b05c9000000b00dc6ab85ba89mr2862877ybp.25.1711372726409; Mon, 25 Mar
 2024 06:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114600.3643948-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114600.3643948-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:10 +0100
Message-ID: <CAPDyKFrKBiR7vnqPj_0iaAcQu9v0hdn0FHdGLgeCS3ZVYPdodg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: core: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:46, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/host.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8f8781d6c25e..48bda70145ee 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pagemap.h>
>  #include <linux/pm_wakeup.h>
>  #include <linux/export.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>
