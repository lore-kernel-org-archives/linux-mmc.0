Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E09248F7C
	for <linux-mmc@vger.kernel.org>; Sun, 22 Mar 2026 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157509; cv=pass; b=HvEP/3BwPWiMidbVHd/UKggifhZWcoVmyYEq+tbXSARDSSeisHT7jdf9rOIvQUWsZDDf6N22ZI6ShAfOcXW6PEL5sID4XwkjKYN5lZ4HLMv8Xgl4mTDScg8caYRbx1v4yXqpUFYjFU/AHn9w1S6FKj13iKTkVctDqikQUUI7WqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157509; c=relaxed/simple;
	bh=KXSs/HcXhWiOOPMswor3shOWBLzA140o6i+GUpk9QS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dok2jfYEke9Xh0NnTced+7vMU9gTuJaRH7yWN4wEaiIAqg1WE9aDiIvktEs4zucvxS6471ykXaz/B8B/dgS4q0SW5I9iSFEg6jwWkYrVpYQjWITwQkXDJW2robjTVAvlHZ0/PCyNuwUsT9Kt1Z97pbSN3Fd32XCw7whcEUnrzK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYnzp/4X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BzCRtYqp; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYnzp/4X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BzCRtYqp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LN064j3394782
	for <linux-mmc@vger.kernel.org>; Sun, 22 Mar 2026 05:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J0ncGstOKXnQJs1g/XjQAdRNbIKLMqFi7AZ1Vp76DrQ=; b=JYnzp/4XVMdkbgnC
	Ue3e7Q2azYQ0ehRD3mX08BeSOxwqD+1iepTPeyBtcRg23ixOXAXzcPRoRZAkkNvS
	oRJGyQxtbvBkHwLZ6HMA/YU8Oszb1H7GxOmY8S4ldynUEZvg94dqX35fn0LrBWsz
	bj05Duhp86cl5zD745UMyTBj2sovnfu7rQDJhrcvUCVDTLNmXYLwX5IMmB4gCHaH
	+SH56gHLzBLk6nR0F09zX8n3Zh7FhmlEeiYTa0xi8tAmL6NL5E8s90hNFAHF9W8+
	Wxviw1cTk6QjC2oRoa8XGBTlSiQsxKGXCBSeSnSNfg407zDIqGOsdCq1HYEYIERM
	zv4IDw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kdu9vet-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 22 Mar 2026 05:31:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0cb775215so68486126eec.0
        for <linux-mmc@vger.kernel.org>; Sat, 21 Mar 2026 22:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774157506; cv=none;
        d=google.com; s=arc-20240605;
        b=CJjtGm8EA1MXzWZJ+wGTXuLfjKeyl3DPjfxztv4m2W9yCFz7Y05lls+wTGsCl1wTnh
         BkhBTIuKJ8os5ueThqn37Yks9NBMuh1kTXquTfJSRXG6RsDeYwRdLoGDmyrtpGpPi1lg
         sd6/I480ZMnsLSiqFIFWk+7TML4PBtpc0fdgz3Ow+7aoakvJpw3eJe7m/bu4paYsqS0p
         eUM32ayzMRrfl5Z0d8Yfu+p4A5yN/a9VkacnFe7L2Fm9styG0fB6ywEPUiURu2pPf9tI
         n2EHeBBe05AoHhmV+Hp/xQtPBFqg6VXB12FNBN5Z74RfkwAVrmlka5466zandrJLbABX
         /BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0ncGstOKXnQJs1g/XjQAdRNbIKLMqFi7AZ1Vp76DrQ=;
        fh=4Yi4VrrY6rSDrBO7P6AtyulowcWS9ENM1wMVYgsQ0VY=;
        b=gVsE7okHaBkWQE4+8OsLgsv93EI7QWxy4ObYJJ1fjMpKadnk8/88LRs/sW5M8GRPBV
         MguEFqYJTyG6RoS7+OlaIkfEqtZFZnPLWIOjjzqi8pKpEDvRq/ExnIblSC4HZl9ZhFj8
         pTpbwNItC3Dw1NUWur6WKdUPfHHR8fsN2HVBxll4q+se77RGoDqCCf2uVVlC1o8KKFRn
         3BVkztpyEXpjeiKcOd0diSx+DHQlLpnYDUdDQjuaKM1wtCBqkk9X6IEH62lt1y6colQn
         9HDdZe2dLuhK6yOK6mr3HDt2OuosGUDNPnxXps0XwW9DeGHreOAe08MDcG2xRN9ZOLKA
         ZLog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774157506; x=1774762306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0ncGstOKXnQJs1g/XjQAdRNbIKLMqFi7AZ1Vp76DrQ=;
        b=BzCRtYqpHUdteTQMrH8UiEJEpGCys5keMQz4Yy55lDlUR3K2EnatCXSznyjDf5lb+o
         4h0yiyZ+36luAZqV/HHBBpva0kIVyC2t76qIndodohaVAgH18udQl5kHffGHlhb97Wnm
         mjT15aqB5Ouqz2O38GGPYPBrM4o4MV+SwAPxyqnmbPAAlvH4Of8/97VXVdMi4d2/C6Fq
         OvqQdjlyQ/Ljzl4xytEf6TZRb694Ne8hqRnItCM+vAlk3jFw2QOkAlQUCsjjXWPwLVkD
         roQL6/3xXWHStp3td0kbrAuuViOSQPvdMoPGwXmqF33F22CRPUOCaX1Ue2dxtsboAXo3
         127A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774157506; x=1774762306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0ncGstOKXnQJs1g/XjQAdRNbIKLMqFi7AZ1Vp76DrQ=;
        b=QB254GCEmgSmgPiv0HSfZ3lX6ZiAAMtaZlvWBPzJHOwjFdZicbhdFrWq+BQFjWx66K
         XEXPlquE3x6nfboa3uwDfYQGjllRo0Z52Eub8pziWu9oN5U5SjvcIcMTfLTSw0OjOShX
         YwUrk2eOC3/JFUGtEADj3qv4Vx2QuJcluc8UlTCN9JJx3Dqke3eenJSC1blGivf53YFI
         xU7kQSA8NZ4wif55OhYeZdqGQKL8sLFcmBXeQCCwtV82YJTnJ/E+RaBhGIP4jhQVRZW7
         3bJrLQATdQ9mH4edqJE4WTi7U7zOiEHl1X3xLaIw9e9IlFOjSZ/2UcboAdwdOS4JxcFI
         qddg==
X-Forwarded-Encrypted: i=1; AJvYcCVr9UedsJjUWdUgZSX84e/RMxVFjaESPiL/1ZAtyEGwBuN6wdI9w9jgX5KVvYxjf151+dY5fhlW1c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAJ82MeCFgWtyOAt6Lj7yU2WvLGwc+wGzxFIMIBI4+nLh+jRQ
	HiJLuiv47JpN1G7w4SWPnQEJqr/S/CzSUsjlRa++DPFCtWNtmD7iL+GEHuzcowfaj61Nqj/Nnma
	hwsfAniHSL1pFoqnp9H1DRUlj4Szz2mbnJbrvYGdkiauPPhrD3QdwBIAHPnl+tjbdQ1XNnIMv/8
	R8ecvfDfE3Mj4SHQ9RoiekyQByDLazkqYysGbdqg==
X-Gm-Gg: ATEYQzwJ4FLCSZM0jfoK5Ql5xa32yHxoq2baiFEvpgMMl2Bo+fXf90+qCYg2bHfwXqQ
	KNJTHAhXp/xFjC/yJH+ktAXWuASrtgDegLxoYWbn94k0aQcfohNH0iZDZBiUdJRA2UxI9nZv95k
	k7IiJjJ4+/PuPOO1tlgoHBlss9TGzF15Y1aXnxKQpl9m2Jc75RxBtJytyL8i0qU+VAxR/4SSSUL
	bsXLME=
X-Received: by 2002:a05:7300:5b88:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2c10962a891mr4064909eec.13.1774157505604;
        Sat, 21 Mar 2026 22:31:45 -0700 (PDT)
X-Received: by 2002:a05:7300:5b88:b0:2b7:32a6:82d1 with SMTP id
 5a478bee46e88-2c10962a891mr4064899eec.13.1774157505124; Sat, 21 Mar 2026
 22:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-8-fe857d68d698@oss.qualcomm.com>
 <6e33daf1-bb90-47d8-955c-12ccdd30ebce@oss.qualcomm.com> <84f1407d-62c6-4ec2-8976-eabe66c74728@oss.qualcomm.com>
 <6679e85c-4eef-480f-882b-c64f8d0eb1b7@oss.qualcomm.com>
In-Reply-To: <6679e85c-4eef-480f-882b-c64f8d0eb1b7@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Sun, 22 Mar 2026 11:01:34 +0530
X-Gm-Features: AQROBzCzhjx0vKHwbPAUpiSfar1k4cq_wVtxI0SjsuisfOaHCCYWgZ9iiMzXYhU
Message-ID: <CAGptzHNyV=cFRyk=K=uXt+Jf5e-ONec8ih=h-Mr2x-xo_bmbGg@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: add IPQ5210 SoC and rdp504 board support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDA0NCBTYWx0ZWRfX+nvrlZ1Eh+rO
 SyoVG9GgCJVd1bAoWWCDGztcuJew8pznKRgI8EDfwhGQpvrEf5T2LKGnve8/njd1iX6yru1B9gJ
 j9N9xaHaQjBlCUIlYJvz3ryLS5g7tNjOrnEEWJrK6LXCquMcAAtVKuim5JtfJhXKcV2cL+oVUp7
 dvlW+/uAqwjVYknCNEibS+u0jTCVvBMbU2r798XZkJL643XpC8InlbvFp5dsPiEAYpFOKGh/Jqs
 153yKF8zeFqctlYESpckj3uh6QdlP1Z12XLemu2yeCM91WBMtIziUnF8WaC7eB7yj8hmYeB+lBi
 7wCHrORGAc5o9Lw0YmRpQo4c0LkLxGqcaDWxTLDouq1s5aePrAlnugm77e+xM/2oxyXvZa0NftB
 SUGEeYH2Mygw2HPOoBwOqk6UaH/2hR/O8XrXunEOz6qbk+PQTJEdET5ckTZ0MTqXDEv9clx9V0Y
 iD7gmrenG9dWqyr4PqQ==
X-Proofpoint-ORIG-GUID: rBiV4xlSDBhtGjBvGjFgZY3F6f99dmHK
X-Authority-Analysis: v=2.4 cv=Q4DfIo2a c=1 sm=1 tr=0 ts=69bf7ec2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=CIsBWlCQImJ4_lLhEykA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: rBiV4xlSDBhtGjBvGjFgZY3F6f99dmHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220044

Hey Konrad,

On Mon, Mar 16, 2026 at 3:05=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 3/16/26 10:03 AM, Kathiravan Thirumoorthy wrote:
> >
> > On 3/13/2026 6:18 PM, Konrad Dybcio wrote:
> >> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
> >>> Add initial device tree support for the Qualcomm IPQ5210 SoC and
> >>> rdp504 board.
> >>>
> >>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.q=
ualcomm.com>
> >>> ---
>
> [...]
>
> >>> +    firmware {
> >>> +        optee {
> >>> +            compatible =3D "linaro,optee-tz";
> >>> +            method =3D "smc";
> >>> +        };
> >>> +
> >>> +        scm {
> >>> +            compatible =3D "qcom,scm-ipq5210", "qcom,scm";
> >>> +        };
> >> OP-TEE *and* SCM? What does the former do?
> >
> > For OP-TEE, we have use cases like getting the random numbers, remotepr=
oc PAS and few others.
> >
> > For SCM, setting the download mode is one typical example where OP-TEE =
doesn't come into picture.
> >
> > Please let me know if this helps.
>
> I think it does, but it's odd that OPTEE wouldn't handle both
>

The SCM calls are the ones handled by TF-A which are usually referred
to as SiP SMC calls. OP-TEE doesn't handle those SiP calls but only
the SMC calls in trusted OS range. So yeah both nodes have to be
there.

> fwiw +Sumit is poking at OSS firmware for other platforms and may be
> interested
>

I think this is a WIN family chipset which only supports OP-TEE by
default. In the IoT chipsets there can either be QTEE or OP-TEE and
the bootloader (U-Boot) apply a DT fixup for OP-TEE in case it's
present.

-Sumit
