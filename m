Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F15244693;
	Wed,  2 Jul 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452856; cv=none; b=nmMVZOBiMhugcXNoIaiQHZ9G9jxOL4nFZk6Rse4T1IUFz4rWcklbRJKA6UmK2ozZXMNgv3SxBMLvDy1fQSTXZQ1cLytNYpcRDjT0O38iDd2FULMoSCYkoTc2nCrQrP44wlYqYVBxdIlZiz1/OitX0VErEdx8PjfNT5pJZJK3u+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452856; c=relaxed/simple;
	bh=KAOjTDNNfMtSybxzzyF1oxwUo5aPUGM4sbjOFZt9Egw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iKV36f/3iG/asv8wPWr1INZS4It40TY+KW8DcAoO/0YOTNpSpXIJjbTdZvBRt8/0Q72SrspLFrOyiwcyORHOFe47jhEC4m0I0ZVq+pPvXqQ5/n3NtuyjUT35Fi5WKDgft/eWKOjgX3ormoUA4R46o6kSVkwBmYFgPLxNa2xJxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DLhAkNIz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjE3Feu5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DLhAkNIz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjE3Feu5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E59EEEC0476;
	Wed,  2 Jul 2025 06:40:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 06:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751452853;
	 x=1751539253; bh=f+jtoViYxyDT44gIcm4ScVTqk+vWq1DU/+tdfl4XPXA=; b=
	DLhAkNIzpkFpF2GoJ3uXO9a8+MQ6k2VWe4RnvK7qkowKYBtldXKEwql0AgYcTQjB
	6C2WGef0oMQSUwiBTATwXRq1fdyId9dRkKldfFsUIkHvy3SGsHKcWikPXoGKSLLt
	v2wip6qoJcj8hM+PDREDXIZcj2EkeQ7if5I0NYHooVwe/TjMg7M5vGMutHYK4zpf
	JKC0nmlrS5+XaiYx0750b6NaXOi+l2CW/8JTaK/kEl2xcjoPDZzqDhBiCCp9loXn
	E1egiloLO7fam3tP42RGmEVWVsaCYom6LmTgVzHnipHhtuXbyUBAPYzjC4XuyTOZ
	E8VuUPkwCcc1E3QhpOxIMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751452853; x=
	1751539253; bh=f+jtoViYxyDT44gIcm4ScVTqk+vWq1DU/+tdfl4XPXA=; b=I
	jE3Feu53gTguVKZDRL2kpkOVMb0KpmQUwmy9BL89R82YGxQ5JpXq9mLZMvBykJdW
	VUnxvpLKIYW8/e27LfyQMFUtMZJ9qsDWtBije6DVCVDkc2eXN6XzNQej9/cxdVSe
	W7xNPLZs5DT0w76kYx/QXxUJkRdLWas8mPwQar8G5dxRsSMjzktgv/JdS+PjC7+/
	Js1sxemUhjDPWstGJDvLdLNJqd1BRuCif5Mz7kI9XRY53e4/9nVSHUcV8R33O2OY
	eCMG2IOhSds33jp2qgoKhriLBP5/HLWA7F2uZi1OX1oYCKNigZCGUVv4GPPYcv5q
	goVcU8Lu1AUUSGjBIQ0Tg==
X-ME-Sender: <xms:swxlaBcENGwyRdD3Lol3wY3YSNcqCO9oHyZae2kSARGeSYHVgoruRQ>
    <xme:swxlaPOD_MyZkjrHVqAMOiN_BgP7IyrLpyYVV5odiVEkfJkQrvK12v7S2pcZs3Nl8
    qQzw6DmdViY81zIqi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehgohhrughonhdrghgvsegsshhtrdgrihdprhgtphhtthhopegsshhtqdhuphhs
    thhrvggrmhessghsthgrihdrthhophdprhgtphhtthhopegsihhgfhhoohhtsegtlhgrsh
    hsfhhunhdrtghnpdhrtghpthhtohepnhhfrhgrphhrrgguohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopegsvghnrdgthhhurghnghesghgvnhgvshihshhlohhgihgtrd
    gtohhmrdhtfidprhgtphhtthhopehvihgtthhorhdrshhhihhhsehgvghnvghshihslhho
    ghhitgdrtghomhdrthifpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlih
    guvghrrdgsvgdprhgtphhtthhopehgvggvrhhtrdhuhihtthgvrhhhohgvvhgvnhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:swxlaKjYdHsDdvduhQ0MEcXOW8CMKc87KCvkl6RjdvJ5XPD31U32gA>
    <xmx:tAxlaK-bKjsdkvf85XBjTrRBq9bNDPMHJlelsR42NkRo33k7eUCebQ>
    <xmx:tAxlaNtHm_x50MZxO88JkjSADPwfsDVmVUJ6WcBMuB3nd79uTugexQ>
    <xmx:tAxlaJH2drl5pDUEuk4-L-F6GF3voZF2Kooj9dHI5mlDWaiEzFexTw>
    <xmx:tQxlaDuN7y1Aicd_OJNllKymHr1i7ALXMocCOAl2OmgXckDib_xxzhcp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7AA1700065; Wed,  2 Jul 2025 06:40:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf7f6c885039edc57
Date: Wed, 02 Jul 2025 12:40:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>,
 "Rob Herring" <robh@kernel.org>, krzk+dt@kernel.org,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "gordon.ge" <gordon.ge@bst.ai>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Geert Uytterhoeven" <geert.uytterhoeven@gmail.com>,
 "Will Deacon" <will@kernel.org>, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 soc@lists.linux.dev, bst-upstream <bst-upstream@bstai.top>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, bigfoot@classfun.cn,
 kever.yang@rock-chips.com, "Manivannan Sadhasivam" <mani@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Bjorn Andersson" <andersson@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Taniya Das" <quic_tdas@quicinc.com>, "Eric Biggers" <ebiggers@google.com>,
 "Victor Shih" <victor.shih@genesyslogic.com.tw>,
 "Shan-Chun Hung" <shanchun1218@gmail.com>,
 "Ben Chuang" <ben.chuang@genesyslogic.com.tw>
Message-Id: <53ba18c1-4554-4d77-84fd-d921febb7559@app.fastmail.com>
In-Reply-To: <20250702094444.3523973-6-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-6-yangzh0906@thundersoft.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 2, 2025, at 11:44, Albert Yang wrote:

> +
> +config MMC_SDHCI_BST
> +	tristate "SDHCI OF support for the BST DWC MSHC"
> +	depends on ARCH_BST || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects Synopsys DesignWare Cores Mobile Storage Controller
> +	  support.

The description does not mention the actual device it's for
but only DesignWare.

Try to keep this sorted alphabetically between the other
CONFIG_MMC_SDHCI_* backends

> +
> +struct dwcmshc_priv {
> +	void __iomem *crm_reg_base;
> +	u32 phy_crm_reg_base;
> +	u32 phy_crm_reg_size;
> +};

You are only using the first member here, the phy_crm_reg_base
and phy_crm_reg_size are assigned during probe but not referenced
later.  devm_platform_ioremap_resource() should help simplify
that code further.

> +
> +static void bst_write_phys_bst(void __iomem *addr, u32 value)
> +{
> +	iowrite32(value, addr);
> +}

You always pass priv->crm_reg_base into this helper, so
it would be simpler to make it take the sdhci_pltfm_host
pointer and the offset instead of the address.

> +static int bst_sdhci_reallocate_bounce_buffer(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned int max_blocks;
> +	unsigned int bounce_size;
> +	int ret;
> +
> +	/*
> +	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
> +	 * has diminishing returns, this is probably because SD/MMC
> +	 * cards are usually optimized to handle this size of requests.
> +	 */
> +	bounce_size = SZ_32K;

The comment says 64K, but the size you use is 32K.


> +	/* Get CRM registers from the second reg entry */
> +	crm_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);

devm_platform_ioremap_resource()

> +	/*
> +	 * Hardware limitation workaround:
> +	 *
> +	 * Our platform supports 64-bit physical addressing, but the eMMC
> +	 * controller's SRAM-based DMA engine is constrained to a 32-bit
> +	 * address space. When using the standard SDHCI interface, which
> +	 * allocates DDR-based DMA buffers with 64-bit addresses, the
> +	 * dma_map_single() operation fails because the DMA engine cannot
> +	 * handle addresses beyond 32 bits.
> +	 *
> +	 * To resolve this hardware limitation, we implement a bounce buffer
> +	 * allocated via dma_alloc_coherent() to satisfy DMA addressing
> +	 * constraints.
> +	 */
> +	err = bst_sdhci_reallocate_bounce_buffer(host);

Having an explanation here makes sense, but I don't think this
captures what is actually going on, in particular:

- dma_alloc_coherent() being backed by an SRAM that is under
  the 4GB boundary
- the problem that the SoC is configured that all of DRAM
  is outside of ZONE_DMA32
- The type of hardware bug that leads to 64-bit DMA being
  broken in this SoC.

I still have some hope that the hardware is not actually
that broken and you can get it working normally, in one
of these ways:
- enabling 64-bit addressing in the parent bus
- enabling SMMU translation for the parent bus
- configuring the parent bus or the sdhci itself to
  access the first 4GB of RAM, and describing the
  offset in dma-ranges
- moving the start of RAM in a global SoC config

It is rather unlikely that the SoC designer chose to
integrate a 32-bit-only device without adding some
way to configure it to access RAM.

      Arnd
