Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790701FDA8C
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039689; cv=none; b=N5FJ8eMo4GtUp4oroOXvjz9TvgT8n7RES4aP4jUdbqLGfEK6jO5cXxefmK887JCC6X15kfYCVWrT/ahXZTuamByjncq+Fo4IISZYiBOyOq3hgYUIhWErQOmPJu94zx0g0qCKu0RVY83uuv1tG20Vndg2/addElt7IaQIXic8GNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039689; c=relaxed/simple;
	bh=cLukb9C2aiYDFVtCN21ZKXnPdKtOqLTL6mgc0FrZp7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLCSCKOFoZkPeGZ5hH8xXTTUKVsuFdnfpbJDunkjIDktDvYwVDesfWprDEM3w/U2gXO/lAUg1EfiHZPE8aJIy2VRTLHEEc6T4grKacklf/SFeVs71cwsFpN0/T/odfuDbCLbqVvLl+8/4qyUTg4u1dtKx+mAu5lngG+hdK79i5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6OlnTRM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6OlnTRM"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a59so47792171fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744039685; x=1744644485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq8efX9K/jKkGa5RDf6t3vrgLuokcYYa4oIPfqD6CjI=;
        b=I6OlnTRM201vUy+ZXODPHeJkUzVDlZQyuP2bUYZepXdkKsibZMnX6iWhE50C5OQxRS
         Ah+VBHZLo7oaOYAn7jzEUwyKVQtSfRIzMFZymjW1tFIeW+6obJJOALVJ0RQVjLMyyMDg
         Dr0xs75cX2gcVZaFm793jtelXkQZ+GT95XZMPezG7A361vKj+yBGYx55X1bMimRLEhTR
         9Ulcwqa0rYkPPDqL6P0MWRizljf0t6/iUJjvrtlGJFJ7VocjOfJOdRn22oFrEwrOh5UR
         V8Y22Oqxu5CookFLPzBh3KoPAfUuoQMb9FQpyTZsfoMbcxj3KrblT78EZXVw6gXt5iKh
         WbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039685; x=1744644485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kq8efX9K/jKkGa5RDf6t3vrgLuokcYYa4oIPfqD6CjI=;
        b=fR3yKH7HsQLH6QQob843FPkGZTLr2y1anQnSFXy6qhWTP0/EJlnaCyrk2IrrcnhbqT
         MW9EwODQu/114B6cbX28Q8KCPf0/JfcJzXtxNlQKGSDsRw3mehEasv9cAijDkwRQBwk8
         T6MuZ0s2vBalWhThQZAsZ3qIAAmM823X/QnVLAHTXKimVFu6OYk/Ex6T8uESYknr9gff
         JxxlFApJc0tNXlfZZp+b/pO2ojb79Zj+AkWz4tR7RM6yrjfrmHrvyGsXqAsICgUeNABt
         h3/jQJh95LQalUhsv6KvlVWWaAdDh8ljgHIwyZKIxASMNa6N5238RI5K0De5pO6Umkso
         3eng==
X-Gm-Message-State: AOJu0YxmBj70bvXZ0ZHPWwIXGGYCzmR1sz5z5ZoBgKQPwE7CQV+k/nYN
	x19zLJN7K0OcArARlG5onZWdB2TfiRGq9R6lPfkQdMoAVOmn132ofF9wNxrOVClgEY/PvffNA5Q
	x
X-Gm-Gg: ASbGnctzJtrYyCCNShVW7+DRQOwcSPgk5taWCPGFhX1NRx9HeBL6MgD5RWBnrMQADTF
	aqXMvsPAv07A7qdPYNoUzGppxIdCFBk1ogjnfMXFiz01Zzrytm193LblHxEWU7sRdOrZt6mO1r4
	imyLGT7tkOGgO3niOwW0ZOoGiRs3IZPYVe12QvhLFEivWl4fJo19KU20zLtrAM4BG4DRwHglRvE
	3aI+CiNeE2fsO7QMUb9CtQt6aGBYNUB88wX6Ad6OjB6UImqJR+jBhUjWtqvZcV9iSXnZtJMmyju
	uV3WAVe+Nk9h/lYp7bdgrHxHPSw+PVdjyZzkX96uTAoVqVrMec7DxjIB93Ac+6yQZ5Tgj22kPAr
	m989MbXEb/Y3UFzTELQ8=
X-Google-Smtp-Source: AGHT+IFObqH9uOMbw/LDaPSoxjH4CdvHzcUd44Am3VfEgwwKnpzakyOKNpnsTiRoTRb5UeyoCfSx0w==
X-Received: by 2002:a05:651c:1142:b0:30b:971c:96e6 with SMTP id 38308e7fff4ca-30f0c02cda3mr37282471fa.26.1744039685191;
        Mon, 07 Apr 2025 08:28:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314c62bsm16158691fa.61.2025.04.07.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:28:04 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Avri Altman <Avri.Altman@sandisk.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] mmc: core: Add support for graceful host removal for eMMC/SD
Date: Mon,  7 Apr 2025 17:27:50 +0200
Message-ID: <20250407152759.25160-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Added reviewed/tested-by tags.
	- Updated patch 2.

As pointed out by Wolfram Sang and already discussed at LKML [1] - an mmc host
driver may allow to unbind from its corresponding host device. If there is and
eMMC/SD card attached to the host, the mmc core will just try to cut the power
for it, without trying to make a graceful power-off, thus potentially we could
damage the card.

This series intends to fix this problem for eMMC/SD cards.

Please help to test and review!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20241007093447.33084-2-wsa+renesas@sang-engineering.com/

Ulf Hansson (5):
  mmc: core: Convert mmc_can_poweroff_notify() into a bool
  mmc: core: Further avoid re-storing power to the eMMC before a
    shutdown
  mmc: core: Convert into an enum for the poweroff-type for eMMC
  mmc: core: Add support for graceful host removal for eMMC
  mmc: core: Add support for graceful host removal for SD

 drivers/mmc/core/mmc.c | 71 +++++++++++++++++++++++++++++-------------
 drivers/mmc/core/sd.c  | 25 +++++++++------
 2 files changed, 64 insertions(+), 32 deletions(-)

-- 
2.43.0

