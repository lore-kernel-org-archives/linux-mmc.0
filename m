Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02D269B1C
	for <linux-mmc@vger.kernel.org>; Wed,  9 Apr 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204435; cv=none; b=KMIEkJy1zYm4mhs8aljjIwe2eiWuJMxLAWCuXloyE+bLOk3hiFYMJ+JXXs4cxVpgRMyWxOZQFqHvz451kq4eW+yLxsqMWtTuJnP9ASkfcUGS0k2giPvYuwCFccu1gW9z8FLmxtzhLjkAe+AJIG4Jtv9qNQuVJ0tsPkMrE+n7iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204435; c=relaxed/simple;
	bh=GXpkFS7tVP64Nlgh1lK9A2cQXAjXNrZFdouOYc0HVqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UQJR1Vmj0ZQG5z+4KNGMrcHmQpwVLggTgGVt0K57msbSscA4iil9xu/XAeR2hV3OGHR0YvxHQu5fnk9eKLjx9ph3u1zLERae5eGSx2pCkxXU48IAUokbAS/2vzWIi7qvL1tQqDS2eBnrC+WJV5xa1WvVHsHjrrKy2wcr9FJdsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IU3AMBNz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IU3AMBNz"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7043db8491dso17515967b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2025 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744204432; x=1744809232; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQ8vryUW9zvUThf3X/hXJPOdrNLb/SCOnUNjNdiRt0=;
        b=IU3AMBNz95cV9gVTEojVgF32n1uW9o1F9j73Lb2DHk3G4EE8AGAvaBedr6QP+nDMxn
         4S/oGSebJ/s5/N13EmQyfs72XViL231QoVOdzDEz2QNmrsYNm3jAqtVUGx84K59xxdxs
         LZk1rCJh3eYVB7AxxPw2l9D9liqSgXnU//CNByr6ySx3m9KmOMNQmLyqd8tBusG6FN5B
         tYU8rS8SRPl/P/u1RMl0LX27JMif6IhKZvjrvgtCXEj4wspleirPEGShxe+ohzmiczlr
         +90Hm9QSYye3Ix4SGVkxRNsYOvEEugzSRHB5iTG3Q+LexZ9nl7jDgLH3xsRGz8KdWkd+
         qmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204432; x=1744809232;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfQ8vryUW9zvUThf3X/hXJPOdrNLb/SCOnUNjNdiRt0=;
        b=ljNejiTzn0vdBuOup2CUx9n0kK5el+3lhNn+g4GguI4c8bhgXCVJqrfq5ks7P+3pSY
         lEEdzs/j9MmmdPno3uVGF5ize+vlUecvqWMZse+gFr+hAvMoUGb2YVZzRnNMnXUIR16d
         RzEXtUDvU9+x2/VyiJNiL1Z+sUaUVaZcP40dSgLyKrNyP+ltTUj3GXKQOvkIegjThLZg
         dJ9IM/ZBnMN4G/qoO5gjpV3H53o1XRl0R1NrodGY4mjG9f+ncdn4CRt2rI9HKYvo5n2K
         mC/WbK1CQ1Iqbyw+kUa9ARxv/tSSul2qcKNKIqFg4a5/m6wnBeQFT/W1R64OL4jyziU1
         RlEA==
X-Forwarded-Encrypted: i=1; AJvYcCXPLU4chVeLzVC7dlV36rDyfs3zVjVn9r/cNwGwAdp2Hnqce8qic4TtleZKtFBfGkHfNg+je/a2LBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYaVhHxcMFl4KpNgzSAOKYj8dPYzmqCOhP8qD+iFWx0byk7uf
	AYjL9a8YZ3Xxq/tjSs7Y58oJ2eXLfg5MMc3CCkowJQVogQpsEDgqYQmc9yfsUWugGkAnBsoA/2/
	YZ8eDfUYX7GowK6ufnH+yuonNtM9po7YGB0jIyQ==
X-Gm-Gg: ASbGncs3DhKcynwyPx1+uLUJEhudfceoQcfqBw2dBtyddVmluyW+LIHnhPiiKv2Fw/d
	buCaJIRxmbdIaNafp76VXXslFvOz+DlAyaym2Xf7F3fT1XyplScitxCKgfdqAX0M2tkFH3LZbw1
	EaJa6mF3sLYIoZdroOAu3SkUb8f2Yfp0LTow==
X-Google-Smtp-Source: AGHT+IGGLUQ2f6gi1PAjuUqFcZrhwocpf0+bdDQndpPucTj6+vJgCYNwU7MqR2ts9RwXmtso8QmdGEq/OB6lKYax9zw=
X-Received: by 2002:a05:690c:450f:b0:6fd:2fcf:12f5 with SMTP id
 00721157ae682-705388d9191mr54765647b3.27.1744204432185; Wed, 09 Apr 2025
 06:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407152759.25160-1-ulf.hansson@linaro.org>
 <20250407152759.25160-3-ulf.hansson@linaro.org> <Z_TZxXORT8H99qv4@shikoro>
 <CAPDyKFoOfNWa6b0jF0-a-imKqdDJQrdJe65OaOj3D0upmS7VXw@mail.gmail.com> <Z_U7ogPkzZY9IVBB@shikoro>
In-Reply-To: <Z_U7ogPkzZY9IVBB@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 15:13:16 +0200
X-Gm-Features: ATxdqUGXuv9t1HllKVU2aDR6LmbCJvQdudIU2i9CZ6_wcvW0oh79KR01BuryXT8
Message-ID: <CAPDyKFooWDpmfJoCFwjED_Utw6HppjAN5JjBL9vcZW1LsKeOFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mmc: core: Further avoid re-storing power to the
 eMMC before a shutdown
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Avri Altman <Avri.Altman@sandisk.com>, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 17:07, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > The rather long function-names "mmc_can_poweroff_notify" (that will
> > change to mmc_card_can_poweroff_notify with your series) and
> > "mmc_host_can_poweroff_notify" are rather self-explanatory, don't you
> > think?
>
> Well, you are the boss here, but frankly, I don't think it is obvious
> enough. I had to look twice and very closely to understand the logic.
> Not because of the function name, but for the reason why 'is_suspend' is
> true despite being in _shutdown(). Adrian was wondering about it the
> first time, too. So, I honestly think the comment is
>
>   for a maintainer -> superfluous
>   for a part-time-MMC-core-hacker -> helpful to remember
>   for someone new to the code -> essential
>
> Something like this.
>

I understand what you are saying and I agree. However, the problem is
that your concern applies to a lot more code in the mmc core, but this
condition.

Don't get me wrong, I don't mind useful comments and good
documentation, but perhaps what we are really missing is a general mmc
documentation that describes how the core is working and in particular
the power-management  part of it. Unfortunately, I don't think I will
have the bandwidth currently to work on this.

That said, I am going to apply the $subject patch as is - but feel
free to send a patch on top if you want to add and improve any further
comments in the code. I would be happy to apply it!

Kind regards
Uffe
