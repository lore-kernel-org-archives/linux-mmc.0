Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GcOGnHDs"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E5C5
	for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 10:57:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ce5e76912aso7444565ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700247440; x=1700852240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fW6308wA70VS87+E3o3wGRpIiX2Yqcpq2KYslJTEbcg=;
        b=GcOGnHDshz5SfDfkU3qXfVFniV/ENuvu5FC9pl5vEmwk8k4xCRpyJhp2F1gqJA/JSH
         QTQqcYl1bUKK8+pk13gRpj1zTbDI41EUxnYk7QN7LjF7DJSOwHGRAB7dOthrI5wg0JPo
         WVg4GdOIk4YPdX3UIwbuUfpkuFgbJJdB2XddsYf/PLqx1Ssc2Rfce8cGip2nlYzDMVV6
         2Vz1U9XT+LRScSJhNiVMV0oBUrAl82Le+CRv0X4uLvsfptrNlE/LlLu3zwRQB3V7d7Hh
         WeMsp9OCHOYvAN+QEgeMJfCFCeaTx8U3oict1Lp4eQmD8h5Ji+dxEPw3jmp60FQ/VDUV
         zRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247440; x=1700852240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW6308wA70VS87+E3o3wGRpIiX2Yqcpq2KYslJTEbcg=;
        b=u5NgD98qxKJHKFEb2MeLkPBRc8ujEnwPix1ug74INkxqOFRHHIoLAftPXvhGb1o78W
         RXAAfaS8RLQlFj1aBiK3CgY/OD2pZzLL9Ms2wpztU7X7TOopmr2O+oi+jOtN4kTjSz1F
         yXaD37tBPhXScSodVovwK5kVtYmFXuSJpCYG3nIbGT+2+qtkPAkcAq2UdpSSEIXfNj+l
         iN+UQjA0Q0t4P9PcDmEMPgiWsOHHva6DtbINPgRPhbHZ0dB056FCTbhkgTbtw9P5FOrM
         gHDbdh1Gew36eL8uizEPikVIZXfgwGQ0mGB1zxTQhOUagp59VBn92B72qGAuKO7N89Lp
         X0kQ==
X-Gm-Message-State: AOJu0Yx1ySo3EExRQAoiTsyc4mho48zmaekEG+OokHQftCD69Hpzjyev
	SE1jHzJwwyJc4DkEbd/VfuqU0tcqet8hX9mrWErMqg==
X-Google-Smtp-Source: AGHT+IFlQXHxTYyap15dGpZg51V8uPaQR4Cvd/FPwpEGVHdEHUzqvcw2KIXNqfb5kgJ+/8bjTQUCVw==
X-Received: by 2002:a17:902:9a84:b0:1cc:4559:f5 with SMTP id w4-20020a1709029a8400b001cc455900f5mr475440plp.14.1700247440159;
        Fri, 17 Nov 2023 10:57:20 -0800 (PST)
Received: from x1 ([2601:1c2:1800:f680:813c:f3fa:3586:5465])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b001cc40912649sm1695814plj.304.2023.11.17.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:57:19 -0800 (PST)
Date: Fri, 17 Nov 2023 10:57:18 -0800
From: Drew Fustini <dfustini@baylibre.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Use logical OR instead of bitwise
 OR in dwcmshc_probe()
Message-ID: <ZVe3jvuERZgkq0BB@x1>
References: <20231116-sdhci-of-dwcmshc-fix-wbitwise-instead-of-logical-v1-1-7e1a7f4ccaab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-sdhci-of-dwcmshc-fix-wbitwise-instead-of-logical-v1-1-7e1a7f4ccaab@kernel.org>

On Thu, Nov 16, 2023 at 06:46:00PM -0700, Nathan Chancellor wrote:
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

Tested-by: Drew Fustini <dfustini@baylibre.com>

Thanks for fixing this. I'll add clang to my testing going forward.

Drew
