Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A23ED128
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881088; cv=none; b=rBHk1MzG6SEOhEe+CT3O05sYaj258yxnufKk1gyT85IGs6nmr/h+Zr1f2OXw7+I2hD1O8q7ErW0zX2hGXr5kO/uGyCqZ0xH6F0GoNDEjnzKk57b2XRacOKHU8wihpHyphIxQSrfP8ZMk/NNK6bYfa82JTarRUoF3aO2dLIstTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881088; c=relaxed/simple;
	bh=ZLH2KqLV7aedLMy+s6QB6PMVRXTqA6HJ0UFO1TUNR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBvJd0J9sHb4ZKXvIrOYjIhNFFTXPUe3ePERNMunxiV/pV0xwhz5K0uzteHL3HCnOLBVioKkumclPG7skDUGYB6tjbe42ZhlLbmz2WkcwLKGi6ftWqXKXIf8tFvVQLx8i3+N6NetyKe8GyPU9RnafYQjE3gWasnibnK2jNmTIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+4gULBH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+4gULBH"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so755744a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881086; x=1779485886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zO9Ka/RcUjyDhaIpyI1tnliMrSeQFbCrFJw2cKmx/aU=;
        b=M+4gULBH3jierlx+36p763aVWQREpJEUSKpDGsV2LcvhksLbJuzpGyOp9jG00S6BV4
         6pX33iXlBRpGe4jFCZZc1BKCMBzrgvac+04kAWwYLwHK+0ml3xXXkqren2Odx2XehOBA
         5WlA0dwIQQagb8TvSHn75uYJKL4ZG6jISZmXBxxdMPCCYAz9Cq3Se+si54/YM8wYbdRt
         VOqxaPGtc7iCfYB6v0G7KYdd+1Mgic/dtteVlElq/U4OLnSCoyeXu0oms/Xp+KCgYdp4
         e/xq8s93KK3WOudPY/E2p7dsMMQglbpbGq9xp9FQ4vZB3THqeUgfVPBX1yjKlWbY/ty0
         EiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881086; x=1779485886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO9Ka/RcUjyDhaIpyI1tnliMrSeQFbCrFJw2cKmx/aU=;
        b=ccWjJ1kO8Wp1jfb3ZjJRWIpOg39BntyMzC2BDyc97GPfDQqvHZg8fbRjSY4xb5xREu
         apI0Zf+E+UUWPFW/Ajc/P1xmWEv6x2MZbrFzrUmpHaBqRE/laSRnPCtwnhlIdhwxThI2
         zuUHA4W5rv/LZn35sap3jRWEe3ZHFMNF5jgCQHIop/HzviR5rc9Oa1kHqYpybNgd3XG/
         4cfbw3yq3XrNdm+FZqLjaVNicL7zEpEd1J2iuimbstGWJ8Tpl3sHQmWqjQTzRWxCiYRO
         OZENVPzF4b7yf9eXRKebtZCK93Xdz2wtPuix3Ns9lEuCvVQ7gMLLBmrW5B19Cp9HDsug
         JC0A==
X-Gm-Message-State: AOJu0YwKRatBTF+Dpg6jSfx7JMNaHWog4nNkShe4JzRCVctYaFKFdv+V
	+Llc/vBuDe+hRNvUCcRRrn2jdkFoqMnPdUgDtFT6KUyML+6Q2XUoQ5JnrmTmeSjx
X-Gm-Gg: Acq92OHPIqE33nu1qlcQmzmfwY2N3B55vDLjpIML9JPZn+SGwi4ekv7trjaCo+abfBH
	4gh5jTmBiDgb3YDHZVzDdZrbYFeZVxiA9rL0b/548rBQS2aH1j2+nUIvX/k4MyKX4RX+uwvp3fP
	9foyfyCI/201SpPBR0N2dFQBtEgMWOUOJp1oJ1TVL8pE7CEM8eICaJNmX2x4+0yblfnmXnFoHBr
	6wcaoeBjqtU4oSWyuvQ58PNcR3riBAKbcq8LKrtNS+2zABzSMWnDrR8kt11a/vDS9ivcJQt3xj4
	jxwn0C2+ExhmY2XBrQDHT8L2HQoHJ/YrO5NJfNoEPe/ARmh0Kt4aNDyx8FG7yKBRkUQTmIhWSYp
	OQ4obRRWaiWCkVUPyYWWLZsyt5s9IWj5L4iibej6wiScW/XaySVbAdPKNFkej+wRSWq3PnGYkWL
	OwyzuXrN35SKcrtHhdTjRyWrVewtGmrNTalPia
X-Received: by 2002:a05:6402:1f49:b0:670:8acb:e822 with SMTP id 4fb4d7f45d1cf-683bcd9e581mr2819721a12.12.1778881085695;
        Fri, 15 May 2026 14:38:05 -0700 (PDT)
Received: from torstein-laptop ([2a01:799:3a1:9700:690:4aa1:581c:2e09])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm2484038a12.11.2026.05.15.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:38:04 -0700 (PDT)
From: Torstein Eide <torsteine@gmail.com>
X-Google-Original-From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v2 0/5] mmc-utils: improve lsmmc usability
Date: Fri, 15 May 2026 23:37:42 +0200
Message-ID: <20260515213747.1452692-1-torsteine+linux@gmail.com>
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

A cleanup patch is prepended to refactor CID parsing into shared structs and
helpers used by all three print functions.

Changes since v1 (review by Avri Altman):
- Patch 1 (new): refactor CID parsing into struct sd_cid/mmc_cid and
  parse_sd_cid()/parse_mmc_cid() helpers; used by print_sd_cid,
  print_mmc_cid, and print_list_entry
- Patch 2: get_manufacturer: fix static buffer lifetime, return strdup()
- Patch 2: get_manufacturer: simplify fopen fallback, warn once if ids
  files missing
- Patch 2: replace read_file() with read_file_at(dir, name), remove all
  chdir() calls
- Patch 2: struct config: remove ids_dir field
- Patch 2: print_sd_cid, print_mmc_cid: free() the manufacturer string
- Patch 3: resolve_dev_path: use stack buffer, strip partition suffix,
  validate device type
- Patch 4: month_name: switch to 0-indexed 16-entry array, drop "???" sentinel
- Patch 4: do_list: move struct config outside loop
- Patch 4: do_list: remove redundant access() check
- Patch 5: bash completion: accept more than 9 devices (/dev/mmcblk[0-9]
  replaced with compgen -G + grep regex)

Torstein Eide (5):
  mmc-utils: lsmmc: Refactor CID parsing into shared structs
  mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
  mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
  mmc-utils: lsmmc: Add mmc list command
  mmc-utils: Add bash completion

 Makefile           |  11 +-
 completion/mmc     |  62 +++++
 docs/HOWTO.rst     |  77 +++++-
 lsmmc.c            | 594 ++++++++++++++++++++++++++-------------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 ++
 8 files changed, 531 insertions(+), 259 deletions(-)
 create mode 100644 completion/mmc
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

-- 
2.53.0

