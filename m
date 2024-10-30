Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7331E2833
	for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286488; cv=none; b=n8MAeYOr/80JzEThEGYqrI0w6oqFjcK86eihHh8yNcz45PM6/VycKw4ywhSn3U50rJvymTJaqvHXh7w7qNzb3ornPZ/oPCGwlSIHr7XzscYvT44aUSHPAg14x7BxtXkgLRWutKQpCD94XOMAuiqsKUD7G8JDg3IDqiO2/qPaY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286488; c=relaxed/simple;
	bh=zzrha7jGy6bX4A4KIQJr6OduF2QVMnAKjm8yxplyNYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT50agLD4xbcAaSw8DHSnVNBl7AJuCFNjPa4W1xNKP3fW1cqz85OAM8ywWzRaqTBfO5ntdO7a58DrlM1xVA+5W/yBP9DtmU0tdcCblqDugnlyf26eXNuJPvFj0uTZYq18LYrdEH/iycZdY29QdwLHtLi0ISI3nDypPp1qztn2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2kRHwRd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2kRHwRd"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so8426334a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2024 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286484; x=1730891284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HtW7qNw/Gr/IvmBwOpblzp4beHIWRAaSzNdUMpl4z7U=;
        b=D2kRHwRdHDN2BcGJd6LGb2IteosWeHU0j1NddhY2tB5w0dwGcz7w8XOmJmyHw/oMPn
         yC37AJO4h+4P4TJpPEGL8mTTeagxBub0zJR9wqZ9c9wQMJ9vGa7F4V6Sf/88Fem9t5i4
         L/c5rLVRphizxe5CwGTW8i+Pj48fX209GAHT6ltH4mtvFL1g+SmzNMsaOpqXbmXhXKhM
         d/r3xDkMRHjUeNW/eOJW3bIOirnF4ywGS9UTAflzORghj6NZStauXTYrx9NMmNFsX8/z
         9xhjyrqr9LsqX/RU2OZ7ZDizmlFUEtY4VjVDEKJ8IrIQfLGtlYEn5Gwd4brRVYDfbDv1
         jVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286484; x=1730891284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtW7qNw/Gr/IvmBwOpblzp4beHIWRAaSzNdUMpl4z7U=;
        b=gzAW7j9ZGZERhUoxIQSAbegLq45Rk/Ehu3JelPgTFF3YADlXqgyl3PZTzlTw1IN15+
         w0pm6urmzL4Uk+z2JKUCWjEJEaWZpR9lK1A5AlxDZd6TOIIU1CPbH1dXHDN1weX8eAte
         gMlZD3MOnSX2iQK/nCE8HS+RkfhLu8wwfzYjPQcw7wVhbqT0aRDGgK8lYMghnrgXgjEJ
         9J5GCRIq1jdm6/NMMGzX/h1QvyWQHbL1a3bPUGgz0xvLqyshMKv5JZPD0I5jh5t6sA0x
         tV53BS+DkTGQLJh5ZTKeKRA98TzgWbUNsWCBLSMrkcoQ50G26Iel+5kYFTzH+Z7MfIVQ
         9LTQ==
X-Gm-Message-State: AOJu0Yz/ffttC5KvcUXBqus1bPvrTe6dVS1dBfT+hhhkTnZEJ6KAXdEY
	wG8lDvdKnjwGTTB9pOrfZ9SvMDjAum2Teyt7LLOaIuPzSRyV/be2gCh6RTeLSieVoFiwMdtoObz
	fDLKQ2ABINQCWrf3h99t/o6KEt3WxThMyakKIcw==
X-Google-Smtp-Source: AGHT+IFXN3h9v/G1nyYZauhpuoFivbA/dTsCzahlR97/GO2a33q0fDcSFnxWfjsGDzeOG9bypL8ba+QnHBYYVFERS80=
X-Received: by 2002:a05:6402:440a:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5cbbf8c30a9mr12008965a12.16.1730286484442; Wed, 30 Oct 2024
 04:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029131752.226764-1-ulf.hansson@linaro.org> <b46e153f-f329-44b9-a72e-bcc65763f789@intel.com>
In-Reply-To: <b46e153f-f329-44b9-a72e-bcc65763f789@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 12:07:25 +0100
Message-ID: <CAPDyKFoL7gHY7h924HXc6_TTyGsRR=oTs1p5BitJP8OpBPcTfw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: core: A couple of fixes for UHS-II card
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Victor Shih <victorshihgli@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 16:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/10/24 15:17, Ulf Hansson wrote:
> > The recently introduced UHS-II support to the mmc core has a few problems,
> > during the card initialization and re-initialization. This series intends to
> > addresses some these problems.
> >
> > Ulf Hansson (3):
> >   mmc: core: Simplify sd_uhs2_power_up()
> >   mmc: core: Add error handling of sd_uhs2_power_up()
> >   mmc: core: Fix error paths for UHS-II card init and re-init
> >
> >  drivers/mmc/core/sd_uhs2.c | 65 +++++++++++++++++---------------------
> >  1 file changed, 29 insertions(+), 36 deletions(-)
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for reviewing!

I have queued up the series for next.

Kind regards
Uffe
