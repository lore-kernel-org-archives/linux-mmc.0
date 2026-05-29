Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F63ED134
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065957; cv=pass; b=MDzAJePbxW6weqwQWzpAm3fECkiRJYsxaQrVgSNTpU3YK7yF+liQnOGkbyTVwYHPHwIFhH9VJtZi8rgKISDxYeID5xwfl41esRcw5GXNF4MBOKD75Jcak14neFrORqFWLyi/FzDyYC2zuJ0bQcBBTqcGTK4Fd2GLxrf/KH0haSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065957; c=relaxed/simple;
	bh=3c6FQKU0ww3D9N7CrIbmhoXUPQQSE3lIJH8TMtrDQLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKtkbfdy8bbtwITitPf7gR47uoRmJM6gUQP2qSCDF6UxV/iOAK+cCV7lc/C0X0aZWnw0Xrj5/oY4mZyFmppLQwZ8AUdUWV1hnNQwFl70SOljappylvrvJX685uYMd9KiyCuAvPLwLrbsJetECcSj4hkxyB2wOvcamNYnO7hsSpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pYnjPGJ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFcD8dZi; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pYnjPGJ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFcD8dZi"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKx5J3729464
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b6Cq2S9LRmrlTwFN1DQ/i6snOMI9FUzTKet+MKwmEjs=; b=pYnjPGJ/gApA76ne
	lU5ujZy9dReMxdk9ScyYwOwHfdbUpcNGl19Deo4GlljIxeGlX7FJhkw32+IJh7QC
	Kl47Oo7a9QUSbzAFkcZdtT+DmZa77GmsZUJoq2O/ufBEutMLHcp3rO/e1aeD8Zmo
	JBLJ1pEiLL6a+zu7ZipoMrdeTewIYms7PBZHlP/Auv1vcv3i40QGEco2dcp/+h0J
	mqRh1bpgdNaLnCVhruy4cSzb95eD3y951XY1amnpQIDZzqgNc4heGHlsvNI04KRK
	CoymX+2S4p/0pE8ekRhrwajKS2CiEqeyUQIB2imnEi4lTjWA9xnFL7cSBSGLZ1UP
	YRkjCg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety4vn4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 14:45:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb0aa51c6so305625866d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 07:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065954; cv=none;
        d=google.com; s=arc-20240605;
        b=S0bL4xwUGwzJ89ondRod2YF2IKRMvT362z8Tbll9qyTsnYQOIyzhoRdB7YFBR2Umwt
         MSwCqlR5Qb7XbLEDqgMujKtC9a1KueMPJ485Ymv+O1KZorIR+t8SO7CxOTuLCcnI1ELm
         bQYXA1hNJ83v7SIphALcsba3s4kitBOsVOE4ZGw5QJe6dotfVs3j656t/P+jZvb5qNQ6
         gwmaRC9GcR74nkL9ei5cWGaeQJboIg6bjtI2I9V7uApCn9jb2f8US9kWjFqeIm0aFIIK
         YGwBbPI+zpHYk1SDDdWMPoil2vxywIB7u4e2xaRvbXZ2Y7und1tXmbfeDsrwqujejkf5
         +z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6Cq2S9LRmrlTwFN1DQ/i6snOMI9FUzTKet+MKwmEjs=;
        fh=8NMWUqAdS4vfQH62bjXABdamcj9fBmfDGV5ZlEG7qSo=;
        b=MBRyoARgzLx69WdXMb8nmCrgdxqPwAzzZ2denKDzjowycHZlXyg+3bbleaJ4E6oKjp
         uO7L9waWYtXLvTnJhrl9p931p90iobrvJUMrk82EWeKnWRbEYRKWLqixp+PBT06IxEvb
         ArOR2U2GbsJqY2YMdZhwBujKM29bquEO6UnHmFVmaSdcEe8ydCoa1l95QQ7E4Ourxoib
         aZ/+G9j/5GeyorpCuVWso8Zdwv/EngqZ9q1KHuPY9MHBE3/x/m2aQzLSdMDbhe86370R
         S4SoK+cQfSF+XA/muorn5cX4carVm5W1TmCIYHIBHoECGP9REpvplhf/CpdU+NxODUkT
         KWMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065954; x=1780670754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6Cq2S9LRmrlTwFN1DQ/i6snOMI9FUzTKet+MKwmEjs=;
        b=QFcD8dZizI9CXI+3ogrVxkQbVReDlVCVIuNW99Pe/KO0Un43HNwh7S6tJuTi7tD2N0
         UvC2dh3yYlFU+34lmcLRvBqg90/zk12OyY6l84Gm7qagFWLaFdAx+5ucnYjEfRdZcQTE
         gDanNOpp7q+421qlmKnitxbL8py6yQ/kADJKLVvLVvL2LIZtbq2pVkVZ2jTe8ss97nFQ
         b6Ru3Pioz1e18zFYxaDjeC3ydNYpmdlYHTbNo/Pzk+c7AOQMSewwu+AaEEjFfeiJRZ+r
         WnRJRI1tl1+sOAbSbityT+ZDvpiJGi2yjOlTYGvs/uOzeb53MleCFHxTrW/sM849QwlW
         1Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065954; x=1780670754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6Cq2S9LRmrlTwFN1DQ/i6snOMI9FUzTKet+MKwmEjs=;
        b=aP+q+Y/ctI7lqTHeSFxSVR17Ak6cQS5OB+EpCpYxEanRWdMZyo1ztaFKk8u2V+P9bU
         sdPuYylfTG6Cpq1zjBt9L0L7gtB89iSTEvCXjUJfWnIGcG7B+K8NDHk7CsnBGK8qVuT6
         dhzYKIreNi7yfYyUCF5SDvovyIuejJdCA50mcImTZaxgdGSnqL/G1XsWL3I61vmw7gJf
         nMwiT8dUsBK1omignTGmeUuPfll4B/2f38qvQ+NkVmKxlIREsM0TvwaiikSBsayiZaN3
         QZKI+V0vkVTtRGS73Npo7LkqJoj0yS0sbHb2YRZ+v4EISuOytX/qbZZ2JKN3RjhMnOV7
         R+gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/f2EiBqwcgH+4zJvEXueqvJ1cERWp6ZPO5moWiGoVXVhqBi7p2FW22/LTY4L+tvz+d4XPalf8ZOcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/SKu+PPNng0q/dD3Dwl4zI7VyzZwfLsWzLn2qD+KXNJdtCDb6
	jL+hc5FZCw6TxgNopc9GxjdsfgynBA1SlQmqsBG8ob/atpfFfWp+LpLojg0hqyWjjZvHPG4L5/p
	w9LiXVGTuv98Hbfp0FqWyEVABvXuZqjl/NPBLkKb3taCBPNfmcB9sT6ZUwuyzPV2r2nT7RInT4q
	tpYp5tzaWlAvV+UJHf4vLww5USJo6R5h/AhhoU/Q==
X-Gm-Gg: Acq92OG6S2hsUpdzrOnD1C4bR/V6+r1dv56qUVLfvN2B7+P4jZRDX0SYzL3LtT6wzaw
	A1+JhCJ0uc6tMolT5aedwX/4UVQi16kNTgpmsn5zGj0FHiiQOyj2oKJHMn4eIpNqkhtIyx0Bog7
	PmROZ6I1UL1h73Yyzqr+/qLcq/7eS2F0IaEG5rK2Zpr2Ol8qrkdLUCxpZg5L/cvGktZrMCgCk07
	y5vneEKpuGI/5agJg==
X-Received: by 2002:ad4:5e89:0:b0:8cc:d38c:61cb with SMTP id 6a1803df08f44-8cce4ef0f9amr37816616d6.28.1780065954205;
        Fri, 29 May 2026 07:45:54 -0700 (PDT)
X-Received: by 2002:ad4:5e89:0:b0:8cc:d38c:61cb with SMTP id
 6a1803df08f44-8cce4ef0f9amr37816096d6.28.1780065953813; Fri, 29 May 2026
 07:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522073133.409844-1-a.shimko.dev@gmail.com>
In-Reply-To: <20260522073133.409844-1-a.shimko.dev@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 29 May 2026 16:45:43 +0200
X-Gm-Features: AVHnY4K1YdKmI2LHW5QgfyzerGOWqad6GNhFctHxLnajRmK-y4LiTVI0Gccaf-w
Message-ID: <CAPx+jO-aG6SmLZuHE2iCkXEmcpgFhUxy+Bvm2MuAHaZLbYCHcg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-of-dwcmshc: minor cleanups
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andriy.shevchenko@intel.com, adrian.hunter@intel.com, ulfh@kernel.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0SIyrjfQWFiK-0ZqozoxJ8BEDccREEmj
X-Proofpoint-GUID: 0SIyrjfQWFiK-0ZqozoxJ8BEDccREEmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NyBTYWx0ZWRfX5p/4Vt6ZGduA
 +UgyOisKxh2Tr3kwPWD4e/rs/9rE84AfkyiFTd1gDgwlGpi1jMhYzq9EC+So/T8ldA9LoXaM66U
 N+LJgxJCB180djKH63IqKJj+2pTATLCNMp66SItLzEF0g2XrFTQZLEGGNOMeAxc+n6OVRHiWUMC
 R5P6OFDhHlvi8W5S3NzwBl7d1GCbxsHmPwbNs7e1+SgCUh7VL6ggaGhcuev7W+Bv+OeblxOgihk
 j6dIKdlYSDA0m0bCtTcHAk4vFeyVfT9i7RfLjmnA9b9j8bhKySfGN431iHGXDBsBRvKnVt9CwCv
 a82cij14/nsSKLh7BfQc1i79/jyJIfGx59xeB5s1RGZNNBz9BlKcVQq5Z9Y6h9lyZim3IKY94qK
 /D8nY5NUtOOHq1yb5Ymblk49ma5J4q6fKO73VSpfnmwFZn3LDTph2NEJBRcZ+lT4qRpCbMIf6Zn
 0lY72IgF6q6f/twjNfw==
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=6a19a6a2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=RqDqEBr2Lp6A-T1MmIwA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290147

On Fri, May 22, 2026 at 9:31=E2=80=AFAM Artem Shimko <a.shimko.dev@gmail.co=
m> wrote:
>
> Hi,
>
> This series introduces two non-functional cleanups for the Synopsys
> DWC MSHC driver.
>
> Patch 1 removes redundant IS_ERR() checks for bus_clk in suspend/resume
> paths where the called functions already have internal protection.
>
> Patch 2 converts error handling in probe paths to use dev_err_probe()
> macro for more compact code and better deferred probe debugging.
>
> --
> Best regards,
> Artem
> ---
> ChangeLog:
>   v1:
>     * https://lore.kernel.org/all/20260518110034.142587-1-a.shimko.dev@gm=
ail.com/T/#t
>   v2:
>     * https://lore.kernel.org/all/20260521083506.356422-1-a.shimko.dev@gm=
ail.com/T/#t
>   v3:
>     * Drop fsleep() patch to keep initial delay/sleep values
>
> Artem Shimko (2):
>   mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
>   mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 36 +++++++++++------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> --
> 2.43.0

The series applied for next, thanks!

Kind regards
Uffe
