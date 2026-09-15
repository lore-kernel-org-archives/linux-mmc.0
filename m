Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D043787A
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478469; cv=none; b=a0WgjswcHGbrxE+wWqCdhs4LxY8rrJTL4r5qSp0UhPsK5qdpbJVjVURvQ1J30o+jrhJJPqh5lJ1JIscQ2CyLSd9ItJjBPn+fQsTyqhktMMIIr1IQpzFAjE7f63kTUPDbdEAuyRTs2OrYtmfN4QY4rO7otb6mQ1WIrW2hahVHprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478469; c=relaxed/simple;
	bh=J5cjlmIhmApL5oXstbrQjH8uBAQgeiyQrYDR6jGDqxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3rm2fJOSCAhhzMHdMHcKBE6geWZmAa4O7S+t9ZBbvZtCSptzFAHTChN9owMINIOO1rz0BxeJkTRlobgloj76YeqbXA+OuPijPhWbIop+aQkwuMcPxh2y/O7+612EbZLNl1mwdX326i93onlF+QirT6bTAJm4JIv+pw71N6xNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fao+moKf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iu6vcXiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fao+moKf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iu6vcXiS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxwSF711923
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZL7N2UR4Bwh
	9Qvv6N097nupKNcXd85noQladH64uxlM=; b=Fao+moKfW3O46B4McB+4zoF61OL
	R9QdINz75MusYRMX0l7rdDHxYZNc3qajoXMp83COPhR9ZY3yD3K1ebpaw+kvF+Qq
	AxXG4NgQVPd/gHGtAVtShnUQFGKuPrj9QRwT5WpddyoAqTfAO0m/w6Re1bkAJgPq
	JCHjE7j4OzVaZjpodV/6N23AJZGdeK9g0wyw3HSrR/Z4TLrlKQnVOauU1hCTPtwZ
	v9xX26gxEvue9NOadOjwuYRoN5/L8rvnvJJN2lokn9XGDBO/GTbnqoi0iqK2Gjn3
	zZYC19VVP9NGuGO8vg0AsB2+54uITAhi2QLULPWzAeB1v3e9Y9BMy7OIQLQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyea216v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:06 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-78fea4e86f5so867802137.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478466; x=1790083266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZL7N2UR4Bwh9Qvv6N097nupKNcXd85noQladH64uxlM=;
        b=Iu6vcXiSJ9wNtR+s/2v3+15HNnqyGBUu0zTlkoezX2i4VzkYhyJgFFq+dT/DZM1f+L
         Zi+fWXx0efMfjKc5I5nlpkNeKHMoFsNZcHcOKTj1fRbCam3T4UJMRSv+bnCgvpzjaZ5w
         f5qy2TNgXIFeru/7BTssCWgMl8F7hiUnc5T6MTrZwaD/IWmSRhqT7l7fy/ZT7neScu6n
         ehI444yZRyr9EkZps2SGtTvVAYEA+5r2SLzXIFqzSOVJsghkk/1U955JeMgWQmDXm4t8
         IUklCL9oaqXfX9lrFBQJTwEXmiEAevgVWf9slhUMUv+vu+3XEAvsMlTFDQ5DFn5+cmOr
         MEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478466; x=1790083266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZL7N2UR4Bwh9Qvv6N097nupKNcXd85noQladH64uxlM=;
        b=18Gv2AUXgui3daWY3LOx1Ir7hCn6gZD56J1aTQU+BdiOH8MewzkzRa2F/zs4ljFAx8
         PBmy6UrAp1pQUcOF3f3E2XIcDtjJhxq1BtoVgx8GIHL1m6DVRXy4BEL7/TLCvwyQQq7t
         edTa/dyZ99nPC5nhbCNoHwkiwAbLxr+K3hYxnmSiHRcHigKDSZSOnjAhXjsEtyXKrBio
         X4ulc30S2E2AqBZgM0YeCUMG5qcHbvnWjjAdpJgLyw8NR425QORPyGQaFEKHbjENkT7N
         gAV65LiIFGhlJfQ8B7c6+X1Q4utOio8G+pSqS1NBsDrRtPXv2C/t4hJSgf4dy2GqvW/a
         EIQQ==
X-Gm-Message-State: AFuF++nShgn3+flGuvhPe2xOurNAUOSSaHQ8j6Amr8K81pIU7r/Pzbux
	ljVFlpPx81aDpTo+nMYq95ZJWC4hdvLe08gHfFEY1JckRQdHxoCxkuQkj9nLUwcrxprPTalvrKr
	ghFoCqMZJpFshNuR2bcRb0o+H1TIehRZaKgIAGkDh4ZvDxwqf4iuBD8cTX08eEKjMz0/n9qI=
X-Gm-Gg: AYBFou3w2DzGrTIvhoCUUyWfma/MXnGeNniNbIIl8D2+yHfREHT7ZTRfKNsx6VOnMoK
	4oL1j+Y6wIpO0hVWj922XG/pVq3TWuLer4r0Bvv6LpBib8HdKhh4/OBb0trOx6KpqbjnsAMYFxt
	1p3Ld2ralj9yDivKDTMyIN6sG0YWowl/LFNU9pQxpVK4PWmHm8OSOpSNlsQLkJzJIwFXNEKJVYn
	heE5iRKeRsXhh+XSwFUzMLdMg5SmXZ2X+B/mJDOK3r0cBzyM2lVZ/qXx3gB+Yv3T6JTGKB7PaFk
	NcT1LaIj4k1gUloAKWrVs7NFwLPZlGKYkX2xmpW/R74K+8IDg/aoAxVCMuu6dASUR93UNtrDQpI
	ROc9n+s8FZ/NqYXERKS5xzmDLDm14e3jTmQfxfOV6fsg=
X-Received: by 2002:a05:6102:3708:b0:79e:df6b:d2b6 with SMTP id ada2fe7eead31-79edf7b4044mr445192137.2.1789478465977;
        Tue, 15 Sep 2026 06:21:05 -0700 (PDT)
X-Received: by 2002:a05:6102:3708:b0:79e:df6b:d2b6 with SMTP id ada2fe7eead31-79edf7b4044mr445140137.2.1789478465519;
        Tue, 15 Sep 2026 06:21:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296613c3ebsm582885466b.57.2026.09.15.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:21:04 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [PATCH 1/2] staging: greybus: sdio: Convert to devm_mmc_alloc_host()
Date: Tue, 15 Sep 2026 15:20:45 +0200
Message-ID: <20260915132052.273212-2-ulf.hansson@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 8mkv0R2U1kEr5GE12epYjt5zIj5Dd4p0
X-Authority-Analysis: v=2.4 cv=cehHPXDM c=1 sm=1 tr=0 ts=6aa94643 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=n9U4IdJ6Fa_2eTZyVNgA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 8mkv0R2U1kEr5GE12epYjt5zIj5Dd4p0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX2wZ5VV6ClrZr
 VPmGBCfLT4Q6vrhUrTPtNd4hWWmEEq7VuWpoPiCmdLqjueC+iN0D04wDJAoY7yFWQmj/bb5ybkF
 xPd/iKlP2Qq1bJ2StxFcU/jbw/eNETc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX9eWye6y9Pfbh
 2vswJekHEjM+BJbQvnrgigu0TCzzDKDonKhzBfno2TtcE3d6RtChhqRCcrrmH8MqpzG9/tPJmdD
 etNvWBckJoE0b5azhjW0/kkmuLMo9yA2tiHWqwTeXvZ9UdVoXVHrUfoBKDVA2jzzdm/QZJTG13v
 E28WXFqRIC88EU38MdKeTiThS732t01Iokzr2kS+2aDuHNX8TC9wcG9ZNueikRsbHnJ2oIwOjPo
 I5Pem2obqnjCHHJNyoL2yTTZdlu1eL+IP+2NnSRm/VOpIuHbs0QQ7bhMmhzHtupWJEuNIi25fiJ
 hYYhRki/lIbz0vgJGNhWAUoJxty0qR1Em9bESzSvFxpfMMgNMiHLIeq0BM3MWRbrPksjlOZn5/8
 /3+gFt0IJ7CS0dNUcda+1E14RJnbYKqvCQi6mS9BQEOI7WL4M67cM5ukqZ6y7enPg8vkzy0oUer
 1ybweauxfKEE8uceqdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150194

From: Ulf Hansson <ulfh@kernel.org>

Simplify the code by converting from mmc_alloc_host() to the resource
managed devm_mmc_alloc_host().

Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/staging/greybus/sdio.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 3952f3d225db..642d785fe918 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -767,17 +767,15 @@ static int gb_sdio_probe(struct gbphy_device *gbphy_dev,
 	struct gb_sdio_host *host;
 	int ret = 0;
 
-	mmc = mmc_alloc_host(sizeof(*host), &gbphy_dev->dev);
+	mmc = devm_mmc_alloc_host(&gbphy_dev->dev, sizeof(*host));
 	if (!mmc)
 		return -ENOMEM;
 
 	connection = gb_connection_create(gbphy_dev->bundle,
 					  le16_to_cpu(gbphy_dev->cport_desc->id),
 					  gb_sdio_request_handler);
-	if (IS_ERR(connection)) {
-		ret = PTR_ERR(connection);
-		goto exit_mmc_free;
-	}
+	if (IS_ERR(connection))
+		return PTR_ERR(connection);
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -835,8 +833,6 @@ static int gb_sdio_probe(struct gbphy_device *gbphy_dev,
 	gb_connection_disable(connection);
 exit_connection_destroy:
 	gb_connection_destroy(connection);
-exit_mmc_free:
-	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -863,7 +859,6 @@ static void gb_sdio_remove(struct gbphy_device *gbphy_dev)
 	mmc_remove_host(mmc);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
-	mmc_free_host(mmc);
 }
 
 static const struct gbphy_device_id gb_sdio_id_table[] = {
-- 
2.43.0

