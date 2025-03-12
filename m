Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E51D63FF
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779713; cv=none; b=EBUZmnUyceR+En2j6wk2PSingtYAB1FOIF2QbZLT1puHPKu263j1yYl4YGTx6pgEnMS8vOtPrfm6i9Vr3LrDGLbXeutI/P3KZfOqltRLIA1+y10LXCE9+/5X7PCGPBFnb6+bn2DUpfW3wGBlPIM+JVYhsB9ooROUfV9586sNBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779713; c=relaxed/simple;
	bh=EyZJGTI+zYNOGGndCCXdh04eNzKAUwXKYAe7V43zfB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReL51Od7j8z7WqhrWqaofP2QcOBMZ+3SR2BkAygvhUh4iDIX+xT5mvy9iJ51yGFi0wpxyBsH51+SoDhmG4DioV4TetXnj/iZLxVOI3D7JFRtXhRPJNyd+hTH/b0QdGMmETeHCjBGiUKkQVjsqXY+D1em2nVfEwVktgsenJi2Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SooVH3wh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SooVH3wh"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f74b78df93so63007597b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741779711; x=1742384511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5AbmgeCtEgyQCx7vuD5gs8jC4kK4Afqyip89boTm20=;
        b=SooVH3whplong8XKwj2pID0QjVIQ+uSmL/uc+dXezDwmnsWIO2Z5PJ35RPSoTyYZW1
         HufhzAdC407xFavVBF66v0d0C2+cJRMbRk/HpXoHZcLONdOxn+F3fWsuTn58/6Ui2hRC
         cweCuJyiARi02dUQDRY5t8VXvDbp1ankT2mL10ffxJel5Kxhe+11GiBkPtVynvOzjNde
         0biGeWFH0n5qn4uGhL0lmZTYeI6OiZZOtgUlk1cNPJWqrzA3uoOh+7XzzMZmyQ9IIxzX
         cceCmEB5sl5hX9libdhI57HXP3SlSIpEb/seP+N7kOwU3MlCU+SHHAeRIJjEntoMDSs7
         0uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779711; x=1742384511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5AbmgeCtEgyQCx7vuD5gs8jC4kK4Afqyip89boTm20=;
        b=aUpbQnnY7UPwuklxP1wjC0wDNYHy+WB698+Su8+LDpFs/lBudk6QELJ9GKXQr+r8EB
         dLDbrsO3hYHWVahPguPrWeW+Gd5nEFyPhhF+9AxR/gtkK53eDhtQoO5Qsu0wYayz6kHp
         j0syCN+J+Wlx2HiFydQJfQwSs2I+LIC3oggyJQnzbbsTEx97dtBnBg/oG34HwQLpHB4H
         s9M+KxCtEuIm/bqQcXzFWDVtdj7dYUEC4QGpd1nV4xQLkadhljGJnrdVyckHByJMm79j
         ZVAxX0BVFv2kDUqbvPAP0sfUYLDGtr+reIATjfpxTEhAMtpecHdlLbCkKwnQigTTpc7E
         Ubwg==
X-Gm-Message-State: AOJu0YwgKoqJ3N3v6MKmYId51eGUTIGfSjON32b85+EmAjFdJ3LYXiJ2
	9kWiRZOoIWv+FwEZMKeCnmlzb4fQkdVJ/0PnP0lu4R8Z5A90RVM+hz3yJV1Oegfgb/F44qLh8rs
	gwSALJUHqnr5uPk7ZTBt2lldm9XNECGfXOJ0zZGFhACO8eCzd
X-Gm-Gg: ASbGncvAN8whR6ygz1tF4ps5xzCCGGOGexeIaTbQfHciYqksHZ3lAplf5iReEpTmE9Z
	iljYwGnX710khvhlIPrrv8v0jVa78D06SLXv/HRo5CNOgjeX0y6umbPCVae2/yM07bOcelE9aUX
	BfRFLCMI7I1v/REcVmHYqa884nHbU=
X-Google-Smtp-Source: AGHT+IEXqOrxMWd5mp7BfZxONhmq3dtMAJ3LKEBa9fxtIU4MEgyVcxr+nYVbdAy6cWqjffdWPTVQkKOI7uwcUB7U8tU=
X-Received: by 2002:a05:690c:4c09:b0:6ef:7f89:d906 with SMTP id
 00721157ae682-6febf3b77c8mr268234537b3.33.1741779711037; Wed, 12 Mar 2025
 04:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310055231.304728-1-avri.altman@sandisk.com>
In-Reply-To: <20250310055231.304728-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:41:15 +0100
X-Gm-Features: AQ5f1JrBNcwGHkyQrxu4iFV2BDn8IY5VjqkL59AYiM1WwTHzBeZoL57ZEbQRTgM
Message-ID: <CAPDyKFrVu-533nCWMV-8ze8gGkDNUnCpEBOsvqdtguqU2V3h0g@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc-utils: lsmmc: Registers value as an argument
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 06:55, Avri Altman <avri.altman@sandisk.com> wrote:
>
> The primary change allows the utility to accept register values as
> arguments instead of reading them from their sysfs paths. This
> enhancement improves flexibility, particularly in scenarios where
> register values are obtained without access to the actual platform.
> Patches 1 through 5 are preparatory cleanups and refactors to set the
> stage for the main change in patch 6.
>
> Avri Altman (7):
>   mmc-utils: lsmmc: Break early in scr read
>   mmc-utils: lsmmc: Remove redundant argument checks in do_read_<reg>
>   mmc-utils: lsmmc: Pass program name to usage function
>   mmc-utils: lsmmc: Update HOWTO to include CSD and CID read commands
>   mmc-utils: lsmmc: Refactor register processing
>   mmc-utils: lsmmc: Allow getting registers value as an argument
>   mmc-utils: lsmmc: Update docs to include new options
>
>  docs/HOWTO.rst |  14 +++-
>  lsmmc.c        | 211 ++++++++++++++++++++++++++++++++-----------------
>  mmc.1          |  18 ++++-
>  3 files changed, 167 insertions(+), 76 deletions(-)
>

Applied to mmc-utils, thanks!

Kind regards
Uffe
