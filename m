Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A438F623
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443725; cv=none; b=W4pGNaVBvH7CjwdLR+cFSkwRNsJcBP3ZdVpNlOLx5jxidCGY72GmsDrYZwldR3Cc6ZamU3iEx7Ck6CAwVkRUYFVeJnnNLt5U4G+N25HN3LoLRwCQeSAWnwWuFTOY5DOJaDAxisw4sNR9VZR6+MBRWfGpJjBheipLac42Ag+XxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443725; c=relaxed/simple;
	bh=283ITlUTpw+pnnWf8GlTk3ilsVM0BLNnI2fU0ZTZpAs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JHhmhjLjzVlx1L4FTWqey5TNUpyvH+lnojlU7Co4Ktb1Oz65Lq1cP4wnTlFYc+sLUav+3SsJc9sTpBWpPUKeS+YFM7J9oJ7NKdERG5y5W7vHsq7r0HYGlCpuL5ZppsAEsvuagvTzYbSqYGQLw2++3OBjxhaOrq0bqQl5TbWTeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoRcKCM7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HAQXKj1L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoRcKCM7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HAQXKj1L"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294lYd1291376
	for <linux-mmc@vger.kernel.org>; Mon, 2 Mar 2026 09:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=; b=GoRcKCM7831kuUhp
	I5iRKWUanqqzJFpMCKE4KqTqTkEiVQz8Oq4LpbM+OJtjJu9kqs+IqAq+aMB4u47h
	irngferz5Ea6YPaLiPrYNznw33L33vSJhrzYPzWFkAcWTSi43pfFnMj2s6KhKyPB
	VaJFxFU+CEoQpoGlVu9xQ6d8wyLzyjfL8WNDzUd1Z21CpgxFbFWwSmdso+1T8QZJ
	5syQ7xhsSAhJkuQ1stVjxQO1+8H5+EmoE/hiGDAiXU5FeyMPvf9MYsLRUeK0utc+
	ukYtUiRDUWhz0cYj82yh5zEG2xquF1tBGfaV3z07jNuGyAOIrFpU36Obt8ozCa0P
	Af823Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7ku02y2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 09:28:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3595485abbbso3168197a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772443721; x=1773048521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=;
        b=HAQXKj1LZOf/bkOBpFO8RSxF3p1pu8TmGDm3kL12okUxlmnuF80uTwxY2M5gKNvY0X
         +pVhCJrmkADX04+Hk9zFILjk432uE2clk2fLiIxm9aYviPcHwKkshsA0gmsqwDoQHzVU
         d434cJmCi+Q53psdcOUMmIn7CNK+JqXcesvuKJTUIal/F8uxD2F7O/4heqsXdoTguPpc
         FjVoqL7a/C8gU/Lzz4p9KJHgesp5CUnBxfxlBbcpyeSX8xRmeF4a2QKNMJWFEJY77Hau
         vbcolF4tK6+p+S00PBsIoeXuwpN9aQGKqWnuCQA3siucghQdNsEMkYuHJiLrX/MDVRIH
         Yapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772443721; x=1773048521;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht8a1jegW8k/H9PVxZasCwKoJs5NEx57HRzB+8Y1KVo=;
        b=LKaCdZ4ijfhR2joLDtzo1oXwIqYklaPlJI1HZs7uVO2rnIM5bvdJndsfrb9T6D/1dm
         PMCJaHFck6EOKAjfjt/AbjgmI7z5cPXZO9dBrLA7Ccsnn5OojVimakOXksYwEMd2E9IL
         uTvGs4sA7ro3f/CcpHNJceFsSdrlScts8qzJKDg6LVg/F9cMhOxbycEHJ+uCNYVkks5V
         VFvjLD9seM8G+RwGzz9z1OXsZJQAyhvo1oEUuDbTwZomEeZ7wGDv0muhbBwr86N8SHuC
         4+nU0vfT2gs28p1Ze8NcsnFj9XOONgmoJ8q6BXPMhcX/rTa8Tzh69DXuxv9Y29uMNmZw
         wGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC5jz/CQ9SK3wm1/jRmgy8mPQXgHvyAj6T2i0/HJwLA/nPoCkWWxHnGbN4a4luLINSReOEn2FmJaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mzFk3d9I/o2FP/a8hgtbD/TK1aI0motubiGKR3G9W6JgQtUk
	dVyOoriYn3uup7DgoQ7Bg5AxndgFw2LvM7iSF3/U25FyEaHDD6WgIChPiwTSrvWRwlPaVDKnj48
	tEQPgPVF1li73GEdhDXDiCKuXlmOy3bnp9XUObniaXdY7615bh33x5d2FDFfdLbIE7Strp54=
X-Gm-Gg: ATEYQzzlvfWF1IpQKU2z6AjhPARpeILuKmARICp1MaqEBbZgatQ4JFFhYLO+hetq5Nf
	r5kN9LxcHA2P6tyKZHDESm19yVWLGwScV6teBqynpE959laXiXmxp9F8iw3mJB5GmiPVr/gw/X5
	2keLJfIB2/FutcFqT3koOYpXGz9ASY1igQRMHEFEYa1LuqNVN0aVVNErkyL0Yo4XOkc/4YCfgDV
	6GXxRpq5u526VkE3WC9SsKwggivpzJNE0QLW7b2KaqkcDl19Su9erIHaiozaol31aQp9j+LiZ/z
	LEiOFeIxgGX9QXvrF0TSwBG7vf6zfOmQRo2t8Oyq1ZLtgETbhGfXHhwbyTild+A6+sDq4d6A8Ja
	AuGk+gfXiz89s7oQ4AyxMQSfhLPw9yCmInMuX4/KpJMOwQFWiXQ==
X-Received: by 2002:a17:90a:fc4d:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35965cc9d6amr10190640a91.23.1772443721267;
        Mon, 02 Mar 2026 01:28:41 -0800 (PST)
X-Received: by 2002:a17:90a:fc4d:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35965cc9d6amr10190617a91.23.1772443720773;
        Mon, 02 Mar 2026 01:28:40 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597dfea2e7sm6307474a91.12.2026.03.02.01.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:28:40 -0800 (PST)
Subject: Re: [PATCH v3 1/4] soc: qcom: ice: Fix race between qcom_ice_probe()
 and of_qcom_ice_get()
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260223-qcom-ice-fix-v3-0-6ca5846329f7@oss.qualcomm.com>
 <20260223-qcom-ice-fix-v3-1-6ca5846329f7@oss.qualcomm.com>
 <h2uhrsjlvovjcj7k2ckpkgrhpuwm6biun4ueq7kyzcm4hqcsjr@y3iiqx2vo6s2>
 <lrhali5ukotcmxqp4yb2g2jvbrhlanpqc67cpvluex4l63skne@ln3j4xn6qfvx>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <ea659db4-54df-1892-f04a-74a8f62c7dec@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:58:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <lrhali5ukotcmxqp4yb2g2jvbrhlanpqc67cpvluex4l63skne@ln3j4xn6qfvx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V4NwEOni c=1 sm=1 tr=0 ts=69a5584a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xC54U6B0g8_6vy67BIAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4Pm2TZJ_y5ldibYJTJ1aK9h-Sqtx3ehZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OSBTYWx0ZWRfX/NvzH+CHaFdn
 j1sTuf8IeCeJcJywIJs6bzcijYXXpSsjUqDgvVNNE+JM3blyOoT/hqcul1fxFS2d0gpItrcE8gY
 /5tgk/2iYg4cxanKsWX2tCYYcUifNxbA5Lgdso935Rhy8kLtqVG3fDse480ZuUlJZwEIzyV7KsQ
 OgH2OSw/t7G30bH8aVONdfSU6xHquK2re1HwTz6TFuANh6oVM9pX3eXlXcu3qwqxTroW6/iL6X7
 XkzsUOLL0BXZ31jAg/sHM9frpadLnzeXUyeKb4f7KPVMzfEqpUVdEFf4DNNfCE8ni03NNuNgETD
 n+0KnyXqPOUk67lSMKRwLzvlvAa6X/ntPjzaNBvpDRIdCwqbfiI9GCm8n5edCP1ogq/pWYjzq/y
 kX2r9jqzsiqawi3EvSgw4jCsurIl3tBC6h8kSDuMCnMZanWE4hrMfmv7cEUkevsOgBuKQYCzk5D
 J95kpl2LWtkjULhJyNQ==
X-Proofpoint-ORIG-GUID: 4Pm2TZJ_y5ldibYJTJ1aK9h-Sqtx3ehZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020079



On 2/24/2026 10:16 AM, Manivannan Sadhasivam wrote:
> + Neeraj
> 
> On Mon, Feb 23, 2026 at 02:35:04PM -0600, Bjorn Andersson wrote:
>> On Mon, Feb 23, 2026 at 01:32:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> The current platform driver design causes probe ordering races with
>>> consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
>>> probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
>>> with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
>>> be gracefully disabled. devm_of_qcom_ice_get() doesn't know if the ICE
>>> driver probe has failed due to above reasons or it is waiting for the SCM
>>> driver.
>>>
>>> Moreover, there is no devlink dependency between ICE and consumer drivers
>>> as 'qcom,ice' is not considered as a DT 'supplier'. So the consumer drivers
>>> have no idea of when the ICE driver is going to probe.
>>>
>>> To address these issues, introduce a global ice_handle to store the valid
>>> ICE handle pointer, and set during successful ICE driver probe. On probe
>>> failure, set it to an error pointer and propagate the error from
>>> of_qcom_ice_get().
>>>
>>> Additionally, add a global ice_mutex to synchronize qcom_ice_probe() and
>>> of_qcom_ice_get().
>>>
>>> Note that this change only fixes the standalone ICE DT node bindings and
>>> not the ones with 'ice' range embedded in the consumer nodes, where there
>>> is no issue.
>>>
>>> Cc: <stable@vger.kernel.org> # 6.4
>>> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
>>> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>  drivers/soc/qcom/ice.c | 44 +++++++++++++++++++++++++++-----------------
>>>  1 file changed, 27 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
>>> index b203bc685cad..3c3c189e24f9 100644
>>> --- a/drivers/soc/qcom/ice.c
>>> +++ b/drivers/soc/qcom/ice.c
>>> @@ -113,6 +113,9 @@ struct qcom_ice {
>>>  	u8 hwkm_version;
>>>  };
>>>  
>>> +static DEFINE_MUTEX(ice_mutex);
>>> +static struct qcom_ice *ice_handle;
>>
>> Did we get confirmation that in the UFS + SDCC case, there's only a
>> single ICE instance per SoC?
>>
> 
> Right now there is only a single instance per SoC. But Neeraj told me that
> upcoming SoCs are going to have multiple instances. But I don't want to spend

Yes and patches for same are under review here:
https://lore.kernel.org/all/20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com/

> too much time on *upcoming* support, but rather fix the current
> implementations.
> 
> Extending this to multiple instances would just require storing the ice_handle
> with node name/address pair in xarray or in some other data structures.
> 
> - Mani
> 
