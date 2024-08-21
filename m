Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8B175D34
	for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275422; cv=none; b=otkibe6x6BXzvUjVlZceLjfhASTjgqsD6u6r8ccv06B7pNv6b4Z3L5lkwfy+rZyhlZ6qT9kwX6lUH5nFCDtxdzAwf0tIknOLPCUiiuaXnHXUCm18Jb393Y/KN4QSHmV+IUWmyB3CuOHogAzYmerAQJINaNS1itRpB8RxFWahKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275422; c=relaxed/simple;
	bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKWR+US5uzEAyMxBWwFrjE6Q5e7Gtw9RCBIbujwAhPCynSBrxzc4WKeaKpIcfsG+kmLp6M53TGIIGtNu+YFcj2iES3GBCDMLkNx6Qr/KbzVicx1MoZsLtbxERwMrfRegiiomCUKgRDryBMBoGdGI/zlK32jvSVLhJEwTuthr7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxRHrxwH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxRHrxwH"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso185772276.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724275419; x=1724880219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
        b=MxRHrxwHiuINOa3zOQVfoBRGLTCiFIwOKotd5QJmnMRxoVS3Mf3ZkzadGNUeSRhpv5
         KEEDt42VQEFx0r2isFm2P6aK8UEnsvrM5w/j5xG76FamNW9gU8kE38FfzPisjyAI9saK
         M99FqA3GcZPdDyB/yCBO5ETqO+Yx6XbjmExTesmrPR0t+YFG90iF/odwbpEw5VXWuN0q
         XR3zKYlMpz1ijjq1dkbXEwjVOLRG/zqpY6N+dauzev2FKD/jXLXmA0sBhmqKOSrNVBAZ
         MaGrBLDU/5UP5jWIOdTn/cKfw6pqaq4RCg5D41sHReNiv7+gOE79Dmwxds/XyIaZPGlm
         HcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275419; x=1724880219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06XfuB6+MpXx4jW/NwCvJBpc8sUCcEjxtgVv5Fem5ss=;
        b=Li6c1W1udxZA0iheS6hk3eC32CyddiDv2XkMGgtnURbVgvVxT4bPPxTh9z6XzLGcOT
         EEJh1vEcDpMsd1Q9gtGi2aG9S14QFgWcF4eGuWGiO+kPShiIeMxP2NJ7hcmV0j4t6Gda
         27wU1iKQfrc6Ns/xJr4B01CK45Tnz7sSvlhulWYDf217jXIFLyTTX4pXHB5s80nQXo+j
         jS5Fc56J0fWqQ6FSrVKB+qUtoDtLDXKxfpb7Ja2+374KygRDkmiEBccSPBWfHGnQ5+yY
         Dji/XKSW72RMlX9AUPCFq6tj5g8cIXVnbh3sRGv1/VyYwb+gEqtYI91YNGEPdg8oqY4G
         otiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6hnuzFz6XhucDEz2dkXv/21XhLGxMuYbVRjo4COGlJahj2TRqsOuBj9YRAS2SFu8O+zg7uDS9Fdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wlbKwpA9tkjB4l7jxdkivkv7E9YNlfchA5n0kKVQvbXnbJWV
	zMinNmseCw23i8YztAvB+BDraHXdx/qcdEioWC1mcCL15IIddAU5ufHdxMF/pL9dvuus6M+Xo00
	i7GOlx5S5h4Srj1QHRMw1wzC9PAbcfR/f3LwHcw==
X-Google-Smtp-Source: AGHT+IEXbBfasg0L51VJ+s3QV0pg6W35UDhcXMQ7PYnH1YM/7uO/Ba/XJW9qtnapmhmS6B3z3oGMVg81ulRaSmD1W7I=
X-Received: by 2002:a05:6902:1583:b0:e13:c4c5:89ed with SMTP id
 3f1490d57ef6-e1666400ee0mr4317516276.17.1724275419451; Wed, 21 Aug 2024
 14:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 23:23:03 +0200
Message-ID: <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This patch set is getting ready to be queued for the next merge window. The
> issues reported by Mikka in the v7 patch set has been resolved, the issues
> turned out to be outside of the v7 patch set relating to configuration in
> the secure world. I'm planning a pull request to arm-soc, but before that
> I'd rather have acks or at least an OK for:
> - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> - "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf
>
> Arnd, please let me know if anything else is missing.

Greg, Jens,

To help out with the merging strategy, I don't mind queuing this whole
series via my mmc tree. It would also be nice to let it cook in
linux-next for while, via my next branch.

 From my point of view this looks good to me now, but please let me
know if you prefer a different route or if you have any further
comments.

[...]

Kind regards
Uffe
