Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F273FDBFD
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065916; cv=pass; b=MRPIg28ZbDuBbtIaD4rQwve2jmYizdirQnN+IXe0r5LqNzRWjNgvKjp+qcCBIUBpsBdZjel0NC8cnL+rvOXhUOnGPTQrWL5WOd5rzcLFWDrsGBd4yt45Yfhw4DyU7Y+wiAMnNIIIxmcRX9hWwiAvbnyXJ+DXHVumrWuBLw+CYKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065916; c=relaxed/simple;
	bh=qwqyWFzyrKSsAMxm847WHgVkmw/h391bpXABnCjyxKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1IE2VcvcRADKRWJuauyEK3O9hVwBR5prMBU4y3uSbiRhgcaabz2DtPVDYOwK6/qmUpp7JfmnXoGl/D9zjlGOyub+dSkXR5Gyvna9EOD+sK/q8q2jG7/D9i2bVuVFB/XGXbn2CtjCkfUYEZiOiaM8fs1VXvFH9EXrKXIxGJjwi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMH+hrEo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NIoE68nq; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMH+hrEo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NIoE68nq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLCUT3656511
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jE9Zz9T7wgCExWwAR+zGHwf+mAaLpOUd64uRWuDMeyU=; b=WMH+hrEo35BWyQs+
	LqP0wu5Ho2MRbY4FKeDiMxhuTffs7RvhVFedC1bDwNopVqHKMvF8Ln/7EsEHCGgm
	dZvMOOCvfwXBrZbhwvzoqC0+zjYQjJRvSPEvjz88b9W7w4WmtAiglYdJNIxlhCiK
	kKI0xuJAObwnVjrcIpVdfBz7WWARcYyE7I/JooTQmKk2uxYQHWh7UXBoRME69xHi
	BnwRJrHCgvlejjRy7XkLi9ME8rGnQtNHHGjj8Rhveo+BMLYWe21JlooLI+0AP7fT
	LDr+MUDsllGR3MYdF0m56l8sHaQzeR0CmSokGOTbq7KK391TR1XbgMBj8UQsUW02
	y4nNoA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5vqm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90fd6eeed3cso2999804885a.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065912; cv=none;
        d=google.com; s=arc-20240605;
        b=AWLQ9K6sqWxDe4J+R2Dk1vcNYltLCjgoYU8Pu5V569CM9zEDJ+TX7OiWBxRpDYpNm8
         LomUqVBaqJvVcxaTNTPnXTdczLQuBoCywXPufFFuwyiPigItfkRZNYetAAfwzPBv3jtC
         8+6hKweNrsr6sp0L5TVe3V5tjTLp4i89htnPcUKkejF4Btop24yE87Mdh7z8tZPG0T7X
         F3zBHllRnMIA69ik97YDe5lr+Cj+rNo4ECoSeUYq2E0bNP26P+iTVRSsbjC0janyYmZ4
         7KBdrgsBOf8uCYwJwX/dxi215LjAXImBVqc+Qpx7TMhjr2CzgIQqgwdHMI6U/vUFNHsU
         UKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jE9Zz9T7wgCExWwAR+zGHwf+mAaLpOUd64uRWuDMeyU=;
        fh=l0d01Fkhv45K/Y+/CBeC4JSxUblbOe1C2Qcw9LB8jTI=;
        b=ASdcJZ8uXZlcE0LDNxSAG0ZoW36/lBAuKiZ+cFb0Hd4XrLhPrJycDkVAmZyqA6uY7a
         +My+oegFMVr9NA9zfmHWhEkTG16gVRcLzyN0e2Im+Z748wfKjqCTv+CiegBRq9WHWHyM
         FydXCfeI/2vciO3SapqucJCwNfwVHJ/wGNb3Z1a5P7dGHGYbhXXApzjXsw9OQpbpZUII
         +jGOJGBNwsIM5OFxTeiW98NewEcaVBjOWxAYNnStf4e7CnGEv9HtBZ2zQJ2/PUFaJbjE
         hn+jIMdJHHxRNN9BDgjunKI4qlX5TJbDZKdqNgrzL7ssLBrtlgU1Y38Fk+HOsVyFatrO
         0eng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065912; x=1780670712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE9Zz9T7wgCExWwAR+zGHwf+mAaLpOUd64uRWuDMeyU=;
        b=NIoE68nqwsorOsrMPvMccu+IxEpDAQLSpP6IzVg/7PSyPwtLq4U7q0Q4jIB9m6weHf
         WU8gd+KLvcn2LTieE0gEwj6CrQ2WdijQXblBGW2tEjQCSf4Yo8l4vCvg1dN6FdAXcVxi
         VqwXyXLZKOFvAyBQlgfVO5KEPhJTOHMk1KzzktS303IsFd8ixtHoz4eN+zf2jdxwrlVL
         yXhIdLR0/Pzo6RRrowBbzyerJZpM942Ir94RPEUCAPP4i44574yQiSRCjdVUtglvfmaI
         gwINrejYVWvuWeUqmT9jsxzxxSi3IwA+oGqQ5NqCXJspITncL2PrxtGM313hgT5NpgC5
         UCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065912; x=1780670712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jE9Zz9T7wgCExWwAR+zGHwf+mAaLpOUd64uRWuDMeyU=;
        b=ReoNw42vFK7tCtsktpw92r8B9o1RLRn9XHLSuoTqqXXVmVX7VJzzitvPSEeQICpQtH
         M4Qa8hO0U93QzuC0g6udu2jSJpkR1+z8ztn9BxN+735bKC2zvCz07mSzs/a5tSpnHDnX
         ya1JX2RN+vCh67th+H/mwntK/46HhHzP7dJr4KIq/RHUVp6/z9jPQn/rELWGPqT87MzO
         w7zmg9Rx8WJRAkITIdGIWWNvAY4kI1M7E/qtBcRAWHiNZJ/qATNxMdhyrEGloAo94K65
         vnykWmD8q626vNOCkdAINrcSDb3KGDQfSL/VBUvqoBdnU9MEXHEAbTXK3Qtba+QaRgxB
         oopA==
X-Forwarded-Encrypted: i=1; AFNElJ95Yj8ztN7Em+s09RoYjGOi/mCnl81dySGv0r0YyG/YolSq3g6Numo5h4XdMD1yjCGMxopTf/xOcwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRSY3BSwphLkqnZscJFPAoTqeBJYf9Uzks+ipjsiDPYm8loW+
	8TwipCF4z+f7pvbRM1MRSjWiavDiQopuKjls/mxTjT8JArheseZ9dD96SUCsD2OO5LLnqomk1BJ
	eDJYGYT4v9EjSKA+p5spIa8Iy5kR9nHRw0yvJV7r2b2fc1etktqA+CwMJDJsfpDgWlxF9glX9cv
	ISZxpqZQlz2UADnEHWNgxD21KQAOicmazzc0pBQA==
X-Gm-Gg: Acq92OGw2UpmSfeAx4lSSWoyCl0AAJ7RAh1joYAAw7RcShcPn3vaYIJZ02KhN9tx9f/
	/OJiE6QAQBI1L+xASC9eghK58AkAomGw1HPAJBskwpO5mnHttUoitHRUv+DEYL5VQELBmWnghVz
	4O62U9BzRsFKmfnya9lfyF4JbMP9NmR8KyYkw7of89UeuriEjLDVlBW+lG9NfesFcnn4XTOwkla
	ULrUGuAMoYYmnKIVg==
X-Received: by 2002:a05:620a:288f:b0:8f4:3895:25d3 with SMTP id af79cd13be357-9152fcd2f71mr442073085a.9.1780065911598;
        Fri, 29 May 2026 07:45:11 -0700 (PDT)
X-Received: by 2002:a05:620a:288f:b0:8f4:3895:25d3 with SMTP id
 af79cd13be357-9152fcd2f71mr442061785a.9.1780065911009; Fri, 29 May 2026
 07:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508101544.736317-1-monish.chunara@oss.qualcomm.com>
In-Reply-To: <20260508101544.736317-1-monish.chunara@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:00 +0200
X-Gm-Features: AVHnY4IkHBliNmi9XTq75zovqnSbNzkMdJ4usBjxx1RC2vXH9sWm-QJsbkmXUfw
Message-ID: <CAPx+jO9QyFWpqRC+W_aBnAedgnNGxyvAZnY+hkkymoSvwaavuQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Shikra compatible
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Hs58657YvmY7Rh1vXkGtf04HiGfMSiP4
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19a678 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=M5uxQS6IaA7ZX0B99K4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Hs58657YvmY7Rh1vXkGtf04HiGfMSiP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX4NX33atyZyfF
 mQUA+a/9MpEkw69gBM0VXnpvgGZLPaSjejKKGM2HbdZnN24ydVSWAtYu4Ig1vkyGF+qOj5hDhx2
 x82TcBJHH/27Z9G+/FAOVJrb6bf9gNQL6RwfFAossIz2zRc6noWoOQYkBSposz021sIEHxgDF5E
 nMOVf7QVjGfZe1Jx4yG6cobs2ogIlRZf8MHvK9tQ46+8jIavh7BdzmHFJcHE2TgZK2A4tghH7ju
 clNNkk7iyimEwx49zvFQXoMZjaCVImqjq7prX+wy3Sy0IFqapd0C3PMnj/c6k5Mh2+nTSlSjA/O
 H+POynaQjoDiKyUFQA4HVPxbekNZxg5RBqMMcURD8sPmqAH0fD0PpAbk+RRfUxh2WsJo48TUobD
 xBhAdOhLlUNHnlq5xzX3nHTA62N5oFomJqigQow5HFfRq2Xijsb6w2EFzbPEATjcZOlDB6sb3CI
 uZI+zxcmqD+MTKVS4Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290147

On Fri, May 8, 2026 at 12:15=E2=80=AFPM Monish Chunara
<monish.chunara@oss.qualcomm.com> wrote:
>
> Document the Shikra-specific SDHCI compatible in the sdhci-msm binding.
> Use "qcom,sdhci-msm-v5" as the fallback compatible for the MSM SDHCI v5
> controller used on Shikra.
>
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 695a95e8f35d..60dc6b0caa21 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -62,6 +62,7 @@ properties:
>                - qcom,sdx55-sdhci
>                - qcom,sdx65-sdhci
>                - qcom,sdx75-sdhci
> +              - qcom,shikra-sdhci
>                - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
> --
> 2.34.1
