Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167338AC99
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253095; cv=none; b=emF4a+1DGPeKbCkCdTjmf0qaIYRnB2af0RO+d1MKkKtz/g3s407pdmbQKPADIN7z5/5Vu/2RkZi0yi3sVQzhfF9+A68snWN1GCbkSlPqe5Z8MoeYEvW/Ij3iRA2zuauKd9roPjANRGTEnGDCWiEcd8Mn5ocgVn/7pLZ8tvmT2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253095; c=relaxed/simple;
	bh=byVAvNqvsjwPdeh+FO9RKveJ6t3iuSgMa1R3KK8A1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frcwYUQOED7yUhWynD8LOKvX/g0WzQXWNIOvyU+7xSac5KMSqIwRR/VE9HiSxL66N0CIV7kEmhdolGSFxQvcThPa8nmRYl75xmpybDX95ky686vzRP7V8SCgx9im8sNf/a6YArtq/4S/BYIRAs5XLrZix+Z3ytNW2p+44iEY9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTd+c8tQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfCIzXsh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTd+c8tQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfCIzXsh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDEtbU2244894
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmad
	BeZlL4Xw=; b=GTd+c8tQgy0d1ilB6i4BdONLqEh1c7vl296/R4QYTdCwRj4SrzA
	koK6EUxfMcjz4wm1/RKTPd4h2Uk2FPWZGwqf57Ktd4KhstVEsbHC7w6eXUE98LGL
	ri7MtQjVQPvY8U9Zoe8z6+KEcbZ1Bcx3BsY5YmS4aXC75biYn+/XIP7Gzo+Z6jTF
	owAV0vRWExG4OyCFC3NfDwLIPcgpHGLD1hKv2fYBUzz6ju5K22gIi2HPHLB6UKgt
	Bp0R25bqub3MSBH79nanEHruabNdrkcmmGn5F3dhMwv+3D89GkLwm0LkT4VkU5xZ
	pel5wzwPhGebPbiN5R241xWwHcXtvEubzzA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxqfsk62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:04:52 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82cf2652dso343090e0c.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792253091; x=1792857891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=MfCIzXshHITDDSc02bT/OmL6GhFSP9kTHk9TkzruuM2qVF3i2ZnV9dAV8snzK+mqOw
         tX9eqvZre1Xf+zAMLECmC6wjIuxelxbcNDUFgZrhU0ytbnn4sxDC/qYIJ9mpO0CGG/BI
         /inpgnMeZLwjETs2dxRByRIJTP3pEaCgGvQIOZhOm4aQ5PLfcoHDku6iP3B2Y5vVgX16
         SdzDfQTn63JzbRyHMIj/aj9u8hJ4pMXtniesXxV1/BWuyz5H3vogDIH9ka0hZdFnKAKc
         nLdBYeI2O6vPeW7wEis5aKpuqDIJFITti7oOu+P1Z9vOUUZh2+cbldm6v2DJbVP+ccZp
         oBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253091; x=1792857891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=USwbLMIN1be1bT1v7mG+W/aszadvHiz/h6IORZTWTFmU/VorB8eCLYuGezWlXQ/Kst
         LVAMFj+UiSjSHO3Ey4YYtTRbQQaAIRqCKUyFQTRJPU/T6H12clThypJzY9TdjbvM08vp
         9QrM+F1NPiea6J57YLdyOOYrd4xxlsiLE5AXtk/A2m2n0uIXmq24jFtUTTckRWJJ5JF5
         Ga/0TituwDnEPIKsp3H+PR29g83Bwl7Rzx8qpSNKAZ39JTt2O1muNtGihQYrqKOmsDdN
         EUQpkBNZ5or5LZ1KrkU4urF2LEAep7BJtLttqW1w6YVISD+yhZeuJUFsLJktY7YoPrDZ
         v5UA==
X-Forwarded-Encrypted: i=1; AKwUvBxtxX/VapuDn7js78s7+JWqsmdgqxUVU3haTVqrGxp+bp61psgyz637wm0OAvqWh8/+EYPpA2ya2EE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJniGupkdtijmyogEUmpHQGcJMO6tdZuXbJBMzvZ8NcZyaB0kN
	nhKgy5lJCqTknECrNc3/BsEhCk8iRTalDSh4P1mjgckQp9gpzXrSlxfaLkpp3rYSzh+P4cnBg5W
	ZWItPkeWlNM7L9nQ75v9iHhTR5Aj+IbDtLXQF1H1fYqVtuS7tegounXy3ieXESsRyCv3x9M8=
X-Gm-Gg: AYBFou0EEerRF4g88zIJ0yjk5oEyDc7DTsfEIT0FsJbUU0la4uD6R2z58kLMDHaAXlL
	ENEaw4zwgIhkEmO+K2eDxOcnZCBzUH/Z7K3LbG2RxYj5usBwrCWWLYX5UCvFTJCPSeQOoXfPhHd
	J2e0g6grPUfDJZJZH7sb8BraO98Imc2xFibKv6QO3iHjYtZYRthx3PSscU+CbrMBDxaxEyM9iI+
	tf30/BKSOp1d6S+XdLA1lrVMYJYlPgwDUrkl0Q34Al8TQKC7h1N4C83h51v361IyfnbMyPzqyvv
	P7RA4bJAJWD8PAs4Wmw0fBMiu0Qdb7cHuPcO3IGEUb7pjrQC46t5OS8CSoCWxoFZ6spm3GrPOBb
	eI/qEQuVJOdcdmlp99RlEZ45wFXsWAjpT6frPz0tXoQ+RI9GembS6/z2whf3LMYYoaydJqG+SgT
	lPmh9XbWjI08FbADU=
X-Received: by 2002:a05:6102:3749:b0:7c9:624:86e1 with SMTP id ada2fe7eead31-7cc36b021c9mr733948137.35.1792253091254;
        Sat, 17 Oct 2026 09:04:51 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:7c9:624:86e1 with SMTP id ada2fe7eead31-7cc36b021c9mr733942137.35.1792253090745;
        Sat, 17 Oct 2026 09:04:50 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm187735166b.79.2026.10.17.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:04:49 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Sat, 17 Oct 2026 18:04:48 +0200
Message-ID: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX4LvuRuWuGj4q
 GhjYbBGUK89SEDlNb/jcz5s1NZYlHYJS4vca1Zuicbocu/PHtVuANgOjYIAzTbkafs7hZJt2MO6
 Tvip1dA5H0kfSE46P2EpLw4wP1hElGI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX5O49VvCsGc3B
 e8L6sKLkNtZlUgqdWP4vOTuhGcPJVF5ATXVCzTqjdVussx5893NJcWU8mp8sOC/kk3Z/r42usZ6
 PVZRFrSV0j5RcR/vTWeSEcUw1CoYod6g6A4trA3ktJEpSmNoe6CVNA+l9ip9Esk2XbqugY4OpFX
 VXYgmsEcHpBrVrycuUek2oEAJlZjfs3muNEPNFMVyblpKdk5UVytHSsv1MAt9bKMRloB3h2yL3m
 w5ki+xr8TpfMFY5tsU40U70aTxrTa8G7CBBMRi21Mc7DN6llrNyEmaj6CtRmT+tK2JahFopO9L0
 nQm/qpoS9PgRQ9BR/EZuSivue0npNpkx3LyTZEi98M/fUr5QMNvDGYNFch3EMGuKNAIXcpbjU1h
 FP1lO6mIZrjuXkSWxAAtg9eY/I10olcI4ODu+vt8dI6P2phZqZ+2Mr0aybzXk5FjtnN+mjrHDbl
 bHExV90G2YCjpEYQQkg==
X-Proofpoint-ORIG-GUID: PsIQ-cm0K-z03yU4G59k3O5kgHO53RXS
X-Proofpoint-GUID: PsIQ-cm0K-z03yU4G59k3O5kgHO53RXS
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ad39ca4 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=aOoE8zyrkuWKOWMt7W0A:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170064

Many MMC host drivers call pm_suspend_ignore_children() which allows
to keep MMC cards and SDIO-functions on while the host is suspended.

For SDIO functions which are in the ACPI power-domain this causes a race
where the host may end up runtime-suspended before the driver for a SDIO
function loads and probes it. When the probe() looses this race this causes
the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
code with e.g. the following error:

 ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot

Busses using pm_suspend_ignore_children() for their children should set
acpi_device.power.flags.ignore_parent on the ACPI companion device of
their children to avoid this.

This is safe todo because drivers for sdio_func devices should always
call sdio_claim_host() before doing any IO and that runtime-resumes
the host.

Add the missing setting of the acpi_device.power.flags.ignore_parent flag
to fix probing of SDIO functions sometimes failing on ACPI systems with
the error mentioned above.

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device wills stay around after removing the sdio_func device. To
make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
also make it actually clear the companion pointer on the sdio_func device.
Technically this clearing is not really necessary since the sdio_func
device will go away shortly afterwards anyways.

Closes: https://github.com/MocLG/rtw/issues/2/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..fa1d300211d3 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -373,11 +373,27 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
 	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
 
 	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev)
+		adev->power.flags.ignore_parent = true;
+}
+
+static void sdio_acpi_clear_handle(struct sdio_func *func)
+{
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&func->dev);
+	if (adev) {
+		adev->power.flags.ignore_parent = false;
+		ACPI_COMPANION_SET(&func->dev, NULL);
+	}
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
+static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
 #endif
 
 static void sdio_set_of_node(struct sdio_func *func)
@@ -402,6 +418,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		sdio_acpi_clear_handle(func);
 
 	return ret;
 }
@@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
  */
 void sdio_remove_func(struct sdio_func *func)
 {
+	sdio_acpi_clear_handle(func);
+
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
-- 
2.55.0

