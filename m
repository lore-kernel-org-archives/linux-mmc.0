Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B6205E1C
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460493; cv=none; b=qfDr2Oqbpi+3pvU6JI62vCMy4CQx8PMjY1UwzaJ9pAbqKDN6QzwoSTvoMO9ja6HgwM+ajsp32TGxKHf3yV/Qar9OGi2lURE7YnhRyT3PDCsLBumAHp2j9er8zxrycwL28koBahzULq3Es623RGlibubhUcPmZtKtel5M2ZrQQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460493; c=relaxed/simple;
	bh=o8z4NaQgu/h5yndTRbrfIfd+lPI/QqjiVU5mNoPtTLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLWrCWIb3O0bFcS2DenD39Isg5TLr+8+Sq96gFK8kbytmKCQevMgLxzuuP0O3QJOrU8bmD2AsbDCbuS1LoRIQS9jJAporcSrtHuDTajOAIUk8OQ+21hiOGuN3hjzW1fHbTUjiVwieWFqfy3z0rru9A7b1rxuzHW9MNG/0qu3PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJIrCnTH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJIrCnTH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fee50bfea5so4083097b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742460490; x=1743065290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8z4NaQgu/h5yndTRbrfIfd+lPI/QqjiVU5mNoPtTLw=;
        b=qJIrCnTH8t5Qvog3fgdyAtklsqnVjIMFTi4xdfOzHaPeSGGa3WP3feHbvq9AIURCyD
         ovdcQgiVClapiuTnbdcwt3jhxt8etvAPsllRVP4sjdWQrp0FNbpex4TK3e4quRxSBWbM
         EtAOUh2drnJc54d5EN1p8XODet6hhhVZu6FpBZy20ocuYJxt4HQnVtlrNycxiUHsy+lt
         UnooXSrNpAqnwVYj4s0Se5+mV4rEHpom+3Ad1LCHbJvhS8orXA7fKmi+H3x3YZ8thqO4
         v0xvinj1JbcMoojHNLCTivbuhtjIYkbU+SH9Ut8VsdM9vF02o+YRfKAr2j30G4uh1/Rp
         v5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460490; x=1743065290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8z4NaQgu/h5yndTRbrfIfd+lPI/QqjiVU5mNoPtTLw=;
        b=rvZ+sNy/B3yb+1ItsYG02cbOs69vCD/mArF0aab/+TG4tIZ7wTxKSBNwD7SiUstmtW
         nOY5lzg7wPK8QuQYOB7lwqpGC51g3hOniJxY7Yx+/WvR1Gl4g+4j4EyprH/fISqzknGF
         veVZ6t6+sHHpQ/3xVjFiMqIqH8lLEhafpWN3UEjZ8s2t8IqBugmfYcDA4OIciLvJTIfF
         y+oQ+X7zqF9IACTwO6Tj77m11j8DqIlsa8fUHiDT8hYsh/067knk/7zfvxSmNTiRKUyr
         NZ4CGq6lQrAQm5coglFKZ5PLlsnSHGjqkVUTW6Guz+6XdGtoRu2ocgRfopd4hhhoUM3I
         lH6g==
X-Forwarded-Encrypted: i=1; AJvYcCXuQt6dtCYWzScjQyrkhHt3Vk+z1vCQMEBYV4P4dkvtEIaJm9bRAlHRmKVo4HtwGbQONirJe5XprwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQG0Z6mLJzl0OunGNfHe5Vg+7ci2I+uQb9bWnavihIfABbt8sS
	eOFWHW/mUrv+P2ouSOaN+FPqicUSdtJar2+pvOsiOSpyhvjFjJQpok6UWCFbuWNMAyEJRUDg+0O
	6H9R2WL+IiaIqdDkgcsHfFInfp2pv/FygieqLow==
X-Gm-Gg: ASbGncvARUPw2/Hx1xCLfJ/vHA6HDadqA/RkDhyGpnRQtFt4fbeEkjyOKL8T0gVJ6vB
	XHhTqIAUtbmIrKsNRO4ywLH1e7XmIm3p6sc85PFCylh+0rmN1StNjwkt64yWYn0kqLyJifnTyp6
	qWrHDxuP6SLCAp4H0uB+SVoxCR7tM=
X-Google-Smtp-Source: AGHT+IHIVadVMtqujK92R4Y+K/jNB3r/aKkrGIw0RRw5Tz1BPo11B74GdF/3FVkdSTE7W/WFkhnlr+w0ruioTmT/f+g=
X-Received: by 2002:a05:690c:45c8:b0:6fe:e79f:bd8f with SMTP id
 00721157ae682-7009c1289dcmr87213147b3.26.1742460490365; Thu, 20 Mar 2025
 01:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c5f72c4-3d55-4d62-b690-8c68b76a15d2@gmail.com>
 <f6732c49-a5b1-4a13-b9f6-c2d552b5e7e8@smile.fr> <31717d89-432c-4b77-a974-99f7e6b97f97@gmail.com>
 <9168d127-06a7-46e6-a7a2-f2e60032a50e@gmail.com> <b1a369e2-938b-49ed-b743-6562f0bb46f9@smile.fr>
 <CAOCHtYiBFNY9nFjtqsFFpqRKdxUif_fC7MVqZ7cffeD8rLSe2A@mail.gmail.com>
 <CAOCHtYiujoMoPHfSmyTrv_48wUn3TfaoiPEcMFB=V++MZXvuuQ@mail.gmail.com>
 <20250226170614.18a497f0@akair> <20250307042822.GE23206@atomide.com>
 <CAPDyKFo-ODVL0JUmeZj5-PgcYwT8Gab6-US9LNSOUGwn_-prPQ@mail.gmail.com> <20250320041418.GE4957@atomide.com>
In-Reply-To: <20250320041418.GE4957@atomide.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 09:47:34 +0100
X-Gm-Features: AQ5f1JpaHc9uDg3HKu11VS8pniWI5RTqxoPZyawaVBPhNv5CO5Yj_kroGSdI6mQ
Message-ID: <CAPDyKFqY-XtVrmXnkYbW+8XZ3eHukMKyG6FKXRh=vz4gmXujEQ@mail.gmail.com>
Subject: Re: sdhci-omap: additional PM issue since 5.16
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Romain Naour <romain.naour@smile.fr>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Jason Kridner <jkridner@beagleboard.org>, "Aldea, Andrei" <a-aldea@ti.com>, David <daowens01@gmail.com>, 
	linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 05:14, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [250312 11:56]:
> > On Fri, 7 Mar 2025 at 05:28, Tony Lindgren <tony@atomide.com> wrote:
> > > Based on the symptoms, it sounds like there might be a missing flush of
> > > a posted write in the PM runtime suspend/resume path. This could cause
> > > something in the sequence happen in the wrong order for some of the
> > > related surrounding resources like power, clocks or interrupts.
> >
> > SDIO is entirely different in this regard compared to eMMC/SD. So if
> > there are no reports of issues I suggest we keep the SDIO part.
>
> Hmm just wondering if you have any guesses what causes the eMMC/SD related
> PM to break?
>
> Regards,
>
> Tony

Well, I have recently been looking a bit closer at the runtime PM
support of the eMMC/SD card. We seem to have some kind of related
problems [1], but I am not really sure yet.

That said, I believe I may have found some *potential* issues and I am
working on a few patches for it (for the mmc core), I will keep you
and the people in $subject posted. Although, it's not quite clear to
me, why these problems have turned up at this point and not a lot
earlier. I have a feeling there is something that I am missing.

Also note that, if the problems are sdhci/sdhci-omap specific, it
becomes a bit more difficult for me to help out.

Luckily, it seems like David shared a pretty simple script with us,
which should reproduce the problem in just a few minutes. There are
also debugfs and the runtime PM-sysfs interface one can use to play
with the behaviour of MMC_CAP_AGGRESSIVE_PM.

Kind regards
Uffe

[1]
https://bugzilla.kernel.org/show_bug.cgi?id=218821
https://lore.kernel.org/all/CAPDyKFq4-fL3oHeT9phThWQJqzicKeA447WBJUbtcKPhdZ2d1A@mail.gmail.com/T/
