Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20116D323
	for <linux-mmc@vger.kernel.org>; Tue, 25 Jun 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332491; cv=none; b=JHdTkNmXEx7NsnqKo4zQAqKtIn06V7wDGK/HjxfsiJhs3DGI2Pyb1nxQMlpUZT10YJsduafK7WqUjFmtH5wtZK1PLJAHSyaf+ekKdl/iYM/dJU5zjADkm4mcySfDlT+QwcI47/aqZYMdWY/jRMeun+pb7DiCcHmBHT+ljwwkrmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332491; c=relaxed/simple;
	bh=CqABDJyIvigPOHjeJkgCNT3v9E386/0PkbPOtvexrmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCi5NrHsGRgMm3vOXqQIgq4rCeM0+e5ca3BaSaGjYZXr22RUFW0x9gl7fL36LCusA01Z8jp6q7/ddoMHPouEgJJQvw008rHKLkHoymo5do/tZybPzSoc3VWo8xTUu2vFyeJ3vtbCyoOAg67QdbCUh99TxXVBN8EZ59fRSpcUavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=fS4b1QOw; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fS4b1QOw"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff305df675so6210917276.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jun 2024 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1719332489; x=1719937289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qb2E6wZdQOD4FpB99oMUsAKBgWpj20AwfW8pSsc6D5k=;
        b=fS4b1QOwgMlQUSHPstioQam5Mc1zkmTwNGxybwB+TmbBaqEULmHCf5adr5a5aFqaIB
         JzDnfVj4Uj0WLgHnSKH8yxlwfyEKIeMqzESqglDVlxVF5ZWjsqmg0aJlCLquwuIkdSP0
         2fUR+fdp18dONH7HpSpt38Lxv3BV0p9ra4Tx0q9EN5OpaRv4ZEik7RV3TWGn5LTmu8Qc
         sHpehnSNLOEKeYgJpwjqY9jKGcdyI/CpU8mUTpzvfIXQX5KeWh2Mc+w1xfnpcjsbwjLu
         XdrTuLW/u/C9Ca5jfT9BT2eRDv4TUYsAdTdQBdFVzO0veB/cI6ox86isdXLXFM/mWl8/
         /FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332489; x=1719937289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qb2E6wZdQOD4FpB99oMUsAKBgWpj20AwfW8pSsc6D5k=;
        b=YxC/L5gz4ETlZIZM9u6uEO5zyJIvq2RzdAKe5LkqMDCSwPXYnfyj+dIb6bhWjU5Gjh
         ba0RvTkQ8ocslJeLN/19hv0Hg0e2ZTY55nx0P2qXiYIQH7ESbdCFlxTjiPHvA+apFIwL
         PoI2JHuyqLRWGnFwJXq+O7Ph5nGXsTqB4Ln1DzeGqPiA7dUhuxNh9YqVDJ3TUjJoF1ve
         hLuhNLN8EnMSLQmKg4e1MNAzJTKgmEJgzxUlTMp4pHvqb31NwQJa3L4LDz4v6oguZXeN
         8XTIt6awTGCTiICY4pqeeqxPADQ0cApDfpcub6mBqGW0b4CeuZsGTfXpjjF1gvdR8NMe
         wTPw==
X-Forwarded-Encrypted: i=1; AJvYcCXurWAsz7w6fS3oPdAS1VUHAzTBm7nYKvQe8CKyhlukFmCpVKL8gov/yM2f1HtDyLwcI76An6F+HZCEFXHIGj1CW0g6M7RAD4AJ
X-Gm-Message-State: AOJu0YyLHqsJy7F0+oh/0+B87iPTCBfHSRaRfy5zFy36MRmA5locGcgc
	flkj29di6/+ajGXGlUl5d7HkHkH+lie1gBYuP+y79ju+BZv681QreX4oNyCkXaBS3yp0br9JMuc
	UzcZP77CvYGuOkRo6/OwNQlrsyY9um0ign0HMxg==
X-Google-Smtp-Source: AGHT+IFvJFRMGLkvlz90nUmrwbH4uLb1Am8e4l5s0tWHQCH+l8Gv5Qv98MQC7wZStmOIUJKeQ6T13TtnSRScfn8cC/s=
X-Received: by 2002:a25:28b:0:b0:e02:bd27:ffa0 with SMTP id
 3f1490d57ef6-e0303ff97e2mr7397168276.47.1719332489288; Tue, 25 Jun 2024
 09:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
 <20240524182702.1317935-2-dave.stevenson@raspberrypi.com> <20240528063332.GA30051@lst.de>
In-Reply-To: <20240528063332.GA30051@lst.de>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 25 Jun 2024 17:21:12 +0100
Message-ID: <CAPY8ntDuKjD08Q0Y8uukpd7ep85y2qoGDv8hPFxu3QPmL8+wew@mail.gmail.com>
Subject: Re: [PATCH 01/18] dma-direct: take dma-ranges/offsets into account in
 resource mapping
To: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vladimir Murzin <vladimir.murzin@arm.com>, Phil Elwell <phil@raspberrypi.com>, 
	Stefan Wahren <wahrenst@gmx.net>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux.dev, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christoph

Sorry for the delay in coming back to you.

On Tue, 28 May 2024 at 07:33, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, May 24, 2024 at 07:26:45PM +0100, Dave Stevenson wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >
> > A basic device-specific linear memory mapping was introduced back in
> > commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> > preserved in the device.dma_pfn_offset field, which was initialized for
> > instance by means of the "dma-ranges" DT property. Afterwards the
> > functionality was extended to support more than one device-specific region
> > defined in the device.dma_range_map list of maps. But all of these
> > improvements concerned a single pointer, page or sg DMA-mapping methods,
> > while the system resource mapping function turned to miss the
> > corresponding modification. Thus the dma_direct_map_resource() method now
> > just casts the CPU physical address to the device DMA address with no
> > dma-ranges-based mapping taking into account, which is obviously wrong.
> > Let's fix it by using the phys_to_dma_direct() method to get the
> > device-specific bus address from the passed memory resource for the case
> > of the directly mapped DMA.
>
> My memory is getting a little bad, but as dma_direct_map_resource is
> mostly used for (non-PCIe) peer to peer transfers, any kind of mapping
> from the host address should be excluded.

Could you elaborate on mapping from the host address being excluded?
On BCM283x DMA address != CPU physical address, so some mapping has to occur.

Robin Murphy directed us at dma_map_resource() in [1], and referenced
this patch as necessary because dma_map_resource() didn't currently
use dma-ranges mappings.
Mark Brown also hadn't corrected/objected to the statement that
dma_map_resource() was the correct call when I was querying how to
tackle this historic mismatch in [2].

I'll happily defer to the experts on DMA (I would never classify
myself as such), but I'm not clear on the direction you want here.

[1] https://lore.kernel.org/lkml/ee19a95d-fe1e-4f3f-bc81-bdef38475469@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/CAPY8ntBua=wPVUj+SM0WGcUL0fT56uEHo8YZUTMB8Z54X_aPRw@mail.gmail.com/T/

> (dma_direct_map_resource in general is a horrible interface and I'd
> prefer everyone to switch to the map_sg based P2P support, but we
> have plenty of users for it unfortunately)

Is that applicable for mapping device addresses with DMA_DEV_TO_MEM or
DMA_MEM_TO_DEV transfers?
Example use case on BCM283x is HDMI audio where the HDMI driver should
be passing in the CPU physical address of the audio FIFO, and that
needs to be mapped to the DMA address for the DMA controller. How do I
get a sglist for the peripheral address?

As noted in the cover letter for this series, if this isn't the
approved mechanism, then please let me know what is.

Many thanks
  Dave
