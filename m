Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C917276D;
	Mon, 12 Aug 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464633; cv=none; b=iZ4zQSacHH6wOGmzbtizuhYLbEgit2oHqsOA3qkU1QEqZg5rh4peGcS63JAeTJCcVQ/DQBAH5vn+WfswDvG1ZqLikmBXP5ZNGKcKTd7aQ4RAtxq8vrIOSGdsDjD7kJjD5oHYMwSbgfc9m98ouHOkiLefrsloTKylbY9HslGV05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464633; c=relaxed/simple;
	bh=Kf8udl+RPQSi7axWxfKiTe4EjZPZKVepns9CIQZinkE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBE1zdR3XttNavegrBVkBXFaq0KQd16fXBh07HT3raThJlvZXHtY1PJBLlx4H/H5yFnJpEvuD3tCz8mDCWsaIlJKJAZJb/vlYPpzHotWiY8A8IP7SwWm+jtD+mMTV3OCUTJr9gRuPSmwFRhwa04w8JUmBmWPVZ1QflUxCZVA5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Actt2aat; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Actt2aat"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36bd70f6522so2318382f8f.1;
        Mon, 12 Aug 2024 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723464629; x=1724069429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iqYcq999gsKKejZxZSj4pJ4zXAJ4qw8TpEhYqcXSNdM=;
        b=Actt2aatPPohW/NJ58gob8yQvfQof8OVmofjrxbYHFcf/0EzVlGT//hKkSR8VJJQFI
         LnN8Y8z+oOmNsvtvn8BwCplQkmdMW36TrXe4Tnom2N/tn6y2t4gNvwh25MO4OH1RiFkj
         ogBZocELVt/3PVJqOwXdge2WhAGCzBnDmgR5GYcieBENBALxZCaktHT7srdo3EGlfpQy
         CnCKyWbhgkRo7OSXea9f0b00o7ZcBwgmaTx2fFMGLEl2mxCdvBwU7uzJ571I7Oa3C+nV
         lUp/Cgb/Peohyw4FYxNHP3LwGqv0UBD0/oG6VI605BchtMLLnFTkvJnke6hivZCYxwGU
         ZLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723464629; x=1724069429;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqYcq999gsKKejZxZSj4pJ4zXAJ4qw8TpEhYqcXSNdM=;
        b=dsZ9KCI6lTP/tGN92hljq0Isq1+sMriC9gHI9MWeW3S80w8UtH+jHlasCKzN/avten
         KiDPuWbtmTjRW6AQW2oCiTItJojOE9rOxXlmlKM9OiKA4klABpctVzRJmTSakU0D5p7S
         mYlu4nNe9ocSkWtqRaOnDehKlgRXeuVlGVLv1oNyFrzH1rAusSnnn3x2LN6OvZ42tFlW
         zzuerZCFihofqgY4oFEEA5/vrcKH72nIJsPPXJgWdSciGHBqEnS/XeFnqRuKyudN9LdR
         O3/DYNq/4BATJsE40qkU08Mhv/cPSzXK27dHvC/8VhQgFdd65b81De2HSxyzP6cpsGHH
         313w==
X-Forwarded-Encrypted: i=1; AJvYcCVFBZRb3h/q/lKmpIZSyCkobUwLUO3EuG0lDzSBEzNdfL7TXPTvJQZo8R60FIQxYmnR/GFW2R7tcA+F@vger.kernel.org, AJvYcCWOMvc/BBuxSFebtxsPS1SBvSif3KBcNOjeHnKZWtmTOZVexD+Lecj7w3osx8UncuJ4BCrBPTZ3qeSytGFM@vger.kernel.org, AJvYcCXh9lIQRnLoPiQRhtvobJQ0x+Rc6Wj1YicQn3vgtItxnVNC0Drs1EdnBsOdmcEv+TkO2vJsn9O1tEWq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1x7e8HSRyxwOhC29bHdIYN02mfKL9JECiMEFbedEsQCbSQYNm
	baWBmzZyCGb7kkjajx39YBD20NVqPQgfJY+pNmY6AXFskDqyEh2l
X-Google-Smtp-Source: AGHT+IFSR5C1hi+8j8Ydkfy62l96VSbCD6ttYmxsw3lESIi7Z9k7B2B1FgWmEng6FK8xhpk8Hz2Qyg==
X-Received: by 2002:adf:f902:0:b0:367:91d8:a1d2 with SMTP id ffacd0b85a97d-3716ccfc64dmr97552f8f.30.1723464628820;
        Mon, 12 Aug 2024 05:10:28 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea82sm7362857f8f.72.2024.08.12.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:10:28 -0700 (PDT)
Message-ID: <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
X-Google-Original-Message-ID: <Zrn7tHHev-ydxq8n@Ansuel-XPS.>
Date: Mon, 12 Aug 2024 14:10:28 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-3-ansuelsmth@gmail.com>
 <20240812111205.GC14300@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812111205.GC14300@lst.de>

On Mon, Aug 12, 2024 at 01:12:05PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 09, 2024 at 07:21:00PM +0200, Christian Marangi wrote:
> > Introduce support for a dedicated node for a nvme card. This will be a
> > subnode of the nvme controller node that will have the "nvme-card"
> > compatible.
> 
> FYI, there really is no such thing as an NVMe card.  There is an
> NVMe Namespace, which is the entity that contains the block data,
> the Controller which corresponds to the pci_dev for NVMe-PCIe, and
> the NVMe Subsystem, which contains Controllers and Namespaces.
>

The chosen name was arbritrary just to follow eMMC ones. Can totally
change if problematic.

> > This follow a similar implementation done for mmc where the specific mmc
> > card have a dedicated of_node.
> 
> That's not a good explanation to be honest.  Most eMMC host controllers
> are OF probed devices, so of course they'll have an of_node.
> 
> Binding PCIe functions to of_nodes seems completely weird to me, and
> you'll need to explain what this totally non-obvious thing makes sense.
> Maybe it does, but it needs to be backed up with a very good rationale
> that is very clearly documented.
> 

But support of OF for PCIe is already a thing for a long time. (it all
works by setting the compatible of the PCIe ID card) and used in wifi
card at assign MAC address, calibration data, disable frequency.

In this context we would do a similar thing with declaring the NVMe with
the PCIe ID card (already supported) and we add support for defining an
additional subnode for usage of block2mtd.

The subnode is needed to keep consistency in how the disk struct are
defined with all the parenting levels.

Just to stress it more... This is really for consistency as PCIe OF node
are already a thing and on block2mtd (for example) the same thing can be
done with something like

disk->parent->parent.of_node (as it would point, if present, to the OF node
of the PCIe card (the NVMe))

With eMMC with the mmc-card subnode we would have to use

disk->parent.of_node

Not having this well organized and consistent schema in DT will result
in additional condition in the drivers...

Also consider that if the card is not detected, nothing is probed so
those additional node won't cause any harm.

If these 2 patch are problematic I can totally drop from the series but
it was really to add consistency in NVMe and eMMC. The real important
part is eMMC that is becoming the de-facto replacement for NAND/NOR on
high tier devices (mostly wifi6/7 consumer router)

-- 
	Ansuel
