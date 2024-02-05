Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB144C6B
	for <linux-mmc@vger.kernel.org>; Mon,  5 Feb 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154154; cv=none; b=HIQTixBoQKvuSgTZAnXYJNi+YJFQteclCRBIJ4UDmagKYW4Kp5E7MYVfXQXXwZlDv/gyVCoky7i71odTwuw17v05ow3H8dq59tUKlQ0w7c+qT/FpuLRDLHJ52VQ3DsAWbw3Zw79Dcoz6KoRMvCLZXzkSN+IgP7wtHVMIWFIBljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154154; c=relaxed/simple;
	bh=ioyziXN8WC3DzmRpJszCJqYDhP45THQflUN3K7kcP18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faQvblnM9P/hgSpGb3JJLvvwEm9roU2XDvrzPrWcly4cKOzM+AfCFMuShuwiQdCfItbwhJBRN7Q1OBGSYH7zIAREi7wlzVzpKk5a9JWG3i2II4YPpwvRMQDFP6l+d2/StnEUzafDm1WoiwFzToL2s+02JjaKmfnGsvOxOYupBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLkGQWe8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLkGQWe8"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5edfcba97e3so46276077b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 05 Feb 2024 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707154152; x=1707758952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNjbBpWo+/mHypw9b4E8VUQDTqlK2KFTdvz3f+o4Kq4=;
        b=GLkGQWe8GtMRpWzxOxfdjhZKEj1Im7UtTcTraNiDqzbI/KlxjlhafJMR9PhR2UrHXG
         hzl9KcrrKUUTC/11OhRBTLCGI6n89vdd65uTmIHPqTzl6HLBsrJbotAEDHdPoeNK5MHR
         s9q09UlMSbKJXhgWrc0tgobHpFt13LOgYkLR0eKS/+QZzt+iOdAI6xUTy/ER8rGc1pWm
         OVBbvrl7J4kCtAYcLFwHw/lTOI5E0r5/ha7dAT0qngpZKg56jMhPWNPPGqRsYV3CKmN3
         pLkLlLsgl/Xw26fH62Q6UGn/5qwOnO97j12LOUJTurdOxesTXdyZtbMqigQdeAvmLyBR
         IAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154152; x=1707758952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNjbBpWo+/mHypw9b4E8VUQDTqlK2KFTdvz3f+o4Kq4=;
        b=LO3fPJ1r7bfrv9qnsi31yb85+izs7Wlc2mV6aJ6JWo3qmZghGhYkNZd9SgWlFL7FSI
         Ge1iArOgbBNYgcNCtv6brWB3KFRiRwt7opNy4lTsEZO0xANK3fx9gRzjrhkxorLRomO/
         Wcgfui5q7bKAkT+iPBg/UYZfffvGqzA3Vy6Xg/M2P8hpvTkiFiA8FkNFJ64pxSma7EK4
         nos9fVz0v7diihzY1kqbAsUknWRRndvhQXbS08vPeZyCj3Cel4YYjpE5ZpPU1ckEDCkV
         rMi2/sE0QJE0Uyd4pM7RjMeDsy+e1JBDHS5kuwBsUIpXeVDsbl3QTLYvSGagWpJ/QqLZ
         Lrkw==
X-Gm-Message-State: AOJu0Yyz0TMfDmBRtTf5aJges8ZDURCd2SfwznPIRbt193tClDA0/ADJ
	r2qdtjS03FAbg/yRI7ZBV6P0/e6QazRCjt7PAGZ3uLUugzhG0KuccK2dXZHnIN98sfiP7jvqNOY
	XihiUKWpOVwE9xuCokXNtOu6/NQJ0tESye/6oCw==
X-Google-Smtp-Source: AGHT+IGA4NJIRSuNrBkmiLIIed7pCInPCEX0FklqvXRfEg/Phj7wPhWwH/t0KfiJ6hpoL/SUCoUS9fs0EklmpASufOM=
X-Received: by 2002:a0d:cb0e:0:b0:604:5c41:e3cf with SMTP id
 n14-20020a0dcb0e000000b006045c41e3cfmr241451ywd.24.1707154152273; Mon, 05 Feb
 2024 09:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
In-Reply-To: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 18:28:35 +0100
Message-ID: <CAPDyKFpSF8Z3_AXDs8B+ACEpoMgxuwNbA=KqkpN8S=qc9hzZLg@mail.gmail.com>
Subject: Re: [PATCH 0/3] drivers: mmc: struct bus_type cleanup
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 20:01, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
>
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> ---
> Ricardo B. Marliere (3):
>       mmc: core: make mmc_rpmb_bus_type const
>       mmc: core: make mmc_bus_type const
>       mmc: core: make sdio_bus_type const
>
>  drivers/mmc/core/block.c    | 2 +-
>  drivers/mmc/core/bus.c      | 2 +-
>  drivers/mmc/core/sdio_bus.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: 4e99ffb173faaf38f010acb369bff57a20e9e531
> change-id: 20240203-bus_cleanup-mmc-008abb80c43d
>
> Best regards,
> --
> Ricardo B. Marliere <ricardo@marliere.net>

Applied for next, thanks!

Kind regards
Uffe
