Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267919D081
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852752; cv=pass; b=KdMp6qOlKHkVIac07En8E2WSxegoaBmfxNFm+79f4rlgv2e/a5JinpvdK4sQJXWQsxyFEYg5VoWMcZxtwMs0/D65DXabxlEHoTYUN83qIQWjz54t4M+hQPkVKX4bMsiyN6n6cd+yOa6V7R6J3G4/CPFbC+UL6wpyWLsIuhe6ga4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852752; c=relaxed/simple;
	bh=gg6EEWL1wsmVRXBl55TcEhNDiGUYMpBTtL91XSq64PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHDyoYIXo+a7smI5W966oIf8MOMDhq49Y4wyKU57545QGJA6LdUax8TmPXLf3k7lqf6233/2RXrQlX/saQWmNg7IOWrt1ffRzCKQpGDmNz4SYNI5y/TNDq0+SxRc0uLwaX77T7JGk5IahZuinDlDHBWGnixggrFTt4rrSKbM/1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBvHQ5tP; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBvHQ5tP"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59f855fd0d9so4391376e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 05:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771852749; cv=none;
        d=google.com; s=arc-20240605;
        b=gqjNWozjm70sZZFSmF9EHe2dnK3p7YlnGqH8Kaykgr///vBjJX+hPpeTrnlRbGMEH9
         CikzNljNmltzlaMZJfXF6App/VjCMzAIuoks95dVOF7CdW0kqsd5+ekTuQ2xjoj/6HV/
         xnUtSJmHO0PNV7TKDg7OtnDneAy6j7w2cIoojEIW7zfDEdjIl8Z6uK58UqLYrn5BF5f8
         YrY4Ev6WY8ET7AOBpJ+N0Y8uHou+TMgxMxmV4toT947VJKWGBmI4L7MmxeOFj8Pksl32
         40Kq7b2BV2/tpfYS2Vf0sZnzkHpeif/hbCwjqvC7cqxIJPDWIe6K0oeHMGy60vTM+Kmt
         SwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        fh=ODSP/RqcHQZF8Vz1MI71aBT3ftaoj/9VwtGcRk33fR0=;
        b=J9MtBdG0jIcKcfiEAI2W0uxhgzsXARbZTQo3BQdA9KDyIhdfzUi/nHnZ+7/Xm4+U+e
         VwUp6ajKlQbGDb5v0knoCjryBdi/m/UIi8c1HfO7ZaJBLJY7nqZ6zPTpZwM4lzjZXJTv
         urfpuRxbW8ucEKOTJf6G5L+of+5UQYKK5zRiqU6eTPKdMGnVTo+K11G5E2YIr0ZuYZKa
         IKuvtNMpnIRyxCNWvkKI5IBg2DPh8HkC0fr4/M4UvizwPhe0eqOoxrFGCgv/AFoboULy
         5fh06MEiaWNweHz/obi7+TGlB5nJjIatDE5W2Q3kvP5CHu6wGJ8Sr3/tDK8Kg9GU/y2p
         4DbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771852749; x=1772457549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        b=DBvHQ5tPBiwhVgVW2qHFSvG4oHzeJuhKr4h49FS8Pkf5ncLtO5lBl4D7AHimZ/nPZl
         wk3xUCGXFjJBtsfFmS9pu6VV1wbthkMgZX3xKOZFhiVbk6dpRqBhXJ7mR9weeGK3MMnd
         yImUv5e1UVpQ4qAW5cUDDmCPstFCqqoqedjknaMcewSGVDmhRBPgcUfddfoiH4bPjmcj
         TozJ6nDyWLUZjY6rlBw7OORqV7ttQQTXglz6/B1t7adLZ106C+FF4XJO87L1mKmMxDIc
         ylD4cxJcWOBQiVsq24tbavKDmIqn8UKH5fbgMIrSZsBoohgqPmGMDqa+FYz6wJHGqVkk
         9o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852749; x=1772457549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u47cn9soFrW8BHoPy5Odl1FEs5rvVnzdpDoreo2Nl90=;
        b=pxf36crXcge/JfVdpWUmDjMzqtpeFeAjftpzhIBfK6s01B+3Z7Gu3MHPhpf8CwZHOE
         hKfuhhQ3NfI+jer1g0l4vzGMTwjnth9GP1171vDxHpf97Xg4SRf2NaPeCXNiZSNy8xv/
         tGRqZbwcJBQWbq5VJFHwZNYC2BXphHjC+0UdB7KCS2tglFJQyAkMJqnwYEJaMV1l+ggS
         FwRPaKYTrk/dDyBuNDplc22tYFzJyvyFiSp82mMcDdz2o3HeUv1wCR+FCON1E3KopKyw
         zX8bhrLfPCQ95smG6ajaZhUDBM5w26Jj+y9fYNUIx/ujPbJA93vgrSNhGSr9FpLGoGDu
         /eNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFWD87NnJEqm7RtqYI4yRJ4R3VejArX+1KgbwbaBknU0HaWKBl2BD7u82EOeQQUgcK9Ow5LIhjwr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwglyxNYXDL/NgOjYr+44VLyzXYVWf9A0aUklhZMcfo17poXGk
	KWoQLOeHBsNSQGyiVhF5bavbmfhSiRBgnKaC0xEd+TfK9J5B6Hw7k7al0RAdaTfpqHY9LB3wBNU
	CZ0a4ceCpnqUg06Y3PyPPymtS9WCBi46nalJ8dS7s1w==
X-Gm-Gg: AZuq6aJFV6BjoLz/90sFsxW9tMMeFfytJLtChXxXIAv4k1/m3V8+8vpoOWS1xfFzrdo
	PWSPCxwfKdKL1jQuEOyfWo6Is3bWcNdFM9zEMFpvHbozK3uo3JO4aa58EK7bxDADuM5v4Ndz7aG
	/CmV44aHpwQdi9uWHZb/OWlDiJ1VIM9tFPv34bwrLkW+faZSQps26K47wMadkMRzXb4/qELlh47
	ua7FidlTC+Psv5hHVrQXLHiMMoumBtqUYPGSUmlsanqcwXaM94TNlOq1ULJlTxUSu5tet/RCMNH
	deYoGVWx
X-Received: by 2002:ac2:4bc1:0:b0:59d:e9df:6dcd with SMTP id
 2adb3069b0e04-5a0ed87df97mr2593500e87.15.1771852749330; Mon, 23 Feb 2026
 05:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219231624.8226-1-sean.wang@kernel.org>
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 14:18:33 +0100
X-Gm-Features: AaiRm53UIVVBouS8ori9IKqoVA3ZwCaDsyl3whmD_0t9aHnCuwJJwIQxLct_CEw
Message-ID: <CAPDyKFoiqit-_PWQ3SitGD2YV=J3ZcD97T4p-+MwYXjLVe6fdA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
To: Sean Wang <sean.wang@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 at 00:16, Sean Wang <sean.wang@kernel.org> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

This should go along with the other patches, so I am not picking this
via my mmc tree.

With the sorting (pointed out by other reviewers) fixed, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 673cbdf43453..97cc834fb3d5 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -112,6 +112,7 @@
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7663         0x7663
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7668         0x7668
>  #define SDIO_DEVICE_ID_MEDIATEK_MT7961         0x7961
> +#define SDIO_DEVICE_ID_MEDIATEK_MT7902         0x790a
>
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
> --
> 2.43.0
>
