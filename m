Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233674;
	b=hhGtBDFw/3K/+mFcGwOLXgDD5QgL/eHDmkH9ZPEYilAbHZ++to/+4i9PjcKem2u+APkW
	 bc5/BBRrMQBe/wD2b2GlNouQsh6ScGXvXZDjYcDT9lYmcPNs3Le9CRyja6YxixJId0dm0
	 dm8bfo63iHLp4hKwg/J0MB7mEkdZ/d8p1WPLW0n0Kdzjgg9s+aj6UfT/joEn5SEG0okTC
	 G/nG3oXYWnJ9HmV3R/0rN4am6+k+ToEewa96Fyz5jWLdv6SUE24M6WVa7MXy2MW+a/nao
	 qOhjfJn6p8mU8Sjhn0FUaEVclMhMRDpbkV1imdhnCA60LrTi0bSPX7a1KEi5inKGEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233674;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=7VxWNVzt6ar4iWWbog0PYNETnif0qpDKeOptuWIO4js=;
	b=A9HsqgtNTruyNstoQx7QB8kE5ZN8LE2h0fcgS88pQr4NjNW747k4sbjoFTpJ7NGn6pYE
	 ufeA33EEW5aV+nd5UFCdR0M2uBAdDVVXibzECbIDr8QHje+vuup4QBsQEIptN0hKiQi19
	 n86jxYsB1naBlgn2QWC4fGDplU9mKyBf82/k4i0yYSBry6772zVXvU83OSkPbQ8NGBdqu
	 vStlr1+ECOstewaLKKdpT1DK9IriMPY4APYtt0j/sdaj6hHDAbX8OrN/sEQYvehRN2tBG
	 j0TEXbHANivOd4+fi52kHaVb/6MsuOlzvghkvVUHA451CgH6FjuEdBmXjaR4jzDrSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=fOVLf054;
	arc=none smtp.remote-ip=210.79.60.71
Received: from mail-m6071.netease.com (mail-m6071.netease.com [210.79.60.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67AA606A31A;
	Thu, 29 Oct 2026 00:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B67AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=fOVLf054
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52b5dff72;
	Thu, 29 Oct 2026 08:27:42 +0800 (GMT+08:00)
Message-ID: <3395e65a-aece-4a91-be3c-aa36df8998ab@rock-chips.com>
Date: Thu, 29 Oct 2026 08:27:38 +0800
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
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@linux.dev>
Subject: Re: [PATCH v2 0/3] Add SDIO userspace passthrough support
To: Ulf Hansson <ulfh@kernel.org>
References: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1850e300003a4kunm1bdf6d7bfd0ab
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUsYVhlJTUpMT0seTkJNGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fOVLf054l36qVI6OpG9tb/zpfxgDNZBFz3Ba3IJWcYwi4HLYa/bWUrUoAmcaplXRMQqiGvuZKwl4xX+uF5J49hm9ljYVpr9XZ4HAGe2IMPFasrWL87mnPS1ZGKg7/6vE7LfSDKQdB+RC2obbQwbAsbWMcuoKZKMZ81IQ7PUfob8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7VxWNVzt6ar4iWWbog0PYNETnif0qpDKeOptuWIO4js=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf

在 2026/09/21 星期一 15:18, Shawn Lin 写道:
> SDIO cards are normally driven by function drivers (brcmfmac,
> mwifiex, rtw88_8723bs, ...), but bring-up, debugging and factory
> test frequently need to poke the SDIO register space directly:
> CCCR/FBR in function 0, or vendor registers before any function
> driver is bound, and some deployments, notably lightweight IoT
> boards, want to handle the SDIO function entirely from userspace.
> Today the only way is to write a tiny kernel driver per device.
> 

Gentle ping...


> So this series adds raw userspace access to the SDIO register
> space as well a small reference client. Meanwhile, adding a new
> documentation about how to write a proper SDIO function driver,
> because I have recently been working on SDIO function drivers
> and kept referring to the existing drivers for guidance. It turns
> out that the knowledge is scattered and there is no unified document
> describing how an SDIO function driver is supposed to be written,
> despite the MMC core having clear expectations about how the APIs
> are used.
> 
> In particular, the interrupt model has many pitfalls:
> sdio_claim_irq()/sdio_release_irq() must be called with the host
> claimed, the handler runs with the host already claimed and must
> not sleep or claim the bus itself, and sdio_release_irq() must be
> called from ->remove() because it is the last chance before the
> core removes the function devices from mmc_remove_host(). Recent
> fixes around the SDIO IRQ work and host removal and the discussions
> on the mailing list showed how easily these contracts get broken.
> 
> Also worth documenting is the buffer requirement of the CMD53 based
> helpers: the core builds a scatterlist directly from the caller's
> buffer and the host driver maps it for DMA, so vmalloc() or stack
> allocated buffers are not acceptable, while the CMD52 byte accessors
> are safe with stack buffers.
> 
> Changes-in-v2:
> - drop RFC as I don't include mmc-utils to be sdio usersapce tool
> - add sdio doc
> 
> Shawn Lin (3):
>    mmc: core: Add SDIO userspace passthrough character device
>    tools/sdio: add sdio-raw userspace client
>    docs: mmc: add introduction to writing SDIO function drivers
> 
>   Documentation/driver-api/mmc/index.rst             |   1 +
>   .../driver-api/mmc/sdio-function-drivers.rst       | 211 ++++++
>   MAINTAINERS                                        |   2 +
>   drivers/mmc/Kconfig                                |  11 +
>   drivers/mmc/core/Makefile                          |   1 +
>   drivers/mmc/core/sdio_bus.c                        |  12 +-
>   drivers/mmc/core/sdio_cdev.c                       | 189 ++++++
>   drivers/mmc/core/sdio_cdev.h                       |  21 +
>   include/linux/mmc/sdio_func.h                      |   4 +
>   include/uapi/linux/mmc/sdio_ioctl.h                |  48 ++
>   tools/Makefile                                     |  14 +-
>   tools/sdio/Build                                   |   1 +
>   tools/sdio/Makefile                                |  66 ++
>   tools/sdio/gen-sdio-ids.sh                         |  59 ++
>   tools/sdio/sdio-raw.c                              | 714 +++++++++++++++++++++
>   15 files changed, 1346 insertions(+), 8 deletions(-)
>   create mode 100644 Documentation/driver-api/mmc/sdio-function-drivers.rst
>   create mode 100644 drivers/mmc/core/sdio_cdev.c
>   create mode 100644 drivers/mmc/core/sdio_cdev.h
>   create mode 100644 include/uapi/linux/mmc/sdio_ioctl.h
>   create mode 100644 tools/sdio/Build
>   create mode 100644 tools/sdio/Makefile
>   create mode 100644 tools/sdio/gen-sdio-ids.sh
>   create mode 100644 tools/sdio/sdio-raw.c
> 

