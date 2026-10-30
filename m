Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370722;
	b=rNEoTih2ibtcRhyOAd0jpa5QU63GonkrQa7EjH6FcXVfK66vB6WQio63K0etUsxGS0gL
	 0DfXwnKbKs7FnsACpGuKcgtD3qZCCriulo/l4dC+ms2Af4KuCWzwq70pdtpqg7upFuVDW
	 1F0PCAr6yaj6z8RjnXEjO42ehvRUa0Kdkz83ZsjMZU7PmujMt+KXPXwsT9sRAUrwA3a0E
	 eCR6zBAXVhe1wRd4VOezZRec1qqT0ODybhaipQgHGF7pv4QWjDDMsEKA25HOqrd0TmMnF
	 ytX0kq8SHaY2Cqn4feFltyVDZWMPeMaMrirbTwgajvnAJdotmaiI+7X46oWkQqMK2EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=49Bl1zt6UwoVqWzxPK8W1b7lN0nB1VkYxdH3jRP5reI=;
	b=COVDRlEl6V9ToC+kdwdmjJHNPJ6RGAYBM/PL8lNlniYQ+XvUyEHRF2m3BqGLurqgKoNs
	 3DsAYQ5qkWx+NSztxQdjfN93/49g/OFrlnOpYlgPRGSTOkF2WNpbJSPZEPhRhwE47A4o+
	 cx4WeAhQz+RPoBCy2R+65kJItIfQdCCcp9IZbUEPyQkhRq0ioHcnem+C/0r1D2P4jj1u+
	 x2RNCQe6cVSp7fLpdZd87ODtNsb59ilgOopCd4T417NLeQRLF8XAaSHMmyZhogcsEO1xf
	 Uj+1FVs3NnfYuLWlodcJ5KllXEOTvXDRYdXhz+O0dfKofNJHAgoTxSQ2mM49idaW8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZRoYqVO;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FD606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 925FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GZRoYqVO
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a17a332ecso1454143eec.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370721; x=1793975521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49Bl1zt6UwoVqWzxPK8W1b7lN0nB1VkYxdH3jRP5reI=;
        b=GZRoYqVOzFQ9NKugWeeCfemabJywoYT1e4+ri71JacGwHc3z1S7aCKftP9etDPCRQ8
         +wHucdQGaXt8YvGFWcyUy4GPb1wia6wOtfPZkF2Yosk8Wco37sEfNQspU27j8c+m9Rv0
         hURd6+hSjjjwjKpUN4IPSBbtYuzwrIhbDfCj9PNO2R37a5f16NvC/+n5Gw9zaRLR5vyB
         729CnX5XFkEbJ2WlaRxWNhGhXA1O9JEvu9/tRGbsUIauhqROT+5BsXNBbz4d+7Sl1FY7
         lQGAbSPIXspb/EeYgu4rVco+KjZLQx5yIzQgCj+uo8ZFgdNuav6tktWtj4LhxtFJ/ijB
         ju8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370721; x=1793975521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49Bl1zt6UwoVqWzxPK8W1b7lN0nB1VkYxdH3jRP5reI=;
        b=okYj3BuuW1R0ZWO6qpwBj/QQ1ZNm2NKc61X8i3SgYbCzRewoxJZvVRAYQUy+0n7xzW
         83rnSz8nu5Ta6MJZw9Lvpt0ppjxS/ZzHg21KPEkl9mgAQXC0ofwNjhA0b2oiDFQXiBBI
         EbRII9u1GW54w5YXvvHRkDlSRLPHjVAxY10MKFdR0S7GD2AzBFtCcxjIYE3CtDNo7YyM
         2ZkwlCz2as4iDDRK3rWIhS5lwIzNZ2+7zbS8hx72S74gryioH1LiAKRQDr2lZXCPXG58
         7eIKSiUO1VkVExtTKGd/mBDZ5aVroHRxbojqexwEWomjKflyh4dxWGVbGIPbVPdqsu9/
         66jA==
X-Gm-Message-State: AFq9FYJikvNzvY2e3SHn3uIqRi2eagXsjYOiD9SzeQ7zWw6ojxn+rYsm
	DLYMW2tbY+p0TkSzabIYzGYDHnTyIuqiGP3AlFsmTjw/vuSmqPJhIktn
X-Gm-Gg: AYBFou04xIWcOBe9Oj12m5laVMgu7KhbngSDb4F+CgSZUj7FGPxs4dg1WcMudnOmXYC
	JDBNVnCmHjKmafyub7HWiKdGOCiCKoitbP5lf5uqIlTziNJIn7OigIR2iHoZyD7yB+8BtcRR4Zx
	YfQxYUOP6fFk3o/BSINhho5P9rIWgHQIxzdrC9EreaUzEEl+U/2ZIO9P16ErvRFeTYFSCC/0697
	5rCi5NA1uO48nbWU9/6LwA+bFd9C9iUByup0+Hdq0Si7YMsMv0T6b2AzSCMU47HwU55xgxkhUw3
	QiFwbjJTRSJ6RZC85yLEkGzJ1PzgmOzhquitidCVg/HdNrjb6bZdGlHQJWs/Og/BVZPtIWOYAKj
	W8oNwGWrfpomTr6kAGCZmzPGKgwZQp06L+fIrpBgtcwcYO30AKp6CR5HLxfiFsCTBJRuafTnVH+
	9Ttw6cPRGf+MWpQVaShPmXhvDPcPxsulZCtCv96aNUUVw3+eqEt7VN4dDm61HZ/BDLKeo+6iR+e
	UQUOBRwhZuUbonKTV1HtDmKvv3jXVf/jyrJyeWp3sPFMJu0QmpWsOMjBxvgzt8bvi2Snm9DGwpt
	sE9SF+9TSibF91S/JzW7gCL8+mJNoKkuFVxcsN22VrDDeEsj1SDsuLJEXB9eKq3rZxN0u7bCDBG
	tcus0SfNtkx7ecz3zadqFyVXq781C4pqoaRRgdK+/vM7Kn5r1rCzsTYSUlPWGodOHcDVerUON+1
	Tzi9FYow==
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id 5a478bee46e88-36a42431768mr5397671eec.28.1793370720407;
        Fri, 30 Oct 2026 07:32:00 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm9438146eec.26.2026.10.30.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:31:58 -0700 (PDT)
From: Codex <samarth.colleges@gmail.com>
X-Google-Original-From: Codex <codex@local.invalid>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH] mmc: sh_mmcif: unmap DMA buffers only after the transfer has stopped
Date: Fri, 30 Oct 2026 14:31:51 +0000
Message-Id: <20261030143151.2916788-1-codex@local.invalid>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samarth Narang <samarth.colleges@gmail.com>

When sh_mmcif_end_cmd() is woken by a data error interrupt or a DMA
timeout, the DMA descriptor may still be active. However, the function
unmaps data->sg before clearing BUF_ACC_DMAREN/DMAWEN and calling
dmaengine_terminate_sync(), potentially releasing the mapping while the
controller is still accessing it.

Since data errors can be triggered by the card, a faulty or malicious
card may cause DMA accesses to continue after unmapping, potentially
affecting reused IOVA or SWIOTLB mappings or causing premature cache
maintenance on non-coherent systems.

Move the unmap after DMA termination so that the mapping remains valid
until the transfer has either completed normally or been terminated
synchronously.

Fixes: eae309836509 ("mmc: sh_mmcif: Terminate DMA transactions when detecting timeout or error")
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
This issue was identified through static analysis of DMA lifecycle
ordering and has not been validated on hardware.

Since the request pages are not released until mmc_request_done() is
called after DMA termination, direct-mapped pages remain owned by the
request. The potential exposure is therefore limited to the DMA mapping
layer, including IOVA or SWIOTLB slot reuse and premature cache
maintenance on non-coherent systems.

The fix also relies on dmaengine_terminate_sync() stopping the channel
correctly on both MMCIF DMA providers. However, shdma clears CHCR.DE
without confirming that the channel has stopped, while rcar-dmac polls
the bit for approximately 1 ms but only logs a timeout if it remains
set.

 drivers/mmc/host/sh_mmcif.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8bd9cdeda..7b33f832b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1173,15 +1173,6 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 	time = wait_for_completion_interruptible_timeout(&host->dma_complete,
 							 host->timeout);
 
-	if (data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_FROM_DEVICE);
-	else
-		dma_unmap_sg(host->chan_tx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_TO_DEVICE);
-
 	if (host->sd_error) {
 		dev_err(host->mmc->parent,
 			"Error IRQ while waiting for DMA completion!\n");
@@ -1208,6 +1199,20 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 			dmaengine_terminate_sync(host->chan_tx);
 	}
 
+	/*
+	 * An error IRQ or a timeout wakes us up while the DMA transfer may
+	 * still be running: only unmap once it has completed or been
+	 * terminated above.
+	 */
+	if (data->flags & MMC_DATA_READ)
+		dma_unmap_sg(host->chan_rx->device->dev,
+			     data->sg, data->sg_len,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(host->chan_tx->device->dev,
+			     data->sg, data->sg_len,
+			     DMA_TO_DEVICE);
+
 	return false;
 }
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
