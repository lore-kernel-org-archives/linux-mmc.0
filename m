Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23F207DF8
	for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353564; cv=none; b=lPdn2rwvmlmHpwuNJ0e25i9AjXFb9lh9/W5+IjFE2w2uoj8Ph00ojjV37QHCMuLb3ACe3F60laRdaCXPQ8eHPDwY/QXgAAfR1N4UdupJ9z7XXmzUUz8hMFH6eHqo9VbkY40xy11Wb1Rz2MVJzpXXrxhPd7i1O9ONKESA293jwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353564; c=relaxed/simple;
	bh=1plww5LSeApsiHW+Lk50lqZF27WN3poyYwcPpo1ejyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN3BTZJzzXTs5aee2hA7c8sxV0Vptc3A1MZORHk5ETIJK8mzgroOt9zdK+SD6kFJgls0H+T6tQWRXnj2aHx+svSJXcpAp99Z1wkjqFIE3UTRR5lSL8Ql8mIEbmWnaH5G5B2yjlWPsDWUvYT2Gcl/1zYnUtRhm6xc+b46/ygPwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f8XvIlzS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f8XvIlzS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc33931d3so2931596f8f.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2025 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739353561; x=1739958361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zuOOH+cqbW5sfzyGH9UF9miBvxPH8Nl8TrZbDwlVwE=;
        b=f8XvIlzSqlNwV37zfu9VVoyFvwkNSd30CNr796GaOfiSzvXgRoHTy0Vuz/PfJ6oYR0
         QyYknjoFGQiqkwECId/aVTjIVDakLdrTHSKbeMUkUr4jpG4TqyIZ83cQ0MBg8MV73tqH
         hIU+eX+s4vueddkrU6+t6QnMFPMIDMIOgAZCqx1qd4kRs/wBaLoEXZYEPVRI3hZHOLIS
         M8UWS5QysJ+yAWqqxY0wZ9bPRJUZBp4/Ju7l/XuRzelIF9miKiKjx6mDR8gjd892cdHm
         WBq3XPd4uln11qSwaveFpWGWLDnYbAPC3VlKqZUhVcSN9gKV5dMUIpf92tJMaS/VMX/n
         WK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353561; x=1739958361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zuOOH+cqbW5sfzyGH9UF9miBvxPH8Nl8TrZbDwlVwE=;
        b=Aqb+FBGrXhy0h321+pp8RTHyUDO3gUxpEe1ndQgg9kzyJtFRzgMe8c/ve79B/qNRSu
         sNi3iR44049wrGKy3FnUJ9pUUcSTn/bT+qevqkTxdW82lZCdECCVXSC0rARXkeb3B2m8
         ONaXfMe/0C0z4M1/PrdGdBAxRYB//KCZX+ZJG8JsgWyVPVcEHFiABJ3ECFnx0EFVrP91
         dZapSfe6wIS5c17jVgGlX4NNyuCB+2kISL/+aP2Nb4WvVthkm7JpQXqPUl2lbACSd4ZB
         YRx/KTOyBAqtSwY+t1uZHiP3VR1aMzZghCNip8FpcyL4BxBr6kNCDjjjxIHrVX3gyiNC
         pIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG1TLkPVPutrwjosWsmjzuYMhbgR8D0FKkMdRil2sDRkJ0jl0GY9NKS3XNk6VMOAgu6YsI//J8H6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTPOiCr5WbmmPR/y79ZRENPO8e8O9Dstztw4WGXTErT3CkE69
	GeVMxf16uyqpZcAQ3CTpQmMtqFztMcbFzkgSyZHRkwfAppGWicvAHt12Gp5Pc0o=
X-Gm-Gg: ASbGnctiJtdVFFJb+is5DnoIJvppxe/kGlu1Mk/nV8ROq+z/lC5WJntBD6Hxq1VMu5T
	sMhz0WP39itgU4DUs5qneyhgPVsFP4XRnYKyHabCiBsYpZDQ9pNB1bmtXPpQHSTJIDNR8qg/G7P
	Ck9yQAQZgYprCWxYIlT5LIYzzRc3G1SAqlWsTqFR0E3oVTanbIu2fHpc3Za4d1qH4x8pl7LFCHV
	mkU7llfMSMX5un+7PYhB7mhOTF0eb+sen3fv2Cqc6ukQxr1nKI8iJDw68b5JHnM3/XxjDqsXSQO
	v+5sBAJvFLES1IM=
X-Google-Smtp-Source: AGHT+IFpt/tGI0C0Llxj6yqwoW6+UDGvasbspWqNSw5lXAH/EOQlfLcMUFUUZtUM6+ncdDrcGoubYA==
X-Received: by 2002:a5d:47a4:0:b0:38f:2065:3f20 with SMTP id ffacd0b85a97d-38f20653f83mr612508f8f.17.1739353560896;
        Wed, 12 Feb 2025 01:46:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a076496sm14262795e9.32.2025.02.12.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:46:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [GIT PULL] gpio: immutable tag containing gpiod_multi_set_value_cansleep()
Date: Wed, 12 Feb 2025 10:45:46 +0100
Message-ID: <20250212094546.11895-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi!

This concerns the patch series from David Lechner[1].

I applied the patch adding gpiod_multi_set_value_cansleep() to the GPIO
tree. Here's an immutable tag that maintainers of all other trees affected
by this series can pull in so that the entire series can land for v6.15.

Please pull.
Bartosz

[1] https://lore.kernel.org/linux-gpio/20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com/

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-set-array-helper-v6.15-rc1

for you to fetch changes up to 91931af18bd22437e08e2471f5484d6fbdd8ab93:

  gpiolib: add gpiod_multi_set_value_cansleep() (2025-02-12 10:29:27 +0100)

----------------------------------------------------------------
add gpiod_multi_set_value_cansleep() to GPIO core

----------------------------------------------------------------
David Lechner (1):
      gpiolib: add gpiod_multi_set_value_cansleep()

 include/linux/gpio/consumer.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
