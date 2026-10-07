Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E49412BF6;
	Wed,  7 Oct 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407223; cv=pass; b=nb5NJpk7HUicxercqvDO6SP2+YHOckS7wIvifkfMLU2g94BMPVuGClzG1K5D+vNFWF2NzhgzVcnmcRNbgZY2mGAeavIg9NCsG/gaciFmilxAx7mmsPn+4NIA+tWvSTZvs4xP1S9vU9YcSaill97dGAZZtOZdwpRjOoNa3hoUoqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407223; c=relaxed/simple;
	bh=4IVYMqtKHxu96uoD6/LMPh8YyKZYkylDuLrOfkixS8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5ESxGeVMCeNSTVoe8IApHiLj3ELgrwVD7gqK9s3YcCHiHnwUgr/2T4+DSXwKgV4t17vQCOvQoKLZ9GvG/O1FbZVTHHmSTCEV1W1MyGm6ogr97s74w7b6SwiRuyr1dywEFn1pphPf+KJgpNPirw2ejHqMgq1/MVGyQFYlwf92zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=B76ge9EW; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="B76ge9EW"
ARC-Seal: i=1; a=rsa-sha256; t=1791407187; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YX7Vu4/jgW15llxosNuC6hNEUR5ce4IaDj3sXJPihNyzrxd3E4OWgVCQYOCgNJt3ywLue+rW7Uqpp/9ALnJ4jgLE2kNWNw05aD+c1RMoZZiX7VJ1Ug7ACvAn9JdkI5L7Sg4NMbRfo1xMKe5moG36f2vEvEOnP/2uE36fNHWSIlM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791407187; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4IVYMqtKHxu96uoD6/LMPh8YyKZYkylDuLrOfkixS8w=; 
	b=FmIY7qZQXxnzh/JY5D5XzcggDmBUxokqseenxNoXKkERDGKoeKoSjfYVcm8EUW8zTQhmXhYMd3sBOspTYDKM+OGPW9BTjyidDJC15cc5rk6qIwXO+sfCuyIIxq21ECZ9z7z9Sf+65IdhzTvoSiOZR68Zk6ZKczdvQA+4Mq4T1OI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791407187;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4IVYMqtKHxu96uoD6/LMPh8YyKZYkylDuLrOfkixS8w=;
	b=B76ge9EWdGLH2Ptmuz/xdysPq9CJEHrkOfEIv5YQBh3GDMaBNqxgz/ZxGuuFcdCP
	bMudmmXQtwMMmgTp3tE1wawTeSXjSQsdGywAPhc7GZSBQ4xAZhDFvtGNlSx190egYo0
	GB1osx1W/XG1qINXvRUMncKowIGkLgWNuJn5kLiM=
Received: by smtp.zoho.eu with SMTPS id 1791407184521227.33749622375103;
	Wed, 7 Oct 2026 23:06:24 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Dongjin Kim <tobetter@gmail.com>,
 Eric Neulight <Eric.Neulight@linuxdev.slmail.me>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: let the SD card be
 powered down
In-Reply-To: <179100548183.3372253.2014593916926884551@iav.lv>
References: <20261003-hc4-sd-power-off-v1-1-f7ffba01b348@iav.lv>
 <179100548183.3372253.2014593916926884551@iav.lv>
Date: Thu, 08 Oct 2026 00:05:50 +0300
Message-ID: <179140715034.293470.4459182430175564610@iav.lv>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Follow-up to the dropped patch.

An out-of-tree restart handler [1] power-cycles the card: it drives
TFLASH_VDD and both tf_io lines low for 100 ms, then releases them and
the card is powered again. With the SPI flash erased, ODROID-HC4 boots
from SD after a warm reboot 5/5 on 6.18, 7.2 and 7.3-rc5. Without the
handler the boot stalls in the ROM or in U-Boot.

Where should this live upstream: the mmc core on restart, meson-gx-mmc,
or a board driver like this one?

[1] https://github.com/armbian/build/blob/main/patch/kernel/archive/meson64-7.3/meson64-reboot-02-port-to-gpiod.patch

--
Igor Velkov
