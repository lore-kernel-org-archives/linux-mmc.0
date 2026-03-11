Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6E3C65FC
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222400; cv=none; b=Npt5h/ReSmq8/psUS0iGcJ6LvGTWXvqKjvUUXG5kGZhfjsSCPgBr+i6kuNZh0etZT5d+/iGSIsLwPPwOv16v0JGdxHaLtBhnLoABAwJbu/RqkH85JSTEsmRGrT2tSnKUg3DzPieR6YmH4Rm6OC6dRK/JmWiAIqSIYPR65fQ8kKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222400; c=relaxed/simple;
	bh=D4FTk1Dc6ZZyZyyYwyYFZQ/PqkaMYdH1kar/R97d2u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwwr3sR/N24DCUoy72UjgT9peseQVH0HML3LxvjabcHl5EHRnGwD6XOECu1dCmqxt0TrEFntBVBgzLZgeOWkg4gO2/cjaWvYWBXkbFB6UGtZnL7/V0TJ08ROKcf1qWKN2yafrL5d/I0hPtySjUgOg5tlKNQ1Win32kG/DsE5xZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LE0H3ja4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SFcskoXQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LE0H3ja4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFcskoXQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9jKiH248344
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n9S9Oesm5sQiwmkIMcRlV+iU3KxqxzSjhKdwL2L+zBI=; b=LE0H3ja4bH0H7vP0
	r4EAfLW0IdOHoNjJ1P7XcijpEqt9reMhI+unoAXLpZ6rIvWAlDlSRBjBwBKcgKaP
	MPiJGzbXdiU6Xw8akUzRAtkMNAu6orcCop9zEp937juBCN2ziFbiEKWZDjmxe9vv
	KtnMu3T5xXbxmodeRMfZ3iajiK6lLEhqY0V6VOUweaD546MLjzWDZepcQ3wKHrRD
	BYKopEBYyxv6DrupXAwqSOZzVAS2TUXlL6KmXlyFDqLNmdGO8JCR8UQ37zA9HnX3
	Oq2LvTStn7NSC6/udCYRsZEEBF4230pPVj0LsMX9HEIOjDISFLhEmb1L35u84UF4
	O8Mvnw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv12vve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829b20cc6faso736010b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773222394; x=1773827194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9S9Oesm5sQiwmkIMcRlV+iU3KxqxzSjhKdwL2L+zBI=;
        b=SFcskoXQ5gQhG1wCAWLkQD5t7VDk1Nl2x73HpJwrFAl+aM4XfBTWDkIMTMh/cReyuY
         yGCNLFBT1CcrXuVthyxPsgS5AQGAVVX/+Wc0SUEMWauBWCsfb+wS79GEn4zjsF57TagU
         QEjFfyrgddC1ZyTG0ctQYRWesTVTiKKupv92BXpP0M6Gip+zBa8XVjgwX7zp4+hc8riG
         2Ahk3a7e5k2r3mdqGPU7t6sfQx3XqSuz61rykLbibVjfQmldxxT+zL8/Do8mnvjjdGIv
         c25+PO+AM8JdSZ0eD/hsCgvKXq+Rmlpbpbu4kVHsaboU7GSc4F5ss2PpSrb0Hjy3keDM
         DD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222394; x=1773827194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9S9Oesm5sQiwmkIMcRlV+iU3KxqxzSjhKdwL2L+zBI=;
        b=IFJ3vPjnDbeGwd/p0nztyHuKXQLEFPvk19sEPKZtnq9orEjrkU8PmGRMtIViQW8Ypu
         lottkoIhcwr46xmQ6Q3urZGfDPLInBfURocXI/SN3ycUBQqyfIlZ+oR41NRM3ffl/DtP
         iDtuvntpEozAyI1gp6QwHyufiYsdQv0dyA61HSf6GleR7Ps77ZnnEUa3iT8etk+FPYup
         f8BBlguPfG++y0C0/xjXdgocNXbT+CRKABH6N5mMCuYgU55uiBb+sB3eXe3amUaxIU8C
         0vH62IuvrXyb995MrD/dZNzHRiIxdtSzdM7Kreu3cMh6dIBH7feDglBVKoqFUZSsUpem
         6TIg==
X-Forwarded-Encrypted: i=1; AJvYcCWzOs7WvVJ+C2bC1Miqp8WYBMocmm1+Zd9SFcQAkRUBYPlXLuT6WC7H0eqiZzmE+42HOdPo5CfYkLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfp2xYlC2q2Kw++GxLcrbak4TMBIX3ecfKdtV4dBGdBDZ/7/tp
	XSrDQeYlTKMPwhA1d+kaIHytAG0ROdg2bs0YUgoHeNSMmOeZ30NDcjHlkuam+X7oP/iyPOGB7le
	r4DuTCaPJD6UXUSLhse6t2OG2yEIWsz4euMZVuEzKmCrZbocmXOeTo49LgSekt04=
X-Gm-Gg: ATEYQzxe33KwGG/B1gBLBF5oHDw1vA0QzY6eWUXJQWNIhnclTpnMbdjWQ5LWlk6XkDT
	S+ojYOuOO2mt55Pe6cfq38bmuADhYLNeTFbnYJFQBjkcg1VtR5s/FomCOOBojTwD0EEvFCcIKrx
	XYBcaBWjjVUEgrihVXU7PiFv50Usx5mDr8blyYnoNIIDCQx5Khk1iTaUPNmxgAdtak/rrAjmoiZ
	Xd8c7EezzLkWzHjmVsZUXchMQUQvydENsBUM+MgkpVy7xC69+QdoJnQRnmtLQgJ/17hzsddDKUG
	67A/y7VCmVqe0aN4mOAi2acHuoPbFf9IFGjhVOheNSfM9HKqfkvQYOgFOIgm/yL+ApaPoVj9Rw/
	xqOqJ5cIpGc1vkomE4SGeCqDopODio1cvSIKTFMDIfYZPhPVy4kqrxQE0rskELHQFiocQ/7EkgB
	okZRljZvhu94plKE44TKuSYyf1Q9VWnaQnVxpXxZ3SFp8gZkKD9KvE6Rg9
X-Received: by 2002:a05:6a00:1a90:b0:823:1bc7:ffd8 with SMTP id d2e1a72fcca58-829f79ae018mr1595230b3a.9.1773222394450;
        Wed, 11 Mar 2026 02:46:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a90:b0:823:1bc7:ffd8 with SMTP id d2e1a72fcca58-829f79ae018mr1595212b3a.9.1773222393938;
        Wed, 11 Mar 2026 02:46:33 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df5ff0sm1677403b3a.21.2026.03.11.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:46:33 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:15:49 +0530
Subject: [PATCH 7/9] dt-bindings: firmware: qcom,scm: Document ipq5210 SCM
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-ipq5210_boot_to_shell-v1-7-fe857d68d698@oss.qualcomm.com>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773222347; l=853;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=D4FTk1Dc6ZZyZyyYwyYFZQ/PqkaMYdH1kar/R97d2u4=;
 b=QebNZs3WsL0Br+pxni1jb4Njj6XELEcpcYhGX9Et/T0vK8D0o74pZoru2uSLhEMn4P/UNRjyH
 Tl5Cm9eQ2N6BlxfEbn/07H5Pgwe4vWrVxtfvJdL7WsgBmazFGCDi55Q
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MSBTYWx0ZWRfX3GvfZu3yYpKA
 j0kNSmrRkm4Xb9cJlxAJHEp2kujJBgh/O+RaFYyXz2PFZJn85TZU+xqSKIyHqTk0b93w/zgMjAs
 KM345lpIjlHc1lyhD9emdbcty3PQXD6Th+m9DQpBpTQUJWuIXugjyowAcjkGc5V8I4Va8wBusbo
 rT/I4akjCQmGU+CkpCYYx1yoFL56on0Bzr5mN5b/xBkL1A5Q0CVe0Xmn7cwaa4Uc5vXG1BtvltB
 4cY1WEV/0Gd/xMpM3DrycPIgU+CrMZHjfTHr4a9+feJ6p7FKGSnCaXC3sGNezHYze01MzlZqxUF
 z7aFZ1huP6hA/I7BUrBR5HcH1FThIP7RqYMLP59u1emLdjEcmvMyte0ro08OTKPcJ017BqpWL3c
 sdLQEbRgLf2WW5r7rD7hGEYwSt1ZYUkdrTGyfp2qqTyvBTmVWu9t9YL34gm5Iy0Rz+m7KZbuqzq
 MduQSw27ia2tpkk8PpQ==
X-Proofpoint-GUID: 8_2a-Fa7V8QWplEF4tZ1hseX-5Ho3PkU
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b139fb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ND75c01xaBhBG1K22twA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 8_2a-Fa7V8QWplEF4tZ1hseX-5Ho3PkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110081

Document the scm compatible for ipq5210 SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index d66459f1d84e4d99c7f72415d08bfdaf1d701948..6d9b71a9b9b3fefd1951b963f34942243aa48ccb 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,scm-glymur
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
+          - qcom,scm-ipq5210
           - qcom,scm-ipq5332
           - qcom,scm-ipq5424
           - qcom,scm-ipq6018

-- 
2.34.1

