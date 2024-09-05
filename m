Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13718787B
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531538; cv=none; b=LoI+l9F2Ir9Wj/IpUm/A6bboYdVr13FDPJtYLWmtaA/GQd2uljca2EBMHk0LTs7nIAKGnrzGEBgM2DEkJ6p355LD8elR5Di9AaTA8kJUTkek2uQqxmvE2/YlcdwBN9Gf9yE0swWjQLJSp+K6u3XNkn2j+0uOM5j9UwHanax9Ngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531538; c=relaxed/simple;
	bh=LvoeKGy9rwyFUTdJtqIlZp8oy/b9I5WNgqi6kny6M+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKZUajGfh+9WlCSTfKwn7z+M4B/kil4vS1Zv3tk1PBTY9K4u+dYeJXLQsuy1G9HNRtyqLCZAOu5PB6voLp1u9KKLA0WfMjhccGT8n9O1RzcWJZf7rfXZk+MRhJ/x2oSzrGofc7MLIwiHmtCiaohhpwxzrzpaxdwMCaf4wyugXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuABxPIZ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuABxPIZ"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a8e305da0so695639276.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2024 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725531535; x=1726136335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+oY6BaE1ynE7zLjqZE/FTyE2vdgPJk9JztQqZbEjgo=;
        b=XuABxPIZ/Bdr2Mvcb1s+ZpHGFmDwfzfaJoMo15yc5Cxdu49+5Btf9LpsgPEBPX9feD
         tl72WcEX5vyJP4YAqDbdHY2gcS92YJgVOy7+EYTsV/Bim0v37vF5nRCFBmzHgOYUMDrQ
         hhyJiiWQTIyVjzxLNuN1WpoPeoP+b1K4h32mQeQoQFYCJtFbCKMwJoGAvBKt5R6bwOTt
         xBKectciS9MmBxni/ULZptk3uOL3iXQhOnfTF3c+bzB24RZ+fIG6+8echUKE7QwdEbRb
         OXfIC41LHjNuudDChZqGRmRc6AjEfxMYOODfv1eiUf2EhEmyF090GyL9IXi2zBikSF5x
         ACPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531535; x=1726136335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+oY6BaE1ynE7zLjqZE/FTyE2vdgPJk9JztQqZbEjgo=;
        b=vaZ2rrAuk5mTHINs4ZFp51orKN5nUAeA+q3rfhewRXN7N1OAu/4hsT1/E4+VdiUjqQ
         yA1K/5iGQdCeba05cvTFiXZC+ijUtOswAzvw1O+Yx58C2ac6I7gYUSDFS/2WI71pFPep
         JcBrKsm8dKKsrdKry+wjvsv+ZQ3ynbTUqQSETXoT/iBb72Y88AfntkXEQ6ACum+ZzQN+
         h5YGKw94zoi42D57hAnb96cstfkOE0sPRwJO70x/4Qt5UJuZNIS5b6VUsqjd4owEZSTR
         kYRxX2Mq4viXhGsKzAl2hPMFCWd0jvLy69qWrbtndxHtJ5qfoNfm+ej4UVL6BGIMR8z9
         TR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw29lz5Uxs41RrsH/QXggLxBR0uVrgYCJZ1zvTRK4BKPXLc6T6AMUjqRPVcc+ojWcNDkG2QsTeZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCqGRxu4LDUmpj0UdSzRcys83su2P8ABcpzXZohdPpAIk7obP
	NWl/09M3R0juouY705t/nEEmC8HAZoE2nKqQAEya3kmqoI/ddy41DAqfLRoBkVp+BQOSg596THr
	RFtdpHkvdAGXtQbYVj/QOvS4OD4WQcpUyx5Vt0Q==
X-Google-Smtp-Source: AGHT+IHuelAEtHGfJqd4cMp1fQLqMT7mIlLYd7mYntKCpCV6iNSsUlkVhguMLQWaZS9WxDOAH0lSnuB4JF5PJW02eW8=
X-Received: by 2002:a05:6902:2d08:b0:dff:2ce8:cc1b with SMTP id
 3f1490d57ef6-e1a7a17a74bmr22861488276.35.1725531535404; Thu, 05 Sep 2024
 03:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904232512.830778-1-jm@ti.com>
In-Reply-To: <20240904232512.830778-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 12:18:18 +0200
Message-ID: <CAPDyKFqt-dATBPTFmAjqocMt_tKh0s_GHHprBLWSmuV0wn9kQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add retry tuning sequence
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 01:25, Judith Mendez <jm@ti.com> wrote:
>
> Due to failures to find failing region issues seen on some
> boards, add retry tuning sequence to make the tuning algorithm
> more robust. The tuning algorithm will re-execute up to 10
> times if there is no failing or passing itapdly.
>
> Due to the same issue above, add prints to the tuning algorithm
> to make debugging these corner-cases easier.
>
> Changes since v3:
> - Fix compile warnings
>
> link to v1:
> https://lore.kernel.org/linux-mmc/20240815201542.421653-1-jm@ti.com
> link to v2:
> https://lore.kernel.org/linux-mmc/20240821192435.1619271-1-jm@ti.com
> link to v3:
> https://lore.kernel.org/linux-mmc/20240826210454.3928033-1-jm@ti.com/
>
> Judith Mendez (2):
>   mmc: sdhci_am654: Add retry tuning
>   mmc: sdhci_am654: Add prints to tuning algorithm
>
>  drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
