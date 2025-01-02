Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC9405F7
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jan 2025 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735821440; cv=none; b=I2np7qsp5OIefaZJ+91mPpbbzjjGmE+ccYGgQ9tGsLM+WgbbWSHjYBtbEbsMN+z+Mk9yNmHbr42MRP5WjmzQtObPKOgsQsPkTRrvvO6K2DFn47tA6d0UF9t0qT8DwTS0gfaLW/gBMrtv4jkm7xnF/6HucPJECcrUkLC9LHRqNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735821440; c=relaxed/simple;
	bh=ovoyRAxRSFeMrgjRMthRmJvxPuen2iEkmgEYYevUnAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlbYNSa2JTsdfsAkrjdG13QFvX+Ax77YL+ybobCN/3FnZdUNuDJ0I2K/gPMp/HflKom8d8EV2TKEU/ZsC06+06qGDIAOmQU1CqwFCLOEtRD9UWyW44yhhDIW3KMmRl7RmA5a8651uvm/XjQAQrEz4lyQvku8KyARkrjBAqql+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5uxy7++; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5uxy7++"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3035046d4bfso106219511fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jan 2025 04:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735821436; x=1736426236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RPvoolvhxT/7Qs6epd3/d+MDJ2hiPjRNnX6aa5YMDY=;
        b=F5uxy7++2K+c/ON0mphr8UrjWPogSmBwsbI0cbwCOXHV9SFPqy6D52BbfpduoN2HaO
         6R3TX/P/ZaApj4dgIF8nG/SQorS641gR+gEFKkAyo4Ru+gUDSB/4W/J08Ozvt1IgzQ9T
         MsRc69UPrLyhRwKREcHz6t15nJzN0ouYh5UOLJR8FZ/274MkJ77B43K/IW/ZYEB3Y/YJ
         63tQjUrz4758iwqVVGsi7/QltO7SAbW8C8aH0eMcxbXJH2Cf/gx0n09V/oFXDY4Nn0F+
         R4GtHNXnwYbd7pSd8Q1zL9dBIdfG/sg1LusdZWAIN1iRVxDGGHOSNR/ychfhxX2N1/NU
         Ne8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735821436; x=1736426236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RPvoolvhxT/7Qs6epd3/d+MDJ2hiPjRNnX6aa5YMDY=;
        b=mIX4maeBfttk00wE3qZwNMfY0J1dmH5EsraP3McNKgkxzilr9bnk4T1t1ur8AKDr58
         iKK3dpnbNXOBsdFn48dY6RsNVvTrIARk/h1C1tts+YXdKCnIzxyjfQWAtB4faGucEDyW
         yG6jyFX3ZrAHEEhw8gKMI5bXSX9/WjgoILua+rK9JOV47R5pmRoYeU9VdxwOFmFGVGC+
         TQBy5GH/qi6NjvGQlQfgdQcA+juiFiuwHqB3YfZDhUZAEvIwVlXn/4IqNNbqinZSSlWX
         +DhUXgzYnOWorlmjr6smC4cTjb732gS7iaDjUfvxK4EulNDQhrmp1JmDKSnlSgPP64kU
         X+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIehzY86DZfZPJNCFmvOaD9N5his8yuDmVqorgr6RX+BxNiO85ejQa5A27Ap9Roz6uWg8vG6R/Acg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJHm63kIeSv8vciaRyazyR4PHostWjMv0upFxtphHduuj02T3
	fh3EJq4UWMyNaIqc+lU/sUq8hST1EbH4xUxW7Kibcfe8EElGfT7ZuRLMSxcOeyFQpqHko+2Ad5s
	S
X-Gm-Gg: ASbGncvefqj7c2pL8EtpCTXcRrLNVcnMHzwgamce2KHjMq+gmPzOR/G3wBE5JDLq0jY
	KGdosllO4Fx7GL9GOJNbz166H22gWi5B3T4Aq6o9nXDqcFwXTYPkWIYFf4urApesrw1BuhEbmbq
	uwQH1RWSsoCRvT25BT+ROb0C4N8bk1bAa2tgCEUeJXLLNkuZ8LN5I/LDfmC3OdUfl1zI/xmKiCx
	n98C87EVAAocJ54SGGttpKy7IasY+aW+chjTdZxibIR8hSMtlGOD+2hoyAGBxvvWrpL6At+9Ddy
	QrlBON7ibJeU6ayG50CbBiXfIYnCvpk=
X-Google-Smtp-Source: AGHT+IHBlJ/mWFZ9Wgo92LO6ZIm7lRRBCg9tZP1+peGoGtc9NU7WUeMv/NQJOITwuPS1+tVr8wIYHg==
X-Received: by 2002:a05:651c:b14:b0:302:4147:178d with SMTP id 38308e7fff4ca-304685c1ad4mr176389051fa.28.1735821436291;
        Thu, 02 Jan 2025 04:37:16 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad99381sm42932741fa.26.2025.01.02.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 04:37:14 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.13-rc6
Date: Thu,  2 Jan 2025 13:37:12 +0100
Message-ID: <20250102123712.49642-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with an MMC fix intended for v6.13-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f3d87abe11ed04d1b23a474a212f0e5deeb50892:

  mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe() (2024-12-10 16:02:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2-2

for you to fetch changes up to 8d90a86ed053226a297ce062f4d9f4f521e05c4c:

  mmc: sdhci-msm: fix crypto key eviction (2024-12-19 14:42:10 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-msm: Fix crypto key eviction

----------------------------------------------------------------
Eric Biggers (1):
      mmc: sdhci-msm: fix crypto key eviction

 drivers/mmc/host/sdhci-msm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
