Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F0846C
	for <linux-mmc@vger.kernel.org>; Mon,  5 May 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451215; cv=none; b=SId2JhYKqQvaaSeCpJf+04IhkQ4JAfRzR1VtSPOvECA2jADPwbW7q/hlAA5YAJga4q+UHVWJFmEm7NfIrZo4M82x4XKpmNgQ3n17d/ugVx3McOcsgd2b3LQ09lbVM7Tj+pPROD1SV8hYNmox+Cbhyrr9kUPa7U5T7l2KImMKMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451215; c=relaxed/simple;
	bh=1nIUIrEpwOXGJJoJF25EtbbyvEfEBQaAzOY8nVHsKSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTPtPHheSW+5m9Fpr/vZfu+Sapfy75IlAQ+HZJkEOistUtFAA6PZhQ1j7oX9iOFe0EylMsdXEuOiIJdrz7v5Q/D414MukQglMuZ9uhuE9NIYgB/jMUP0PejMf9OBMiiBjanCvenpil4QhsE8vw5g503XvZI3dqy3QyoCBD+sNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMpJsZUu; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMpJsZUu"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e730ea57804so4704268276.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2025 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746451212; x=1747056012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nIUIrEpwOXGJJoJF25EtbbyvEfEBQaAzOY8nVHsKSQ=;
        b=CMpJsZUuOIdQk5AsG9DnZykZ+xsOtjU+LHgDH0tCuRSurcgfeEchVTJJc8fqKsSLWw
         ZRjpwAbhTawo5IlQ152AHpL1CiQP8eGxt+T7q3QkS/mwDVLIABj8/7KB7wpn3b/uOf/0
         M0UGQXMvEq0ZfxaH210Cax5A8tutj6murHH8VDDx9/QTT8fVP7xGnFJ8dTJg9jybZOg3
         MB61iSsabEKU7ExETbTsXGcaY2x3IJjS8u/Pae+s1Lkkhsl8blSHuIFa7p1pC5wEJeja
         uJ+MDaQ9K0RfO7ClbGtnEIJTH8/MM3RO6bMj4EiECkoDXdSkJ/KdyakVBGNTQdfis5ko
         z0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451212; x=1747056012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nIUIrEpwOXGJJoJF25EtbbyvEfEBQaAzOY8nVHsKSQ=;
        b=NVp2xJ5sX2ssn+g4yr+FClTjqdyjITZyobpSWzhi0mOJh9BK2k2hinAb1t4akNO0Cy
         HecYgPBY6PWZ+2BYqT+CC/crlCJGPd2g0FYr0UkieCqmC8ix2ye/oQfJcKCH0RYb9ase
         /zXmXQ58bN/eh+81wJ37W6aHFFZOLoAMqqbaMxrG598ZBxhu/orlKnawXE2xe0PsyU3H
         5u2dipQ+v+9YMgJlQjOLY1NJd7jryKkgetTUVUgyqLNByK7NwvmMsZxucVG8tthRKSBJ
         ZCr174kbqs+txlXo0Kzax7+uzHbfKLVu7fr0ZDsv+cIKBRN5vUPYN7vfWPbJxnh/coOm
         vUUg==
X-Gm-Message-State: AOJu0YzKDSo91Mam6ihNI9rzlHvWpaglh0hYNUlk4t1f9vPV1Ka7mjUq
	y8AhICtuIbS8CirpqGMls0xYNsy184adnESsq4TltO68Llb+2b7egmDsG2wEFinR5W64IN1gEKR
	Z1otHv07u56xoZgTjDQhNbUFG3Y6E7/V5PdK97/SiJfu5UH/c
X-Gm-Gg: ASbGncsIgL44JNh8ej/D+JumsH56gPWrFe799oDsgRzDjTnUWnVRIM9471sSrUzjW6V
	nipuemxwF0LqAcqKUSqKrD08IPtMu706rSm0Gvij+dair51YQccsyPWCIePzzgrEZjd81kYMmuS
	TfEvvXR9xNhd+m8PIbD+ysMI8=
X-Google-Smtp-Source: AGHT+IF+P/+RQPOlbwGvlfAV8eYBKG2g8dLKf5L3pF20PuV36XS/pKMo3XFaHb0+JM2HJMOiwIM99Fq2ezV/kNrOAL4=
X-Received: by 2002:a05:6902:154a:b0:e73:40bb:3304 with SMTP id
 3f1490d57ef6-e75649df004mr15316734276.1.1746451212211; Mon, 05 May 2025
 06:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
In-Reply-To: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 May 2025 15:19:35 +0200
X-Gm-Features: ATxdqUFRGGumz4woAM-eLjfovWh1QtOtlibzcaNV0eahRnMhVL_j9cupmTyyFbk
Message-ID: <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
Subject: Re: RFC: mmc-utils versioning
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 19:05, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Hello Ulf and Avri,
>
> Would it be possible to tag future releases? That way, Buildroot's autobuild
> service would automatically notify the maintainers of the package of a
> new release,
> and in turn update the package with the latest changes.

It's certainly doable. Setting a tag is simple, but having a more
formal release-cycle with release-notes, etc, is to me a bit too much.

Would just a tag be okay with some kind of summary of the updates
since the last tag?

We need Avri's opinion on this too.

Kind regards
Uffe
