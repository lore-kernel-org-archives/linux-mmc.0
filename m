Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.91.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187801;
	b=ZjAeqOiIlODHkLDzxjso7AFnjT2Ua9zf99o8DMzh9L/ZTVHrCkHSbgyBzhsgFQcpQkaz
	 bHC7deRI3NrmLuHMCBKMomawuHeUDG+PzDSUqpRXCkGctdGLOcMEHO1OCn5cDbaroXTjZ
	 sTxkFX2d9K2jr0gQmFakmAMsXzJFGddspC127Yg3loU2fJ21Od3qhOfok72CVDwsQhi/P
	 f2oQeg/P0DLmzqPZhfjqWupinqC6bBBxTIxOZgnk6HK8uaH3YTRzuu+saylRxLy3/H5k1
	 /X72u6k6q8EqwDkqNxbjjDM2H1zSi8uourI8bXzD2jjqibbBMwulhvRRWamLJcDy+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187801;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:From:Subject:To:Cc:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-JNJ;
	bh=OsuVkeafblGpTsXYut7m1aN/nlY5ZzIRjoB1MM1Rhx8=;
	b=wbMXzs8v5GVKWFrPX/dI5kRDiXU52G6l+qZj9HVRg7vwX36XBcWMb6cQxXI7A7x6Ma0E
	 9zV0wwrZAoAb9kxwNucI4wiJzbA3RxsFQvnMdCCTzqJHKPQtI5nVRtI/QopOSocI3uZc1
	 2fPXZ5jECHuSQ6a2dazfEo7cBBr7h3d35AVKNddUadlRldt21ECYyGX2BPumJym5pXgWL
	 NLsNnPlgTBrgw8gc4RPj/QYuRktxLuESTSbb+YxN1uaN9yzIG5q03jyT0oyZhPTRg6Id+
	 unggvpZdDfNGCJGkuqBoqHOqVaRHY4p1zEBJfLg7qT4lH3Skf8Zij1Pp9xev+Jm4hfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=manyhobbies.com;
	spf=pass smtp.mailfrom=manyhobbies.com;
	dkim=pass header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=hwNbtXvn;
	arc=none smtp.remote-ip=57.103.91.143
Received: from outbound.ci.icloud.com (ci-2003b-snip4-2.eps.apple.com [57.103.91.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC2606A31A
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 11:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manyhobbies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=manyhobbies.com header.i=@manyhobbies.com header.a=rsa-sha256 header.s=sig1 header.b=hwNbtXvn
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-10 (Postfix) with ESMTPS id 6C1051800820;
	Wed, 28 Oct 2026 11:43:18 +0000 (UTC)
X-ICL-RepId: 01a18252-5d6d-7bd6-91d2-692952ce09ab
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAUMGWQZeD04dXwVcEhVdRUcMWkVWH3kVUgNOA10SWxFWHhkIXR0ZHldQWgpcCVEXUQ9eDkFeWhdeTUUID0kZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1UGV0UXwRQElAdQENUBF9QVBFXUAtaBUkKSQtaAFMERglWC1wEXAdeCEkBWwRZB0gLQANZDl0DRQxLB1l3BlMeQBBcD1UCVwMXG1wACUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manyhobbies.com; s=sig1; t=1793187799; x=1824723799; bh=OsuVkeafblGpTsXYut7m1aN/nlY5ZzIRjoB1MM1Rhx8=; h=From:Subject:To:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=hwNbtXvnnR59r7qgS5h1p3fS16aD5jzIeyH6FfM/P0jckDlcg/ea2roFPOaOUG3J/sb081LehV5wvctDZ/JiMRzjuh8SU/TYry5D2bxTyoPyNIiVFQNdgFJDsGrAy5E0jl6a3Ka7FE4sxX8B0I2kBApvKwhZzSkSlqogs/WjPtNceikWDst1iRwoB3qmZw4xPH1EzPUwPoPnJoTCjz0XIpvAam6R2m/B8cJZr1W5fmag0lxrjvkDJDxJIDfBOLgUQDYUPYfQpK0na1nRpHwaj5tJ4QU3NTx4UyOPY6VSvkOIKY2b9BuD0skdqxmIXQB+5RYx+6gfh73l9TCDfnDoOg==
mail-alias-created-date: 1780273699991
Received: from claude-agent.manyhobbies.internal (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-10 (Postfix) with ESMTPSA id 9048C1800839;
	Wed, 28 Oct 2026 11:43:17 +0000 (UTC)
From: Tam Do <tam.do@manyhobbies.com>
Subject: [PATCH v3] mmc: sunxi: reset the controller after an update-clock
 timeout
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
    Jernej Skrabec <jernej.skrabec@gmail.com>,
    Samuel Holland <samuel@sholland.org>,
    linux-mmc@vger.kernel.org,
    linux-sunxi@lists.linux.dev,
    linux-arm-kernel@lists.infradead.org,
    linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 11:43:06 +0000
Message-ID: <179318778660.81375.11263258280496155344@manyhobbies.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NiBTYWx0ZWRfX9v7vwJCZUAQh
 cJY9YliLJf5Sj7s8z0lAbLqgy4FCJ+wmLCJ1GwC5QAur6kNEf4/BFfS6/FFWLkZxtGHz9NTkVeD
 vBCi1Iwab93fOTroBByohOYlMa98l/5Lu9VqV4CjwBEyizskLbu9OaCmeohQoNAlf+KTJRCrBpS
 C6zZRoQ8wGLqR7sCw6RI/3aPA2hMx6dq32DuMb36aKZe0uJiB3CHuNwS7zx2wuCc0b9Nb0oJgyt
 DxqZQ95bkDKbBrgjyFQag6cf2O6JytdZKdd+ksQoMHocnZw2HWcROlehudyeOiPCJgyhu1Rh7LB
 luZ+La2Hc5IEZRt92uJjS8ig8/Fvh/f2BdEVv1eMwoeo96eaIeGc1YBiF8r4+0=
X-Authority-Info-Out: v=2.4 cv=L74QguT8 c=1 sm=1 tr=0 ts=6ae1dfd7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w2OPf45SAAAA:8
 a=1tvfc1y3xX-o4uWKYHEA:9 a=QEXdDO2ut3YA:10 a=-iXIJKm6ftRzmWoHelNS:22
X-Proofpoint-ORIG-GUID: VSrRne3TfcgmffBp2ODlyHQ9fNAP35cV
X-Proofpoint-GUID: VSrRne3TfcgmffBp2ODlyHQ9fNAP35cV
X-JNJ: AAAAAAABnZTtDZq/p55h04EW18ZZXuIli9DAQsyjrV651gPUhYbhFPONnpN4Q2l1D7zh4h
 jrNXs/YFjDA6Bc66K1KHPplaC618Obo/QKJfRxNwzx/llyrxopXKzk1QMlJXTmC6A3JH9k
 KOx0wC755kgtChPDKOkD9zfVh+aDbg/8iZRUD+HUldRc8IeOy+5ggKT8k8h25lj7JoAmtH
 5H4qEAbxEbogSP4abWSsRcR8/WqdHkjdpZqnu0QqctC9bGgWbopMNVbWXujObrwRBrGStb
 h+uaGM7Nmre1ZIFromtNOwQkx3WddvxeN4berUVREtE0sz2y6nez4cGg5QLIpT6mnBGD6u
 xS8LQcpp79ORU7urxKHgmCvgE7bw+0EhEFUeGipD1TFkyWEev345KJNNPKdJBiehBK1n9C
 /n92+exJYEQDOIkxBay5BNga3YfW+uvtnYwWRsyXYEazHgyWLBHMvgZaGydwF9HtKg0bAF
 uT2Ik9ZvHmkzzc1ce87Jf1QhSB1UUDFXrDwem6m3YPHaAbRJD8D3SaGt1JI+PRj5ydU3uT
 ZcwLfbKQhMAVCIwYba4d07PJammAtKU+L/8wcdXtkI8XHWEtrykhPPY6JSI8bBG43vy8dG
 kgjGdm182S0/9AhzDp0EpZ+xz0JQ1zDIVUwzfgu45ct6ZTMZoN76K928XsckRATN/C7P4H
 eQ6nGpkmiWsppNeCnkTVH8vAYzxH770OPo9qF8UY+rA9hNt3oWLnD0J4XRQgnLc8uryHcQ
 eGrAv6ruAjklRXg5/oms1LvE0Wih++CTw5ICWVI+aXA/n5UdJ5OHty52H0WVISDW+4tvIR
 8UXEmk+0s8R9TbBZwivGJHkJM7sL/CMUw/3PyopCouOgQJGHUHtX7rF6BOkrehGdJeHF7i
 Pw/hyjOUML+QMhsnl/CEY3+q5fBreUcdfZcC9BdHNGNYkXCtQp2SI5gbHnJaN4RmfuvbOY
 QHeDN6QPjXJymQGLcYGpMal4OZdbWCFn5tq4ptVr56UlSvCkdtadjJMTiCUjuSCVQMtHX8
 uGAIIQBbAfuLBBxm8Ush/yw8SWT0Sn/gCtp5gf3Vzq+d+lP6WdMQ54FNDt2ZQvOPSUrHGs
 ueoY29CwlXH1ikSbY+qDWtqlVtMFTJXXrLPxH95vdJJM5w6JKXNF3PVImepC/+D4g65U8D
 qJhfo8VQlnloXhUlt5dfAGAsaYgJL4EOEDWxqFFYbUZJRC0aTLVbKOx3c1Vgfe4MnTv/75
 G9owgtAxXrjrA60wSpoul5PyOywNJy4nUrGbARfutKqiBVB+kokHxYBilZDL9ZdGseisPB
 V4Hyvm1XM=

If the clock-update command times out it stays pending in the
controller, and every later clock update times out as well, so the
card cannot be initialised until the next probe.

This happens on an R16 board whose SDIO Wi-Fi holds DAT0 busy while
its supply comes up during the first clock update.

Reset the controller on timeout so the next attempt can succeed. This
runs sunxi_mmc_init_host() with the interrupt enabled for the first
time, so write REG_IMASK from sdio_imask under host->lock, as
sunxi_mmc_enable_sdio_irq() updates both under that lock.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Tam Do <tam.do@manyhobbies.com>
---
v3: take host->lock only around the REG_IMASK write in
    sunxi_mmc_init_host(), not across the reset; v2 polled the reset on
    jiffies with interrupts off. The return value stays unchecked, as in
    sunxi_mmc_runtime_resume(): if the reset itself times out the
    controller is wedged either way.
v2: held host->lock across the reset (not posted)
v1: https://lore.kernel.org/all/179307312104.39863.12372814163472848752@manyhobbies.com/

 drivers/mmc/host/sunxi-mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe4c0f6d73f3..55313780d06d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -322,6 +322,7 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
 
 static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 {
+	unsigned long flags;
 	u32 rval;
 
 	if (sunxi_mmc_reset_host(host))
@@ -336,7 +337,9 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 	/* Maximum timeout value */
 	mmc_writel(host, REG_TMOUT, 0xffffffff);
 	/* Unmask SDIO interrupt if needed */
+	spin_lock_irqsave(&host->lock, flags);
 	mmc_writel(host, REG_IMASK, host->sdio_imask);
+	spin_unlock_irqrestore(&host->lock, flags);
 	/* Clear all pending interrupts */
 	mmc_writel(host, REG_RINTR, 0xffffffff);
 	/* Debug register? undocumented */
@@ -688,6 +691,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 	if (rval & SDXC_START) {
 		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
+		sunxi_mmc_init_host(host);
 		return -EIO;
 	}
 
-- 
2.39.5

