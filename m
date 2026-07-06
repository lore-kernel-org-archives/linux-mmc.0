Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDE395ADD
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329930; cv=none; b=Bj1T8wT6C6yGm1y4IoaeSu7feJcfxKCR0bs2A5eun47Q+Q39tRIAuKqyaiYHP94p6+XmfKi/q+sG+48x9qEySF5gIhm2gmaW5Crn/sZyg+0IkTwCiQgNNzD1jNnWXq+4P1gZ//N55TDArwu5yA9o+xA/GUYEL7MNeq8Peq8ZFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329930; c=relaxed/simple;
	bh=dACTrMLzfgfQ6gTt7ZY5sLl94/4hurSUBIXzgzd6EdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pksMY0Uo6C4xtgDYrEWDshXFkjOUA2zlnIG+swM1GP5vZXYVjuYLOLMdT4Pj1o/VLvrYB3cT1Uxkp4JNjnRbMEY+m92kmojOupRDht15/boc+8iws2RrRMrESCsuycZ79+eeg7bUuPuOQWMDBT8kUTu1EqMEihDA1k5fubhZDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Bm0b70Gr; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Bm0b70Gr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783329919;
	bh=M8HlZIFCaGyfA0eadmR0fKU6p9U1uj214JVtlZH28H0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Bm0b70GryAOqs4JgBiuK3TlZHMnOsFhwNV7SrRQ7MwF2H1E2HV/JcGj31hdMpoWhs
	 YsZGJwZY6/zeD3BP0veWviVeCumYi+0y3E/VKrr6WlZ786eQ03R5nXt/RbuaiBOszP
	 bTP/P0aTjELAgWlsTPRxRO5GAHciv+tNMIO4PAi4=
X-QQ-mid: esmtpsz21t1783329904tefc8f8ba
X-QQ-Originating-IP: AQjCOk7/TcHDQbi1hAdP7VLT37q4Tz2Hho5d0FjaGuM=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jul 2026 17:25:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16912968289962725828
EX-QQ-RecipientCnt: 12
From: raoxu <raoxu@uniontech.com>
To: ulfh@kernel.org
Cc: avri.altman@sandisk.com,
	beanhuo@micron.com,
	shawn.lin@rock-chips.com,
	jens.wiklander@linaro.org,
	kees@kernel.org,
	benoit.monin@bootlin.com,
	marco.crivellari@suse.com,
	b-liu@ti.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] mmc: block: reject invalid perdev_minors before division
Date: Mon,  6 Jul 2026 17:25:00 +0800
Message-ID: <C7A17066496D0ABA+20260706092501.853376-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MytpMCCBBwXiPBEqW6bYJFB4fi/8F9GuC5kRPRZQy7Ii5VbG1089N810
	5zkb+IfFIWEiIuO2EcEoAPJGAafq1EBeU31l7ASC3qJv+9DXnYgrpDmWarlPLJCGHn75q1F
	X3I0cxtbZRXguLvVz0KCvYhDWOvz5jmwk/J/4uySgIKhwExPyNJcKirsIR3iBeN1hyf3/y7
	VdGOdrr6gB2lHKA2yQSmaCJi7fzavOhM8jWLYXbOES7xiiHgjruN/1GYpU1u3Ugwv0aZh5b
	r2IoWc0UoyEx0woYINl6nltapnNReBIW/xmE68j1w7mBniv/ov7GJ95a1JtMr7drOnjscT0
	WLQwqkwbPYaGrwvkq5dYeUToBmJWs9nlJ+4sQb0mhZV/3050dbN83OngVVcQhuHVfYtWlSy
	9bymv/2YwPAUYmrwpbq9whYof+tMU7c8M18MA5BaaxFzI1ZqOZV0qWxUNKYidVeqyulrK+U
	dXOdjtfIqMCTD5az+2deRWIWP22eHYNnh15kPzlvKXOs73XCw6tjCO4eDyUQ4x0M0LzEA2E
	mnsVHDk6D0In0z+f0Pu1JOQ4Gj+ayhXzq9DvbXwDOkg1UUfYZfXTtpXlpojWRe24QcqNblv
	5G3vmtLEsPX9+N6w2YU+Fs39TWGrOVjSQBtMpE6WAZMvENpRkATVm/YH2gwYwcPhLABjn0f
	+Ae8rQ8O+G1EJRbBobcZV600nJsOzou3RUZRkjo/k1rcw3qQre1m6Mb5V1pGaELikwD7nto
	QilBK3zltwxIMutTqGn1pzzRX09rYwmVNJrpXAXTqJRL2fQVsZy+vTSpvVfI/Q9/RwJkt10
	Vmm/KxNaCio8p62cm4yEvEUTILEK+BPM8sdeH/H5CVCIFj/dJIsEIs39y0Qx0Dw0Kak5FF2
	uqO1NM+KwM6PQgE1ik8CvfBc2E6p9v+Yv8XGnws+HSxsYtADPdAoGtytfP5fEz4ozX4MkLE
	y7Crx2Zs/NmOzjZVG7OUlYUYoEZYqV9rHRIrkSFkZX9JvVYySl8k6Pj9ugg3/r2MO+VAqBb
	D4mLqpLvCdakeJQ555FWvJtIec0GMs/Y6ZJE0ZKUUR2XxQlu1NygmI0mZuL7gdBmJna/QBN
	g==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The mmcblk.perdev_minors module parameter is parsed as a signed int and
is used during mmc_blk_init() to compute the number of supported block
devices.

Passing perdev_minors=0 makes the init path divide by zero when it
computes max_devices. Negative values are invalid as well and would make
max_devices negative before it is later used as an IDA limit.

Reject non-positive perdev_minors values before registering any mmcblk
resources.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/mmc/core/block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0274e8d07660..9cfd27c90215 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3338,6 +3338,11 @@ static int __init mmc_blk_init(void)
 {
 	int res;
 
+	if (perdev_minors <= 0) {
+		pr_err("mmcblk: invalid minors per device: %d\n", perdev_minors);
+		return -EINVAL;
+	}
+
 	res  = bus_register(&mmc_rpmb_bus_type);
 	if (res < 0) {
 		pr_err("mmcblk: could not register RPMB bus type\n");
-- 
2.50.1

