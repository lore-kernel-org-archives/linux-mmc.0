Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B513D6478
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364282; cv=pass; b=EvscUbKAC9bIfZeCwjMUGmlOI1KTUOsmY+hYqA0DmIpu/Ldxovva2xyCH1UCjP7jocygDI9IRESVW0crwfJ3soVUtAlw8/KmRIwlrHeF//nNBhRo5jtdMqLpYq+o+kKae/NUCbC/JDjSw8bJQ85UvEqZMHovF52Ms68AQzHnke8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364282; c=relaxed/simple;
	bh=6xljpOJUIZOjxqkc8IsQtg/dDMs5h0JMsZuQ2r9xges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaOJbYcoUB/BwZRhTxknNZ566Th6Tese2yJQ9qQutMYzIQSm5C+9i2td0GAuQObDPC21HvQK3UjRfGFY41ifFmOkSScJzbNNWj3wMJxtKHq6wApMkLgPcBPiNVaI2KWqwAXQigAaitV3WPXuKPSmB/hM64p92nRiNj/NYB4sasg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ownxWEHE; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ownxWEHE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59dea72099eso5010667e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 07:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364279; cv=none;
        d=google.com; s=arc-20240605;
        b=CzZoaaOm7ucZ+RNQZ9DyM/sVj6cXfZDfG0g2DQ8677eA0ebfMP65GXRPl4FLhVyeZF
         vO9XEGajbaepO0WPI0YoKMzOBk8u/0pbGh8lFs3sb02josKLJtqYpC9ZikHaYgLUg4Tw
         MMaJ7iwIp9uWoPVgoSXMl3Xd0LnMBU0Vjw3T+eX6gGji4lTGHIDUWh3dgeS2Lsjr19un
         Pj4ht4bdArNK60Z0mi7R3L0o9Qz/ewIOsuAeN2jOi9XBlX4c+92GYWBN27+zttVkztg7
         p6OTD+E01+EGEn9sZEgokRgBi9RGSRtWTZJScG7FrMmKPbbB5VbII0tt7Mjqhk+KmRQl
         WaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        fh=9cxCTWw4sdQvVefOtgO/YL6S6CMB5xB0vUt95ZWgyCs=;
        b=YMm1MV6Z/66zTsCT6yJMFfnTgmvxzMxnlMfmO9aWuniVe3O9rlYqX4EI7pjv57r8s0
         cYYfKAai2AUmqsNnFQ2pXnic7gYbiSit8X+L3obDOo6wJru6/zOkM9Cd//X8U9byFqo6
         gVmEx34Zi+Reba/idaOB4GCEzNbdP4k2aai0B4rll2eSekGG95zcwxANFFgB54mHZ0z1
         BbE2vLYr9r6TI9CkleFCuB+lQ+3dJUIg5D0RaQqxqsfNtFhX1EXq/FxL3Ur5/vGnmNEh
         NI0N4wzocROF7oA1nerRiQwxGS4fimwHLkJf1K5CKBstAX+dQzf1Y7vDFPve1+AyzEaW
         AbTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774364279; x=1774969079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        b=ownxWEHEYYC2jomQTGrwaJXdMgBuFy9zPJHCyk0ZOaVZ7KBxtoCkQi5lcEgK0Zow+y
         gDDdZD0pxLTd1WHB509FfsI0Le28Gq62YegpDITmR/WEc3dTsl5YXqIHorXXuPpmEQ91
         p2tohFk66GYqeWchk5uaA38ZjV4WfcjgBn+QTXcpVnAUlG2MxMuWOwjnmacgqU4kmEA0
         F1HGP/4k3lRGUjCU1xbeNV9ZohHu3RNWNJ5fqnW/XKfi/SZPknR/rz+wvl/8d9Ma44Y/
         1pC4Harh84vFo9O570h8oUMoBSTapUUH5ktajQEAsEoXHFYJsgkMZXhrtt+YxSrLDp9K
         0WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364279; x=1774969079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+/JT4EIQokEZ3mYpEqQ0slSjAC+QW8qaLJ/zLQY22Y=;
        b=N7n8iYSatzN5XQLOIw33MX0/c7SyCCOXx3tWMtDbu3KjWbspm8T7hjpZEObkfB7xJ8
         VNctP4b6A2KcOBfXFvu44AOUa2hxns+iASDSVvbZ8s6YzYN6PLCoBdUCa5ehVOH5Z+nY
         HQuyIdB842jff25yOKJ0jrf1Yi9BTW9KqcAMTea21woEGhcrpiiOPHQ5KSIegjLC/dxb
         TAszTyJX60KBrSg9FvNLQ4EIsuXdVitzV+jYFACGcgz7DB1q7byxroemo6Z9V0Sh3ERA
         nvzRfDj/dNexmFbuYP60aHEiFQKPZFuZdv7JJb0nGAj+O/Eho7oNLU/Yx+CHbKEXW3tX
         qyXA==
X-Forwarded-Encrypted: i=1; AJvYcCU+WUqyV/A2ewFnQbov0VuvA6/WtnVS8T5wL8BAMcYSVW+LBLdok+5Zp1mr3uDdwmZpUp4JuPLA1Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5INu4bTJEY7SFwLvoQSvllPQXwLmyGNdP+a6Ny5PO3uZTeQv
	3y5r4YRIQu7b5ccdq0U3ZwAV2eZps8YYlqgcEM/rbBWwO0p/cA1wW9oYGQNW+woR64Mq4EkTFvL
	WL0EpqyJzRRIleKM82Vb4UDPStQcNA/wI3ya4Q3CpwQ==
X-Gm-Gg: ATEYQzxL1vozert8CllYjz2H3dHS9dGutlVBwYayRDSuR73TssaCfaN669+o5GozFRw
	L986LV0bPdFng0iLwQ7smpz9rd7WbkQYB1Ki7drSoS3kK1X51natgZGfeEVA2noa5mj3u0VeJng
	FK9cR7G/RN+XWt+t8KNbMRT2JTwctISjM+BVo0lH25j8QiYMVjU25QhUNCJk29B7eLWJ4YGr/rx
	F0hNw8g22gqBvt+m2NI2ruEguKm0OfQlQoMGSkIjpSaW20H5n0zk6YQvpQMKzjmuWQRj+NVspXg
	7yWOX0iCA4xFsaCemRo=
X-Received: by 2002:a05:6512:3501:b0:5a1:42c9:d978 with SMTP id
 2adb3069b0e04-5a285af967cmr5754009e87.1.1774364279081; Tue, 24 Mar 2026
 07:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com> <20260324143448.2631888-1-b-liu@ti.com>
In-Reply-To: <20260324143448.2631888-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 15:57:22 +0100
X-Gm-Features: AQROBzBoKLSC5g41HZ9oD8gxep-eNNKjSY-hwFAbhml6t5GCMNqJZlpxQ2HWs0k
Message-ID: <CAPDyKFo5h57uiym=WuKBLji-VwcDtCiCBu434RpmZdYTWzSm_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: block: use single block write in retry
To: axboe@kernel.dk
Cc: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 15:34, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> With i2493, the MMC interface has the potential of write failures when
> issuing multi-block writes operating in HS200 mode with excessive IO
> supply noise.
>
> While the errata provides guidance in hardware design and layout to
> minimize the IO supply noise, in theory the write failure cannot be
> resolved in hardware. The software solution to ensure the data integrity
> is to add minimum 5us delay between block writes. Single-block write is
> the practical way to introduce the delay.
>
> This patch set reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> link to v1:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u
>
> [0] https://www.ti.com/lit/pdf/sprz582
> Signed-off-by: Bin Liu <b-liu@ti.com>
>
> Bin Liu (2):
>   block: define new rqf_flags RQF_XFER_SINGLE_BLK
>   mmc: block: use single block write in retry
>
>  block/blk-mq-debugfs.c   |  1 +
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  include/linux/blk-mq.h   |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>

Jens, if you think this approach is okay, feel free to take the series
via your tree. Or if you prefer me to handle it, please let me know.

For the series:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
