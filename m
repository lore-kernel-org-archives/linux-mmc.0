Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94D313267
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717070; cv=none; b=LkbdKykvIsa7ADDrLSm4GQZ1vlHq5ryM3m1D7O115zhDr814hfk8SYurrCi6JnSvnS7XnTCy3DsBA84LZcWouhsDwcSGko+7HR2EET+8V+QQ5ZyqL8ctwReQrxP58HDDVYCyJKY9UkMjUUhVhVXNGasL9Tzx/4k25yH26ydc450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717070; c=relaxed/simple;
	bh=hBOC6p3qSLaHNV0djiLX6uVbZLZo3wiE2XvROfSEcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ns2So3hqkJgXV02SAHbJTyxX9V+bdMeq/5P/1DPYwpzzMht3o0/tWQV5Cd8Azu6+9JjhKPlAMK4G3lrCHNxlU/ZWVAFwj5dLPYplx01AWANXCV15FPOMjef6zq7rTq+N3gxVD4TqT3AprGe6Kjt9QFR8o7n78bHv/5H7FL9lxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RniZP0N4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RniZP0N4"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec423a5265so1109296366b.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717067; x=1782321867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ9G6th4JLy+NHKbzbIghs+6XnvRtXkz1b/VNykfxXw=;
        b=RniZP0N4rWvurPfhBvo/fynU74Ayc4N1soAjUiJvXsUWUVmNJBCJoZisuaCr31/oQJ
         wHFhdQMG2rMCQZZUWKLKUJu2TVW9fKDW3DtTzPX3zLIwSaM67WSkP8j5ztTbXYt2qZAp
         uy4q+nw06Q8eWGXlJnNFeiTC4OycDcsPOSjpfvA4qlRVDejIBk+uvVBznaQPL/BHvlmf
         tGJrsVNu8wezqOmdOSU/QDsHo7P1r/Z2QawuQDL/6gjVhQE2aBbMrZ9ndSwo8Kek/1p9
         vTGkE7hhqL5jFzgkkI7wSvI1vewy64tRQW7rBj/GT2CLSqZbtkq+yCtscegr7wi2OJfQ
         d2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717067; x=1782321867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ9G6th4JLy+NHKbzbIghs+6XnvRtXkz1b/VNykfxXw=;
        b=VPGrNZypHEN8RG2xbIw1kI8k8OCmtK5MWJ+0ZLDGQy2qxyaWqf4oiGTl2p1YpMQXX3
         OPbAXtM+dG2cqmPQYSQ+MJGbZrzNOGxFwVWqu50A6uWFv+KMTU2L62Y9kx83Zr9oFI67
         m+B+6afPj/MzAy450i2buNZRrWWODKGeEvImHUGIJFwBVbYRd+fQKQ6uIHPbHTuZah9h
         X7010HfHl0RAkP3OlIx3Iukb9xB4tax+faFaqPmJ+tO9OKLR96DEsnKHzP8g9O5MB5TE
         2euBpm8Q5ZoStA9wwbs4jGRe0aSQReKQ3h2ApUNkjo9ziZ+y46iMij1fpBpOzLez6XHH
         9jWQ==
X-Gm-Message-State: AOJu0Ywqdy/B/txoo/Or7tdbqyEJXSSqpQ4xhdzNmBoQrAUSfFmWhyaY
	ln4mHffawQ2vlxLYeGhwD31O3lJl59lSLPRph+yIMrFImiiNFpQ4y/EWvvEoqQ==
X-Gm-Gg: Acq92OEGdF7QhmdE0UlR3Qbyxhs23KW5vkMoXPCM6TpCS+IoMlCxrAVAduOzlOwBpiX
	3ahciZLGdNRqwuTaQCUHUammbcrCGP+xr5tEiWMpDI65mWSf6pd14/aedvrqtQCL6eSxp0mGkIp
	5cn+S8kCez1wiRKLyizFfowaSsidEzb2eZzUUZrKTGlnjBhudt4Ez8qDFfyf4+zHNIYeSC75BT7
	nYT949MXIk2Yc6ApPuVyGypj4lb5FwsEEg1t9ydJ02V2Sj4DJdTz+YfEIHNsCnKBJvuaRAubnGU
	0AD7gTWDQKoNK1oNw9nzPXiAbBaH490jk80xms0IFDEofYgK12INiRJSvveFMhN2KIiMekW3Apf
	Q37q/wIMqrxIsTWpegSAjIF/IcCWehZY0CDMoPplkVIrdMVRZbVj0W7erSOU/eNg2vqZXO4RlKo
	B/2jd/oa3/chhEwoo450KdBdZl0BE=
X-Received: by 2002:a17:906:9f8e:b0:bda:5265:423 with SMTP id a640c23a62f3a-c05a5218fe4mr347241566b.44.1781717066956;
        Wed, 17 Jun 2026 10:24:26 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:ec6d:6f56:be28:aea2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm323873766b.51.2026.06.17.10.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:24:26 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v3 0/4] mmc-utils: improve lsmmc usability
Date: Wed, 17 Jun 2026 19:24:07 +0200
Message-ID: <20260617172411.42805-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves lsmmc in four areas: external manufacturer ID files,
accepting /dev and /sys/block paths for register reads, an mmc list command,
and bash completion for mmc-utils.

Changes since v2:
- Patch 1 (now also includes the v2 "refactor CID parsing" patch, squashed
  in since it had no independent value on its own):
  - get_manufacturer: return strdup("0x%02x", manid) instead of NULL for
    unknown manufacturer IDs, so callers always get a printable string
- Patch 2 (Accept /dev and /sys/block paths for register reads):
  - resolve_dev_path: use snprintf() instead of strncpy()+manual NUL
    termination to copy basedev
- Patch 3 (Add mmc list command):
  - print_list_entry: new helper, split out of do_list() to format one
    table row per device
  - do_list: probe both SD and MMC ids files once up front so any
    "ids file not found" warning is printed before the table, not
    interleaved with it
  - do_list: skip sysfs entries whose type is neither "MMC" nor "SD"
    instead of relying on a missing cid file to filter them out
- Patch 4: unchanged from v2

Torstein Eide (4):
  mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
  mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
  mmc-utils: lsmmc: Add mmc list command
  mmc-utils: Add bash completion

 Makefile           |  11 +-
 completion/mmc     |  62 +++++
 docs/HOWTO.rst     |  77 +++++-
 lsmmc.c            | 621 ++++++++++++++++++++++++++-------------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 ++
 8 files changed, 543 insertions(+), 274 deletions(-)
 create mode 100644 completion/mmc
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

-- 
2.53.0

