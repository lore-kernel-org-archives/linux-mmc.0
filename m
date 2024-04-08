Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95D53368
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605976; cv=none; b=TSlom3OymGaDb2QvLAPj4vG7C/LzVZC3a+X3bYE7Mb/C6K71LjLRV56godBVZZm123+cCm179gnxQgWlQnV5R8/cBID938uJ0hBQml3ZpnsqjD8pTckEaDBJsgwDU4MDOlhcdz+ubjROCVdS+8BdrTsgTzhAysvt3E6swKiv88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605976; c=relaxed/simple;
	bh=3M6oq1qvuCexplvJj1z9ViupZJaEHt17LjMm1wMrd2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4R6F007+j1Ucc++pqWPn2FFgpYtfyYoLiG4oYRg7smt8o3wgxm/qk2OjZnQoJAK1C5C/2ZLHgyrXk6m5b3Y5H4gSb2+64GvP8CG9C4LaG8X84gD+HSpUQSxDIHmrJCSzA9mDGWTSxuoMMPlgpy96o2l7L7Bd/1yref2wZbnT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxdCzXHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxdCzXHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712605974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ehv/GjiuFO6hGgKdrclUMzA+WNbqwYI/WJ2c/pbOSso=;
	b=ZxdCzXHjS106aoUnUxi1xkxzbkZEIx70Z2rBFRnazDBkVQX7TDDp16YTqvlU5bskuYbRzn
	BS4e626mbErQx5B7LLRSBobYWK1oX3ZIpb+ri4YwBJt9sLyZJfquHdRYzdxhyQdjO+4UEU
	8Jl/h6bBiKoqPUmo8CGJpQEFaJJTR7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-iewW4QW6M72rOoPCWAHiyQ-1; Mon, 08 Apr 2024 15:52:50 -0400
X-MC-Unique: iewW4QW6M72rOoPCWAHiyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C787080BCE7;
	Mon,  8 Apr 2024 19:52:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C47AF1C06666;
	Mon,  8 Apr 2024 19:52:48 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/6] mmc: sdhci-acpi: Add some DMI quirks to fix various issues on Bay Trail devices
Date: Mon,  8 Apr 2024 21:52:38 +0200
Message-ID: <20240408195244.248280-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi All,

Here is v2 of my series adding DMI quirks to fix various issues on Intel
Bay Trail tablets.

This v2 addresses a few small remarks from Andy and adds Andy's Reviewed-by
to all of the patches.

Regards,

Hans


Hans de Goede (6):
  mmc: core: Add mmc_gpiod_set_cd_config() function
  mmc: sdhci-acpi: Sort DMI quirks alphabetically
  mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not
    working
  mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo Yoga Tablet 2 series
    sdcard slot
  mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
  mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO
    on Asus T100TA

 drivers/mmc/core/slot-gpio.c  | 20 +++++++++
 drivers/mmc/host/sdhci-acpi.c | 84 ++++++++++++++++++++++++++++++++---
 include/linux/mmc/slot-gpio.h |  1 +
 3 files changed, 99 insertions(+), 6 deletions(-)

-- 
2.44.0

