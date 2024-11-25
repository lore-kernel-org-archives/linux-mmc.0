Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EF18AFC
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537830; cv=none; b=IOEjJ9gfLYRHb1Wmuv50IcoYNVtD00++Z8vaXb6LHVmWeN+Ew+J4px7pzR0enZxcUx2qJM7ZUi2bf4h0OQmb/flb5tv95VdIFEi25XjBrMqvjKp0W1Mg9dbPn3lEcYwaEqzAFDkMXbj8VqVvN8M/kocoQqaWMDIWvtRaV9rko34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537830; c=relaxed/simple;
	bh=90SLUAANxsCMNsikNIE5wtExQy6eDEIMjWU4Ztyoltk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adkU2958gN63zwkb0LJ1SIYsIlKffBIuv3VeXpyYQD1GlTjBxkZgML/B1deeLsiPg1Z8DS2sBW78oFpK21zztFGXfGD1C5buBmL3WQkDic375PI9qjeb3F0mwtVQB1xQtVvbQ9Uss6ltdYCjTQD0G+3RVV4R5tG5DLaCszLtkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QF7w5+bP; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF7w5+bP"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e388186edbfso4127325276.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732537828; x=1733142628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zw2qX+qEwOD7kxM/1rDaAU3vYEgA4YRJTsR7kYlb6Ro=;
        b=QF7w5+bPP+41xBrEQ+CHc3crE56RPmTtAzwAE4leABXOY0xcPsCsEI/ZOrMmqNm8FB
         iRuaYcGxi7MSEGQSvAAy1btGq6XbnuMcrjHB4PIBNo/btokqk4HnFM0g5s1zVmrq/UZR
         vkzm+TpoL6O0FWmxVacbkDGgAyS0iJdSk6D/SBeT4e6dOtXE0Cg1nX6M6uY0R9CITQze
         2jLKIBIYxgHGt8zo56W18oYLPoulOIlMxHDf841swXyPvoHGRItXPi7JPZTz57Q13q+y
         RR4jsaVMU80minBdETJ+cpFVWQc4D0aRDFQcbXqZwNGppxdnfxlwKL4wAcslDT3jozuw
         kSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537828; x=1733142628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw2qX+qEwOD7kxM/1rDaAU3vYEgA4YRJTsR7kYlb6Ro=;
        b=lVGwSi3htwoHQxBH1Z+ekoqER+SKa4+EdD/Cw+yEOlcDznaLKd2wnz8n8mfj6rtg45
         dN/NgN9UcPc5qs5j5RITvapuoGGahxTH7QaSPIJNvKmEegjOkrf+R1Fh2OASApGh3deD
         v6pz6VgK2QglVIPbfCcvYYtwQARGXtaFCRtbhnu1HE5mHYyRdr0A8kGIK1jGxLT4R46s
         VCVxsO1aED58+HD/GgVZRcw/f2T6TO0Eqk6+Qdft3WTuhE/e1U/SymGWJcQA+0sktzvr
         umsRrX2b1vso7/4cAWDk/oiMy+S2kng4VGbPwS6v94PSVGh5fpe+1ueE209ao1aqp2r3
         PxdQ==
X-Gm-Message-State: AOJu0YyYiIqaxdhBA1ybGXQCIsZHGE4H8Lrz2JDH5C+/M9Qb/FSIFDhM
	ftWOVLuEaR3BHJvUfU5hWcIy465fkuBrhQ46WqgxWMeh0MBXU4SWTGkHsKg/KwzlAP90wQ6NCSJ
	uxLb+ZiTGlvMQInjWaqVHYQ6f18y3sN8VY+1t0Q==
X-Gm-Gg: ASbGncut+JA6Adamm+iYjuUqi31yyXuWiKnu5/TP1lQ8Z+XupsmpObQwnloQRLWGbQO
	VQxy0jR8RhcVyboLn5BLIc7BCYlxnaMbW
X-Google-Smtp-Source: AGHT+IFH0p/9xEc+3Rq2YR1Lv9xY1NRTZkhxV/CjYlHQTJAV+QbtfYW0ihI4U6npcE2X8QFHBgLw0DGUUHrz6gr8qzk=
X-Received: by 2002:a05:6902:2b84:b0:e38:99df:5406 with SMTP id
 3f1490d57ef6-e38f8bda10emr8355594276.40.1732537827728; Mon, 25 Nov 2024
 04:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BN0PR08MB695133000AF116F04C3A9FFE83212@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFrmMog-jemQb2-FGogq93+RACkoBXxOFRHUfYSkEsg4cw@mail.gmail.com>
 <BN0PR08MB695151B49A2CBFF1D293775883222@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAPDyKFo6BnHRg6G9vj6xiUncowUi59ExE3sCVLk8K+=6wqd1xQ@mail.gmail.com> <BN0PR08MB69513344FCF13A3CD7780B1283232@BN0PR08MB6951.namprd08.prod.outlook.com>
In-Reply-To: <BN0PR08MB69513344FCF13A3CD7780B1283232@BN0PR08MB6951.namprd08.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Nov 2024 13:29:52 +0100
Message-ID: <CAPDyKFrqQUSiZRx0Hr6ZcmrFq4-CRcCHqE+k+YKjdQfu1xfGWQ@mail.gmail.com>
Subject: Re: MMC card detection may trip watchdog if card powered off
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 18:47, Anthony Pighin (Nokia)
<anthony.pighin@nokia.com> wrote:
>
> > > > >
> > > > > If card detection is done via polling, due to broken-cd (Freescale
> > > > > LX2160,
> > > > etc.), or for other reasons, then the card will be polled
> > > > asynchronously and periodically.
> > > > >
> > > > > If that polling happens after the card has been put in powered off state
> > (i.e.
> > > > during system shutdown/reboot), then the polling times out. That
> > > > timeout is of a long duration (10s). And it is repeated multiple
> > > > times (x3). And that is all done after the watchdogd has been
> > > > disabled, meaning that system watchdogs are not being kicked.
> > > > >
> > > > > If the MMC polling exceeds the watchdog trip time, then the system
> > > > > will be
> > > > ungraciously reset. Or in the case of a pretimeout capable watchdog,
> > > > the pretimeout will trip unnecessarily.
> > > > >
> > > > >     [   46.872767] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> > > > 03220301 flags 0000049d
> > > > >     [   46.880258] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000001
> > > > >     [   46.886082] sdhci_irq:3558: mmc1: sdhci: IRQ status 0x00000002
> > > > >     [   46.891906] mmc_request_done:187: mmc1: req done (CMD6): 0:
> > > > 00000800 00000000 00000000 00000000
> > > > >     [   46.900606] mmc_set_ios:892: mmc1: clock 0Hz busmode 2
> > > > powermode 0 cs 0 Vdd 0 width 1 timing 0
> > > > >     [   46.914934] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > > > 00010000 flags 00000195
> > > > >     [   57.433351] mmc1: Timeout waiting for hardware cmd interrupt.
> > > >
> > > > Hmm. How is the polling being done? By using MMC_CAP_NEEDS_POLL?
> > > >
> > >
> > > Correct. (At least in my understanding.) 'broken-cd' in the device
> > > tree will trigger MMC_CAP_NEEDS_POLL to be set.
> > >
> > > > The above certainly looks weird. The mmc_rescan work should not be
> > > > allowed to run at this point, as the work is getting punted to the
> > > > system_freezable_wq via mmc_schedule_delayed_work().
> > > >
> > >
> > > This is the backtrace I get when the timeout occurs:
> > >
> > > [   46.154348] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > 00010000 flags 00000195
> > > [   46.161917] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > > [   46.167743] mmc_request_done:187: mmc1: req done (CMD13): 0:
> > 00000900 00000000 00000000 00000000
> > > [   46.176526] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg
> > 03220301 flags 0000049d
> > > [   46.184016] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> > > [   46.189840] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> > > [   46.195665] mmc_request_done:187: mmc1: req done (CMD6): 0:
> > 00000800 00000000 00000000 00000000
> > > [   46.204362] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0
> > cs 0 Vdd 0 width 1 timing 0
> > > [   46.219307] CPU: 6 PID: 153 Comm: kworker/6:1 Tainted: G           O
> > 6.6.59 #1
> > > [   46.231988] Hardware name: [Redacted]
> > > [   46.238678] Workqueue: events_freezable mmc_rescan
> > > [   46.243466] Call trace:
> > > [   46.245901]  dump_backtrace+0x9c/0x128
> > > [   46.249643]  show_stack+0x20/0x38
> > > [   46.252948]  dump_stack_lvl+0x48/0x60
> > > [   46.256603]  dump_stack+0x18/0x28
> > > [   46.259909]  mmc_alive+0x74/0x88
> > > [   46.263128]  _mmc_detect_card_removed+0x3c/0x158
> > > [   46.267735]  mmc_detect+0x30/0x98
> > > [   46.271040]  mmc_rescan+0x94/0x238
> > > [   46.274432]  process_one_work+0x178/0x3d8
> > > [   46.278432]  worker_thread+0x2bc/0x3e0
> > > [   46.282171]  kthread+0xf8/0x110
> > > [   46.285303]  ret_from_fork+0x10/0x20
> > > [   46.288878] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg
> > 00010000 flags 00000195
> > > [   56.793379] mmc1: Timeout waiting for hardware cmd interrupt.
> > > [   56.799116] mmc1: sdhci: ============ SDHCI REGISTER DUMP
> > ===========
> > > [   56.805545] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
> > > ...
> > >
> >
> > Okay. If this is system suspend, it looks like the workqueue didn't become
> > frozen as exepcted. I don't know why, but this needs to be investigated.
> >
> > If this is a shutdown, mmc_host_classdev_shutdown() should be called to
> > "disable" the mmc_rescan work from running the code causing the above.
> >
> > What am I missing?
> >
> > Kind regards
> > Uffe
> >
>
> This occurs in response to a 'reboot' command.
>
> Here is an instance of the failure, with initcall_debug set to 'Y':
>
> Rebooting...
> [   44.500858] caam_jr 8030000.jr: shutdown
> [   44.504805] caam_jr 8020000.jr: shutdown
> [   44.508748] caam_jr 8010000.jr: shutdown
> [   44.515349] tpm tpm0: shutdown_pre
> [   44.523165] igb 0000:01:00.0: shutdown
> [   44.558695] usb usb2-port1: shutdown
> [   44.562268] usb usb1-port1: shutdown
> [   44.565864] xhci-hcd xhci-hcd.0.auto: shutdown
> [   44.570306] dwc3 3100000.usb: shutdown
> [   44.574052] [Redacted] 2030000.i2c:cpld@41:watchdog: shutdown
> [   44.580137] tpm_tis_spi spi2.0: shutdown
> [   44.584054] spi-nor spi0.1: shutdown
> [   44.588066] spi-nor spi0.0: shutdown
> [   44.592112] mmcblk mmc0:0001: shutdown
> [   44.595902] mmc_mrq_pr_debug:274: mmc0: starting CMD7 arg 00000000 flags 00000000
> [   44.603413] sdhci_irq:3546: mmc0: sdhci: IRQ status 0x00000001
> [   44.609240] mmc_request_done:187: mmc0: req done (CMD7): 0: 00000000 00000000 00000000 00000000
> [   44.617939] mmc_set_ios:892: mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> [   44.627877] mmcblk mmc1:0001: shutdown
> [   44.631709] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03200101 flags 00000095
> [   44.639200] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> [   44.645027] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [   44.653727] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flags 00000195
> [   44.661296] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> [   44.667123] mmc_request_done:187: mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> [   44.675907] mmc_mrq_pr_debug:274: mmc1: starting CMD6 arg 03220301 flags 0000049d
> [   44.683399] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000001
> [   44.689223] sdhci_irq:3546: mmc1: sdhci: IRQ status 0x00000002
> [   44.695047] mmc_request_done:187: mmc1: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> [   44.703746] mmc_set_ios:892: mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
> [   44.713667] aer 0000:00:00.0:pcie002: shutdown
> [   44.713673] mmc_mrq_pr_debug:274: mmc1: starting CMD13 arg 00010000 flags 00000195
> [   44.718102] pcie_pme 0000:00:00.0:pcie001: shutdown
> [   44.730534] pcieport 0000:00:00.0: shutdown
> [   44.734898] fsl_mc_dprc dprc.1: shutdown
> [   44.740863] fsl_mc_dprc dprc.1: DPRC device shutdown
> [   44.745830] mmc_host mmc1: shutdown_pre
> [   54.873286] mmc1: Timeout waiting for hardware cmd interrupt.
> [   54.879023] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   54.885453] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002202
>
> The trigger CMD13 is in-flight at time 44.713673.
> The mmc_host mmc1: shutdown_pre is at time 44.745830.

Thanks a lot for providing the details! Yes, this certainly points out
the problem during shutdown/reboot.

I have sent a patch [1] that I think should address the problem. Can
you please test and verify it?

[...]

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20241125122446.18684-1-ulf.hansson@linaro.org/
