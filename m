Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDD3D544
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116616; cv=none; b=MZ5ZD9UfYPdL3o9WEmRHkkqcw7v73DUSjdpERNsGee/2mL48r5QwFEBtCgorrXtiEWJEMJVSuWB90l7sNGth9ierkfpeVLYywRlgwqVoJnWmsNnhnBIeCstKagIWU7FLxC+EyTq4r8NAOmtDu1VzORKZFmUVFYJ0x0/Q+UAH+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116616; c=relaxed/simple;
	bh=yd4psyy+VS/NkYJLOcH20PSirg8JRnX1pirB5TnCxog=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A7o1BTRDQK0ECeH0MgAivVh96DlfLsGuCWVfK/4i0IHtrdK5hoM95xInPLjmrGyOhRLWOIMPc8VqnKmT6ZzpEcJqg/v85JwGbwaXBwAbDkri+UcL/+ZMnaw0KgbPDcxH69JwK4c52LXp/2gZlo58FeTgXZrX+9Vkv0mK9KjFxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CerUh7/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCnVfEFD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CerUh7/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCnVfEFD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2ESfN1459465
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8O6dBf21XCwLby4yH5fsq7vKzQKO7Fo4MyOXqHzm9+I=; b=CerUh7/IfszCbh47
	pbrrmEpc6TQPGEzupR207C0cHPZkh6hZiF/2CmgdnwMi/0h0V/9XyZimVWCkCjz5
	HlPSs+6BzB6gJpY6lVC4xDNnPTxHAJTJrPBZOeSy8gLHigiZILCTFB98r/egtOrh
	moWHUCNQHJsPsBcuHgZjx8+T2mCkiCMZlQoYq/sj4YFhFNII7LxcyVEHiy468aS/
	mL5Pva9L6UTv0hNWdTrCynHBlcW8TA4m4fqjphiJQz9M7Px+J1mcyvb5/aga77wA
	kf/dv/FCCgvWK0O1Ge88Zx1f3yGpLaJZfcMTzAwp2HJQ5hk9fPzyIybS9DFG2hUO
	B06fow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy2mav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 04:23:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8299c57642cso22819982b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773116614; x=1773721414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O6dBf21XCwLby4yH5fsq7vKzQKO7Fo4MyOXqHzm9+I=;
        b=ZCnVfEFD6v0q0Cm8IpRb8g+Melto28RApE4cNug4X+xPPFINpEmrX4CnqOiJDHaQNP
         R0FG2sm/mQKEtYXOthfWgTkFZCiuCylTpGBiZDHDGEHUGugegopoOqwpydSL/IONu8RY
         iZknZnD1/Nq+/BJhASjSuqTCgWqPUuw5A0lqv1Qsq1KFLgkjDr1N2zlIU9Tzj3VP/b9z
         2qDheJfTtLd7V0O/LnGS1W/4JmIvLg7wwem/IfA6zz6VpYioBsznTRSrFXesodSvSNHk
         ZT5udz8ZW5FFZv/3nkm5rQRjljgJd7LmSdwxY7QKyctgWf1Zdv/sR7Q3CCH2Uv30HYj3
         SIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773116614; x=1773721414;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O6dBf21XCwLby4yH5fsq7vKzQKO7Fo4MyOXqHzm9+I=;
        b=iRl+1RTZ0CDZ4fTxqKPuXeJ0Wqkdju00LpiJ122imCJa2dDCNlkIcgQfbtaWJ3abiZ
         RGdfoPG8v9UWaZNfxlxTS6U+XqKB5m9p6UXEfWIHXaAgigBL1Rodb7HhO4/Kd5mX4k9X
         8lzD06wO853WQn0EOUrUxf+70RFPVUQW1JkInmOUay7Xojbb/MOX0g5Z2+TuZ8mzcXf3
         kQr6h8akIH8AhbfjN1fvI5Mq7TkpmYlhzBdfvMXuArOmlp+nvLlNorP64jchW7QNRDAE
         0kHaTPpb2DsR1S0SDbUv56p11UkgxBCP1vkFV6oJ52rlncoFcJjH9IfLTDzpaGmbprPb
         ezgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlb8JAvloYMYAVy+v6OXVxbZOdYKpIqPIHMbNxC7DirzGl4ToyuNetfJDiE41z5auUkFuAzvxVDYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1LUJMpCk52smGmk/g4I49dVOtuJI33SG+XeJ1rdyEBcjzL3V
	aHpco5hBco9j3Mql9k9nzyFIO6DLLGnudWkY4Or0FioeE9c+9KNzb1QEavfUhB14mvy+PmMEUF0
	h2mwfvjEbK0OQHWxT3/Oq1GM1kioFKany2+oM5A+a9rF3PmwBe69fLGxWdXH35zo=
X-Gm-Gg: ATEYQzwN3vQvj99bnit0r6Efm6QHw5BJ+ZZ06EfeY/K2nZyvSi6vas4yj1Oe4EgO4b9
	uRe6+Iy5B2bPvfiw7Kr/CASvXoEBzsrx300L2bFyr/emYAyyDqmdN82NenIS4kZtThq9pxr8a89
	o81iCiCKaY9LQKjCQY2JCKNv49t9DmGZg++5o5ljWAk3PxulTBeBrWJmHmVk40jKAums6V+km6F
	+xEn/urFyPE0wKgmiubsPcv1zA9vK60Y2AVxxtcDqUidpRbyK7nX1AhMjeiX8XkSEWihMZ2bokk
	PodJHk+a7/XjxzRgmpHDy/qFO9YNOIQT4SANy0epq/GXwx6QEZd+X9r/GSRtISEy2lie1hs5+4m
	fTw1+q0IhL4y+ka98z8r5ksMXvcFhwXNQRuT861yXoWblJiLrMQ==
X-Received: by 2002:a05:6a00:3cd6:b0:81f:5037:a318 with SMTP id d2e1a72fcca58-829a2dc3838mr13185142b3a.21.1773116614397;
        Mon, 09 Mar 2026 21:23:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd6:b0:81f:5037:a318 with SMTP id d2e1a72fcca58-829a2dc3838mr13185113b3a.21.1773116613946;
        Mon, 09 Mar 2026 21:23:33 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a467239asm12382088b3a.26.2026.03.09.21.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 21:23:33 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: monaco: enable the inline crypto
 engine for SDHC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
 <20260306093332.4193993-4-neeraj.soni@oss.qualcomm.com>
 <20260307-wonderful-vehement-macaw-33b6fd@quoll>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <09d09441-3495-bb12-8d9f-31effeb714be@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 09:53:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260307-wonderful-vehement-macaw-33b6fd@quoll>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAzMiBTYWx0ZWRfXzMGFt+BStf5+
 A6Zyvo8tkQ3JH7sC35dEb8BzYSsOqFlyIMBUXiqeCaRgyiJ7jaVVTgKfEUml4tJ/qKjRr5T55Nh
 aZ0kvDMkvsYOnX4PjEBB2GgLrL/r5dhqM90G9YOM49hpF1UsUYtRqV+4SF4Oip6B4uTPqnlMcZL
 Z8jAuNvO9L9bzvJiCSfRwbGcmrkzsHlqnFFdzibmKVEvv786GN12gMmK5grzqtBKIlBT3B0d23z
 LQcSqkWfavmwcE1/UYCsgfiTU57x46hLk2MCp0DIj/QJFHMGoI5UquxrhE/LmSXq5/1LCMsVj3O
 IU5Jvah384M6yZsVxuakvp5yrU5Zq6fNyIjwkv5MxvLL0TLj72FoF5rJ2xUvsJCVZyBMVaSyfBJ
 DsGyF1j4oAwyUVKJXjweZfwacK91QZdgfIG30nfHyFWSLulSqyQiU8YU1NB0OLwJHzMF12tnLvO
 UMPPlgQaBa/DlEXGiiA==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af9cc7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=niw1k7PmRTl2Nx2QXY8A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: QIZ8Vg95KjasgEVdKSTh2PRuH_svzpHX
X-Proofpoint-ORIG-GUID: QIZ8Vg95KjasgEVdKSTh2PRuH_svzpHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100032



On 3/7/2026 4:07 PM, Krzysztof Kozlowski wrote:
> On Fri, Mar 06, 2026 at 03:03:32PM +0530, Neeraj Soni wrote:
>> Add an ICE node to monaco SoC description and enable it by adding a
>> phandle to the SDHC node.
> 
> No SoB, broken/missing DCO.
> 
> checkpatch also would tell you that.
>
Sure. I will fix this in next patch.
 
> Best regards,
> Krzysztof
> 
Regards
Neeraj
