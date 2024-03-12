Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CD79B75
	for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243023; cv=none; b=ooa1aMwnHd68M6TBQebhw6boXHuvV3iGYHz+kMEQLdeDbG6BmQ1YQ5iIZVyE7mbAZiBhHbCm4p2k2KHlHoviq//lKZ7kxAtylXpZKKHQWkqaOg7fm3Wq87HW3CKxQwsaZZVRdObj7iRbam+malE44vQgICwbBGWV52F294EWZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243023; c=relaxed/simple;
	bh=l2WdSNUP4K3SIKsekSGXnuJXGSgpdVPTEVsLPobE8NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmX2XiQrbOYlDH5lk+irsRTMTcOmk4sqDYa9h2+phCwUDfG+86fvvxX+WmJEvqd2QYIDwZfH9VKLFFwj9wNiUaUGeUZcIoPnhmYnTgCwy1XgcElKFiX3hTU7Tl1PdcCr/L3MXYROn2baJtw4RZgDnECEq8ObxkhP6bUbm5l/kxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suy3Kme3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suy3Kme3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso4388776a12.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2024 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710243018; x=1710847818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CupxoLbqDAw0iGT/Dkpjp3a8L1C7qew16mx6r26LNOI=;
        b=suy3Kme3GoTwvuDvCo7FxdJ4a+X0G2nZQEYnirOqW84ejLh0FNsdIG/IdeyWsJwlFX
         D7PNR2xUj0GR783+HAHnN7+hHCRMgjBIInIpLdwnMdGTyCIy0biLlg9ycPQ+C9pTbhG7
         cRMhWL7iAUiWrhJNIC/aM7XMio4TxArzO1LvhDAQfOmTE+tcf3g7e89yzg3Kk6ileFgn
         fuchibVdIeFlJ0GcoP/jE8/vPo2mWCd5eaR38R7eyGJ2WJFoJpRxt3tD2PLWHrjjJeHY
         m4CIB/9GbXBcjcCJq4JQpGegS15S67nS7e58TjUSuj8Ft/+fg2noDGObneizeWuQ/uK/
         INoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710243018; x=1710847818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CupxoLbqDAw0iGT/Dkpjp3a8L1C7qew16mx6r26LNOI=;
        b=QgIxaYxqk0u0yqLLx7VLeKpSE9SMr3+uyQZNeWKKeSrxGwon4dLfI/xiPVe+PVazHw
         citvHsps3G5xkZCFhuBvTMq1gUHcPL0ZLQCtZEEcDNpSGwWRF0ooAnQnWz+u/TlUouQs
         ThMamaPKLQlKBtQ30nf+MBpkRiHpzNMg4hvBihQ6ls1QRuBsXTiDxjUFcb2TfrdY/3jW
         XSPJlmdJaMWG3E9VrKhGUkeXypWVT4q/n9x6EXxVjAz8PQAUpDu2+S7Gn+3YtQJrMc0q
         xKSP98c2uT4nayBrN6TX7KAGeE+zHrK6k8NkwiA2Dq8TVUmGuuUOCudvJwfckDck4xyN
         4bnw==
X-Forwarded-Encrypted: i=1; AJvYcCV9KTqVs1IoxeIAiGN64YMTOJbAmHc/5cWpUqxXGLIam8oKbQWQUdHcQz5Dtd5pbPTUaqgKfyv69AeE7dfqYEbY9SM7FNcBBJJ0
X-Gm-Message-State: AOJu0Yxl/IO5vCVlTMBHAQH9s1C1Se6eQ27T5McGbNAbIPnHzEYbHsyX
	rExlt8JmUqZUrPzV7D6QSkpp5/ZCZPwaf/tT3y4qnqgnqXjbHmildr6clotU9UnxBv40ORBCmxe
	/XSt3upcG2wybdR/Zlv7ITfxBf0NMgYHfQWEsYQ==
X-Google-Smtp-Source: AGHT+IFHD9Ak/IwOC1zEHFPh2Kddo7eOh7ziL0ulLzgGW/R32C6TAxkb/xc28APd4ASLmM4PwNUPmk3IAYvFtC5rG5o=
X-Received: by 2002:a50:9e24:0:b0:565:1460:8447 with SMTP id
 z33-20020a509e24000000b0056514608447mr1438863ede.28.1710243018038; Tue, 12
 Mar 2024 04:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085135.16245-1-amishin@t-argos.ru> <CAPDyKFoYRT=P+4L+5ciNPxEHcS7hoXPef__NQoodxkSy=39Teg@mail.gmail.com>
 <98dea36b-41dc-4d2e-aec6-56c849e1d58b@t-argos.ru>
In-Reply-To: <98dea36b-41dc-4d2e-aec6-56c849e1d58b@t-argos.ru>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Mar 2024 12:29:40 +0100
Message-ID: <CAPDyKFrJmoHA+HsfdC_VjJpah=8Pqi1zGbj0oABMn01go7CrbA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Wen Zhiwei <wenzhiwei@kylinos.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 20:07, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>
>
>
> 07.03.2024 13:57, Ulf Hansson wrote:
> > On Thu, 7 Mar 2024 at 09:53, Aleksandr Mishin <amishin@t-argos.ru> wrote:
> >>
> >> In dw_mci_runtime_resume() 'host->slot' could be null, but check is not cover all corresponding code.
> >> Fix this bug by changing check place.
> >
> > In fact host->slot can never be NULL in dw_mci_runtime_resume() or in
> > dw_mci_runtime_suspend().
> >
> > A better fix would thus be to remove the redundant checks.
> >
> > Kind regards
> > Uffe
> >
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Fixes: 4a835afd808a (mmc: dw_mmc: Fix potential null pointer risk)
> >> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> >> ---
> >>   drivers/mmc/host/dw_mmc.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index 829af2c98a44..a4f124452abc 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -3570,8 +3570,10 @@ int dw_mci_runtime_resume(struct device *dev)
> >>                     DW_MCI_ERROR_FLAGS);
> >>          mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> >>
> >> +       if (!host->slot)
> >> +               goto err;
> >>
> >> -       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >> +       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >>                  dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
> >>
> >>          /* Force setup bus to guarantee available clock output */
> >> --
> >> 2.30.2
> >>
> >>
> >
>
> At the same time there are few checks such as "if (host->slot)" in
> dw_mci_runtime_resume() and commit
> 4a835afd808a3dbbac44bb399a902b822dc7445c message contains: "we
> previously assumed 'host->slot' could be null, null pointer judgment
> should be added" and replaces "if (host->slot->mmc->pm_flags &
> MMC_PM_KEEP_POWER)" with "if (host->slot && host->slot->mmc->pm_flags &
> MMC_PM_KEEP_POWER)"
> So where is the truth?

It looks to me that the runtime PM callbacks are prevented from being
called, unless we have a host->slot assigned.

Just adding checks because it looks like the code could need it, isn't
always the correct thing to do. I would rather try to remove the
checks altogether and give it some tests to see how it plays.

Kind regards
Uffe
