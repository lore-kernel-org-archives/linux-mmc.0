Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F945235346
	for <linux-mmc@vger.kernel.org>; Tue,  1 Jul 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371775; cv=none; b=MdazQ9agTUXbGHfMgiov8JQxWRUqbH18854KPY3bfsNPR8sRi6lqbeerIhxtXkqMBv4TZfA+275gQQmJatYT/O0EaZUN8AW05qSDx7ZWKx2UlLNVtkfzBYlQaFoP+AY78/WPf3DXBwGw0erLge4/0BsGHHRNiVZ6qX+4fiLyEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371775; c=relaxed/simple;
	bh=WDRgfXWXGfe0UH9qUXWp4TgglhR2HVl6KIlxsZFWhTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhyWq9ChNh3vg4bgUXpr0Ss1NC1SghxViUvnVNnzCdtIzkennKqPjZIXk08CFS1SFvc4WngDvBpeMeAeVR0/wElrZoNfMFSbyoMZGdDixWY6AgWH1U9/WO8TYJYeyIUUMCyV2hi3WZHkLorIRXUhOUVT2/oQBvjAKJoSZ4pS5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbUbHnCS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbUbHnCS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5618DLXm010475
	for <linux-mmc@vger.kernel.org>; Tue, 1 Jul 2025 12:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lf8Jmyio+SLdCvkpCacq2i+KFuRD1jwhGH5OllRLLL8=; b=ZbUbHnCSdKJCie0w
	1MOcIYiXdG7Z2EFwtFGjxvH4/X3fhF3KgvqjZO96vEiG1r065QMVrFFuVfcyzzoJ
	GZvU3Q6WGb76ODHDziuBorpqg/rlvdHMZHyYzsXjKKCiGRswNK6hvuAsCcxC7tNO
	tKAIaRwo2hz8jekaTv6UaFdAG6WMGiroOhDdJfYhlFtPjSPqK8maCjs4MgH+OgEd
	z0gS8k6rGEi6xcKNjfd0fe5bYGnH82soTeo/AHWnOK/JoIocjfNm9KkogJZeg9Gt
	eVwesQZed3zZac6fAGZ/9TAsCZ5FYStunXL0qos+fZcFB/2+oC+xFBJtdqBrdjUY
	nyiRXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm8sft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 12:09:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a5832bdd8dso5782261cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 05:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371771; x=1751976571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lf8Jmyio+SLdCvkpCacq2i+KFuRD1jwhGH5OllRLLL8=;
        b=bS72tzfF42jHjnWYkbwXqxP0XgK9TapZzbnKu4eCFBgIUxZAadtU3XprwavoE/BDJH
         BHl7Yr9HB5DEcKHGwUw4Q2amMRZU0XbK5ZU9MKukUAMYIE99az9NXBAbv5XA5JVHRl09
         Pz15Nt7X93TPjoAcyzcLkut1K23c7iFyu/WFlIYPs1W2cxO73N9d7dKRFx6jCyfavtyE
         pQdD+098hRmGvdyWWJbvhc51bDvq5xnB+DTv7x+doOu6wxDiL7zLnLUMpDZrNC1UYqD6
         YsQ+tvEc1rGg3hdQNkuaZWrUzNoO0t6TRO4tsg6hge4Jsnhh3hg1RXwhVnMNoUrJ25rP
         4nig==
X-Forwarded-Encrypted: i=1; AJvYcCUmvSnJSiTQ5RGo1O9rPiVmddmbp3rHYMP6yxyV7z+VYB5ckOhq6tYZPj27xltrFiJ4guWBEl4J44A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnBpicTAw5MReqdjMo1lOHs4w+VZaGU4/h1WsUAktaVt7dsVo
	4Ia20EpjxopwQBYLRdyiFTL2RFoJpP0asMylOe+cl3YxtW9fZ96oMskRIg2/pTDtr5Y0nYPOQsB
	uhf6EE7G9mbUE0KHHHCMalt+j7l+Ulv8C9KzkuBrSVHPTEFeTbnPX7kz2o5feolI=
X-Gm-Gg: ASbGncurcfMfTYh7hIWAz9ZJPd9K9hzd3Ad64rfGMkBn35B2SZzNrhEb/bUGvpzj8GU
	Dp8IED3oQCgX9kBv0C2GEh8qhPPfI1645itzXID7FICBcYCYMzgHryvZ9YWOQkWulxuB6Ljp1sr
	3AOknjvFINzocQazvPdAdAniA1G8VQqx736nmVTQVUTkdJoAaKFH860KhmpJsTlbShrfg0n2Yzb
	KXN8ZZdvjmjWghOcbRczkWVo0gcjNjhcKLdb0T3wPhx0NasY30tF0LqrMoWvkZE2f6NlCv4SwXe
	ffGo2cSeSHKDwiGSA2+8IihZrPF/A1Seuv4TIMvPRAf0i/Xwx+aA+HEWNvFThfbvBGUA5zFW0zO
	jL6AzeNl6
X-Received: by 2002:a05:622a:5cd:b0:474:e213:7482 with SMTP id d75a77b69052e-4a832d99b26mr13892211cf.11.1751371771282;
        Tue, 01 Jul 2025 05:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQVXZRZhEnxAxzvyWJKIWKbRY1rodAvUMKMkXoSRbY/JskzbHVFmzlfJJjTVfgKYRM4buiQg==
X-Received: by 2002:a05:622a:5cd:b0:474:e213:7482 with SMTP id d75a77b69052e-4a832d99b26mr13892041cf.11.1751371770787;
        Tue, 01 Jul 2025 05:09:30 -0700 (PDT)
Received: from [192.168.1.114] (83.9.29.190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b24fsm857473866b.34.2025.07.01.05.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:09:30 -0700 (PDT)
Message-ID: <9db5d1d4-1965-4334-9540-fbb66498d7d5@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:09:27 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mmc: sdhci-msm: Ensure SD card power isn't ON when
 card removed
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250701100659.3310386-1-quic_sartgarg@quicinc.com>
 <c7lpaij5f5monr7zfeqitncwnau22iollid2gs7okyorlegtmg@jlq65x7ipp25>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c7lpaij5f5monr7zfeqitncwnau22iollid2gs7okyorlegtmg@jlq65x7ipp25>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=6863cffc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=fKQzr7EGRj+VoE0XNsDNvQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=NKAVfNCoMK6aC5uGs1EA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: k7IB0D3VOGQJby7-uB7EshlLlFwdDUKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3NCBTYWx0ZWRfX3oWnN3VUgoJ4
 2a5CpKafE44lCghN9Y5AdGWbYgSD2Y2pCP6Lp85AFxiiccHarxf6bpBPkVzUVBloVLWjpnzYA1+
 IfXAf8QQL1hMBCvz0izRo3sb1/Y2NZrK9OSK4niE03fsPDZ8qKEpatICAVAoyTZKPCtRerekLKX
 q5S46gtYwyPcXL8cNOZlBcnWlfTx54PVr+37FjDZYzX4WX3hZvlB20uhCPqtTTLoBsOoOF/K+NJ
 UDG38j+Tq79Kd8ovI5NTln9wB3ZYRe6PVmj+j7IbLkRdICbuTVhdP2z0NKJjSyPdJlLLMydHTz9
 t3HkosOhchr5SN7JyRTiKeDbUkoTA4QpBnRgIHcBL/GkPhtVdWw6a9sxhTvOIdm8BQdUCcoYr7F
 AhbuvTJRpHw6u54Gc8mBtbxUpmjvxDUrKh6Skw6ihc1MiPKJK9/ixLlma8QEJWBOWKUQdcHY
X-Proofpoint-GUID: k7IB0D3VOGQJby7-uB7EshlLlFwdDUKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010074



On 01-Jul-25 12:27, Dmitry Baryshkov wrote:
> On Tue, Jul 01, 2025 at 03:36:59PM +0530, Sarthak Garg wrote:
>> Many mobile phones feature multi-card tray designs, where the same
>> tray is used for both SD and SIM cards. If the SD card is placed
>> at the outermost location in the tray, the SIM card may come in
>> contact with SD card power-supply while removing the tray, possibly
>> resulting in SIM damage.
>>
>> To prevent that, make sure the SD card is really inserted by reading
>> the Card Detect pin state. If it's not, turn off the power in
>> sdhci_msm_check_power_status() and also set the BUS_FAIL power state
>> on the controller as part of pwr_irq handling for BUS_ON request.
>>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Should this be handled by the MMC core instead?

If possible, yes, but if it only works because our hw-specific
sdhci_msm_check_power_status() behaves a certain way, it's good
to go as is. I have no clue if that's the case.

Konrad
