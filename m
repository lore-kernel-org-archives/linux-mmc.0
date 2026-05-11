Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC80402426
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514025; cv=pass; b=WYL3FqtNDMlCstHI65YjD3npyKd8bdXVfqN6XWVO5EetDv8LoOMmgEL8IBaJ7R5PpAT8iFZNsA+trDpWzSCVHR3NxEWJvSD2ZHp+l6wv3GF48kOgvrNQb3UnjkN42V6Eabu28ksQJDVq0HPWhKMuUCZQyzAB1lk+GYykaBirdgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514025; c=relaxed/simple;
	bh=S8/rBkZ/4qHgBEDhTDChyj/eLk+EKq3p+KYE1hfy8qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBuweBbe0GisGibK7iRBFnlrqf+bjahMe8BIKjXpZxiUDsx0wbtDEj1zOvZzMTtJJNXNhOJcw8HgCXJfzWf4X19uPdy0u+xO8TM9TpIK8i20h6Tk/6oy+lwtpSmk8/Bb+Y4qG5oPv4q80zMEBQpg0zuZYUkqn29CFzFe5IlcNHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gyY0KYdA; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyY0KYdA"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8891febd2so5223533e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514020; cv=none;
        d=google.com; s=arc-20240605;
        b=JHZnJttl58tbTkkIBk2o5hdKaWdeq1+MUZ6vOLaXwnl3gE/MaJigNCfMi+3/pGGxQ6
         Ie8jeeHAVrKX73PWMKyBLcyVI4/MTrCAvTpTDLuWgyVhEie2RqmLcF36EybIbK8mhiA6
         HDC05e6tylD9u6w1wDCEUbNojgGQL316S1lXJpcNwakOnINqP3S66orcbOhH3Ku7oG49
         T7/b0eAKJ+bLcX+CuqnkyWa3vDi0j4brQiFLdA+915+Jpv4F90Ddr8Q5g7iXdLa/P7fh
         h9xVq3LCOCVvwvwmbaG63WzR/RBJDh4Lp4lD/ZWONWNYPb2KtOE7V1QwQU1zUmu6n2hF
         JxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oJDpp87U3qP1/ZdloAL0g1B0PkMAMnaCHXe9tWClupk=;
        fh=EqW5nGHfXV+Be0mQXHHg3vz1zDJsViW5T2ltHRlRSu4=;
        b=d2FuR5ai29RKuQvVwUIrjtwrKwWQ1g9TjejBLj5jyNJpqdOMN4xvRg8oQOTHrlE+A2
         gUn7G2TApZ5G2o5DFiacmHZ3F/zNUTMoacoGYb97dSikS4bMvAsq5z9kCt2GV5E4TzfJ
         wPRlvUSrTRFMUs12KeRQ02u030g6FxC1I7S0QwqrXVCMMtXaS1QDQVdlMf9vAIlyjVM6
         xaMZ6L3H+ZcqAa+/PqRxaGd2g1FVbgGziYOjmyvAGJktMgYnV1Z902d350xTiKl5Jg5g
         PV5DmU2v9GhXl7AvSX9rhUCFTm0DpB7Tfk7FMAHTy/V7spaDCJL1Plyr3olzEuMI/Ldr
         93Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514020; x=1779118820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJDpp87U3qP1/ZdloAL0g1B0PkMAMnaCHXe9tWClupk=;
        b=gyY0KYdAqN219bmzjwITNSoVfLjX+50R7cJAtejXSJoFkJhqGUPPDLTRJLB7JS+nte
         oaoWd5c6lDNUFkpE1Pb/yD8z/W0/BbpQ3poJXyMIGWtvV4LD8AIkxp7zXaCtF7KPYiuF
         glMPLjHlz9HkiRvhVweEy06NDseUyGLGugO9fDS5PGadG4sMLIgDjF85RcWSLV9J6XRt
         7nbCahFnvXWf9o9uB/lKnCVwRwIK4CLKVhA2Wvvm8zIKJGTtqnpdJdGnvnaIBfWjGYrc
         KutrROy6goyxe57YaGtuMMHlQ5BZUtGTYQ2hP/nb8ySmApvjl/2EHmut0J/oFNj2uMii
         Y8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514020; x=1779118820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJDpp87U3qP1/ZdloAL0g1B0PkMAMnaCHXe9tWClupk=;
        b=G1ocec/YGIG/50+sGDnPqXeJeS4fqVKiOSpzuvrmyURb+/haTUlw3rlZt01RpTNXJX
         sGIjY83Pzlx/RoNELDdK66z7ZMBkVMD6fVED1o0ZEdZAfT7hinY9cVLODH0FnOSQxRug
         9XxB/PaBHdY/kvifKCVHKwSBtbtZ0B+tDy5Dv14Edc9Dle640dDphGXJhgja2V1vaAhB
         V5r5b1dLlRfdsL/hTKNDyVGJ1oElWWS/JSg/6oPbFBevAItaNswe/fda8ZG2bdLsnDGm
         w5Lt5i1N2zoZ1j0emUG5P7xFtJebJpsLXrF9EHlRT1ufBufrmV4W2KOtYiVTREKKEyE3
         ToxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Z5BE8a+bTSprIUrs5Zy6XTwQeepdYr06yhjFWGX2gM/eBaHqo01YAJxccCFtUO5Wh+z2GEHJ5oi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLlDhAq1HeK65dt65oKhjWXL5eYhDUBiL8equJkc7LrGEZ1LZ
	0tZ6xv4BDrTxjFLRjiYlWkRk6DHs/vVNisyVW8MhP1UaG0+Vl6n16QAb6pkHnnl/L1760dTxMzK
	Ry9K/fvL+LIaHIlDYpVEttxgyFZmyDrU0nUGglSasfQ==
X-Gm-Gg: Acq92OHsnXCW1Zem8Yit7DruZb+3n4jORsO/lToGLqYWAVigFH0Ax23cPghQHSy8Njk
	/DlbtfvMYddHKOhpyvg8Sq6ff7dgPBy0+bdtZwQmheFjUKX2w/fmTlbM1eWm9HiKHdN4TEZ1HS7
	QBIthOXdsoSwAODDFV3BwLRhm0Y80XMgCPWAefu01Z8U+u6IHlhRAxJ42d9iFzy4JNE94aw92Q4
	suMUhawde65toisVgANJ9xVc3qXZABLSklBWiWhKWE8w+9uWh+r4mgFQetKntzimJRoJjBh7AOV
	WMad5ykq
X-Received: by 2002:a05:6512:114e:b0:5a8:9b8c:96e0 with SMTP id
 2adb3069b0e04-5a89b8c9738mr6839780e87.25.1778514019474; Mon, 11 May 2026
 08:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:40 +0200
X-Gm-Features: AVHnY4JBPCzkZwSzFDJ7ZPq0FDuUgtck_opAyj3KzG9EF6Q6lmD-f4c2EYe-ClI
Message-ID: <CAPDyKFpvRMW=gMHqmqXk+fdT+YggqjxcRB2MS1uxT06n-PbVHA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Refactoring to support per-instance configurable max
 segments for dw_mmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 09:48, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> The first patch is a defensive fix that addresses a crash caused by
> incorrect max segment numbers provided by host drivers. Patches 2
> through 4 then perform a step-by-step refactoring of the dw_mmc
> code to support per-instance configurable max segments, which host
> drivers can utilize in the future.
>
>
>
> Shawn Lin (4):
>   mmc: core: mmc: core: Add validation for host-provided max_segs
>   mmc: dw_mmc: Move misplaced comment
>   mmc: dw_mmc: Add desc_num field for clarity
>   mmc: dw_mmc: Convert descriptor ring buffer to per-instance
>     configurable
>
>  drivers/mmc/core/queue.c  |  8 +++++++-
>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++--------------
>  drivers/mmc/host/dw_mmc.h |  4 +++-
>  3 files changed, 23 insertions(+), 16 deletions(-)
>
> --
> 2.7.4
>

Patch 1 and 2 applied for next, thanks!

Kind regards
Uffe
