Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80E4BB27E
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056346; cv=pass; b=qyfDM48KQwI4tM7JN0XcZ8HhczxFpnLvBKDjMtOS2sCYVadPL9KzLN9JhNnkqRnj4Hs6NPRNf3ZePA7yVAb8QofqvuNVv94FY2tbszzx4X7KTFeBazod86lhS7tL0fLdFs9hSil2SaLc0WiFnxxTQrFnDx6xPc/I7kPTTIFaAhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056346; c=relaxed/simple;
	bh=aBy1wp1XDgJgk2FDHwx8cZ27pYMc6ljfdd5t3tcQcWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlMxK0jboUWExvV8OE+gpZabPqVBc7EI4bFpNyFvwY90VUWo2HlWUqLGux2oju2d3p8xbb7LaQqv2rAkrXcUnpiU2Gqmd0EB9yvAR8TgMC88jkoK2B0dmTaHxD5JoUfHSEql3DiYS17P/F+1VF+6XBU8eLe9LkIYb//Pg0PwfBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gd997f9x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UlNXqFhx; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gd997f9x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UlNXqFhx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4QoD792121
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykIn558nnliWxTOhlMDf93gMzJ8uiyjVSOWxZFwsTe4=; b=Gd997f9xtHHwFcNK
	ESk2kaXCnE7PChuTUrYr3RcjIX5qulDIXd4042yQkQPv1PGEwzcf4NA5C2PjqDKA
	VU3c2x4mX1MZps4wbENVRTO7f5e73qqF4n+DcNaPhVVa2yBz8Z3zUTWcaQz2pFX/
	nR7j0xtubkEu1bj7WgORXBC+VyHc4yB+oEcEar016FyeMnDmf0eap5bv0vcfVXKe
	i4bgE3dNGVaRICb7KrQboVxsHlaDfeCBtVBWblzTuqWg45qxwjQgJdlfn5HMeA+/
	kXENZlnTL2OJh2Fu0sVgwWT9PtgfUiqNLmN3+6WTyXVG6hOxx0ZxK9N340jzBB99
	w4MYSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx0qee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d7e0f3b4so3234782a91.3
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056343; cv=none;
        d=google.com; s=arc-20260327;
        b=DR9Wpw5Y9CVIeD+MgQasXtqS0YzOjd5lkrD6ZHgVixBhUPwLUJdeukZe9A2ruYwh0X
         OmLwkkAXneQHvlG/oZT7IARsBsdDEV4+ujYv0XYzzuWnK53MIrS2hxQzir6RB1oz9Ag6
         Tj52F1DkZVCFL993zeGTr8cWB/2Gsr4nzJZwGh7EsmTsG/tUOLvPDxDj1NGcH6hwLjQr
         LFy4qeYwENXcvseaVM5GLwPK+KOhuwt9CK2iFv7KTPP3n6VAnG+vi94ee4JNaKHJ7j9s
         e7A/8OPM1VSSjALwmWXxSb0wrBg7zqcFnHzP11EUef7b3LalyY3MhEO+gjwqHG6UntuN
         R9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykIn558nnliWxTOhlMDf93gMzJ8uiyjVSOWxZFwsTe4=;
        fh=laVNpbaGRHtUDT0ZLXG40+XsMYGTxlwEEFG2DVMnEpQ=;
        b=nbT+qopHirZsaxNeV+X6YPjMA4dR2R5P1qwdMUCgaKxabYricgdMeGCO+bE733f2C8
         FGJCgPZgjSAQVkY5NdzWIZIT9IrBkI+NICThliqRvLm9LJJixUCd9mNXS9KDaNjvMEIv
         C2xGbvabRVZWpKXG6DALqpa0dbTVc2xBaZuV0v5PM1jsiE7SRTwDlTVdEYcD9D/NZ8ic
         3ZjNslQG29Iwy1365IwJx0kHV5uGLHpDZ8X+0MA0vSvP4HUa673L+Y/ZGR7DGS9epbD+
         XWi7qx77NMuFAVKzSIxoa56DidYY6hBAwSxsLrx8iVaus678UFyfj3L9tVQlSqMYvYL0
         vSkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056343; x=1789661143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykIn558nnliWxTOhlMDf93gMzJ8uiyjVSOWxZFwsTe4=;
        b=UlNXqFhxUHKhCqL4fNI3V7Jxr9f/1utmGP5GVMQUxT5DOCvVdAJDcE6iygBEP0AUd2
         2A8Oe0wmcWub7HfgE3hLGN2D9iJQ7UQ5GH7xn0rk3/tVheJylvNV8apmJl6zFN7irIF3
         8DiKcP8efCA41qKvks1e3QbGIMIp0S5uzckn2rggK5bm+Vis28oM3hvUV2dAMEpngETS
         uk/m56K1eYoIH7MUV26MKEPuLbjuZT10SHBXlKHPLjGbP1IZDIbQXMHgielIeaLdlVZE
         cWAyUBrw5UNGkBoSdjFkeM1IM50kdgVMl1UoK5E3n2vj5tVwcThOvAFGPloGHvDkqUAx
         O9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056343; x=1789661143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykIn558nnliWxTOhlMDf93gMzJ8uiyjVSOWxZFwsTe4=;
        b=OKnzcwX5tGbZ0yg7oOuqD9QBhouE26dLJ/ePTRspK/nFLCJiqZRNyvtEvtt1de/p8a
         bKvQ4O0RDEavemg9yV+BZAk1w5fmzEAZGjxdw8KP1paKoLF6A1wAqQHY3Sscxdt5Ko2S
         Gh4PN6SLbVfpG3G+WjgPWKGKBtU47RlBSODUhzn8etOL9K8Q/oFFFd4FeJUrDMJzyhC9
         1DMwE3xh43kQ3BqnlnzTNXrJ1mZPu0UAs8WzX+jilK5NlT3JzcPauUMmUBVOU35n9Cq+
         rQ9yjVJptZQ8AO6hpRHBxDQHNGYJ+4R3sTO3IMs7yC56M41e4GlV2meP3ZfazA4yebQk
         ED+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzLOk1eGiUjRx8s2GTMtvc2B+h+pFO1b3MO4luWoEt6jKNMMmpXngKjR8QYCBgaq8St8dQjlNqFCtc=@vger.kernel.org
X-Gm-Message-State: AFuF++ll/ZODaHs4I6kD4XNOtPq0lfZbzFdSL9an0dU12v7IIxhfvbvh
	RChGIhJChamddtDw4ZoiINqcJQWWZ0alSkldYHsGc+0sbyYzSzXNPNbODeoqBZh/PfM5pxuaurq
	HyxtJ4TuP4MqJgJP0F+HKXJ48+NphDGpuK5TJkyupid4JUzrU0F+u+ynNwIQBDz/8IVMDUuEQzT
	7ZHZ0GpZk0UVddrgmsfvS6m3h3jRD/DK+AEyjlgA==
X-Gm-Gg: AYBFou1tqaerb5QKnrT/+UFDX+nlOf4zYqeRIHBhkiDcC0JSZakmw2ctwhFPS+Wcrwq
	KdpFuZBax0GD44PCNBuH9XLEY5nY000aofNm9ejPdjO0fKM7jEv71QwrtAq7oM8/vazrbCJWiKu
	Z04lYdKFp+a72zuzoI1Q/ff4Af5sunvUvPH4HU0yz+JHISQJdzrHF4Z/K0Sg==
X-Received: by 2002:a17:90a:e18c:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39d709e6ec9mr13852683a91.1.1789056342593;
        Thu, 10 Sep 2026 09:05:42 -0700 (PDT)
X-Received: by 2002:a17:90a:e18c:b0:398:c16e:69d3 with SMTP id
 98e67ed59e1d1-39d709e6ec9mr13852578a91.1.1789056341947; Thu, 10 Sep 2026
 09:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825083702.3931016-1-nitin.rawat@oss.qualcomm.com>
In-Reply-To: <20260825083702.3931016-1-nitin.rawat@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:31 +0200
X-Gm-Features: AcwNN1WvbHnGQHe_mStODRAHYsWnHQkMBnMABj4Ua6z5LYWNHvR9yk0WKmoWbIw
Message-ID: <CAPx+jO-mQ_zFdpUGZR5FJYNdJuJ6EUyRU3-uO5zmTPdjH+S3+g@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Maili compatible
To: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, ulfh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX+SkKZ3pVuX13
 9L48fJClYNHztMs4a9OVhy0xTvYap9ZYSGXHo1Gz0mItNvJEvBB0TsX+5gk72mWydAjSyOBC0Vc
 hDdKu+DjeG+cnvwh/GNUKTdwxp6sqgdlx16eBtPzzdRopmSG8JZ3UD4ueu83XnXFgSG9qYkqgfA
 5xUkOdI5E58YzHAUTYnbO5VEwNg1sqg1dmu76OR2URrYjH5nSqGq8u4ApW4cC0/ekw8fGQhr20H
 Tw1z3WtOALs6EIeYCz87GGmtN2U0O7cObvmCiOnxx7JHv+GuDuSpq0tYMQ9HgPkFJvk18E1yq5C
 c/2Lgf01b5kfUMk3wRnBVcwZutB7cku9xiCBDp3S8NIAjqwT5Wib5hTG+yo/aq0uBE+ie8IXl3I
 A7o0+UFEdZxbz0nrM9ooenmMuPxMTNEjWHVKMXJGq1xIszQ7mBKolBHdEf8tYkKmx0d7fUx8+qP
 jW+0LgzS9byyamoqh8g==
X-Proofpoint-ORIG-GUID: zWAsQP5NW5CmVr48UdSKYIOHO2VXhwYO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX5S5jW4XciBYe
 RUUrUfX9ieyR+P1F0N6JJmrlMHMIip8ODcrAvtxxKHCiEDfUwOGUEukAYCl4Ipla6Any+o47YWb
 OdvRdhctJJlcVJ38bTbM5oK46Z1FsvE=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa2d557 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=bLxP500Z3OXyVcFfUPAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: zWAsQP5NW5CmVr48UdSKYIOHO2VXhwYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Tue, Aug 25, 2026 at 10:37=E2=80=AFAM Nitin Rawat
<nitin.rawat@oss.qualcomm.com> wrote:
>
> Document the compatible for SDHCI on Qualcomm Maili SoC.
>
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> --
> Changes from V1:
> 1. Added Reviewed-by tag from Jingyi Wang
> --
>  Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml b/=
Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> index b3fcc1673c10..69bd44e65ad7 100644
> --- a/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
> @@ -47,6 +47,7 @@ properties:
>                - qcom,ipq9574-sdhci
>                - qcom,ipq9650-sdhci
>                - qcom,kaanapali-sdhci
> +              - qcom,maili-sdhci
>                - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
> --
> 2.34.1
>
