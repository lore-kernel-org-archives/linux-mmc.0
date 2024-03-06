Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87F12C52C
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734945; cv=none; b=JeTWqJSnTfCo77otUDVCUr59e52ANXPVNenGnsFHCIsUe2GLREA8zwQmxxn3PvuetqOQDkX/EcA5tgunwvg/SuLH/LG19TIk4obOd9chePm7BlAbKJPcahO0/BV1XyUTE0Y7wA60P9TS52EDakEm/ZoaqFLB35v/t/BpCkph/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734945; c=relaxed/simple;
	bh=qxYOwaZcbx8hyWY5Ie0DRgeqhjQYZZ3KBdeahsa+ULc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjtrUKrO8/CcuiBf/oCuZDJgi1ZnFIbJbt6tQ6+CdTZsc76Bu8pQT8tzzN1yKaq8b5VWvgXNSbHEhkV7LQMhnnskt4WAWchH4RXUSUsADwbYS8Ul/2dwF1pGPHGSIxvkreii03d7JAofr9MWdbhjsQoInEE0fiiN0MPICfehY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=X0P9x3OT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="X0P9x3OT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e96284b9so15919955e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1709734942; x=1710339742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOt02qNbcMDdF+TSWPrUZScoOyboAJRj4lBIhLrn6nI=;
        b=X0P9x3OTiV2FkrXiaKle/QAXw6QfrgTqjpXyWG6q8guu/IhQrbFNoOXNEtNmlE70oR
         rtLrue7xz9G/U+cMLhYW65QufJD8TrXVT2HPognKKwB7j2xMfsLnyZExr67CugrGJEdT
         uQ7q2yLXm/xfVJticlxLVVL4bs1c1jib2Q+2bMqCY5MlTxhPQzfl+YdKGM7o8P7+957/
         nebrV8XCtwJWCQxf9WvCFVSZQM1SbvD6Mu+5QidgqFV7hEjZZIgzqq7dzt0hApd4MjOY
         g/1QdncTQoVvtArqZ7XKSFnf1a9VBnmTmoyLzICAgJNAL9eloWn9J9b7oNgQasfMKDDF
         MNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709734942; x=1710339742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOt02qNbcMDdF+TSWPrUZScoOyboAJRj4lBIhLrn6nI=;
        b=k620hmHfhHYXTjqxkPEkuXbb50Ql+FChYrpufKaRNKlw9qostKTSOeoAgvyrZNF4Bg
         lftthRHDp/R7wVMmOubYv4DAc70aQ4oJurz4BVw4tZvv8PoSQBC4flfeYWgvGwmUHgtC
         NexbzHvWkpbhlc5ErqF6pQsG3zMWuxMb+tDkDAkWqnFFU1FdYfAnl1JPl6naIKxv4pF6
         bwtZbVeaXOzGBxsmovLj4CFDHDdYwRigXuIdwBy8n5LEb2f/Dyt3xj2NkWAzqUzNZNcL
         2v4r9ti+w4n2HUFffWYidoD4wz19g0BejlI6RnKBIF4iJDVo0mwCxjTvekZ60t3U3P88
         J06Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR3rjYn03jlNTsg2Q/2+YUvnEh7aBAn7mvxjYKX3qC5tqxGlTkrdNQb7nNcwnYMKA0nx7tWKKgKO3k6VTq6mRZvMRGgQNG8yrC
X-Gm-Message-State: AOJu0YwwgssHWdhpckh56yykXz1po+h6g8I9/YuaCvUpejmvMwCoInmv
	boODhY7c6cA8cwPB232el6mvI8hBpXdfdZ6Ob1OAem+GQz+Kw+vBQXRneWB+t0Q=
X-Google-Smtp-Source: AGHT+IG+O14wyWHMVOWekCfQvwWKXcXAS82ZA8/4Fv/QDUBev5zw4Lh2wL576FZOCtNprYufeVeXMQ==
X-Received: by 2002:adf:b199:0:b0:33d:873a:616 with SMTP id q25-20020adfb199000000b0033d873a0616mr10057350wra.64.1709734942333;
        Wed, 06 Mar 2024 06:22:22 -0800 (PST)
Received: from trax (132.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.132])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d4a06000000b0033dbeb2eb4dsm17642666wrq.110.2024.03.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:22:21 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Wed, 6 Mar 2024 15:22:20 +0100
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Message-ID: <Zeh8HGDToMoHglD2@trax>
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax>
 <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>

On 06/03/24 14:18:49, Linus Walleij wrote:
> On Wed, Mar 6, 2024 at 10:05 AM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
>
> > That looked strange as there should be support for 4 GP but this code
> > kind of convinced me of the opposite.
> >
> >         if (idata->rpmb) {
> >                 /* Support multiple RPMB partitions */
> >                 target_part = idata->rpmb->part_index;
> >                 target_part |= EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         }
> >
> > So if we apply the fix that you propose, how are multiple RPMB
> > partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> > more than 3?
>
> As far as I can tell there can only be one RPMB partition per device.

that matches everything I have seen in the field too (and we have been
supporting RPMB on many designs lately (# > 30).

>
> The v5.1A spec says (section 6.2.1):
>
> "Two Boot Area Partitions, (...)"
> "One RPMB Partition accessed through a trusted mechanism, (...)"
> "Four General Purpose Area Partitions (...)"
>
> implying there can be only one RPMB.
>
> Also I have never seen more than one in practice.

+1

so I think it is safe to conclude that my commit did indeed cause these
regressions as it ignored the support for multiple GP. Sorry about it!.

I still cant grasp how "target_part = idata->rpmb->part_index" is
helping in the design.

What happens when:
1) EXT_CSD_PART_CONFIG_ACC_MASK > part_index > EXT_CSD_PART_CONFIG_ACC_RPMB
target_part now could be indicating a GP instead of an RPMB leading to failures.

2) part_index <= EXT_CSD_PART_CONFIG_ACC_RPMB
loses the part_index value .

So part_index should be larger than EXT_CSD_PART_CONFIG_ACC_MASK even
though the comment indicates it starts at 0?

/**
 * struct mmc_rpmb_data - special RPMB device type for these areas
 * @dev: the device for the RPMB area
 * @chrdev: character device for the RPMB area
 * @id: unique device ID number
 * @part_index: partition index (0 on first)    <---------------------
 * @md: parent MMC block device
 * @node: list item, so we can put this device on a list
 */
struct mmc_rpmb_data {
	struct device dev;
	struct cdev chrdev;
	int id;

is it just possible that "target_part = idata->rpmb->part_index" just
needs to be shifted to avoid issues?

I think the fix to the regression I introduced could perhaps address
this as well.
