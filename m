Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5C2EE276
	for <linux-mmc@vger.kernel.org>; Mon,  8 Sep 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319633; cv=none; b=sqqlZsY6Q2GaOKM5el/JV+SiW9nGdXDZ9BhkY4Q17YrZRwlZXPN5QJ3bhN++P90FTh4gZ51xuIZB8gBYAYv5/Unl4ZlBmW4k9KiytCqi3pkwvttzuyeG5wz0a9LL9gYR8FQYt6B4nmAboGp5AZHi1hlkF7y0jIYiG48GHsMUIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319633; c=relaxed/simple;
	bh=ud3TuPggLahDGChDQ1o7XXbj4HVsLOYi90l9y4PcyNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDhdFzJtypH2sYbxtAj9QHrZLYhUeAZI7Jj4/pj78Fl0nf03eZ6evuCVptHeaG8nVqsz2jP2bYRkP2D8wpmgXqsdSgEPSV/8Q50OWRbXUudGAt8k7d1ztKoeTEjinLV+844reWjSuTvgqEZXy+uDffHml8KF+eU0X3ylvHBqs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=See+D8Ax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="See+D8Ax"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587I887S002547
	for <linux-mmc@vger.kernel.org>; Mon, 8 Sep 2025 08:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=; b=See+D8AxF84ZaO7f
	VjLUDEfJwHPDwXoWn7kbdFH6yNWdgY7uBKAYMRKR/5giDJ7Hh02DnxtR0AFadNH7
	mz5og+gmKz/p0xruK63mZ+yhzZOmT7OCOuOzwODv7xxUHPgbcjuv6z7Df1cyApQ/
	njq5sUJP8tC+aY8K/oT1DYmXPZyrJyItgMF72IPzM/N9K2+guC65Q85+T2V+uIC2
	omzJZpL96xJaruQfltqUT2zX0bPhK8r0rJP1UyMRGSOaNYjl+BR1WVXc7U8IQZEn
	pt66e7ySgCaYUB6fLMvF9hPKhWkNpCUqFUYb3k2ujmjK3nBmQpeKSwnf1loA16L/
	vQSpmg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ktc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 08:20:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581953b8so46328555ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2025 01:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319630; x=1757924430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=;
        b=klxddVRo+Mjs4Ut4f8zbnq+eHgMPjWR70wfKPn52foyQ8+PJuy31Vz4AEtCBDnmhv/
         GIO+vfL4pwjaDTGCzJoYLBSXqZL0bymlpl7Sc5tAJy9iuHaILx6QnAohjOp5uL1mNNMa
         5a4cy0eH+I3WrkzEbPQEhlDcL0JGC+0IipbQNtSHz014pbdThQ3nGuFLE4R+dJuRhxwx
         a/n8NM6PghmdzTXhS7OwCrT50Xz6trEu3gbmmqF9z3grUWighYB5BFgFmTPUZCh0qP2S
         Dir2vdv5O0LWgW1y3UG+Qu/ock7yyU4kD3BCmGSiQqU5By7x72jvPS4nb8iITIOX7B1j
         iAbw==
X-Forwarded-Encrypted: i=1; AJvYcCVGCt6N6+sT3cxwBsAe9fOJe1TGJPytW9u1usrUCPdOk8jUM8GEp7J64eu+eKn+53JEc5QYWDAhf0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjTcRlSQKHqlrHXfaCkO6n/hk8ujJaKXnDYAYCxulxVkqJHNx
	d+qnpavdhz7MpTu28fzY70OVNNp3Oe8acTDCh2hYXGTX7k1sOMgCDxG35jqc+lL8aYPWlws9Io+
	xt8wFTK8TzPEppne0DVCl+uD4Vt9vOTvxQwh8CMcdM5FKqrp4mpp+z0rf2dTSiNM=
X-Gm-Gg: ASbGnctGy4GsEBRD5Hit4A1jhuqqqSK+E4SdwvIwVuHPM/MS3JXW6GvIASGkFgHDhb1
	6oik9lRJYr/R5KeO61oLVc4ZFHO0hHq318k5movxyrIwEhkJ2J6yRVysjISrGkCwnakJResCXeC
	AZMoYn8K5f/qGIcfpAZEnwF9q8H1LoVi0udeDOsk6rZcTRc/5S1cOmYOLjADlK5/NxQVtwIW4XB
	XecUZnkzOL+o2KkzZi2ZA9f4FZZ/AtqwDPue00X43Ozti31EhozI4JuoMjM+5mmU9e+bjPG/e7U
	iXKJjCYIP1cO16uI7NkdKOxnuFtODZZioXOPN4Wg9EABgB6mPUKFZ/HPYd0jtXsjXmfv
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106344075ad.12.1757319630230;
        Mon, 08 Sep 2025 01:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2+Pn3pFEGWPMZXwcqWfe38DfVXT0Rgjw4TxXRkh6HKMpHekVGqpZgUJunuzabHm2j/OvPg==
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106343655ad.12.1757319629581;
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:54 +0530
Subject: [PATCH v4 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-4-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1307;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=jewA1ZuLrE/ryGMwa1gffJep1WWzoOZkukzHH7TucfM=;
 b=i9UWS6iq/NvrnGVeENKuHD5pzIRUYthJoB6yM1Eyw7sVIHrJwjlTu8pkSBmTCXd9ZbMx/WCOa
 JV0jF+D6AGnDzZ94UZQCW6n+UQmZrlDbSo4PlLz3htX5eUNiirnba07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: A74GIlpst-mVokONt_YCJYmqmfyOuFaH
X-Proofpoint-GUID: A74GIlpst-mVokONt_YCJYmqmfyOuFaH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX4xEyfapPufYI
 DyCY031HXv7R59gToZv5s5vRFa+F8AbGfxWAPqLKtg+KgksRJ3qtI0lSVx/U+32md/d8ZTvKngE
 oLNMKVcZ4HNJ/3q7xOjT0DGInnSg2P4+KKwoo7dcYCUYe/PvjYsdzF2R7k4umGAdms1Rd82E8Fi
 KSbNtH8aLCW/Z1MkCtsvPn7PiHn+4VK8pYhdVSEa9GMFTLmPXCZa4h2MFC9/xBZY/gbZzBagCa5
 KiQe2BhcFtlevYy9YO9du1NZ6vjrdPQfZ+SDCP317Npy8ImONMAceUJh/6qjyGSy+udm8scdrVd
 29bdythM5CSmurf04XOnQx/TAL//4SVxAclRrpuPx+e6oxSDIj9zKjjHr6M02sNCqbUnwUUaq/K
 7gzYGR7l
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be91cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=itmwO_cg3X_j9a1xKB8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 56aaad39bb59..c48cb4267b72 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -289,6 +289,38 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		reg = <0x38>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		reg = <0x39>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		reg = <0x3a>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		reg = <0x3b>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0

