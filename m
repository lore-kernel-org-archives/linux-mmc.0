Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB692AD16
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480188; cv=none; b=D+sdY+SSAhmMViW/XlAfyb5Ohrsik5QlGwk3BsB2YWcSISxNJyKbkyJ6AvMxGHvD/nYdmUws+Uy6iT4TCGIHHQOpKTMw7+axZpqcspG4F35qTaPHzumi7Wizm8opzBzDIkGY7RwIOQ7nGCOiM7BDG99aFKACAXcC692APzoDwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480188; c=relaxed/simple;
	bh=BG7oXm8HfnNGRZ+BgKfaO795/z90fQRMwxeOL+t6m1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQPJgcJI2l06tbPuyCbthyKVAVqz5/5+cXStPPkiZD2lOwJJhPHeh0sSCUHhsn2u82WqRBMaZa/hHJxA3Jnl07nmUQ4fCI0bkmFqpC6Iv03bCA2qed5E/Qj2eIe5bVk6BGjmqoUFZ3IolulQgsrOFZx3ksFmOqCo4AJJOBKz2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aaq+pKyC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaq+pKyC"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5499bd3084aso847780e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480184; x=1743084984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiuwvxdAhCBLo6Y0nk402oGwzDCK0nUCR/MeYHjI7FQ=;
        b=aaq+pKyC3GwcCj6hmyd/mndnt3vLZ0Bcew+vEPZvml/WjzGWVBi3KC3quSLEGpHFa5
         rocEjkThEM5l9YBT4DSuBaPywskSwLKsYOLqOBa/jpJZPxfhiN/54vMcRru1G795dsq6
         1RJvH2sk4jJN1WQ5UZv1m6kYoQuKZyqA1tfMyTDI+TCCpQvlBANvsWXObUbv8bXApUdP
         uMSFolZBc4ckEIJDGR68OtGJ5fBxhUn9fObdsBZ/UpjGnsNtFM62sazihVCgl/eNSN91
         uAAwhAKOt8S1JBwzcnMtf/E6Eog/nbEVEL0zOhpsI2qn7BN/poAhN43X+6ogbwPHogrO
         YQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480184; x=1743084984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiuwvxdAhCBLo6Y0nk402oGwzDCK0nUCR/MeYHjI7FQ=;
        b=RPZ6g1kqNGEoe7wzNjl664LPa+dLhWagXSX9suo32SVrMIDam7Lk4Y+RM/N1mjBbjh
         xL7GqxTpRMAh4k0UfHEB+eryevVdiiqW5ngjbQyv0X7rk9BWjeMV/UvuQX5YOJZ/RGLZ
         Wdt34X3DzP+26PkHIofZIwT27g6CJieUbvsbelwDZVuPafVI4Mg7PdJX4XMW0qgl2Wja
         jfNMzzeZZ3XoKMnV5gWWL1qn1ci9DXCwr3NGYN9S6I7SiVXIdhbO7wmtmi4hxvpF/HZ2
         lkYZQJzOSgjU2T1kNoL301TuZS/bci7wVFuBJK5poGGONwHpDrNuxa7/3QtCNeuZfqU4
         GI/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7c1dGkmYLr4JRQSiK2eaBC+/7eVLHDaRRBKTt2FFwm3UdJYWNd0iSjH3hLohcYXFnTicdNSYfHz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnbdYNuqHKw2t/y/yrHGLbrOHfDzVgEAibVIGTIPGrfjNmVOG
	B8PIYwJEmK+e2jRz9ultDkxFEs2rL2HmROBknLxylyMwweu915kg7UJYNgRqvSsl4FvUBGVovWd
	e
X-Gm-Gg: ASbGncvWdSLQKY6m4y1NMwI+zetEsqXS+ZNdZND1NaffzcaXyJrwWmZcjcHU+jJ3dyh
	h3M27zk9QYNmgGVaxFOMoEN+0/whiUQbDq6I7WUaiP9/UbcbNL3ocGzp68SvEBEW0Ixtf7H79i1
	mN/urU7+gNcP9EodaiCRvPPfGA2hNJ44cFhyQzUWmFzYkVa79DSmfOt8w4CZSlBkJ56Xlc5efrY
	P4lB58MVdUI54UTqxzXz8zkdsOMxmRPgob5k/eDD/GWbM6O/aeX+USChXkkLNCZJjFN0uD9u5Oq
	IKG9Mkf8A0CzUbflADzPp5Or2ccWkx2RzCEeTMNG3N3Xw9aE8Xewp6StPrLjKA4z9+YRCgBkYox
	jOFqzZdls/mjwVM+Y58U=
X-Google-Smtp-Source: AGHT+IGq6ZMnqynS/LyosQzximB2DC5hiOhKm5mcuHaUP+x5dJQDT/ew7HjON49ahwTkD2EY/GpYaQ==
X-Received: by 2002:a05:6512:693:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-54acb21a725mr2921834e87.46.1742480184315;
        Thu, 20 Mar 2025 07:16:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e24sm2267110e87.107.2025.03.20.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:16:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.14-rc8
Date: Thu, 20 Mar 2025 15:16:21 +0100
Message-ID: <20250320141621.164515-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc4

for you to fetch changes up to 723ef0e20dbb2aa1b5406d2bb75374fc48187daa:

  mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops (2025-03-17 11:42:42 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-brcmstb: Fix CQE suspend/resume support
 - atmel-mci: Add a missing clk_disable_unprepare() in ->probe()

----------------------------------------------------------------
Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

 drivers/mmc/host/atmel-mci.c     |  4 +++-
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
