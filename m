Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB23921F1
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977646; cv=none; b=Ig1rlo5SuSo6hJ/MpMMKUQXzPAkYJ8jtYlSPcRYF3iAqeVSn8TkZAXYpIzRHXkI7DJUV0BNkYAba3h16p6+KHjnSKGOLbh1chhl5oonTNONwf3o4ZXw01eflGofBbM5ZcJmIUACB+bXQZp/OSwGEmOnAYzUzXwF0+Nq5dZlDyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977646; c=relaxed/simple;
	bh=8qei+cZyradtd50ScPvFXNifDm9xbNX0s48ZSZ8pEik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3M05XuWP6YtlNSD2V/7PNw8Xsb1qDArEIp4OmhEzve3Y8wXaA/gd/jP41Z3d85TWhbuZ002vtEFMCKw54zQbnUkNvt4t+5UckqAmVhbnnczRUAalIc5mraqdNAGcN+smCpJuYgXTCk4U5HQAwnSmFH9mywALHxvwMzRt7AzqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D2Dqq7GO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dXEJYYpy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D2Dqq7GO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXEJYYpy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624iBQm3591072
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 07:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JEalJ388UV7aZKSYSZMD52o4Z6quoMTRP0H
	R3KK1hG0=; b=D2Dqq7GObUQmDZrEuyNcw+sMOoDXzbQCYrE9zdrt1dq0GecKXnj
	YSbZYrfD+zPPHqxOPJHxF4qwVPvA+lXloYjhI3LqnSMTI5pAZmsysYHJNbzEjlmY
	2NsbKSsfPygvPijz00X9DDQAt14QUu8p7bJZpSAMR99HEzciFdh6gtehS1ftHr9Y
	/YnNUwpSs4MKxefx9tkpkwSx7RZrmEy2SyGJCwzLDe6vG/2Nh3YZ4vdFuvqbhIPr
	qYu9lLzpca2ZrubueJBhFWEHBM54cOKDWAqrxwPnZKRTDejstq415gJyQA4ME8cD
	40zQ5U9jVyPFZDJ9mATWf3ekDWEc7Cc/WlA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n8jgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 07:34:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fbdbc4d03so531203a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782977644; x=1783582444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JEalJ388UV7aZKSYSZMD52o4Z6quoMTRP0HR3KK1hG0=;
        b=dXEJYYpy9MiWy3Bulsnyg4d9ZvQt8Sqzqn0qjvx3X1/yVpwQb2Q+xMvDcM3QGn7GKP
         74BkJsFvi+N87nl8k+7kTqDZz0xB/uiKbrs0jrQyliVjDyVHZ6JzFwbJg8AIbTilsMmv
         ZwTVV79Zemn5kJ4YYm2W0dc+KfaPIRTr2ztd3ZeY4LsM+9kaHrkkRkcXtV/Vstfzwk9y
         o1ojKYj3J50f1e4F7lp+Gt4th9rV1BC1j/ImetV1rfNWXp2ZmFpRN2RbQqMZxNRzx1zt
         EIwXX2ZVZhdj2kK5AFBnL4oI/How6SW1LCYZzEKEMk7b+u2SKJ3pLX0Lgm1pg0RuPn5J
         J1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977644; x=1783582444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEalJ388UV7aZKSYSZMD52o4Z6quoMTRP0HR3KK1hG0=;
        b=Ymy39QcNysX0UurjCElVtoQ1a7rztQeQ+t2jfSef/GvcyDC+wRpOyaEUQa3P96XpP1
         8ucKVShNeTh4ohigqkAJo2V+WmkfqyPz0Q3OD7RUp79gN45e9bXMUlioSvmfQzW1+0rA
         BVMRiggKY1AIMdmYhJ6K+M713daAtd5q+LdSgyx5Ih5vqxL9KnEEmBTRwd5k7P2OugEf
         hIpOkhY/8rb9Fp+yGSZ7c/jh8nDvmw/idwGmKpefNX2fgzRnvGM0wtZ2pJogx6lEs2PY
         TOK7N6ruCzKw2flF9D6x1KXA3ZZ5Dj7GA+HWGQXIZiKWYac73xnGjHoSVwMO+t9G/J2m
         XKKg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0kgiFUDSIwUkDFQFz7uuESRgq91zyZrqgaYJ9nwjZe0toMtW4Fw0qV8KWNDo9+mabwFBMtKJsgQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEK1A/w8WlTnQT9L6mNHj9xt6qckSCenJ3aFzNoykJLM3nlFJG
	LuY9/rg0YeHFyZU5e+3fAJEtOYtjW+Vgjg2Fcxiq+6ILH4j0+Y/fZ0cVTaJha3x55ZfJThh8yq7
	hTxgGKA+VEfikjkv8Pl4WT91IaEuOTGX7Za8teMSDqGheW9EApxijgEpe4fw8Ol8=
X-Gm-Gg: AfdE7ck/P6YS3yre8BgKPyhCC/opRskCH03sDi+cu7jx1OTD0wZpTGhvVa7jtO24bKp
	JXeDz7B6iflaDigoTcTJZ00foCgGqyrORGEDRmamMTZGUZBsOvgNzfZcq6twpsDr6zGotMDdd0d
	twrdfvyENGQrWSo0hBip8ALnNra/LxecuMRyUTF9Vqz8g+4pkVpI4wtQthCKVWMKwOM0Z/PdP9M
	wrIrS72CY6awOCtd1Y15ySz2hyigEMXGAvPR/PqFYN/0itDmTCuQfPHvFEon1cDnui49Ip7DTTW
	w1j3P++ouofZYpHs4SU9e6dxzBk01n1BShnkKFwviWFZ3iwVfnNoE1FBOkry/vaaCUuOS7h5uG/
	I+JNW4mcS6dxJ23IVbKfqeDAn34xfmUulLRaANV8UPjEyfg==
X-Received: by 2002:a17:90b:17c2:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-380aa1d5609mr4006133a91.13.1782977643755;
        Thu, 02 Jul 2026 00:34:03 -0700 (PDT)
X-Received: by 2002:a17:90b:17c2:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-380aa1d5609mr4006090a91.13.1782977643055;
        Thu, 02 Jul 2026 00:34:03 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e163211asm587380a91.3.2026.07.02.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:34:02 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V3 0/2] arm64: dts: qcom: Shikra SD Card support
Date: Thu,  2 Jul 2026 13:03:52 +0530
Message-Id: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA3NSBTYWx0ZWRfX1Ro9zkyO8JxW
 MLJeRGXLTasvYK5CfUb/5+VG5e+wenUfz0bame/1ZNy2l55z7yZowh8T0NZ952hXGvVNrGYgZKu
 sssZbN6En0UZ7URy2hJ4V8AZ22S3R+qCuAoKZSTak4YCNlFFUIvEV5Uri5C85erS64RGVtzp/Bp
 3GP0onN+EbA/kwiDiw8P+YUNk53oE/8doHKevwbblyGpd3bs+kx3T7SkBql9kxYad1hGgEMOK0N
 TQeKEcCGdjYijoKJX//U28G97kCjW1lde4+lb8h2nqx0oO1SyuX6FNCSgO83FqXMC4UVGKLnOqL
 JpchCxQUdCMq4SrUCDwZVsl9yBc7xfukZOwV38suhRRoq29fKoqFrVIjB0baYd7JY1ajNGui2yj
 delscEPrrLSBcrtVFfviNoYe0p1Ntq5K1BPh6CxNdBB4pqApP4Nn6Cv8UGzHRbUt364/UKLlJ48
 wtth1RwuRlsmbriabWw==
X-Proofpoint-ORIG-GUID: O78HbRuHM0b6R6RyBnnDexDW9bMJAyXU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA3NSBTYWx0ZWRfX2UVLdXrynrHM
 yE7hy314kcLgqiuK7o/BGt3Sbnfr1DbNX4+A7+hoRch5Dc0EGzbW0VpkJgLqJmZSw7wPha1e6mW
 oFQy4QFvAoTA/xLJjIfqnHjMZ2XhpO4=
X-Proofpoint-GUID: O78HbRuHM0b6R6RyBnnDexDW9bMJAyXU
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46146c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1w3StAHzAm3vCDDRDnYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020075

This is v3 of the Shikra SD Card support series.

This series adds SD card support for the Shikra platform.

The first patch adds the SDHC2 controller node and the necessary pinctrl
configurations to the base Shikra SoC dtsi. The second patch enables 
this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
the regulator supplies and the card detection GPIO.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Changes in v3:
- Padded the address part of the reg property in the sdhc_2 node to
  8 hex digits with leading zeroes for consistency with other nodes
  in the file
- Moved the common sdhc_2 properties to shikra-evk DT file
- Link to v2: https://lore.kernel.org/all/20260630165700.1886608-1-monish.chunara@oss.qualcomm.com

Changes in v2:
- Rectify the alignment for clocks and interconnect properties for SD
  card
- Link to v1: https://lore.kernel.org/all/20260604122045.494712-1-monish.chunara@oss.qualcomm.com

Testing:
- Validated on Shikra EVK variants.  

This series depends on:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-2-6b6cb58db477@oss.qualcomm.com

Monish Chunara (2):
  arm64: dts: qcom: Add SD Card support for Shikra SoC
  arm64: dts: qcom: Enable SD card for Shikra EVK

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 11 +++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts |  9 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 97 +++++++++++++++++++++
 5 files changed, 135 insertions(+)

-- 
2.34.1

