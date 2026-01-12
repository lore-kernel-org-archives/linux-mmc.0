Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC9311C33
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244990; cv=none; b=EWDXocX0pGGJDwUyjaB3Cv8xWcxCHlLfKJXAU2BVddvRfoaNKJR7iVvJf1+n7oa3VtvaWLaOPG63wwyiIzqiCkVXG63hWyIMzMTja0ZjMkhOb+9WSJw+/kkidtVfL26Yt6zxYaSleiwCuLNp9UPy/O3HxtDA5uq9ErBXDMj3tf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244990; c=relaxed/simple;
	bh=3xgYxXVz7pTlrANFhJdQjdekTrJ2dMKKIhvMM9hszBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNU1i4+0Fn7E7cBj7zLIiE5ND26vVA0f5mMQmMEl7iooMK1MbUoDGsvjrfc+Kq/XElLxGfyJPEUeVG+3mQHvRfCVimcQDK3TN5H/NYZGh3VvwLL7d+rYHXmoFTKmlxzlGkbNimQBq/xLrsapc05y7eb5kc3pu4SxVkT/mPDaWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etFx61KC; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etFx61KC"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-450ac3ed719so4384567b6e.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768244986; x=1768849786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xgYxXVz7pTlrANFhJdQjdekTrJ2dMKKIhvMM9hszBs=;
        b=etFx61KCpSg30zE2a9h6DQp8IIJbxvo1WHJe9ALB77rs4QpU1RuwYf5lMObivyY7tb
         UTRrFJiGJMYSEzCUv81mDC4lVydW0CnFbGuFxPkaPKQQBTKajaxxdoE4x5UDJUXiZ5Yf
         uhP29RBk+ZVWuacKRRQwaaNro+JC+L0Q66x2JVO6ustYMUcuQfzmPCkYQwhkXTTyIbyq
         eODBg48oVR9qGzOUUXDU7ls9jrQUgk3AXSbfHKuziiyphI8pC0kNavPcvuHnaFnYTH0k
         0u1Wffu1Dvfbg44GQQpyZynKkIsw57sZ4RN+X/z1+cNSQAso4VHEQ/dafnceH3rks3QA
         oefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244986; x=1768849786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xgYxXVz7pTlrANFhJdQjdekTrJ2dMKKIhvMM9hszBs=;
        b=YUC0I5jJw1OGISlwhbe5/hZ42jlXYuCTouCHfUZbF04PNAZBcCbUqmxnR2TYbwWZzI
         rxp1J0Onx1McK9rlgbz3Xm1ogn3O1SxfOXDxJOEowADy8f3A6fJGid/0oOGPjfXJEzI7
         xKqS/BdhZwkVPWyjEHTcXLQQDuCfMfwcLkpWtUEmAlEQHz0wO0kbAsUP4bUd/gDYwbpp
         Qtr8GBd7F60Q85VFNqNvg4RsWEttS5NPdr157qmNCB+o5CbLPIWn3NMAwcqSrxWM0AJs
         CVDbAVwODxHXXsY/2ps7emK7+WdXz3C8noCh5EcezNR4yMa6MNduFG+wJinx8gn1rv6Y
         0aCw==
X-Forwarded-Encrypted: i=1; AJvYcCUUgWyM5SedVViB4qVyl283lpYacJE85qn5QWnlu+tkHL93csuE7VUxXF36VvvoN1QeArpYfv0I9p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbjSFqFZHHa1tUKP9ZOj7wQrRWgLJ6SaqUg5NAUi4Z1WWzZmp
	+N/PnqdS8Cos10Po79hEjnMX0duCIkYRKv16vCtQxvT+dYW4L3sgjUNSiuOovEqcysEngt2tpEB
	AfTzZbKYPjdzRa3efHxRFa6NIkHLWQh8=
X-Gm-Gg: AY/fxX7NEfn08T+h77P1KGqWxz7rcUJuQbgoV3WA+6icavnzT8CeMim6gvnmTEJVHRu
	icQ9tlWWzpybMYdvME0bl6L4c+9q1XZREv0i3Hkv9Y+lYoD+9PwrIATGA3R/BzvN8xsHpE84OXq
	METVI9ySiX5CHd3SwqK0wkEM8Q0bi9crTvieNuh4Dq7uBmqkJs3fxPnB9me9bsv1xWfg0LOXBZV
	w9Y/1yDJIFDQC5VvdO1V7zDkcpsieGD8h9DOh44npNxw/nCF+mtJPZLVZXekPpmrBZMicJFZYYZ
	T+VMiz58oz/lD3yCLgA/sOrLB3Q=
X-Google-Smtp-Source: AGHT+IEwDmLeVhBFXh9EVFS3176R5WTz9bHFuYfygwgWJn3bI7U+szmlFfINN1R6jPICkSRAQjR3WA/cuwePtfThcjs=
X-Received: by 2002:a05:6808:18aa:b0:450:32f0:4887 with SMTP id
 5614622812f47-45a6bdfd28fmr7796703b6e.31.1768244985965; Mon, 12 Jan 2026
 11:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com> <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
 <c3ee063c-ca11-44e4-9e7d-3861a82db3ea@rock-chips.com> <a346ba30-43f1-4579-91e7-f10d2ccff039@rock-chips.com>
In-Reply-To: <a346ba30-43f1-4579-91e7-f10d2ccff039@rock-chips.com>
From: Marco Schirrmeister <mschirrmeister@gmail.com>
Date: Mon, 12 Jan 2026 20:09:35 +0100
X-Gm-Features: AZwV_QhduoYwkSZhCEw-t8HBLxeWwsxbNWZkTjbia4I_1o_9SGTrHxB5ncQ2lVs
Message-ID: <CAGJh8eCJEwSySH3jddmcLjdtbFkn2yDmoE4mH1snmZJQHopA0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, heiko@sntech.de, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:58=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:

> >> I found several problems on RK3576 for supporting sd cards. I wondered
> >> how all upstream RK3576 boards claiming SD support work? Anyway, I sen=
t
> >> a series to the list[1], not sure if it fixes the problem you faced, b=
ut
> >> these should be the right patches you should have a try.
> >>
> >> [1]https://lore.kernel.org/linux-rockchip/1768189768-96333-1-git-send-=
email-shawn.lin@rock-chips.com/T/#t

I will give it a try on the NanoPi R76S. Have also ordered a Rock 4D.
But it will take a while before it arrives.

> > cannot be detected. However, if the SD card is inserted before Linux
> > boots, it can at least start up. I suspect that other boards may behave
> > the same way :)
>
> This is true, because .get_cd() returns card present when booting for
> the first time, you the only way for upstream RK3576 boards to use sd
> cards is to insert the card before booting. But then hot-plug case will
> not able to work.

I can confirm the same. sd card only works, when inserted before boot.
No hotplug.
