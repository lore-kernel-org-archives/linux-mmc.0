Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF27476CD2
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478472; cv=none; b=P/z5vcXjMv7hCxJUnzyM6ob8+lONnDPOe9AGYLy00NUZ5FVtW7QlAWEPtxPZbt79kAfbrtGLgjjtCs0lhZ1DZqOZgc5+nhCYCjpWFCZbg4FBoSAhzP/jRAhvePJagqjLWzQdCRPlPqvcAsYpscX8WjEaMDTTC2slawS4i1KPNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478472; c=relaxed/simple;
	bh=5uxg7Tq62X7t4ONo1Iw+PVq8T9wcgeIrqkC2J/jYYlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWLWCbKfsxMODyylpFWXvmA9+P4OwONDC0L8DUxYx3rszo2iA2Vx2cRreyQTa65uATOWO1nkTsgIvOECRaw1Pi98qS/jJeq6YAFRNFRr3QITU7RwTH7yHE3UPh33XPXvTKKjFvVG6UeCfnYBsQdKu/BUM9uEHExXPEVRcOV2Dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nKy2/iNC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIhFC7IJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKy2/iNC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIhFC7IJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxwAg711917
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9lglF8Jy2Eg
	aqPwPCoZsJG+/E9siJbnm0STAQ8lMENc=; b=nKy2/iNCtyVNJTfFPp/v9rqUG7c
	USeoeGQqik+ltzttwSNI5Swk2T8aXhSUTe4UW+aOXlOUThgBnXbhLLSWk8IqIiCB
	vi7NrrrVgf53fQ4hUtA2FthOLJu6t6ciyELUtMZ1V9raOdaS0B2YUp/kpoXzXEbB
	qh8I6Cf0r1qXktxqrr2/zB0DlAE14NAeEyIFROBiG+ec7KfLePj+8VaiSgJuZDKo
	H083AnKrTyuHhAXg2ELGIV90vGMvhjqAeEFZvTMJfmdjVtgVqSIsptpml8Tia2jE
	nvv1zavYGj1v9YshMvu1TzPs8vbXJopBG54z7crOn79o8KwbI5bn3TqWwDg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyea2178-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:10 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-785827e6073so977745137.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478469; x=1790083269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lglF8Jy2EgaqPwPCoZsJG+/E9siJbnm0STAQ8lMENc=;
        b=YIhFC7IJZGbdcs+D1CTU3NavCDmbz6hsOnI+whBpqaY7vyal44LOzmRes08EyMLqLd
         b28IJGXMR4KvzshD4IhLRtBUyFO+JjCuS9ecWZxtsR/kmLOIpXENaA1HeGUz3z1gXqAz
         Hs4EEXCLMOm8w/lKU8do4kgN1KrMcJarZq+r6YlIxf49BpQ1o+Wy03G/E8tv8nNi6yTD
         esD/KXmR9eI7dr5fFpgz12FVcHMyd0Cto3KxfBN1ILq1T0KcH2Uupbs/mSIMUh1BCP0T
         hqu6Dbcra41X7d4YCU/mmjOFVKbslZrQRjEBNI37qc61wVzuomOpERSrOlZZYhIz8Oax
         T5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478469; x=1790083269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lglF8Jy2EgaqPwPCoZsJG+/E9siJbnm0STAQ8lMENc=;
        b=zdRW3M3UnEgUGi1TMoFx84Usu/2hPUz1xI1Q3lUha+Ms3cGZmDsd58W5c6cW+Ep6ke
         8VyM7pI27d7WEniLA5ssKntfmsUUJZBeip+/YnU3Th47Q1b636qK2WhuRYElt9SQEP/j
         h5vjY/hCnWOJrLUJDzUow8vmUuZ7xrkFgbL4pU6/7IZaU04MNzflc6tWoNNnYQ16ht7d
         ZR/dKWnL/+xDZ8cG/ekFpfHeMWak7w4S4Grvhn/45oBNFJ9RzJTcah5J3vJnmjVwnnut
         S7wzszP92PWJv+usiIwCqjGufKdiLnrLP6g9Q4AVHCzIIWN49X/Zcx0n+dbWHwMSbIbM
         Ocgg==
X-Gm-Message-State: AFuF++kgFipAR278ATtWBdxEWeEVhDYYHRnIchYbCkk/lVEjWl0hCRyf
	arRgJueAp7FEvLCHJcINxF14K4s0rPAKPU/n6d1jDvd1fUypnE3pMUsn6EQAIOrzZRax2uf5L+v
	150dTGqhsOHIF18gmv4sF1JSVWJmh8ddG/bJ/0hV1ug9QnT37MfWzDII2R2J95HgN0J+/Sg8=
X-Gm-Gg: AYBFou20YDhOoiZhJfHgmBZvXDbPdrMAxAyJX47gVRFQcmcNaitsSF/vhB/jJPVsGDD
	wT4VeyHM3AuONdGkH4ycU9OXrbkUuv+Vmdm3VYzRoIghw3jC4LYcbUXZ0+wd7YjeHocHk3+JnKf
	I0u9PKuogzjycWS9OZkfrhzFWwPzrC1nfLuE4SxvS/8DQEvI1BKpsgoMwG1NlHuJx6uo+QGdS/x
	kdMuTAEwz0MFT7b3EUmxCPjHGghoQ2+jgngAmR+UGrkQlDCyPI9++0UEi5sgfGfkm24TZ00nCOq
	3AhOSVDWv9kNNRIIUkTKRVfJl/DgmxM7n3MHcXSrwL/4DG/8IPtv+28v3FscVIfYoV3FP8EkwGi
	0mx9DacaeHOK+M15t+6IcTdKGXUPFRmOKAtk8SNDPM0itNrXPEyUvUb+5Bw==
X-Received: by 2002:a05:6102:510b:b0:778:5369:763d with SMTP id ada2fe7eead31-79b56aec243mr6728954137.1.1789478468760;
        Tue, 15 Sep 2026 06:21:08 -0700 (PDT)
X-Received: by 2002:a05:6102:510b:b0:778:5369:763d with SMTP id ada2fe7eead31-79b56aec243mr6728842137.1.1789478468218;
        Tue, 15 Sep 2026 06:21:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296613c3ebsm582885466b.57.2026.09.15.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:21:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static functions
Date: Tue, 15 Sep 2026 15:20:46 +0200
Message-ID: <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: A2sUV9QsuFVhN_qzbGvUVECKrqZTWauS
X-Authority-Analysis: v=2.4 cv=cehHPXDM c=1 sm=1 tr=0 ts=6aa94646 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=ZspSQYoVYSdymiOi6Z0A:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: A2sUV9QsuFVhN_qzbGvUVECKrqZTWauS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfXx3wdoKVadChx
 JBfFZp097UhgXfwoqBr2KC43C5BzDwX32FJx6v9BooWE3HYbfAYXdhxn+SQGWbJ8gYLkn8njNFx
 hHDBQlqYAR5VEqbwhKggEYJv0OMcFqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX79mfzI398USB
 aDXPpDnWhY0lLryLAvNxA2xSXgKGcQToeOLHBAhRQU7eT/truuCWhS9MylENbkHbdFXQ/wcQw3g
 fprFkVCVKyhmV3dSquqcM760mKky+WtedIvVhg2HO1Htn4DCU4A2pgqYhYLXzkTUjkGc8IJ/P6p
 oGSKNKaXCr1Fq/rNgn04mShjRRJvo7W0TtO3YdjqQlOEEjvbXCHqj0asPkXC/wdeRxU2XtZnqbt
 VeVHzExFGVq1V6xkTKCaYLBIpwgn0DoCHiFcQjTaZtF7Hb1CWr6uFC2qsKVS7gF2E/0qjUX3nNg
 g6157T4cHX9ZA882EfksxUawpLmHeqzH1JunKzVPY5u6YgEurJlKQjE7NoU8zWWsGspDFTkt9kQ
 e2etfNdcaJBYcIKNu7S7EC/Si/RL7RzjN3PW0OWePn68Ye+Lj4kKNEy258mR2sD3qZsECPKFv1k
 GCdRs3cpYOMey7hi8bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150194

From: Ulf Hansson <ulfh@kernel.org>

As there are no longer any users of these functions, let's make them
internal to the mmc core. While at it, let's also flip the order of the
in-parameters to mmc_alloc_host() to be consistent with devm_alloc_host().

Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/mmc/core/host.c  | 35 +++++++++--------------------------
 include/linux/mmc/host.h |  2 --
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1bcf0e917b59..8e9e61839198 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -505,14 +505,7 @@ static int mmc_first_nonreserved_index(void)
 	return max + 1;
 }
 
-/**
- *	mmc_alloc_host - initialise the per-host structure.
- *	@extra: sizeof private data structure
- *	@dev: pointer to host device model structure
- *
- *	Initialise the per-host structure.
- */
-struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
+static struct mmc_host *mmc_alloc_host(struct device *dev, int extra)
 {
 	int index;
 	struct mmc_host *host;
@@ -583,7 +576,13 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	return host;
 }
 
-EXPORT_SYMBOL(mmc_alloc_host);
+static void mmc_free_host(struct mmc_host *host)
+{
+	cancel_delayed_work_sync(&host->detect);
+	cancel_work_sync(&host->sdio_irq_work);
+	mmc_pwrseq_free(host);
+	put_device(&host->class_dev);
+}
 
 static void devm_mmc_host_release(struct device *dev, void *res)
 {
@@ -598,7 +597,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
 	if (!dr)
 		return NULL;
 
-	host = mmc_alloc_host(extra, dev);
+	host = mmc_alloc_host(dev, extra);
 	if (!host) {
 		devres_free(dr);
 		return NULL;
@@ -692,19 +691,3 @@ void mmc_remove_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
-
-/**
- *	mmc_free_host - free the host structure
- *	@host: mmc host
- *
- *	Free the host once all references to it have been dropped.
- */
-void mmc_free_host(struct mmc_host *host)
-{
-	cancel_delayed_work_sync(&host->detect);
-	cancel_work_sync(&host->sdio_irq_work);
-	mmc_pwrseq_free(host);
-	put_device(&host->class_dev);
-}
-
-EXPORT_SYMBOL(mmc_free_host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ddb32bc2946f..198554e48346 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -585,11 +585,9 @@ struct mmc_host {
 
 struct device_node;
 
-struct mmc_host *mmc_alloc_host(int extra, struct device *);
 struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
-void mmc_free_host(struct mmc_host *);
 void mmc_of_parse_clk_phase(struct device *dev,
 			    struct mmc_clk_phase_map *map);
 int mmc_of_parse(struct mmc_host *host);
-- 
2.43.0

