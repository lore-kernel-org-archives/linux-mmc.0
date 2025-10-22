Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978F313E37
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126867; cv=none; b=b/toQRWKgXsSAgld2AnZ0OcY7Ac9fvCG4Prpmt+lFonlVsKaDjnQ9boY3CO7ZfVOi7sneUVWj6Y+/dTVB9KfsJRpqR+3RVo2V9Gi369lPJ3rExcQbKEaibafzsh4O5De+4aHgK9OSoJcG7ftMsfj+ECAv3UQBg/kAe58U7kOCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126867; c=relaxed/simple;
	bh=EtmpbyasQ2LuCD2dbtC/pJs9nZwGvf9feLYKaHbanUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZBPipJnHkw4jC52HCGUZ8cE4m8iLFoLfvtBdhbgPW/yPIUU5xTz7ge+glIiF52xEle3GoeqD9rxgg0nsiUmK0IxiD6/tsTgMYbIGWxIy0YP3hZZwJHwu+EvU5UO+X7iCcoHrQK2plyEKSN5Img3ZA0OR0gSeYkW56IE3ux+DMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=npv85VOO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npv85VOO"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so6500609a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761126864; x=1761731664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WAfumH2uX3Z2dq2Ora9O/PY2fjKCeePCu7c6aWb3bo=;
        b=npv85VOObiL1ZNQ4XyAXjKC6E75qdHprbI0clWZku4FSdRjobvDUIKz/w18HcdDHR/
         SPw3OMZNAfJ0hc0CUyVLRa+g9AE76ifxIGpXF80sevFRq+ylT+DDDmrdcl/O6LBtay+U
         UGq1gC+puyBypFzJK1AbFqNt7/xyxHbYEkWInE2oZzPyhLIn3lJ9pNtY53UOtv02bSFk
         Nn/QWf7P/F2zM5+P7GV6JibDlPwIITt9a3Kea8ATkbQRtQQAI/jG+65AX44k0jsIEpby
         awzNBxj87SpePUNp7HlTSUNTaQYIhXvp9io7nNw2WtBayCdvCvFtjPTpTpOiAW4UwfDF
         gf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126864; x=1761731664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WAfumH2uX3Z2dq2Ora9O/PY2fjKCeePCu7c6aWb3bo=;
        b=GW+oq2Hk0qDc1jVlUD0omfB3MPIfZh3pK65lX9yjz8pnkZI4NsTMZ4RfJNtFyRom7v
         wSYiNKynwhyB3ACeqg/N++sPJSrxyIbgznbcu4YpApcfvh3cwWDPCTbNKcW7YshlRuOU
         fkpJF8aVHK7Ggao4rzTxo/swoVOInDy0FkPb816/9/aDh8a3ruMYT2grxarJR/i3NQfF
         TeH9In2CtAciECljS/zIJtFxRutefRqvkCk0rqcwe7C+ekmlE6x4Vj6XzsmZpQYNs7ww
         SSJDR7fTmDVeE4xJHOBUATa2mXUgBYzY7VBU/CIpeSN+jjKd5juNnPBBMgTxx9TnUzcA
         HFug==
X-Forwarded-Encrypted: i=1; AJvYcCWnEiHaTZHkOsm1pNupsIv2+2YaDSeNSP79g1GcZ9xPMUzRoe20X0z2Yk+v7HpAkQzbcfmzR93tw5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvYSWcdZW2c6puJn3ZertQRUJpdJs3x8YVw0Y9xN+tos7oNpY
	MJocFe0XgkPRazABU4XUL/bDouTL57m1B4QN3DCsmEL0db+/eexNLf2IHhiC8kItm6UVM96CYsR
	lbYtseJ7VWPhtZt0lBWg/pGm8Ky/LjTHLWrInh+uGhEVCa2y4GF3i
X-Gm-Gg: ASbGncuQTOg/puBgeKsqBhIsTnQULi0hGbKaKaqgN8m2lACgXVCFfyeZoBlJsem8YNp
	a4jhgWZzuLm88udptHPFB9BWt9cx77L4NwJWANXPUjyLx6aQfdYoLfcymv/ZHzaE/yQooAiqMmh
	isxC23/J7LRk9h7ut0ePd8hqZVfTVQ5HnZgja542zNdVYsgaLAIWialW7a6QPoUNqjCv0i/Xi5n
	SYIDfyXgvKLs/+cySNGD33ic895CIDDKswMKmBwZ8QOdB2xEnohGFDnB2xyroi1AYIOGv9H
X-Google-Smtp-Source: AGHT+IHkJQr+syP4XIj1NXSd5IYjCrxLULtv4w/lZ3TC5j6oJlcO8HY0fyR0XJQ+hvogLv5GWo7ratm2ymqw+D8ofdw=
X-Received: by 2002:a05:6402:2813:b0:633:d65a:af0e with SMTP id
 4fb4d7f45d1cf-63c1f6cee4amr20288278a12.28.1761126863838; Wed, 22 Oct 2025
 02:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
 <1066e578-f543-4233-b556-ae458c9327a1@gmail.com> <84a6b292-868d-c202-6e60-28f21390cc09@manjaro.org>
 <7a1e7da3-226a-4ee9-a3f8-fa4051f833ad@rock-chips.com>
In-Reply-To: <7a1e7da3-226a-4ee9-a3f8-fa4051f833ad@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 11:53:45 +0200
X-Gm-Features: AS18NWBUzt_fvNnQ0T3lLFsjYpwh3NtNycjxt0IDDOQ_s1idScunzU_ca4HSyNs
Message-ID: <CAPDyKFowGts=3cksrvO=EAPo06yuBo1ChCGR4MmSWUCJTHA=pA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Hugh Cole-Baker <sigmaris@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 02:39, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
>
> =E5=9C=A8 2025/10/22 =E6=98=9F=E6=9C=9F=E4=B8=89 4:24, Dragan Simic =E5=
=86=99=E9=81=93:
> > Hello Hugh and Shawn.
> >
> > On Tuesday, October 21, 2025 22:04 CEST, Hugh Cole-Baker <sigmaris@gmai=
l.com> wrote:
> >> On 20/10/2025 02:49, Shawn Lin wrote:
> >>> strbin signal delay under 0x8 configuration is not stable after massi=
ve
> >>> test. The recommandation of it should be 0x4.
> >>>
> >>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>> ---
> >>>
> >>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/s=
dhci-of-dwcmshc.c
> >>> index eebd453..5b61401 100644
> >>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> @@ -94,7 +94,7 @@
> >>>   #define DLL_TXCLK_TAPNUM_DEFAULT  0x10
> >>>   #define DLL_TXCLK_TAPNUM_90_DEGREES       0xA
> >>>   #define DLL_TXCLK_TAPNUM_FROM_SW  BIT(24)
> >>> -#define DLL_STRBIN_TAPNUM_DEFAULT  0x8
> >>> +#define DLL_STRBIN_TAPNUM_DEFAULT  0x4
> >>>   #define DLL_STRBIN_TAPNUM_FROM_SW BIT(24)
> >>>   #define DLL_STRBIN_DELAY_NUM_SEL  BIT(26)
> >>>   #define DLL_STRBIN_DELAY_NUM_OFFSET       16
> >>
> >> This patch gets the Foresee A3A444 eMMC on my NanoPC-T6 board to work =
reliably
> >> in HS400 Enhanced Strobe mode; before this patch it would suffer from =
I/O
> >> errors in HS400 mode as discussed in the other thread [1].
> >>
> >> Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
>
> Thanks for testing and comfirming it works as expected.
> I think this patch also need to be backported. So Ulf,
> could you please help add fixes tag if the patch looks good
> to you, to avoid a v2 just for adding this. :)

Yes, no problem!

>
> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform
> support")

The patch is applied for fixes with the above Fixes-tag and a
stable-tag too, thanks!

[...]

Kind regards
Uffe
