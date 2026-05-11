Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05E40626B
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514049; cv=pass; b=PQOz39MXuz4JxxDzhNEHMEdbCdCu3tgw0lVGCBTXK+c7GQRZmua0UY0vyS+F8WsKEcGBYqda2PYUBBLBK8B4Id4pKhKmCo6ASWW/DzMNUFfeFdEizKPcHPlR78LZCuuu/gpmjLyGJcwXRxskegwYS4Vt5SMyzkK1wgPZ7pG2YQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514049; c=relaxed/simple;
	bh=tmNN8YPvEaaeYCTepKNqzkRrrJK8O3PMdrlPIoRqtFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZnZlw83VDB4G9SaWGOI+k86iTu/ygYCtYQWwYpCEV54u3I43mrf4XWmyOFq6yS3Lc2w+jGgaY/zk91hhrVybdveYsAL3avg9TCdCxxlmt2YXZjPM4koRdbklVDadiTEDNgphavfOSuxL+feqS7dtC9QB4DX3ghRvyy4swJ9pZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nm0Vv+i9; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nm0Vv+i9"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so3390317e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514046; cv=none;
        d=google.com; s=arc-20240605;
        b=BTURQpC6TI5qQKa3kPCvUNa3QSZrsi9rTQnDQkUEdKa87eLYl2cbsLvJ3QXAbV0VBj
         lse0cRc3j73HBlDCcSerM0uRjhxVWfeUSJDtUJbz4wcEab+r82LB5SvVXypZ1LAQW5WA
         cSqIXfgf4QNSCBkimZWcQ8TGtGpHArPk80HQYUI4cSJKvLC3yUYZdE/Ftr5kOp5Ky9wx
         YB7ySZJ2xSGtNTNA5m2NSlsz44nXPrvcZsRjznF+WrEWQJ5XYAd7TTEF9vNCTwrPUJHe
         OCRnkAdFqD3ogGvmQnjxupXLGoMxoE4xGMkoSRs8WWtqMWpwNov7X1mIbjPjCeh9Kaob
         1H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pWVMeqj0xlUh1jkgFkzLBpyzkrq/g1Uwz9H+NMuWTPs=;
        fh=6jUpNUy/MeIB92ROiS8ONIYfZ49X104F2jqCFhyjZBU=;
        b=K2YJ9QlTsqVAYwVbRRpMEzaauDtY7+tdc8GtskSVciV1GiKjwXdp8g3ivGhf678QCF
         hzlfLepr5cWXWPlAbYHtHUfFYIatYp3z3udaR6rh6I3ihJqId83mcH+TeID3n6Y115WP
         /FTlWsJJhqsaE53J9RNHBIXm0J2iEkgugyGIyTIJegxSFbRSPKqxjzaYQWjmBshgHe1L
         QN8GaiIozQQ7kcumIFIvuqgAs6IEqKdJw6/LQoz4f32xnzH1xvDU6nZZQ6hxVHVASdpB
         9jA4f0t1RvW6LUC9JeokccNFwJTwBH6LvxI0imKKTfk6dCQyct339wsYxvfjtE1dy/ba
         mgHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514046; x=1779118846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWVMeqj0xlUh1jkgFkzLBpyzkrq/g1Uwz9H+NMuWTPs=;
        b=Nm0Vv+i9Rzwf6kLEBuBATLNCyaKzBXQ40CpOeen2FivElTr6g1IhQ7vdylSm8yxbrX
         4nXmAkctFnli9dZAf3ksgCUKhLS9lg9tHDoSrw1rR271hwkAZaBNTHkrhArUpXd/juQq
         ayaJvOlZgpgkSQV5jFT7vNCJuSdWldYHalBD1fd9GHQ0CDBHivyQzGdcWMKqSXiqJvip
         fA1LkmhbMEc0QzwVZWemOwoWBzxsBo2A97XQlXWF9z90B1JrBSnT1ow2EsaGRc1aZO7O
         EDwh8yoEJejPcCCMbxFJvQKpT6WjneYdOQW8IniYwwgcf97BFREc4DiUxUSZg3r4B5r2
         FDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514046; x=1779118846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWVMeqj0xlUh1jkgFkzLBpyzkrq/g1Uwz9H+NMuWTPs=;
        b=tWMguwxjwQEUQv8JDZ5Jv1SF5rxaxqEsBW8nxBmjc/RlWRs/1INaKxs3Mc0NTmhhu4
         PNnuMz2K9RCbEM/gvZxij1coA1wRnKvgwpz93GWSL8HTD2u4YH+thUvw9qFPNCP09YUU
         9RjUh1yR7emYe1GNU9WJvlmy85Uj3Qvv2bf5nifG4o8vhagPE2IDtpNCe8FTwHI9bLuz
         oBBf3mNP7YSogypWTDLg5HNzTSZr3OrgI2uo2Qvl/7Rw7E/4q/hS1wLGFMSICePjwnvE
         P46eHMjVd9JGhb2HGnn13sJ3JX9hcCRARAlyn74aLzgfwx0FO0dLXAPjzB97ZckJBhsb
         z3xw==
X-Forwarded-Encrypted: i=1; AFNElJ+pxRzkLXKHX9DMP91Z06TgPH9qzTK/Pr3zDn8OpfCBSJCRcNA97JUGjtQhePYq+CfCaRznbwdUu0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwocE9Li6E/12TORl1xil1RV5CDPMMAFU/VGtVwaP83xyCLmP+Q
	Q0ITagH5gC/jSo6lH82mQzSjODMEosmxZ4gr1xrjH9Nv0F0PHD6fgVsTgwRT1ZgYtgn4q3rFLIH
	Rt61blYhRWOT3aCjAkpn1wofT8J+xtDDDkn8SWHdUxQ==
X-Gm-Gg: Acq92OGOhe/E/dXqj/FatxTt7UPA1y92+nHr8jlOEr/aHHtPUaO1Ci63qagX2y4UYkn
	KdKDbRR4h8ZN1rvn+X07SkB4K+TI+wHFH8DiEkV4Cip6OzZlh88L60QwlGny7l0l4oAvijoq7lH
	liZwCtywW61MwuBZDF9P66DqP6JwxKl0uQLda6Kausm19mpZnga0lXCnRQor8RUKDXj4RFzqnyi
	SCxuO8hbh9N0yd9+3cFNrlD9TWVrmCHNoMyUBS2WIUQulFiNE5cH0fvCG2JTzOrtqIpnR+O1sXN
	UIP3iRzO
X-Received: by 2002:a05:6512:3e24:b0:5a8:5288:28f with SMTP id
 2adb3069b0e04-5a8b709d3e7mr2541098e87.28.1778514045977; Mon, 11 May 2026
 08:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505103323.207010-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260505103323.207010-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:56 +0200
X-Gm-Features: AVHnY4JFcrbyZo66snzwgXck_jRaBZR7P8sWj1lGBUqeDdEUbyk9AptCesJjbto
Message-ID: <CAPDyKFq2tiDDvn=3tCz40HeOpaBD37ELBb5XqoMV1xb7yA154A@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Move MODULE_DEVICE_TABLE next to the table itself
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Alex Dubov <oakad@yahoo.com>, 
	Alexey Charkov <alchark@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 12:33, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> By convention MODULE_DEVICE_TABLE() immediately follows the ID table it
> exports, because this is easier to read and verify.  It also makes more
> sense since #ifdef for ACPI or OF could hide both of them.
>
> Most of the privers already have this correctly placed, so adjust
> the missing ones.  No functional impact.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 2 +-
>  drivers/mmc/host/tifm_sd.c         | 2 +-
>  drivers/mmc/host/wmt-sdmmc.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index 1373deb3f531..84ff6d82ae3c 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -188,6 +188,7 @@ static const struct pci_device_id thunder_mmc_id_table[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa010) },
>         { 0, }  /* end of table */
>  };
> +MODULE_DEVICE_TABLE(pci, thunder_mmc_id_table);
>
>  static struct pci_driver thunder_mmc_driver = {
>         .name = KBUILD_MODNAME,
> @@ -201,4 +202,3 @@ module_pci_driver(thunder_mmc_driver);
>  MODULE_AUTHOR("Cavium Inc.");
>  MODULE_DESCRIPTION("Cavium ThunderX eMMC Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_DEVICE_TABLE(pci, thunder_mmc_id_table);
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index c1f7d5b37911..aebffd3ebf60 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -1044,6 +1044,7 @@ static int tifm_sd_resume(struct tifm_dev *sock)
>  static struct tifm_device_id tifm_sd_id_tbl[] = {
>         { TIFM_TYPE_SD }, { }
>  };
> +MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
>
>  static struct tifm_driver tifm_sd_driver = {
>         .driver = {
> @@ -1070,7 +1071,6 @@ static void __exit tifm_sd_exit(void)
>  MODULE_AUTHOR("Alex Dubov");
>  MODULE_DESCRIPTION("TI FlashMedia SD driver");
>  MODULE_LICENSE("GPL");
> -MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
>  MODULE_VERSION(DRIVER_VERSION);
>
>  module_init(tifm_sd_init);
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 1b1d691e19fc..489daee4f4fc 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -744,6 +744,7 @@ static const struct of_device_id wmt_mci_dt_ids[] = {
>         { .compatible = "wm,wm8505-sdhc", .data = &wm8505_caps },
>         { /* Sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, wmt_mci_dt_ids);
>
>  static int wmt_mci_probe(struct platform_device *pdev)
>  {
> @@ -980,4 +981,3 @@ module_platform_driver(wmt_mci_driver);
>  MODULE_DESCRIPTION("Wondermedia MMC/SD Driver");
>  MODULE_AUTHOR("Tony Prisk");
>  MODULE_LICENSE("GPL v2");
> -MODULE_DEVICE_TABLE(of, wmt_mci_dt_ids);
> --
> 2.51.0
>
