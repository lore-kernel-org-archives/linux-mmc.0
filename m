Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5630CD80
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048770; cv=none; b=rvxlHDv/T/3GhG/Clpb0b0Yxn+ZOaxOWm6TwNLt8PhBsQFU+E5ZH8ORYK/WvUTVC0QkT9Dgg6oF76wAtFw8oyzxQckVat/Pqg4/sUMW6ROh7En8DqfXwZLOlfXiv6a9w3LxsqxMtwb5zF3ZGNswgOW3qrG1tUqmrWTBINWINsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048770; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=pDOtnfaJQtsqq7+y+IlhMtSbBUQcjW4QsQiifXNAoRgMU30o+F628az4m0sEZ9KTvUFJOR5xnCiZOx+ATqAPeoK6xKCIfvqetZz8Qj/QXDHR4E4hCngOV4gpqOj5Bu9ZUNKdT5uTMTgrPCfAthvP5Ri3ri5in+de7DBEEuKBjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvXFMnwk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEHYQCSo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvXFMnwk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEHYQCSo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645MWGNG912368
	for <linux-mmc@vger.kernel.org>; Wed, 6 May 2026 06:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=qcppdkim1; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++L
	fAOrCAj6OvBfk=; b=YvXFMnwkIr7cQoRwQcz/UpaaLBlZ9/7Ad0K9aMIfoJCxSN
	NYWZfqc7rci+cXzXSpoGo4sycDbV8N8vO86b/rnvkRSbmx9ZuUcQPMc59PcrkoRn
	w9xruAiMGeQZ49K4w1kkMlLgwcz+eT0lUcQVvxmJWPBkwPqk3F6lKqGrwJE4YHhW
	p7G7mbv4Mwm3SMbnM/1/mi+GmLvV4VSGLSEKNBEaA7z3CYIVY5ff3VUDaYBTrGR4
	YtbeWmvENTMWJ97sc8dStC3d0o4btXkuJUjBIcd+HFaAPpHO9rXYyc4VmSQ1tDdZ
	HBOw1SYW6IVMQ1jgQCinaQx+Z4VUuFmegCWvtoYw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jk78e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 06:26:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6fe41283so9482565ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2026 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778048767; x=1778653567; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=VEHYQCSoiSMMg9azNjzUngWWBgNuGN2VbZPWiksONrh8ALd0jm7pBwY1GqLFuKDiK7
         wXePOm9BiLfWw/tfYmEbiSBG+bTVob/KykWai+XoVujNi6htS4aJxZA9RoonAnT6fUGb
         zL8cVBl1l6oMDQUIuZw73YfQDkQFp6RO12YdPzc94ZIR9wVvSUCS0waz6+/qavx0egsn
         lr/r0XWAjA3HRKOoILHSOsu/Z2VpV/WjClAN0nST+hmGBbY7VakJAhMrgpkzVXYyfPFO
         IuL/d1H/9zEpKDsTNa/S5rZ3oCR2v3OfqRboEuMRmcppCdAqgVr6uxOCIykTRC1eNRVC
         Tf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778048767; x=1778653567;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=rWDr7CWjC4ZiK8O93Y1MnMBl1dVQ+5Xb1I2BJXxNw7KDv7UVBc08G7Rb9HA2+cp5ry
         iN8hRAVNAlboijeGkLcuooJ/X0oDoVSUas/j2XQQZBc/DTgOeBoGZUORKV1A5LD0rOt8
         8++77KdyrvNrnLUtqiIy+zCpEVisD+zhWRZVaqxkbFd3Gx7VyBhnpY6S6QFUTHiUTbR1
         wv5nc0OGeAjW4rmZbMp9lu0+LgRBTuegiI9b9Da/GnfaVS4Hl7I6QneZ5OEVRf3td3VZ
         qlNi0Qm7gM1SPU+tCyb0b7wrXqkOlsLN5bJ1uzmup345mX0jODnoYMrtKMDUotPZa6DD
         pvaQ==
X-Gm-Message-State: AOJu0YxHxrZeXwtQGzxctHOOkgYaeYhfXOGLEkMOFYcvcIR/k3DLol+S
	YtL7KR6OAn0IH4NDnBGJJ0cYnaCvGFSexTC1gcKDgIMzhBQr8Lmtml/FYWzSGWw3Gr0sHNBBylf
	XNe5aaFshnSiOLcY7VuBqNE2nKI7YV9bjA8uxnKiGA0c/0lL845lxUopMxKf+PknOeTr0cfVejk
	7G
X-Gm-Gg: AeBDiev6bd+6qf+kv+xhnjSlLO2V3C6iwjLh5w4LEC3tLFtcgs/IB9zEy1NTdc/hNUG
	WTji8z3lgHyshujoPTT1Elq4YdHe2l5v2C8e7FxDtT2PJxbURGLxzZVha/IwiQwBXJ1A3xqlKGk
	EnnPtIe8BYR6uLn2xqi5oyoFZo0fnDFIqjeuNhRtrmsmRNxlaaj4W7HcKjMJmacOZlK92agdwKg
	q9UlTM2vS0vTx6ZsRheCoApB+5jWT2ajp9jXbNvLsgdURRgs0P0bBklQOi8YkGiXWAbpelv6cAQ
	aJGITJBicrvUtq3bNU444baXXtagw1g4ii0gnoBYfx3ttbkKmEhfV5wdIA7/Yedu4RmQWbJmxK+
	i6AwVQju2a3PAlC1jTbqY9C9XijmRce/RwnylaoE=
X-Received: by 2002:a17:903:11d2:b0:2ba:2e9d:55db with SMTP id d9443c01a7336-2ba79c10319mr20042275ad.36.1778048767283;
        Tue, 05 May 2026 23:26:07 -0700 (PDT)
X-Received: by 2002:a17:903:11d2:b0:2ba:2e9d:55db with SMTP id d9443c01a7336-2ba79c10319mr20041945ad.36.1778048766765;
        Tue, 05 May 2026 23:26:06 -0700 (PDT)
Received: from [10.151.36.91] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bd2bc91sm12382805ad.11.2026.05.05.23.26.05
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 23:26:06 -0700 (PDT)
Message-ID: <2c73fa50-0e00-4a56-b963-91d015ca9346@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:56:04 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2MSBTYWx0ZWRfX4yU+7R/MAc8l
 SLtU6ltvDuXRiwv5J+ap96JDl1ac3xiwZVpMHYwonmjHKugmcvOgVgnQ++Txkbp39hQEfMGz+Fz
 wtR2vov200fnsQLf3qa79RzrwPuuDKf9ciOQ/o2hZRiCF55YOvfgHlzfITwqw5VPebMpXn6Z8O7
 fwAHrhx8pFfW4rx8kr5nUWa449IWeFBWHi4ELAjWdYQQ0HG114I796OO9uCwF1RrwfLbaKItpWj
 xwVwMXooAsZ8nVDo9iF2E2d8OZphYOHqJVHw1LTurs1aebXi8PybNuptJOg0egvfXnylGK/d2d9
 fAPxQTIPpMYqFe7ZUZ8/8/8f+mb+mqhIgFd6zlZ3KA1PBGnOeOB25TEVhU/rreeUzYRiTAo/ksJ
 WpjjcxDsYvY1yrcjZibDtEWa4E3LgMpS5tcmBobbQkIvEyIUintB3xozxZ5RNgCRwoewx3ITxt1
 XlgLf9VLMlSLX6cddKA==
X-Proofpoint-GUID: b27aEXdydGR4_7mm5GfIE0xWRzPbuKvO
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fadf00 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JV2eVSZHMSyV4Tj97bsA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: b27aEXdydGR4_7mm5GfIE0xWRzPbuKvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060061

subscribe
