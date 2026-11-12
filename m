Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484930;
	b=0Wqft2bl6SpteftA+CKTPnHIuMwXrfQ31CdSwZzwrGcPVB+nEoS+4zg9j2+pRq3s33Qy
	 80gIZvvLMMJUc3G2KiY4ngxS68m6GmQLC5qvCyLJ8gQerYozJXW+eqgsSjGT2/R5ImvEN
	 NwCJr1NO1MhHGnNP6v0FSy5bgK7QBwsY1EmMkjIxf1bcZ2AIfH501q6FMYf2Q2rywMshN
	 k5rCl12D3I9OxuoLgqQ/n1mVV0rFT5EA8v37NPgaUHoxvcwmyMSjsnsjVX2uAGP3J8Li6
	 2oELEDZsa6XE5I+a7i8b+tOxQUOzNZIyQpwARDXDEkXHpwbbGehG6DPyxlXbOsQys+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
	b=En8wUPgMMmrtvPOojqp7jTg7jQs4B3jofnskHrD0Yx9DrAjvAYEQQyf1MI7uaW6lpMsR
	 9kvJj/MhVMuyS6F4FjyTzUAmmw7psKD4X/HGtTNxtlN4LoiXKsNjFDMT/BPcAIO2K2yYf
	 k/p81Ezrvls0MgHiVK0awYCY5PqPXCvQ8kvMuQbenBK3x3Lq1wM2AJviQr6W/iZ9pW2l5
	 eS2KOUl60AXVPxfwrnIAHJCy14SZe/EbJlupFOp9BiqPFAUERdcuA/FAO7FkIWLiCu3kx
	 I0Y6kbbjpK0L3fG4VZDyTzsLk0IrJj2cb/XPHHGvah3Rhc0D8e/4asltFWQ0zBAJbaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fAvN8QWs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="d/Vm8QDn";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464E606A32E
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6464E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fAvN8QWs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d/Vm8QDn
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7iucZ126100
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2ca
	aN7EZPtM=; b=fAvN8QWsmuU63JrxdCgL0qfveB+M6RlA4jwH8ZLIRqOa2zWe2v8
	u8ja870wKN0nbFSKms4No9qzIwO0NQ4Elk+mJlDPRVmc38f0RazxKDxsMUN9fXZE
	yZqH0kTZkJnFMd9l+k6hWZwwG9ro1NDxcRdEzW6hlyf9ChvUxEsJj87iSAkxsJtS
	/eNdgKFGEVp2wRXvQTECYKr961yHNfF/jzcnrPDzINJaLoFEC3s5d8X5dTS0WMtA
	t3tLQp8kWzejHOodWzwFx2eyduZn+IzP0MnTN8Pe/OQ3mgSmNp29GZHCJo4j3Lcr
	KXuu36RRXYiLlldnhb5naaH17MaBNo8A1UQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a08w7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:02:08 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ec3e192929so956677e0c.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794484927; x=1795089727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
        b=d/Vm8QDnZ+t4OJIB8H9UGHjJRI2SoF0pprMESo5cztFhTVH7KHU5IDNcAmU3i9GH2K
         8tR+gWWt8b8RZfWSn2TVS7iOyC3B4TpE7rkO2Z1Qx9U87sQX7OLOxbK5Mc5rHmgzRGzU
         5zzdqlaiO/IfwfV54RsAde6Arj81y7BO+iyTJEoXHNAURCetm85ajHUv7rJNTirBlyfy
         9tgrR3sw6BRHpKHZeiPsgGRmLioWthR7esrhvNiP3//zguMKIG8g01h/WY2xJgSACrsu
         VXOSkV7CUatSOW1m6VgP+iisbqIUueSclCIyQonjwreYpucGoHwHg8JIAxgqwRFvYQ6k
         g9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484927; x=1795089727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuDYEcEDJUR1UK2uaeMHs+3RuDU+1g1i2caaN7EZPtM=;
        b=CkNoEQgNpeaYr38jQQA2PtBEm/h6/dlexDC59IYPUV7VIqdSb/edT0KCsyOdmeewXb
         om43PKGdgVuYqptwDGbBFVYExFFnN0+27WMwEf7uuoY2mQFwOygo73NWlQY/VqC3UjJp
         bvT7UyHax6+X9fE/Rj9Cmi/sAQZISB+wNxgl/iAacH/CByhyiNS7v3ia7aBgn0uzA9x0
         rNXuy8UHnmdZbkJjXLADvmxVURwomsYRfJfmSvtSHFIxCURMXeTT0fDzwvlwK6IzYnL5
         pATcqhuqXuYPn6stf+f2fifddvTRaBgRAyj+edX3kQCb8jTLhka2m6n5I8Cv/XWRef/L
         Hi/g==
X-Forwarded-Encrypted: i=1; AL+hErFxhRS1C00X2eIw3/BF5KBPqokownSvH5QYLiQgnFKWBayRIQmjPNnxZx8JIpQguLh6ktAXFXhfyC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2/tOK6CwyINOa7yWFH9gjJ1TaTl/kaezrTPK3qJu2hjPSVIgT
	c6iOLNg0AONe6pmZIWJZDtfPXsyxnM+08FCj4NQM1F05GyHYWnuHMl6pNQBkAhTydUxAUMFQlJi
	x7fVu+Ov+0a6nYy4CMcKpzt0wOzpx6WGfbv53KKgObllnnBv0EhIR/aHFY90rZpg=
X-Gm-Gg: AYBFou3dhyRQSrsuPtRDvkH5EWDT+ZEdB7Q7I+ivZEcgio1cl5VjCIQmOyeoeefWXG+
	w/I4zUSOVsUkXNgqsDVHh93qLpC9D/u6YdxdLXn3S7VU1bh7Yt9Q6ub4CUOvRkod1ZVkyzuSV8Z
	x9QiMIfoxCzY80FuB7NgK9TrItboqMZBHU84g7dMdOhQArkT6eAcrkBeq6tE3uFvVA/4ObXRomM
	flHzA1rc9njqsKblXmT3499HL/gpdM9Cdx9ZyQGJ6iwoosOeyq9wyZNmsiYWpNkpGupMIX0z8Wv
	cP8ZwUCiq+pI7px+mfAIbB3LG9VHXy9cGpcDBrnliEEOKm5uNoYf0yU5fZ9BxDzBzPS4cqMP7HX
	O+KAEaBrh5dnTodWu312LkjwaQ1IxEb51QCzJC7Ww7YFQ6AkX5W2ybjbUWybcXSkVwDKA/s3f3s
	6H2akUQzIXIw8404Vyc2vYQHroKX8P99VzkZMp0lfyiFHJgxwG+3ixICBx79C0g8Ja
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5ee1c2a6763mr1925860e0c.1.1794484926924;
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id 71dfb90a1353d-5ee1c2a6763mr1925756e0c.1.1794484926192;
        Thu, 12 Nov 2026 04:02:06 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a602b70sm325553366b.49.2026.11.12.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:02:05 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/1] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func companion
Date: Thu, 12 Nov 2026 13:02:03 +0100
Message-ID: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-GUID: N2kZl4HMmkb3FMNucYXs47gvjlFve3PZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX/BWCrUGs0UKW
 Ev7zegCselzsm0qCWOG6GhEaUgVOsVbCDpnESj8y9xEZXsMojFpqfIbAOeqR0qD6JyMJJlEmBZJ
 ITGifmZROVOEB+SWSyJzBiSMlL+HXnsKIKWS21KAmRfm5xRibPq4ogQdWlGjed0ooFOBpie1XYE
 fS1UNNptTdGdSvfJ1UYiMNXUPY9yoVUJQKKS31tJKNEBkBCT/1t6MgcqIuWaZB8kWcUAM58ug0o
 VSMsguYOjccrV1i5mBAiVY3qkMDROFkh+Usz5fV7PCCiLdnbE8E3DOOTC4yKYhTBXehf96UPPJ7
 k0zrFVXYE93tMKst4Ds21ntbGy38+wk2axYmnivqRlUGe9Md0yvVulvB22z1hbmZN7RzJoZGpIM
 UJLFM9rhWeqBnHiz40KVBUDvTwSyXbZkm0Ut3/omyxD2Oz/DNNeGQfNylNtJ9ISadORSfJyXMa2
 mrGmzjPVHk4O5IAIUrg==
X-Proofpoint-ORIG-GUID: N2kZl4HMmkb3FMNucYXs47gvjlFve3PZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NyBTYWx0ZWRfX/rDGfSZcrgH2
 FRggg6O2EGbi5cz6nGGkfkIulruzQKkdfx1yG6Ud96fo7NI2HeELXkSGjcU0uwCMoaWddZhE1g+
 fY5B4/spkz3dc7aHMcfKwYupKV6Na4k=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5aac0 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=XvLEI6pVna3Y4YLx6BYA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120047

Hi All,

Here is v2 of my fix to fix a runtime-pm race for SDIO functions with
an ACPI-companion fwnode. Sorry for taking so long to get v2 out the door.

The race this fixes has become much more likely to get triggered by the new
rtw88-8723bs support replacing the rtl8723bs staging driver in the 7.4-rc#
kernels (by somewhat changing the timing). This old wifi chip is still in
use a lot on (somewhat older) cheap x86 devices. Which now often end up
with non working wifi due to this race.

Assuming there are no further remarks on this version, please queue this
up as a fix for 7.4-rc$ to avois users getting hit by a regression when
they update to 7.4.

Changes in v2:
- Do not clear func->dev's (ACPI) fwnode pointer before calling
  device_del() so that acpi_device_notify_remove() properly removes
  the physical-device links from the ACPI fwnode.

Regards,

Hans


Hans de Goede (1):
  mmc: sdio: Set acpi_device.power.flags.ignore_parent flag on sdio_func
    companion

 drivers/mmc/core/sdio_bus.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.56.0

