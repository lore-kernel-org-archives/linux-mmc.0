Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAE17BB2D
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776609; cv=none; b=c6D18plaRaabMYl04TTtWfn3KW8Dfytd8jRdnKH4hAJgUuFiiWzE8L0VhoL+ZWBB9KN4nR/aCAjalcjUXkudUbjhutGAUH/MpNQsVpoDVoiIDgcYtcQpERYJSj7sMEF0mQTE2ylGSZBwtMRrzAYEoTX+JcsA+CLyUpniv8ZRMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776609; c=relaxed/simple;
	bh=p+THzd48hQUVMEur3ENuOSA0lDZ0jQ4EJJ+0Q2LLq0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9aDQoUwOtpIGG5o2zf261kp9MYwNpkOpzv5GBdkh0zLdcxGAa3b+8eqATR0lx4oUfAuJaKBrg/xSW2A/qLeWgYfi2N2xK/MhWFd5Qm9qAibnrT1tVODqco//VdLp0Pd0LicRP0JypmTYHae2cOh+USUDiOR/o2p0Qt6i93x7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoPZPQ06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoPZPQ06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712776607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVLmiV+FHhixrjqT4DJ7t6PVY4+lI7IXVqA4SStqmj8=;
	b=JoPZPQ06tgS5HPaSlq0z08EjE7qsV+ShRET9FGzOOzlmz5hudCYVT7yGf86OWASG8RITzw
	7T44qvMOusUVUM43/bxc5UE0ODViK0NoAMeZOnxzUoS+ZSygKVzADy1pSf0161Ek6nqqNK
	9RUcw/qN3KNnUbU338A3IgzE+z8kjPE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-QtjjBTjsOhS98i8d8s0Ljg-1; Wed,
 10 Apr 2024 15:16:45 -0400
X-MC-Unique: QtjjBTjsOhS98i8d8s0Ljg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD9929AA3BA;
	Wed, 10 Apr 2024 19:16:45 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B60C44434C;
	Wed, 10 Apr 2024 19:16:43 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/6] mmc: sdhci-acpi: Add some DMI quirks to fix various issues on Bay Trail devices
Date: Wed, 10 Apr 2024 21:16:33 +0200
Message-ID: <20240410191639.526324-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi All,

Here is v3 of my series adding DMI quirks to fix various issues on Intel
Bay Trail tablets.

Changes in v3:
- Replace "mmc: sdhci-acpi: Disable UHS/1.8V modes on Lenovo Yoga
  Tablet 2 series sdcard slot" with a new patch from Adrian which
  actually fixes these modes:
  "[PATCH v3 2/6] mmc: sdhci: Add support for "Tuning Error" interrupts"

  Note this is missing a Signed-off-by from Adrian since this started out
  as a quick test patch from Adrian.
  Adrian, can you provide your S-o-b for this patch?

Changes in v2:
- Address a few small remarks from Andy and adds Andy's Reviewed-by
  to the patches

Regards,

Hans


Adrian Hunter (1):
  mmc: sdhci: Add support for "Tuning Error" interrupts

Hans de Goede (5):
  mmc: core: Add mmc_gpiod_set_cd_config() function
  mmc: sdhci-acpi: Sort DMI quirks alphabetically
  mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not
    working
  mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
  mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO
    on Asus T100TA

 drivers/mmc/core/slot-gpio.c  | 20 ++++++++++++
 drivers/mmc/host/sdhci-acpi.c | 61 +++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.c      | 10 ++++--
 drivers/mmc/host/sdhci.h      |  3 +-
 include/linux/mmc/slot-gpio.h |  1 +
 5 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.44.0

