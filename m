Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68063ACA65
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561437; cv=none; b=MabwD16NL8uq7ZjyyhbskaS/29peNdMepgZyGfba/ONnVaU/ss0rV2D1BpMJlwlIHQvvRQXHvbg86rqLrYbbfaioiRqJNy06JmlEsuu1uZ9MXXIAyRvY0gwp2yDwDP2fqLEepdvxXUJr2InBsLzms0cEHcISishtoGpsgJKQOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561437; c=relaxed/simple;
	bh=J97/LFHCSQwl41vcjradM9y1LhUgRNkjOziSeuheST8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzMafUP/Aa1qeyvwYE0s1L2pbzLN7rh7hiFNh/o0fy1o4RlDC95ezzmnl622o8O1W08bGa2lWUA7AejuWknz5vd9M/9ffP8kzdqQBWSFNJjcw3GHj8yJ6o3j2dCnf/zwJjWXqIG2MdfGTYOdPwPrsh2Tl4X0/nk0sPjaccgxhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvSDZqzw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aijfO+gk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvSDZqzw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aijfO+gk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376OO6f3536831
	for <linux-mmc@vger.kernel.org>; Tue, 7 Apr 2026 11:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVTjeMJAl4HC/zZnM//c72iDIv2/Ko4Z2oQzHGrzYXE=; b=kvSDZqzw7yoxGeGa
	gwLkIstspUFxxrVI7/RW4xXRibH7b0vdhRddhVU55JP6BRfG1KTH4SP7MPmT4Cv4
	NVIYowNqnJFH94GLXwAOfQ0bdW64JOCqia4OZEqkHM9I82X2sngHw7Do7ouYiVpw
	Kd7m0w6IDlqm4smY5omoxDJOhVpFNYMn9htqH9F4i5j93nY7ADGg1N3Pv5mvuEck
	7Luhp7atPB/VR2blA+gngL1T93Sx3EZUAUByBqMACIZFzgD5XIuxYYkNC2Rnd2nG
	UH6OffedkQ1BU7YP8JM2N4I7j8rVgUIJQ8MVNol5kthIU4SUB8KotXOomyzBAAK7
	TMbB2g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra2g9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 11:30:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b52a2d70cso112673111cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775561435; x=1776166235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UVTjeMJAl4HC/zZnM//c72iDIv2/Ko4Z2oQzHGrzYXE=;
        b=aijfO+gk65PC1HJbK9Nj0ekdC0EldweH/iOQPDzhVP4e4H1u6VWZRe0x17enEA6qYg
         N9lxNKGzBTTxRmR8C68AC9cobsJ70xQw0rgLBt5ATUF5yQMRQh8gSE8XufQlVszZJFrK
         15sFfC/PcW7lEbHAHQnt070616YrsFVmYS7t+6E56SzFEGfksu4oXpXW/XMLRZ9tQh6i
         arCzFA5ENkBgml2NSdzBK0I4+P8gGTiYYZ/Kx6mb5gg8FpjO9DS+a9AMnzzcwF4WLDwo
         IJReI6wrj/hdCOcmi7t7OewgYlhjcr1INBtMh+qS2kTMkrCsZJ0/cNuvoH2LNUtHFxj5
         bJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561435; x=1776166235;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVTjeMJAl4HC/zZnM//c72iDIv2/Ko4Z2oQzHGrzYXE=;
        b=Io7e/Qe+OJU04WRR8zD+g4hAuZ0tEIvz/YmvaV4hFwXmp7oDKTkXpsMmF4iSuBCTCq
         2kSyVmLZ89Ir/utQXtqr9OU8//LqheZq11LTd+PEKGbnfAg0xtFagh7pz/E2jGbgxMsw
         S7D9jyjUYbBJvH2C4/czYsfs80CRkDEpWKWekBCkVK5foFuNEEZsb3udfVl5JWUO+v+N
         sSyGNH/T04GetQsvVNTp8rgcdVHoZzA8lqe7NXX30dUPo7TK7W6Dn+VVIDwPkBOuXr1+
         LW1eoWhJ67b53IV5lA88rAxGX4XeOjWIjsWo0mK9cIShWrk9XsvZzznMKRa0Zg1rgneV
         SP6Q==
X-Gm-Message-State: AOJu0YznpYxsVWGZ5AQJ8f0x3pkK1FkP+//UCAn7ZXPRhh+/USz9b/Uu
	llpo+0JacnUqsybaezN6n0JZS8NjYXsD6dFmxq4+xe7uRTOB6qduoBljsR2yt2dQDFNhWv09jpQ
	64zuGhpXgVX8eRtSwj2RvT+C9Q2rdIaErnSHV0l3dRuAYKd6peKLUnl2Y23tD/oU=
X-Gm-Gg: AeBDievECrAQtSLE/Sam89wCnrjkgUEmHUtzDEhVxVdKWde9Mxo4Erhcy5zHdBxYVDW
	5soYXmTd52qORIRznEhvXEdRiUOxpA7EcW1a3+fj52qpUlUmI03opk+Q8/Yx1nsvR92ErXRDKOS
	rJMJb3IMyVHpjawPkm9jE5vkxcv6TyA/6hPLMkHkjmPjGjgBlLRid6QPIn3aBUfoOsj50qy/b7t
	TBrZE95vr/CkuSvopt6RrcequfUGaFHr60iM+Cp3mch26kOzW2KejhLGDySjXmvQD1zy+1z86+k
	qmPXmdT4qHua02d0rN3TQz7Alw8BvTsZwlnx+irPPvbgQtW6Ju3nG2atLDVCHH9q4lJhjKzQQ/M
	ewHY+NPNegtV6p55owzx2tZLW95sA+tOJVl9OEfRniohQ0ax6
X-Received: by 2002:ac8:5dcc:0:b0:50d:714a:327a with SMTP id d75a77b69052e-50d714a37eemr207910591cf.10.1775561433134;
        Tue, 07 Apr 2026 04:30:33 -0700 (PDT)
X-Received: by 2002:ac8:5dcc:0:b0:50d:714a:327a with SMTP id d75a77b69052e-50d714a37eemr207908351cf.10.1775561431537;
        Tue, 07 Apr 2026 04:30:31 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a8ddfde7sm408468995e9.5.2026.04.07.04.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:30:30 -0700 (PDT)
Message-ID: <ef40135f-0ea6-44e5-8c34-34169bb357d3@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:30:28 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: cqe: Add CQE support for cadence mmc driver
To: rohan1sj@cadence.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Milind Parab <mparab@cadence.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Manikandan Pillai <mpillai@cadence.com>
References: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
 <20260407-cdns_sdhci_cqe-support-v1-2-13efc0810631@cadence.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260407-cdns_sdhci_cqe-support-v1-2-13efc0810631@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7gFoeBNnIuSVcI1uYLZEFkE15HTYwiZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwOCBTYWx0ZWRfX4M4wwP1j8Ijq
 WSe/2VjegvPT3BlQx+2k+osIsX0Ugfi51Tjce5c6+/0hRXqFVTRDe9TS0B7TjVdLVRtC7fv4b+L
 ZXJi2zlB5ece2VPf8RtyxVrPK3JR+DqhLzDR/a2AgdllTm0C2yaV1yzMUlc3n0Oe1+fB/T6r5vK
 XvSw82djUpKd2kbVZomLsjSoxLJqi1wRCF9WfM72+zr3bg5FusjpcO2RJbVLEHUP5Lb3KhqL8Hx
 LHCTjbJQ0vl1GL9qgSGPzvOU+QKVdb/nd5YSDnfhb3aGx+DBTvUZ4esyCULP/6T3+Obw2wBt1K2
 7XPlLiUdcWiDpcuxLQHdq2jG7dVLSP+ZotvCrhPvAHW7wV4KEQajuSOvO7Y1ArrdtQ4TSnvK7LC
 VJ+OA0cz1qMk0nV5zFDROp441HhRylLkxOUi2n1Tv8J+wS8m8dPKKOl4A4aqeBin3TNcalXDxQJ
 M/lPFcv/rlCcn2upEdA==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4eadb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=cRWuF9MFhkk3AmCFUGEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 7gFoeBNnIuSVcI1uYLZEFkE15HTYwiZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070108

On 07/04/2026 13:18, rohan1sj via B4 Relay wrote:
> +static int sdhci_cdns_cqe_add_host(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	/* setup SDHCI host first */
> +	ret = sdhci_setup_host(host);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Init CQE */
> +	cq_host = cqhci_pltfm_init(pdev);
> +	if (IS_ERR(cq_host)) {
> +		ret = PTR_ERR(cq_host);
> +		goto cleanup;
> +	}
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	cq_host->ops = &sdhci_cdns_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	/* Finally initialize CQHCI */
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "Failed to initialize CQHCI: %d\n", ret);

So here error msg

> +		goto cleanup;
> +	}
> +
> +	/* add host to MMC subsystem */
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	dev_info(mmc_dev(host->mmc), "CQE init: success\n");

dev_dbg

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79


> +	return 0;
> +
> +cleanup:
> +	dev_err(mmc_dev(host->mmc), "CQE init: failed for %s\n", mmc_hostname(host->mmc));

And here also error message. Why twice?

And if it is probe path, why aren't you using dev_err_probe()?

Best regards,
Krzysztof

