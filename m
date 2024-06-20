Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CB1AB35E
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893369; cv=none; b=TDAMxw04Wo0Uo3ORyTVBQMi8f+O8V7UhyxUUUHnF31RS5V1LSHGkxJ2RGtkzu5lrkYogpe5C2Em4dI444VXMbyZw2gxXzbWmunIw0Nl8wUAbgOrDseVDKHRRrFQk/b6XQCCo8TLOY3y2lvHJRsQ9CrCmbhN5xJ43pD6QemPY2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893369; c=relaxed/simple;
	bh=R5I8MCxc6HrCQZOo49PzevemalXoQruR1e5Ny69+HHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWyRGXMHmL5ASo6EUVIZVPbHdNZVgednP0VbBnSVyUP8nRJhXKRAvPdnmQMAC6uvpVaeEsUsPBnHE4zucdDxs9BeSnPMaxtSYk4umxUbbKT8/VHctN+Pun/Rr3KBctcwTIn21U0lj526dnJBx/QpSaFiO8DKuBmp/Y6Hi7MpiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMWFSkSZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMWFSkSZ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-632750bf73bso8280417b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718893366; x=1719498166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pb2FlnRi8qf9Ze+6GjyEuSI6u+QcvLgXicbUKY1aLM0=;
        b=JMWFSkSZhiR6H0C+ao1dNTq6cAVIfeC6Gqos4OCgGHv78P2A2Z9ErT6W/3xZ2TdlXv
         Yav1+oVwye3jwjLK4IcLCzOhTljVeF6N0O25CMex2CYMnYQkCmSoDoOYhdBkc1S2FKHv
         4yjsoeCK7QVb9KA2lSBcBmevIoEzm7WeGVyZW7dDYV4GoW1ydYF2TCQQNBdDYutMR4NM
         dvGiVc/bpPABa21GjjBjJeeSoqOj73TVETUMq0YPjMKbyxc2zTI5JYQeWE/Gr3uAR7k8
         UWQ+9YKztq2iqXdJaEog9/v4w8xZBYbcpFyVwYsvVj/eO7yxIVAEtzFnGzxjMi4vDaHu
         uL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893366; x=1719498166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb2FlnRi8qf9Ze+6GjyEuSI6u+QcvLgXicbUKY1aLM0=;
        b=f944yAKQHncphEVNvTa2IKCejlFcZcqMda5BfBDBB9e9SJEZE5WNM3CsU3NRvo1Za7
         fL932zqkwjH8BFTAyRvia0XgUXdEO3H2oBwNMLMkI8nFEcGDe1egBC+1+NTdwuv7L58i
         yvhYTtlj6dgwKiGMP04ksNtQBWUV4CqXRpbhCm14RzGi7Kug35+le3YPzhamWxFmd76R
         69BB06IrnJbfsIC1C38OMd9C5sXz+GGyWHrG074RUcnryQQuNxeOvFtNsDMIzwB5PiUY
         qAmRNw/HXb+8ZyEuVkuV8pPU1YbCEPumrh5qZQ6cA0HvZ3rMRu0dK8vvjc6021INQtvF
         aZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtcNxgfJM2QL56H5ewQu35cGde6sxjMb2cQE7PV8mEjc8ROKIVyxCDKPr+aI+ZJl2kKXqCVWDXSTTTexHhog0lCmUIaYZidqWO
X-Gm-Message-State: AOJu0Yx1uxss2NEkiMtekNpRcw+8oQb/XAFWMz9AE3GjwOs0ceLvRnzO
	kJmIut9q4cNG5ULAuMUZVWIseLjRofD+92FaMSLZUvEEEWQRhjWFkT8TxvUUDWiJLPEDlHh4X8T
	qXHkZL09mk+aPBTL2TbscS7f2QZ0FvU+8afencQ==
X-Google-Smtp-Source: AGHT+IEeEQ+wBPet0NG1PUeZIgHWiVCS8wkCOBp21eaOWmXAAk8Ryjep4aUjBcCsRpOAEVGWt4sGzL19OJEg52KNsdo=
X-Received: by 2002:a25:6942:0:b0:dfa:fed0:caee with SMTP id
 3f1490d57ef6-e02be176f4fmr6442103276.39.1718893366575; Thu, 20 Jun 2024
 07:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718213918.git.limings@nvidia.com> <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
In-Reply-To: <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:22:10 +0200
Message-ID: <CAPDyKFqXZ3JdQBMpTM1ccAFqUSsqUcZ2fn+Ste2aG-APS2dt2w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 00:53, Liming Sun <limings@nvidia.com> wrote:
>
> The eMMC RST_N register is implemented as secure register on
> BlueField SoC and controlled by ATF. This commit sends SMC call
> to ATF for the eMMC HW reset.

Just to make sure I get this correctly. Asserting the eMMC reset line
is managed through a secure register? Or is this about resetting the
eMMC controller?

No matter what, it looks to me that it should be implemented as a
reset provider.

Kind regards
Uffe

>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index 4747e5698f48..24e0b604b405 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2018 Mellanox Technologies.
>   */
>
> +#include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/mmc/host.h>
> @@ -20,6 +21,9 @@
>  #define BLUEFIELD_UHS_REG_EXT_SAMPLE   2
>  #define BLUEFIELD_UHS_REG_EXT_DRIVE    4
>
> +/* SMC call for RST_N */
> +#define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
> +
>  static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         u32 reg;
> @@ -34,8 +38,20 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         mci_writel(host, UHS_REG_EXT, reg);
>  }
>
> +static void dw_mci_bluefield_hw_reset(struct dw_mci *host)
> +{
> +               struct arm_smccc_res res = { 0 };
> +
> +               arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0,
> +                             &res);
> +
> +               if (res.a0)
> +                       pr_err("RST_N failed.\n");
> +}
> +
>  static const struct dw_mci_drv_data bluefield_drv_data = {
> -       .set_ios                = dw_mci_bluefield_set_ios
> +       .set_ios                = dw_mci_bluefield_set_ios,
> +       .hw_reset               = dw_mci_bluefield_hw_reset
>  };
>
>  static const struct of_device_id dw_mci_bluefield_match[] = {
> --
> 2.30.1
>
