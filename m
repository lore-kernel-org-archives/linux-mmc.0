Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608C3822B7
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252787; cv=none; b=RfTdCLxSX9k6zD9T2cfT58Zr+9y9+sHW2slgWtZyKpWziB1XPbTzy3xPz79K1nKRhnBf18imO6HNAR+UbYBaLlnX+jPJ/xq5ALoyn3cMrJvnQV24Z/BYjpKjLZDIQcDTwzy2paD/br55QdiwiUKiDWwnjesMbbsSmIGy3As08ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252787; c=relaxed/simple;
	bh=byVAvNqvsjwPdeh+FO9RKveJ6t3iuSgMa1R3KK8A1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdP4leo13Sgbor4TYcO6LFkEzeGe3pJNh/WgSBnoiyr6rwr2HkRE7AtGXAE7Lq/c86UnYMQyuUc5NIhV/Fn9aJGnWDTgDxVhix4+jDC/U5rqtv2QfvOfJsQ2UyLAoMI5qHTPFRSizJThUhMRLodmXgf4zRNfMqPNeKKfVmYoCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0mOmyo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGJNVGXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0mOmyo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGJNVGXF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDF8Jq588602
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 15:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmad
	BeZlL4Xw=; b=F0mOmyo655CgrUXGsmDERF3TGJi766eAHyw9RMqF+ZR5vKQvPbZ
	mLAt6AbTMNIupW8ezj/fEuvKIg1aE3aqrduSyg7WmCKEb4Q8+4A79l3f23OOko8A
	x2GyfwdYHXJOwoNtlU6kEc9/BcXBHzOgHNT9qIsHMbx01t+b+g0R2+RINLwi05pP
	v7S0qE6gk35GqYwNvbPkbWnToFOJPrLVQZ5gXRjRMsz6tn6tocHkc9g3B369DMhN
	PKxEJdtC0/LF7mh8hbyA00i8NmEwGxbDTiIY1HsQbo/JTjm+QVTrDKoUZOz5fdUf
	WjPFMYaXyGExChIqcUb3E9isDQ5Gkvfk2tg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se16dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 15:59:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so182689585a.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792252784; x=1792857584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=fGJNVGXFcxcJViuLHnaTpxfsGq7YouewcWVZf9WqkPCWysBylWzLKAKK3wLiOIRRqb
         P7gtWhWTqP8i2Ssvwev+kqZ2KfigHRW5MWtKz1gD9OR0vlkL/1op/MzWs/Flf9yOK/dQ
         KYZQDBi8hs39eJXOWhVuUkOdzWRU1EId4vCPzaS241nB8oBu9aNPDFOgNpAXttZLZXP8
         0l+934pq98bYG49wNbLSWMIYeRrhBBDNuEPuF4REhhdQm/K/EDM946kW0FkMHUOdp78c
         K9dPqQ5crHzRX/3Vdm4aNEityoebz5bhg8qPFnAaIb1ix0ONS+bwVUuUXDN5yxWsy+4y
         X7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252784; x=1792857584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ccr27OimvV2UAkq9Kmkh9z2UO6XI19mmadBeZlL4Xw=;
        b=d02hp3TfYdZQF9ZPXLSHgzvdgRWhbRFUlo2WVkNC5i/OS7Ma+D5/cqVSlWNMcZEhAV
         CDtjojn52aeE01A6zRqHLuZ0WZYtyfCVR2sjn3kB7M7qi+kknRKhYQoZnGXGqAXfVsRl
         WO4jUtZDPgvSFbX09syZqMCX8htrkxtzRahU4Vhhc7Tgm2E7kbeVGqR59YSZDRFZ8dqH
         fdDtZYlA3WuoV9CLH1bhKybVJ0A8esnF9dottoY6y5jLKj2m+Mj8+Pp4xMmaI6kUZmX3
         CiluxtU3ERiN58eniUTebPP2dDDL0LovB77sSStM83R7dmFIFk/lrLpd8fRycQQENbYi
         vlrg==
X-Forwarded-Encrypted: i=1; AKwUvBxp9haFCg6+EB89PhBQZcp+nul5YSFYX0R/cPRUlFTEpvQA59x/EOP1N256ZFQVfbPLXsrW5Q09BEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnmBPhtOAhZTDOU+Zau5KkuvTBtS37myr8dR4KUb/3O6l4JDmP
	cO83/s/wCYcEiTm6Ty4IT6v/1UE15f/AKz8KwPs0d8pNz5+7tLDT2gTv5/RqENaWJ1qURfN2lSC
	XcRdQ9Y+H1T/YDpY74OHXxFM+N+Eo/JqIAVvi6Jg5CqTbb0AUn/wPJYEMIj5jvRo=
X-Gm-Gg: AYBFou2bkF4EfuL3kYVviG2EvwMzFdDb69GXeUxCmXK4k6DqnckxSluWIPCYacAwhAp
	IbL9WbByEbG2jLCuWevOzPjcLWIltNzWfuLpwGMoSK5Gmp/TSRr73dp4TimbZfqqNyCWs2BhKJg
	2yg+VJ8FKfQ+KMwEJaYgOs239jx4rbo3Vs2metzILj9edXZF3BE8VGAquWaQYhCdYItsldIZ47/
	Wyruxx+Fl9UO8CV7h1mRhsuwNRcNV0AszSH61Pn5UjQ/E45GUH6g81+ooafpuG0J4QM1W1HXLcY
	uG56AzZrMWTX0Y06Lh0roGlsLy+8VyY1SkWg0IILCEKvBM8N+VtuCBO8IqV974kDf8dCmDLRWWg
	8N+zwBJKOxYC7f9iXj9DtB9Ti9FgXPg1/rI+EgAvngqRlmcIUoK+0PF1Da+jsebm9uj3Ghro3Rj
	jg1e+qv3AVrYRv8eE=
X-Received: by 2002:a05:620a:46a0:b0:93c:290e:9e9c with SMTP id af79cd13be357-93f17ef320dmr1099205685a.16.1792252783841;
        Sat, 17 Oct 2026 08:59:43 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:93c:290e:9e9c with SMTP id af79cd13be357-93f17ef320dmr1099201685a.16.1792252783230;
        Sat, 17 Oct 2026 08:59:43 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c4c5dsm185868766b.39.2026.10.17.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:59:41 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Sat, 17 Oct 2026 17:59:39 +0200
Message-ID: <20261017155939.75677-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VpCFQT6fpeYyd2jrsFpNOisFYRXCbq1l
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad39b71 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=aOoE8zyrkuWKOWMt7W0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: VpCFQT6fpeYyd2jrsFpNOisFYRXCbq1l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2MyBTYWx0ZWRfX8bAn3cDbjxFD
 FS+tmE5UDF1OPE6bepeSRZUXsrs6wqt1ZZ+sC1nNmagbV242uwmCkhxaKjoTlS1Y5w0h71lcYrr
 x0UUOTGuszLuZlTae+/5Hw7cDt6pzMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2MyBTYWx0ZWRfX8jap8qf9Z7b2
 0kZtywzHFXvq94CABKi73dOfX9y4busfL6yjRl/hwIs+F1LBUSL/JNzshSPMEiLc10ClOJAU4Co
 OisEiUT9P5C1aCLFhXjsf5XikuB8Z5dlTbHFTB7MB8T85ae9a1CBMNzZ51KhHpdJu8wbTJMV0OI
 cSaMlZmc0QZWxrowGHmIMODlDZcZagnZLhU1N/8dsqvOAhmQF+/Ix2iNrSwLrAukfnjew5+xRcH
 ODoxjoIIbTgZ6FLgbcvd7Cx5CxiphD0yZ4Ts92h+fE1MQbJiuW3tV8ZfcZXtxNjROUYxl/t+HiG
 kQYUYVtcUwsiW2BSLqG6hMy3oDbXPG9epXnFKWFZW/XHF71vm+ajpqD59+B6PAhxuSDeThOi1pJ
 ypDY4S+t5AVkdl4793QvjfdbMNYyzu9ZLgt1outodRKcvtZy5D53wHaAe2Oeosbo38/1At6MdXS
 t15dAv04WpPkgQ0TvUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170063

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

