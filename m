Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB76360EEA
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592827; cv=pass; b=ACyTZu8RHmiSmrznZIYubXc/WXqfimDqJ4x0iMhNeCr1TN6xANiGzXttJ778SOnm+DcL4d2Fkrr0vbHmNJ+FLAvq01ZLB1BJYOpCQIoLUjIqkCFWqjMR7J4kVjJRQQdy/of+YctrDCF9PpUrUmUtV0ttxFcXVgKo8usG/YOlkS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592827; c=relaxed/simple;
	bh=+mxx1NeFBdLFZ5BiUM22SxP9V5/01FP0eGozBut0nK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGC5A5IdsXuXq3RNa/6za7h1+5GU1GMue/RgmYityUBfzBloE5mCxgcw6mPUVFm2tibtecN4KAGkMXkk7E6Q4chWfwcC07MBclXBntJaCKc1QJs6Gh7mTvmG2gr/f+j9WrFTfV6AFsf89J8SIdu0hozNSvV892uhIBRGT+2McAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DinNm6it; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DinNm6it"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39389398838so47402411fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 06:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592824; cv=none;
        d=google.com; s=arc-20240605;
        b=eu9i6u1j3y9FfcFc7VkHlI8yfUKMTVyNTzDfp17u0oSmyyVKZmuGCP2U2YWvckX0Qc
         Rz0561d5PvEil9tgBCou0nWxRir1SOj7RMYyDF5c/HdEtX/1czUJ9cuwMU/52Tsv01sE
         CDdr4ORkSoRqc+VCC39Pl4CvhQUpPN3yCdLP6R8r+iSqxcXTX2a2j6/EacjQ8sNwnoIv
         ZbWvt20ZjtA8kqUmBI6/BFy6TkJG6GywCagGBTSJ2GuK1zrOwmRAsvQed1org4NCF0XZ
         8KZkZ0BnbVCHXKcnh75ZhPDzCGhaxdJKeNg1nZADH5Ihmt7mwnGwDGyeY4HQkdzkWX78
         kXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+mxx1NeFBdLFZ5BiUM22SxP9V5/01FP0eGozBut0nK0=;
        fh=WORh2DxYDi+m04QGN0NR0h7U+MANo6VSPhH9hj7eN0Y=;
        b=l2P4HvwCHDMeAltXcJqGekAhWfycS4BHgox53vsN7eBJR6tdbS66cUjgsMIh9oAneN
         ku9m9XycFD0BY5lSDM0TY8yE9JMc/jqqvguhCwX0iSsoB+f0ILLkxvf5ttGt2CHHVU1t
         Y/Jdrrhjv6UNLPfrJsnvpsHcbq9gdbCiCcSk6B94XgTtY6pTjhMW7XQSaTDqOsPY54sh
         Gwyroi88qsL2b46yEhkujdJ1r+2P3M67ZzJP+Y0alkUp46X2fHjk9yEoAZ/m7Ras8VuF
         eyocdD3B4HkNKMOFAa/XE0wSfQOzh8zFo/MS3x6tKBEGqUmBrZGAPF9epMU1PXjhs6rt
         +dWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778592824; x=1779197624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+mxx1NeFBdLFZ5BiUM22SxP9V5/01FP0eGozBut0nK0=;
        b=DinNm6itCplU43BaIih2TkT7g6hLzP+hbZC8tpwdPFRbDa3b8+0NS7zIb5uPlceo7k
         5nbz/Tfyu/t87kFQgvATzh2yFdwJ7LCQFi6772YamCGKTg0NgaFY6cNzpWLYDlMuwu4z
         Q2vdqSJRp2aBOniwoLf2ihSGaDyCVy32oYcHxSZ+TE9FrIKoT48UIrIq89fgJ02/4POi
         PdisMYLepYJcjEZDNYXYwwMU0W9Ggj5SJuCguk21QL8DD8D8FX9Ae7L9uODg6nLTuv61
         NLLQw5uHG/Ysdvsx/OKrRfozeskgvlaQXIMT+SOev2IiziTvL2l/jSXWa5foQ+LconUf
         rRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592824; x=1779197624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mxx1NeFBdLFZ5BiUM22SxP9V5/01FP0eGozBut0nK0=;
        b=hKuO6bfzhlQy7IkFNZB7Y2A7eXAhU5JTyXySnlevxXCXGUM1MTlAwlbUsGSI70LaYD
         A31xFPdGPGK3oAzKtTRUr3zI7FW0JTbNE1K3eSm/KDZJdhgo3rJEAkcKzRbhyIOrBWNn
         B2vO68kbNUmxQDYGx4QKlXDi2DlEDmxHhzTDc3bdtc5vmu8UdRDan+3SaENRIQfhBZr7
         yi2Ym15ElCtf09gNOEg5Dl+3qv5fdjZAv9Tx0+NdMyuEFqUmJiTvFA6WFkoOXPdmHx9Q
         Y+HNp678f5Heyq7yn2cvC4gzM2jNasSjcUWQP59XDX9zs6VmFO3bN3neZJIXkoBFOjjl
         sMug==
X-Forwarded-Encrypted: i=1; AFNElJ+CmoVh9Eji8JH3+CNidjk22jD2hye3m1bffY/x/69PT0DWnEauoMWnQt4GIf0CTYzpftz8P1yZE4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhGA7NG7rQgSvnEtANUkqSTJ5DbcWqWa2VdH4RvjwVvPN+Yoi
	vpcqQUTtm4Fv7vNvhVTtwUsNqt/4Ck3mw+cPrnbw5KyZUiK7FXJ0NUb4IQ5x6D8aqKu+vdxaa6f
	2IAuNpXisUClXqPOMC+sy+h+ZhUUnaRDhZ8NR8kZlYg==
X-Gm-Gg: Acq92OGurUPl5NvJ0ksSDj5Mv5xoiSBljL3NrRy2l9YeRbFJv3SQHV99cW+MswHdIEz
	MKI6cemO4HnRq5JwGhnORd4T1pAyZtUMhntJFscoVXSPFLQ9/vYWAfwZ8GIIDE1k8Umro0DtDjV
	mcxUvAP1okihYm5cIju+KF1PqwEh0SPS6NBzxkCDbLL0rN1Kb1TqGH1mgn4ioGIzP7FdMKsEOOY
	SkJ6wmLr81hnFqOBbdoE3m6M64KzabedO3znERJm8K9plYsi6jp4UlhqbovHByb02+0iZ2NzgC0
	CZgPrLGW
X-Received: by 2002:a05:6512:138e:b0:5a8:9494:1245 with SMTP id
 2adb3069b0e04-5a894941334mr7632411e87.38.1778592824010; Tue, 12 May 2026
 06:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com> <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com>
In-Reply-To: <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 May 2026 15:33:08 +0200
X-Gm-Features: AVHnY4J5Mc_A6lOoCuuGo9KxjP3SD71ix0wvaaOJ_hIN21RnOB8an_Gh3NCI_zg
Message-ID: <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Avri Altman <avri.altman@sandisk.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, 
	Erick Shepherd <erick.shepherd@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 18:01, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/11/26 07:18, Ulf Hansson wrote:
> > On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >>
> >> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
> >> which prevents the system from properly resuming from S3 warm boot where
> >> the eMMC is necessary to pull in the boot components.
> >
> > Is the bug confirmed by Kioxia?
>
> We've been going back and forth with them without much progress as far
> as a resolution goes. Since there was no progress and I would like to
> get this included in downstream kernels at some point, this was submitted.
>
> >
> > If not, can you explain a bit more what is actually happening during
> > system resume?
>
> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
> When our systems resume, one of our hardware cores driving the eMMC (HIF
> block) in command mode will send a CMD0 command for the eMMC device to

Is the CMD0 sent solely by HW/FW before the mmc core executes
_mmc_resume() during system resume?

> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block does

Can you please clarify what tSLEEP_EXIT refers to? Are you referring
to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?

Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
optimistic to me.

> not see the Boot ACK pattern in time and does not service the read
> request from the processor that wanted to read from eMMC, we get a reset
> of the system, rather than continue booting.
>
> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXIT
> as advertised and we don't have that problem.

Okay, I see.

In this regard, it's important to understand for me how the mmc host
driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
mmc_power_off() from _mmc_suspend()?

Does this turn off any of these regulators or what happens to them
during system suspend?

>
> So I suppose I could reformulate the commit message and give some more
> details here if you would like?

Yes, but let's discuss a bit more first.

Kind regards
Uffe
