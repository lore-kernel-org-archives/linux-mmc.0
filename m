Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112069;
	b=PfrPX5FsSWaSMMtpehEBoifeJko4AKDl4RhOs4o5J5dG+SEkEN4kWN5aoIdNuS3f/VqO
	 Z23aULQdfMH3MG1787rsJ0rxpj3PhqxsFv60EVtFOKVUpwBODaViQg+lKnVeQR+N6E6EQ
	 1nN49RA03NwncHsYGdoVvMVmXRRZasH1wuLG7dEgIH9dnDpcksKmB/2OE91Ij7V7ZXffs
	 D8xhJoHZFGgJYlt1yw0296GhAasAxgOdcxV2xjsnImLQKNCFHuGlYF14/FF4h4Lw026Y1
	 AZ/2OHg3ftzMu7i4lHhc39M5ri89c3IDD5La5+MxvgpIzCfTuFIEP9DUub2mMh3Rg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112069;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rkwojZsyZMs6xnXWVxQkKwahjcOTdkxi+tMztfsICyk=;
	b=u1k/HpsuLiFkFv2LiNPF5noFdINkB/iBJYQnbdj/+39cPEtp6yXww8bVmI1Nt3s1jfHy
	 Fmg9Rn+kf/E0ZyfFXujES7pVksRN2UwSiUzF2/BY+8upTlBb9ZQswMaL2RESHQxHEvZQ3
	 tyisQsrSBLCVSxKnDXyYJahFIkh10UjRcbdnd9JZZfnZI9JjiFmHC+pg2ABiSp1XAtlWt
	 l/mT31+XafNU6UO/KfvLm9+HDtIjtrhyAv+2p8D3uPMHsf1VwcBFgNolqW+jTftyQuxLU
	 /khEYuzviYhEwyTreRW3jlNAllNLVBq4+1F5zby95sbc/Bzu7LlJuwREtu1ipHO7QEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LAg4eR8+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LAkWmWRU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2B60A3801
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BF2B60A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LAg4eR8+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LAkWmWRU
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoDYm1316466
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rkwojZsyZMs
	6xnXWVxQkKwahjcOTdkxi+tMztfsICyk=; b=LAg4eR8+0cibYIyjdvg3jg8V4PA
	+bVoOpUgIfetdiK1YHHJCL4cZxoyZn3W26T4iJ8SncdWfmTqItijEWwJZTWcq/50
	7UIQjtYVoD+JyeA40HtKC60qq4L8MvEdUyn1aw3+iGpn/dvE4peQnGL0m/yCZrOM
	y/YT2oxf7aeWRtk6tMsW2ycekQ4Dt9H46qlXB2a/cqwemVfashxXX5IbbQvN+Zrx
	N536uxTzuO3Ho9fz97zukFqKH2iI/lpcZ/CE/X7LUwzft4y5wl5Czne2tGRreJj1
	0Ke3MHdRkViFjvQUzLMj7+Tq4OU5I3286T8WnBTBpOvYHMt6w2U34p5WGEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98k5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so699216985a.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112067; x=1793716867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkwojZsyZMs6xnXWVxQkKwahjcOTdkxi+tMztfsICyk=;
        b=LAkWmWRUK8xfpaQEJwtEmdAWDR5jHN64R4a/XySNk2Onhp6Ds5bIMNQ2nURGIztf8s
         e2elncUCkFiu4XvzB3uISi3QFbjH+i99nayLffx1TQyvQ2oUniIYeidf0u9OGqeV/nBk
         WBu61TmM7AzRh53MOj7oy1/ewt1F6gc7SER6UIzqf6Vx3QbCGj6EpDwHDKjQ3mF1SFf2
         td87W7I/KbCW2FW4cFS54z6QufqebPZ/GCPkyTEiHa7K9H0uZLnArPiKSFaH2fJy8vDY
         amjfUt0kOC0XEJbTsJnToZ5NGJEhkhlZKPORi7AExz78vRMQ8qb3KESDRpcEM61kTgwW
         f+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112067; x=1793716867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkwojZsyZMs6xnXWVxQkKwahjcOTdkxi+tMztfsICyk=;
        b=C9m6OuNqF4GBC8kn98bd4AThgh+3Ns702NT6WNzaCxsbPSkJS6/EwWURb1OsLmSCPw
         99BqAD1Gn6Jz/AgDoBv+0ZiNV8z1UvTCBBF/XYIKfj69NXECe2f1cisdvlmthPsEXDqt
         ubN6p98eDasPIHGhjICC0UWG356BBVqElL4sk0nbTvL2Q+LEC3zjM4ZOOQUxVphCgmhQ
         PE3iv+gAjo7nTPoebQFDQDW6wKR2xaPBDe10kq5oDjnaiedfoOt1s8R3vBZxIfRE1WlH
         /kQyYGz7rjewDmadGeZJcJrDiTkQw7vOPkXNRHcMjd85QiSwoQCpOvmwaoj3FvE/n0tw
         TdUg==
X-Gm-Message-State: AFq9FYJKiUzHt8cb6JeqJvZDhVzxgiwyMLryoKfCTpFBtW/R2+HKOXAq
	Pqyx18iqefHh2Y0/EiXVzKUXJ82/9pgHw/UpfwyE6JRWNwaBI/bwn7U1uQGrgSEO/Pvmr2boqPP
	zgw7lco5Md6LAgJkG2hRIkfjNcnAagi4eZv6U234DS8e9B29cB+j8mPy4E/dcwYxY/WMKDe8=
X-Gm-Gg: AYBFou3A8rQbrUGF/HWYWZXcnjzzH7QYzkKntuDfNNpjcKEWH0xCdnUdJFKaiTJQPAu
	IfcMVzlB/XDZ86yWG9U7cobSyIVQ9sZJMARl8LKodnzdKV3wxv/SdWuYl0NtrW1S8dddaZWi0NN
	oAvrHURZV2Rnjd4HlBU27IOhZy16gvqmojt/vJX9pTW91aa3zq77s2K9qctaafuOukQZe6AFitP
	p1qCQnE/Tzyzcka8fKwLnHeCAOn7dXxTqpsaNzFh+GFqD9deC1w/M75N9JkjRnz2TzjMJTsL+a3
	Zc5aNiRA7AJcLf2EAw3XWWCnEnl7/O+SThGcG3G80oZLZekUoolD/1oixFt7W6hJxLsfnNY/5Yr
	Ij8Q5qCaayQXPcCT1V9HwoRMvWPgxiJXh1rZZp1//kCx2MFuRGmU4WmbH2A==
X-Received: by 2002:a05:620a:8702:20b0:940:f224:5a57 with SMTP id af79cd13be357-940f2245c64mr1061355885a.62.1793112067288;
        Tue, 27 Oct 2026 07:41:07 -0700 (PDT)
X-Received: by 2002:a05:620a:8702:20b0:940:f224:5a57 with SMTP id af79cd13be357-940f2245c64mr1061353985a.62.1793112066783;
        Tue, 27 Oct 2026 07:41:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 2/6] dt-bindings: mmc: Add reset-card-at-resume property
Date: Tue, 27 Oct 2026 15:40:40 +0100
Message-ID: <20261027144051.249211-3-ulf.hansson@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0b804 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=Q-fNiiVtAAAA:8
 a=EUspDBNiAAAA:8 a=b1zTPemSR4zJYqohF9EA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: JuNxoLKk-EBg-TSG6eKh_u1S_ayYcQxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX2rRbqBz496yB
 1nUON9lqELcgZb6TFYCXYWtonlmaX4V4hPRwyCt/LSZ55DKnMvvkhYZ/b15YB1BlRSYtYIAa0HA
 yA/YdrONHS+7ObXsZWXZeefWBZZwN4jHq4SwL2qiakdPor1ahnugJMRmPEIVZ/M08U9ryEh5OxJ
 iCKiJRzy6c30H7lHTVeWvT/AuRNlKz353SxUbDUS8Qn7+7bfH11ogdtqGO95NCjuBNdN9I5Kd9o
 IbojItVNpEiOlKkzh8JxHVl3zycCzBu31udgwZPJtFLy5lC53KQekIjU+O64G7eWnujFjPcRHH3
 i5XknHXhJQeiG2hN3v8zhx55Bam3YvTe2z85sADfOy+8RyCiF7Kgums/4IALDPhD6oYKaUyjxpm
 ydIO+ZKuwlTbNOnNWu5K63Uss30bXwus6HbhjUOcd9XpZxoMgY2rXdG7/uE3q0v04Ez4KTzIZIt
 JdYPKP74Zgbv/ZHE5Ig==
X-Proofpoint-GUID: JuNxoLKk-EBg-TSG6eKh_u1S_ayYcQxU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX+IMwempa28PS
 nYkgxnK7Fy5rZIjh9QzX1PTaDKoM7lxc2ycmbO9TzWULXBLC465hn/dNguDfrCnEovIViOe32QR
 d/GmnVHoyQgQ2jN4fQUxM4RxMVZMRwk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058

From: Kamal Dasu <kamal.dasu@broadcom.com>

On some platforms, firmware or other hardware accesses the card
during suspend/resume, before the kernel's own resume path has run,
leaving the card in a state the kernel can no longer assume it knows.
Add a flag property so such boards can tell the mmc core the card
needs to be reset before it can be used again.

This is expected to be paired with keep-power-in-suspend on boards
whose firmware needs the card to stay powered and live throughout
suspend: since the card is never power-cycled, nothing else would
force it back to a known state on resume.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 2fc8e06d5ec9..c824b95f2ae2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -303,6 +303,13 @@ properties:
     description:
       Preserves card power during a suspend/resume cycle.
 
+  reset-card-at-resume:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The HW/FW may have accessed the card during suspend/resume,
+      leaving it in an unknown state. Hence, before the card can be
+      used, it must be reset.
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -371,5 +378,6 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  reset-card-at-resume: [ keep-power-in-suspend ]
 
 additionalProperties: true
-- 
2.43.0

