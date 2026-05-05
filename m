Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFA401A30
	for <linux-mmc@vger.kernel.org>; Tue,  5 May 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977576; cv=none; b=ap6ETtBBrPZy80+4AtdXrO4l+HyfiduITtPwf6E0uLx9iDhouEZBwCy3NaN48ru6H15IqTSrzAVR4WEy3mrRAa83adWBy0c9vOlzkbOTCvgYcf6ebvoj3JY/nWMA4v4JA53+PN36iXxoC6sOg6mfHhYGel9VIoAQPU9lNety4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977576; c=relaxed/simple;
	bh=VuGo2ndSqgWzrRoZd62e7wQE8h6ueHHrBArG5tRqxbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl5evmCOetRwMtHJxDu8pMW/yKk7oegLxfZ1Y4uaOqVksmGYf3dVDLLyCRPFYcX8avSwibaU6B641uyzIe8hVBPTqZfrW6syuMWlyWSDuO2QjmKX7zJ9MpoJKPRxKuFif393XE8vAQsBWrZa3l70ydKqBuv1uGITMnXRxWlGfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=leZRNxHc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IOlYAHr3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="leZRNxHc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IOlYAHr3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64586UFR1187051
	for <linux-mmc@vger.kernel.org>; Tue, 5 May 2026 10:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PtzKaI0DPR/0j4wYmv/ljDtexJO8QoAxWX9
	jmN3KXuw=; b=leZRNxHc0WxVvXhgEhHSbNvh46+DLY3qY0q98W2YD3XCuKvSSkI
	KUfx2ZsF17uOyF6P0C1lU4NtURzr+T4e6RsNn6NfE6yEdfP/IlbBXLacDnXIPhHJ
	iRJ3GD6vtxND9Uv6kRrkoVTiKm42i664iEaWHrBOLl5lmMYU2Pyhfft2hyL43Qxm
	5cV33h6Cc9u+nGf4myOjXUDBnFM/58nqy5PrGYTz2lyAsMOOk4bVAcWmruCp+w3J
	ebVxYWGHksd1IA7EAUdY4LRTn3OEkbyA+b0VsOOQm8zq+GKtYXUHcrJ8ehomogU8
	TLA7+wu+ydd4EIljqlubkLF/UQ3frUTCg5w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvgbxj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 10:39:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50ff0bef198so130274161cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777977573; x=1778582373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtzKaI0DPR/0j4wYmv/ljDtexJO8QoAxWX9jmN3KXuw=;
        b=IOlYAHr3TAW24zoy9/p13daS8I8aggMl8pbPP7FTwVzcFDdSHwfRaaUchiUJ6FSFVO
         A5isTYYuXuQRjM7jfe8pNtrxMSbU5ud56696ZuHZMuRx7ZgXxR+Tow3YtzAsAHFD/tM5
         Sl7uW65dzIWKQrJ097ax/QWuGkXCg3qx+Kpe2BsqkaLrjodn7IxCzW9Y6Y+UTV58rHzl
         4RSfDc/zqjAJHWpdA02LnToVnUVRoxSLlp04BClr3wSFLLkkQnQ3LY9jFXyeX8/KTx5e
         1occYflaC8UbQgmzmyEqNrrpBUi3DQ/0mikeDgekI+2ss8qfj61fKpuwJY9CYx5m1joj
         MGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977573; x=1778582373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtzKaI0DPR/0j4wYmv/ljDtexJO8QoAxWX9jmN3KXuw=;
        b=B+CQ2EZegOTi+T4bIN0TYLcakwVJmE7PycEUFkw1ACj8l2UUtPwI4rn6F6Qs/xvENm
         O+QYKF8KWJHS3nQSIRJ4EBtjt04Ou61r5Z1xjQKnkkQk1C/2kh0Fx30YOz7OzkhLtAN8
         hMCKbOasAWEli+QP55kQ9EIF69gYy1Wiu1BlM+Uxo/a4YIyoMtkBM2DkurJFR44IxnIu
         qe2yjybXoL5c92ZGr16UMH4Y3+voNPxIeBM9FVo8cHZgc8ywirB7mDvY+fAlYR3xjKXu
         pCJKGYhtuBzGCb5S4T4ufD+wf+IGku/OP/7ZGGA/yGuQ5J5oA3v1SQ3fYk6epGsNC8Qe
         feAw==
X-Forwarded-Encrypted: i=1; AFNElJ9YZuQ4R9g+ck5c6gef1X1tr0TLRbLaBsbROdIHq8FviOK02bHZtQjdvdRFPxe+KEnzGpLLEzyVD6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOeCHN6Yd7G3e/nT405di0YxfgkMT2gyR1PxEugJVjlg7dPg+
	qiZhF1wIeZMvelZ0IycyuXaDaE5j3+NmHo6R8uHuGLX/BK0T0ldLKFbqwdeaSZ6t7wTIZlkXPb7
	o6Pl11vBH3dgl2vKdFkCokFU+UHGHzYkKr817fxaJ5du6YLWO6TazrcYyIYtFJ5yUZztTx/k=
X-Gm-Gg: AeBDieuzIZNi7I0hJiz5gy/RKKllh9mJnnAAhYbkmHJQuNQPuvnx1cZ0Lo8VNvOKTrK
	UuNco/F5hm3D+l/oiPimSWX17KTlj1SJrKbvJOglz9unIyr5k/8pfHCWs1QJHnIICtbLzY9CR3V
	GGUc4HIQRPhzYmzqPRmcAiMdoaSaxP6OmuHad3u7pl3RMx5vHmEjrq1Nk37nme2xsTFm3V+4nP0
	u14ccc+5Alh6YsenleJ2QGctveBGheVeIHy4V3StJ0WXbezdnXq1F0dqk5HDeoyfJ4zIJ9F6ASY
	z5AzqghCe8M42erkhp32Y8URuSsCokrfcu7Sfas8WY86j44FUfceYYwLg0qwGrdAyojbrYUWr7i
	gLsfDuNy3nrDM8KmWRr7kIAmda1FYYgp2vua67Z9wo6a9+nY=
X-Received: by 2002:a05:622a:5485:b0:50f:be4f:465e with SMTP id d75a77b69052e-5104c014372mr198585531cf.53.1777977573015;
        Tue, 05 May 2026 03:39:33 -0700 (PDT)
X-Received: by 2002:a05:622a:5485:b0:50f:be4f:465e with SMTP id d75a77b69052e-5104c014372mr198585201cf.53.1777977572361;
        Tue, 05 May 2026 03:39:32 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba6f83sm329691645e9.9.2026.05.05.03.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:39:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Alex Dubov <oakad@yahoo.com>, Maxim Levitsky <maximlevitsky@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] memstick: Constify the driver id_table
Date: Tue,  5 May 2026 12:39:28 +0200
Message-ID: <20260505103927.234104-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=VuGo2ndSqgWzrRoZd62e7wQE8h6ueHHrBArG5tRqxbc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp+cjfFadERDwDpTo9fI8/Dr/p5ZWp0RqoxFmXN
 HE/d2ajc52JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafnI3wAKCRDBN2bmhouD
 1yNRD/9mQQ56I1R8rTOC4E69IHoq4mSTbQA2S9Upz5cjO4Np01xNG4IAby9jKBi1HSOl0O33nGY
 kJ8VyZwCYE7ktbTiNUDMG02QMqex3XqHQS87xn4nthVQYLSOUo8rXYnsAt+822WRdGu4ZRSIgk5
 k7bonF4I6huaoVrbkddWuvRuqT3xm9Z/FKh2avpuPqrQH+dua3qmwgv2nOHM5FF+RBmLx/lZ66q
 gvfNNWO48zmgxoBTKfBmGhyN71zUI0/aLoLcOnQp7ArB0oiMeXwULzyroiVF/G03JLIzcrgzmO4
 O4fzIcqGTJfufz9u00Dv0fuoUHV4RKIxuY8dRCE3kXsBxXucS1qe/8aVxCaRLMQfswiaZqrIjSf
 NA9/+NEZOp+T/9V4FvlrWNLYKRvyHjGs+gjTLTDqfkOWEahPpAIiiub7wuAm4MnCZRgX0WkJ24A
 ct0R+5/hWWW2RcPyBslO5qFgbvKfpZcAP3TTismjX2ntqZceITrh10Q4T2xP9QZzmpO/bk+mq80
 tcEWfRrTE7MyABGVaGT7fzC8SmMfK8HB4Bx/g4aOKj9AHH9hSIiBV7HPx4SY4tv2iuXnc10ON7e
 SloOi8/7hzAaRES8OShHl2phhyMIlUkbHmzNUgb0jgHuDy/Q6z1G64NgD2dYXNif5CNUXncAjr3 Owfhyp7MvyqQEHQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 13ZpsyYu-eyBLCIAsPimhxt2oomGPrs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5OCBTYWx0ZWRfX/Y7g/oyMrQmi
 nJFx2zjDBxP3zNtAQ5qEEGFMeLsQGeWQMYQIuf6a7X3+ROU9tn8i+wmT21npFPn9IoxqPJw3+p5
 FiLiEM/2viBSX65q5Yrl4Fq2DECUsttMKM4Uxo4A29Y3l8MnZ6r8Wzy5jQabXhebM1bwSZNDKqz
 tPCiEluoJ+zrkowu9RRI8MYOSkVtMCt4YAqWAOL1643ocTgkXkKebvQpIFGiaPFnzENRXP1FLZ2
 +4QwH1byvmDKfx6lDs26aqivTD2t8w09x3QUFe9vzNf/EoXPVDqL1dHtqRYLrd3bwozOx8BajUC
 iRPBBZiN7F7Vow7ceQMDP4akeoA9nP6Y/zTc9Yt/Q2IFvTBF9VfHklnYQk6b/9lzLT3juY+ZA3M
 3xkDNrxXd7NBgy6B9srbbpOc8i7JQh+iZmc+sE2TFRYFCbYZmx8MWMV623GsWLy4uSg72XltjyA
 LoM7Js9RscYY6d+Joog==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f9c8e6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UX9wxLNV5ftjljSlYSgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 13ZpsyYu-eyBLCIAsPimhxt2oomGPrs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050098

Just like all other driver structures, the id_table should never be
modified by core subsystem parts.  Constify this member and actual data
structures for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

This should probably go via memstick tree with mmc ack. Or other way
around.
---
 drivers/memstick/host/tifm_ms.c | 2 +-
 drivers/misc/tifm_core.c        | 4 ++--
 drivers/mmc/host/tifm_sd.c      | 2 +-
 include/linux/tifm.h            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 0b6a90661eee..0a54586aa54e 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -647,7 +647,7 @@ static int tifm_ms_resume(struct tifm_dev *sock)
 
 #endif /* CONFIG_PM */
 
-static struct tifm_device_id tifm_ms_id_tbl[] = {
+static const struct tifm_device_id tifm_ms_id_tbl[] = {
 	{ TIFM_TYPE_MS }, { 0 }
 };
 
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index da0827724a61..aac8f0933e43 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -31,7 +31,7 @@ static const char *tifm_media_type_name(unsigned char type, unsigned char nt)
 	return card_type_name[nt][type - 1];
 }
 
-static int tifm_dev_match(struct tifm_dev *sock, struct tifm_device_id *id)
+static int tifm_dev_match(struct tifm_dev *sock, const struct tifm_device_id *id)
 {
 	if (sock->type == id->type)
 		return 1;
@@ -43,7 +43,7 @@ static int tifm_bus_match(struct device *dev, const struct device_driver *drv)
 	struct tifm_dev *sock = container_of(dev, struct tifm_dev, dev);
 	const struct tifm_driver *fm_drv = container_of_const(drv, struct tifm_driver,
 							      driver);
-	struct tifm_device_id *ids = fm_drv->id_table;
+	const struct tifm_device_id *ids = fm_drv->id_table;
 
 	if (ids) {
 		while (ids->type) {
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index aebffd3ebf60..28ab2526dab1 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -1041,7 +1041,7 @@ static int tifm_sd_resume(struct tifm_dev *sock)
 
 #endif /* CONFIG_PM */
 
-static struct tifm_device_id tifm_sd_id_tbl[] = {
+static const struct tifm_device_id tifm_sd_id_tbl[] = {
 	{ TIFM_TYPE_SD }, { }
 };
 MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
diff --git a/include/linux/tifm.h b/include/linux/tifm.h
index 44073d06710f..752fcfae27fe 100644
--- a/include/linux/tifm.h
+++ b/include/linux/tifm.h
@@ -97,7 +97,7 @@ struct tifm_dev {
 };
 
 struct tifm_driver {
-	struct tifm_device_id *id_table;
+	const struct tifm_device_id *id_table;
 	int                   (*probe)(struct tifm_dev *dev);
 	void                  (*remove)(struct tifm_dev *dev);
 	int                   (*suspend)(struct tifm_dev *dev,
-- 
2.51.0

