Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871F19CD1B
	for <linux-mmc@vger.kernel.org>; Fri,  6 Feb 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376860; cv=none; b=UD9HvOZD2vDpK+YlI67BdsRGSHEEq1/c72v1+emq/mEAD0dcD7k7Ul4CYAIq9NNUnFXZvIIstS8wTkszNr1rmvWdIaBY24quGC6H5mcRdv9AIcjnNN+FeCjfMxrhK8+EO2V3KnEY4bJVd6rdz6OAPujvWqXjUBKkegmkdqB3BL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376860; c=relaxed/simple;
	bh=8MniwXhoSDBLjxGfPy2piP8bb0OObxLz3gJR92HVQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IeUFF4E4kIoA1UAAxPmUAdMvyNcZyfCFvDXItlb19Wo9bRx2VLmb8ZM+n8XeWWrfVzOyHdq13XhE7UQ2V55VxKkRJF1ENxlrXY2lwxRzuV7sEY2d2Cdz+4PCvt/JkaUyBAZq6LlYaDU4Vc4nRlJz+VCOF3WIymNm4VpPWxCrxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jox9uX6q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHhgh/2f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jox9uX6q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHhgh/2f"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616B2nYB2938835
	for <linux-mmc@vger.kernel.org>; Fri, 6 Feb 2026 11:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7ipg6vDGL0Bln0nZwoVmG/CTwGSHgWXyQ7z
	nW8kSlcU=; b=jox9uX6qxMkFo6JxrOWfEFG1yUWlR3AW2QNeYhFqqyuHUUpQutk
	I27PiZZE3VmHG9KfJjkg8ea1he49ix0qo5ntR7jBD2tb8Lw8ObWL0cSTfA0viCNX
	12/ubSISLvlke/lIx4PlMlKGydr6Pj3j1a94t03u1jQ6vi8rJXWMVvSigmXWLJuF
	yRu63e1UISgL2DfN4hBM4HArBF1D4dUL+imLT58bUFizJxjjVRCKA/YASFRsH3x7
	1cZeGee6dfyM3T8Je+MM2/iSKrJW3I+NwJwuUQ+uOjifLm8pzQYTOpx9oGW40zFc
	e2Zc4LB59OkDM/eDWu/wzFZpmHZqnxclNyA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5f35r1g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 11:20:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f29ae883bso15144045ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 Feb 2026 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770376859; x=1770981659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ipg6vDGL0Bln0nZwoVmG/CTwGSHgWXyQ7znW8kSlcU=;
        b=DHhgh/2fzzVzUXh7B2n/SJrGY5YeFyKUiCDpVZMsKKqiUXUK3WnxjNP4hTFFMOagW8
         XZOVx7383mNM2ALMvetpry4np2q1k5R9+lDGUgzoMq/y9/Q9Y4gjqZdxOE3QyUkLm+Wz
         UVW4/PZAAsRIlxDc8MhWnTnU7VEZDF+Fv0eTBD2ktsk8sJJVZP//Y5iw49PH+F2UMLkG
         8hzhCoQO5vWXm3O0uk1z3RUjVsWbOo76LuOaBG+hAuiSDKYpqS/WS1kIUtToyEJR3rWE
         kwZjyCPiViBW38VUPHJ3FaYXlRBbtZZdddqdfVjCmWL+XZA9jnZQ+bJSFvU/1+Yo8XlB
         G5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770376859; x=1770981659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ipg6vDGL0Bln0nZwoVmG/CTwGSHgWXyQ7znW8kSlcU=;
        b=vlPZY6NE6WRPt3p59ZPPiD0/dPd+g210Ecd8uhyQZ4bxc/8t2qeFTLglNK3LyKKsEU
         CLXoeVJWsYRkQFtqNo/EJ5IU7iJCF7BnG88C0z42uEfOdzW79oa59AgByOqQ+BXOwrbA
         UXxC3vS9BiodRvq9XO3Hk7ioG6K4kKeQfGWW5YUs3LO9tPCTz/fV7Nw/UEk/Y2FKO0/x
         VhN23sVaxtNDcguINV/JCkeFVjToil3MeEjqUus8g5WnWWhMlt6V6rL0p/TFVvpF/yEQ
         gdk7+rZi2Ji2/OW9M2LNX21tQI8wfn9HTNHRrQeXiGzPZhWyOhgsEj5m/IBizA0Yiytb
         kDQQ==
X-Gm-Message-State: AOJu0YzJlxKX6/LnT97CuycK2HgMUn1He30+BE9yhqpIh5tPh6g7BzKu
	IlBWZ4TI3Bf3Fucvqr+KNPYffCmcTk6LvOPrdb1OUye+pafUY+Nz4snBsrWkTjtbLvLMyoivjKW
	oCaJ18ShEDX+rFoeggFJZCMJ1fLjG8kzF7aGKEhuzUOfVZb40MXwwIOAE2mTop2o=
X-Gm-Gg: AZuq6aKWDBtWxYNnzpQxlVtuU3xZYrKK2dff1KSuJBJOOTS6buGgysZCPiCSs7XksCm
	gRff4eUqMYqSjfn/5Ldvx5zbWxphsV2wvjNOkuEE/Ab4WOl/pdUqh0StUFjX1aeqgcTxbGD08S+
	nH0kGRF0xGjzCuhki7kRZfuk9iPYIxJkqwpRRi/g72foGCO5DJMur6LRdx8dCJmANOivMdczTvq
	bjZCKixeneAjUTfYLTx49LdY0iFvBYH1BSvM+ZcXTs6S1ozm1jzooUtUpmR0sigpggVEDjNniAZ
	bxXWl8QoxHpRz/cThJg462byvB0T8g4gtWlMnVzvSeKhCDGVynrJXluNur67rFb/FuBFU5Dhftt
	1+6AfYtUWrKUwCjwHWWkfR9s1ZyCqhckWn8FWj9jp
X-Received: by 2002:a17:903:22d1:b0:2a9:47d0:12c6 with SMTP id d9443c01a7336-2a952026a43mr26042705ad.16.1770376858689;
        Fri, 06 Feb 2026 03:20:58 -0800 (PST)
X-Received: by 2002:a17:903:22d1:b0:2a9:47d0:12c6 with SMTP id d9443c01a7336-2a952026a43mr26042325ad.16.1770376858185;
        Fri, 06 Feb 2026 03:20:58 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50211sm21675905ad.5.2026.02.06.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:20:57 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v3 0/2] Enable Inline crypto engine for kodiak
Date: Fri,  6 Feb 2026 16:50:51 +0530
Message-Id: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BlIkPdMW9SpCwBuSAIYrINk2PNXSjWDG
X-Proofpoint-ORIG-GUID: BlIkPdMW9SpCwBuSAIYrINk2PNXSjWDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3OCBTYWx0ZWRfX8iizzn5PDbOy
 fL/CK3qKDONbSnwC0LNhLKAl6ZCH/H5VjFTZOxVOtZiUK6RhUGW21va/0zyRcH5hTIlEJQL+z6V
 gKw29z+HTbQGowNil05uvlTWXQKXqhhYxEfawYBh2NQ6Jkli3rkBWTnqJcgolrH2//r2pfpZihe
 HVEkBCM1PbiXHNQUsLPUqIpjwEvpM3i97WfHHAuOm4vTFz5Yh0H6s3ynFVruI+KbtIzZWIKk8/0
 WfabAl509nXb1rX/MYYejUI5hq/ne3QDGTcExVPUDPsDs9pKj16W65+hST7XooKnbbq3q5r+BW9
 rLMLRcfUtZ/qqOwYqS1nv5DAq2BSkJBJDmjyT/SFZLZDUOhj2O2o/bYZ99oM+OoQiykuItMyS5F
 A43U27KUYrHv8e5tBN/dOAU3mUxm240PWPPdVUf7AtQulCdhmsyPrZONnlqHv1TKAVd+8EWo3KJ
 4rY9iYOxqqPCeBfxkjg==
X-Authority-Analysis: v=2.4 cv=ApnjHe9P c=1 sm=1 tr=0 ts=6985ce9b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=OaewepulewRRD3_FMPAA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060078

Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
node to enable it for kodiak.

How this patch was tested:
- export ARCH=arm64
- export CROSS_COMPILE=aarch64-linux-gnu-
- make menuconfig
- make defconifg
- make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs

---
Changes in v3:
- Described the purpose for phandle in "description:" for "qcom,ice".
- Re-added the "if: required:" description for "qcom,ice" with proper
  encoding.
- Corrected the uppercase for base address and reg address space for ICE DT node.

Changes in v2:
- Removed the "if: required:" description for "qcom,ice" dt-binding
  as the ICE node is optional.
- Corrected the ICE dt node entry according to the dt-binding description.
- Added test details.

Changes in v1:
- Updated the dt-binding for ICE node.
- Added the dt node for ICE for kodiak.

Neeraj Soni (2):
  dt-bindings: mmc: sdhci-msm: Add ICE phandle
  arm64: dts: qcom: kodiak: enable the inline crypto engine for SDHC

 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 26 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  9 +++++++
 2 files changed, 35 insertions(+)

--
2.34.1

