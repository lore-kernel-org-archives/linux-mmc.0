Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44D219A81
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856741; cv=none; b=IvvumtG80o0VhXwX/dK+N+p9n2K91eVb+BkevNNsyr3m7HlTv/g3V0npDkeEPJ4YuFJzWJhzTdKjullanqTQeXX1R2AR6+kazsSiONLeETOwaL/3gSI1ixgZIx4/XgNN74BFwtqmlm14dsITLFVNdxZTs0ogTMIp1wSsPnjMoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856741; c=relaxed/simple;
	bh=FD00boVi7jm3nXXfQYGSl6CRaBgwvUPArFELpTcQcf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDdhLpNjEb8+/QlNw7BX7HCsEcgiv7YEkd6IA90z0aX/bSbMQICQ0wHQ6ZfEfFRrpVDRxLjIkar9NReZHQ5nvxtg6MPmsAu+eY++661CA+8dcKH4/2Y0D9isgcGX8fv79HLJDKOUZa3RCr7Ho0haI0oZEWNHouxTAdqkHuNJzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBeGujdF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBeGujdF"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60504788so16354697b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856737; x=1756461537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ta0x0Etwp/qHFHu8i5E2Zmb/9HCL2i+tnxSvK4L8KnM=;
        b=hBeGujdFyM7IhDkTHno7B9V8qIEHej26Fm/9D8TothcqI4OW7Cf1zreIDoin+DQpmH
         TuiOxHYbH1Aj2KUPztTogCUlg9bebpx5gLOw1mp9dECOSZKtYVdenVEXMcH4Fiw9e5Cp
         w8sxOhKpC8MtX/wTUd+Ux/sbdVBpDeIY9aRk+BUlzHMipr9VKhEp5CyCIYbom0qrwECS
         96/bekYV+lhrHl2shY49fxdjJUUFGVx2FnfoBmsg/+SpPUx5QwQYV1FLaOUB0XiVQOX1
         C4pAuzerW36KSPBxHvxH3PlOLShNbMFcLSkD0wS6TzBk9FucQD98pMg5em+DWceiv+WD
         Id+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856737; x=1756461537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta0x0Etwp/qHFHu8i5E2Zmb/9HCL2i+tnxSvK4L8KnM=;
        b=g/Gkws3LeV4c4MDSdCitUTI0iap1qicnlPzOGG50re6ap0aioPoj9k8FEaHVbiYiUx
         iRW7EEnrrJDFlod2baaf8HpGD7ZrKuQz1L/dP4b7Oi5B7WKh0hKbdEtH3SmrXUus/k7m
         1V3oXcG6UY29zIXEDbAs9DAPk+6eZVWNn4e/bv79FQfljBj+vJdDfv1zSR8O1ozI6EgU
         Sc6CN0h1YxPAgoOKL3IDQ+fVEQDKceEyU2PeDxLKJovuVnMqLsqCy4fEixfEwO179FcA
         C493WcPWZHyNqWrPTWgYg7rWqZtWorQrKOswpyX/CAwaNowCxOoHrkZtklwCzfURsaYc
         p2hA==
X-Forwarded-Encrypted: i=1; AJvYcCUwruYlYKyrU5PvJeIRNuay9O5O1fT9Qc9cwJzzGqhQzbbbDXd6EgsTsgRmaS6NlX5yxrj0At8yUoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwQeZ5Q/kWZ/AguPS/+OJvw3fCSCFAi4CAe+kHbmkNb69wEP3
	uyb5cmD/Jya/f6wZv31QMDRFLEonC2BHeGH8w6+4WcL0UmY5UH+E4K9Q7e4BLRUiT0gXJVCB7sJ
	NIKqOyvflHiudy/mEw2xVzRmqAcuME8tsFFr+4gMf4KyEZ8nUpcGV
X-Gm-Gg: ASbGncua2FWA/LuaPG6idNltevtUhs/AD5rsASpo5QgiuX2bp0phflIPMX25ac0sNpd
	aWnuxT7t9a/O0mSLcyWQXTirlbdCQTPwq+KMuNznxj0i2M5MKCmKixPCsC6DRqD/eV7Cq85Ya4k
	WV5ZbrCk7/NFw3Hnfwu8y9xNMxyZXTMkd+GvD52a3HIDV9yM0k51yUPqEddBhDYB4bdYQHpobK6
	haXdC7f
X-Google-Smtp-Source: AGHT+IFd0X7jkwq2XGOJ7EKMxon9dbw2ksIcL5ljDLbAAX3e91uv+L7uUO91qQDTLkLCO0orfNEA4dlYcWAaDmDw/cI=
X-Received: by 2002:a05:690c:6702:b0:71b:68ab:8bdd with SMTP id
 00721157ae682-71fdc437461mr24057427b3.39.1755856737275; Fri, 22 Aug 2025
 02:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-27-david@redhat.com>
In-Reply-To: <20250821200701.1329277-27-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:21 +0200
X-Gm-Features: Ac12FXyNlpfyW29hh3KLyFNs0xgg6UyHwa_qnpYtINLnggZTT9u4v5G4XN84Gbc
Message-ID: <CAPDyKFrAth_76byLZG+5+CA1ZELJVH6XaFzfo2i7nYfnMYKa=A@mail.gmail.com>
Subject: Re: [PATCH RFC 26/35] mspro_block: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe




> ---
>  drivers/memstick/core/mspro_block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index c9853d887d282..985cfca3f6944 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -560,8 +560,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
>                 t_offset += msb->current_page * msb->page_size;
>
>                 sg_set_page(&t_sg,
> -                           nth_page(sg_page(&(msb->req_sg[msb->current_seg])),
> -                                    t_offset >> PAGE_SHIFT),
> +                           sg_page(&(msb->req_sg[msb->current_seg])) + t_offset / PAGE_SIZE,
>                             msb->page_size, offset_in_page(t_offset));
>
>                 memstick_init_req_sg(*mrq, msb->data_dir == READ
> --
> 2.50.1
>
