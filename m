Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812233;
	b=x8kC6AIK9eu4EV9BMOKXOkaQKqNsr+loOLhR2uf96m4m4eSEcufEyYFGC/NuhA/8Gnj/
	 B9LnjFFaQE5qpxyDjZYxV/9ZZKOKBr4i6YCqSdDBO6Z78E3PEbqE26vHvQBYNjPZg8GSa
	 AA/WEPdRRrKOwTLKYsdxgFGNa70Zuz2xXgMIJmwgl3VLWcUmRMvl2UWdiC3UOGfnnb4DM
	 +8HBt/34pPEaChm744tEWSHVrs7vkhrqrAfj8AhUM6awmqfLxVkHEWiTibixHk5OD6a68
	 8UkRfXdsLVnR2gz8rc1mgFSzRd0hYcCrr5I7bi7EShK2K7W32Eixt+bhbiBUdPwTz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812233;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8kVbLa2hYPiQsN9qOzj3DO2zSgYLfY1noEtwJGDEPiM=;
	b=L5VH4MCoroS4kc9p3mSvdmzYWpbrFD8JlDEKgptlrk6dxJ/zyRZECSinOppSwcd57b+t
	 4eQiwKkmGLAPaRlr2d7KSovsBmTA3WXkYRYfvabgYUsECpLrFmqlOgMwWqndkoMKj37bv
	 aCVKh0gOcEF12FczDhdq/b/z/L065tpNotcoUVKN4g+xOtecjhN1MBW4oppkM2DVdrZtA
	 FqCv8kDJma6C3hFi5L9dUQ1rgKhEKB1YDzYlwravxwsugZ4sT0GRaEAqj+FwiYyZYqOjD
	 2QeIBR5/hOrF7bvCLFAvDOVNd71VPHrNqQwgV6Okx5V0yomc+uO+6Dl0GrjRjIqOugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLCw5W7Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BDG8ylHP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4292606A323
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 06:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4292606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLCw5W7Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BDG8ylHP
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5LVSK1585502
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 06:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8kVbLa2hYPiQsN9qOzj3DO2zSgYLfY1noEtwJGDEPiM=; b=FLCw5W7Q7NkeVCGU
	yuUOnerr82EOmNUhiSOX2nGjnVGRAMsexFpHYCIfr3Ha51qinHKBh8x323+XYXve
	L9f67DnSziCuEMlxEr34fazeYbkYBDMGw9F4qZooZatHME8M02cujI/l4Wvt+hHM
	KD7wzIusA3EAA6SAAaQoMBDlWpxp4Xnf1nmTxGtagzqsvuniB4fb57OCA3fE1LN/
	HgpLtkLNQZBsO95/Fqedn6PPuyi2nfNUOcbg+Vem5TdgG3HJxaLB8b33/bHwisCg
	j1v6fIC6QPjQTiUQrx/pBdPjV3J+kRNcmXAY2s/873c+QJZZBMv9dwCNLF8UjlO5
	L6NKfQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdw5mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 06:57:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so3681993b3a.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Nov 2026 22:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794812231; x=1795417031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kVbLa2hYPiQsN9qOzj3DO2zSgYLfY1noEtwJGDEPiM=;
        b=BDG8ylHP85zP3NraEzlVsFnSt/VhVC2pTmVrULFYefJUmRT4S2rHMjovPPgJ2XuY4F
         JJKlfhpDp+906ZcAbOQm7U/TS6CqfRjMyAUxsyMXdhc7F//V5tWP/GIOT9laFoQt42r+
         jPAwusWs1aG5w8Fc3L+yaQSI/wHl9pDG7Mfzt4CO7VrAZbA3+p7F3fcTl/OUgRlpUt3U
         /+XeownhoeAaFfvBY1nRVUJRYxC1Vv83oRnNNQNSzGZCTWV+xFSYqsght28QmfgwmGxe
         dEVgnyluBOUwYJJJbOrxmc1YbOdPyz0mVyLyD6/jupwTCwMaYm8By8nQf8ZAmNeCJom+
         tWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812231; x=1795417031;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kVbLa2hYPiQsN9qOzj3DO2zSgYLfY1noEtwJGDEPiM=;
        b=CKgiil7Numr0SycGrjaQppwQ/G9KHsLeqvMOOgOprs0l94NZcMqhipbUSZec5jg+AR
         s1PN3OT6Uj59VZXbpQU5ABW6meB5A1jccPQLUJbPyM9KIJmwxuHZnodsLRwPkret4z/B
         i0rmkn/OHRBJjwzzROq9/4BjotZe/Oals6ZlTodZ5h0lWCbAqurZ5S2x/J58drZlwh7k
         T/wgOiAS9nYmyDLQ2sUm49MgjQ4lIgzDGICVLsPF0n5w3WOCFnezKqOytlmf4BL5sLYG
         lnPigLq7Cv4lNub7tgQSxgzlLsbJogJOEqIp/Z9VLqgMUkJAezeBRztEz1xPGVN53EPD
         CIAw==
X-Forwarded-Encrypted: i=1; AL+hErE0xydjFYT0mcmWSggIZMrky2mduf7nRs6LkC81W18SLt4wXp6PUFvTNZsbiiPZftBbLfP5vgylXz8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OKJa1uli4PaCd5WqhRFOWyAqx33jqWjDIFsjevgfF8oggktdE
	NTXbTTfLSbdfRHuy1LCzlWfiJagXrjxjpG0XAcxaPHoLdOEMyVpRjfsV5xvOEKfjKI7ylTMKNjD
	WMwhF9F6x23Z+RoiHffijM9A8wCLJ4JkNwpbOhGEHDcDK5d78XgLlBAHHzHpI+LQ=
X-Gm-Gg: AYBFou3UgrMsliL4SJt++pdc7tjAspB+nDUa64RoQialDfdO6w7esxfwYo7IGaST93/
	WhnoV6RKusBcpf4zhOqsaHZm53iXVFz4B4J11KOJgYdaWJvf9EV9HWKmkRO8LEu7NZ+yFe3P6GV
	tjMTVKqMOivPxMZ9fBn59MzkYTaIDxghJyWsR9Be55GyWYbyRn27vAJwgcNiSWbfwsHLLrIcIDP
	YD6Pdpez4r3GYW90fY1YBtE+m97XW0Ee9rJjplbt/4j/1w/c4ld80jZ3mD4zC9G4mTlNJDT2vFJ
	HG6f6aTTWU0RVWcHdIjoX/TwLQHxnEkeovzH7m5Tiiw72Haz9ibN4TcRJgGbsdlIPxWiC7I/New
	8V6PzlqCe1TuSgJXjEuPkhTbHezYt1Ag/dGmTRzImJUE2J7Ec9Uif0KoGkT3KwCxsVXeXdIzK2d
	MVLMVP
X-Received: by 2002:a05:6a21:3405:b0:3e2:b15d:56a8 with SMTP id adf61e73a8af0-3f7a95f156cmr9720581637.50.1794812231408;
        Sun, 15 Nov 2026 22:57:11 -0800 (PST)
X-Received: by 2002:a05:6a21:3405:b0:3e2:b15d:56a8 with SMTP id adf61e73a8af0-3f7a95f156cmr9720565637.50.1794812230960;
        Sun, 15 Nov 2026 22:57:10 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c09fesm3754506a12.26.2026.11.15.22.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 22:57:10 -0800 (PST)
Message-ID: <304e72a9-2def-40c0-9314-0b7413e45e17@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:27:03 +0530
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-msm: Enable ICE before enabling crypto
 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
 <20261022-qcom_ice_pm_enable-v1-1-f7a84086c651@oss.qualcomm.com>
 <20261024182904.GD2553@quark>
 <172229a8-a4c5-4103-a38b-e4cce3f18718@oss.qualcomm.com>
 <20261113035858.GD1742@sol>
Content-Language: en-US
In-Reply-To: <20261113035858.GD1742@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afaa948 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=AalTVwZ0bjgfRv4LwVwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNyBTYWx0ZWRfX39fbNR7dslGs
 azxK8P+2ql5HfEaCHJozCCYtnJjSmQSWRbnfCKb20SVH3Px0Wv94tPooKiL7UmsDGqXhJYrlSAP
 4eueJelmtXfqEJzL7eV+lUOPTQBvUBI=
X-Proofpoint-ORIG-GUID: Z3x3Gop4HtXb7FZRQ0RG68VCSUVUfAlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNyBTYWx0ZWRfX/BuDXUEqb19B
 L8sE/LQA3jhBOtKUknZCeDHicC3L++GQQH/OfHhrvAgF906hjaM3Y4C/mnfFLYJNQULrZMX7/tY
 p5phy96q3DKMOdFiqEm0q0oxEUVMUI29/1ab1un+xem876Lc/V0qB9nRUf4uvF4s2dyrirq4HSa
 6oFi2a74OmWTPk4JwjO5LJpctW2Zug19xPGElbU5vqD2UuLQFQU+gczQ+XQLAC2lB+XS+GbmPc3
 5Gx3mN/woOtUBaRekqzjVFC5fsK+tvAWawr6YKzX9Lt8JE7cClydA2MjpieNlNkYm5KG17rhHZh
 sF5KWFZIREzO0l7IDD5FBgovtZ+RJ/EzSNjIgQ5RncEeQbMG5jNNiuaVv9riVHx/cqITGbpI1Qs
 jWY9fONatAigRzgsbT9IeyH8HO7TC4FMMSyGECEDMFAYniwovJzbrv6IF6C3j4sanY89ae9Xol8
 Rda+4c+PvACccPZCC9w==
X-Proofpoint-GUID: Z3x3Gop4HtXb7FZRQ0RG68VCSUVUfAlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160027

On 13-11-2026 09:28, Eric Biggers wrote:
> On Thu, Nov 12, 2026 at 05:00:56PM +0530, Kuldeep Singh wrote:
>> On 24-10-2026 23:59, Eric Biggers wrote:
>>> On Thu, Oct 22, 2026 at 03:21:50PM +0530, Kuldeep Singh wrote:
>>>> Remove ICE enable call from CQE path, since ICE is now enabled
>>>> during SDHCI crypto initialization only.
>>
>> Sorry for delayed response as I was away on vacation for more than
>> 2weeks and hence couldn't catchup on the thread!!
>>
>>>
>>> This change makes the low-power and "optimization" settings in
>>> QCOM_ICE_REG_ADVANCED_CONTROL be set only once, during probe.  Is that
>>> correct?  Those settings never get lost at runtime?
>>
>> Yes, the low-power and optimization settings are set once and are
>> retained over suspend/resume cycle.
> 
> What about hibernation?  We recently went through this for keyslot
> reprogramming, and it was established that keyslots need to be
> reprogrammed after a hibernation image is restored.  See the commit
> https://git.kernel.org/linus/8b190e9c0b36aac5
> Doesn't the same apply to qcom_ice_enable()?  If so, this commit breaks
> ICE upon restoring a hibernation image.

Ok, I didn't verify hibernation with this change.
Let me verify and get back with results.

-- 
Regards
Kuldeep

