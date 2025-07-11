Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C51DF25C;
	Fri, 11 Jul 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216971; cv=none; b=saZTCYQxj26yeIY3bkczUiiIyiyQ3RzmjnT5wbVFm39+Sfm1OQwQyXiLoW/wVRRZU8IZUGUdgiO3s6WIe0aXNXZhP2GTKiqJwykrFsoU3n9tjVADflAySFlHySLBBupD7d0Q/UeE8EFEMpP8UOg0MHOLyb2fqiLGI7ASUI3SvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216971; c=relaxed/simple;
	bh=XgGLwjBI/BLttcKWbYKBlD9gn7f1n3yMFxlQBgojBWw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PCHgAAjXyatw9d4yD1aDp0QgoKfCjc8EEriOk8X34siFvI5xB49K8WymBLq9HoNmJ0edCA6zi08c1jmm4KBhw+5MQtKTwErA8LnGfV67ldo9LGEPMOOA/WOtgQtOmWqIBSyuAt5gU6iu+14rafQjhjaQVrjz1TSSpE4aT/V5nO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cBIdodbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKc9ruPx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cBIdodbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKc9ruPx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5C1A7A0182;
	Fri, 11 Jul 2025 02:56:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 02:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752216967;
	 x=1752303367; bh=M4Xvz+KPK37iLn4olXTWpx65q/NHcXwB/dKGeGt7s/A=; b=
	cBIdodbsNpx1wCWAd2Et1s7xbAczlMvnaVsLW7AF4nSuMV+SWVR30UaPAiO+gQ/z
	B5wWqNk2VBja3lN4t5aJV6AK0c9ds8obU9TJ6A6P8tqbE6OkNcyC+Vsb/EiuY1w6
	j0nU4XwizVUfYb1tBm6V66ZZWWRi0nuLUNnEMXMuPLDkt2/C841OY9ZIaSLy+V7u
	T8dWHtveaGdCzBAAqa2Eww3k4GF3Z573LEsGas7ndZ9rlcWq5glk5x8YQb3OeZzA
	hzxuqKyUCTWmgWWyQDk29Tll0bn3rF6LRwtbCjgTjLxwfrYWr7JwzB3f7nniYbNS
	dDAdeCItZoSi15/CBrTvMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752216967; x=
	1752303367; bh=M4Xvz+KPK37iLn4olXTWpx65q/NHcXwB/dKGeGt7s/A=; b=L
	Kc9ruPxAYBW/TmY+QLqk1vE3VKM4uAj7/5U+Xabz4xVEM+jLVsSImO9I2ZzyZZsF
	nHzWomZZBC7gzqf03Tp6H317gdXHfOIwe+djDiCWsvzlTpcq0oS47eXxmxn38iDg
	pyPOLZFt+lyqiPuxQ5g2Y+JglG4fLLC7ARsvrVUfxUJdcA/wlNLLp0df2utLFD86
	st/IPreKT3IVYEJyGT0Q2zKQQ6b7XvVBpPSGWA3P75MQhcZMo03U3j05eqZudjto
	sb0rV6d+AxfT2RMTt69f4Todze2ii6jH3iG1hrKbgz5iyTSex1OER/ekNKp3kq2A
	Fkj+NYbfHfWUjHLcsc/mQ==
X-ME-Sender: <xms:hrVwaNgekwpTo7adTlk91SjiD8clBFD4Bmddb7aSvQCmVgcVUYDiZA>
    <xme:hrVwaCBOcLXUJwNA_0fCqYhfGjefDHyt7IXm7G2A2IBEeM1seX3yrl3NQfAbhTQPt
    719IdOPbFNU-gEsJCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgohhrughonhdrghgvsegsshhtrdgrihdprhgtphhtthhopegrughrih
    grnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhlfhdrhhgrnhhs
    shhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohephigrnhhgiihhtdeltdeisehthh
    hunhguvghrshhofhhtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hrVwaAj2E8c1PSzr7c1zp7N541EXQpYHoT9Wp2Jp_8IUkGo-B0IAMg>
    <xmx:hrVwaLT1uHCsBPw-MB7MmG4YhdxiqzHRYbuo73pyjGA8xKLlrvEEhw>
    <xmx:hrVwaKUxtLAm5nsB2AlIxom3OS5102MVMdE51W6ZgA-lx0tBMEsdAQ>
    <xmx:hrVwaHTPHorkAMCiuDh_KLsaUzEP6evPZgD3nngan1WSoeWgqMf1Ew>
    <xmx:h7VwaL1Q7KUDKF0ZTXdoVa5AmyYih7zzx1pqpfSY1NLvuwsxSXoVE1Fp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C387E700065; Fri, 11 Jul 2025 02:56:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf7f6c885039edc57
Date: Fri, 11 Jul 2025 08:55:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>
Cc: "Adrian Hunter" <adrian.hunter@intel.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>, "gordon.ge" <gordon.ge@bst.ai>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <05e13ba9-c1fe-450a-a159-9693edce0a23@app.fastmail.com>
In-Reply-To: <20250711055529.1321072-1-yangzh0906@thundersoft.com>
References: <53ba18c1-4554-4d77-84fd-d921febb7559@app.fastmail.com>
 <20250711055529.1321072-1-yangzh0906@thundersoft.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jul 11, 2025, at 07:55, Albert Yang wrote:
> On Wed, Jul 2, 2025, at 11:44, Arnd Bergmann wrote:
> Regarding these last two suggestions, I'm not very familiar with the 
> implementation 
> details. Could you provide more guidance on:
>
> 1. **dma-ranges approach**: We tried adding these properties to the 
> device tree:
>    ```
>    dma-ranges = <0x00000000 0x00000000 0x100000000>;
>    dma-mask = <0xffffffff>;
>    ```
>    However, we still encounter DMA addressing issues. Are there 
> specific 
>    examples in other drivers we could reference for similar hardware 
> constraints?

The way that 'dma-ranges' is supposed to work is that it accurately
describes in the bus node how a child device accesses the parent
view of the physical address space.

The 'dma-mask' property above is not a regular property, but the
dma-ranges you have looks similar to what you have for a 1:1
mapping of the first 4GB, matching what you describe is the
actual hardware mistake, but you are using the wrong address/size
cells for this bus:

+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x0 0xffffffff 0xffffffff>;

What your dts file describes is that there is a single 64-bit
bus named 'soc@0' that contains the entire 64-bit address
space. You have given an explicit 'ranges' property that
maps everything except for the final byte in the downstream
direction, which is equivalent to having an empty 'ranges'
property. You have left out the upstream 'dma-ranges'
translation, which I think means you just get the default
that matches 'ranges'.

Presumably neither of them are correct. In most SoCs there
is more than one bus, and you have already said above that
the actual bus that the sdhci device is on only uses 32-bit
addressing, which for a 1:1 translation would look like

+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;

meaning that doing an mmio access on the first 4GB of
CPU address space gets routed to this bus at the same
address, and that any device trying to do a DMA only
works on the first 4GB as well, which then correspond
to the bus itself, not to RAM. If that is your setup,
that would explain how the SRAM and SDHCI devices are
both on the same bus and the SDHCI can do DMA internally
on the bus, but cannot actually reach RAM.

A more sensible setup would be to have the DMA access
routed to the memory controller. Since memory on your
system appears to start at 0x8.00000000, that would look
like

        dma-ranges = <0x0 0x0  0x08 0x00000000  0x1 0x00000000>;

which means that a DMA to the first 4GB of the bus
address space gets routed outside of the bus into the
first 4GB of physical memory. Obviously you cannot just
change the dts to pretend this is the correct mapping, you
have to also program the bus controller to use it.

The datasheet for the chip should tell you specifically
what type of bus this is (AXI, AHB, OPB or something else),
and what registers are used to program this mapping. It
is possible that this cannot be reprogrammed, but more likely
there is a hidden register that is made available to the boot
loader but is not intended to be reconfigured by the OS.

> 2. **Moving RAM start position**: Which component would control this 
> configuration? 
>    Would this require bootloader parameter changes or SoC-level 
> configuration?

This would be in the early stages of the boot loader that set up
the memory controller, as it is hard to reconfigure the RAM
location after you are already running from DRAM.

> The v3 patch addresses all your code structure and documentation concerns 
> while providing a clear explanation of why this approach is necessary for 
> our platform. I have also fixed compilation warnings about unused variables 
> that resulted from the refactoring.
>
> **Current DMA Issues**: Despite setting DMA32_ZONE, we still encounter DMA 
> addressing warnings. Key error messages include:
> ```
> DMA addr 0x00000008113e2200+512 overflow (mask ffffffff, bus limit 0)
> software IO TLB: swiotlb_memblock_alloc: Failed to allocate [various sizes]
> ```
>
> This confirms our hardware limitation where the eMMC controller cannot access 
> memory above 32-bit boundaries, even with ZONE_DMA32 configured.

All that this confirms is that Linux observes an impossible configuration
where RAM starts above the DMA32 zone.

       Arnd
