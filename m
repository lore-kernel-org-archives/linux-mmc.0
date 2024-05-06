Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF611422C5
	for <linux-mmc@vger.kernel.org>; Mon,  6 May 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989228; cv=none; b=DgjWXA5gS1vqh3zdEAonKwuswccC3OuWdH0GS7wJqMRHbYafIZ9EV9DV98bTxsJWQ9vhYQvA3+wl8LpV55I5GKmF6YzB9zWufhdXsL95mpbTvqNBglOJiGKzs8LolpDAAoNJvjeU8Wk6uw7VgRyN6cg/EC8+h70Kd5t3yS4Mq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989228; c=relaxed/simple;
	bh=TrHiwaOow+WkdUNx7tpNbdeY254y3iiLN05rNZRZGak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2q3VrEaHHdTVSx+Ro4+uou2GRVoEMxX8AmvS5lW6DIcDTV5NtIf1hcednUqawbyWc4kbLKIQjOeBJVTMyxBppwjhyVMpxMB++FSBxqeYnyQI/0c2rQypZ0uR8B1PruMfOS+FuwAy4wlkyE1I6VPZq9o5x1HGemzW1dsHqguo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrW4bSqS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrW4bSqS"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de60380c04aso2047261276.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2024 02:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714989226; x=1715594026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QAxLpV8Ulm6XSkEM6iEN9trdiWGUMcTKbu/e6WBDXs=;
        b=OrW4bSqSKOVoBGO6L5MsL6HY+yh6yJmqs/cjK58QUerqB4hzxqBAVhqLl07ut3d4a7
         wjU5QJyEEY9sBM8/PA2BewDFXXWT/Fs5JOGe3KTkoGRctugksZaGZ398JaOoR/D8+IZT
         FvHIalPbhGa0bANDbBUDj3s7nWIZk70L8XPniTlbuMOH8VNcRg7BktFxxNbG74tE2Cxt
         dMfFXkHTELj4voD4C8fWqSBSdtvcA+eCW+rj07mXULQ0N2Fg58P/Jw2H3JREC2rPWVSn
         JvLlxFRz/7AfACRQ2tV8ulGwPw4yDzJAme7t8MFqU6oin/G1y01HEkFYUbpR6KF9x98a
         8vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989226; x=1715594026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QAxLpV8Ulm6XSkEM6iEN9trdiWGUMcTKbu/e6WBDXs=;
        b=Hp30tn1yd+FwMv9UE0jaxk6Pht4nPnEnG+BOlHzMBkd/z3j5C6CtEVmU6Z8XPbgEYV
         1pudmzDII5BCFZZwFttFzfeMS1ZRr3lQKyQEWsc1AO1crONWii6AGfPHIuPJIPVWl90k
         Cq3J/ec1KqlI84GQjf8vM7//VRThaS5tQsdBGlvJjCeXHjwh5PMUcGvB+r8wn98bdLxD
         0VbdrDmD5J+H6GRG+DHTZiAP8UijYkcqpLA2+qysgDoBhdGKugj6MplkTmfbmIIRZ/GX
         Oudr+Awvm09ivFob0K6Kjup02StwremQC4hjMgzgyO/uxgyxcnkV53fABxxJy5RgIwDs
         42Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXFIUAZbuXQ3Ny6MymnWmaN1S7GsmUtJDcEwJHAZ8USpqhxWEMP3H6JzWJYU0UNwutGukTe6EJgW9mHJhfRJDjysSc2tmom75Nq
X-Gm-Message-State: AOJu0YzEv3MP7KUm8DBbX7iG5bMijGxuthTESlbLvbSlIxrtTCkOIBYO
	SVpnfpP/cJDrLih+fFMJh/QKemsyqExuLvfVFicaos1qxUjK/mLES975hOhroaewGLCxI8XBP+S
	SLjkiMMvHs0q1obqw2h8KDm56YbIJ9+eT1OBb4Q==
X-Google-Smtp-Source: AGHT+IGSwWq3kcMhDPYwLGMvb2VmZpLlIPgu2aLzNR6aw7HDS8bxYfuqGRSKESVoTayXVIVa/xKszOolJjH7jDjlksc=
X-Received: by 2002:a25:910:0:b0:de6:dcd:20ae with SMTP id 16-20020a250910000000b00de60dcd20aemr9515456ybj.27.1714989226469;
 Mon, 06 May 2024 02:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFoB+r7KMdbV-svz9d=WdPm1Zvd6oZppzbsPDWqX7YN_Kw@mail.gmail.com>
 <20240506033644.10538-1-Joe.Zhou@mediatek.com>
In-Reply-To: <20240506033644.10538-1-Joe.Zhou@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 May 2024 11:53:10 +0200
Message-ID: <CAPDyKFrAp5SHL32LkZZA_nXekSa0HVVW2nQzMi9aOPnd90+N5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: race condition between "sdcard hot plug out" and
 "system reboot"
To: "Joe.Zhou" <Joe.Zhou@mediatek.com>
Cc: Peng.Zhou@mediatek.com, Sharp.Xia@mediatek.com, Sophie.Wang@mediatek.com, 
	Wey.Zhang@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-mmc@vger.kernel.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 05:36, Joe.Zhou <Joe.Zhou@mediatek.com> wrote:
>
> From: Joe Zhou <Joe.Zhou@mediatek.com>
>
> > Thanks for your patch!
>
> > Doesn't commit 66c915d09b94 ("mmc: core: Disable card detect during
> > shutdown") take care of this problem?
>
> > Kind regards
> > Uffe
>
>
> Dear Ulf,
>      Thank you for your replay!
>
>      I think that commit66c915d09b94 ("mmc: core: Disable card detect during shutdown") doesn't reslove this issue.
>      1. Issues may asise in the following processing.
>      sdcard hot pulg out:                                  SyS_reboot:
>      CPU0                                                  CPU1
>      _mmc_detect_change() {
>      ......
>      mmc_schedule_delayed_work(&host->detect, delay)
>      #Step1: call delay work &host->detect
>          mmc_rescan()
>          {
>           .......
>               #Step2: detect SD card removed
>               mmc_sd_detect() {                              ......
>                                                              _mmc_stop_host (.pre_shutdown)
>                                                             {
>               ......                                        #Step3:_mmc_stop_host() cancel detect use sync
>                                                             cancel_delayed_work_sync(&host->detect)
>                                                             #Step4: wait delay work complete
>                                                             }
>                  if (err) {
>                  #Step5: host->card is NULL
>                  mmc_sd_remove(host);                        ......

Via mmc_sd_detect() we are also calling device_del(card) and
mmc_detach_bus(). In other words, when _mmc_stop_host() has been
completed, the struct device corresponding to the card should have
been unregistered and host->bus_ops should be NULL.

In the later phase, mmc_bus_shutdown() seems to be called, which is
weird in the first place as the struct device should have been removed
from the bus. Then, even if that is the case, the host->bus_ops should
be NULL, thus it should rather lead to NULL pointer dereference splat
when accessing host->bus_ops->shutdown() callback.

What am I missing here?

>                                                             #Step6: wait delay work complete
>                                                             mmc_sd_suspend (.shutdown)
>                                                             {
>                                                              ......
>
>                                                             #Step7:_mmc_sd_suspend claimed host
>                                                             mmc_claim_host(host);
>                                                             #Step8: use host-card(NULL pointer)
>                                                             if (mmc_card_suspended(host->card))
>                                                              ......
>                                                             }
>                  mmc_claim_host(host);
>                  mmc_detach_bus(host);
>                 }
>              }
>           }
>        ......
>       }
>
>      2. And in the version that includes the patch, we have reproduced the issue.

Can you please send a detailed log-splat of what is happening?
Otherwise I may not be able to help.

>
> Best regards,
> Joe

Kind regards
Uffe
