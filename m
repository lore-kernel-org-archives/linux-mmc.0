Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0C47DF91
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041331; cv=pass; b=rzej0fbIla1XFD/bsRyVtkncsvPPCFRc6EewIkPo4QTaXzVJZLsgAZ+SmvzZYIRl5TZBH5rU6IR3/1U6wTgpbrjAVRVKj+e9FXoppPmiVE7Cp5ac738/DV2yqrDmN0TZXsm/Pu9GN0hTEN+iqwGOet7EsCgAHGzpKnKSove2Nxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041331; c=relaxed/simple;
	bh=S0FLkqwloJK80/wATJskq/ItQstxHs/9zbYL1VDZJe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlPv20XHkEKyOdLw4vwnjz22XqPhiN+/eiew9zuZT2ss2e0d7CsDUQ9F/zi7D/97t7EnsbpFPissQ+hbcqXimrw39Qr4oh1WZd2fJXRmqWFe4IyfihDgx98ttB9YwicRIgtt1hGgLIHAgawdOJ8tx3iUpl5e8W9sKJF/ALxeeew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHPr1df3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V/SX4Qwi; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHPr1df3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/SX4Qwi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8pwOe3998383
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 11:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S0FLkqwloJK80/wATJskq/ItQstxHs/9zbYL1VDZJe8=; b=XHPr1df32s7zoAET
	uTIuamvAgLFXlMPACiKiWZ//xbW0A6kjU/VhM2q6C3c7D6oBVZV2f6aXaCV9lAH6
	5/tSAJ8qOJnm0geGCARPJK8obnAULfLziPc6Z3l7AQrN4onfnVQj9w67MRmVg6Ya
	mge8GSdHsg5mmhf790rp+w14O3dKrUm/hvXIXUfslxlt2bCKNmkdwWVSN+sEQR/q
	KZ6+WnGJUrBcdOo8ldDS9ya/hANMJxBynTBClkoQ0eLSjk6DbC2bYH+ke9WQd0hS
	TadS8ibjvJiSQII1H4szEQl0MtOrpaSAy39Vim+4oA4kZfrgK7zYMhNXoboITier
	abgzEg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfkra1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 11:55:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso72726385ad.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 04:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789041327; cv=none;
        d=google.com; s=arc-20260327;
        b=AjqBJpYkt/BFEUU8UFBEffhkF43tilJhEbFANinBtoXAOhyISVOLyUIsK+qwU7aSvp
         4WfFDMzmx6o+KGzK+oXsE9HOkJnyPZFfgfho/g41K3fcaHDUdY4rEmx8WHk9DZRj6mdk
         3l6FmahY5KAMX3cAvQncOKcUKE82YwtUWVSe5C4/4gBACElDhi2uuegG+smiLSGoTa2i
         ZSlfluZRClCbccioLL86JKonCzyxiu74//i4vfJt2zcV6iDW6fqStyYpGMTGj8OBkBro
         WUQjexwBzuMM8zQTYyMmomqXLrXNrVlMEyy2vHGFj5pZBSnszYKYZY0pj2kGbgNDW6P5
         duwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0FLkqwloJK80/wATJskq/ItQstxHs/9zbYL1VDZJe8=;
        fh=IR8mz7G/EYAcQV9UodWwKRVTmTWypBye+7C/igJBsJw=;
        b=dVGNaj4yDcc50IHWcSwtM6hj6wBEc5nFMh20HG8ZAUE0ZDwJmwwyLs76at3d/1/P7f
         oBV81nmamFp9RJ/I31owoiKFJXiTYND4RJrkd7A6EB3LFgUlPsOkHMyLBr1Kcij0Pfba
         7EMHdDVCXSDlvXEm8kppAm55Fs+uuDMNUSxtivGKATfDvZVBOcO3rAx14glmeZ3lRRvb
         1L9DBpuZwD+Lh+BIHAttKPsjll3KUvxPoj0ZmrdU/HON/nzoM80Nn8zIPvz0/jg3/eUs
         BsLzUclechqYm/tM9nBR55nCkTUrg6vj78wUl/Bq709dOP6rPcDIiYyjbi0GZszeGsq3
         LkMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789041327; x=1789646127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S0FLkqwloJK80/wATJskq/ItQstxHs/9zbYL1VDZJe8=;
        b=V/SX4QwiKMYIJu8kShQShDZuHOLEghAlBJ86uwtp2ossIGFAWbrS0yZPJzSp0CDlU5
         O5RSXDoD/pftOWPThMEBu7KfXpkvehAdVsN1bAttTGtCvMla/oo7ZVR7cgjYtL5jWMqi
         Br7Qts8pCDn4LBzyoqMtGioKJIje2FxRmP7bEMNsvpXvnG+g5p7ggjiz0B0sendJNjmj
         QLo/riGNlAlzYknALuyFZHDbg+gOxP7MdBn4LqNNRxNLfxFNy+SCGKnF+OAVQD4uEJZG
         q3sFSXfd5K2oQRqeOhUW8VyEyEbbvAf8EBXecmXQJvwB8QcNjQbDNb8FCq2FpK//GVT+
         Xiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789041327; x=1789646127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0FLkqwloJK80/wATJskq/ItQstxHs/9zbYL1VDZJe8=;
        b=k0WEPpguTvKDKW7XQTfzbxegkZnQVFgVAk0QdPkcc4an15TpL2LfWMyADIdbTDSwa1
         g1gblWuCGChGaeYmUAvONMr4vZFTbPnxdEMXBvfODdgfLXLIV7VYFBIDmbEqILaE10Oq
         J4BWqJl1JNiaqPzqNTioQI1LWZB5azDSRoHj91lvudArbBl6CwZFDDZ1Ed142oxRAdsK
         +ARBijfSsBBfwvNQbaTktEbZcqSxH8BilYFzohYz21rJtAzx1BkKBaPphAlCby7aus2m
         nvTRhRFi7oxlUqa95qHUztl2S5Khaa81eraqP7tgUawaHwk6FEUe8VcXr+9oYgwkVecX
         Y56A==
X-Forwarded-Encrypted: i=1; AKwUvBxvxQoPyZilr99Ljy5/oRiirTAtQzepERURhUBXemEUlwZrzpY0ME/c7e5XaWJZcdmD4VyRNl4tLY4=@vger.kernel.org
X-Gm-Message-State: AFuF++mtJz7fYLLd37UE7s2a4i0K7Sq6GtvgNKHVGYRhbqXfuI/vq/rZ
	08DtBCnii5G9R2/zhzRD5SKkzSDPa7pbIY05rkc6REYNfy21mif2qQ1KPcw2NpjVFeul1JEZ/JY
	1AEGpg9UQFNCSsX3wpHPh/BN7+sP936uaF8yI92+O1atVh+jzN7Am5h3m6eA0JQzA0Csh8iiFKM
	b2iunRggWvtsN/tCVd7/t10d4+Cfkc1WNSEMePzQ==
X-Gm-Gg: AYBFou0yymKxu2ycwoZka16BLXJo3RbohY4MDKJthnIkRw/JHgKn7JUoH2ZkRqNFIo3
	JW0wV0Cx8PNMk2wJU3lN0gIxj1eYryN0YfmEyhtq2/3e5MOW+Ds2jn55tj6rwq6i68DkaroLcbE
	/NdHLm8q1ooos8LM1K0Fc1Rdn9fQ2Dm3qh+cpAHI9xjBbprTHi3g7TTfZjhw==
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39b261323e0mr66322489a91.11.1789041327079;
        Thu, 10 Sep 2026 04:55:27 -0700 (PDT)
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39b261323e0mr66322419a91.11.1789041326634; Thu, 10 Sep 2026
 04:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826095217.2885229-1-neeraj.soni@oss.qualcomm.com>
In-Reply-To: <20260826095217.2885229-1-neeraj.soni@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 13:55:15 +0200
X-Gm-Features: AcwNN1X17Z3L39bGH3N9FTd6tOAl9kGgw4CpwVGwNcjsk3O551oqwHOl_exeF0g
Message-ID: <CAPx+jO8hLqgW9aXDcAE2tsWx=tWoxKSJzvs-KQme5UPo4v9kPw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] mmc: Avoid reprogram all keys to Inline Crypto
 Engine for MMC runtime suspend resume
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE0MCBTYWx0ZWRfXzWSZt45xoQgm
 L3QVQhhsQjk5bVFCvG91n8Og4SLwU+ltXVK7+6N9oWJ3f6YJxOu2FT7okAkLaKiY4Z+rBNTgtHa
 1quElI62qZDcywzyBB49iiuAnfhahUA=
X-Proofpoint-ORIG-GUID: Ul2tqIb6hN25acGxRyg8JN4KCcya-lJf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE0MCBTYWx0ZWRfX+u4Jw8FN0abl
 XDcM19YLdKsttVAsx4+9bA5BwGqF77e6PAAmg/iNs0K+5ZF9HG2lQzvXDGIbIQqnoQp9EmjBrPv
 sJkGvCg0dzfPvJIMpHPiMxP+p5GfvMawfwf6jlJTKlRT7/0SlkVxUcU6I16ak5FoH5DCkVhBK0C
 LIxC0DYt5cSDrYdXLUsjBEy/3YGv/5dSGkrjcB0VFckiG1oe0KGFWy+ddMjcP74JOY5ICK0uUXQ
 /4KLoV98RofM2hCsFMvcL5LdeOsAVBVtfk/mZdpNbHzZBtnvOrm8B73vn34RzCmjUprWU4+iYTd
 dGHFeiZYioKCzC32SkhBV8lGiZmkELKX/0L56Fy+R72ebw3tKuTr8ktK+XpXrFeT5uSSiurmgJL
 kyT6ERA/UksdJbLIeHKgu/ouEMbblPqqp6YvKLXT8gzjANGTK4FeJbkoIsumRdtGEtn8Rgf55CC
 h2Aa5fXs5nMpzwYzdmg==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa29ab0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=f4iapASk6-FZxEQnkJAA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Ul2tqIb6hN25acGxRyg8JN4KCcya-lJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100140

On Wed, Aug 26, 2026 at 11:52=E2=80=AFAM Neeraj Soni
<neeraj.soni@oss.qualcomm.com> wrote:
>
> Crypto reprogram all keys is called for each MMC runtime suspend/resume i=
n
> current upstream design. If this is implemented as a non-interruptible
> call to TEE for security, the cpu core is blocked for execution while thi=
s
> call executes although the crypto engine already has the keys.
> For example, glitches in audio/video streaming applications have been
> observed due to this.
>
> Fix this by allowing host driver to control when to re-program the
> crypto keys.
>
> ---
> Changes in v8:
> - Update the commit message for [PATCH 2/2] to clarify the expected key
> reprogramming behavior following hibernation image creation failures,
> suspend-to-RAM transitions and CQE recovery events.

[...]

The v8 series applied for next, thanks!

Kind regards
Uffe
