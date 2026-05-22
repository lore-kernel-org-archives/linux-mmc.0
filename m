Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870DB3B993A
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442483; cv=none; b=BjhvtdFTdmxCuTXa/Q8CfJZC1w+RnI2tMkHB4dqS/VVwQAQVJqfymgOrxwnFk/xeUIqIkLyklALHeQ9CxNaytwTa2c2fDPQh8RZCLPse9p0Sq/rBydeSipzZZAwPpXdOcJNmnzf1JIdi/LkKruL1IjPbRWii6rFb/APpJNlSbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442483; c=relaxed/simple;
	bh=KZa7rVfKaLsvI+1EOIq2C0yqStQ4z0m3wnVY0OVHT4w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O1skSFO2j9Geqgoc69BBcroh6j10vj/5AjKLpvT1MOL1l+hbEmApZSadpViFJAZFlMQCaoozl5Pu6did9pXYGAZ4VfZ+cOVH3GJ76Yz7uP2RS60hbxX8Nda86FQGKxKSGME72m3NQmDoqoGyQ0NUXbZmswffspbAlZEG/f4IGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgqmzNmB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctYCychO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgqmzNmB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctYCychO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8blfx1657832
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 09:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pu55bG2vP5jws3ymKDZxbKEP/sVznBdilOK4Sk0Mwws=; b=pgqmzNmBC4s6+ANL
	acNwBNGkOyMi6NT5AOR6V5NbO+GMSmslfp3+IpYPpqxFKc+TrT8CWYq33RTyRYn6
	ERVe8KA9/wm3jDJOOWpmv/cyYxGElZZlFrgwfRTzHcZG8R/ePx3qPIzJrKniLnEQ
	zC5VT0rSMqS4Bz7VBxsww8yqrwrS/HjicNW+AnnzK80ufrL+jlQi4EMA1r0AsJhh
	vLxezwOi1YuHBhKLq96MUvL7sIzpxuaYddYwYz/8HNmBfKjVqkazF942rLL/CUY7
	gnn75EuqMKuBCSAqlcCu9ecSzFW9QbCvI/WXRMWfFazKM4UGB/r3WTRTzWf5PmO1
	Fmsq+g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkn4pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 09:34:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83f7e7f7457so4146528b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779442481; x=1780047281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pu55bG2vP5jws3ymKDZxbKEP/sVznBdilOK4Sk0Mwws=;
        b=ctYCychOs0r77XmPolVETUQKegZZd6/LJko243VX0fYzSZb+1bEBdc3er+pBRhKnP1
         fK2mK8G2jsUc4RUfNFUDLnegP2vTwdEUx0s9SqeTQrWDV2sFD1yZrQ6R1Rspqb6qx43V
         +OYBMnu/cYwk/V4Vjt3I1YorIq2T8dGPeTN8ywpla+nh+zFYIywhkVIqtaZuS7ttHJIH
         hpjJVycSyXjBdAIpyVTqpmovwQBGNAJHVTh5+JO969zlvrmnljJNy2JTdR/fdJX+WA81
         Opj+s76qU56PrPN5jQgw/G8MKFhN+f/v4Xif+JBfEx86XUnryHzsINsg60G9CiFdLaqo
         FaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442481; x=1780047281;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu55bG2vP5jws3ymKDZxbKEP/sVznBdilOK4Sk0Mwws=;
        b=YswruWO4ABLNTPchs2p7WwcS6g8KyUG4W0WKncoy7QgprscJY6amOhTD0tFAnMSv59
         dnWrqo1qCXrpXS7eDRqZMlgTEhagskehN7G/XiFSbAXxSEvFxnxdyiw/h4izHxUspr/x
         lwXcIerrPXinFciU43bzG1E2GioEMMxNZ2/8T/KU9lWYmoRilsAXcoNxhAUXkTVYZStu
         /SamMRG2RepZy94ZHMJdWDLJnD7dgU5Bzw1IehXsA7BEqpUpTJILkA7MFQ4wDKzxemRN
         yYVv9opO4I4RsKQpPDVk+L7QYAmxMftR02kkeqfiMwNT5jEhrW5XChWC+OB67Hzasjjf
         oGUg==
X-Gm-Message-State: AOJu0YzaSWUfbDc+4sEhrupb/A6SoEYixFmC7gNhayMekv/ZyRD+K26O
	p5cSmmADoaCPHuiM3N/e9yvsLo4T49Zolvk+UjKziigyIqBMQoFPHWU7Sp/BAK+JDWyx7pruNx9
	GQ4AFUdmgcQ7G3VuR1QaAPp2krTmRBJdeNKs/Lz2ssQxUzmDg8e7dgbEY7hJvwag=
X-Gm-Gg: Acq92OFiq+F0kzdNhD7XA0O6HZGMIObbB3yuzGad8yEmXhHTDNvVfMfpVMGjwz34zKO
	H1l7lz21WrbD4O/wEucbI/1IsV3nV5YBAbn24Do15NSov/KBb7LD6OduWvvLSehiBkDP+9VL90b
	meaxxJauwn63ELkAwkMGQ4WjMRzj+WTk2Yowo+3ZUc208vnCBQgLzp4BlXQ77lUT+EQBN1bxofr
	odrPCN12qd3dl45tx5r3cUj8LYBzW3jsHnxjUvi9l/pGpctbzbGYmKpz5ovUc+7JeREeTghqMkh
	EezOz7CxO36v443UN9+rRZZO4quun9X94y6Wr4or6ztPvGhrAOXd2PAoLylH6J9V5c9oTDpic81
	IzwcmTn2n9JaVubb+2ChYvgF97yjWc2pKIWkxIc8xL1+lqdo8+Q==
X-Received: by 2002:a05:6a00:2388:b0:82f:9a88:9092 with SMTP id d2e1a72fcca58-8414b5d1e03mr5245765b3a.33.1779442481052;
        Fri, 22 May 2026 02:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2388:b0:82f:9a88:9092 with SMTP id d2e1a72fcca58-8414b5d1e03mr5245748b3a.33.1779442480588;
        Fri, 22 May 2026 02:34:40 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841648a2bf2sm1335125b3a.0.2026.05.22.02.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:34:40 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] Enable Inline crypto engine for kodiak and monaco
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <07a7d2f8-4a6c-d9f9-71b5-49a1dae693fd@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:04:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NCBTYWx0ZWRfX3bOjvffJBVlp
 W73gayNUnzSfTycrEDR4D1LGPgZQqG2hu30WCBYfleUopZ6WX1xfckmwgTOiePcxhtmtFFex768
 st3Ub7nVkQ+A1+2F3NTTaWXZM79R3C17E/d52LeVBg980sqTBWEMTFeJVTs+crf8ozWfUB2tm31
 p8m9IYJN2Jsqrv0tMBLPb90+YLhBaTa3nFkCk2FMFqb/NDIi2662ohsoO5GyS06cVgBxjv726/F
 vrA/5xbrPaRVwO1JMMiAQtg5V9FZVNdE7+9QubYEaZStsfHn0ETx29MBlnQQMQzHPNnYSG7R+Fn
 +gmUMXU1IUPxuWuObva5hYLVCz2jGrHMAScePZlhRDq8cM6es1+rrs5gIA+njdmI+QIhoCpbSi9
 /lYkl1+G5gY1SGtf1wFMmhci4k0n3100CHz7trfX8Y0i8FDkhTdnlk9K/UEtZoPhtWvLbcXwFs+
 B5qFVUpCmFAnstj6eYA==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a102331 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=L_mIoDfPuTR8LUiAGlcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ekDRRgv0m9Xw1o6KT-HDYkcQYbd9xoij
X-Proofpoint-ORIG-GUID: ekDRRgv0m9Xw1o6KT-HDYkcQYbd9xoij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220094

On 3/10/2026 5:05 PM, Neeraj Soni wrote:
> Document Inline Crypto Engine (ICE) handle for SDHC and add its device-tree
> node to enable it for kodiak and monaco.
> 
> How this patch was tested:
> - export ARCH=arm64
> - export CROSS_COMPILE=aarch64-linux-gnu-
> - make menuconfig
> - make defconifg
> - make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/sdhci-msm.yaml dt_binding_check
> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y dtbs
> 
> ---

Hi Ulf/Bjorn,

We are looking to target this patch series to be part of 7.2 merge window
if there are no further review comments.
If if is fine, Ulf can you please ack the dt-binding patch (1/3) so that
this entire series be picked via Bjorn tree.

Bjorn i hope this is fine with you.

The v5 of this patch series was "Reviewed-by" Krzysztof for dt-binding changes:
https://lore.kernel.org/all/20260307-llama-of-massive-downpour-2e512a@quoll/
but i missed to add it in v6. Requesting to please apply the tag while picking
the patch series.

Regards,
Neeraj
