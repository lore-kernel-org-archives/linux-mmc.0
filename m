Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9C19E7ED
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971818; cv=none; b=EVuQ84GGnh6l/51RSATOB+mfh70b8SdL8qIuMUkqpcRp8Gsa78BTYFjbszTLj8ag+MsZlIid4VN/C9N9+A7TyZzEA+jYaXMDZrWxpRK3XnVvFvGkDXb/ewXffHCtB6XOnnydIdVhu5SoFdCE5Fj4wFSFJZ5vYASMUQtnpF1+sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971818; c=relaxed/simple;
	bh=miNv3339r2WX86DHjC8+SXqHozQqvgiqT3TsmhMpGfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ADNS7/PUS/AvA/4u11SvJJRiA23Fz3bQy/pa36vzVb5RaL11J49fUMocP+GhyqjZKRNizikpHtdPz7ZlfOe2OnfhYTAdhoCvxMW8ZyaMAANH/oQ2kC8F8d7BjRvpZy0+s8O3EM2DP5KhjnotOmk/wImM5uToKqKSvCfs4K1HguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a7Hzuj8M; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a7Hzuj8M"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241003161013euoutp0276b12608509f757478538a98262cef6e~6-TWcOYFE2413724137euoutp020
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 16:10:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241003161013euoutp0276b12608509f757478538a98262cef6e~6-TWcOYFE2413724137euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727971813;
	bh=2mG/1HmIe7Kzfq4rY/1tvTUa+HooXzSlE7nFPxQHY9k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=a7Hzuj8M5PqMQX9HCqpQ11VZuLFalrayHz3QpyIIIPz9/W9Bq2pUhJP8A4t6H7prs
	 H/Hv9CozST6X61ogNuqYcVt0jJMgh5xfXPFt42Mq0II8ZkvQzn7GRgU+d7XbHB6cYl
	 hpEH0GZC/TIwiy5Zpsobov/xtWMbWEgPJ67Z/qy0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241003161013eucas1p2977b41aa8b063fc477653ecc5cbc33fe~6-TWHq7Wj3105631056eucas1p2y;
	Thu,  3 Oct 2024 16:10:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.DD.09624.5E1CEF66; Thu,  3
	Oct 2024 17:10:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d~6-TVp2NVQ3115231152eucas1p2a;
	Thu,  3 Oct 2024 16:10:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241003161012eusmtrp1574d0361dd728e8147246bdefa7a6469~6-TVl3zyC0752207522eusmtrp1w;
	Thu,  3 Oct 2024 16:10:12 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-92-66fec1e50102
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.4F.14621.4E1CEF66; Thu,  3
	Oct 2024 17:10:12 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241003161012eusmtip1768f167a46cdee0fb2b42ee9f529a0f7~6-TU5fAU93183431834eusmtip12;
	Thu,  3 Oct 2024 16:10:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v1] mmc: sdhci: Prevent stale command and data interrupt
 handling
Date: Thu,  3 Oct 2024 18:10:07 +0200
Message-Id: <20241003161007.3485810-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7pPD/5LM1i8Q8Di5JM1bBZbf89i
	t7i8aw6bxZH//YwW2z63sFmsPXKX3WL91/lMFi8v9zBbtM3itzi+NtyBy+PNy5csHoc7vrB7
	LN7zksnjzrU9bB6bl9R79G1Zxehxqfk6u8fnTXIBHFFcNimpOZllqUX6dglcGaemLWctOKJe
	0X7xIlMD40qFLkZODgkBE4m/jyYydzFycQgJrGCU6Ng5gRXC+cIosfvEAyjnM6PEp7a9bDAt
	T7etY4dILAdKTHzLBOG8YZT4/GUTC0gVm4CRxIPl88HaRQSmMUpsmn+LBcRhFuhjlJg04yBj
	FyMHh7BAsMSm4/kgDSwCqhJnlx8Ba+YVsJfY0b6cGWKdvMT+g2eZIeKCEidnPgGrYQaKN2+d
	DXa5hMAZDonLDfMYIRpcJBZ8es8OYQtLvDq+BcqWkTg9uYcFws6XeLD1E9SCGomdPcehbGuJ
	O+d+sYHcxiygKbF+lz5E2FHiX/t5JpCwhACfxI23ghAn8ElM2jadGSLMK9HRJgRRrSYxtacX
	bum5FdugOj0k3k/MAgkLCcRKfL99mmkCo8IsJH/NQvLXLIQTFjAyr2IUTy0tzk1PLTbMSy3X
	K07MLS7NS9dLzs/dxAhMUKf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8M7b/jdNiDclsbIqtSg/
	vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgSlFMZlleTqjkn9s8F0eYT02
	sy+HvQI+va5hPifnXedq1jvv84TOJxv3SfttN5/4RX+XlFqPyLfA99EpEZdDZD3L81IvrM09
	FLrhuOTOdu+29zPrZNUsn03jebT64c2Y5dmn8ndtSmzO27Eq5fbpVCvW5LY8Rw2p3SYGUgs+
	H2Q1tE796rysiGXDiiW7DtaeXxTD2n9hSaVExDWeo9MXv66TerVGQ91K7frzw4+ORG8IP+1d
	82ZhisWMD3LMTCUFb++ZFR9eJ3nKodBL64zKmirJJq9HpUF98dL75m/uelgVfO1JOKdV0Key
	80ZLhUTUTcMVz1zj8jAU27z9kMiPO1NNY+TvHbR1jD7p3tg5R4mlOCPRUIu5qDgRAGhaC9K/
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Xd0nB/+lGWx8pWlx8skaNoutv2ex
	W1zeNYfN4sj/fkaLbZ9b2CzWHrnLbrH+63wmi5eXe5gt2mbxWxxfG+7A5fHm5UsWj8MdX9g9
	Fu95yeRx59oeNo/NS+o9+rasYvS41Hyd3ePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sL
	PSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFPTlrMWHFGvaL94kamBcaVCFyMnh4SAicTT
	bevYuxi5OIQEljJKbDtxnRUiISNxrfslC4QtLPHnWhcbiC0k8IpR4vQqsBo2ASOJB8vns4I0
	iwjMYZTYu+kpM4jDLDCBUeLOq2NgVcICgRI9S6czgdgsAqoSZ5cfAZvKK2AvsaN9OTPEBnmJ
	/QfPMkPEBSVOznwCVsMMFG/eOpt5AiPfLCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl
	5+duYgRGx7ZjPzfvYJz36qPeIUYmDsZDjBIczEoivPO2/00T4k1JrKxKLcqPLyrNSS0+xGgK
	dN9EZinR5HxgfOaVxBuaGZgamphZGphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPHxMEp1cA0
	SUupYO++8rrgRF0/S8lXyU/+Nf888fPlCu9yj6fmh2OnO59wcFnF0d3140nUlCXbxTmjz8xb
	I9F3y6D1/M+CKasM9+6M0hVj2mg3ZfpKwYzvf4PcHf4Z2+qI3/tx+Etf4cT7JWHeKhM2Hn35
	aPrZnvuGnZMFXQ8lZCoZXnztNvHmK/eOqIMP7vVt1LjUcnTm93ni3/psJKUSPduj3Z4LpMc6
	Sjoosk4X21QlWf9lUbIzk4Nbnkh8x3n7TYVVzbZfjW16zTJdXyq1Va6u40nSsT0THsvwKmQq
	8yoXL/ZFU+sfta9nYJbP2XPVyG5n67vYwDbmyqb7d5ms+hVv3hPkSDr/3mjnnA+9x6xY/iix
	FGckGmoxFxUnAgAJKHOPFwMAAA==
X-CMS-MailID: 20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d
References: <CGME20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d@eucas1p2.samsung.com>

While working with the T-Head 1520 LicheePi4A SoC, certain conditions
arose that allowed me to reproduce a race issue in the sdhci code.

To reproduce the bug, you need to enable the sdio1 controller in the
device tree file
`arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi` as follows:

&sdio1 {
	bus-width = <4>;
	max-frequency = <100000000>;
	no-sd;
	no-mmc;
	broken-cd;
	cap-sd-highspeed;
	post-power-on-delay-ms = <50>;
	status = "okay";
	wakeup-source;
	keep-power-in-suspend;
};

When resetting the SoC using the reset button, the following messages
appear in the dmesg log:

[    8.164898] mmc2: Got command interrupt 0x00000001 even though no
command operation was in progress.
[    8.174054] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[    8.180503] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
[    8.186950] mmc2: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[    8.193395] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[    8.199841] mmc2: sdhci: Present:   0x03da0000 | Host ctl: 0x00000000
[    8.206287] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[    8.212733] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x0000decf
[    8.219178] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[    8.225622] mmc2: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
[    8.232068] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    8.238513] mmc2: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
[    8.244959] mmc2: sdhci: Cmd:       0x00000502 | Max curr: 0x00191919
[    8.254115] mmc2: sdhci: Resp[0]:   0x00001009 | Resp[1]:  0x00000000
[    8.260561] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    8.267005] mmc2: sdhci: Host ctl2: 0x00001000
[    8.271453] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
0x0000000000000000
[    8.278594] mmc2: sdhci: ============================================

I also enabled some traces to better understand the problem:

     kworker/3:1-62      [003] .....     8.163538: mmc_request_start:
mmc2: start struct mmc_request[000000000d30cc0c]: cmd_opcode=5
cmd_arg=0x0 cmd_flags=0x2e1 cmd_retries=0 stop_opcode=0 stop_arg=0x0
stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
retune_period=0
          <idle>-0       [000] d.h2.     8.164816: sdhci_cmd_irq:
hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x10000
intmask_p=0x18000
     irq/24-mmc2-96      [000] .....     8.164840: sdhci_thread_irq:
msg=
     irq/24-mmc2-96      [000] d.h2.     8.164896: sdhci_cmd_irq:
hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x1
intmask_p=0x1
     irq/24-mmc2-96      [000] .....     8.285142: mmc_request_done:
mmc2: end struct mmc_request[000000000d30cc0c]: cmd_opcode=5
cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0 need_retune=0
hold_retune=1 retune_period=0

Here's what happens: the __mmc_start_request function is called with
opcode 5. Since the power to the Wi-Fi card, which resides on this SDIO
bus, is initially off after the reset, an interrupt SDHCI_INT_TIMEOUT is
triggered. Immediately after that, a second interrupt SDHCI_INT_RESPONSE
is triggered. Depending on the exact timing, these conditions can
trigger the following race problem:

1) The sdhci_cmd_irq top half handles the command as an error. It sets
   host->cmd to NULL and host->pending_reset to true.
2) The sdhci_thread_irq bottom half is scheduled next and executes faster
   than the second interrupt handler for SDHCI_INT_RESPONSE. It clears
   host->pending_reset before the SDHCI_INT_RESPONSE handler runs.
3) The pending interrupt SDHCI_INT_RESPONSE handler gets called, triggering
   a code path that prints: "mmc2: Got command interrupt 0x00000001 even
   though no command operation was in progress."

To solve this issue, we need to clear pending interrupts when resetting
host->pending_reset. This ensures that after sdhci_threaded_irq restores
interrupts, there are no pending stale interrupts.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b91c9e96635..b91a6076c332 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3098,6 +3098,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 		sdhci_reset_for(host, REQUEST_ERROR);
 
 		host->pending_reset = false;
+
+		/* Clear any pending interrupts after reset */
+		sdhci_writel(host, SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK,
+			     SDHCI_INT_STATUS);
 	}
 
 	/*
-- 
2.34.1

