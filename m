Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D913016F2
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048884; cv=none; b=Wdw22FLGQ1yduS2KAgptmRXWe6fp7cwSR1eyaJEIeQYSnvVrtn3HD6Ia0B8Nd66moNgPUwNmWvb4pLKyy6jWQeLc6cqDokKPbTHr13Q6IuRLTOmXXtt6x6HLjEnBoBFmTPqQtiEqIs1KEpVES8Wrei7KS3VlUSzV5BwJfHwN0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048884; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=iYB1Em2KdgyjsIxAvQ9+RvzVFdJfLkrh8xMUV6015rR+OsPpliq23JqcTDqDnBccsUkgNfkpCu9W/ZebEGskQAe4Rpgvu/6RDUrMq6OfHzBUs4OFGe384Xr/s+oCaAOpQbVrdyKnU+cO6HmeWycAOrBesZu4zOqSCAcmvZwYlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y84LPRzy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DliT/96t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y84LPRzy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DliT/96t"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463fDd82186945
	for <linux-mmc@vger.kernel.org>; Wed, 6 May 2026 06:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=qcppdkim1; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++L
	fAOrCAj6OvBfk=; b=Y84LPRzyVd2gbfQRAjTu4aR6XqA0u8fpEEEAhhX48kNnz+
	EDx8GiSg3tGdgLrR+07BOsOQ+5V/glUjJ02elN1E2XM2WSRygwQilQJmedvxl6wg
	2F8wpzIsuvGb/4hU7r+ozkcHBs+aMdcg14dWJM+DS3psFmJo0LvMaf12DZ5nL0YV
	EXia40i+85FK54b4jL5/3/1AvA07V5jjKcMX1fAwTcwJI7LOALywsSMxQCZa50Z4
	p73iipc7QxmB3/aCVK4+LspgrR9OQAJFqafhPgKxcgf47C4Y/7OVUYXbnBbxAU8L
	X61StfGwqmnehqc+CHS7EM+NRqRhOdnD24Tn5ALA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dygce3ss9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 06:28:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2923050a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778048882; x=1778653682; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=DliT/96tTbtdUpmJOR2AufjzKni5Jw320pTXoEzzrObEqgs2UAh9XCSrwd/a2vlnRm
         FNwcQVk4eUDSmrowq6EQaXXmS45khp0ji6EeH4lmb+zdQINlA7i+Pfu9ian5CheXvzdH
         dXqvXF6Ub2in1iyMxPOjKFjXQR8Zw0YMkfpwwUAGnXzAviehoH436OT1TxzOp0royfZj
         moOUY8qm68Wn61FSAqScmLTXZow2gmg6/ytygF94dfTqC4hoRzm9m5dmYwC45kHIM/v6
         gEyBFhZIkkWSjbJcMbPFuT043KFR8JOo05BBZiKlYXpoErrmI/LRTxjdY6A0jDWx5UqJ
         9tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778048882; x=1778653682;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=OLo+t5lOu/MlmjSgc8h7u8AZPltrnROhw5vm2jKBQjc+xsT3hBI6ERejz9HZ7/PTmG
         4ePGAtX1Cv4i2CZZOpRAFaN1bVCVfoZTOs+JRS9Rb4H9MPMt/QZ8T5uZDGqIY131RLad
         Azq/G9q1H1MiF5abn2YXWgOhkGhufQVTHyOQD1zWpFNurXPbswOZ0nWCaB3+q5/VDc7A
         5yBnMT7KYVkNkiwU3IBxMpgcfEJNrBY++o3791/uN7ntnRLHyQSZ9BCSYhio1qZSJWrX
         WujYDiTDOSMFlV9AGr0BTsX0/LwWEU3xbKAAWrzi/LYp+DHDpWBgoxuNCP9pHaS5HcZJ
         3JiA==
X-Gm-Message-State: AOJu0YzBYMzGmwn8CueljN7qkNeIkxSNGC2zJoFBguEnxcEMkjEA7/Ij
	R97o/eioEgMj+8z5X8cc/QBDKI8vi+kEy33u8gTj83xV+URDe4XPQ2m5WwPTYOWf2oT48DTJ8zM
	+XiBU84xg3fNfw3hY9Owk/Fi+Ist+mW7nUnGG+6C7AWpmgWpPmBQ2c870l0WUOt+4iQPiSI2odX
	3q
X-Gm-Gg: AeBDiesZAAu7fB3VHk4VQcRmAQpTnnpIZQ5Pxc3ug/Y6J1a+36MTlVrRarsol4XB3Ph
	UA9hSZLsjira6GDEK7DPJS713+R+TGQoYz7FSbFVdXAfle/m5zEzFXrge88WrFBYtiPumharEDI
	oblCHq9JN1BaE+BBvRimdjp6qtFqPkOzubp/I4FU/kkc2/LnlezbhKBsfPaUtPCli5N1Ndlq2sT
	A9npKbrUmPLrZytDJwk8sG+5c5/xVZkOx4WLvh2N+r5EjaktR7JrtLY6J7TfSmGL1fa+8LI03/O
	kSd5BOnUBiTMiO+5SE4gbD7iUe2qYGhoKOFgObV+KJOBOiPql3349v3Kx2RKR6ay+zAteTYOsTY
	ReVCQDva92DsklSkIeBQQZ06qwrMeUcicZievfoI=
X-Received: by 2002:a05:6a20:9392:b0:39f:24ad:acfd with SMTP id adf61e73a8af0-3aa5acf9b6dmr2075910637.53.1778048881462;
        Tue, 05 May 2026 23:28:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:9392:b0:39f:24ad:acfd with SMTP id adf61e73a8af0-3aa5acf9b6dmr2075888637.53.1778048880920;
        Tue, 05 May 2026 23:28:00 -0700 (PDT)
Received: from [10.151.36.91] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242acb8cdsm1073856a12.9.2026.05.05.23.27.59
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 23:28:00 -0700 (PDT)
Message-ID: <f3ddfc01-fc75-4773-a638-4fb47490d080@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:57:58 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mmc@vger.kernel.org
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2MSBTYWx0ZWRfX4D2RysDav22q
 JmB7dW4ZqluKepgx6zP9eW0pzekHUwLtdYDNs6FdYJclkHQuN0CMB5n54Tw43h/y5Z4CXbnDY9D
 8hXxHKRvQA8SloO/JG/TMrQmD5p+QzTNC0Gg7Az1wKlbWjTtjxKKdao5uLNjX/cn5qmjjaDEBTb
 PAc93HYeJfrWVM5tUL9tcitPLlWHX8ygSlEySFyxuOXcxfEWMkMtlB/dEBR9o4nUJRuZ2wZLQZv
 2rbSX6Ps6Ejg0+cpyNML+/8zt2dV9m+w1ebRTbYiYx1ktzRX/KFk0jt1mxefQyeFbMXTcLBVJmx
 YjjmdzwwwbK2VnAG29HEBcCnWko7KVAmecwg4C/UPnAQmE/ZE0kDmCrdY9pgnciqCcj4jG82i/I
 TBhbLwIoliRJlUllKIhSv0r+VsWBAS7vmkTMSq3PEROIqr16+n4Mc6Y2lzFNVNudLRxQ2cqNgOn
 HpsHGiuRqdIfsap6rRw==
X-Proofpoint-GUID: pVkif38EXSJXH4H04ITMp4Db-tVzY4SO
X-Proofpoint-ORIG-GUID: pVkif38EXSJXH4H04ITMp4Db-tVzY4SO
X-Authority-Analysis: v=2.4 cv=b6KCJNGx c=1 sm=1 tr=0 ts=69fadf72 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=JV2eVSZHMSyV4Tj97bsA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060061

subscribe
