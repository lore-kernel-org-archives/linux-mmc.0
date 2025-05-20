Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67421C9E4
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741551; cv=none; b=I1b6nehECpXE2yvdCNgGRag1axxdVrrG6i6p1LqRKr+90YT37mwJbSj8X/tZgWKXWqndM8Ec5UkTkIjcwpMv0AHEuwc8GPavBS41ptt8sw2SD3I9+TrWbssER1uehwHp6mCqR/FFpIpnr1417JVBsIXNVbK14Q54ynWsbZLeE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741551; c=relaxed/simple;
	bh=6nEgMVOFXdJWQ95yk8Vt/QHURmbC5GQno1AeM8YEWKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtIlsRJEXiFsT/Y8ZPprZCFw6bAjLbe5KyEwtNjyjJKA7vBxY6Mr4IiszORik3zyRngtwpav8o5F6NzGhn/TzqZFLiYIGBTP1TMx0heE4dO3w6tLSdhFZDEViWRj4jErXePd62HPaA+mKhp6+Co+1VR64LxCpBUvOMwfz8a41hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8Bx12lrayxonF3zAA--.292S3;
	Tue, 20 May 2025 19:45:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMAxzMRoayxoYTvjAA--.58140S2;
	Tue, 20 May 2025 19:45:45 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 10/36] mmc: litex_mmc: Use devm_mmc_alloc_host() helper
Date: Tue, 20 May 2025 19:45:31 +0800
Message-ID: <4405f00d7b7320f3a47342ebd661a208bc784064.1747739323.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzMRoayxoYTvjAA--.58140S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw18CFWrGF1xXw1rtFykXrc_yoW8XrWxpF
	s3JFyakrW3GF45W34UJ3yq9Fy8Ww4S9a4Dt398Gwn5Was0kr9rKF98Cay7tF95JFyvyF4f
	XFWUCrn5ua1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
	ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j4WlkUUUUU=

Use new function devm_mmc_alloc_host() to simplify the code.

Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Gabriel Somlo <gsomlo@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/litex_mmc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index b338ccfa8f33..d2f19c2dc673 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -506,11 +506,6 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void litex_mmc_free_host_wrapper(void *mmc)
-{
-	mmc_free_host(mmc);
-}
-
 static int litex_mmc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -525,15 +520,10 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	 * If for some reason we need to modify max_blk_count, we must also
 	 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
 	 */
-	mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), dev);
+	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(dev, litex_mmc_free_host_wrapper, mmc);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Can't register mmc_free_host action\n");
-
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
-- 
2.47.1

