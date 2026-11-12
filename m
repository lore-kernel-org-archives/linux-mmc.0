Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487477;
	b=YJ12J5IxKR6gN3tmno9HdHt9y6Ye6zkC1MqJylqpGPdhuF0bKc2/5CBhG7tXkPDzpol5
	 OrlNOGFF7XtOnjQ/WzpM9bAX/EEBfTNldOfKBzkCML7ZrBMFvh4y/JP31gXipc50P77JJ
	 bBIOmdgM3rU8VugkaVAXHdWHEjAkojDMzIifQSgtLP/lVh4yHr3kNoYocJSL2QIAZk3UK
	 ciWTmL47yVipqXh2m16VQZerGmOOQ6g9X7ZCotY0EBIqJu34ucGHDmmF6+kOPwJB/20Eo
	 /8nIaE+rXHh4uI1CY6DqV3HDgW5TjxX5yjDfgX0vIuYgRsXOZ8FgpT7nUvF9T1+Hs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AuwEFxA7dTKpyl3YpGXO5FylCNB+4F0inH8Ef9PVzTw=;
	b=UbIx4rE0J/viTRy3+FQCaXhjCKMjsWU9WkKZmBn9Ib54s3ukEW2HF/F2nvWR3cridtdn
	 gtGCxFlS1S9P9RiQYezN3St050fXP1crmAKIxm3NMY/SsHBcz+3fno7kMtDm+ag1ADqPY
	 D+RmTMbmiiVV2PQ0hoveEKJ4fQVCxWFDl9fKVoGCRi+XcsWGHr3gWv8qd3NVgPbtHqIk5
	 BxFelypsIHcdkwfHaGt1nziRiuJks8Wxl88AXoJU0pGJBb5ZuiYV9UIlOH+vsh3Ncbc94
	 0yh2cphSAbR2jbuZqgdGwKc+fpedA53ccFVMM6kwAoGyIvdUBtpp0hcMKwlqRvLiKpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3ndTDvC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U+LduT9Y;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0135606A323
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0135606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3ndTDvC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U+LduT9Y
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9E80l480590
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AuwEFxA7dTK
	pyl3YpGXO5FylCNB+4F0inH8Ef9PVzTw=; b=F3ndTDvCjXygnOFjJfjZhYxt5rF
	on5Zh/xko3xM4Plu3voXbU8nDbGXj77N1XeugeORbIPOWjTQpygjZ7lHWt7PCtKT
	sHYiR1VXuUJa1KaLjfy/9nVEhvTbqP2PWnF0EsqU7Z9UCn0P5pSIO0MOihflQP/t
	d9bAbB4Lw5q4JrObTyCA0DYHkwU8UidbRRREYytoX1MttZlAUmAhsu2K7Q/Dff70
	iYe5F8WZfKN4Wdyja+9Wr0/ICIbBIBEDH+K8ygry5vFrTuP4/5ciSZBPmwpV3kNo
	Sak9DDeV+sOiJ+a13OjvKiGLiY1D5ULCpy5W7+rD4Qd1z7JHf/4ATKCUFRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rpj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so521788885a.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794487475; x=1795092275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuwEFxA7dTKpyl3YpGXO5FylCNB+4F0inH8Ef9PVzTw=;
        b=U+LduT9YBkdsPdjjGl0vFdaApCwVJJ0SyxOJ9UCaeUI+JaWPrs1qSY8fDF1rr9yWwQ
         Ff3I7M/S8KIEVAWTIXyfV5q85PtFM+kZ+0re+yzXWFZlZ5RzcOyjzanOe3c8GdvQV7Xo
         V9cpE/rPnk8g5PaoOpj9Min7ibHiF0oujBaRvWjVDpDwvyrK7y8nd5ODJ4KVUPvOsgWv
         b+/iy3VwjorYzWGD5v0NKDhL9TkrR3CAqerZA2wcy7cs04X1zIDrOaKYMMrdE26x1oJE
         7oLjQtfI2f8uSBxNw5Ah+30JvnEQ8eQxixG5LFGw0ODjMHulCzu7sXrWG2OZKc7yCUDJ
         cgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487475; x=1795092275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuwEFxA7dTKpyl3YpGXO5FylCNB+4F0inH8Ef9PVzTw=;
        b=hDLL89k+dZQEEy3JrjVvNiASc2rL2mMOJFZqT+inmAswnz1FhsVN5nM5rWyeco4Lf0
         sgIb61nDHBbO8cVc5tFszzehrv8SrActlS0RXKaZUTv8M3KykENY3hNWRbVrNTMB/GD0
         2cyzLll0MWm8n+UCFknCvLrQ4GPMV1za/YnErLUuxrwVE7lqCaASnjF5vARlc3bRl03X
         1RsXbqli25OR7IKETvRy7H70y9SmJkW9aJO4ukWdRyHBkXb49AxURrduPnrpi8KXuCke
         GknpR7hleFhn2fK7nj1n7oRUa90D2I/pFXEO5HKCsiql7PRI1FZT7/t4R5tSElHtY5Ql
         mA3w==
X-Forwarded-Encrypted: i=1; AL+hErHimoImsHopu/7TvRJqrQUIrMQjbzJy4YhuWyJwwKUxcia1cehqgv+Hq5BVVOH+bd3yM6YSj7fOsK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O2YO1XuIENWmvaDT/JGvxMADmuUi7QCVOZUbqN1Fdbf0TJvAd
	AlwG7RVRNF/qgCvyXxQtWV9kB2vRVznVv47S6VFnW4n+FNZhRPwvN7aqjwMhNKRnKVZzWKpL2fE
	NIZTJ32H0Z3Fq6mvGm35s3yNcWB2QinZc+iNZVHGSETFq0+67tz0lV2h+T7YxH0BXfD/s+i8=
X-Gm-Gg: AYBFou3eqA8jvIEbsl7qbTLi/+/TZdkhnn7oT9+Ft7JND5C3G++RNVY36fhn6ZWKndm
	RY2W5qyCqL5dsxVSkRcknFzNfcuUf+3/ch46Ynv3VHlKKUW5IKyHCUndMinxLUWZ7HvPm9nXgsQ
	uinW6pq7TTXEu5Y4g/u1QxFVT0ETenOI7lV24iVA1soYgu6gCRStXriO160bE4TF2Pya+VrLa86
	Rh7UqrVlhPCoh5gv4Omsp76IoqyTjz/66d5LeW5BURHWSSUYZ5ajrwoDTnn6T3oO5jvx3q+ZU+P
	tjeYB8ugzkVIhHMO8F4nYNf0n5kroibW7ITPZbWDAn+C6f9lk03Cya4E5x1BjcnRv+fAuUgMcbW
	efrsRYjxsXlAFlxBGir3mQO8JfsWF8DRaxuPsvQjib513Tq6e6lmCqz0+q3T1R6RtrZGsYaoTN1
	19cTpjN2iMDkuVTSSloUKrGpQTsZymP7kqvWRehoLGNsVM3ni3gMC03ya+u5VEcdqc
X-Received: by 2002:a05:620a:4691:b0:940:cdec:c867 with SMTP id af79cd13be357-947b003cbb9mr845150085a.70.1794487474797;
        Thu, 12 Nov 2026 04:44:34 -0800 (PST)
X-Received: by 2002:a05:620a:4691:b0:940:cdec:c867 with SMTP id af79cd13be357-947b003cbb9mr845145885a.70.1794487474306;
        Thu, 12 Nov 2026 04:44:34 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823caasm3289147a12.1.2026.11.12.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:44:33 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:44:30 +0100
Message-ID: <20261112124430.110629-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com>
References: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-GUID: eC5e8HWsrSK4Hq3VUdn-5OumVu8JD4BH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX36DaunmPalnV
 WeciA84DYzQxsHPQRbQzyYdk2t6pjA7bfkHvFDkvDGTqAetS1GJzBOnE4De8EHZx/zLRI/Gdv0Z
 lWqkaCg9z/FrCK9SGo5bMgHy8jepYA8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX50UEVCgbFde2
 BP0rhkKly4T46jCetVz4ynJVATWeVX1M/3c9lBSWYpG7xvIdmRIDTUBd2zz768uBgDs1nwiG8Y3
 0FadyD4Q01KyTadDBiFz3nKVxGFkttPqyog+Tu4WYJZ7CXitiXZ41uIDa+3YwKCx6PhJIPg5tE8
 teT3GqA6p5325Usxy2yNai1gRSzVBr7LBWrfQJMQOX9yI8qPHYDTVIKBHYDwViX6hg6mANtia/z
 k/XyUmwZXDEM+Sy9AFLymkuTCrXV43fQs7lOHggzAT5p1stq0gZrWULmudSHQenZv6UxXvDxjZo
 xFZTQKo2dvPgqdiLDKba93thV+7oyMLs1Qo432F8i8Q2SLHuAYYYd9B8naU0lQLX+lz1hrjw+iH
 ARiDm9ICYssLLWs/SOk4tVOsq0T0bayT7Q2yV8rylzs4y6568XP8c2kHVZVPjhJ1bo4fR26lolM
 7D02I3GXxKnsYLO2INQ==
X-Proofpoint-ORIG-GUID: eC5e8HWsrSK4Hq3VUdn-5OumVu8JD4BH
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5b4b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=BMQ1IfJYKatq3Wfn4ssA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050

Many MMC host drivers call pm_suspend_ignore_children() which allows
to keep MMC cards and SDIO-functions on while the host is suspended.

For SDIO functions which are in the ACPI power-domain this causes a race
where the host may end up runtime-suspended before the driver for a SDIO
function loads and probes it. When the probe() loses this race this causes
the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
code with e.g. the following error:

 ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot

Busses using pm_suspend_ignore_children() for their children should set
acpi_device.power.flags.ignore_parent on the ACPI companion device of
their children to avoid this.

This is safe to do because drivers for sdio_func devices should always
call sdio_claim_host() before doing any IO and that runtime-resumes
the host.

Add the missing setting of the acpi_device.power.flags.ignore_parent flag
to fix probing of SDIO functions sometimes failing on ACPI systems with
the error mentioned above.

This brings the SDIO func handling in line with the SPI and I2C handling
of ACPI fwnodes which both also call pm_suspend_ignore_children().

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device will stay around after removing the sdio_func device.
This re-does the ACPI handle lookup because acpi_device_notify_remove()
runs on some device_add() errors and from device_del() clearing func->dev's
fwnode pointer.

Fixes: eed222aca8d0 ("mmc: sdio: bind acpi with sdio function device")
Closes: https://github.com/MocLG/rtw/issues/2/
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v3:
- Drop unnecessary clear on error in sdio_add_func(), sdio_remove_func()
  will get called on errors and do the clear
- Some spelling fixes for the commit message

Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.
---
 drivers/mmc/core/sdio_bus.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..2cba8c45c8ed 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -373,11 +373,32 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
 	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
 
-	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
+	adev = acpi_find_child_device(ACPI_COMPANION(host->parent), addr, false);
+	if (adev) {
+		adev->power.flags.ignore_parent = true;
+		ACPI_COMPANION_SET(&func->dev, adev);
+	}
+}
+
+static void sdio_acpi_clear_handle(struct sdio_func *func)
+{
+	struct mmc_host *host = func->card->host;
+	u64 addr = ((u64)host->slotno << 16) | func->num;
+	struct acpi_device *adev;
+
+	/*
+	 * Re-lookup adev because acpi_device_notify_remove() runs first and
+	 * clears the fwnode pointer of func->dev.
+	 */
+	adev = acpi_find_child_device(ACPI_COMPANION(host->parent), addr, false);
+	if (adev)
+		adev->power.flags.ignore_parent = false;
 }
 #else
 static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
+static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
 #endif
 
 static void sdio_set_of_node(struct sdio_func *func)
@@ -417,6 +438,7 @@ void sdio_remove_func(struct sdio_func *func)
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
+	sdio_acpi_clear_handle(func);
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
-- 
2.56.0

