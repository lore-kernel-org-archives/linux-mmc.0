Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9718C93D
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381817; cv=none; b=XdIYK9Ffq9vdAP6AYOU/NdWdj+tWjgv3JSZwBx9VJxaKBZM6rvpjQ0QBC9nwXxiZqboRzdYsEmvfXtPiTI/QObeiXBJQVCaTwXtWvKwiZB5IMEymfKZwn0Tx/Q3SADexPAdsRwQObtRNalMOGBQMNB+OXDHd5QPoJg5BuPE5dP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381817; c=relaxed/simple;
	bh=xwI00hdaImyHQMmmLntgTWXN3z9EYeYZ4nzyQyVtZfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=VS/zLgcvZkxeWAKEg2lFwqyePl7UDnYQu6iHFjbpzVMx1hkU2QgWNfcTxDzIA20C+RJpIWh+suTRZ6+57v7QuIwJojmX4PPfis7Eprb53Ud4lXZeZX6GuwiDZURmQAwsj3Dx77M3M396oW+/h4G6k5ADXk8OUSL4cot5pp7RRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gJ4asCny; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gJ4asCny"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241008100332euoutp01c8fb494d4ca8a6153e7c904bd5a722f6~8chn6vWoJ0613606136euoutp01y
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 10:03:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241008100332euoutp01c8fb494d4ca8a6153e7c904bd5a722f6~8chn6vWoJ0613606136euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728381812;
	bh=Ah1poD1LaVugR6Rwd2dEgovTZI2JeFMt/pjyUWpvXUA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gJ4asCnybYZWZqc5KUfcyG7zkJpasEyLTY2Kd0cRm5JaQV0obJqBC4zCAOoPsTc8O
	 2BHAyLpx1B7HYbZLgwnQczLweberdp3poiTJGKILE64K4NAzehO6rhmL1Uw5U1GRmg
	 KaBrPPbjbntmcrOcv27mM9maQfO0F5CDS4n+KBpY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241008100332eucas1p1fcfadb4269b1ba6ec360e8e300b6a1f0~8chnnNokU2196321963eucas1p1t;
	Tue,  8 Oct 2024 10:03:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.10.09620.47305076; Tue,  8
	Oct 2024 11:03:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241008100332eucas1p12e84a156c835e719e6916331762c74b0~8chnUHZN01094710947eucas1p1L;
	Tue,  8 Oct 2024 10:03:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241008100332eusmtrp17385cae033f463cc86742e6f423b6838~8chnTfNQG2642126421eusmtrp1b;
	Tue,  8 Oct 2024 10:03:32 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-6e-67050374a83a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.9B.14621.47305076; Tue,  8
	Oct 2024 11:03:32 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241008100331eusmtip1ba8eac577bc7bc637f885d7c48411246~8chmuue2_0568605686eusmtip1C;
	Tue,  8 Oct 2024 10:03:31 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: Prevent stale command interrupt
 handling
Date: Tue,  8 Oct 2024 12:03:27 +0200
Message-Id: <20241008100327.4108895-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7olzKzpBg++ylqcfLKGzWLr71ns
	Fpd3zWGzOPK/n9Fi2+cWNou1R+6yW6z/Op/J4uXlHmaLtln8FsfXhjtwebx5+ZLF43DHF3aP
	xXteMnncubaHzWPzknqPvi2rGD0uNV9n9/i8SS6AI4rLJiU1J7MstUjfLoEr4/KpVUwF+3Uq
	mrb2sDUw7lTpYuTkkBAwkTh+6Tp7FyMXh5DACkaJHdvPskE4Xxgl7s9exgrhfGaUWHVnOjNM
	y5fzn5ghEssZJV7e3s8C4bxhlPh2/yAbSBWbgJHEg+XzwdpFBKYxSmyafwusilmgj1Fi0oyD
	jCBVwgKhEvsuvAbrYBFQlTh6YzILiM0rYC+xY/ITRoh98hL7D55lhogLSpyc+QSshhko3rx1
	NtgdEgInOCTads1lg2hwkXj3eQlUs7DEq+Nb2CFsGYnTk3tYIOx8iQdbP0E9VCOxs+c4lG0t
	cefcL6A5HEALNCXW79KHCDtKnN3+GiwsIcAnceOtIMQJfBKTtoGCBSTMK9HRJgRRrSYxtacX
	bum5FduYIGwPidNTZrOClAsJxEoc+807gVFhFpK/ZiH5axbCCQsYmVcxiqeWFuempxYb56WW
	6xUn5haX5qXrJefnbmIEpqjT/45/3cG44tVHvUOMTByMhxglOJiVRHgj1jCmC/GmJFZWpRbl
	xxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTAJtit//nOZr8OJuer+n7CY
	s4pLrnHOKl1zVF91+fqEfXk6ITZ+k2Z+fXlLpl21LjLl7LSA41LRxfbdrnWd4a7LfG63esdM
	Svk8wyYmml+l6If13/WXw2pZH2ZwRdb8OvYqeG7FU8mzGRd+BDX/TnhbEbZTIO3KyyAPuXUH
	dsxdLPnH+uN/r95VjZXWO9z7vP5Nqsy68syhsYWPWXhdypLlGcV3Z//t+ckYup6xVP9R1MKm
	6w8E9I/XaVvo6jKqTtlasKhNzp1vZbKdwNmSS/el9z6/7frr4/7SmGiriJu/E0vWnn3w0FG0
	kX+/qcyMk1pLny5uCzL1r1l2lv/olSc2CrfFNHXmGE6rVmx3ZlJiKc5INNRiLipOBABCBfbA
	wAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Xd0SZtZ0g4WTuCxOPlnDZrH19yx2
	i8u75rBZHPnfz2ix7XMLm8XaI3fZLdZ/nc9k8fJyD7NF2yx+i+Nrwx24PN68fMnicbjjC7vH
	4j0vmTzuXNvD5rF5Sb1H35ZVjB6Xmq+ze3zeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
	Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcfnUKqaC/ToVTVt72BoYd6p0MXJySAiYSHw5
	/4m5i5GLQ0hgKaPEvFMdbBAJGYlr3S9ZIGxhiT/Xutggil4xSjx8uR0swSZgJPFg+XxWkISI
	wBxGib2bnoKNYhaYwChx59UxVpAqYYFgicW/djKD2CwCqhJHb0wG6+YVsJfYMfkJI8QKeYn9
	B88yQ8QFJU7OfAJWwwwUb946m3kCI98sJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn
	525iBMbHtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8EWsY04V4UxIrq1KL8uOLSnNSiw8xmgLd
	N5FZSjQ5HxiheSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MDkz
	HKhfu/6v+z4m1hrVQ2sXuwhdj09ZPO1A6yQL4e6XjCo9lsF8Sv8uJrq/1t8euD1gsX7yni9O
	5Vt+1HwwKORac9bI/vCyExZlXX+TD20MC1qyRuz1KavAzGWNvPc4jWQD/i0vP73II8fK4cfZ
	XVFs63pi52Yo3G1TLWfUkSuM3vW1bzX7hH8WMb0rJlXd3GAUX6T8W7Zba/dHQWa3xywzjt5S
	e+phJv7+4OuID0LBs5POrHr2+0D3X3eXCTvKhFxDKq1fZPlv5dnncrOg6U2pxqXTRyUbo01t
	bGu0/9r+2frmS8Px829aJsXUXe40zA/w6ro1/2jWG5OG+4KbUldPzZq3Y9vP5J5Jt4KFK5RY
	ijMSDbWYi4oTAQQl7cIYAwAA
X-CMS-MailID: 20241008100332eucas1p12e84a156c835e719e6916331762c74b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008100332eucas1p12e84a156c835e719e6916331762c74b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008100332eucas1p12e84a156c835e719e6916331762c74b0
References: <CGME20241008100332eucas1p12e84a156c835e719e6916331762c74b0@eucas1p1.samsung.com>

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

The behavior observed here is non-compliant with the SDHCI standard.
Place the code in the sdhci-of-dwcmshc driver to account for a
hardware-specific quirk instead of the core SDHCI code.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
v2:
 - instead of modifying SDHCI core code, only modify th1520 specific
   reset

 drivers/mmc/host/sdhci-of-dwcmshc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8999b97263af..8fd80dac11bf 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -852,6 +852,14 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	sdhci_reset(host, mask);
 
+	/* The T-Head 1520 SoC does not comply with the SDHCI specification
+	 * regarding the "Software Reset for CMD line should clear 'Command
+	 * Complete' in the Normal Interrupt Status Register." Clear the bit
+	 * here to compensate for this quirk.
+	 */
+	if (mask & SDHCI_RESET_CMD)
+		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
+
 	if (priv->flags & FLAG_IO_FIXED_1V8) {
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl_2 & SDHCI_CTRL_VDD_180)) {
-- 
2.34.1

