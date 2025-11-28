Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CF25333F
	for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2025 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764307231; cv=none; b=FjMWrcINhnhbh/oqe28KmG1rrYfkKI2wiTtAQBxlf/K/4yRbay+Inw5MSh62wyLSPJBNZEolTyajpbUJYqynOYkBJBDdpOM5w+ERNBkDD0dQlHKTvppAEjL0sLEYh9Z3988UAvvI05wr2Lksep+EJ8TOYsB4PC3SYdjcekMLCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764307231; c=relaxed/simple;
	bh=THmGnc3dgP2lVXCPjvN1kS7wAWxW9jiNKeJCqUBkwxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=blcKLXRum91s22ws6mgM1wh/4mqpofSXL87Q6SwNmocsitskF1Xcw9kYLjJPacH1vD7+X8NDM3K5pS5XE0mim/FBwdP5uJQsskR6TYgJ413/IfEnaQiORnVhODnM5c3xk5nXBX/ZIL8xdRA4LgUhUURgMUt4COazLIlJIeMc17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFgcaWl2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFgcaWl2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso9091085e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2025 21:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764307228; x=1764912028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd+4cRJO6WJEbxgEf4MunCD/7gdH3yrBq90idrCO3SE=;
        b=PFgcaWl26ShDpdrDNeZs1jZjfx/Wq//oNCz/cVwoitoAFgaEhzKOlHPmjt3N+avEsV
         2ZoEcxhnIj9J+dkeYYOK0kDexx8l1/5L2LAED1Q6BPmhBVa2mi+X1HXCEGbhk/n3v6Dh
         kFEKtYMFygSu1zRx8VmSAp2ur7epyKc44d7LP5Sa7G50sU/w4XaQqShw5+kXbe7FlbtV
         q1yzcA5acco4Jjb/ZQfzaiW8WlcQFnqluI9aQ5nxrPfb4yIqnTKrRV0JUIpB6C9dr+SU
         5JZPLhGIFEQwh/WILpJ/ZZ5ECs9/nWR/lDVC/pCuCJD88jo4bTcs3pXsVzHeHgrLA7Bf
         11eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764307228; x=1764912028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd+4cRJO6WJEbxgEf4MunCD/7gdH3yrBq90idrCO3SE=;
        b=IBTIGO0ymmyz0ZYalBP1TMVM1XH3xX/pShTcbgC/DxdfeBQReU2bw8wziCWvgLc4b6
         BhGmfAjiwe9Augy4C/JbUBIXRP5p5P2CYRP8DYdjm9b33s25JJatOtkDWeY70lOB7fCc
         Jye0lIlqj1E6kS4TdLqN+AoNbWDudqGmV+bVRwXM29sS7oI4qlZtIw679ePk7izRhZe1
         yAAzd4JjyQhj29gXGZm8v7awItrBiko7gP6ZnGm6yQkFtpHTIFGtZRfU88/Af88UUB7d
         oYIpijQBAZfIxr7CaqqoayVc8Wsun+QyLXrutRF6WFxxlAxuU1NhVAbymjxSSk61xg2C
         bl6A==
X-Forwarded-Encrypted: i=1; AJvYcCV5R/J3iGqnC/Q//PKuUt2VLs+oI9SPT0AHIZEmBDPaRNnmDCz8/i1XeCjcTskUZRXggiejzC/VpgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCgma0QtlIUUYIFNbZhog9uQE8qd3tuUZVp5lJklLTvqAtLuT
	/u8KF/A3o01Kt4YfsCqrKGFDemsqICHf4V6yPdUWVrNOdOQUOhBOppSM
X-Gm-Gg: ASbGncv/84g0uGYICIIUq8L0nZiiGBEbLpmaS4CsUDJzE3K8zgyFBYk+CBknQyd5JTs
	uerVc2xSFdMN41sZYHcYC3cDQPo6cxDED9rqVVjK5iuFNApKvLHkxK3JKvL+wIDOVxV5aAxHaqB
	WHBfosKbNAWfAesCjprksxoXHR7DtCToWEhpPu6/CDgANDlHsHx9FuQ7S9PFQt0fo+sZrEA16fR
	1lTUmqpKvxw0XLuJ4+hHswSAQ/W2sri2x+AO3+FotMpSQUw3h8SSM8dRGN+E48LahIbLvU1uBIU
	13GsLQz3GAIIAE6zL2VGiJzXuIKW2HFN7w1twmuQKqk99BJNlijsKbqn/rL2Fa0el8WFv0fFdTY
	wzl7fntgJsflHrm051UE855cnwUoCUnDsFwqPHEsevl7tEGDzBE8thfJUhYghVg5PaDPE1pMNWK
	7uATUR3thf8Y0GlcM/9S5qCooc/hxnRCxH+R5rMnNgZ6/5liIjTPEdRaFI9Sk0xb9NhWKH3e3o
X-Google-Smtp-Source: AGHT+IF+COsn7cy7+sM+/flMyNATzLJQfAe2nsSCOkHCpatzswZIzTXsE2f+EUf7qS83QJk1tqjO1g==
X-Received: by 2002:a05:600c:1c92:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47904b2c2c5mr147859095e9.33.1764307227558;
        Thu, 27 Nov 2025 21:20:27 -0800 (PST)
Received: from avri-office.sdcorp.global.sandisk.com ([129.253.242.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791116c3c0sm65802385e9.8.2025.11.27.21.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 21:20:27 -0800 (PST)
From: Avri Altman <avri.altman@gmail.com>
X-Google-Original-From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
Date: Fri, 28 Nov 2025 07:20:09 +0200
Message-Id: <20251128052011.204735-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ulf,

This patch series addresses the upcoming exhaustion of the eMMC
manufacturing date (MDT) year field, which is limited to a 4-bit value
in the CID register. Under the current standard (EXT_CSD_REV=8), the
representable years end in 2025.

The first patch implements the recently approved JEDEC standard update
for EXT_CSD_REV=9. This update rolls over the 4-bit year codes to cover
a new 16-year period, extending the range up to 2038.

The second patch introduces a quirk to handle vendor-specific behavior.
Some eMMC vendors are not yet updating their devices to EXT_CSD_REV=9
but still need to report manufacturing dates for 2026 and beyond. These
devices re-purpose the year codes for 2010-2012 to represent 2026-2028.

Thanks,
Avri

---
Changes in v2:
- move the fixup to `mmc_ext_csd_fixups`
- State the correct spec release
- Fixed a typo in the commit message of the second patch.
---

Avri Altman (2):
  mmc: core: Adjust MDT beyond 2025
  mmc: core: Add quirk for incorrect manufacturing date

 drivers/mmc/core/card.h   |  6 ++++++
 drivers/mmc/core/mmc.c    | 12 ++++++++++++
 drivers/mmc/core/quirks.h |  3 +++
 include/linux/mmc/card.h  |  1 +
 4 files changed, 22 insertions(+)

-- 
2.34.1

