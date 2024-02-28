Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6A2D60A
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110765; cv=none; b=GmlMRc5dSL/hQL+/Mbq/EsZe9O5iwYRrCszYOIWTSTOIC/4goSIcniAq8qMBm9+tg3JtP4p4i6agovyKqA4S+XeZiOYwjH3k+pVuEZtTUR2QvKGOhgtglZJNXtlKQ+G5mTYjS4X1QBc5E7EgB62vhWtok6/G+N902jNpKKXvaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110765; c=relaxed/simple;
	bh=rI6SWg85yq8UOI8us9O4MGVHODKQZnu/8vEJH5S5vv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIUJ3Eg8W3s8TMwM3M/KEZa8mzN8P54qVLhnPkIyIz2yoOP7Kl0prsihyu6CrU0WjZ1KgHh25qxUmtu24WzlmfKBE9IdIOekCaxMuJm1NdtVjkQASVlZHyNYRyJsabGgAiOP/me2sfnq5Djde51ryc5MCPnFYkfM56YHY93CJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNxrnGtp; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNxrnGtp"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so4717037276.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 00:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709110763; x=1709715563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83xEoTM9pyhFIZQ3p5uEaWab0ZVg2/ERRfhIG/jiX1o=;
        b=YNxrnGtp1UwarqqGA/yWWC8g90a6/2uiRttSd5WOrzu4yGDUCnpeOAXCvtaHUjt6tL
         pb4VSTN8bojv+CvedDkcmTIjUcDT58FQKRTHYJ0Bm5lmbTKU2+/MzUBxSaNhSnbRx0Kj
         azULdp3kBJwhU+pIeot1KcFiyz8OzScrR24a+HxVaKIs45fc2Y+eSdH3UsPrAvTRKiDG
         lC2bdYVNZ1T52tFvEgfep9nz1bbFdGGFECYo12picsLv0iwUc2tSVuheo20pt7MGx7EV
         d61dybepUvxzPKummG/3RS8R7vur+baQzSAg2XQrVwxu6WoPaNIUuSymdTEAoI6XkvGQ
         xM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110763; x=1709715563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83xEoTM9pyhFIZQ3p5uEaWab0ZVg2/ERRfhIG/jiX1o=;
        b=hbooK8aXGRzIZ4UPhysb75BT3eXKh1m9RO5f8DHdOkkeQf/8iWJxSdJTfAXPmDEc8F
         Lowd8TSIww6Z53DZDLkvfjuKznMUdHIOI6NCJKHBq6rjKtdgMm5Rwvjvh/kitFUk9OhB
         dDYvAniIvfhvrlAGRIH3+u/jt52WTqIHh3ggHpdYoMhWO3Qw33DgD4pDAz+cmuCExyYK
         6b5oLiSLcP/HTEww+YCpj+2t6HtueohvqYWZfS8iXSybZXsFEsKrx5tOS2Fy2DGXDVsI
         cIwa83uleAzHu3lScCnbcgAm0ZpkOG+ydCJOfKK3RxmRPSMOjhquYgO41xC2XYvN497W
         kttQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO3C7Zxpap7CIFlm90q1EgtA6Kr3cCpzpKgdKqlQQdVRLrwpS9iIMV05e4Mm6xvos7v+CRm5UcJs9ya9xeKqzJa5DofkkhRyEU
X-Gm-Message-State: AOJu0YwF8IW56ccGy27U8FsTdbn2PNvYUIhzwQn3v7S5IEcBGoBj0wzx
	I5F4m3a214wspLeZPUOpQIYWnjfv4G8dYwU98ZkumQNlmS3WtIwwkVLP5czSSM4kZ2MyJeaSWdj
	+DFfj7HSwYOlEHmmNG7tDbCsy7+AikGgJKCMLrA==
X-Google-Smtp-Source: AGHT+IFZNX7Of0MMd3ykmjiTkSAKI592ZXZVNzAES6E4dSQc4vKU+R2SOYtzg0dpglbKvcbxvkwogfvkr0NKXX3At70=
X-Received: by 2002:a05:6902:250b:b0:dcb:d8d1:2d52 with SMTP id
 dt11-20020a056902250b00b00dcbd8d12d52mr2065031ybb.31.1709110763457; Wed, 28
 Feb 2024 00:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org>
 <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com> <CACRpkdaRHz5LE_TpD7xkitX5ohafEvqOACx8PrEUuD-6oz-pUg@mail.gmail.com>
 <ce6709b3-b87a-4823-b4c8-b36f82195191@intel.com>
In-Reply-To: <ce6709b3-b87a-4823-b4c8-b36f82195191@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Feb 2024 09:59:12 +0100
Message-ID: <CACRpkdZwF1PYuaxDS5HTCPT==wyz=2K0t0Am_MXRF6KoXaVkMg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
To: Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Angelo Dureghello <angelo.dureghello@timesys.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:36=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:

> But passing around is_atomic seems ugly
>
> And esdhc_mcf_buffer_swap32() doesn't sleep, so there should not
> be a problem using kmap_atomic()

Aha, I'll send a simple patch just making the iteration atomic
so we don't overwork this.

> As an aside, gotta wonder why there is not:
>
> #define SG_MITER_LOCAL_PAGE    (1 << 3)        /* use kmap_local_page */

That beats me, but Christoph probably has a good answer.

Yours,
Linus Walleij
