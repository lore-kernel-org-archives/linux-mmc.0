Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674B43CECB;
	Wed, 21 Jan 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980487; cv=none; b=d5Fb56swdu3WvjfAvyCIsErUus8rlr+DeE/zYg5Bv2CKzUTshqaFsAVCkmtsAWptYD6K9nwDF0s40NNawf2l8uZEZeGsOp+kxiBtSzb3tQZ/tivALgdDLZB0FNvmUKcWksamPsj1O5Al0JPDvT4M1sb5skFc3FAsm2ghalTxiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980487; c=relaxed/simple;
	bh=1Oh94yu/kL/t6er6f7NIe1Qp1FFW9S+PybGe6FlLZHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X+eUpHPwPZ2o9EOfAIM4w+I9J+RMKfPG8GkRdMTj25AYR8WMJoAgFjGa0TSqk6d8TKRKXHs+/vyVU99h66kUzGriy/uE7xhRSBlHhIDDUz6yu2XwWwbLJxMxsGr/0KDwQhGO/hLR5IudvTpK9DfqnDpXuXKN2V13LeFVbUcbMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhjfZJ21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhjfZJ21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB6C16AAE;
	Wed, 21 Jan 2026 07:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768980486;
	bh=1Oh94yu/kL/t6er6f7NIe1Qp1FFW9S+PybGe6FlLZHU=;
	h=From:Subject:Date:To:Cc:From;
	b=QhjfZJ21jf6EGEXDW6+iEsvj5JDAHD9edFPeLIuMM8e8nwANaobZbxDUZ5dxWZV17
	 wxm9odXvvWo4fdU0COQCyxHF4+t9rfgfTRddCZr8Feb66/KbqARhVYHom9R1g1Et/4
	 1VzyiFDToeWmeFXnQ1W7ShRqZDteAwPcXQ2eUZZGx9xEmiuhUw0P+Gn4WKjQPC3pNB
	 rwUd1kZsHpPvrPht4nYe8uScubX71CrXKimmgPfTt1pLegEKlcXMWn2Y/h8iJ1uP0T
	 eErtKZU0RCB78S/aeNLfT5+kecGK8hnWQ9J7NQd1HXKFzDg/UE0O3JEo7C9j6I8NQ+
	 amAYe5ZANSTsw==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/2] mmc: spacemit: Add support for K3 SoC
Date: Wed, 21 Jan 2026 15:27:34 +0800
Message-Id: <20260121-07-k3-mmc-v1-0-ff77c07bfdf6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOZ/cGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MjXQNz3Wxj3dzcZF2z5EQDQyMz81QLYxMloPqCotS0zAqwWdGxtbU
 AOlcaI1sAAAA=
X-Change-ID: 20260112-07-k3-mmc-6ca01267e834
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yixun Lan <dlan@kernel.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=dlan@kernel.org;
 h=from:subject:message-id; bh=1Oh94yu/kL/t6er6f7NIe1Qp1FFW9S+PybGe6FlLZHU=;
 b=kA0DAAoBMarqR1lNu+0ByyZiAGlwf/qiAxUKtChbUUvTE3OCecGbEPBUlt4Vu8bn/vU6Op0QS
 4kCrwQAAQoAmRYhBLW6uMnDG3EVZwIj3DGq6kdZTbvtBQJpcH/6GxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjExLDIsMl8UgAAAAAAuAChpc3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9
 yc2VtYW4ubmV0QjVCQUI4QzlDMzFCNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqu
 pHWU277bsuD/4s7LzzrEsbzAHo6QjeIKdv/YeJsWD/JLVS4oubGZBLufaEkBnbVgNMyeBP5Ok8z
 6t5sbZn0OeI/a31RsbMPPRphnuWh2bjgJQ7bMUoA4FntwG+rmSWTmhsFWz6hPO4MbdvufTgtUXm
 DUMa7VhiYvkEiar+pALY9j2LNEmh6VxPGfZYf5Wz1ZEDWsREFy0jJY1n8bjdBYzTpsqpe7h3ZxY
 LLsTblrlxvkdHRAYaAphRYk3El8I2K9qPH82tjDiCQPKswYQJ/DMJg30el0xE/cb80UKlEa6ook
 lqB0fimro7mjKjorA3wOWNrd/VLWhYovBnnM3LiX0q/bMGD6gfRF9AndBkihCUhF3UU6zmP+v9c
 GsksDPjvnLOHmmw94GVnBxgpaZe6YFT+wEhzQ1/lLYd+8frij99hxMLil+avZvYRwz+Cw018U8p
 b7wDiRgjNG1gjEy0plJIfPLEf5dagvo6nyC5QsyV9yotiEYHh8ypikV4RcgoujBgUMhbEw32yej
 zGy0WS83dELVp5Kd448gyAmkgQNd6YIvU10P7B1X5+yBnO8f422c2TAQd5+eb4PJZP6C7mjaLx8
 XvXwc46xwelmgGH0RzugcnzsuUP9K1SLBeNI17W6iirBj9xdO8vvXJ6UpvDNEFgT3y571jBlYYr
 7nwmjgbFyOxP8tJ8qbl7g==
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Enable SDHCI controller support on new SpacemiT K3 SoC, while as before
only the third controller and the eMMC device has been tested which using
vendor K3 evb board. This board has not acquired support in mainline
kernel, so I've omitted the DT part patches for now.

The new SDHCI controller almost reuse the same IP as old K1 generation,
while fixed the broken 64BIT DMA issue.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (2):
      dt-bindings: mmc: spacemit,sdhci: add support for K3 SoC
      mmc: sdhci-of-k1: spacemit: Add support for K3 SoC

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  4 +++-
 drivers/mmc/host/sdhci-of-k1.c                     | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)
---
base-commit: 6cefff068d030786d63fa50970d6581c354630b2
change-id: 20260112-07-k3-mmc-6ca01267e834

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

