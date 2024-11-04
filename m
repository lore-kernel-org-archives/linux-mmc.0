Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E01B5823
	for <linux-mmc@vger.kernel.org>; Mon,  4 Nov 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719463; cv=none; b=FSESg6jV6940nA5yjXRWhbpV1NsK6UsEm0T57sgYDuaIp/zhtc02EgAycbXSjn64b6Yyy5X+oby1MABq2t8ufv6QJPgz8pHXk8hb4exnv2QADRGj736YwwpgjoV1PFuYggWDcTj6BqIlIwy4NH+PZT3xNgZg30l/u4kvJyetx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719463; c=relaxed/simple;
	bh=UYZ3kIxDLucn3oyrn/tKsey0UjLM+aqNDUd0kAgrci0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJViy1PvttKSkwdKudplwaMjcfZQH4g1kZSAErA2FKlf5adLhPfEJ/9poShW+v3BMCm/3kkMuNGPOVhyTejIxcaLY4MqgJEDR81eTNWI6RSf6fRodmXmgyD2heOyIGpLJIaGgs9X7KlKlV4YkUfMQYuUrjON+eXAQFdiV6pEYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sG6jOTxI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sG6jOTxI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so6206889e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2024 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730719460; x=1731324260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTHdbkolXrAXojf/yFVLVMxFSBrJ15Q3tYkvYVpuHpA=;
        b=sG6jOTxIoo5Z0s2UkmcAxy6qIFGQ3IBjgCGdMotT6oY45qFGL/L5WXlbJ8ax32iTn0
         LCmcwB/JoURbdL/KuTdti3RbvpnDeA91oq249jD7siCdOhfDlY9TS4t0qkaBuwX7nXXu
         0JxT5NOHlwsx+49lthVbT6MfK96rEtZbLyb4eHE+8pBy1Ql3L4t5HfZnczEwmLABOwRe
         2fSvFLnXMOTyyubmDWj5uhmIaVArQPB7IeNmQXeyZUAFZw0UYIq4nXQKB/E8Kg9ksFBs
         wOCG3ECnzfk3GySy6TgOfD0jnszVK8QIUQGW8alUssc4FZEiPDkxY1lmwWCFNkbC7p3B
         M+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730719460; x=1731324260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTHdbkolXrAXojf/yFVLVMxFSBrJ15Q3tYkvYVpuHpA=;
        b=pQh3hT2o69h7FRlglH3jnL9pQRUHyj8btBRnso8C4X8mUtBorTIRtXB1a7cydiDth4
         NTtLHJu186HqJQ87rnnfve6d9zCB0RIMp9UOUEGnCEfGjQ9wRt3Exa+lCFRHRyLbyZ6K
         DrSzqmLfXNwO5J+HjBgdyF2JaRxww3pewd+s9h/hmPtPrg6Sn/Ww09l48rzqfwKQlH6q
         4UFrTOv9LWdXuze+4rcamu+5npLdhMrxBRoqqEXOVaeZ5uCCzyx5rIHP2NYLIAxUSLHd
         q2oR7VGy3XRKympdgeuEPeHsA/iqkCHBtVb1s3fi4FPRseKYymzqxEivBcDHzSEXDtR7
         Ay9w==
X-Forwarded-Encrypted: i=1; AJvYcCXNqNRCAQBRUTtEQHMR2zjr46SrsixMYV5toosP4pImWdZMQhR7IiQcZbwh8jxpsQb9KcxAXPyO1HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkIJHFqe+xmMiA5nUtjEbr2LWy6Kn4etsXkwqLlAIB4oncGvs
	x6/12RL01M07JrhPwW6lUp46YdOdS2C62HoFUrcHQu22edSXV2OhIVVkhFLtI9M=
X-Google-Smtp-Source: AGHT+IFZaFNv8wLkd7sg6t1hW1ZdCSeinW0m/apHyHWo0TgH/lHco95Il0oiLc67lylJL7XPhu9+NA==
X-Received: by 2002:a05:6512:4015:b0:538:96ce:f2ed with SMTP id 2adb3069b0e04-53d65dc9855mr7025092e87.10.1730719459698;
        Mon, 04 Nov 2024 03:24:19 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c179sm1648707e87.91.2024.11.04.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:24:18 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.12-rc6
Date: Mon,  4 Nov 2024 12:24:16 +0100
Message-ID: <20241104112416.51129-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.12-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3

for you to fetch changes up to c4dedaaeb3f78d3718e9c1b1e4d972a6b99073cd:

  mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process (2024-10-28 12:30:27 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-pci-gli: A couple of fixes for low power mode on GL9767

----------------------------------------------------------------
Ben Chuang (2):
      mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock function
      mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process

 drivers/mmc/host/sdhci-pci-gli.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)
