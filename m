Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9893E227EBE;
	Fri, 16 May 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386814; cv=none; b=ld+ltv6PRnop8hEPKuPe1o3ZIhz4VdfUGkZvQEGnPdXohZXMwEVZFrOI5saMebinGjGU4bqSZn4u9wXdGxe1eSlACGEd1pxHweoIHF6ZXCJQ179lPB35hr8DcXcVdpZTXzP0QBj7zH9FUUBS3FKLTKLMn+3SPAZO1S6ijtgWLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386814; c=relaxed/simple;
	bh=2LTT0+WmAJtlQ1IqZtUhdjsXEEI+MhON5zg4EbTcuJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YX4brUVnuVnX8RN/poXI5hXf6U1K/ylkdZbrzup5Gh7aFZispRntFF9fw4EwCShxu3tDHUiawXccujLPiJWxBmDwLtkzq1ojXoN6kv72oiUNlnnYmWHY5PiEw9gLfamLKZfrf7XieWiZnOHLVLvQXMTMM03Zxtn1iecJZ2S3OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgDXaJKqASdoD9F8AA--.41109S2;
	Fri, 16 May 2025 17:13:16 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	shanchun1218@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v1 0/2] Add driver support for ESWIN eic7700 SoC sdhci controller
Date: Fri, 16 May 2025 17:12:59 +0800
Message-Id: <20250516091259.774-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgDXaJKqASdoD9F8AA--.41109S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4fZFWDGryxuF4rWF17Jrb_yoW8Ary8pa
	1ruFyFyrsxWFyfJ3s3G3WYk3y5J3WfJrWYkr4fWw1rXFW5ury8Kr4fKFyYqryDXry8Ja93
	Zr90gr15CFy5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

	Add support for the sdhci-emmc and sdhci-sdio functionality in the Linux
	kernel. The driver provides basic functionality of emmc and sdio for the eic7700
	series chips, which are part of the	Eswin SoC family.

	Features:
	 Implement support for the ESWIN eic7700 SoC sdhci-emmc controller and
	 sdhci-sdio controller. Integrate with the Linux sdhci subsystem for consistency and
	 scalability.

	Supported chips:
	 ESWIN eic7700 series SoC.

	Test:
	 Test this patch on the Sifive HiFive Premier P550 (which uses the EIC7700 SoC),
	 including emmc and sdio peripherals. Perform read, write and erase tests on emmc.
	 Read and write tests after mounting the file system. Verification of kernel support
	 for emmc device. So this verifies that sdhci driver patch is working properly.

Xuyang Dong (2):
  dt-bindings: sdhci: eswin: Documentation for eic7700 SoC
  sdhci: eswin: Add eic7700 sdhci driver

 .../bindings/mmc/eswin,sdhci-eic7700.yaml     |  131 ++
 drivers/mmc/host/Kconfig                      |   47 +
 drivers/mmc/host/Makefile                     |    4 +-
 drivers/mmc/host/sdhci-eic7700.c              |  353 ++++++
 drivers/mmc/host/sdhci-eic7700.h              |  237 ++++
 drivers/mmc/host/sdhci-of-eic7700-sdio.c      |  991 ++++++++++++++++
 drivers/mmc/host/sdhci-of-eic7700.c           | 1053 +++++++++++++++++
 7 files changed, 2816 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
 create mode 100644 drivers/mmc/host/sdhci-eic7700.c
 create mode 100644 drivers/mmc/host/sdhci-eic7700.h
 create mode 100644 drivers/mmc/host/sdhci-of-eic7700-sdio.c
 create mode 100644 drivers/mmc/host/sdhci-of-eic7700.c

--
2.17.1

