Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CA2973BA;
	Tue, 15 Apr 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721866; cv=none; b=p9RbXbl0G9pGD2sNue0nQtLY/DJGaUGNRt1k20UsYD7sr/arQ7RyZkHzbZ0PpLwMxE/22HpLbg4c2OD0w7TLRiZcDGqesPzbukADxftN/r1En0CRCvhEZUDBm/yXB4EpwRlAdd+6hL7uWC+f8BgxP6FRjjb17S8V1W4UcJcY3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721866; c=relaxed/simple;
	bh=LFJwyTd6MnFShSXdxjp8wlhVfuya8ijcIKgjmhM9bmQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h5G3f2u5JewcIYU/DMJhOKXFfKgihkvJ9q8Avksl+WuN619ZUsliFI33VvWTTdB2SOFHK86COMkpGyx4x3DQ5bdIuTalKd98mVAySPR1OuunsHU25MiDHF/z7ZhL3UKeR1Lp/GHjrgC3oPQc2m7ckzwAYL+5oIfM7Db1Kinegbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TWPZXhIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gMKqPC0G; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TWPZXhIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gMKqPC0G"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 905C7138082E;
	Tue, 15 Apr 2025 08:57:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 08:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744721862;
	 x=1744808262; bh=B8S7VT2gS3fok2d/qA8u7a8APeUMe4HZUSTTc3nUw6Y=; b=
	TWPZXhIBh8wmWu9rdDyrY9bNCSvE4Bwkzh+EcqV5pO4hl2PsZG0jv+iCShQ9ZLIM
	/G8+3jPTBZi7Cb0AFDctEHPkeGPaTxy0AblYI9pzfnNkt9RtMf4bSgaGrWz6Grj5
	SCFotlzO+WEDd8yl549Sy20Sc1Tc8qNqSI0o0xuvs3sLMILv6PNy1pCUAT/Hu/ZG
	UHfmaKlG/o6bOXg+6RkFy+vRZbfdE8wM2ScRX7FVKtpSDcDWuCxY+VYw9XQNJgYa
	9paYpDk/VIPgsjTqDtwRpzCoZpbhgQrf0JGoG6v1GzDqzv9Riuv/PNKha5iwgs+I
	E5+jWWOJogX20i0pSWbF/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744721862; x=
	1744808262; bh=B8S7VT2gS3fok2d/qA8u7a8APeUMe4HZUSTTc3nUw6Y=; b=g
	MKqPC0G/Tkl5IbFu03/d6RuwKfziw1jaUgKWvcmKd9L44fufUt6jVPq2TyizhWWC
	vJEl/S5zgSJUKfxMWoQyHuFfRI/zZ6eJUAvP1VDZUexrEie0eJBLKZVSYt90pYek
	E7BOfLmfn5gjUCf8a3Hq+ZDVhqX3N2GJQPZG73VEqWavOsMk/5s+vuOfjoF7uxUK
	X+EfXsvsKekuxT1MQN3UVCJmHG50ueKLyXDn19kIyTanZtHhfFH0epcNy4xdMA8a
	Q8364S/WNFfR2vxcTpVciHAz8zL0l/0WIVfiTpaipY8Um8Xk//x+tBxFQo7JPQYa
	e0GXg4eySZSf/ptnHRWRA==
X-ME-Sender: <xms:xVf-Z1NNS0pn0p9cbCaLBXdutrNGto_a7g88DmCz6j9JmcNiM3W7ww>
    <xme:xVf-Z3-aAtT-qB9mUC7t5832mntXOAMgqQqZ7g7kyk1tsZ8-qnzdhI8O91h_XdLwj
    ifT00euLvvZSSfZpYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgt
    ohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    grfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshho
    nheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepihhmgieslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsfedvsehngihprdgtohhmpdhrtg
    hpthhtohephhgrihgsohdrtghhvghnsehngihprdgtohhm
X-ME-Proxy: <xmx:xVf-Z0Q6XiJgne4OAMJJq3ehog6MuP1NxtSCubIFKfjbfEsdzNxlCw>
    <xmx:xVf-ZxtTCz5mKaO6dHVJGfzsCY_dQJxoMY6L_FrziU6krO3Ri3WE8g>
    <xmx:xVf-Z9dopNq9m7WPCjQuRIRsAEkjijdupk2iN0EVThipuU1A1mxLEQ>
    <xmx:xVf-Z91pTGez8d5wkbB28IgbXPhN-cLxMe6HpTUxUVDYBf54eBJShw>
    <xmx:xlf-ZzPyMxFalFCb0HMH_zLxyMXL-SMFMB9zamHYBxNuWZcr2TX73yYh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE53A2220074; Tue, 15 Apr 2025 08:57:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4d63d28ce2d16200
Date: Tue, 15 Apr 2025 14:57:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Luke Wang" <ziniu.wang_1@nxp.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Haibo Chen" <haibo.chen@nxp.com>, "Adrian Hunter" <adrian.hunter@intel.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>
Cc: "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Josua Mayer" <josua@solid-run.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "NXP S32 Linux Team" <S32@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <3d544dbc-863d-4ac5-9839-aef3a36881d1@app.fastmail.com>
In-Reply-To: 
 <DU2PR04MB856729305860ED5C3C545771EDB22@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <20250411085932.1902662-1-arnd@kernel.org>
 <DU2PR04MB856729305860ED5C3C545771EDB22@DU2PR04MB8567.eurprd04.prod.outlook.com>
Subject: Re: [EXT] [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Apr 15, 2025, at 05:15, Luke Wang wrote:
> Hi Arnd,
>
> This patch has compilation issue because sdhci.c still uses #ifdef 
> CONFIG_PM. Do you plan to send a new patch to fix? If not, I can send a 
> patch to fix the compilation warning.

Can you see if the change below is sufficient? I see I have that
in my randconfig tree and I did not see any problems with my
v2 patch and that. I probably added that one originally because
of some other build failure but then never sent it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd0e35a80542..4ee2695b0202 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -874,12 +874,10 @@ irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
                           dma_addr_t addr, int len, unsigned int cmd);
 
-#ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
-#endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
 void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
