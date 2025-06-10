Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8C1DF72C
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554206; cv=none; b=MGqnQwrMzEMKpw4UThLvqUrS0Ar9CLhiJz5Cl0NcFvsb2tcdmiGcYJtYmZg0oWyWXjWTeO+tBzQQfrOm9ZpW0hkeJ4EBTixbByWSWoLgxI9Rt2j6kKo80XpJgfXNBPySKDxhSzwcwcLIVosHyKFfeswA0HlpK5t9C0ye8KWxFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554206; c=relaxed/simple;
	bh=D7oAsKh48TB+BaBDonDWriP/CliLu8zUNY994H+Nruc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcuO/fWSuKhnVebE1ZyGaLJraDqtDMlv+ekJhQdY6pPm+1W6RE6Xy3v05DXq+SGcuoSgvWRQE2HXT8WLc7xWOf7h5Wpvs7hVtPFlNQlDuigYZryHMJNcN0mrm05tvib2uBv6QjTwGM0ZBiwbEjTGCzHzXIhcC0r3I4ulBmXbxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dzKk29I+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzKk29I+"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553644b8f56so4910851e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749554202; x=1750159002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59+jyY5FeA0lTSpLcCkeMwgce/BtI56CDI+w9Y0BpO8=;
        b=dzKk29I+o+wLNLEP1oOGiSn75ewICsytPnq156KqUfcU0rwD8H86PgrC45lKeEWUT3
         Ne3ReOMXMY3zfYWzgdaKqib4TcZjcZsuv7sFqG7lEcqfDArE9nuIb4KDZW3LsaIaTXes
         FyExUYwfyfhZ/GGyTGqeQJqyLIm8WPwliGDLfPhC0DapsZz1WNG9JuRSe/MvziYhwOxk
         wMDm4WleWmjyw3SpfTV3EuW2SYawX5RBSRzJ9EWWPwEpWSUo/voj9ZrWslW/z9E5Dnc5
         nNEUE9AQAM+jNl0FkbzxL7ElkSDNXkBeKOJtujjLXs3TzzeSSgEnyXW2TX8Vy/4dssWU
         h2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749554202; x=1750159002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59+jyY5FeA0lTSpLcCkeMwgce/BtI56CDI+w9Y0BpO8=;
        b=kGrQxVI8mhBn0bVJYQ04NHt91buPGRfP66c+q/u3chM20bgS3E667aFCJkj86HjK1P
         vfAIYriSXBc4PUOceie8iV/DMaHP+iRw6Dl1hnw0WHRdSPUBFkL9TSuVKstRgWcuvJbV
         7Yb+ECX2aHzTI4ZJcS+6G3ieQrQDqhfW4Pw/DHJOdIpBYP9cpKAkdkIE75GymGBBsOWB
         9wBfMVb+wb9ZTJmW8gKotZtjBq9t/tj8RZcfNMsMmOJJopt1qLc/K9RE+FIOVEhIB247
         /iQLqtL4bhMoPNkvwl0wrxwux7ekKEDkm2SW9zEYpDGt23FiD814JMkc52XbnOdWamZw
         dFzw==
X-Gm-Message-State: AOJu0YyfrH08UpEdox7G8TFCa+oCPR2Wyog5HFc0RzLYC1B38FWa++BZ
	pd8xFoTJW8BeQBf6z3ieSM9ZPsSppqnw8g6ulHn9ONA3B6jG+pmAK/kVbP7EohCc4IVI8AMoSnn
	TgnPf8Ec=
X-Gm-Gg: ASbGncvO9e+jh26MSaVUZIjXllIFW5PogsX3xejXXixA2UgUmN2t+mr5jazi87Sb2ly
	gZxpg/G8wtsociHSzSlaNfpJod9IATImhscrbvp5RbRnr6wXn+JnyytwwTfYpUdpsoP9BLpkGbz
	f5Cg3dWQ7ZowB5F8U16VIxEffvKyrtzWj222uB/Z2U/dzHqkq/j/Dnm5tSIwDBXdGm5TIfVkIL3
	RkNrEvqEPX2nCArQ+Y5VgdQR/7YClsPyo6ICIkTxcouUk8K/DGFRpWRyEMSdyXCij1oKwqxncau
	d0IazuDCZPhe5L31a2JlLw7Ij9MyEkKJBNTDSUaCDymRNLbETkl9Z7utugoiJI5MkkahszauG1Z
	CJgfMxhwE3sKSSSbyMFUnoWpvaqCJ6eWDMwdJ
X-Google-Smtp-Source: AGHT+IHOFjelHxd1QOwaYBTXbZfIYjxJcofXqOv7vfCY5jo1kSfya97flIWsOjBIeuzmXmniz8VjQg==
X-Received: by 2002:a05:6512:1328:b0:553:2190:fef9 with SMTP id 2adb3069b0e04-553947c5d42mr567301e87.34.1749554202325;
        Tue, 10 Jun 2025 04:16:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722481sm1500146e87.126.2025.06.10.04.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:16:41 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: rtsx_usb_sdmmc: Improve sd_set_power_mode()
Date: Tue, 10 Jun 2025 13:16:22 +0200
Message-ID: <20250610111633.504366-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code in sd_set_power_mode() is a bit obfuscated and also has some minor
issue in its error-path. This small series addresses these problems.

Ulf Hansson (4):
  mmc: rtsx_usb_sdmmc: Fix error-path in sd_set_power_mode()
  mmc: rtsx_usb_sdmmc: Print debug-messages at power-on/off errors
  mmc: rtsx_usb_sdmmc: Convert sd_set_power_mode() into void
  mmc: rtsx_usb_sdmmc: Re-work the code in sd_set_power_mode()

 drivers/mmc/host/rtsx_usb_sdmmc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

-- 
2.43.0

