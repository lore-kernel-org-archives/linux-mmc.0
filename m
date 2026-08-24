Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB3A1688
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558741; cv=none; b=OxHFJmOxeN1wtqRDyH5yPTppbQCn3IzEkBsOsnvNrrE0pycJfSM9YYGBXU0+AJGWi1ThWoya/ebibYX2Da7cMFpj58VUFYumdiFr13cxpkgVqZV28bdoCW5EWEz7tIhp56XDlqHBnOioCSO2Yz0OXNwuZhyQGJbI1fT/HHFy0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558741; c=relaxed/simple;
	bh=t1Q5l7E2NYA9ruZLWO4AvWE7k4IA7tU8aqEhVm7aL7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk46nSvkFdwQp3sYMbI6hmIwl5nIqmvpF3FUGXsT6K0vl5v8279xTBxTgmw+AqX4Ic5Ti8WeP2FTp8F56pk7VeDIio6V9UH/Ts/SdU7XZOKefNXL2F5Vm6k8mNF0cu/6hW8ySSuekFiwFMJhWmBlZOReN/pJUlbELZMqrM2nUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BJ+irut3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XjTBMApy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJ+irut3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjTBMApy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O6Scga1982475
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HO6pzy8hdqwatnNdzVyG4rmy
	PCjNL3yeag8ExcEKy7g=; b=BJ+irut3ccBgSn9wUrIC8NiLjx7J+5GHz2zCyAfg
	A2OvEI5Q3CevhJ44/P0AC4Jz1rM1QpE6XZjwDbKvDNmxxw9xhTvYbcU8X6gE94Qf
	mWEnUDu5yrN3oKpK9CRiDwIGrUia9s0SZ+vcuw2U6i8w2lvw15RIo6gTG0Tzi+Cr
	+0fb7zkrlJ8tPuedh3pz1nIFcri8F8i8+/2GuiPZ2Vqz+sbqa1jMBNKM1K/Fwn0P
	t9+xZhLQ4K1/iPFGgJwPv0WS2mwX+268KJKgCH15hgXf69o6GlB1U27jAKU8CA5s
	buPRDVD189ykC7yT2EOTNRVO/szpXkxePWJilRKqVFkLog==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn8e24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:05:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d137a68so68509711cf.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 01:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787558738; x=1788163538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HO6pzy8hdqwatnNdzVyG4rmyPCjNL3yeag8ExcEKy7g=;
        b=XjTBMApyb9gtgEJaJh+1p1yvlAsu6RD9Bp66iKklAxeRSgL8lrxCvdfYI+sRtyx+39
         TLthtbfdsltmxtH5oW+MZrruMqnsNY7vUeLfjiNEDL8ykjhsvW0YSqgtL1gMjgdFZgMU
         8MJnt17ShFbhvmgFux+DWRAjwAqwbW6LGZqxqk1VFx9qLLJqRUpg2yzvjyzMPjOWQuYb
         yXkVvrWy4xRmLdizVnx3zPoT64mnR8T2qlR35LoVsAOLwAJzWugz4MH9U3ziEXRaxAnJ
         KBYHnsenGr1+sSuTbF/H8YYRXTYBAwmL81gg1nICRom03DcngM5Ey/Q7Aiuf7v4qmzRX
         lPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558738; x=1788163538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HO6pzy8hdqwatnNdzVyG4rmyPCjNL3yeag8ExcEKy7g=;
        b=XLw19HZ74nKEYdMVmVS3cRYXn4a3cc+Yewt4xGnX7ZRBcTedWy3ob81fzdTUP37yfE
         B0CWoclZISa/ClBUnuIarstWFMYrgSdH3tgJA9rhencRPFyrA3FGQZDPpLJTgLdFoQ2z
         StqLDbHO++n68TVbmXUN5tNvwD+gdFoJ5BfX1PTLp7aLIKiVdouVCPKFjjiHI1yklgPr
         eLW25kyoHk40xhRgTWEu5LjjCN0vY6VRshTWRRQDqwQ1PEx+8BpSHQ/iJIVEScrljRqf
         qi5+eWKZV8YlYUn+Rp2mc4qPMp+RPkMO76U988ZdgE47d+rQBYjZm0sd8QQpV6VilGjb
         z0bA==
X-Forwarded-Encrypted: i=1; AHgh+RqeCHukNuOJ2qDu7RBidJbc3Ii9uK3P/ZTZULZkKNJ3JlV6h/Z1E0el8lO3KvKIbyMNX7b0wYCXWUA=@vger.kernel.org
X-Gm-Message-State: AFuF++kHzZVXOFWQwQQ+u7h0k9PAVVWOEKYzH+o4rignxE7F139FJlgD
	u7/a/cuuLhGeZy47kbochoB2voCpSX0unYlWJNSSn0NRPYAn1JbkaU8/O2TNpfYlIKaG/F4uskD
	z210qBBZJYOATosdGvDKIijRJtUCoEpNY/LgrqmkOicZKcXSW+1C80CNeg0t048s=
X-Gm-Gg: AR+sD10dKBu8YunCz1H8TK3WsviO4PprpNPMkB492ns/0ceotNU3I53B0zLRM44gDJl
	AN58yMgP2l7q+A8lug+34+seqUjhpjc7J+eMFdIgT1iDmM0asDie/rU9riHSHl5Pd7YVjR0yNIi
	wj1sTsCMII/t6+6nWIvFV9op1cCzdNOwEAS1pI2OVa8T8aGj4zvIybnrxNQ4mykOlR5B4uFURp+
	M9HHsTIP4H1NvJbDtNyllswRZcSQScVf5RvZ+4A4f/gaf8DCcgKo/9iWrc+yK1ZXLH/YqLWNbYT
	roOc2ThI4zrD49SCjYIWAxSCSqO/gvVCHJI37XupjSxr2vkV2nst09BjtMI/cQ6fHlmAN9jgB4O
	QL+FoWG7CrOioJHw=
X-Received: by 2002:ac8:7e95:0:b0:52d:9a3f:85bc with SMTP id d75a77b69052e-52e09bea1efmr169365411cf.18.1787558738047;
        Mon, 24 Aug 2026 01:05:38 -0700 (PDT)
X-Received: by 2002:ac8:7e95:0:b0:52d:9a3f:85bc with SMTP id d75a77b69052e-52e09bea1efmr169364541cf.18.1787558736879;
        Mon, 24 Aug 2026 01:05:36 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bd8fasm1739877966b.28.2026.08.24.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:05:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:05:33 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v12 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE SDHC nodes
Message-ID: <snkzt5xwhkm7lueb5vp5bqjr2b7devmh4mnawlbjptl2gcuq6b@khutwr5w2zdn>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-5-09271f583dc6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX2tWCo5wySlhd
 HCg8hZ6GPx6Iu08SupGKeeJwL3IRUju3jkhnP4VG2g95Rev12QnqHjmY+FjP5W3xQZTjQ0gxNb+
 914ITzx8VSpIuSWpcg8eZ07KDTishlY=
X-Proofpoint-GUID: Ik6ZzZkhcQbucPsbvkQpTgtRZiTrrhz5
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8bfb52 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-W0wxAWcNmATYll7EfoA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX8sZs8IZU6bT5
 rWhSdsTeXp/g2MmInqKh/voe7a4ZIMrLMkwotWLii9/zQ0aW8HhqgRN5O8mcHSnQ5eH2uW64X4Q
 flM6s29XeQWQANiJlQgdLOMK1XvaB738jb+C+P2qEEtswOpFwrDB94pblM8LjfyRdNRElM5P00B
 xiawKBAiGVUZajyYyP3LpZTt98/w0sMbXC0ZTEsqh7huzebBsHfZR3yXgoJPTeIp198LxeIrCpZ
 D+deTWyxcNY3NClfw7h0kBVxTteWHHp+WATxWwAvHW8Iu2RLq23O/i6l+W35XsVmLuoWV2zElXx
 ZfZLmN4oksgnm6oq4WkAA95Njdd6vknt5yphzivURSOxYEP5821rv7kpSLXU/2YQjEmlPKCC3Op
 ZxB/SGiX9p0oj3Cei+H4CVoviTrRUxpmYOvsBvE1B4BOhBjwL2VEzkZ0+apcFvjJgyxjhWy6ieo
 hSXPQbqfh2Mee+F5Qgg==
X-Proofpoint-ORIG-GUID: Ik6ZzZkhcQbucPsbvkQpTgtRZiTrrhz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240070

On 26-08-24 01:17:42, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE SDHC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
