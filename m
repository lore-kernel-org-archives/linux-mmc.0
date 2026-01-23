Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415E30E835
	for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169554; cv=pass; b=hP85oDwIhTWqIC0CRNoB8FUp9GksgrOmQRBlArgewtwP2T3QW8M7Odkwy+91RPkO20e4SvD9RFM91+0+Zh91cxE6DQQ65zG0SLCIYE+sAR1ZvW9xH1FUia0cm+nZf7ko1pj1nurUfESOxYCJIOMVLvx0IFrhIVpn9gHoslfOIhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169554; c=relaxed/simple;
	bh=k79NNH/h74Y7f421TEcywbMpSV6zLKg2gmkromGoImY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CofRC4nzBIXdohE4pi7acdeDpyGTDbu8QEjD9DrpYXsVL2H7QBbrdwGQWJFa3qiUn7knDZoBbS1kqvgRiTNoX0LAve5OZH3RbV/6kmZ9pjy7NtB2GK+SMhGO22bqvjaDVViKdavGRUJAWd7ELpCYdkRSnebycLTl+5soVSSO69Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CGp4fTe9; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGp4fTe9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dcd9b89ecso2630009e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 23 Jan 2026 03:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769169551; cv=none;
        d=google.com; s=arc-20240605;
        b=ex2vrQofwvVrebPkWzt0qrtTHzmbWbsa0f+aLMW5EvbaAjO2qB6S2y4rCBLtv/KEwC
         kcI0pbl7Z0UKMeNYFBc5eL8xLuHDzGbgAfhvllFIDufKIvj6DRZRp5QRjKi1G+CV4f8F
         fhid/eqLdhyw0CoeYTkPnil/7i66TGsYNnjcYJRsXc4E9vvXrGqYnIH+tCYLMGk1AIXk
         q2UWkrqUSEpRSnGk9q8SXhu16E6khA8SSHKdlT+DTUfYxOFc1A2YZR/w8Y29BfqLy1MY
         We8CR8oryqAsDgtlhEyz1/qNILfCjnD6Q/CuK+0GrOYB9bq+d8c2P8Py8YP8aaLZ5Rit
         kPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k79NNH/h74Y7f421TEcywbMpSV6zLKg2gmkromGoImY=;
        fh=T4MH+Xx2Cd0HGgyyKtCIRmiKyZhncyVFwSKo23lQ8uQ=;
        b=fHCI4wivJMypEPWVTB+xy38KhEqOWpSZgRFCfWG4zNhwkB6eoC4+1k+f9kUiyVyVIp
         W1QHCdkijts1vndARMihBba9Emc+R79YV2iFpCQG/DdSAPw+N2p6hb4j2ZdXUAG5ErE3
         aJksHLkecAMll8ORHN/LqPaIJyrhv4b4kWgG1O2ojO9OTzcRpIn/OIPztpQmuTIP2d5f
         hGMxM+hiIoxShxJT9yl0foFprYXTcxjbj9aqwx3FHp44+AC8K+gDeqoCp3PtkZUHeu2R
         eI1PL5R7O6EoFKUGLPKRPlE3OYpErRh7mLC4LRoYd2ihinfNvun7yXAkYxEYM+U3pnKu
         TAYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769169551; x=1769774351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k79NNH/h74Y7f421TEcywbMpSV6zLKg2gmkromGoImY=;
        b=CGp4fTe99uVk104QtSwaryW0CaB7d2xhLehAgFhZrQfXZZXdz872N9MK+C9X/mWV4U
         pzZV59328LWcvCafNl97hSAKya1U6YGOHj6O/Y+mVpX8E89Uhv28GzMplsYRpiSXa7fh
         FPeNkFUpOXAE/IAzOgJZYZ00SNU6GxmSePUBZLP0M8xfzbmXI7oC7kUiSWoJYpo/7mkX
         LV7kLle0+JOxhTH7wPVhth/4MYIsTcqOsbddoF1KrlRx3qj+uoFkmEeIvlZKsdv7wYTe
         GKX+hrdSRwHU/xBmvPQ3iQK0O9pg+CoixZDikHxLa+tlS72++WGLu19biLQftuXU32uw
         UvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169551; x=1769774351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k79NNH/h74Y7f421TEcywbMpSV6zLKg2gmkromGoImY=;
        b=Z6lLDu7dngCYEcdUb0v8oX+uVco+FUC5aqh7rCUtMQjFnQIuixMH1F6avx5eZ4+oqS
         2LREkswWDZIG20Vluh2KwoSXhyQTrRyb0ld5B+tbvq6xwYB3wMKJKro/QP1JP8yxHuBu
         ASrAPeP8N4MxDGzNq8J8Z/hKRk/BTZrxs6880AIBvZ59Fpfcc58sJKIkYFrMenbVbCJD
         38ttuTdTYE+B8+UVFoPVysj80JzCw7PyqXpMv9DyMfQ0ZnEbBiyQWyu5qMQgN5byR55d
         o+vsnc/Tj2DtKnluKiK65VdTVlVidBT3I0V++LQUpBDwvH4Gzf7UeRwFpyjRo2NsuqHU
         1vNA==
X-Gm-Message-State: AOJu0YyVVlTXPLQBQMlNuAoa06IJ+hkbTq0hv9ktCtXsUV/Ohy9Ip4ca
	c5BGSg2HauD0C3u3cl310wr9V/19JRmVp+7sikAESfuy5KD8Evv/RSvNRuZZsVrDKWe5whHCbV9
	bELZTJ1A+iFnP1wL4/okLDmypopZbUn7VPLNN/OZ2vMw3bNoojgt4qjc=
X-Gm-Gg: AZuq6aIKTLBLg8zHqe8NrVGWleMC0bLx6qyCnwHHRrkdMylRpt+xdM5DaWUpLLzTEnB
	qL5l1ZoWWqQPtbL0jQJI6Z+BPHqMKTQq0k+hflw2niZrIrckH4JpXfbaCWVfrkrqBqirwf2bnQU
	F9qTks9luMi3cAiRWu+9d5A5+WBiWyCrwaxuRvlHb/8l4rlovZYYlT3VhD7DljtWhCwv5g9pT9C
	B1mQ4hgP7Y6QDs2JxwTyRN/929rynVWXkXbp3iur4QG9VoGlhixfc3VeDAev5MjCLx/Lhyr
X-Received: by 2002:a05:6512:15a9:b0:59b:aab1:5571 with SMTP id
 2adb3069b0e04-59dd7bd9387mr2426208e87.3.1769169550505; Fri, 23 Jan 2026
 03:59:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110144432.176015-1-ahmet@sezginduran.net> <CAPDyKFq0a9VjRFQsk=kU63ULwHtZqmq5ocBFj5=GfHhBo8F5DA@mail.gmail.com>
In-Reply-To: <CAPDyKFq0a9VjRFQsk=kU63ULwHtZqmq5ocBFj5=GfHhBo8F5DA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Jan 2026 12:58:34 +0100
X-Gm-Features: AZwV_QjHf4X-elCb0fgDOXH6wQJgKi_ZM96N2cJdQomdsIg__1QRvw1hgSSVpPA
Message-ID: <CAPDyKFrVLmZ=T3VuFmKn=PiVbv65NEhCsQNDV3YyFwp=Uz=EyQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pxamci: do not complete requests under host spinlock
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 19:03, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sat, 10 Jan 2026 at 15:44, Ahmet Sezgin Duran <ahmet@sezginduran.net> wrote:
> >
> > pxamci_dma_irq calls pxamci_data_done while holding host->lock, but
> > pxamci_data_done is also called from the IRQ handler without the
> > lock held and completes MMC requests.
> >
> > Calling into the MMC core under a spinlock breaks the locking contract
> > and may lead to re-entrancy issues.
> >
> > Drop the host lock before completing the request in the DMA error path.
> >
> > Found by Coverity: CID#1658802
> >
> > Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
>
> Applied for next and by adding a stable-tag, thanks!

I was too quick here. Is this really a problem that you have tested or
just something that you believe is the right thing to do?

Other drivers are holding spinlocks too when they call the mmc core to
complete requests. In principle it depends on how the host implements
locking, whether it's fine or not. For pxamci, I think it should be
fine to keep the lock held as the core will only kick a completion
variable in this case.

That said, I am going to drop this

[...]

Kind regards
Uffe
