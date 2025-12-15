Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DF223336
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813458; cv=none; b=FwOaD4oORVXYD5wB/oyeII6Hs/T/+FksUqWO+2mFi48YRufaof0y/ygWMDy5vbXtDte7ngvO2uMh3zRh9SJdpwNCtlbSECJIU7XCOYLtlHMvaGxB4+o7jJkpez4DXZ8631uMBLG8vTdZaa0UF7Yi1XoVr0Rk6/z+d0wBj8evtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813458; c=relaxed/simple;
	bh=OPA+fxuief7E2SBlAHatD0kmyRya8xhOrAuKA0YWco4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGmxL81WJDxanPv1QkqSJ7jydf61XZfQ3PVtZSbF45rJdBQi1dGGR1kKvxtjo4LiCpBkroNJ5/6uvQ15usmuYIrb099eQrteu5fc65QpXQdsGr4jdyMq07863XZLIGRKq8gAVslCBwL651K8mQ+Ev/uR91oHt4milFTGSQRdlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7DOTqze; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7DOTqze"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso3164977d50.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813455; x=1766418255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxLO4eXVEbQkA9BtFI3B3Xjfx5jZwIu/7GRR4IzCyHo=;
        b=r7DOTqzeObSkHf+sg/lGcHd5gPkdSbljTGLex51kN5xgmjmv3LR7AcyBsJKXUbFcLC
         cdg/MTruMWdHoc4x2YCvFZSg6HEknSENopsZPmWo6kqz/FRbibuSYR5GT5J4fKQlrqia
         LgN4b9USM7YKiWS4aQtqqLYaSwgxT3Umn38mL2GfLxX0SjmeT6mshRsVeQPScmrvUVPR
         sVOLA6Nr3Q/Q70CiUtdPRpN6K6fSc7CpXKd0m1Dd0KEzDOHaUn/0BIMnAdXC5NaiH+WO
         9ArPMt400c7dRys8WIx6oCwUDJhGEjx3rZMbIu04WKc3c2DUv+LDlwXtOusibUi0E6zX
         nXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813455; x=1766418255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxLO4eXVEbQkA9BtFI3B3Xjfx5jZwIu/7GRR4IzCyHo=;
        b=FgxH52j6RqqfQkYMEAGwe65uH88Oi8VvcRnv0v44bbZKTl5XVPX1QMtDx2jBS9BYN1
         Tc8nB4nUA8oR0YJPyVHtIFJJVQPJpcM4PLMOzCc6IpzQoznFNQqgbIItfhH39PaxSgZN
         2vAy0wL/+GOLx4O6zbJC1TB68G/wfvm2jLZd0pQBgaWGUVezjZ83WVg/HiEpf+7DKkFf
         0v3PBOeVXS738CoTH/U2+p+VWiUx5G3MvSfHkX4YlwWlhLveKtNOxG2wIN9KzmZ0BCIf
         CWfKJCl7gS8Lf5Zr8Xzx9aL9gJ2Y8SsFyehMlp/GTfYfh8w4QUEdbtElUq9soDQRGfi3
         Q+Og==
X-Gm-Message-State: AOJu0YxJHOgmEVUJemVKfzeAgnnW41F7mHZMJRWEC++S6A1m1Nd9ANgN
	iJOd60CyouNYvN63TWpzcvNAFWMNIhU0UGMslq8LLDgYcqU4SEWlxVv+TzY7TE5kidQwvs06tQa
	PcNlQYa5s52JR27093ixvXjWMjCpUpnbDrkc6cNtrHSbstKFyve7K
X-Gm-Gg: AY/fxX5Vw3mYzlwAIQCExkVtkdfFW8WEoEn3t4sRwlWhNt03dhLAl151CWXVo8TJOYu
	mmDwkQHwu+cc2nP8/rXg8o1mEkvAZQyEWwcFN655NVwyvIschK8Q8qOhZfwoVUcfKrK0ApEgo5h
	naNt1JHX9iq2AXFvWNcyFYVHO6WbtKINds0aHNan7iGtl/U43KN58JcyvYy4wQ2omQlDGY0QNcX
	mZIbcod56pyepzPQVD79CNbNMEXXPZ8NRD0c9zV87iFyk+FoojCfWP4zmye5ccW4BYMTKFl
X-Google-Smtp-Source: AGHT+IG1uK5T0BBOLdAKplctlgz9+htwXet9zUm1yTzPSsHNKNaIyYhluNQ20EMsH/tIllKmvytz7L4txNlac1Ca14I=
X-Received: by 2002:a53:b205:0:b0:644:6520:eadc with SMTP id
 956f58d0204a3-6455564e8a4mr5823439d50.50.1765813455238; Mon, 15 Dec 2025
 07:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128052011.204735-1-avri.altman@sandisk.com>
In-Reply-To: <20251128052011.204735-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:43:34 +0100
X-Gm-Features: AQt7F2qn-ts1UtRQg5C9q5KFtRNe8QQGyZlUWTb20p_ylXQQmaJqR_8VpbxJ9Pg
Message-ID: <CAPDyKFpshnLSa+GNOpFdQ6_Kc2ov_jofq56eq7WsqZMRVYs-NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
To: Avri Altman <avri.altman@gmail.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 06:20, Avri Altman <avri.altman@gmail.com> wrote:
>
> Hi Ulf,
>
> This patch series addresses the upcoming exhaustion of the eMMC
> manufacturing date (MDT) year field, which is limited to a 4-bit value
> in the CID register. Under the current standard (EXT_CSD_REV=8), the
> representable years end in 2025.
>
> The first patch implements the recently approved JEDEC standard update
> for EXT_CSD_REV=9. This update rolls over the 4-bit year codes to cover
> a new 16-year period, extending the range up to 2038.
>
> The second patch introduces a quirk to handle vendor-specific behavior.
> Some eMMC vendors are not yet updating their devices to EXT_CSD_REV=9
> but still need to report manufacturing dates for 2026 and beyond. These
> devices re-purpose the year codes for 2010-2012 to represent 2026-2028.
>
> Thanks,
> Avri
>
> ---
> Changes in v2:
> - move the fixup to `mmc_ext_csd_fixups`
> - State the correct spec release
> - Fixed a typo in the commit message of the second patch.
> ---
>
> Avri Altman (2):
>   mmc: core: Adjust MDT beyond 2025
>   mmc: core: Add quirk for incorrect manufacturing date
>
>  drivers/mmc/core/card.h   |  6 ++++++
>  drivers/mmc/core/mmc.c    | 12 ++++++++++++
>  drivers/mmc/core/quirks.h |  3 +++
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 22 insertions(+)
>
> --
> 2.34.1
>

I have applied the series for next, thanks!

However, I noticed that the author of the patch has your gmail-address
and the sob has your sandisk-address. I guess we should change to your
sandisk-address to be in both places, no?

Kind regards
Uffe
