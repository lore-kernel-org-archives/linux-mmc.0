Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8B1D54CF
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115870; cv=none; b=l+b67YopkBU2llYsIZn2Xk9nVURSUfZq/qy9VMHH9lJ0kDGvYrSaxjZHKS1OJfGD3iPZ+yGMsZvKzXJwtCh0F2hO2JI4XieLcX2jUKqa80AlpraA41RQi6NkAraZCsDgAcsQqO877efIkqopxfEKbDeB1xExUkeBHvUxYMWJ5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115870; c=relaxed/simple;
	bh=3xFIWfJo3pQdwnnPZnaduSjGt8HhXQhQ3ge4r5d3ltw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WatxPg8e7bn68iOsj5/OWhSY+dkZL6QLxYmnS5HDSbnfvnrY+9si0/XOYArcA4emZureETxvNqaPdz5hmvkIyGgpS2Vm/AuXzxehwqfKOkenEw7LzP4dOThYAliPYMIBNLKAfwMWonGxWv9krs51mHSozH7HxHV8DgMt8kbOJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AjZW47CS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjZW47CS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e38fa1f82fso37235277b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115866; x=1730720666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFVmEddiuryqNGKDf9Q1oDWgMn+16WshHbAMBqqnI9E=;
        b=AjZW47CS/8/9xF2x1hLuGnN4SCsZ0x1pZC0wjySFdGw5itJFH7G7zrxoVaacJ0D0hd
         EEdXaAIe5ezm3bUQLo4cay2GsdlQeip+pG2rMjeVAQzIHp8YLmWSrjAAUyRDR7PyHiuw
         8+VdPoewpkKFKIosLkLwRT/LPCyBg1FyDfVwBrbh4JcY/B3gpORYZmC7HoBFjP1K1GXj
         IrHHV2XPpYybdwRKEwO2o3QdK/WiLe3tETDcEBCdnbkrhYQQs8kemfhtbmDUjUHooBqF
         Zd+Jbj3oSyEfTR9jI+GnObeDexPkxADQ6Ag9oOAFCBU2LU3WtQ1cOk84Y10Xlg1qokFl
         sMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115866; x=1730720666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFVmEddiuryqNGKDf9Q1oDWgMn+16WshHbAMBqqnI9E=;
        b=njNsGcGMPlKlhJTIfnNXefYKMzDMLkyMGLQ/HnevInpXEY5lji4YUfu4HNRNdC9HJq
         8Ya7Pjr0kxHm7oTHmylOV6tEN8Pzpejjfj9vzfJ8a8XDjOvqUVCJW9zhTnOJXWphj2Rm
         3dXtyycrVAsPjaJhwfIkT4W66GGySEUjY7yBlyp6R+I3kaD7IqxcRkIZfy5yMqyeH3tF
         43ePsUHZnPeZ1oe1gi09Ijv2Yt+hdtfLN31POPsHSKclglNu1LFoXvMsSZTLcg12KajV
         a1OpGcbg6d9xfYw0Dhjvpa42WYv/1YnrWyzSUmgXu/Mksf/K25rchsYVA/+a5aaNugsX
         JPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZA/0cVJRT7ks0sxRYcfhbI6nzfA6kAX4V8/F8kSC3SOov69MBj+P3g2GV0nbeWUxyl51toVucELY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7f/rIntsoPOjO+nVx/aMh/abbYziaGYogQ+wBCTdylJyAoXXe
	5TqgZtSM7JgLI3gjM0wLMHPMqcHdkdy56MMf6N15AQTHip7+n/KJylVAtndZyANxhNwv+LLLHg/
	8bNpJAUzoKLPbY92cEK47yMb2xtDMENLbMiEPrw==
X-Google-Smtp-Source: AGHT+IE5OTm252q1uGfP6P3MnXsBSg9wck2d1Wwn1hCijodT6ovEU61LQd68sX3eVHp9B1aZIJ+83puGuB7yvYkxPGM=
X-Received: by 2002:a05:690c:dd2:b0:6be:3601:7189 with SMTP id
 00721157ae682-6e9d89ae873mr68811647b3.10.1730115865933; Mon, 28 Oct 2024
 04:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com> <20241025060017.1663697-2-benchuanggli@gmail.com>
In-Reply-To: <20241025060017.1663697-2-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:43:50 +0100
Message-ID: <CAPDyKFoTAiniLRBpDv91HVf94_GJ=REhS52tqeNi+ptDXGGtyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode in the
 SD Express process
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> When starting the SD Express process, the low power negotiation mode will
> be disabled, so we need to re-enable it after switching back to SD mode.
>
> Fixes: 0e92aec2efa0 ("mmc: sdhci-pci-gli: Add support SD Express card for GL9767")
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

I am dropping this SoB, as we agreed for patch1 too.

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 22a927ce2c88..68ce4920e01e 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1068,6 +1068,9 @@ static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>                 sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
>         }
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +       value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
>         gl9767_vhs_read(pdev);
>
>         return 0;
> --
> 2.47.0
>
