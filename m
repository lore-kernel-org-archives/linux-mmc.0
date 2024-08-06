Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0E1C4618;
	Tue,  6 Aug 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948921; cv=none; b=LFskbJw480+L+RzYMRBnZpgt4EtyjTOGT2vOsv9TznjHpwHPIPb/SHEYU7DWCvsL80TdEsQov208if/6HV/K66eE6N+e8a29D/iD9t9SexC9s6KDMjzVhcIJ/4pXMEQdRagQVVjNvhay3AocuyNvORgIhmAhIoRpdZd4Jgp6qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948921; c=relaxed/simple;
	bh=lmDlYyysbWwU5impefWx9g8E0dYTl9UV2mnU9LDBMTs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfP6qNdhO0z8SqRqGj0OYSj3JMoYbyPZYow8mKkUor/xHzsKk9GCNp3gH1NyS/okafROjVnoSQppxM64P9s43VuAdC4CPQ+16NFwM2ODpC9+i16N8DIGR2xH0ByqXyU5hY6ebxrxpTf2iYD6yhb2Ubpgi24Knh7naqrRs2e6Y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgzPEcBR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgzPEcBR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42812945633so4844875e9.0;
        Tue, 06 Aug 2024 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948919; x=1723553719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuJWybY/5l5UyBwF8mZPkMRRtpH0IYFVeNn3er57z18=;
        b=kgzPEcBRPni6G8flHYVhEsWrNsIAYMWovdLAD9ftG9CfhkuW2CUT/zcFgpnk8B8REk
         024PvmSoH/V+jYCeHSNW70x9Qo7cYCDZy/NYEQN+V3bu/2Ai6WBOD+YvjDCxfnkMCnXg
         Se4mxd2Gj87pcShIwU5NliUpGzDyuKDLIBWZisnICwL0xOnmGpsuZvDcVZYfiVx2qOxw
         XzHKMzmXeSaDJlyOPxp0+vn6iG+qWOLXkjXC9h/ZoAoYCcMXQsWeZX7oiJRqJfDJmfxV
         YdB3zvQ6t0/rzeGlIOF60RfuPnNhWmIDfSQC78wERm/I2WQr0DXgBEde1ZThOaSRJLG/
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948919; x=1723553719;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuJWybY/5l5UyBwF8mZPkMRRtpH0IYFVeNn3er57z18=;
        b=uTIPm0awz8eNty3Enk/OmwtYw9024XBMT5c7uRFvE3frx/cAc33m9DNK8BUlVoE5+S
         7SIoRomr3PDoDGeYiv02avC4sZ4jnZ809Q0HJWX4eoPZeKfA7lzZt5ukbytP4j4OYrfP
         bXvsbizORIiD9675fsSiCrxXV8jwTGnnY0qdMdo9+Tvbwdvop9tz31FN5YiX1gaEY0jL
         vn/RZPcpZtD69s3W4pX52Z+w5jrGGzZYy1uH9pzFitElNec6a1ZaLAIwaSzPR4nOeRs6
         YHKxNfA7mejux4OG71PXpMaczKcfcr7VbEJLBoq6Y5rq8mUuBnTcVQ7O1lPhLwtJvnqR
         pjMg==
X-Forwarded-Encrypted: i=1; AJvYcCUO4i7BePKjT69zIS793hzuZ06WECUKPkle5TXPT6DT04wVS2TK+JShcbpjpfiNNG7hw4vwe78R3q0+dpmjr2MjqrEsDXGdyQFNAvlo29lcIauz4d9kJ0b2j0m6PdZ88/oP2QVgc8L3tfQYjj6hE6yhM0tqJ9oCrGSMoFA4yV5BmL4rig==
X-Gm-Message-State: AOJu0YxCEGYVJN97rE7jo/VJLdU/dgoEUO2rMir3KUTbVV+R28HOEwXr
	krAJiOz3QKBmwonWe9+4zPP3Cx7DO7+Fl+fyd1Qj6zGgWBZcx7I8
X-Google-Smtp-Source: AGHT+IE0Qd5FtIv9e0QXQW0IXNZyBBQjJDJFmTAC/0KBUSGyZsbzZmsYlkLeZQJGbpFymr4UoLEIog==
X-Received: by 2002:a05:600c:5489:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-428e6b78e24mr96453035e9.30.1722948918385;
        Tue, 06 Aug 2024 05:55:18 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64952sm243271985e9.37.2024.08.06.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:55:17 -0700 (PDT)
Message-ID: <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
X-Google-Original-Message-ID: <ZrIdMc8CeHeJ3U6s@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 14:55:13 +0200
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-2-ansuelsmth@gmail.com>
 <20240806124224.GA10156@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124224.GA10156@lst.de>

On Tue, Aug 06, 2024 at 02:42:24PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 01:41:11PM +0200, Christian Marangi wrote:
> > Document new nvme-card compatible to permit defining fixed-partition in
> > DT by the use of the block2mtd module to use block devices as MTD.
>  
> What does nvme card mean?  Is this about nvmem or nvme?  If this is nvme,
> are you talking about nvme-pci?  Why would that needs a device binding
> when it is a PCI device?
>

It's similar to how it's done with mmc and it's to keep the property
consistent with block devices.

emmc have something like

mmc {
	mmc-card {
		specific-property;

		partitions...
	};
};

The same will be with nvme with

nvme {
	compatible = "pci_id"

	nvme-card {
		quirks maybe in the future?
		partitions...
	};
};

The following implementation permits in block2mtd to not complicate the
implementation with all the add_disk functions works with parenting
struct and how they are initialized.

(alternative is to have in block2mtd all kind of extra logic with switch
case to check for major block ID that deviates from a common schema)

-- 
	Ansuel
