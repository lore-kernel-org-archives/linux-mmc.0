Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34266B4E
	for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550589; cv=none; b=Nnn+8m1QoUR5m5UB5dffDbrXdZTGVfFWOku9G220MclE8dihB2XQmAArlVVqUUVA709ruaZLmlfn3IB1zzA6vpxkigCZgWuFseZR9a5KuoAwG3i9aaGza4p8LZ3phmDSm79KlzXnMQDhZwhLxhOZMCrky/AnnXUe/Gl2O+xVJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550589; c=relaxed/simple;
	bh=iiRktMYHLIJ9fptDhlCR5IFkYS+XarAW+y4+IYRyFw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pYXSA7a6I+8HgUafMzFeuaW5ljWrsl5TtSmbmPO7/CKWudTTSAMla7gZuZ/Ztfacow2M2Qt0WIbKoM7yVDGMnQ/8M9QZhumpRbEgjBfxpM9Ijere0nB5E0ijjiqx1vfQgsyG0PwoQ6is6CA1hd/XlKP9czG4LVZaAutFu1lyJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeU+u+gH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeU+u+gH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so10453718a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708550586; x=1709155386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Q8p0SNxiEFE6O8wlGL+9mnBksm30FOR3CroGvtLII=;
        b=CeU+u+gHSpthGT9lD1Z7wo9COU75Ry8rfrq+gqRGck12/9xV5bW7HP+Fv/+bAwC2MA
         21xfSvuSRDy2+DzOLShNmbuAeIpkTiDBgHxXbhKzXHBOKnKF46jNqjKiMaSO2UxINLJe
         2z0WhZNqi9kBEHNxFW51BF+HwQ3NJgwpSF3TBHNhXYAuSmjvyKATuaDviiZxglKL3dKu
         /SPb+T/HJ1o4P8B6mqP16iUezS+uNPKu91cEVvGP+6BVCdPyx0C9SR8mOktZ89WSd2Pi
         4iqZg6pZLAqotiIYvgdV0fnC+ACoQwtl8OWw74a9ZrTiKg36kwyfaqmJNMQkFiZVp5az
         /Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550586; x=1709155386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9Q8p0SNxiEFE6O8wlGL+9mnBksm30FOR3CroGvtLII=;
        b=es3SF+qcpFurLS9R0ZpHB7oqA//rl2ReMsIdm1K9uRrTCWeJKm5db/ZFEKQQ01uSGh
         CN0rxsGRtjQi7WZWP4NtBOAPBM4NeCHzjvNwPmxD8D3mqyO5djJMkF08Ku0blk2dBuGR
         BvZ2Nk0FAKwFzfZbH4RzTfoefQaOgFSm3t/IW4MXHclIcC+3ylFdfeoy8dAlG6OlLQG7
         Z2FoALaDQX56KEYxl07VLEx9ylqZRM7TxuKxpVbLlPcjVslhT8sQBwg0alzhH0mb8FdA
         tjh5CuCcsOPW2Ws4pmNIAWHPSWTQ3N3mULuT9hU0WY3xQMtNBu04kf+r+QhrSEosnJ/F
         2xTw==
X-Gm-Message-State: AOJu0YyHk8nyPBTkutws3vjlqfuqfJTrmHyEIx8E9aC3XB6n4vJ8LgU7
	D6Qe+RwYWcEadmxIRU090LFw9Xfb8NImuBEKbtRSB288VMRULROxRWVZxvQzOd4=
X-Google-Smtp-Source: AGHT+IEYXrfFWthgj6BeXcG46KD0grv5egr0h3pCKVPoxAcyTPYvN8NKxie1AqmF9wHr9/fz7MOoXA==
X-Received: by 2002:aa7:d697:0:b0:564:56ce:5570 with SMTP id d23-20020aa7d697000000b0056456ce5570mr6568833edr.33.1708550585958;
        Wed, 21 Feb 2024 13:23:05 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402094e00b005644221a3desm4018764edz.3.2024.02.21.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:05 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] Try to fix the sg_mitet bugs in SH MMCIF
Date: Wed, 21 Feb 2024 22:22:59 +0100
Message-Id: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNp1mUC/3WMywrCMBBFf6XM2pEkVNK68j+kizSPZsAmMpGil
 Py7sXuX517O2aF4Jl/g2u3AfqNCOTVQpw5sNGnxSK4xKKF6oZTAQG8sEdfVUsB+tNJ5Lexl1tC
 UJ/v2H7n71DhSeWX+HPVN/tY/oU2ixHl0YjB60FaG24OS4XzOvMBUa/0Cd6QVcqkAAAA=
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.12.4

This adresses some bugs found after the introduction of the
memory iterator sg_miter to the sh mmcif driver.

This was first just one patch for fixing the atomic bug, but
now also a second patch is needed to fix a semantic issue.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Collect Geerts test tag on patch 1
- Add a second patch fixing the problem with advancing to
  the next sglist entry before reading/writing the first block and
  after reading/writing each block in a multiblock operation.
- Link to v1: https://lore.kernel.org/r/20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org

---
Linus Walleij (2):
      mmc: sh_mmcif: sg_miter does not need to be atomic
      mmc: sh_mmcif: Advance sg_miter before reading blocks

 drivers/mmc/host/sh_mmcif.c | 46 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240220-fix-sh-mmcif-49c1de70c5b7

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

