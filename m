Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196744BCBE
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385006; cv=none; b=MRxrcazcZxygF5Mo5UOM4rdA+mhl6Q8RFs8oNb4umHEPCDT73dPDggyezzkpTrQqizEN6jlGPImLx6Giie7+PJWqs1GcKhEP0c/GFN3QUQ2VUh75q3fIz23DFkH13Om3gCDUWd2AsQlIVnnj2GAq1PtwPzltGapzg3hYoVNA6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385006; c=relaxed/simple;
	bh=9NTdtJ/TSp6i9fELQDWEuFYvwbqy3ev3R+H2YTC2xv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E19aYPJkRpjOoCazxiTomAnk6KQrv79NK6l24KF2+Dpy33CoGlIt2ZMGNKkB7WIQDI0xLki/9LSbiWqgvoR/ppZNHka6iZdbsjc+Rs5CLsvn2nNYYLGSf9hLwF2PKi7Q+/rnI0hs9EeIN1HRnzbBdytYReemfUX9c/8nC9ACaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/WVOCmY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ht9320d7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/WVOCmY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ht9320d7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EAmL6r4032508
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=; b=E/WVOCmY/+5Enkgw
	YEeOQ9dPHJUB8CWxTR20yFYOlY8UkoMJaYfEbZw5mtWvnO47B9tf1wMQPeafNwuh
	wcPa+7jFxuwllxPm+71b/159YFvZtg/2RACZvfhGXsdX3lRflqfucbjNfAT60rpW
	nT2W6tgRlLZN6L+MSJ/TNerjJkANtic5DzviOrYF00TQxSgNoyEqEGVr9kcRPO/3
	gIuOu7yV0ud+xAE5Z0o7WnQCbf35GMdm9FpQLiSsBTvoxEBODy0Mr28DtrxMTC/P
	1BajQAshRn13edHqPJho+jbGH0cD+CYPJc+8jjhbFR5E60BgJZv+Py3P6XJNpBgD
	ZRcYpg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq8ac0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 11:23:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-938fd633df7so48947385a.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789385003; x=1789989803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=Ht9320d74kpNIcVyo8Quf80aiP5sRtcR3/0wQmYfiFriM2hhqg1Xc30rzDlEyoNYFM
         uRHd2FRjQOZ1zCgRZ5KOqYEbm4q68H7RiwKLBhVo5MofTGjbi5NYvFfajGuSZoDZZTw0
         EPteeyDnHje22gRYbYKCuMNAsdLLXRiLdZbW9nTjGVbPMnkkOMlD07nTCUCIDy+qe0U0
         kuujEZJb9EXOnBkkLhL9clPNrfIHSDWucD+E7UJ6NFZpQTBhIGV5pLX9PI/safMHVzv/
         D41HwqyG3tb5J1PXgemorUDx8cIj40aHjlwKE8Ged7XPrzV2qxiwtdL6OGmuypDNXRLZ
         Ahjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385003; x=1789989803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C99yA2ahM9Y0TtIpiFt1fwPT2Pp5VWgJygOu7Ai3npc=;
        b=DsvzmiJtUqcgLEl7XTpVIv6yJ3M+o3LccTXJtwZV3uukc0MjLuktxQNNi8RRBoZ4Qt
         matihW2I3o13LsaRmkCBYUHIu1MNzvf8B2Rz6U17vasOJ5FJKPUgPUjRJNtzhXiqd2wk
         Xf4Mn+ObeyAuHN3fnYh5JNL7G0akmsaYwhjkbph/XUaA1HNHhfYCvOc07O7p02DxbSrN
         7zv6jiXFdanHWArSd5mdtVOzbH8WH3qmqNl7Yy00xBUgfwKPMFs7bg35awli8v1xcZv0
         NFovZC3Z/wZ2dKE0hUv4JpUbgTOklHxIrTs3ce6bnjP8IdqDazJut2+kb0ZUyY43Oxcr
         Ilwg==
X-Forwarded-Encrypted: i=1; AKwUvBywiEjaPN/HY+o8/X3dLfNyw7nf1lyWA4EpFvUPPo0ieiCbBt/ndAm54q37n96fYJpnZdj4r/rB8wk=@vger.kernel.org
X-Gm-Message-State: AFuF++nHXZwBeJkLfHQKLnC+4AJ1zHJayS2Hlox+Yzicz6DiQML61CLm
	Z/W4DnlQv/fnopqsPT9Ajf/V/cb3VlZZO6aeV+1oEn6k/K9wdK11mOpC1lrGsPVxTLgKHk6W9iN
	dhP7WqhY9fNtCzf65j6hSpdYlAHtpmNwuMzch9NfcZucSDJOHavB0RcnCoUcTWAw=
X-Gm-Gg: AYBFou0ZIrHfJ/ym1oncOg0QPnSi8kz5I1NWD1pAx+l30Et9LyA+1vO2N2zzr0bwMrK
	pORb6H0OJZdvwliTx3h0xA6Gmsb0p+AdrDJH6+kn8FDZlz76rFYJu9OxmVqPKbkNqIxAI98vLst
	dTSJHwV8vAgmgo9Yvb7g+2v/B1Ja/o9tHuYJ0MMNPa8pJ4zvg2gsM+M9CLerR/fWmMWAydL5TV1
	ieGYWPUOJXx+AjKXknNUA6OIKoRzWqtswKupQd3JrEBg22rozxXeXP0yWF3CFDRNCZlgiMMjntS
	kYbVaOIu2BbtN3GkuMsKdn7ZLXKHGsQFlFAYwPy8lzDHJD6o6yUwJiNLvg4d2bHZFURcdrWjnc6
	THrlbKm1BWRKZdckcP+sELA==
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214252585a.3.1789385002644;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:934:95d9:85fe with SMTP id af79cd13be357-93a29a8d250mr214244085a.3.1789385002074;
        Mon, 14 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296601f4ccsm406660866b.20.2026.09.14.04.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:23:21 -0700 (PDT)
Message-ID: <757e124a-4c7b-4d3b-b73f-19e7e39f2677@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX88XcDK39DuOO
 dEx6ED6i1kUqO5IySy3ii1k/PwaU0YJ2I+xxDuUuebDhF1z1NFAcW+cZV59MD1+jY/0MvUpn9dX
 AR31j1taCKMRBhMkK2uXlqObmUwsUjYT+2LUXlnFTwf1RmHIubkMmjyj/no+EnCYwEs7IWiGedK
 XamPO0PF6RYYWQVI1X5+o6h2g4+n97EWUQ5UdJlh0Ob6bh3VoIOAYFRid3z9RQjpMxfGwxox1uy
 038xPxQdNv3t5GxdAg0A4pjRULXTIo6fCYOvNX2ywkgnGG8qSP7HxNo9IYEk+B4MhlBodhaYxgI
 r7QbsV0AqfR9UhxbpaFF3tt2b9Xa+usKsv2lHc4PMKu7Lfpr0f3Y1QyCm090YCi2DIYlBbpmwaY
 ahQkkXkTL8TtfXYoHS9RgkcA5DhMwuMP+W1WtOXPt0T7EgwgX78HQB2iCQbfxjoTzs8aEzDxX4t
 tmk6ND7AfaZFpCDjl3A==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa7d92b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=OvtQcJRYg_U4C0nSOkMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: ibop6QDNHllQKv-dflAvwqL2KYUUJJL-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE2MSBTYWx0ZWRfX1kQ7q9hFq6Hr
 bCBMSs05ZsC3H8ChL/knhhB2RaTMmHb7bk3agdzY7y1fwUAtBP/UR+vegwf8vBT5WVVcTwNYC3W
 pPCoK5+I4oT7E4/xuwjtugfcgD+VF10=
X-Proofpoint-GUID: ibop6QDNHllQKv-dflAvwqL2KYUUJJL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140161

On 9/12/26 10:39 AM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
