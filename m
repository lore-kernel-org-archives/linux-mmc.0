Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F4145B3E;
	Sun, 21 Dec 2025 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305256; cv=none; b=fVcLVG2RB3vIgn74IQWba8uGS4cRobmded6jBIZFUgqYQvlhiilncslmwuKm5riORdDXiU29zuw4QU4fVAxspmDBIc+qMNhHOJv8RZLwhiUnMg5N+JjdbSHjyp9GsnOv7zthGZOTMKF4vCg9lg4EY/CKrMyBo+mcSNmkLH6FAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305256; c=relaxed/simple;
	bh=fwDvpWFME/C3CoNwdgQwLHWmN81cJv0j91O9vkwGH0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cjwLZxuOYSDO0b0CYizezRce+IvxzKQB3Svj8Y8RcrXqcvZSDw8BFmIQ9JGSPEfa62DYSX9YEMCt/nTjlRIYft7EBxlEMNIpXSP4zJ8INjAdpXp4ZN7yFCLEuLsq4yv9WZWMgs7SyxJh8Fx7W/YkAkbuQarx1YWlxsAk+mwQ1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 38FBC341073;
	Sun, 21 Dec 2025 08:20:48 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 0/3] mmc: sdhci-of-k1: add reset support
Date: Sun, 21 Dec 2025 16:20:25 +0800
Message-Id: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmtR2kC/x3MMQqAMAxA0atIZgNNVUq9ijiIjTYIKo2IULy7x
 fEN/2dQTsIKfZUh8S0qx15AdQVznPaVUUIxWGM7spbQONwINcRZMLHyheS9CUTOtI2D0p2JF3n
 +5zC+7weVBIgGYwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=fwDvpWFME/C3CoNwdgQwLHWmN81cJv0j91O9vkwGH0c=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpR63TYA7dRtb2KLL1GGbovWqV0rjPXrxxtgSgP
 P3Of3F6n6GJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUet0xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+07Ug//UVu3AxsoKrERtL5yNRs3jBYzDq6Cv5supSGRzMfHGcancvH7MiOf+
 ZZ07qWPFJ1a1qV5yoDwqTVDpWGzBt2pOsO8Q1TZPhMqu5G6Zt8TdXJHvbLRqEeykTSyDIY0Zz4+
 qOl6c9nxbyJaxpDHNa+/Blqe2gEzWs6hX5qcSqI4bhZhl8IbFK20NxNTfrKG7pl40/Rupn4Xdl/
 QJy66SL/YOSFH1F8mYIyABcDHZ92Uq3+5ITYP/IezvMHQvkunxvF3UZna2susEHMHGbcpxCuv8R
 JrtCr/HOn0GoRc4+BzXwQEBwjCENoL2EnprQpWOzHKhJsyjQOuWU1URn6829rA8W+4m3UCYwJAv
 6Pm6ljmbnTav8jCeAC9LgQft+2b88EuVtDYZi9OaQq7+kIuciedBomikfhZcQgoabumVrTLeol+
 GUm3DcMIpd374rUoSCnOAAfSdnAHPVUcEwl2Dh00H/wmWNAsQT13LeKHilKBOAdYthvCrLAiY2E
 O3QYCYqrp4TB6qEMgbfGa9vxff4AsqRdmeuHJ6Cjh9muHf4ZGauakHyi0sp+DHX/dKRt1SWkia0
 XP0pb1kNgD47u834WVk8Ahum6d0c4ccWY42ALVOXkB6uIxJuSczqN+Y1uZsLdC3cfL3zHXg2TJ0
 o2GPCUD7THxT7qqBMprv7EtDql/vnM=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

This series try to add reset support explicitly to SpacemiT SDHCI controller.
Previous it works well for eMMC due to it's already initialized at brom or
bootloader phase.
  The controller has two reset lines, one connect to AXI bus which shared by
all controllers, while another one connect to individual controller separately.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Yixun Lan (3):
      dt-bindings: mmc: spacemit,sdhci: add reset support
      mmc: sdhci-of-k1: add reset support
      riscv: dts: spacemit: sdhci: add reset support

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml      | 14 ++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi                 |  3 +++
 drivers/mmc/host/sdhci-of-k1.c                       | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251221-07-k1-sdhci-reset-1990d1170437

Best regards,
-- 
Yixun Lan

