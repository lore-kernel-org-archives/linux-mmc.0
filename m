Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484930;
	b=Hl9IarnjWSLl7M7XUCj2R8cqpJSSp3tiVJyipW81pETGt256Kwgyyt8wBtuPZxI6OccY
	 2RSgarzOKpuyk4p5+Bp/tDY7oHeTHW+MeYgmGBD+mn+vEoAyk7azec3bRZggX4F+e968r
	 1tpm8EaS4lXxsEzVMkcxJVwAs7CWGddEkCkrjVKBnEAU6wnFQTemrTVB9shLD5EP2kf4K
	 m1eSS1rRm2Sc2CUhGFtNApy18F21k/8d9ycT1vWbR0UJrbqWdLt7vHbTdBNwO5bYJ6d7d
	 /8Syf5FTjCQykatOmFt65bp5ROpKqd4AnHHbqMe3oiNaFBt/o6BoCWSoh/zuFqIkLdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
	b=wEsUe/CrvIE+vNNrQBlffqhf9TJXzIi1vldy9JC9KSWRUYdWJWEFVFB5yg7h0LEII4NB
	 C2iHuJ2V84Vxy3dHGbi3n2Ky9Y8+kbqUKMNCP6KxRp35RpXC4WJoT14Kd9ZdBIXuzniZb
	 qU5DNmedrabAR8wFjQ9u4jtrPK82qXwXt3i+hPSYjzX7UnLRLkp5gNUKHYu1pTClPsiDI
	 gZgXU8yg+Ps8eSdbXBylhISj83MWSPsnIVol6nZahFI2hP8SgT/3aBQK+h5qhb6CRr+Zi
	 MROTv2r5Z0Fqogj0Lzgz7AQD0X+tK2Ivr6EqMzova9ixUT8QiFlFq/Uc5SI5N2Z3cyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="JQbqy/4c";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ee7d0C2P;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C08606A335
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C08606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JQbqy/4c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ee7d0C2P
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAmqQi2555696
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LN4npOI8ENN
	n8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=; b=JQbqy/4caH8gV2NgWMRAHNwct7u
	VtFQGJEwMEMFEtU8xYPTOczAHsM0tBKdEkYXMzARYNKSzUfX/aLdeh2GeX3QclcY
	KfOMKKu4wi8b1CPPPLF7EayiWG41B7Zvrb99M+XYGnyZ1nGMQ+rxeDjqn0ib4ayD
	s/aKuaT9JgyP7KOqNst00q5eB9f+MQfeTDzo1YV2N+InkfDWq7AzMpBAFtq/Z+BQ
	3aeUKgcbyfBGKiv533iD8iOD+PZJXHEGwh6ABZ4MT9l0EhQuCyDbUn9i5n/hoi/a
	cNbIf7rLkg3Z9qe5KDqk0ZATrh2fr3KOwmDeCjfUxMD5Zb2LCq9vjsqh9ng==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j07p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eaad8219b0so1316381e0c.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794484928; x=1795089728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
        b=Ee7d0C2PrmC/n+0d3shjCeo39IWLf3JhT1zoOmuekvgYZPdBRolrbzd+pjE0WYv1I5
         3AkiPRiravgSJp3dA6sTG5RngV23dJnc2MfdB7fMIR5W0K+0K0chCZjuVr8lxMVs25ej
         l76wCSiogXXNk47CkSO5q57XXSgr/SuU5OyAtEYyzqWm5FIjO3xvYZ3IuWHH4ZI11uUA
         dMq4CiPF5ZwMbnElhb8kqGvtuggDgrrfcaOtQLEfd4JmvK316rxuk79tL9zopiRPuEwV
         84MvZP8C/L7OkTZjrMxpmT2DKr7/V0vy9KjY+8PQQRvM4UeNYFXEWJMHN5mloA6zCFKR
         OaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484928; x=1795089728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LN4npOI8ENNn8TMuNv0TyruYxv1giv4YRRzHn3sz4Xc=;
        b=yiUA2W+pHhwd9x2sdj+lyXsEzIC8AnmgZeuCfIXeYGL6zecSXhFKepYPwxOIW9Z0lV
         EBTErgbVjkAH0uRerJxn2C7vu6NSemuu4FdrsfQYU5k1s7hMXUYm8BhVxnC1povwaN2w
         eIacU6BVAItaYvD21ol7mu0TIr5uEWzBYRq7/594VHIYIKUSNGxkVMdtUuWsWjvH1SOZ
         Et9KtvPlnc1ARihHBSt2hSo4y7B8krbWFI7SswCUfAI1ougQQE12PPD6QUpK/RW2onHk
         upmZOAgEpfiesLivtcbxtmrOw3Z6lwf9Kh2+SfiHCe6MEs6COOrgvSGOCAI0uESnFrmc
         tmJA==
X-Forwarded-Encrypted: i=1; AL+hErGq9olnbJfWbZzGAj/uigbSy37YiEGzUXDppo23hrxJHSWwKZT6jK0sihwpYmHI8maJLsE/wKxqSKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p8aE74QO4QD/mg/U3HCmvkQp9efwL3MVT4Hx364wNRAWku8IM
	FvzNmbVbcKzd2U/DjVU+j8PUOgEp7kF9OKVzGgkh7ZS8BQd1nGL4y4Q5UGYBSmIYKMnhBD6hugJ
	BoMB3xq9EAxSkmJ9K+KBdp6l2Fu8DDoE22QEYQ50GdRANKmFmoSbok83MTH8eVSc=
X-Gm-Gg: AYBFou0Ilx0ucvquuy0Ry5RS6BdO6OKBgM0AWlXdKmCYlRAK8q7sd7D1T7sP+5Yn+bl
	VivapYexuQYaedpk6j4NgYkg9ek2904hwYk4Pv3kIkvHgmgTUaJDbDXpuQ/+7SMolvZvd14hcon
	w8egjvPhqM7tRIYWhoQu/0Zdj7R+dB69tDJw3cLAEAVRvZ6XrLb2H1YNqpWOMb5Zh4dK98gkHob
	eVvXwa0tZhcvYCCE5OqYPUIqbH1dP7zrJHLmTcHBRUIODbyXrF2DHyxkwHnngh9e1rvLmA3WdJB
	5A8whG7HMsVzTnVRY/sWHsX2rHMblktSV/nn2Gz43bC8UlGzzjK86QW9X/QILsHIU4uWZrO9S6H
	7YX9wcZLoNanVz1tRD2h2BDorg960akObf5xrcWT5g/+u8/8WafmkDC799mz+nnEEiH5a2I8FG4
	qMX+xotzd2ECDjaVz0fauL9n+KfzBY0TamEoTc+PC7+AOYCGala776fIwch1hQKmz1
X-Received: by 2002:a05:6122:e248:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ee1bf5d992mr2179505e0c.0.1794484928151;
        Thu, 12 Nov 2026 04:02:08 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ee1bf5d992mr2179440e0c.0.1794484927546;
        Thu, 12 Nov 2026 04:02:07 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a602b70sm325553366b.49.2026.11.12.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:02:04 +0100
Message-ID: <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX4slmrxLW38ME
 cKlHTtUuI/m/t0O4v1Gmgffu62cIQAX7m5cYJKFlOPQgkZgxXNHwYEf/hfFWDukPovqYT45L4+N
 U6mcCxKiSWQSAs6ZoB3slVfilREMk4o=
X-Proofpoint-ORIG-GUID: 64CBs8J8IUgxS-BUbZ05-im9FVp3T3e5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX0vmsXmDTHFUg
 zqKQdhKNqIsLnHJVXwpzb4eT9wOGTFLf1XUdXvl40Pr9Vbo3UarLBBigtHeNPNFKlQEibkZj/1n
 bdXwRxwiD+9GtBlzAoY34WzacsWlBR/gX6zvQnt0ZfB8jTqqNu1xywekFM0h0KqEJA2FnVgkWc0
 FrgZXnSBB2+XlnutUqVhmKyGe1AwOJIzH+KJu8IpRe6qOi2BKa2wUJrTWSLE71BUVbxe2duY/b9
 nmnn47pSXI1fz+/44H0JWrBHN4wNoKmgct9usodp1W1+YDUOoziufl5UR1ftYju2tbaS5wqZacq
 JvVJHMDF3tYfGwZC4GVg3OL2kMhSm4sbfEOkH+4cYduvrJ8tT3DWBmhYqSdTZ9lecU5dowVuLr4
 5SHXn7KWtOQwIhll932H/SvlrKk+XFLBwGJP38aj/Jx+zhzo8XwPo3pRrzQmSpuNCwhH9yi1epM
 nMXXgCkIW5mTHwKawpg==
X-Proofpoint-GUID: 64CBs8J8IUgxS-BUbZ05-im9FVp3T3e5
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af5aac0 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=BMQ1IfJYKatq3Wfn4ssA:9 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120047

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

This brings the SDIO func handling inline with the SPI and I2C handling
of ACPI fwnodes which both also call pm_suspend_ignore_children().

Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
companion device wills stay around after removing the sdio_func device.
This re-does the ACPI handle lookup because acpi_device_notify_remove()
runs on some device_add() errors and from device_del() clearing func->dev's
fwnode pointer.

Fixes: eed222aca8d0 ("mmc: sdio: bind acpi with sdio function device")
Closes: https://github.com/MocLG/rtw/issues/2/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.
---
 drivers/mmc/core/sdio_bus.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4b07098c33c3..6814d0506445 100644
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
@@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
+	else
+		sdio_acpi_clear_handle(func);
 
 	return ret;
 }
@@ -417,6 +440,7 @@ void sdio_remove_func(struct sdio_func *func)
 	if (sdio_func_present(func))
 		device_del(&func->dev);
 
+	sdio_acpi_clear_handle(func);
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
 }
-- 
2.56.0

