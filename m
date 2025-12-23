Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F72222D8;
	Tue, 23 Dec 2025 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456740; cv=none; b=Sp3ZEb9KhwiXoPJVv2CyKUmeCRFX/tqrKe4xD8aN4cD7Y88WIYdGf9hvuNxs7FlyehfqSB+nLmcLAewN4EcZBHwH0D27vecqHHi3fAXfNxlbg2YsnLO3eN9bCuiBVoJ2P1zTsUyUEXiNFCfGtWRcYOqxLMzobeZCN7010n4NSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456740; c=relaxed/simple;
	bh=Mwz4mD+tkwx1nsWURsMNV1z+XbY+V1uxN9xNzwtuJAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aenATT9l9LnuBfWnGYvyURgAeeNjdqZTWnCb1DcPyv3Ytal8Oai1n5FaCLM5cJSKFj1ZlEXkpct0d+lvoLuiIZj3kXJlRLNrNm4HH/I8PIc+TF1Icp6/R7FPYzIre6msvuj48BMRioavHwqa/vHNFMfoCeRBZU4YqDfelEzPUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 08D4A340EA8;
	Tue, 23 Dec 2025 02:25:27 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 0/3] mmc: sdhci-of-k1: add reset support
Date: Tue, 23 Dec 2025 10:24:48 +0800
Message-Id: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHD9SWkC/32NQQrCMBBFr1Jm7UgmamNdeQ/porSTdBAayZSgl
 Nzd2AO4fA/++xsoJ2GFW7NB4iwqcalgDw2M87AERpkqgzX2QtYSGodPQp3mUTCx8orUdWYicuZ
 8clB3r8Re3nvz0VeeRdeYPvtFpp/9V8tVYuuuZvDODy27e+BljfEYU4C+lPIFBE0AXLMAAAA=
X-Change-ID: 20251221-07-k1-sdhci-reset-1990d1170437
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Mwz4mD+tkwx1nsWURsMNV1z+XbY+V1uxN9xNzwtuJAA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpSf2Kf7VnoThBSQORz8vGkFmgA549SBpTrrWq0
 nQufYgz/VGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUn9ihsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0uiw//cM/o1Oen8fYzJ+hL1YTV6bg2t1KXr38twAHGcpmAoVVwngF2pTZ5C
 pPLfW4GHft0m1x7hlfpXkIbVBZFc9wCsXByi6kqB7B4UMYCZNCecWlzxhAO7U7TxQJFRaCpSK63
 1qmX0s8Bmpo0MhXU1BOj4CS3zGbxkkw5QlI8tOHlrI0YyMPj6Jx4pF6C29aAQbr+zNdW+jf3nTb
 1fq4pAhnxbG27+CBaw73vPiXorLYu3i3OCLupIehZgQkzGL6HE53+olJwZ2vZ3DDehKD6w/I2NG
 zUKrEYkiPns9Atd1nbMPCjmjGyjyB1G8Fqag9UshIerkFnthxt7OcnIQ922YHIxr1kH2fF6ha1B
 3B+uov6HAQQ76Qpx4cMMagNuE7CF+DHfE9q5u/jRGF8H4ZD0k+5WArmOGPzor4JfBJmhYnDXYfV
 J1k5vZREFIRJahSDMD75A4Jx6y1SFZG+iaNZmd6R20bKJokXypCVK8mztAXvUhAsmTJVoKhy9TQ
 Xxuy1lEyF6yLk3RizevghA3E8o5bGKCekTllz+8WD9LguRgW6ilggzqq92f/PE5YI6WwLUUW8Px
 o+bf8HSvM69EHsWKCvu48QUGndGRL6trqUDLOwBhtlAxQ50ZrxF6C39gnVOUnimuz/KmQbptCuA
 g8//1pFwJm7rbhjbIOOLs9LlhHbe3U=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

This series try to add reset support explicitly to SpacemiT SDHCI controller.
Previous it works well for eMMC due to it's already initialized at brom or
bootloader phase.
  The controller has two reset lines, one connect to AXI bus which shared by
all controllers, while another one connect to individual controller separately.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v2:
- To not break DT ABI, make the reset line request optional
- Use devm_reset_control_get_optional() api
- Link to v1: https://lore.kernel.org/r/20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org

---
Yixun Lan (3):
      dt-bindings: mmc: spacemit,sdhci: add reset support
      mmc: sdhci-of-k1: add reset support
      riscv: dts: spacemit: sdhci: add reset support

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml      | 10 ++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi                 |  3 +++
 drivers/mmc/host/sdhci-of-k1.c                       | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251221-07-k1-sdhci-reset-1990d1170437

Best regards,
-- 
Yixun Lan

