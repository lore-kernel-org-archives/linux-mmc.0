Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAEC2F50
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730870049; cv=none; b=K9cKr+XjG4xnJcvL3UJHQciVanfyW1Hsw1SJ529c50lSrX9ttWg/wXwGa/9oNHQt4Uu4VHNbsduedZmiidvykjrsoMaAQDB/WlxsvDI21lDh73Fr8IFdCpcW7CKQ60Z+/AAui+pUqrUWvL8CUNiybN6wf5XDYOvop/vJm3ma4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730870049; c=relaxed/simple;
	bh=aE25BL1cEVdJ/xrO/l8Vi+xw/a59c2RCUokodWb8jWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=fq5djljAc04iSKQnUS2nyVxCtXSgx6iKBS8F/cCxIpd2td8ltatDiKknaV7NHrRKN6vXttu3X+GWimtWojl2c7+odK4FJqlDJC2sKFyWf4u/mkRloz7izlOwS4RCjrmJUbXVWHOIeIIOUNPA+2E51+zumYsje79FExznyGo6+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RXlLG3zC; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RXlLG3zC"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241106051404epoutp030dbcc7dc55a3d93bab0ae7e686e18912~FSSKLAC3i2629326293epoutp03G
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 05:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241106051404epoutp030dbcc7dc55a3d93bab0ae7e686e18912~FSSKLAC3i2629326293epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730870044;
	bh=l+DDy/a8OyhCLxWs1meB0CR9Rl2VqxIJR9slE55Sil0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RXlLG3zCnxvtmQ4TeVoUcu5G8M10AV7d3Q63mSwEbqIyRXYwHizp7hzQ1Onn5CiAQ
	 emg6v2rmUgIyMPrsySp8JKcCgTvFhFuphYOjm1jARl5bF6J1sUMv6ZRkzP8UmJ/qsN
	 kqkREATjYxLy5GN9biEXR2+iw7PHcFOHb1xg3xuE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241106051403epcas1p30b1badc9335efdfb046c4789c805becf~FSSJsr_lz1747717477epcas1p3D;
	Wed,  6 Nov 2024 05:14:03 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.240]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XjtfM4ByXz4x9Px; Wed,  6 Nov
	2024 05:14:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.AE.08588.B1BFA276; Wed,  6 Nov 2024 14:14:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c~FSSJCawfE1453414534epcas1p24;
	Wed,  6 Nov 2024 05:14:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241106051403epsmtrp12a3a25c075d73cef2d6ce5df51b2a8a9~FSSJBiW1T2460624606epsmtrp14;
	Wed,  6 Nov 2024 05:14:03 +0000 (GMT)
X-AuditID: b6c32a33-a57ff7000000218c-5a-672afb1bccec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.B2.08227.B1BFA276; Wed,  6 Nov 2024 14:14:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.100]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241106051403epsmtip1f7a0b4aec8ee6bddcb766cee41d2b76e~FSSI3_0Cp0263202632epsmtip1V;
	Wed,  6 Nov 2024 05:14:03 +0000 (GMT)
From: Jangsub Yi <jangsub.yi@samsung.com>
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: junwoo80.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com,
	"jangsub.yi" <jangsub.yi@samsung.com>
Subject: [PATCH] mmc: Add config_host callback to set a mmc queue
Date: Wed,  6 Nov 2024 14:13:47 +0900
Message-ID: <20241106051347.969-1-jangsub.yi@samsung.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmvq70b610g47JChYdWyczWez628xk
	cXnXHDaLI//7GS2unTnBanF8bbjF5kvfWBzYPe5c28Pm0bdlFaPH501yAcxR2TYZqYkpqUUK
	qXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QLuVFMoSc0qBQgGJxcVK
	+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ/ZteshRME6h4
	/m8jcwPjSt4uRg4OCQETiU9PWLoYOTmEBHYwSszsKOti5AKyPzFK3O9pYYFwvjFKrF7xhBmk
	CqRhU+M6dojEXkaJTc/nQzmfGSWuP25jAqliE9CUeLv+KTvIChGBUIkDHcEgYWaBEomJx1vA
	SoQFHCV+3+9gA7FZBFQlHs5eywhi8wpYSpxf+oUNYpm8xPk3/9kg4oISJ2dCnMoMFG/eOpsZ
	ZK+EwCF2iTM7bzFBvOMi0XTaBqJXWOLV8S3sELaUxMv+Nii7WOLAs0csEHaNxI6Gr0wQtr1E
	c2szG8gYZqDz1+/Sh1jFJ/Huaw8rxHReiY42IQhTRWJrnxrM8I17pkFDx0Ni6rkr7JDwjJU4
	fWMX0wRGuVlI7p+F5P5ZCLsWMDKvYhRLLSjOTU9NNiwwhEdicn7uJkZwctMy3sF4ef4/vUOM
	TByMhxglOJiVRHjnpaqnC/GmJFZWpRblxxeV5qQWH2I0BYboRGYp0eR8YHrNK4k3NLE0MDEz
	MrEwtjQ2UxLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qBqW8u95UzZ3IWv5/KuGRueKuFQaV5
	fteEWL9gccXN+2suxU7pOd1ZbJ+wc8fM6sNz9Sb2lhztEpdN9G7RUHcrXuOYJffweYBM04+l
	7Gl+u5iPOZ/mU3Y4F1lbXeUgy3S1w/509pqfrL/PhjxqOvY488ay/epnLkd4hf5WPmn/9X2K
	P3fnlv612Tl/VsvVT2yaELKw48n/7DeBodo6TxQP/7wvUvihMWL/4WrO8ILFD7VMUxgE9N/b
	ftEQX3Xs9CybhG+le8z9C3P9tgt+O6sXzKrR+fvAT7WTt61W7l2gn6n9xNHqZ8KtSq+w0G6G
	npnK98yi34T+Wm7zLdatctnZ1vWv7j64H7Kg9/St1+ElSizFGYmGWsxFxYkASSqwa/cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSnK70b610gz/HeSw6tk5mstj1t5nJ
	4vKuOWwWR/73M1pcO3OC1eL42nCLzZe+sTiwe9y5tofNo2/LKkaPz5vkApijuGxSUnMyy1KL
	9O0SuDL6N71kKZgmUPH830bmBsaVvF2MnBwSAiYSmxrXsXcxcnEICexmlNh36jqQwwGUkJL4
	8CkFwhSWOHy4GKLkI6PE/xPfmUB62QQ0Jd6uf8oOYosIhEvsejsFLM4sUCFx8f56VhBbWMBR
	4vf9DjYQm0VAVeLh7LWMIDavgKXE+aVf2CBukJc4/+Y/G0RcUOLkzCcsEHPkJZq3zmaewMg3
	C0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwcGopbWDcc+qD3qHGJk4
	GA8xSnAwK4nwzktVTxfiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFM
	lomDU6qBqfz6EnlD241rFaY3T6uz8vjVVtUmNe9w3ORu/g83XlRtK16zb9H9TY3T5d7U/I4O
	3xJ4J3CLefu7mOevZOfIOp77ZrVy3UW7OyZ38i71pK2pnxCZrW1bWb/uhcq35zNj7/759CNV
	conqwt+rOR/JiTxTD9W7Vm9w1/+u9OycBytXvE7d9uf9/IyIMtVV7PP1T8jOaX4v6JB7YmPj
	9ATF0sjWJTtq7p7S3rc36WjRqqeHjiiZ/H0WqHn2c4KUzn6maSlZ7+P+a6kZLmVJ8VzOl+P7
	wNPF7kl1Z6L2ofORzJ3fvpe+3tp3S/BTr9PGUPvdH/6tN+vt3Ph87bakJTXaDtNie698W3t/
	Yk/vP6fuCzeVWIozEg21mIuKEwHyenM2tQIAAA==
X-CMS-MailID: 20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>

From: "jangsub.yi" <jangsub.yi@samsung.com>

Currently, there is no way to set up a host-dependent MMC queue.
In UFS driver, it is possible to configure the request queue in
ufshcd_slave_configure.

There are cases where we need to configure and check the current
state of the request queue on the host operation. For example,
mmc_queue->in_recovery, in_flight, mmc_queue->queue->queue_flag, etc.

Additionally, since the timeout setting may be longer depending
on the device, block layer settings such as timeout are also required.

To add the configuration for the MMC queue, I will add the corresponding
code and initially try to add it during initialization in block.c.
The detailed implementation will be done on the host side.

Signed-off-by: jangsub.yi <jangsub.yi@samsung.com>
---
 drivers/mmc/core/block.c | 3 +++
 include/linux/mmc/host.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ef06a4d5d65b..d292f93ca732 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3261,6 +3261,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 		goto out_free;
 	}
 
+	if (card->host->ops->config_host)
+		card->host->ops->config_host(card, &md->queue);
+
 	ret = mmc_blk_alloc_parts(card, md);
 	if (ret)
 		goto out;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fc2b328ec4d..81e21553030b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -113,6 +113,8 @@ enum mmc_err_stat {
 	MMC_ERR_MAX,
 };
 
+struct mmc_queue;
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -219,6 +221,9 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/* Configure block layer setting related on MMC queue */
+	void	(*config_host)(struct mmc_card *card, struct mmc_queue *mq);
 };
 
 struct mmc_cqe_ops {
-- 
2.17.1

