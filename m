Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02137218328
	for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811277; cv=none; b=rc0WV+IsCTGrbURBVhYj6G0w91mlxaSjnskl3NL8JTrJL8undrzldWTBRDkkjBJOHRHTCbJwLbqK5+UfTwt87IfKpjQ2dJA5DDJjTay5IRnigo4ynZGhFtIceTE7W51josZPiReJ24HyHeJzBcnde3s70ia4TQxTVEj5VxJmNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811277; c=relaxed/simple;
	bh=DVn+SYk+Tjqw0iTy0Q3POl4+sdohk99Vj0R+qOJJ1tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coIMnI/AgVdoHwP0wnjepT4EfZZn39/jMQUEBHuAffJbuxQpawbcv1e+84zGuxIYQaO1M2Urq2tI8uXUl5xQBcRnUZUPeKFk5zNzHQL9BwezGzH5zZKL49MLKIDkVGxGEtJ32KLciY+2QHhjBe/PXAXCnJO96yMk2YrX0uJYbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uA8s2lPt; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA8s2lPt"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3881042dcso14262247b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Oct 2024 16:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729811274; x=1730416074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd00M3Nfh2EArviVNHmKQJ9PrDOqZudLClGyoklHFFQ=;
        b=uA8s2lPtt7CxA1RbthIpkzDUNyv8+xp6VAIABipueeeNxC49n7DiDQlYdmpW/jQheT
         XpgduRJv/LUJ8+WGRm22rGeF4FypzLWm5kF3Mbb9tGF70QsASoir/Zh2/W8jSXmBbGQ3
         h9IokpTySpYxui+ifwUdnndnTJWlBLoXZC+/djWW3CVFDIHXhaE4/kSivJth+Fe08PHP
         4N96iX4rhv7RVu7X3JReUivnqux+tYtJENx72pvN6QZqh5GNl4N6v/p1XXEYFjVLxfIw
         2k2xoyIn1QGXR5imCtSmsQ7gkUlfX0xD5pZJoqetC2gxYXYVp6M2zImjabpW/yum/TII
         uIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729811274; x=1730416074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd00M3Nfh2EArviVNHmKQJ9PrDOqZudLClGyoklHFFQ=;
        b=uNzFAnssJGJ2OS1dCbCgpNJ6elZijZzaLPnUa4EDGWdzbWVZWWhLGjnXefRDiq0MBx
         0ZOftc9G17LPqej0yS+GSklVij5y/k0CZil7q7Azkv9COhz2AIGoPJPUMzDrMrplCwbq
         /ge4wqpCa6fIXzCCjaUooDqZKr71lMVofsppUyNsgoU8Gd3L1LiozllX79H/bHVkOWwP
         y+YH0ICnh3gzgnMS80sOnXs6RW+b3/ljN52HuurWVS4g00HV2v5Ttwfv51XO5ZCizCR6
         RuiQauy6CrrWNMi6HjOrOkshFB3dLLT2NKR+L5E1CLwXg2Y6x5PyLyT2zBZPbbwU5614
         0e+A==
X-Forwarded-Encrypted: i=1; AJvYcCUdkzOK2hY6qY0QGi1dbHck0e/LqZgdKbs0GI+hgH46rT1xZ92S22rJNvxO+f7fGW1QqEKSYPI1ed8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFCAu63RXLe1iuwHyw8KT0DSfQ17rnQ1dbVBySX307PeCKpFB
	wyGBzd6qw0QC6yRFWJK69m0zjBX0xRPcGCmiOsWMLK6Qc8vwlJfCPTdGf3hX6BBgJZe9tLfgwxn
	6QdE66sK0L7hWB1BF2nsYteRKIk4f/HN0yGjpcQ==
X-Google-Smtp-Source: AGHT+IF814lTmaAdxP7QG+WjWHddmoT0eNmGaeikt22gW0jXgl1lCMcHZj3wSxBIOfK0gG522vtucnFBiJQutSiPhTA=
X-Received: by 2002:a05:690c:93:b0:6c3:7d68:b400 with SMTP id
 00721157ae682-6e7f0e3e428mr83305447b3.10.1729811273927; Thu, 24 Oct 2024
 16:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com> <20241023213134.GC3736641@google.com>
In-Reply-To: <20241023213134.GC3736641@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 01:07:18 +0200
Message-ID: <CAPDyKFo05Hyw9gdEBx7zQq_6P58ittHHsZQLuqmeR1AChyHSHw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_neersoni@quicinc.com, quic_gaurkash@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 23:31, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Oct 06, 2024 at 07:25:28PM +0530, Seshu Madhavi Puppala wrote:
> > Crypto reprogram all keys is called for each MMC runtime
> > suspend/resume in current upstream design.
>
> Is that correct?  I thought that similar to what is done for UFS, the key
> reprogramming happens only after the MMC controller is reset.  I thought that is
> different from a runtime suspend.

Looks like Seshu is not really worried about the host's runtime
suspend, but the card's runtime suspend.

Perhaps there are some out of tree code involved here that makes use
of MMC_CAP_AGGRESSIVE_PM, which is what allows the card to be runtime
suspended?

>
> If it's in fact triggering more often, maybe that is what needs to be fixed?

We could extend the runtime PM autosusend timeout for the card, if
that makes sense.

Kind regards
Uffe
