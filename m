Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB12DE709;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608740; cv=none; b=Sv+EjVDaPf+ZEpV1hmBkcRkwS9yWfNmROaZetKe/ypJ4u6GCWW7gUVTqnnurZA9isuXswNCIQW5kTfcCNaUKiwYWFguAALDBxWEo4L1viovlOFN9VedtQK8JYGPTpmW0DpWh7whS4I9Ry6/9W1KHAQDqiFWNrRduLL27TmrFUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608740; c=relaxed/simple;
	bh=ZeJGcKziTRNQaiJ+0pmwZ9/PxjWtaz7N3vEC0qiM/YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQKnDyd5JYV2cgmzhl/rLa7AlE77Gyagnz75eRxMziKq7Hyd2ysbytxjNxKrtUx40vr2ylwvMjhwrILOtVKIidnmqAgbTP+UTjo/S2eUeCkiz+7N/Zcf+qb7XZ89O0/74nVBzEyqPUooy4j31pgQdyPkQJKLE4GdLtIj5854GLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY1UftBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY1UftBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA0BC2BC9E;
	Fri, 27 Mar 2026 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608740;
	bh=ZeJGcKziTRNQaiJ+0pmwZ9/PxjWtaz7N3vEC0qiM/YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VY1UftBfEVWSDUl6jmhrn03RXYv8oCJIiYp70LUqTGi91DNn5iGnaOOHOeIwmOD7x
	 pYUYNWBTTewj8A2WvJPubIBfnvCUtiiiM/hzBvUuEfDf/lBL1v5ocqd+2Z2sV0PAoC
	 HTb/bpQ3rVKBjIVXQX2Ya48YkLbMIQaKTSFNaRUrBiAK1RQ/4VFOKYG3i78tEDh8GY
	 S8Zsds8nmzQqiFDRaGW/OsBENOlF8QTA9l9kuRnX91ZquIxDtmUEHICjWe+fDTAHkV
	 oq0OPX8opdXEk3vGev9n3QQCTlTqP5yfyl2+MUALHuTwIZSIL5LTYpgMb+Z1tPnRmd
	 6W+wgofos7odQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64na-00000005Uza-1BHd;
	Fri, 27 Mar 2026 11:52:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] mmc: vub300: clean up module init
Date: Fri, 27 Mar 2026 11:52:08 +0100
Message-ID: <20260327105208.1310739-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327105208.1310739-1-johan@kernel.org>
References: <20260327105208.1310739-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up module init by dropping redundant error messages (e.g.
allocation and USB driver registration failure will already have been
logged) and naming error labels after what they do.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/vub300.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 3057a69ff8c4..6c3cb2f1c9d3 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2429,37 +2429,36 @@ static int __init vub300_init(void)
 
 	pr_info("VUB300 Driver rom wait states = %02X irqpoll timeout = %04X",
 		firmware_rom_wait_states, 0x0FFFF & firmware_irqpoll_timeout);
+
 	cmndworkqueue = create_singlethread_workqueue("kvub300c");
-	if (!cmndworkqueue) {
-		pr_err("not enough memory for the REQUEST workqueue");
-		result = -ENOMEM;
-		goto out1;
-	}
+	if (!cmndworkqueue)
+		return -ENOMEM;
+
 	pollworkqueue = create_singlethread_workqueue("kvub300p");
 	if (!pollworkqueue) {
-		pr_err("not enough memory for the IRQPOLL workqueue");
 		result = -ENOMEM;
-		goto out2;
+		goto err_destroy_cmdwq;
 	}
+
 	deadworkqueue = create_singlethread_workqueue("kvub300d");
 	if (!deadworkqueue) {
-		pr_err("not enough memory for the EXPIRED workqueue");
 		result = -ENOMEM;
-		goto out3;
+		goto err_destroy_pollwq;
 	}
+
 	result = usb_register(&vub300_driver);
-	if (result) {
-		pr_err("usb_register failed. Error number %d", result);
-		goto out4;
-	}
+	if (result)
+		goto err_destroy_deadwq;
+
 	return 0;
-out4:
+
+err_destroy_deadwq:
 	destroy_workqueue(deadworkqueue);
-out3:
+err_destroy_pollwq:
 	destroy_workqueue(pollworkqueue);
-out2:
+err_destroy_cmdwq:
 	destroy_workqueue(cmndworkqueue);
-out1:
+
 	return result;
 }
 
-- 
2.52.0

