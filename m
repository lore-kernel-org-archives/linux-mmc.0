Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20D4879B
	for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216599; cv=none; b=eSmaRm+RCP8Gj7Igz/CA23xWOd2RbBzkG7mxrMcXHH2Fyoo7x9emO6Z62T800selxgtMtNlYy7YWjn54k4P/ZwJGXJiAtfeAc4ELSwiZXtv5JYAPIOTl0erLVdRQ1VlWUVxgM+2gnytszVvB1ibKGHhjIcnl9OSoMHofEuETc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216599; c=relaxed/simple;
	bh=6+JyWGlWuL3neFwfndVAm41mP9TCdZhO4TKU+cop+kc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUnXwrMRCb8+egPWdqToPN09Pae5oHvd9meNxspcCaoKusLfIx7zYZSMk9IhkCegPwY/8Q/c9W11/+JoYr0fHyAZwAoqxFurU8ECOskK+vMtJ2mhpCMDm7pBPkHXtgCo28FrfPFt7rZHJBn3k9GFXJNi7xrYCVOp1/IypyWOB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XzVtDjXg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XzVtDjXg"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572242ed990so3217087a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714216595; x=1714821395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWZ79BmqrOM43+BCD+VAgtUw9w+BzvSsy0l3aYOkwOM=;
        b=XzVtDjXgC+dnW9W3hYw2fbdXVOfEpk18lgRg/dQrGiFHIm8In/fHOTGEirxUAweF/4
         7tnm+bYHjXAnW7kpB9Fgr1ZKXj3r+6wD7iy6ewaNWNQL/gvr8HC032fJ1QY1F/I3IAFM
         hCJ7GWFhwn7qC8AGp7yJNEstypGzK0m1WugC/tKJksisAfBo9vAaR8nK/kG121DejWha
         yN6a/SgXV4nUgBnq8YwtfypD/0K8bYRa0bMhkjqDzow21QhOf2gnyUKe9y3v+G+zCv/K
         J05cErm/NcWlkCplR2vFSwjKaSeKJ5T1CNQRdzPXEBk0Hq8NZQ2hPX9q3Hgu5hYw3xol
         Ofeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714216595; x=1714821395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWZ79BmqrOM43+BCD+VAgtUw9w+BzvSsy0l3aYOkwOM=;
        b=CH2p3vYh+V/1uRjdDpPLRT674OqIsF1vSTu5Y9F2e4gFjUsjZPDS0Ivu6KgmVk2wrC
         tWumm644hAbMuT4vFWLSRkZIm10N2YMkI7v5waot9//HKXciHJXZX2gK9TcAxs2JY7zv
         xMUymrBPDdd3gYDyxZ8Y6/namPh+B1kno92/fYH/iZMea35EJP0kbwrzI3tnwaZeLSPJ
         1Ss7WIWj15JFjtLoLIE2TFqaOPE6PJuqRk7cvtQoyqeVMpFNAcJ1+IhPuymVslmv8znn
         XwrOfMWAL/oxz0VWcJmOuFwQ6apaxvtrcnWJ8w7H0SrLWmyHcu4/pRK1GGouR9DaTBQZ
         guCw==
X-Forwarded-Encrypted: i=1; AJvYcCXX97nxLj8NcBgqvADsXIF2Inh7Y8y5JGF5wxbveFeMcibfzPIWki1KnW4ctFl0ZzI42XdOWuOZd1hrOG3DMjNX71/6L6qeDqLJ
X-Gm-Message-State: AOJu0YyVLIkeKgbTZy4DM8DLecMC5MhDDWDnvWrfi+Uofyj/0rHnCBx6
	1wjK0jK0noUusPe3+c3BY0Q4TXfMJss2RGngZA4fEKvqBgXZbkYgEfR6Rop3enI=
X-Google-Smtp-Source: AGHT+IHrGtv7xT9rFyE4L8LkvUgTtsWBslnRasfuA9d5IggWzQk3+JPxHG/Eoxi5ndjr+pKGaak2Wg==
X-Received: by 2002:a50:9e87:0:b0:570:1ea6:e9d8 with SMTP id a7-20020a509e87000000b005701ea6e9d8mr3714303edf.9.1714216595365;
        Sat, 27 Apr 2024 04:16:35 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b0056c24df7a78sm11060511edb.5.2024.04.27.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:16:35 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 13:16:36 +0200
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrea della Porta <andrea.porta@suse.com>, adrian.hunter@intel.com,
	alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com, jonathan@raspberrypi.com,
	kamal.dasu@broadcom.com, krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, phil@raspberrypi.com, robh@kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 6/6] mmc: sdhci-brcmstb: Add BCM2712 SD Express support
Message-ID: <ZizelID_-Hxdxp_N@apocalypse>
Mail-Followup-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrea della Porta <andrea.porta@suse.com>, adrian.hunter@intel.com,
	alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com, jonathan@raspberrypi.com,
	kamal.dasu@broadcom.com, krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, phil@raspberrypi.com, robh@kernel.org,
	ulf.hansson@linaro.org
References: <cover.1713036964.git.andrea.porta@suse.com>
 <a3d82e5a28fe53f1f61621d37d1695b0cd7655d2.1713036964.git.andrea.porta@suse.com>
 <57f240af-7e99-4bc1-a2c5-415441aa5f0b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57f240af-7e99-4bc1-a2c5-415441aa5f0b@wanadoo.fr>

On 09:34 Sun 14 Apr     , Christophe JAILLET wrote:
> Le 14/04/2024 à 00:14, Andrea della Porta a écrit :
> > Broadcom BCM2712 SDHCI controller is SD Express capable. Add support
> > for sde capability where the implementation is based on downstream driver,
> > diverging from it in the way that init_sd_express callback is invoked:
> > in downstream the sdhci_ops structure has been augmented with a new
> > function ptr 'init_sd_express' that just propagate the call to the
> > driver specific callback so that the callstack from a structure
> > standpoint is mmc_host_ops -> sdhci_ops. The drawback here is in the
> > added level of indirection (the newly added init_sd_express is
> > redundant) and the sdhci_ops structure declaration has to be changed.
> > To overcome this the presented approach consist in patching the mmc_host_ops
> > init_sd_express callback to point directly to the custom function defined in
> > this driver (see struct brcmstb_match_priv).
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta-IBi9RG/b67k@public.gmane.org>
> > ---
> >   drivers/mmc/host/Kconfig         |   1 +
> >   drivers/mmc/host/sdhci-brcmstb.c | 147 ++++++++++++++++++++++++++++++-
> >   2 files changed, 147 insertions(+), 1 deletion(-)
> 
> ...
> 
> > +	if (brcmstb_priv->sde_pcie) {
> > +		struct of_changeset changeset;
> > +		static struct property okay_property = {
> > +			.name = "status",
> > +			.value = "okay",
> > +			.length = 5,
> > +		};
> > +
> > +		/* Enable the pcie controller */
> > +		of_changeset_init(&changeset);
> > +		ret = of_changeset_update_property(&changeset,
> > +						   brcmstb_priv->sde_pcie,
> > +						   &okay_property);
> > +		if (ret) {
> > +			dev_err(dev, "%s: failed to update property - %d\n", __func__,
> > +			       ret);
> > +			return -ENODEV;
> > +		}
> > +		ret = of_changeset_apply(&changeset);
> > +	}
> > +
> > +	dev_dbg(dev, "%s -> %d\n", __func__, ret);
> 
> Is this really useful?

Not really. Removed.

> 
> > +	return ret;
> > +}
> > +
> 
> ...
> 
> > @@ -468,6 +581,24 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >   	if (res)
> >   		goto err;
> > +	priv->sde_1v8 = devm_regulator_get_optional(&pdev->dev, "sde-1v8");
> > +	if (IS_ERR(priv->sde_1v8))
> > +		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
> > +
> > +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> > +	if (iomem) {
> > +		priv->sde_ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> > +		if (IS_ERR(priv->sde_ioaddr))
> > +			priv->sde_ioaddr = NULL;
> > +	}
> > +
> > +	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> > +	if (iomem) {
> > +		priv->sde_ioaddr2 = devm_ioremap_resource(&pdev->dev, iomem);
> > +		if (IS_ERR(priv->sde_ioaddr2))
> > +			priv->sde_ioaddr = NULL;
> 
> sde_ioaddr2 ?
> 
> > +	}
> > +
> >   	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> >   	if (IS_ERR(priv->pinctrl)) {
> >   			no_pinctrl = true;
> > @@ -478,8 +609,16 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >   			no_pinctrl = true;
> >   	}
> > -	if (no_pinctrl )
> > +	priv->pins_sdex = pinctrl_lookup_state(priv->pinctrl, "sd-express");
> > +	if (IS_ERR(priv->pins_sdex)) {
> > +			dev_dbg(&pdev->dev, "No pinctrl sd-express state\n");
> > +			no_pinctrl = true;
> 
> Indentation looks too large.

Ack.

> 
> > +	}
> > +
> > +	if (no_pinctrl || !priv->sde_ioaddr || !priv->sde_ioaddr2) {
> >   		priv->pinctrl = NULL;
> > +		priv->flags &= ~BRCMSTB_PRIV_FLAGS_HAS_SD_EXPRESS;
> > +	}
> >   	/*
> >   	 * Automatic clock gating does not work for SD cards that may
> 
> ...
> 

In general I'll drop SD express patch for now, it will be re-introduced in a future patch.

Best regards,
Andrea
