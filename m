Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685113;
	b=L/wMd6lEFhgd7WtAtLPy9kXWpfo8j6AWkRGzk09I90Do+g9/GF5WL3J0DG3EPAQXo/72
	 JS3f3piO08OoTCk4mrAHzZLHgzfThNxNOWxnjR/kzNFMFkYUtaT4NpyEfqPVDkASJLjSJ
	 FzhHMY78ENHuZmdL2xjsRNPoPhsSk5FYvD07QtmZl+xHtrvdR8kGPl4pipzTZs9LTKyDe
	 0MNcv/SwtN7yN6m14/OetKOt46qQWET4MZMlWUiYis5Ihj4wMJtwByy0BspLaKxOPHkcu
	 OhAfindXuehCGX5cMx8WjD6PDG9fHHPouSYWZFYFuwPOb1BAGLHZNkY1lOWZAsci4Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685113;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=9JSNdwZV67Uwnrr8l1kdCs7HPzDkZQfnoroyJMBz3l0=;
	b=FibWzGZOwqzc3cLm3acSOt3GmbkgwzCaq6Fzy2sURSP9bBlL+FZDbQBRAZQNQbLhLOgH
	 FFoEk0Br6xN3/8rvQiz6rLxaIgBl9tyPjAqRhn7uatYEiJJHq9SsmpyTCMOndbLn9DqkY
	 BDC7I4r4sEUm67u+hxTBVo6rLZUg+nBga4ZvHz2GjLKsDKgKcYjoqEQhCIsByPUVUEHRj
	 TPTtUtZ6q3VfI9oGmEhfEcWoJ2TzA/vxogaUfNLq7k4m/1hP3y799ne9nB+ZvP9mCu9dJ
	 kdoAPxwGq0H5DO/Uek4cj+m6tm4mz0A1sqVucwOcAiJA4QwSus5p85pc6dY1zPZ59vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=qvcFVzs9;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD00606A31C
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 09:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=qvcFVzs9
DKIM2-Signature:  i=1; m=1; t=1795685110;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:bJxet8XKwUacBhtdiGpS+81g83w/
   8V1A10mrn/oOB1zsid5/q6xtt0IGn2p9Ta4ZtfiDt6nqI+bSzyYHRs6I1gK0eioizFJh4fmL3Ok
   c4+fED9oU0FEsLrGyJhtDuX5DTw/EQEqunfwSsnSeenbeGrtoWCQ2DKJPcca8huRYVSw3YIOz4B
   CFF9YDbTm7Sx6v0EIGuF7ZRt/YmxAgL1qyqxHPB3eowjLhMnVjymWeEnQrnVJiVE1nDslsNW643
   woePohuQrQJaKrqLCXsylzJx/ZRetuEtir0OaA0f+mI4SbI3VlMSH0p26cCmM5fYKrr6GYJjF7j
   oCtMcQknRMGHcQ==;
Message-Instance:  m=1;
 h=sha256:
   8tyKrKjTXvavKxXLtUUO/GrJ91WYuWeK4i+uVERLt3g=:
   fivIcAd4rKt7AUTEW40BewMt8mNW8MG6LIlwpdkYJbI=,
  sha512:
   kcVNTBiYOp91P41GzFaI6Qsecf6mC6mDlv+sVA549DQrNMNHQbQA0R4m6NI9Vxs6nudIGvyxVi8cqZ0+pGJleQ==:
   6ok9KLgnMdcQTezwC9UVZnzzlB0pHgZ8U4Osfnui5Cs2zt8w2CSBuOgVN0cjYzmu3wue9Ot3MWQCM4BbSkL2KA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795685014; x=1796289814; i=markus.elfring@web.de;
	bh=9JSNdwZV67Uwnrr8l1kdCs7HPzDkZQfnoroyJMBz3l0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qvcFVzs93vTh4OmkjFWvfY5JXMEL2MnHSCaQtRZbVa21opWnmlAG0LVOpJPf6DW4
	 agQp0zfx7ID41obnzHdC5V6/Wz6JNWLvVhHZoO6fwnMe/5X9s9/Er/b1gBrut+ZwW
	 +uCsOA9zLG03KhY8QOt1P+Thad/4v+baiffbj4KTTlvb4pdV6gCsvYKvMWsPM7O8e
	 rUn+KwhFm4e4OwCKhuzzLknDhsYQhFxcW9zK23PzzD3Lq23pgZceNLO+3vE/lIjRz
	 n4oecbZQciTZglzzjr0UBE0oGfiDulGMKc+p6Ee3NeW+bX/t3AReDHrhVRCw6fmvv
	 0JZdgvjVIP7YDSuDyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1y3NbJ2suW-00SpYE; Thu, 26
 Nov 2026 10:23:34 +0100
Message-ID: <9e76edf9-433e-43ab-a748-8a71804e2b26@web.de>
Date: Thu, 26 Nov 2026 10:23:23 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [00/13] mmc: Assorted bug fixes across MMC host drivers
To: Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org
Cc: aaro.koskinen@iki.fi, adrian.hunter@intel.com,
 aidanmacdonald.0x0@gmail.com, alcooperx@gmail.com, allen.lkml@gmail.com,
 apelete@seketeli.net, aubin.constans@microchip.com,
 bcm-kernel-feedback-list@broadcom.com, chenhuacai@kernel.org,
 christian.loehle@arm.com, djakov@kernel.org, florian.fainelli@broadcom.com,
 geert+renesas@glider.be, hkallweit1@gmail.com, jan.glauber@gmail.com,
 jbrunet@baylibre.com, jh80.chung@samsung.com, josua@solid-run.com,
 kamal.dasu@broadcom.com, khilman@baylibre.com,
 krzysztof.kozlowski@oss.qualcomm.com, lars@metafoo.de,
 lgs201920130244@gmail.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 martin.blumenstingl@googlemail.com, mirq-linux@rere.qmqm.pl,
 neil.armstrong@linaro.org, niklas.soderlund+renesas@ragnatech.se,
 oakad@yahoo.com, paul@crapouillou.net, pb@handhelds.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, pramod.gurav@linaro.org,
 rric@kernel.org, sameo@openedhand.com, shawn.lin@rock-chips.com,
 support@cavium.com, tony@atomide.com, u.kleine-koenig@baylibre.com,
 ulfh@kernel.org, wsa+renesas@sang-engineering.com,
 yoshihiro.shimoda.uh@renesas.com, zhoubinbin@loongson.cn
References: <20261123191703.179283-1-lee@kernel.org>
 <bc602723-07fb-4af9-9201-272dd0fe759e@web.de>
 <20261126085340.GC38590@joneslee-macbookpro.roam.internal>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261126085340.GC38590@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hpuFpSStygnRjyGu4OdwI8scl5Tqdmf8IzYI4hnLjaMfqgtX7UM
 ibOS+HndZBacMC/YuZ61lDrnndFscX38s5dE89HRhg/oRr/1uYX0yiV5jqKjW2rh0aLEIIG
 CGKZmtpk+LJl8q+QZXKhYFZyjvldtY4SizqsqY2WEzDwV2w7W0LK1RjadRiOz2Gt/WAFilt
 Ncx5IupM7mNy4nEUvlyHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:27iBBxTNLss=;pM/2RWrGZu8RBZprcieS2TZSkdh
 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

>> How do you think about to sort (and group) desired adjustments
>> by affected software components?
>=20
> This is new to me.  What guidance says to do that?
>=20
> Making your own rules up and spraying them at contributors wastes people=
's time.
Can the following list variant be more helpful eventually?

  mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
  mmc: cavium: Remove MMC slots before destroying slot platform devices
  mmc: dw_mmc: Disarm central watchdog when ending a request
  mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
  mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
  mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
  mmc: omap: Shut down cover timer before disabling cover BH work
  mmc: renesas_sdhi: Disable internal DMAC BH work items on release
  mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
  mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
  mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe
  mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
  mmc: tifm_sd: Synchronise timeout handler with request completion

Regards,
Markus
