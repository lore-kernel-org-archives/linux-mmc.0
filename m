Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KniiwsuA"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BA10EF
	for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:09 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso737295276.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759948; x=1701364748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzfEo5WBvdgfB1Az5F9u3yyf28qwDoy9yb7+zzh0FnU=;
        b=KniiwsuAsvX0yhKsMeWdT+gmcdXMIT8hXtlOyxALu1WfVFR4zxkjMUohbae9SqDytg
         ZShCrzsiYKnsqLT2yJ2EiiSVZC3tnY5ARTsMkgr0873wGdKsfkijuNAM77KZbSKQiEMi
         4S64+pQMCyZlREQwJpPSedBfwEDybDkuEMLkEuOJmHpf+TCa3CUNtw4VVkIsUJM609zh
         8EJpHJjlQb6Qj4BX2KPaR/Q2HNtmFQV4dIjsWxdZBdZGdV88dNYyiGVtsHvjMZWOJkiG
         LdQHPL/txurlIcPecZmMUYAfbXGznf9EWrTtpJNcuBehBBXh3lomkAwpFkMUrHzjkbHN
         5YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759948; x=1701364748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzfEo5WBvdgfB1Az5F9u3yyf28qwDoy9yb7+zzh0FnU=;
        b=s8EQYrq7MgqdTz9eNi4VKitS/jyFbYwYpSvlG252Elz3SJkuVVufS4cUF755W0JpUx
         dsWgl/W4A/88TbqBQmWBFJC129TGygy5SRI1bH5fSZK29E6gQILEk4sFItLWN7oGM3mq
         blYrEpKAeZJc3do2meih6ulZ24HJ1T6zHZzIdXrlIL/LZYPwFbkWiEiIQwY7DtJe8Ar0
         8Ccz2Xc5icBsdNz8wbTUfeBaqytEJV8QVgjMC73Ki1DSoDWmfiV38EPZmfiNn8XT2I3A
         SBEG/WhCPiqHwNc17rlz2LMOkTCFKZ4OwP4XosiiLVv13c+jTx2jTEzgZG7IHlACvALW
         +RZw==
X-Gm-Message-State: AOJu0YxVcKqgQgGUVb6YQiSQurBdEx9lsRfER2CNdqWCm/HGhvBBMqdG
	ypiY/E/tMKcPO/+0QEK1IaTIVAnDmKkRI5ke/yvq5A==
X-Google-Smtp-Source: AGHT+IEmXW41Yp+RFIjdjtRm1iq8rHwdxF6zrXwjU0rUmegEetlfzR0xiq7PtKWXXUYlM7wUx54oeIEvylixkhQM9x4=
X-Received: by 2002:a25:24e:0:b0:d9a:485f:5852 with SMTP id
 75-20020a25024e000000b00d9a485f5852mr5831926ybc.13.1700759948302; Thu, 23 Nov
 2023 09:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116-sdhci-of-dwcmshc-fix-wbitwise-instead-of-logical-v1-1-7e1a7f4ccaab@kernel.org>
In-Reply-To: <20231116-sdhci-of-dwcmshc-fix-wbitwise-instead-of-logical-v1-1-7e1a7f4ccaab@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 18:18:32 +0100
Message-ID: <CAPDyKFosve2awkdzzsCJb38tt2154kKKKneXiaBNqQATwdUupw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use logical OR instead of bitwise
 OR in dwcmshc_probe()
To: Nathan Chancellor <nathan@kernel.org>
Cc: adrian.hunter@intel.com, dfustini@baylibre.com, linux-mmc@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Nov 2023 at 02:46, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=y):
>
>   drivers/mmc/host/sdhci-of-dwcmshc.c:873:7: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>     873 |                 if ((device_property_read_bool(dev, "mmc-ddr-1_8v")) |
>         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     874 |                     (device_property_read_bool(dev, "mmc-hs200-1_8v")) |
>         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                                                        ||
>     875 |                     (device_property_read_bool(dev, "mmc-hs400-1_8v")))
>         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/mmc/host/sdhci-of-dwcmshc.c:873:7: note: cast one or both operands to int to silence this warning
>   drivers/mmc/host/sdhci-of-dwcmshc.c:873:7: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>     873 |                 if ((device_property_read_bool(dev, "mmc-ddr-1_8v")) |
>         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                                                      ||
>     874 |                     (device_property_read_bool(dev, "mmc-hs200-1_8v")) |
>         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/mmc/host/sdhci-of-dwcmshc.c:873:7: note: cast one or both operands to int to silence this warning
>   2 errors generated.
>
> There is little reason for this if statement to use bitwise ORs, as the
> short circuiting of logical OR does not need to be avoided in this
> context; it would be wasteful to call device_property_read_bool() three
> times if the first two calls returned true. Switch to logical OR to fix
> the warning.
>
> While in the area, the parentheses around the calls to
> device_property_read_bool() are not necessary and make the if statement
> harder to read, so remove them.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1960
> Fixes: aff35fbc7830 ("mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0eb72544c09e..a1f57af6acfb 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -870,9 +870,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
>                 priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
>
> -               if ((device_property_read_bool(dev, "mmc-ddr-1_8v")) |
> -                   (device_property_read_bool(dev, "mmc-hs200-1_8v")) |
> -                   (device_property_read_bool(dev, "mmc-hs400-1_8v")))
> +               if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> +                   device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> +                   device_property_read_bool(dev, "mmc-hs400-1_8v"))
>                         priv->flags |= FLAG_IO_FIXED_1V8;
>                 else
>                         priv->flags &= ~FLAG_IO_FIXED_1V8;
>
> ---
> base-commit: 3f00051234f02d0d9d1f63b9a334d0fd4c65b6ca
> change-id: 20231116-sdhci-of-dwcmshc-fix-wbitwise-instead-of-logical-bf8fed73b5bb
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
