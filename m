Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4C3A0B23
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674156; cv=pass; b=hOv13JQBrAeWEHaTYXBOOCPr35g7tR8gdxBbeEPrGAxbOL26QcxoLyjF+fa4y96QQU4EXeDeOBc921kFxEr/8JsJR3Uy02Tv1agbczOMU3Zhuh33VcEwz9g49FqWO0MBkmdfRrLBXZLTmOj21RNY8VxHYNo5GwPukyz11VUP9K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674156; c=relaxed/simple;
	bh=adhh3tqlHS4Ze/OS8K6K5wX807pJ3adi6K6Am+V0qE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abw4ezn7zeE6ogtrweOPNS1eoTfpCHhooE7cwYok2/odDl4h9FuU+01ebkuL0PeXIlYUWPT3UsJ5wZavx7GOTHd8sywgLr4nqYRQFCU0soPnrFKR8pypPuvUN/ID5FTWgVtT8inTEuDuWVAMhQPj571vlUPw3T8lXCgJa7pCQxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZG19aK+H; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZG19aK+H"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a153f2dff1so4632784e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674153; cv=none;
        d=google.com; s=arc-20240605;
        b=BWK96nSwUCqF34TCydeK1mJczKTT/hm9hz5aou9aBCGIXD5N8I0mk+0x1GXk/vzcw0
         oRL0dPWoQyoBXpVdQ0Dx4OU4wK3D7H/AcJbFIv+YOgxHcBCPQLYsQ3XCiYD1WFCRvBAw
         PeWZjCGPvvrSrPfGu/aDZD8ZQtZOb/fgNThgPNazVriyV+IQdoLSjNNaxbBm2PIJ6qyl
         JN8YDCM4BbOgOm4aihMvDqrbxlrYGBESYQKMXXZpw/eUk21i5RLahQ+oTkzC+N6dwWoZ
         EjFwIgeYEbVyPaeyqWPTWj3XrW1iRDKS7AX6dDgIXNzk1bG1cejU2zHsLyLaG+lMNaCV
         IX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LqHFA8ezpiqlalV4mlS5Ns4Uk9hJm+DS0/y0X5Bc/n4=;
        fh=j9Ob0U+wANaqcnp1yKZD45ewqCz0NF72k10mjNlDFP0=;
        b=b21VuR7SItR3+zFzDmNN5LeYDPBxrifxBppEiifm2fQaKxwrfSigeRHPDwaiw4tbmv
         gwHVjKeSMJfy3hf5lU4K4IbwRbPnomGVqm3mRa0lAZPBYtq7U7Am4BdTu/OPAaaL3Awg
         +ryqODd9S6k/gFNsJx45fOIu+OuM5KkZ5L0vNeSTPv3fZnEFn88NIRw9fBe4zBuexTgr
         Ay4R9YTxaXwTq7PUvf7QBGGaCyAn8bmhBqmm0A8CpRRWRc5GBWS3lrVB5vSyiVAkSulj
         PzvKIJDjfiGVnoDl354DMGbbnwEHLa8SQ2AtEiXwXLASWPiq8Fqec5IeGHnHNJVleRQQ
         PhTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674153; x=1774278953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqHFA8ezpiqlalV4mlS5Ns4Uk9hJm+DS0/y0X5Bc/n4=;
        b=ZG19aK+HTYVlpGFt/2YMozQus9IGWnKcfBgjg9s/mK5KuvrIhzWk2/VDgDgJV03e/+
         FXT2T2mltPUQtik09U7y4giKiNITH96js8li4fZD0jo2uawUQLCUMc1B74/JQt0PEDD2
         dsz2QGOjuuUIu52rGYodurocfjHvyQBqOqFgKniXsXmdVxisZaUgCd7WQ5/84nrK41z5
         w79izJzWVhB9C7vW29ms8jkA0LlJF9wW2T6QwSeyMp8qKwu8vR3fYFHrWVNSF0+FCyKc
         PZHIyjFdcKIGM+Pa6oz0DQKCmTzUzb44h6WJNYGTzGGS9U2h1jhjfsEviJzdqhrCDTeI
         2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674153; x=1774278953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqHFA8ezpiqlalV4mlS5Ns4Uk9hJm+DS0/y0X5Bc/n4=;
        b=szmhl196RsBWFcq1hWv2VYq74uqTAgnmh5JgjU4TIkMwwSU0SzqDEEOrUMv0VfpN3Z
         K5CXA+Lp5LfxhHp8HbQvZ2H+bmn+keGYgmPkZtGT7zSDwb8qq2E8jIBfmdog/k0wqNxr
         Sg98B3Bs4+cgJYOUyHOYCvLBzvJ4e3QOQ2XfaUT5dK16roUdgsq56Y1UDignpZ+OcF6V
         Sn5U3oGN6dNg8MrccwfxxdLM7FJpDrq8zyl3v9oS9f88Pu/5DZAkFbMXv/3IBj0HNzi/
         /pLGl70oLPdiqB665qX3x0h2DxcgkGBfptDjPFZ+4VJpxE7ixS5N8Okp/U1pQLLbNV3H
         Q27A==
X-Forwarded-Encrypted: i=1; AJvYcCWvTLU9ogj7MjTs3L0K51E/l55uCk55XBhInUojcaIi3fCeZkjQhBSKYYNMW63nbeH7kuHfweVARxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIgm56AWxWu0OykcVapmmXdbYCk0N3bxgU9sL2PnqFcGq2Xq9
	aISn8zi0PiL58jnuoxbSrfCMW7mftG2L55xyLVPXtLC59dMUKo6zFeUDqYRH10vwFmASrW6cBl0
	4MDqeBs6KsJlMx/uF5jm8ACUT/qK/Ggqlj7j2c5CT+vKxORjJ1XUlvCU=
X-Gm-Gg: ATEYQzyDIxoBfCzxWD0GtM3n3Jt7duKMkrtVfrctURxLSzP+HCTlN+7VeDrmODlOqne
	mXh9w1/xYPSaGdt5Smlha5UZa00nWWhmbRERa0T2rHI08aN3AyK4XFWZE/nTaevyhBoIYXUovb1
	IZOQL6mRzPLcDnDJEElOv8e0qnfp3+nq8HJ+9+Q5tbe44WRR2y9maGAXi/3m7kOxuz5QOTkqlc3
	OHnpZoGwXf2q9ADlFMNkQd7TLVbRXixzi2GKsqAigtBKjJBTdbpLVsL4v9dKk2B+Z94zl29iJcT
	SAuYENE+
X-Received: by 2002:a05:6512:3786:10b0:5a1:5994:2773 with SMTP id
 2adb3069b0e04-5a162668c3fmr3597222e87.14.1773674153033; Mon, 16 Mar 2026
 08:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:16 +0100
X-Gm-Features: AaiRm51ROAc5PVIT4fZKKt2_UCIWlTSjB2cm-yra15BjSZUgNMXbRf49SImO_44
Message-ID: <CAPDyKFqqbR0ir3Ja4mMXxOveKQUwaeSMSDtqnhUuS=iriWRzjg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add phase map support in dw_mmc-rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 04:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> Hi Ulf and Jeahoon,
>
> Currently, in dw_mmc-rockchip, the rockchip,default-sample-phase is only used
> for some lower speed sampling, while the output-phase configurations are fixed
> based on timing settings for all SoCs and boards.
>
> Subsequent validation shows that this approach fails to achieve optimal timing
> performance on many chips and development boards, failing to meet test requirements.
> Since different timing profiles demand distinct phase configurations, we introduce
> phase map support to dw_mmc-rockchip to address this issue.
>
> Additionally, given that dw_mmc-hi3798mv200 already utilizes phase map functionality,
> we avoid reinventing the wheel by moving the phase map parsing logic into the core
> dw_mmc framework (similar to how mmc_of_parse() is implemented), rather than duplicating
> code in the rockchip driver.
>
> This change maintains backward compatibility: the original default_sample_phase and fixed
> drv phase configurations for different modes are preserved, with phase map values taking
> precedence when configured.
>
>
>
> Shawn Lin (3):
>   mmc: dw_mmc: Add parsing mmc_clk_phase_map support
>   mmc: dw_mmc-hi3798mv200: Using phase map from dw_mmc core
>   mmc: dw_mmc-rockchip: Add phase map support
>
>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 11 ++++-------
>  drivers/mmc/host/dw_mmc-rockchip.c    | 27 ++++++++++++++++++---------
>  drivers/mmc/host/dw_mmc.c             |  2 ++
>  drivers/mmc/host/dw_mmc.h             |  2 ++
>  4 files changed, 26 insertions(+), 16 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
