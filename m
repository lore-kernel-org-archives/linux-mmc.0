Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D01D63D2
	for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115860; cv=none; b=Ge5XXGFz+SvAdpQpIIDTLaDBGXWN1hUT5nx2TMZUDq8Lg0nJWpmvLoKcUVQFbd1S1ccXYSe69iTFqtbIEdx9rBr8Clh546nXm5AUC7Wgmde4uFT5aQhdFUQW0ONL3bpvYnHPsji+zrfNu6mNJkcVG9CGHYyJCzluH00HF5T/rUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115860; c=relaxed/simple;
	bh=oHN252Cm/PR4IfsmtjEHlgEfFHmNRB7exyOEQK+Es38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/RIGKudTExlDCQfkkUkT07K6oz+S8GJO/YVTPuMt/3MT6DTVL+JbGQ1eoYtqD92EVyNaOUpiI9l/KCRVhsTf2t3yc3kcRFN7Nln7yeZuEb1sW6RDsx0tCJP9Ohx7zJmn2qc3Bur6bme9g7lHqRBiIG3FKrEAPSbY02TrugO7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeoPWa0X; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeoPWa0X"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e390d9ad1dso33695637b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2024 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115857; x=1730720657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szANAidLxxi7S1PZCTPLqWZlMP+zv9KWhvcW3ZJkZQM=;
        b=AeoPWa0XlYxQDg/X6POZ/NvoPCLwXVGYgXitiKqPr2RiwlswK4KUsKDpfY5F2VT7fU
         JLgx/zu7KPExzDDCOootdJAqCD7f+tWzpotEzdt7N/ImMlz1RXbMh4AdeE9EMuRBiEku
         g0lYigKR6yVkbk5JY53MjN7ncWKpx99c59wYGi/RP8puBcWA5NHIgVZuCBeY5GSYEcU3
         O4g44+WOQ+pQX148deIuBP3xwB7jG2qWpi3xwNz21u0evouY16/zEU39n7zWEi5sJ+cD
         oN7FDgE4aofeWgj6TTQosqgLgOWSrZrF5LSkIJs8lfqXF4/CHZKnMv7AJotBEchC2J4m
         7GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115857; x=1730720657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szANAidLxxi7S1PZCTPLqWZlMP+zv9KWhvcW3ZJkZQM=;
        b=g/2pOBWHeSSHR1XTMUKHkKYw6t/nu7MCb40/e1XfAM1/XPjUk31SF2lr1rMtCzrJ8R
         lp1SCWHp7Cxt9vE6au1e1nZiML2zevivi0ekPdLbwHULt9sUVczjoKzE81l08bTdUmyT
         2BJlwNn3BhXmB3vMw1QaPbyAbpndJw9nrH9BsDQOIHLUo9sAlZSmPelIcZNbohcaZctA
         PqilL5Y1VFNYKqvqnFTN2oOl2zQshIL+EAjet5aaldwO8YCL5NqA6MgC8/xSV9lXjxwP
         PGE8vm4HFn7PUyveIM8HigU0P5ueqCtdCK+Gs7xww5vFJ2SHI7vP/Pj6th9nlBkKTGWk
         gTnw==
X-Forwarded-Encrypted: i=1; AJvYcCWi0GVJQMIsDWsbnMN8RkfPOnAuWd2UtGRPvc+9J5MLPS8oTCtRl1TvWLPBNDofzVIwYaMHaxCC2kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk92t+vxrD/YC/2Np+hrrdi/GmD2z/rPr13OfSTGBn/VfjGS9p
	pUVl6cf1OUxn92y4PcllX2iPt+f28wohHfnfnpFA19jGEuHgQGH7ZtHlCBd5abx7cApSwfCFWQd
	jLPTrze3wsMz9rnHD6wfxv619a4RiLkewxXLbMsG9arJ09IRU
X-Google-Smtp-Source: AGHT+IGlwVOjMs2uEyjnINxzYdhzOYC3xUxuhss1DI1A8rYReLEVT61L75XVgrauUGWoh5wtBcMP1/AClNWL+Q5J27A=
X-Received: by 2002:a05:690c:f15:b0:6e5:e714:3be0 with SMTP id
 00721157ae682-6e9d88fd767mr64305097b3.1.1730115856984; Mon, 28 Oct 2024
 04:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
 <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com> <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
In-Reply-To: <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:43:40 +0100
Message-ID: <CAPDyKFpx=FwMH0PgaQqd+hFVa3ncuUjnikC3vfDHwN9V65H9mA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ben Chuang <benchuanggli@gmail.com>, Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Werner Sembach <wse@tuxedocomputers.com>, cs@tuxedo.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 17:40, Georg Gottleuber <ggo@tuxedocomputers.com> wrote:
>
> Hello Ben, hello Uffe,
>
> thank you for this fix.
>
> Am 25.10.24 um 15:22 schrieb Ulf Hansson:
> > + Georg
> >
> > On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
> >>
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> >> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
> >> So the low power negotiation mode cannot be enabled again.
> >> Introduce gl9767_set_low_power_negotiation() function to fix it.
> >>
> >> The explanation process is as below.
> >>
> >> static void sdhci_gl9767_set_clock()
> >> {
> >>         ...
> >>         gl9767_vhs_write();
> >>         ...
> >>         value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)
> >>
> >>         gl9767_disable_ssc_pll(); <--- (b)
> >>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >>
> >>         if (clock == 0)
> >>                 return;  <-- (I)
> >>
> >>         ...
> >>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> >>                 ...
> >>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
> >>         }
> >>         ...
> >>         value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
> >>         gl9767_vhs_read();
> >> }
> >>
> >> (a) disable low power negotiation mode. When return on (I), the low power
> >> mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
> >> cannot be enabled on (II).
> >>
> >> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")
> >
> > Is this the same problem as being reported in
> > https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com/
> >
> > ?
>
> Yes, this patch fixes
> https://bugzilla.kernel.org/show_bug.cgi?id=219284
>
> This makes my patch obsolete.

Thanks to both of you for helping out and fixing the problem!

I added Georg's reported/tested-by tag when applying and queued this
up as a fix with a stable tag.

Kind regards
Uffe
