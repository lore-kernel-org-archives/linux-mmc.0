Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112078;
	b=pwXzAs5CF3/sxJH6dFO/ZsxPfkyvpogmzmdUzQwVoO3nJAihry22sFxeMlQvZDsxYifa
	 OyRcjS2k/TZVGZaSF9LoTwNx4vr+6fvQAsp4ALjxu7SzYcwug8n4V2YOOXzyRhdQJ8nni
	 g/PDxfIaCWLThmAFHGkeZB3+nEohlR2/TFYqeqEkapWF+rYOu/Lk52VH1szDZg+lIGqk+
	 T/u7kBhTU0HBt7Gzv2ewj/Ay2Laxx0u3DWylpb6p32lgPDCuXa578FeeaJjkdZxVgv0HF
	 6gI98Gz+xwUDYwb5HpOKcbK584Vk2iU1gXKClGR93Akwmaw4xqODKNCSIYG6/b4Tx1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112078;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vYGAHAvMifjzfkrBI85O1q13l3BAF9fl4LmL3f41VpA=;
	b=HdSFDjjtKiPyMaseZH02yx7q0irHxy9BY4MjBtBISOANF2Z6kQitYoR3O1zO4T1yzkDa
	 XYYbp6Keg8EGWAhbyjHL1qM9mWVrEsduVPQ4Ft2rJrdjVbUN9rnUCAPTSfjT8Yct6bpTK
	 ktwgSA5WObiUraMchUpw//uiIcYPt5cDmE0u7gouFj88rVXWSu/NsIcDRGxFEZ4Wou4Gn
	 0h03rRKk7TtDhXjfhPGNfkI1w8v54MZXIOa424PokJQGwbBKLxaPvdol73pCcWA/SaGp/
	 qAidsvFnw39hxUqe1hSy6YfsIk1JOdDAiq6cQJVtNphRlTIzJE8qau40vZ2gkQ9bC4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dwQj1E11;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hisIKUG4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412960A6F48
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7412960A6F48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dwQj1E11;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hisIKUG4
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo1VN3449472
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vYGAHAvMifj
	zfkrBI85O1q13l3BAF9fl4LmL3f41VpA=; b=dwQj1E117HezDmgH///6IxHQuBc
	nBvpwI6a5PVCTCTm5kzLuoxEHJqCw7NBM4/UlI7QVls+bCoqN5QoLwr2EVGFklx4
	tupAGLGHPF4POJI7sRuXfmzW7GRY1b9QZe6+iJEz9FsubkuSv6zVZrM8iX4huzui
	JceW2Ox6hAigPv4kO+VrBuJcXbhKpEqpKNPHUtf/Nv3GngACesgSYumaI4Dw0uO1
	vKkCRDVCckfsXvJUVcsOP1ey1emsnnGVsy/6hWJzsyw+AWLNQQp7hRLUUrfxHp6j
	2cWHL6hV6gJIe6qpSP12Yqz+kYSAhCqDVxoIowsnj611tDqeMwKA3/UYFZg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91b0p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e92aad34aso886565485a.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112077; x=1793716877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYGAHAvMifjzfkrBI85O1q13l3BAF9fl4LmL3f41VpA=;
        b=hisIKUG4AfSzjRRK7J7bvoxZMCIGrZQcosUDba6VEEvxgUkOxbIECn16sbme9bGKY4
         oL1UZHNayybxOUAYkCj/PjMqJRUjQK7/h5snp1CdWxJEvF0M3Fzt1MkaF5mbksMlGjVL
         d6yEkZiwsCoHGytjFEmEfm0m3oTDnr1/ZB5Mp3M3pXSY0Y/rVTz2mDWnWhhAXukdi84E
         COuUnNXyBnwDHLybUOlq6Yt0mmYuU+8BmahSsBwCWyCimsgQ48UgdKcdMPzS0Ko+691s
         4qSYQrOnFl94s2VVouryN9tp+ukLrYG+dEiMscfqIRTnWh0lcuZKUt6XTXiQDqAizPyq
         Q8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112077; x=1793716877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYGAHAvMifjzfkrBI85O1q13l3BAF9fl4LmL3f41VpA=;
        b=rm2hhaekQyymUd7x2kR+pck86gfUw5vGQWSS8RGRBL1YJXQ3QO9Khaqoc1PN3Gtdpx
         v8qysNM/2D4Ih0oUExzc9oKI6c9eK/0Qt0mkhOcx8TCZHlcgQOVNakDVHOqbjwbfHMlF
         +Dyg45KLSqxmabZRcKlCBNzdhiau1DpTtVBr+VIFL5D2dAJOxsEjse5lyF9CpaK3G2+a
         WQdKw+s25MPP953DkeT+ahqyA4aBpiZKAhuam6sRJ64hNmQxrUoZ374wSdbNIyDElbsm
         WYjDxMlndNANKhhBCbRpzZ0aIhaJr4x4LEvZawSeY4+Kv6pgeSv8Y6yH81iaBgXdXtKR
         ReNQ==
X-Gm-Message-State: AFq9FYIjae8riKPe59AkOdr+xxsC3MFSPCjs4mQMgaCWM0x4D1xpMnK9
	iWWUQUQSPwklzObkuwEXmcOapWm30+cy8c5GK2/wu3Ye19vdZedeVG9HsXAhbgIC1C9w6VBRKJx
	75eIn9jfBZnI3wWd78D0gzmVA3A55Bl8AvMYcFvuodDoabk3vUPoUbxP4w/go+H9agp+B4/I=
X-Gm-Gg: AYBFou3bE/IVC7mWrP2tvCEvSwUYxFK+TywL21crBdjxufqUCrpM7WFRTAoFeRSyZrZ
	zEqU6gkK8j9NlRAK0Jaky6Jkfwklea+c7KW+SiX9ia7Gr6hV/U8Mx3wc8sLomj915lmhMy70Cln
	DWNkHjjKWtultvoXgISCK9GkAJs1zlcN6umiM5fnnU0ifeRFUiprCXAYayyMEAI+ZygsN2ltQ9x
	fuNnmLGYu7yU9r5Z4JK8RH5ogpS6zP0/R+dkafVAj2KXcmMORS5+QA/nvK7+zvHXTBtMptWy2W4
	umFRF7ycaBH3loxJ8gcjmeCbwJxNXABccHCHo93bnPjYeF4GKUGk46whqMEtbtiADS7fYG7aKAi
	ZFsUXG+zuvaOHCcgNfEOujHWXVbzFDjLh314HjrC2zi78Cvk+TcrmGhO+dQ==
X-Received: by 2002:a05:620a:1a08:b0:93e:96cb:3083 with SMTP id af79cd13be357-940ef93e368mr1522389285a.33.1793112076524;
        Tue, 27 Oct 2026 07:41:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1a08:b0:93e:96cb:3083 with SMTP id af79cd13be357-940ef93e368mr1522383285a.33.1793112075965;
        Tue, 27 Oct 2026 07:41:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:14 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/6] mmc: core: Add support for resetting an eMMC at system resume
Date: Tue, 27 Oct 2026 15:40:44 +0100
Message-ID: <20261027144051.249211-7-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oQwg2F4EDmEkGgEpmDH2JsF9UMH1Ld6r
X-Proofpoint-GUID: oQwg2F4EDmEkGgEpmDH2JsF9UMH1Ld6r
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0b80d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=aACyBoiUQpo5pDtu5t8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX72a/wFvBd6vT
 EYLs5LZQAlkLwwvSCoE/247rGSqPJHBNtCC3+HHoPW7wOgKORcF522mxyhFbdZ54zMPDSqwc5pT
 CCCi0znOtyR2Pt9AIOezPmTtCpTYRMcxpXGrmGyWPOX3RVCyLSHup3MDCL4iBL0lPfi63YEjl/F
 pYnutkhFEFoXEA1/UhXAXnEXUWIjhrledUX/++bwNJIn3yEbNu9zSVpmhTqt25553lgpxSGt8Dx
 DFC2rEbqyzEOPXDryiAbSoyRadB2tJ7pSBPkPfzM0Mg2bOTkFtsEo7UW+0hy778l4JxBkBmYt7b
 xtx96XKaTx2Uoo2BUGYrsiuBN2mGW7JAToqwFanKRSclr4/Yc5S3CgLCkZder4iQTHVJKIErL5G
 5n8pp4TUVUDJ5YunqICOpKYsTGdZcwvgWZ3t3h48koUBtiNbJktxcQmKajMgeGGLFay2skjNHTz
 TUjjBbePS8WZcyIcMGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX4IXgmmwjbkXB
 Fi87bvoApjoyaehr3yJJncECzFJc0vCs797ilXTH/5wKKhYpNT1JtxAHc3NbCYg/EMeVMKt3IWJ
 WVwkSViOo8JWiUZM1RION5239pFYao8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058

The DT property reset-card-at-resume specifies that we need to make a reset
of an eMMC card at system resume, assuming it also has stayed powered on
during system suspend.

To implement support for this, let's start by parsing for the new DT
property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Based
on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for the
host, to keep the eMMC powered on during system suspend.

Finally, to manage the actual reset during system resume, let's extend
mmc_resume() to support the needed behaviour.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---
 drivers/mmc/core/host.c  | 10 ++++++++++
 drivers/mmc/core/mmc.c   |  5 +++++
 include/linux/mmc/host.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8e9e61839198..e3daf4026cba 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
 	if (host->bus_ops->pre_suspend)
 		return host->bus_ops->pre_suspend(host);
 
+	/*
+	 * If it's required to make a reset of the card at system resume, this
+	 * indirectly also means that we must keep the card powered on during
+	 * system suspend.
+	 */
+	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+		return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
+
 	return 0;
 }
 
@@ -375,6 +383,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (device_property_read_bool(dev, "wakeup-source"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (device_property_read_bool(dev, "reset-card-at-resume"))
+		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
 	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d4bf0f25bd74..908d5cad304b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2315,6 +2315,11 @@ static int mmc_resume(struct mmc_host *host)
 	}
 
 	pm_runtime_enable(&host->card->dev);
+
+	if (mmc_card_keep_power(host) &&
+	    host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+		_mmc_hw_reset(host);
+
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 032c018650e0..552873da7987 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -430,6 +430,7 @@ struct mmc_host {
 	u32			caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_RESET_AT_RESUME (1 << 1)	/* Reset the card at system resume */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
-- 
2.43.0

