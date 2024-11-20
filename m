Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB31A4F02
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107855; cv=none; b=gQF4QfONbRSLxv7lugznDnQ9XnBINICNZHpl84gMtRiRDiPD7CXsbhrjYizBB2Ng/o5bK6LzsW9qXtSLbke2wlKtdkKbmYNTiTYC89mKAqUycpNT2/BJg1HPG2iz8B6D6JrH2PQvOFH2nt1eN2BupWVDFyuWsX3BPcZPobIjwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107855; c=relaxed/simple;
	bh=FvEBrpwo90we++ixVfnts2lMiToUK30o6Wp7OgsriwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoXP6bhXkPH6P7SDIBa2wLLGbEMmayYPAp+am3fCtMSNAbcKOI+oEDmJBSz7UPWdtd7I0uSq9u9ZEXDeMkkUEuMFWtxeWBvJoQDdEH0pM++n1VcnP9QT6nDAYCMe3I48TlKb5ccCZpK8kBAXT1JRbPFnUNmJa0ZvIgzKkorcJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZmzCkfn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZmzCkfn"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e388d853727so3323194276.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 05:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732107852; x=1732712652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HUBMfsuwI5bgMcS7HETv0oPFC/sFFKbFgZZ9j2lIyvY=;
        b=WZmzCkfnOymBRGvRu0PjlwJcHSlclS4z7vCTs+3LUlvUCN0bCpgtuuu+elNiJmQ9C9
         2jTDGIBZzLCu4g1yIVo4TAU2IY36LtL7c6xf7kN393PtkjEpyg1hjL0vylsNvliPEY5N
         GC9bUx/Nxarvi+2jpwpAqm7fm2uE8+RJ/tXDxZd7tH0iuhIpT1CGYmLSHaqfzkJg24lb
         Nk7U9HfC6o/dqtUuJbcNB8ZEL8JfTmkUBty/ka9XPMim6JKWK4Vwo+zJUq4Xvv0e9bB6
         ZOfMcG9c7e5izuf6WT0ocTVDbaI+FxyGsjijillgkQ88id6CUXbAc5BiPyrWkWK957pW
         XzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107852; x=1732712652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUBMfsuwI5bgMcS7HETv0oPFC/sFFKbFgZZ9j2lIyvY=;
        b=nP7WYlEcismMG+HGkZLCxFe/nN+4YNkzKIS7lyCSPl4yJbtIPJHbkhJD7J07Cpt+QI
         YosJNav52T8X3nVZe7AWsK7KHt417Mqz0v/Rcmr27kJsIjHJLxXMZV4X+8k97IZcvyoG
         CeYt4tecyVxspolu/yzddHE5aJ+wPRy2XRSI/P8da2k/tSsgYxWa+kpCrGKiXJM5bSHs
         S1k4hI61CPv/XS0a7q0nInbsYctMvuwRUNAAeQ5HGuixq6Q8nd1VRrs7ivTKaaaEPyXq
         2DHQarh+559VkEtMvG6UVOs3ZN7Oayxl4dMcbKQYqAswtZ7iChzAxPLTQvHx0QZBgfmg
         oVDA==
X-Gm-Message-State: AOJu0YyhR9TBss0A7IgmsdiXIx688oyu/cHUbcBpCB9hXaRhvgh2H6O0
	G+t2al8eQzY+hVDnjKqkTCzg6tjP4R7Qv7yW4EALxzmlzRWJaQmKMcc4oDdiVYZMPZhMecf2i+7
	zl/4Z/2GhaZ2EWu3ugO0ZD4/5MAifwV/XXaGCcJHXfAAwx797
X-Google-Smtp-Source: AGHT+IEcljAfxoohDsP9d021EI6CJaXtljuLbAi+TQD10Q1D8b5cnEPzatdbNzKro7UP1NKw6eA57Q2pyHf8Qn4QyPY=
X-Received: by 2002:a05:6902:2785:b0:e38:b3e0:501a with SMTP id
 3f1490d57ef6-e38cb57f02bmr2336989276.16.1732107852588; Wed, 20 Nov 2024
 05:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
In-Reply-To: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Nov 2024 14:03:37 +0100
Message-ID: <CAPDyKFrqxO6gSNTx7suYv+2_KZRaBrwnwwXzrAeSERYs3nRDXg@mail.gmail.com>
Subject: Re: SDHCI: linux-6.11: mmc0: Reset 0x2 never completed
To: Pankaj Pandey <pankaj.embedded@gmail.com>
Cc: linux-mmc@vger.kernel.org, "pierre@ossman.eu" <pierre@ossman.eu>, 
	isheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 09:28, Pankaj Pandey <pankaj.embedded@gmail.com> wrote:
>
> Hi All,
>
> My target board(ARMv8-A AArch32 processor), supports the "Synopsys DWC
> MSHC controller." I am using the Linux 5.4 kernel and have enabled the
> following configurations to support the "SDHCI platform driver for
> Synopsys DWC MSHC":
>
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_PLTFM=y
> CONFIG_MMC_SDHCI_OF_DWCMSHC=y
>
> This setup works perfectly on Linux 5.4, successfully detecting all
> microSD cards. However, when I use the same driver configuration with
> Linux 6.11.0, I encounter the below mentioned error:
>
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> mmc0: sdhci: Version:   0x00000005 | Present:  0x020f0000
> mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> mmc0: sdhci: Auto-CMD23 available
> mmc0: SDHCI controller on 48102000.sdhci [48102000.sdhci] using ADMA
> mmc0: Timeout waiting for hardware cmd interrupt.
> mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> mmc0: sdhci: Present:   0x020f0000 | Host ctl: 0x00000001
> mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> mmc0: sdhci: Int enab:  0x00ff1083 | Sig enab: 0x00ff1083
> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc0: sdhci: Host ctl2: 0x00000000
> mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> mmc0: sdhci: ============================================
> mmc0: Reset 0x2 never completed.
>
> =====================================================
>
> Please find mmc debug info and dts file changes for references:-
>
> root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
> clock:          400000 Hz
> actual clock:   400000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    1 (active high)
> power mode:     2 (on)
> bus width:      0 (1 bits)
> timing spec:    0 (legacy)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
>
> sdmmc: sdhci@48102000 {
>                         compatible = "snps,dwcmshc-sdhci";
>                         reg = <0x48102000 0x1000>;
>                         interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&syst_hclk>, <&syst_hclk>;
>                         clock-names = "core", "bus";
>                         bus-width = <4>;
> max-frequency = <25000000>;
>                         status = "okay";
>                 };
>
> Kindly request you to please let me know if I am missing anything.

Would it be possible for you to do a "git bisect" to see if we can
find if there is a particular commit causing the problem?

Moreover, we have v6.12 now, so it seems reasonable to give that a try too.

Kind regards
Uffe
