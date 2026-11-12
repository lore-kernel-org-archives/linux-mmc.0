Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487474;
	b=N5ggUpZpmk42FQul6O4oFY6OESGQGFxrUOOAOephFGsWTvmMPt7sxhYWbkqBfTh9IuOu
	 XK7P42/Tb3uzcPn/Tw7RgYmJnsxEKhkhxCWTtvSkA2DYavuXB1hYXd2OHATlxfUzq5VDy
	 d1xS65u6bq3Oq7lLUhvLENZr36/haAh0TMFXp4FZJ7/MbMlka+4esldiBcQp1cV6XOuX2
	 3mYTaBTD+TMSWqJiOGSEHnKmuZPl1UmkMaYfi5qFQZVS+KIlvwIjjXc/bQPl3i1rOXEVu
	 aDzUd4YCP8ZGyqIZzZlaJhlQ/HYQb49wdRSN73YCDo86yeBmhsy7Wwc/mQMzu3J9Law==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
	b=DB24MTbJVrPQ9mWOTiylQ/zahdJfpbhTl9+9GcOnuvdyedyxdtkz2nruKro30dpdLYkD
	 3efrKhYFGuDWchduad3CvGfiBjGL4Z4Vf2HMezxKJGbBogfNnp8Unl2Y0W9MMTKIKO72L
	 W8p6pu7hRE5ZFbrGqgbfcm8i1vXIA9rsveOkVM/M1SObFnZAQfuF4Jz2dETGOn27cGIU0
	 Bhug5YSfESjYIX7MCpDK5EDDbzKycamCTa/cT3/t0FjaNeGXYVcqoipsXix4GKdakThBq
	 I/CrKklE3MGJXyPabSy0YJK3Yys0L8PnrcCdJrxGFzKUMQR0xsvUwnVHjPyGttNcpiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xu63Bjmc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLnwTPyA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04D606A321
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A04D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xu63Bjmc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLnwTPyA
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUijH1629373
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0
	uFniqkMA=; b=Xu63BjmcDkpILW3Uw1b/6dHUZkGm34fSN2nYRTGQi80RbkJT+GJ
	7bubcECXLBjIqBbLBI5sXkiQdvft5O9gwGXIJKxajLO7ExMu/+6SdvRB2BTknVX0
	EgOdDjuwsKnpOyWqF5dlqYwU1rCCq5UspOI9SoKrXRWH1dkHJj82FJ8HJXiwzcaJ
	ZwD92P7u8OB0m9Qn74jPrmU40IGu9zhTmy6cHlhsPIw92/gkblabek0LbZCkU1hg
	6xutXcHBxIsj3EkuU86r9GFiBNFXY1rRxipsfXFh3sfZRa3K7l/VAIxZkY1ClTZb
	Cx0UNCZIQQ1GQnzYIWmQbmIimLXLXgrox2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00e66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:44:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so867617485a.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794487472; x=1795092272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
        b=XLnwTPyAwvOQ5EUMVlpPjIrw698sy+C0BXlEvBrwlqKHy5TtUEPyPf7NE5HCxABPLu
         WcTiVQAlhHJp9YszZdSn/VUV4/TmoidFp/+YseuZbiTEyjHutpGUCUU/qoHbUGWRhCSC
         9OscumCwi9Ulaxl3DS8OdQt2MhpN1THxQTXsmD6QejTse9BWFE+BYH7PKgZkitvwjo8q
         30x9RlULI0rvkY8LIzLSJffOMmecDrZ/472I25Y7rNnge8fH8M4ABG29ppluYd7phzI1
         qfs37Pik3KAHaMvEljpc/dQ79ZTjAOrmuAW3LWPVQl4QWchIZQ/2/+CfUhmCChTs0qk9
         cYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487472; x=1795092272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49ZpNrKwE8TqZiyrTrpVNbWlzThPfD/h8h0uFniqkMA=;
        b=tJNZFDDREgMtm2lUHHl3S4LUFOhqd8AjX59QBzlE1BbQg/4GJsBvkBlN1Q+zixd1Hz
         0biO6jVBDnAxE4FQ1vRJqg3zj3cC6jkNI+vClZL46BGXToOAJQkr8sb63r/LBRMdsyjz
         Hke38V3HI+ZHyt44GUHbbupryQ3bufQ3pQA9lUF4WTe17R4uky+Pj2SBUqq4Ew5FQSaK
         7OvgaiceixAYyddCBU3yYp7G58+WwlIxu/p+2VNZZAByht9F9YOyCastm+WYkdKEFMON
         75iHePg9ARPGJI2EzcJiKrirWo9vyq4neWcD2ych/n9pdB3Rkz/E2dwe+snKQm2vys8F
         JCVA==
X-Forwarded-Encrypted: i=1; AL+hErHOAytXbJnZA0NE1wjLf0TfiX37DwEv89FkTjEDZNG2ndTc2FRpFBn+2iKeqOHWtJmafYvRYB2Fibk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UnCkNmCBKRRfHj6DiViAvRXiHxwIGewq1srm3rjPiT57o4fJW
	CLSzwB+3kuGNkqcHnm5O/x1tiaFI6SEdJxXuf4+2ivdKGbAtiZtNSQOl6TTGihS8UwmIxsUf9t8
	sqK3cDag3uw50Pcg75zAOTbfnK1tUPsDPHmn6CRuKkHv1QYIEWyHJ4rrpgzuAE7U=
X-Gm-Gg: AYBFou0mzOknCfz3hvEhsCJ2AFKssCT7jnelnJ0lnfLcMbAOrBuj8XRPZ6kXaPOKero
	3/axYT7El2FxOMzZXEd08/X9aZ4pSsdsoPpvVbpYX4vGDWIsePiNXM8Wz5c84wiLyWyuybgHg52
	vX4LvhPpa2ujqtGHLaenHWu6odChb49nclx4FsjxMyR296VeDTjesU/EbGnvfrXVhi422Em5ifl
	mENjuxx1plSFlmVkv1bwR6xpuzEDDrjAQUFUQ+QiTg5Bow1z0YoFoUP9Iqpxg2TgGr5Jv9wO+S6
	zOboKVOAV2Dh+9dUrT8/OsBzNi+A5Y+Ucizb/nrrFOv3DBmeI3XHeHFEneYTUkBjcSe43zZPvBR
	ajt59wdJH8/uN55kqdG2NmLRzRyUf371cn4sYvJE8fGusV0GmXtxPTdS/f27nZ3DE2BmhlARB91
	rJPvcVRLHrJAt5uSwNHmDn6ahuFMOFvntvBJWTtMy6deVAH2iuKjX8sCI0YlvgXdGI
X-Received: by 2002:a05:620a:a188:10b0:947:b201:fabb with SMTP id af79cd13be357-947b2022ed5mr619972385a.58.1794487472289;
        Thu, 12 Nov 2026 04:44:32 -0800 (PST)
X-Received: by 2002:a05:620a:a188:10b0:947:b201:fabb with SMTP id af79cd13be357-947b2022ed5mr619969585a.58.1794487471766;
        Thu, 12 Nov 2026 04:44:31 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b757823caasm3289147a12.1.2026.11.12.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:44:30 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:44:29 +0100
Message-ID: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX5mqHYczz/Ldp
 pH0DnB7YoTGiUXuuGFvlBZnW4mWzg+IKoFOJGsTo1VX2pAtiZKz+7TuwrlcYqkmtB//lcNVmn7u
 SSLNziFXPwN4LflPsFsxs/ufYpojZABoQQCc4xuG1MpJrPbcPvKMhvItsR1Klkn7ViZmM3ditD6
 2dbn+Bra+N8QhjZHzUTiSaB9nvs4AoDGFOXUGN9P3SvsMCzLhiaN2TXENsL8wb6+0fm3SD4LaYP
 sZD+AIJWnN216mu2vtfj7K347Tn6tnFG8s8uyXKTlWoWWe3UbIAJxwk8JeLfrzzemOn43AWSEn/
 5D5tsBO0Dt0mWOFgTRZMtRXleLLTAnhTNv3WlGGkfgu10lpoBvD2RFzebM5TGFqET/SxCtuHDCe
 KoGfrBKTg4m9sF+HV8xgySyJicbbWJQW6J1bAellvFWi0/QmwUBtaj4cmFykIPJ9CGzpBn/xzkF
 fbbSqFHQ9pKvSCSGTzQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5b4b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=P1vjxsRChtBFIuO1higA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX2WQw+DY0SUbG
 5I574FLO1a+f27t8LkqGh0VJptkhbfsgeYecGqrA8vGik8EFoXRUIPyg83VjO7i8Cvtjf8Elin9
 5+o/jsiuMyQjaSKFZCLOoI1Ckmmjs60=
X-Proofpoint-GUID: mt00RKbKYsU-CNBIz2G3ynPajvvpGN_7
X-Proofpoint-ORIG-GUID: mt00RKbKYsU-CNBIz2G3ynPajvvpGN_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120050

Hi All,

Here is v3 of my fix to fix a runtime-pm race for SDIO functions with
an ACPI-companion fwnode.

The race this fixes has become much more likely to get triggered by the new
rtw88-8723bs support replacing the rtl8723bs staging driver in the 7.4-rc#
kernels (by somewhat changing the timing). This old wifi chip is still in
use a lot on (somewhat older) cheap x86 devices. Which now often end up
with non working wifi due to this race.

Assuming there are no further remarks on this version, please queue this
up as a fix for 7.4-rc$ to avoid users getting hit by a regression when
they update to 7.4.

Changes in v3:
- Drop unnecessary clear on error in sdio_add_func(), sdio_remove_func()
  will get called on errors and do the clear
- Some spelling fixes for the commit message

Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.

Regards,

Hans


Hans de Goede (1):
  mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func
    companion

 drivers/mmc/core/sdio_bus.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.56.0

