Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523192;
	b=J9K4Mtdg24IvO/uo/xDANmmuseMVxiAKdHHyolwrULjjDcnv7U6wrDPbJpHQHxqqd2p2
	 Hdh2IghIZdgjNTNlOBfIBDC5TDJ2BaPe+dY2Y5mfZABZMlrU7vkL3D0N0zIJyIdF9Xp2k
	 5ORVmTHtGNpsxyBg+noDrmTUGvKHVS5/Evwk4XYwGoS62MMBY88cTJt41hnIASVF3yjfH
	 0vKdbAWZMMbN6sc5DtjzIf+NDgG90pTl2UIuWEopeSyUB7s6cVMVIrLGNxxtJMfrHuhOY
	 Et9yqrSNtY3TFol9cJpHJAvQR8xLTB6CzVWJeK8RyhzYGBDRz5Vt3ZxHYoW3C9RkKJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523192;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d0jw8JKgv0n0ezdqZ8dsYLNGQSrLdfYWJ7gZlA49lV0=;
	b=idsM9wUGihSkdorM/iOYR72Fyxs5eoRiP+HHnqwhXBQqtlM56OEHvOrtk7K13zqdROAB
	 vIp12WyStf7wHoBZV03OG3Rf/CLt0BcX7wavRhHl8QIqJit/CPATTLw84ViOzKyE1ve7T
	 ux1mXeSBZSr+F8olYxa8tg+DcWAmldwicMTuBICGhQtd5RuoZwsKIkMmB5x7msXj2csO6
	 gY7DKM65vEo2nBQhPbw/9YWiu6BKalw1nAox3QXPCo5fYcu2wRMvWAEoMn3tWZq2p3z8z
	 dQimcZIQzYrqTNncZeyBDqYNe0FoUMgiz2XCgqm7ez3rt1weuRO3M+JKNIBhzEqrN3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V63K56ZY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fj+43oaQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C99606A33E
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C99606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V63K56ZY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fj+43oaQ
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJZgQE2266659
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d0jw8JKgv0n0ezdqZ8dsYLNGQSrLdfYWJ7gZlA49lV0=; b=V63K56ZYhmMmzVzi
	Abvhos0ZhgGq878N66gbiQpvGPsraM5OnL7XP2Qof7LnhO78uTu1exsRapupGRDp
	hMh+Pm/TmhoVmH75rLbqRM+1QJ7PgEs4TWHDY8YslJUW27q4NZNPfes2ZyMQFcWm
	eQdIHslArBMU08yLQUmBmodWUZ30+ah4iOYQp2F90dSK1e/zPAbgX5p8DNBcT1mW
	daqj9GY2wl4o7r0LxHzvNXHNFdHahSPt+wtmp9o3gve3KFMi/gZzLJ+k2lKU7mzv
	lRN+J79LnAsL7YpkNnGDuSps4S6VeNBZ+jV1OgzDabUoqPteaYQBT3zqnFMHS8Rm
	Zzpzgw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc3jng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:51 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1af203073e0so215194c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794523191; x=1795127991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0jw8JKgv0n0ezdqZ8dsYLNGQSrLdfYWJ7gZlA49lV0=;
        b=fj+43oaQb7W17VghbCtiaJXL6dS3HCupr2yoW0NgM4Vyos/XAZ8QLRD0+BQzivJC1Q
         MT+M1Pk40l1v29lvp6bEoPQc+NLmjchyODP/g75H90zAw+1/IoEht1eveBWhcuXJiNXx
         NixaxkG5edH5wjNmFEsyPp3T9AzbvU5HnLkYlpEaFFfHjwxQWPqzr/5mCvMPrudGNzwT
         Rdwr3QFhXz0uei539IIpqGybtzXauQLIyLuGEEadZRrbtl4gcWBV0TY7U8COKWjC05kl
         PLMxEo0V1n1abVUmLyr4dPqIgsXmwe2ya1wG9pgeMifPxfgZgzO3LpRRWL2fPJYL84uY
         RZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523191; x=1795127991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0jw8JKgv0n0ezdqZ8dsYLNGQSrLdfYWJ7gZlA49lV0=;
        b=ccGjgWPxbAmYLv7IJPXsth137s3mQ3HhkgZqBj6xb7a4NwwmqVcESjfhSdC9AmTunA
         15mzqFRDjZVKsW2wE+Uk3s/Pe3ANVYn+Wo6q6y9AbuhcH74VMqKG2Vhsx4Mb3YSEflkR
         2tkzkI5tJHM5RrA3xaDncuKfh+Ni6MglDahn12CKkAo+jER06DAy5ci5Mq/hJ2eqkJ9M
         wyI2RT1RoDF+SJLDymV9L0xlhr23Xm3hfa1Y4KL3umqw1Dp5Tg12DqQLUnkLPPoVrYO+
         xAXo6d4Ls4UJazTRgvtH//dhGQFiwVN3BIB4ASJHVdHFzB0ohbyM8WVMzRZzczWvaJDi
         RM2g==
X-Forwarded-Encrypted: i=1; AL+hErFqR6NlsLfQcHQaofkQ1F0GYtm2z6X9Xyc0vJPqyJduJseNqE18CaDU49z9t6+XyVkiXI3ab3+fGLE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MEPntkDt4oSAzX8XM+WvwiMbNv6eySExNSdcPMPWBJMWyebrb
	DHkmwquduIJnfBCbOZAQMOoJ3wamrgfmMmLMslxY7iaJb7Awy7VoqsSZEtXvDfIl8EJavzdSS76
	KXaGSma00u9BpZUP6o35UcOTSk7j5AxJMmP62SOr/pt1If88Bxs1R/DSVoLOe4bY=
X-Gm-Gg: AYBFou21VKrYTQ8jym7rHH5/0h7HMRe8Us6VO9g/cfj2srEq+H/IgDvMtzR44v/dBXs
	obk2oFLhqTA5haNoqvcU8En/DRACL/VUfZIz1bdGMh+I1wViO9Hk0ZVaGWoiKjBGlXaOp/FBDn5
	34SLCtcJGlG5wPTcc2Pz1TTWbUxuxDw+FESaQ/xusI9x5BQwtfz96141D9REtJgTrH+pyqFHdBp
	0Axi0iduIDG19zsQ3RWVf3lMM725MgQYESslgBPKR6BAnOADKKUQa3eY09e4jSI++U/lu6V+D1j
	ynpKKG/nj2JhxTH76u3/N7lRqrsgPYn6jRr08RFpoYJ5yJT6pfieebpu/ZSlu3r23I3qSwxcZ3V
	3jQYDriHhfefAmZAD2WJPwPdKPwW9uFrmcXJ4osV59PJFq7usj3FA2u3lPO8EznSXA9b8kKY6Ct
	UcaRpf33iEDQ==
X-Received: by 2002:a05:701b:2050:10b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5031247b2mr877020c88.30.1794523191081;
        Thu, 12 Nov 2026 14:39:51 -0800 (PST)
X-Received: by 2002:a05:701b:2050:10b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5031247b2mr876999c88.30.1794523190428;
        Thu, 12 Nov 2026 14:39:50 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm2333496c88.5.2026.11.12.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:39:50 -0800 (PST)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 04:08:32 +0530
Subject: [PATCH v13 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-enable-ice-clock-scaling-v13-6-258dc817bd63@oss.qualcomm.com>
References: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
In-Reply-To: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: G5xAsdDq8326Te-fHRVrr3KKxrmTJ7jl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfXxzKfeXAiiwky
 VA4owvsocy1XA1u0gYgY/u6an0i3pqjteZP4h5Ge+QcNgdgrQo1T3thgfby7FEv+kg/AsMFknA3
 2G4SOm901Z8RLkq9UKC20iRNji3Z//w=
X-Proofpoint-GUID: G5xAsdDq8326Te-fHRVrr3KKxrmTJ7jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfXw4hv4Qlhn3YI
 g8VVI3tlhYDURwhxylMkfFSIHw9YVV+MWW5dejUEO9ZZtdjq8CHz1usxfYY26j9dfnk/ykuFq42
 Pl9Czd1Dg1H5Xvt6KLWD50O+VyU5tZjZwuyeFxdugxB4s5uQTf+F3ViZeVZVr/r7+ZVMeqQTWiz
 EqWG/OVVOrW++Vee8fwsGWXVwawuTUaBYNEM9FGftBNo36DZzIStcQ5OHhNSYbLlKsTZ6hxbdbq
 zHdIT6rIJmQWj55s6hNiwk/nR5Ava99H7c/t0ocvOddWSG6iQGhYy5mXZBaskVpn4sYlF8UDzH7
 KL7GlGVXlhqJV3rUsAFfASRNoMG3phLhjlMqq+8IqEblfaAqycy3LSRaBAAgMipCDuk9wVbCsU0
 vukYVEnm35mtMrukoN+rwYNynCfJafDToTYuUnkGTpVj2q9vV3wtwATQ8HurqL9MmJGPk+o2PUL
 RpNhEvLd8KuRwKj6ujw==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af64037 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ASeq7m8wwX9lxpDCPrQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120090

Qualcomm Inline Crypto Engine (ICE) platform driver now supports
an optional OPP-table.

Add OPP-table for ICE UFS device nodes for LeMans platform.

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-embedded.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
index 0be39bb9de1e1cdbb7d67a992172861a5a10a05a..a80fd8f96427488c20205c5ad798413aeb53964b 100644
--- a/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-embedded.dtsi
@@ -1840,6 +1840,32 @@ ice: crypto@1d88000 {
 		clock-names = "core",
 			      "iface";
 		power-domains = <&gcc UFS_PHY_GDSC>;
+
+		operating-points-v2 = <&ice_opp_table>;
+
+		ice_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-75000000 {
+				opp-hz = /bits/ 64 <75000000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-150000000 {
+				opp-hz = /bits/ 64 <150000000>;
+				required-opps = <&rpmhpd_opp_svs_l1>;
+			};
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				required-opps = <&rpmhpd_opp_nom>;
+			};
+		};
 	};
 
 	lpass_ag_noc: interconnect@3c40000 {

-- 
2.34.1

