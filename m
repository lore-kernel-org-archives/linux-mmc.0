Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65B2931F5
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558501; cv=none; b=eA9YbuqlTCymI46nmiFidI92W/jYFHm1zOYxG4BJHJb2whiYW9tEKLwkn0aILKRZJ9zL6PdFKKjMbdbKFj/+VJx6xGl2geq9Wh5Mj3XMt4qf0kR1btZD56kDyCHpQ6SimNdWGOHvi9q5gRBJJF/zqdgj56r50ofqfTtqw6IH29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558501; c=relaxed/simple;
	bh=vP7KFRuxv5/PvNudwnrv8A7AdwTbutFf3LNghXEf8Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSWE+DzL577JyCO/9jUhyJ026qVBUugdHKZ8eIjiMp57TKo1lM9HgqIngCyK529fVyJDl2+job8yBDWqv9oDIbZadoLI1WtTsZ1JOfax3hPHQ4TKWWwfwNqk58nij5T5Slb/JmolPlnKq65VxRvqxY6IAfTrCypYD2CUjlmGCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQWswynp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JNcHvlr+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQWswynp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JNcHvlr+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RBtb2058202
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ukMn0O890BjOQtEZhd0gOFgJ
	Vu4vFO2RS+3Y7jP/DNA=; b=eQWswynp7awzOnk+lg3cTUgKBINakVAZYttmSMUt
	v5m7b4ljZwERwWvwgY/xuaqkz3W1YmGlUAFfajCkZYqeYBKVHVa/e5ABoFN5SMoN
	yxS3WpI4viKvcGwqP8WB4HKOhYKAxGprYK6I5lmt/OSwgCQFaj2w+rF4YzW8Lu58
	hncuzdWkMrMbK2S7DXluKW/B/HTa4LkR6VPEfAGqUoxl4sVmFq+kvtjG5h2mD0ms
	l56HNY3vHVMkiqZmEcmTkf4dKs0JTx61zgY9aEiqhW0RIjZt44Ja5tKxdu/H1trS
	b5c/9Y1vDZowrMdQkHwu2iXgPUn8utBZHy29DpYp7+bdZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr1awu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:01:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5276aa86d00so34774911cf.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787558497; x=1788163297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ukMn0O890BjOQtEZhd0gOFgJVu4vFO2RS+3Y7jP/DNA=;
        b=JNcHvlr+OidnTVBZk2211x/yQ8XXRvWs1CClMbAvVVJGfkrZhMWPhNkBx+hETr3e83
         qYfMLwds5weQN67J9XuPbHYPBGSW3mUL02DRWfMe8pJdTG4Y39VAnsNfR9dVjurg0Kdd
         izLPxM6oI9WmjvdLezNBv7gP6ihV1Gs7TeMkXh/XNMZ+w4ItBHf4Q9oT6+JPnGS0UndG
         lHzwD3JuKgZhDGYMHDHKpx5EE+2vxmUc/k4byJMUAnfDvuMIY89Is5yIezWQwu/8a5AS
         KVVrzynXNS26YCf3s/WEGfdUufpIg72PJVzO0fo5BPrHXWcQ2aQJzQy3zuFdAzQgyRph
         5bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558497; x=1788163297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukMn0O890BjOQtEZhd0gOFgJVu4vFO2RS+3Y7jP/DNA=;
        b=iZLSXFRcJLJpOl0x+oXdF/7YQA+KLHZ0dkSBOoAyqIreUUh3059osUrA/bo4QKUjon
         o3z4ud526sTXglakc4AXEalAGAO5GCjpZxKEaq1jLDoku07ySzvzqwvcx/ruUMlc5Noy
         zkc++91NRsjpmnEKpghogo/mIDIhEQa1B3LcAgw5nf5PBGG3Bglfs3uAnE7/s0rlBgTc
         UBFhC0CId2AiFJ8kqyLG78cWJdCyNFQy2mAi9hdqRLffXyqYET0BcJteq2mLAD4URPI4
         dDulNiC3/TT0dYWqFOItyFi/AbqL/bQXgU7kLqX+wNsN3+Hxl8n0Jqq6Z2YV5wbvn2do
         6MTA==
X-Forwarded-Encrypted: i=1; AHgh+RrUSPPoxEfhAwWlqi/XNnnE6UKJslhB+pirpLs+uBIougSM+KA6Y1lUXYjG3nFIvNFtW7wUjOBCZ84=@vger.kernel.org
X-Gm-Message-State: AFuF++lsh39cut4zUoNQi50VpMGJ3+Z328mzKOJVyxsB/ZHysdZcT/iI
	iMNYwodLPyQNP0hn5Cy+BrtGjRxidlQWuWQWFAD1GthaExqv1EJMCfIi45a1lJBf3Z6Zt/NcwPa
	uNCCNKclwWYnZtCM8oegn6a1S7+Jf+4ry43tDXZWRdpcOhMxvOvYDsUxvg94UNS4=
X-Gm-Gg: AR+sD11IF56lz+1zG4lIZTAkJ3hQQ+1va6Mx8nwQekns+ovoAWGNkMru58s9mRYLOuP
	HrwNA/Byt24wfui8oKcjjvbcrbpRoywXEwvz/+AXAr5ksavdpzSu9Ob38cLDQf3OyecsCbE9Zfa
	k29R6VhR02udT1uckZYDZShjZa4EfW6awg7jidDInT9TnYPe6CWiiaZjQBlW1RQKZq7G+Mo1CqS
	JDW5aF+xe5FN6Xwv1RGjJhICg4hmuOZZTyxN8bTfXsozofqDJb7gvRi2I3x3rWexbCBxG67Tjv6
	jrwGOXmBWtTFHBE+bZ6nHMea2VoRbX+qAKSVzPh10JymEJSfCraB3bas5oBKjidTJ65EmPaSFKN
	ie10C3QSB8VHQq/s=
X-Received: by 2002:a05:622a:4c0c:b0:51a:8c79:a2d with SMTP id d75a77b69052e-52df56e5052mr252526931cf.1.1787558497451;
        Mon, 24 Aug 2026 01:01:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0c:b0:51a:8c79:a2d with SMTP id d75a77b69052e-52df56e5052mr252526211cf.1.1787558496975;
        Mon, 24 Aug 2026 01:01:36 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bd8fasm1736480866b.28.2026.08.24.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:01:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:01:32 +0300
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
Subject: Re: [PATCH v12 2/6] ufs: host: Add ICE clock scaling during UFS
 clock changes
Message-ID: <v7mmy3emjbeorjy7zfrbgqmozu37whvisidk5uba4o5jeqq5t2@ntjncu6bywtx>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
 <20260824-enable-ice-clock-scaling-v12-2-09271f583dc6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-2-09271f583dc6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX+/FmIS8Y50Co
 WZpDzdtvGiDjP3yZpb9o1QcsR+y1mkOUqMSSCT+l2YB75QG+m0/i6KCK0hW+UZocFp9EysVn/BE
 47RiQdAyZT7CIfTE6vC/1n8/k+QnDx+WSHdNJ92mNCsrV7zsIdIhyeKqtCxRK22nCZN3aXl+eYY
 LMtC73d7kfA1jFAb4C7XaMaZlNAT6x86IKerMHvvNfvlIOqPz7wfzuSawvLs7uXLVZj5bAeWUyV
 yvUubWspeb4MbnNKTVWOG5Dx6M1ZHNhVUzVxKwdzvEgbqT5kZdo3Dv9DazX3YsEaNYMQhcNSq4y
 fPUPpTb4p91ViKJ/IVzDJQswT/bLsiqwSiyOShGXxf2VoSUj2qwVeryyqOV1unPDJnTHPersD6e
 zUYYCN54in1ax3ngv4QRmFOwy2LgtWX5HxI/V80jFlqHZstyFXLU2Fwm/uHDDCNlykRnatW4/lS
 5N6kNJgV/EcBgjYVxXA==
X-Proofpoint-GUID: l2i-zNhvXZbcYvlm6ou6_TbvtvRfwN51
X-Proofpoint-ORIG-GUID: l2i-zNhvXZbcYvlm6ou6_TbvtvRfwN51
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MCBTYWx0ZWRfX+5GIdXVbkLU2
 4jC65Hq8WPOppJegsA7S8YsKrNO5qGD1I+ikXyk9VcRJQU+uG0wxneIPmosoq6s+bLCch/Nqbw/
 0OTzD8vNEETcRA6QssTWGAw98XX7plk=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8bfa62 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yPCof4ZbAAAA:8 a=8RJfRLJrmUUAMqN4eEsA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240070

On 26-08-24 01:17:39, Abhinaba Rakshit wrote:
> Implement ICE (Inline Crypto Engine) clock scaling in sync with
> UFS controller clock scaling. This ensures that the ICE operates at
> an appropriate frequency when the UFS clocks are scaled up or down,
> improving performance and maintaining stability for crypto operations.
> 
> For scale_up operation ensure to pass ~round_ceil (round_floor)
> and vice-versa for scale_down operations.
> 
> In case of OPP scaling is not supported by ICE, ensure to not prevent
> devfreq for UFS, as ICE OPP-table is optional.
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
