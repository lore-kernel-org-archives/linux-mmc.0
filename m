Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CAA926;
	Sat, 29 Mar 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743245198; cv=none; b=o/HKHax21DiKCyComWPIL+sL8REsuYzGtFdUO3+NmrbvaGeheBPtPMYaNutVnwmOa7SA7Oi7eOLChHbOnccMvAxeLxxrQblq3hEEbfBNYmIY1Q7R2gsAHNbOpRHlx5S0UKV0b3VdSHqFiTLasHYdZtPWxES1eUVDJ6SoZLtAB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743245198; c=relaxed/simple;
	bh=abBknvG1tnsdcfr1O8SPtZNsNVvcjshg8g4ItvKLiuw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j4jVg0s1U+TSNYO3NmW8T4WDJT+DMXxH4Ea/AcdAZTndqt+rONDQhK88eB1Xc2QIWf+kxMNGrA/K++VeHQTKWxSO0iO8/xWyaxgeBxBTMwjeYFQ+hKXkLeWs/am06Aln7cQ/kizNMAnIpnsC4dzCDBY1CYA6v4uadG5w9UisE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mAqDxCUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJ6T+T0n; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mAqDxCUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJ6T+T0n"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A0CF25401BF;
	Sat, 29 Mar 2025 06:46:33 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 29 Mar 2025 06:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743245192;
	 x=1743331592; bh=OLgBx+r6xkyWt3W/cG+UMLFBG12g5/2uvOpEZ4keCCg=; b=
	mAqDxCUkwen7TM7cFY3sJmJwVun6sZGtvCLRrgAp3fYxUy/imPb1G7nk+JiU3pBc
	mC7YGmYYaN0ZlFp31BzCu89vxZSH51oM4lFKAY1nEt2rEGIhjpX7qbqf/9xA7rmq
	DWasGE3K3p5VT4flT6GxgJwF1YzGljolSjZASyChTXypZ3wMfxZIM+l7nf6A/seM
	H18xf3DlrI2gJU3/+s3YrqebEq8vQJi3c9sqtRNbmGGYZytMaGlo8iwQ5B2sPpgt
	KifNfv4EfZOuVg8GTQ9B/rIP+39yaX+jwGH5OoE7e+RlNekjMyuw37DPQut8gF9c
	Ug0v1nt1RDomIY0JHiCvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743245192; x=
	1743331592; bh=OLgBx+r6xkyWt3W/cG+UMLFBG12g5/2uvOpEZ4keCCg=; b=W
	J6T+T0nberVqJlNjDsJuZ5jujgRA+Azs+RLaEn7CyeV7pQRlgwtI2Mfg3iM1CvKW
	42ZvD083ODClOj8j79BtmJ6C5Ehw7WxIh+6XGBLB4UQRQILq/RGvz5ndJiwc6HaW
	lwm44CTOx4SMvThE8MnHJiaWpokKEf3NLsSHq/d3bbWsZ4RqvG88jiVN3TfK4sv0
	bKCcSO+PO1DqnTBnlFRaWeWMhBtxFCfuF8dFaMjDssGwLUcRU/XJHyzJNLv2lI4t
	V62oTLHQ+kfO3KhQM+Zx3qkB16c0SyEEDTZOudeo9Rm+Dkx38LrhEVS9Vjf2sx6d
	PBYFHleHiSm3LuLveEfZw==
X-ME-Sender: <xms:h8_nZ66EMpfl-OKodZX6tkbM5rT7SN6PdaZZWN0w0oc7vhGtne4-XQ>
    <xme:h8_nZz7uFEB5e_TutvMsHyRGHqEMIk_3KdtCxmiIzFKsd2wmrNh42gCUNRV5M11ne
    h6w9Yz7SUioJewdD4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghijhhurdgurghsrdhjiiessg
    hprdhrvghnvghsrghsrdgtohhmpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshes
    ghhlihguvghrrdgsvgdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopeifshgrod
    hrvghnvghsrghssehsrghnghdqvghnghhinhgvvghrihhnghdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhmmhgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h8_nZ5d8fXOONevlZgzuIlDiCFSHIj7tuQzgfMDrDNwtRbQjDAciBw>
    <xmx:h8_nZ3IidfwCF2RxQD62Lh8quNIoxT1Dd8_YbvGa9Yg2h6D63v1ujQ>
    <xmx:h8_nZ-LaLZSlIrWGe7jJ3u2XHUINz8VOVpssg9V12Y3x72P0NUfTGQ>
    <xmx:h8_nZ4zaa48gWvggJTRy7dbmZKytZzU5SJ6zYxEmlSu2hWsbB2WENQ>
    <xmx:iM_nZ_qDrpW94WQaiSZTHwGXRsV4N5XGBNY_omCX9Jtk6qVUNR8DccBJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59E852220072; Sat, 29 Mar 2025 06:46:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdc810edfc44aecaa
Date: Sat, 29 Mar 2025 11:46:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Biju Das" <biju.das.jz@bp.renesas.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <70367c55-81c9-4387-b332-1e19ab8397d2@app.fastmail.com>
In-Reply-To: <Z-fBYVzkxZOqZixB@shikoro>
References: <20250329082123.2325267-1-arnd@kernel.org>
 <Z-fBYVzkxZOqZixB@shikoro>
Subject: Re: [PATCH] mmc: renesas_sdhi: add regulator dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 29, 2025, at 10:46, Wolfram Sang wrote:
> On Sat, Mar 29, 2025 at 09:20:52AM +0100, Arnd Bergmann wrote:
>
>>  config MMC_SDHI
>>  	tristate "Renesas SDHI SD/SDIO controller support"
>> -	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>> +	depends on SUPERH || (ARCH_RENESAS && RESET_CONTROLLER) || COMPILE_TEST
>> +	depends on REGULATOR
>
> Hmm, this is too strict IMO. SuperH does not need REGULATOR.

I haven't tried building on sh, but I don't see why it wouldn't
need the regulator dependency. The code that calls it is

        rcfg.of_node = of_get_child_by_name(dev->of_node, "vqmmc-regulator");
        if (!of_device_is_available(rcfg.of_node)) {
                of_node_put(rcfg.of_node);
                rcfg.of_node = NULL;
        }

        if (rcfg.of_node) {
                rcfg.driver_data = priv->host;
                rdev = devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rcfg);
        ...

which sounds like regulators are always needed when
of_get_child_by_name() may return a non-NULL pointer, i.e.
when CONFIG_OF is enabled.

If this is correct, maybe this is the best variant:

config MMC_SDHI
  	tristate "Renesas SDHI SD/SDIO controller support"
	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
        depends on (REGULATOR && RESET_CONTROLLER) || !OF

CONFIG_ARCH_RENESAS is only set when CONFIG_OF is also set,
so both subsystem dependencies are covered by that, while
SUPERH doesn't currently enable OF, but will need the
regulator and reset controller if that patch is ever merged.

      Arnd
