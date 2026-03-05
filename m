Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA64399031
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711841; cv=pass; b=I/4c9PSUcAXUA1HoAm0GdjqPqJD7vn6OgHoQggiZsgl24WM//gV31fyjYHoNOcCBG7VS5btcZ3h8MmpR9hkgiINnayOWlyslAuOW/KBlH5fxV7WSsKfK6W53crmW8vD8NGsexvx6eL3iMqeKCQ0fDWmR6YAG1pY0V+71h6kXCJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711841; c=relaxed/simple;
	bh=pyfLXJ5tH+UuhUvOqbSizCPD2ZoHU9KWmBROO0vV3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm1vAJbfU30Wum2z5OmG5GxBdpf0Q6myiK0E8pPFqN6Kqhh17MxTWtdyy7XLIHcwpwprFhUbaIoLqKvp0smOHuMKddLAYzv6HJuFI3gyH/md7lAoUwTXLWrc3SKaOYupD1LhJOsyp+3muAUeo64EoI55ZxAy9Vh7TgNh2yqqkGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBWE+kKM; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBWE+kKM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so2348212e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 03:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772711838; cv=none;
        d=google.com; s=arc-20240605;
        b=QVaEfpxC0U7F0W61wveh3IiRP2DsMf2cbIQHjVSc8y76tg0s1jUo9sBeydeomli5Es
         Eqb/k3bnoSVSeD5IbYpq3ZsRZ807yyijvApr0wA/h4pCRZ3dWexk2DKxpeXQEu6L7t18
         7wFpxkbroWo/ngevfBTWOABr/mG2ryFdGu2ZKSXqYLM5Lo4yHeBh8Ujo4vEDcdO9iwZV
         oaEGKo8+8hgpX0jyWM/HYypCieQsY2RlqI0bWHFdsXGSfqDsYm97LJi1lnOVjfXaMfMS
         I4DlWLbez2/3MZoixJMB5AbOrT+dvQMV8b8JQ3fThOMCdpfazywrTw9tn8ek505iBMMM
         7YjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        fh=QutEiKjIQQNBhzWYDBU0tFoQVAxDmFXs6MfcBHyIeTI=;
        b=Kavh867hn1EDp5sESd+t+yIAYZZToRRJ0T1tVFkD/oKLRypA2GhnTNSNDwbhPs/7Th
         wCntKaJXF/0iI6fWnPPJ4nhMVgO4SZ8asTA10f05ZVN7Wz7ZqYu3IRY+5mkIQoP9J4P1
         KRvqC0fcH4B8AHZYVv5maRxQmPUrfT4SP/IRXTtoBNq7xinGafQID1SHsebyJdVaNbAP
         nAUjSYEEBUt/at2VwhXK5pS7LbhDIOgbZNAtQTAJcz5+bonIfyH+xbia4bmOXvfaSnAm
         /hpbR8x62o2Og4A8LRQiaNtp27K88pI0aCnsexqulkPAoSleoHzJ5p+a8w/5ueMxb0z6
         7eWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711838; x=1773316638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        b=qBWE+kKMddGItbMbel4SbjPrRrfVMGpS4N0LcKFaMI+KsX9O7nt/V3YudJECrSgEoh
         DPBFlNpipEYsW/LbZqGPakHMkp9gZXDszaDwwgyJEj/6SpwXsjmtIyfrcSvruNrO6iu3
         anO4RBj6rLbt+bkM4ZCNbVvw61c6x422xLQRx7lO3Z2gI7oPOiopEO91St8uWTSKPOM3
         PexPTvgS0gqD6Tdgm5R3s1fnJkxAMm5xVwGltaEqg+2OkyHjyjo8gycxROQX9ZnxtxBi
         Ioz/IUFFy8xEMFPW2gsOUgf4vGPXA+a4sIKewAF+8bPHy8VHKczYjts/aEqSNQr++6iQ
         fRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711838; x=1773316638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        b=xPVQRewkGZHVHh7eqmz3n8oyucl70XEgvpBpZinaBZT+D1j8a55Tkl7uOySVbOnMjf
         afUtoA5YXAFbeUUfGALGDd58KOafTRA7SXwDloaZsINOQo2nrElSAS2Y4q/E77i20ANc
         bv50gEysrGz4T8TnwZ8IkkeeApuvFBeiPB7ZmbyuklZwd/XU2UmQjeQJ+HbOQLi4UPyE
         d9+0ATBBEneg7veDBsDHw6pnlpBbBmaiyj0foG0BI7EEsrn9s7tIWhAJPXoOyJnYOZFq
         zUj1q86JFewoBkxY6nL7/h3CKKIF83U1oaCjOxAetpIu1C2qDd3tjKFid/M7R8UXgTse
         gCQw==
X-Forwarded-Encrypted: i=1; AJvYcCXSEHqvMdDo7ofuDpD7H78cRAeRnNcJmByzSc0JAHxthxrA5oeyKXxrv0Qt3M5BiDLGpw0TiKDuxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUGljBqXgJxZ99b8ESng95U4rmatNPj+/cU0aSgVdfM3vuuL+
	j8UXw+uBD2z/YgX0bbuMjXHgimJ9SbxXNqPi73uahYQ7WyetslhSuFLL2L27DYH++nFZUQUAaor
	b9u3gCfERsBqCT3e2myinvw7nsERwjaB/rY/jaYBjeQ==
X-Gm-Gg: ATEYQzzrIf+fsGjkYDBy4shX/011yIqgXZjOxtR4MxfzJPNDS97N6UiuwWW1mFIwGRs
	qF3qCWwORbkwyXZRIlD/jmZXLEpcXP7h+kaamexUKTOUFXmXQrasA8YhlTvsVMKy0xIF7w0mXgT
	XZBy7SEWALU59jnH91qTwAjDgXaO2j+NL9jfpi8KB2SbqFd5wzYcBefNbcmbrbW2TfXzCVeRDML
	huZsHGGx0/otOEP4fWbEl0FzSsjPMPhD/etv4ryY72ZQ1WNbhMD/v4hi3yFpHZrH9ryN8Im5yBA
	qXnJ0t50
X-Received: by 2002:a05:6512:1310:b0:59e:57d2:75f0 with SMTP id
 2adb3069b0e04-5a12c2a7335mr757421e87.32.1772711837789; Thu, 05 Mar 2026
 03:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 12:56:42 +0100
X-Gm-Features: AaiRm52pvj2zUe_TpocqnZcJOsKiyXAj5UvLIbFePU9N0VW89wsfVt26WUjr0tI
Message-ID: <CAPDyKFqXhwT4FPE8iAEBnLyEz51MvOPAb7o6b4koogSyDDkgkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 at 22:08, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> The GL9750 SD host controller has intermittent data corruption during
> DMA write operations. The GM_BURST register's R_OSRC_Lmt field
> (bits 17:16), which limits outstanding DMA read requests from system
> memory, is not being cleared during initialization. The Windows driver
> sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.
>
> Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
> write corruption verified with f3write/f3read tests while maintaining
> DMA performance.
>
> Cc: stable@vger.kernel.org
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Move GM_BURST register defines
> - Clear R_OSRC_Lmt in gli_set_9750 instead of gl9750_hw_setting to survive resets
> - Link to v1: https://lore.kernel.org/linux-mmc/20260227075909.3860183-1-matthew.schwartz@linux.dev/
>
> Changes in v1:
> - Use the proper name for the register field
> - Link to RFC: https://lore.kernel.org/linux-mmc/20260117234800.931664-1-matthew.schwartz@linux.dev/
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b0f91cc9e40e4..6e4084407662a 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -68,6 +68,9 @@
>  #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
>  #define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
>
> +#define SDHCI_GLI_9750_GM_BURST_SIZE             0x510
> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT  GENMASK(17, 16)
> +
>  #define SDHCI_GLI_9750_TUNING_CONTROL            0x540
>  #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
>  #define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
> @@ -345,10 +348,16 @@ static void gli_set_9750(struct sdhci_host *host)
>         u32 misc_value;
>         u32 parameter_value;
>         u32 control_value;
> +       u32 burst_value;
>         u16 ctrl2;
>
>         gl9750_wt_on(host);
>
> +       /* clear R_OSRC_Lmt to avoid DMA write corruption */
> +       burst_value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
> +       burst_value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
> +       sdhci_writel(host, burst_value, SDHCI_GLI_9750_GM_BURST_SIZE);
> +
>         driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
>         pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
>         sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> --
> 2.53.0
>
