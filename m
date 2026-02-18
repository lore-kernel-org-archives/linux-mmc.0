Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509C30BBAC
	for <linux-mmc@vger.kernel.org>; Wed, 18 Feb 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414163; cv=pass; b=ZXQczO6hcaT4G2KXlqnESAUAdRcJW7pBSItTkwirKFaBWgjxqFf84zQERF9e3pt02PvhRsOEZi54c4lfnTGRuxvFJLYWcUTGIqI4lGONjlPVudkCp16PBZlgPud5QvxRBTIcWPJYKw1k40dKlxOfePXWGn7N8HV5vqKgW1Z2NWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414163; c=relaxed/simple;
	bh=IIJ4sJBvPTCTKAiqjqkQeomyIzptNmJbKLz8jcJSeeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr1fjyxOQLWRhqopNnd9wYrDx0SBUSrcgWafm8RGZKO3UsQFUsZ3HPdjeIH12Kat1SMfLMY6dGAtM5p5EKjXzzatk/Y71D6F55XuumJrPQxFR1zCT2o0sJkaPwkIccRkIWI3hFeHjlNxi+puAlBIym8lXWK3pE+QBeO/3MRyrqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t07fnlrT; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t07fnlrT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so4970560e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Feb 2026 03:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771414160; cv=none;
        d=google.com; s=arc-20240605;
        b=deVc7aQqHuFupVp+1l0zuyiCd7LolyDRXhUQ1wk4Jc/ERgWYIEm+/zaUo3zRfqoCKw
         p+HndHAHdn0X1Z7WOeM+n9TfcRBP0MF7XCw7gFJA4CS1m4zJoLX0Da6OMecjHB1HKv2q
         cyva/kkgQPseVC7/SKAOX7RMD26B3SkKwvTL7Qsyh3bj3szp5v7VddfQY5giq7igS7NJ
         xVABGGS6M6z5WQbiRRzd5Q6IpeqyZ6w2Dvz6T396t2SgDgARYOct9wyBICVxer5C/VFv
         F3PDJ4RBnlKpi6i+dXYhw1gFBT9V2CUbB3GqCbrZs3DNUfyAexYXpXEQY5zvo+Lg56C/
         Y1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IIJ4sJBvPTCTKAiqjqkQeomyIzptNmJbKLz8jcJSeeQ=;
        fh=CVWtvClrPtT3MXM7vrpeEDn0oWBOQ0hKnUNj5oVb9Eg=;
        b=U6dxMC6j75fHE9jBk1kZwKVF8eDvrlQEymEcJdR2AEyu/I4vM/iu6ZZpQyLmQwDO5S
         fzspfbPnUcxL4z2gEGUHP7x/Axeirvx/agb/8aU8CxCamWoDW3gJ2AGGXBsIR+axF8dy
         jxthd89TD2j6XK6Gam9YH3DbrohpVnzPW1GDAnnS5rNwJf0H5L+hkWT+Asnu6+fPAT3V
         EokEbQzmNIeWc8iE3QM7bQmGPBGGnuNTRPGfZrCIiBBLjKgQPdkWHiYiYByzG/HlVTJy
         i4QuR1RFF9Y+b9w1E+pBrBnzxpUsaRxOhr8BOyU8NS/QGEE9ds0wfUxIJKrKoGn3LEH7
         Gutw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771414160; x=1772018960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIJ4sJBvPTCTKAiqjqkQeomyIzptNmJbKLz8jcJSeeQ=;
        b=t07fnlrTUy+LohJkIAyvGuDak1OWNHrBJcpWf5Dd17HYZkZqZBLYjux6BoCuurS97S
         Mn9thYUe2lPgiR6F4iaXmoJT/0KwFa9Sf2gdbQ4u6/Z1FRYJ2aLwfiZrBAG7jqWAoBLp
         UDp6HI5O2j1nOURlrhdzOK0g1n3DFmDQd5w5ltDSVh616Alvdw+9BofJyxBpB8igv5bc
         KtY7nLlfJnpyvS1DGUHndckBneNiuLT+6VqiKHDNUIGAUpR19wiTxgzt4LlPGBh2SdUj
         VfnGPEeCh/2vkyDq39vu0tK+j3JzwEpdn8oS0Ah7fGlqsYy+qSVIdKcSt2sHv6bsXiUm
         ODcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771414160; x=1772018960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIJ4sJBvPTCTKAiqjqkQeomyIzptNmJbKLz8jcJSeeQ=;
        b=nzGv3b4t71KSxIhogN17NZwFECZ1PmyoPwhm1L8YSNmTDwEGpF86cz0PxLbEMQrNJE
         cNZn4JWwr2iNAT2aUWtQ/z+MzYJr9IAJbHyNoxQVaQmUFMWS+qo6RfU0jwQIdvN+BPD8
         A1HkxJiPGIo1IK01GOAT3B/YdODEu7XzNpTC9/27L2RZ2f9r08HNQhiAL7i6w96o2mR/
         UvJnk8ipoYUYBAOg1Z4Vg6eCsAzlZoCcXmk/xw8Ofv6DlbV5Qq3+UiC3A2JbzmtCtCS4
         KMLylGcaIGQhcLn8EwOOmHlzfKA3FSZMO8rHxhf+EsyhXFcgMZ0eyoKko9LGqvyhrdmH
         CcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhj0YxvUIvtouVLHpS2TDajIqJea141jVPrmWkIaAWoQbZ5sPk8yqVCcwvrCet1qym2vjwadUDOls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+gdLbul0XDBE1U9Lkgq1ZxOaO2CY1EQ/ryYwGtQ5uv+lLLFL
	7XDMLCSBjwQ0XzL6jKFUi/6480UWhGQlfocLU5VZsa6SmGmK6f1ZQAEsM4ZT7lYusvZtbzBRkbF
	vQiyXFGQo0uqXO8qucbpJyBVD8ikWRUIzbtEIfXk7sQ==
X-Gm-Gg: AZuq6aKcX6VJHifqwK3glOJthmsqzX6xrsjTf/NBs4bGsvDhmLV5yfl0UHSzkp2ra7R
	MTh5mit2l+ofDxls61bWB+sxQ0fF0UMzpy0guakkt0dfJA+kNAYj/vhNQ1LOK9fHx7xXlMfX4w7
	g/FEumvqRmgIjPpSHRScP62lJIG3b5/Z9HAnoUJ0Drol1kHx9pbTgX/F1GUw59kD2GRcNiWNyfK
	N1h+onZtZ/8604zXHKFf0bjaNNsKCKveOapJSpsPwxeIj+Tw/ROfJvBm5ewaiKfvSzwof5y6lub
	bRbIR58i
X-Received: by 2002:a05:6512:3f07:b0:59e:5d0c:ce with SMTP id
 2adb3069b0e04-59f83bbad80mr515595e87.30.1771414160049; Wed, 18 Feb 2026
 03:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216191543.2514647-1-kamal.dasu@broadcom.com> <dd8c6277-9ca0-4d9f-88bb-362c5b96843b@broadcom.com>
In-Reply-To: <dd8c6277-9ca0-4d9f-88bb-362c5b96843b@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Feb 2026 12:28:42 +0100
X-Gm-Features: AaiRm53qSojgtbY0tqDCYOXdN2UAIV1pZkOA_ObLi5mp1xNnSnfgnFwgFfwwVvI
Message-ID: <CAPDyKFprVGSu9DQAC=8d9sOCVQPuLFQmfeP9M8osxwijO3t5rQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: use correct register offset for V1
 pin_sel restore
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, adrian.hunter@intel.com, 
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 at 19:47, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 2/16/26 11:15, Kamal Dasu wrote:
> > The restore path for SDIO_CFG_CORE_V1 was incorrectly using
> > SDIO_CFG_SD_PIN_SEL (offset 0x44) instead of SDIO_CFG_V1_SD_PIN_SEL
> > (offset 0x54), causing the wrong register to be written on resume.
> > The save path already uses the correct V1-specific offset. This
> > affects BCM7445 and BCM72116 platforms which use the V1 config core.
> >
> > Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
>
> Late to the party but:

No worries!

>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

The tags added to the commit and thanks for testing/reviewing!

Kind regards
Uffe
