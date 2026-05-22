Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E97409129
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460196; cv=none; b=bz+OrhSYs11EelGuCS7VdAVPX5MGMMlbQ4R5UK2prDxkZuyVblJLBCbiqqeaXqAkBCs8MhDStRho5sY23DwHZs3SsjsdAOLHPKo4Zpl6QNp37UhzES6MPFeDXEuybd0mGFa4/Y05eLCsP2+5E+TOiZ3D9xxwUL6Qle0rKeIVrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460196; c=relaxed/simple;
	bh=g7YJh6S3LOw4N2D0kOgN8qAMoXO76noYCCbV3Z7SoKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYlOGrUaG+mRpprUJ/G4CWL4gIyPICNInomymd9LOa8okNYFrI0ZZcyOuwkIwmblBisCkOEdkobdonpYcgcAcQpJnCrj4AGGnXeie/G99mG0MPEiSoc4Gdnd+Q7K7NtN8F/xwTG/nl2ZeB6+AOroOytbie1Pd7+fsCkk4QXF3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQGjtB+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TbmX4QM/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQGjtB+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbmX4QM/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9qmPj313099
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 14:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g7YJh6S3LOw4N2D0kOgN8qAMoXO76noYCCbV3Z7SoKw=; b=fQGjtB+bC9wPyIXf
	jE2JEr6EZab8eezHxz5Wvofhi41Zb1oT5FYhFigpWRCGTMQMoZnGoolykRl2zYtS
	UPAiqcxedSUPm42BzGtyVYXmtdeHVrCnxjvDAr6kIRlanZw08nq4J+lGpRfKGHfZ
	nBOqcbqk0OPBXIJdwJeHbxc3iez9BfamD4DW0hayb7zK/djWNUfwjkZTNK0JGsgA
	fZhJVfY2zZ/dBUDtpcwTyMVNhGII569jz7yumZQxqbWx0SnkKetN9QfIvr6Hs+lY
	PJypSsVdoaym6Ehj2Cf2EWouqR47dO76kIF/IBpIl3++Sva+MnIqzXPzB/p+vQHe
	OWBI2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88347hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 14:29:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba054e0304so67045355ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779460189; x=1780064989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7YJh6S3LOw4N2D0kOgN8qAMoXO76noYCCbV3Z7SoKw=;
        b=TbmX4QM/ScQTDyR8eIGQR8cILH3Vb0q9AAmO184YSlZOsylyLWhnXi5M1Iuoq0eh+t
         udarkDjGXIDOKCLzzj351yVGKaqFIEu1lCyTaOTo74Y63exNr1tO3j8VTqRkuVPNOwjA
         65AlL7XfAgoE4n+s2fTEtw2VBzStwssKGspKUILJMVvbBqUYmFY8IKBXlM1AEG/3GLkg
         LQcckxBk3P0BOg7f3tGk/k8xN4FcnURPTaCZrv9nSWjjne1ACcsbdRDGflhqjbCzW5f6
         S0jW/sVVRBFbn8aiSEUSEsVWlAJQl9XtJVJXp3dJGXZXP7XNp4ZaYp8VFe7OkJBWBkom
         WAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779460189; x=1780064989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7YJh6S3LOw4N2D0kOgN8qAMoXO76noYCCbV3Z7SoKw=;
        b=smkhihJnr0lSKat+503ugWyN5N5aeZKNIy3cFkoj5lu/PmUZ2nlKpK3o9xqEvDQMS7
         Qxbqrnp5G3sWwho9bXrfPdHq0WJxzQc8OyWFUp7KsscxvsbJ6B6bKh3Hnb5xoMdrsz4T
         /Mm/r7RrcFQUNMRL6x8OAvbKiIRITywY6C8KGdFb4ryl+LCNxQK3D37RUnR0RzofKy+S
         UjON9io7cYkvNbINtbEFh0mkFWt6EaGmfZJsMe0GYX1/kf9EwZ4GhLTYz9lP2hicGV43
         4388zJ6A9EWLjBK8wjRko7l4mSmaGqzNfLKE9HvXo3HBbmDGjfHGjHgSEkBoPUs8Kukr
         9xcw==
X-Forwarded-Encrypted: i=1; AFNElJ8OzTjcPNjNIsaKox93PScbCRQOBPBv8bjODCQn3WGbq12qMzH4G2unPtSvUT8kxdYMCs2dt+NyErQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWHNFjopzU7zAyVh0k0N9pYdxLJA7Tmq5zvTVd2p5WgYEzZuh
	vZ94D3uVAvGybgLuIbhI69AfGzFyZ+VbTLVhcTs2krV9y3GQM41v2VIPUtkJeFaGfccDN3nP+yC
	hPDH3DG4NKCnlz/4r114H1XmXPjREnQQ8qMIZNdiCIT6ZtP37PdA53dj/3r0Rmp0=
X-Gm-Gg: Acq92OFyK5TtRv2BEDZw0XrAtJInIx8hsDxLL9PSgFUk5imfhlez2Z/jxRmCuAXwHey
	q7ptk4NXLmwE+7CfjkQTa/Vpy24SocpiJyifJYrWZwKMPiNAmC+yg0P88hYCumNwU3PSOp99zRr
	gW0ljbke+2nX7GLZEUba22AeZAkoh1TLCzS5edOsyXpZyVMqbVrNgh2kEI5ABmnRms9n0gxl2Tc
	Qx+gwsZ/Hu1kbM4WejsANnPP1IBjPk3avCkitp3DcA+4wZsPDxBB8jIwGGo60ZPR6wZChBKZOZM
	x0w4BYMaemlAnQi7GHYFk0D+o8hveIAY15WchikPzb7fP5/62OILCXeIF0FYC4d5sGfvfWpCD1M
	OQdCPFRy8f77KB+RZyxhrJXgwMru35YLdT7VrZzjmdAMXcwL9
X-Received: by 2002:a17:903:11c4:b0:2b4:6597:44d9 with SMTP id d9443c01a7336-2beb082545dmr32146945ad.8.1779460188793;
        Fri, 22 May 2026 07:29:48 -0700 (PDT)
X-Received: by 2002:a17:903:11c4:b0:2b4:6597:44d9 with SMTP id d9443c01a7336-2beb082545dmr32146545ad.8.1779460188216;
        Fri, 22 May 2026 07:29:48 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695c4bsm18520165ad.15.2026.05.22.07.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:29:47 -0700 (PDT)
Message-ID: <293cd6ff-3b69-4448-a493-d2e72a358cbc@oss.qualcomm.com>
Date: Fri, 22 May 2026 19:59:41 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: Add Shikra CQ7790M SoM platform
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
 <20260519-shikra-dt-v2-3-c01b90fb4395@oss.qualcomm.com>
 <0b1c66ba-d841-460c-b702-8b4530d56f73@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <0b1c66ba-d841-460c-b702-8b4530d56f73@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0NCBTYWx0ZWRfXyg4gPe7sJKAL
 Lw6m1qQtMbxp+JPUSFYMt3sjEcgIITrcPSVX4DgmPR9jAbDP75hEzg8wYLV4/bNXEA4Jlnait/d
 mvhIJNBPyrwA+c7kxY0EX1tJc7biFlqcAI2a24GvJIG94Uk+S1bV6HkMZBiIAJofLOrYv9q/xET
 3QShc5WOcA2qFx2EoPduF6JqjH+I6zMHMtMFQZqptB140CfeoI/TK7NYrD9kB1HhGitBk33gD6J
 /FIifbX13RvX80z0RQT1NZ0PYoKNiLO9ZkDOqh4bPfVjVyh0ZWfs9Z7XIKv21HmXN6gOvpkJ2WU
 +vYl6Mz3e7iBuyjH4HUpHPBLokuv/Oe9AjvtGmUSh5Xh/5OZ2u85Fo1hLVbC1LVIAexYLjW8QT6
 aXKnQSMcXZ4LqlTyvm//yaFT3gDMW4hg10DbHzsLXfws/Ugce2OtdRmpwItAPOhuC2MFyX+c8bt
 1rH/gn30EoVyFjfCMgw==
X-Proofpoint-GUID: YzL2DCVzXm4YqJ4dmLCVEGlGXRldg4Yb
X-Proofpoint-ORIG-GUID: YzL2DCVzXm4YqJ4dmLCVEGlGXRldg4Yb
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a10685d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=rqZrXzn3qAiNiV10lkEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220144


On 5/19/2026 5:21 PM, Konrad Dybcio wrote:
> On 5/19/26 1:21 PM, Komal Bajaj wrote:
>> Add device tree include for the CQ7790M variant of the Shikra
> I don't think CQ7790M is Shikra

Thanks for catching it. CQ7790M is Eliza. Will correct it.

Thanks
Komal
