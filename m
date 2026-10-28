Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793183818;
	b=KoNdiPDDFpjAXFwp2rA0rVKDS/CX/8LOzdPkADoeoauxKB6BcEGvVVBjCqV9gM7bRa/F
	 POHbwheHOVoYyc/dPzPWQt+cwIRCSAc5rbOBGYYAZLVgTX3Zy5XunWBZhJL6uXNFnzGww
	 y3qhtjhWmGPuvexD3jZMipupZ7x3LrqCG/w1cuCYhEpDXEZEmB9YYFNy2b5XHZH02rPR/
	 FAzNAHfD4b76Q7dlrWyC7WUIEdinf6UUzNxlNZTb97mmcnEeDmCtJCn5ROFXx7DycQa46
	 07zESEdcYMrzj9y8W3eyzWZteszy6/Knb/7/TyQguI4AJ2Nlzz4L0i4YL29i8S+wIxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183818;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GYZdHgXiHBouJ9ejDg7nryamtVIjQkYJVCR904hj2b8=;
	b=cSXxfYpRBUEZrSogwpiMqZVhIJMPF+ffiCkcMcworIgU7GOFB6FtPtanWDwpyUiGo5YM
	 ZWNWTjxLjJz7mYv2qxdd58X+WMGJiP2patsCwPY0arfEPFgvZGZjuPBpTix/fdmo7xsQ8
	 pT/eryDqtGnUoxKS3TP5I5OgpWYKwqmRi2U/xr0rLM2spvk47dNv51j/pGEoAb4kzflkS
	 pPVkRAKYPTQ0fjwzKCnmg2s6ALktb7mHXzp0v/gWe1YOWGo/Ly1x4eocPJJvV0bWH9Hwv
	 VSlDS6nEWE873q+BRGPDcBCjRIrOgmR5IGFbv8seBRvY3dMybQ47vi+nJeLQvYgiqeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="SeaJ5/oq";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R3MxyAaO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D8606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SeaJ5/oq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R3MxyAaO
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SAZteg872094
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GYZdHgXiHBouJ9ejDg7nryamtVIjQkYJVCR904hj2b8=; b=SeaJ5/oqFe9yCvFG
	n8K5pKGPqPeTOZBVHIi5C/Zu1ziqtPTzTFOt4eTj/IBskftxuxfQWzrnhIRHrcjz
	SFq3qvCWszIEq7JFk1ufb2QyufxO7uj10E0c+TUIJ05mzD5GS4OeI7mN7ylnkja1
	Y5FD6bz4fsxycnipTEVdylXAjAlhwXN9aTuhEYDxl+R7F9WhmY3IsHVIvJOEsfXo
	E+h/sf02/K87ugR6c38m0CYs0uacEOOy0F/B9qHIwAUU8Ecq/Rgz6P+NyaS6GJxi
	c/+/Umzga+XJrTYCl+9dU4Sl55l04mSASmKlZy8A0+3YIgol2o7EXhb0JVVFPMCR
	fqFdwQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehg03u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:36:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso1345679a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 03:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793183816; cv=none;
        d=google.com; s=arc-20260327;
        b=sDjjw+FFKY9uXSAiqweeoiMMHgbNz+cEgAw/mWYTO5gIhsgfWDeTGRFdh79hLBMfye
         XwRUYxSFzgMO6BItCTzdJJRRjyuw71cgDqanQ60gQFpJqrXVfgFRCI09fexLXX6iHhB+
         GkJjMUL903Oae0xSVRlfwErrMl8y2HoqY7pJrFuUp1Dn5FmsAzEHGmCqRpX3JD8SBVGG
         oAKxDM0BlqcziP7yDfOY1z8pjENRSSPEy5w0vMtsSkIBXX5AfnV+MpYZ2jlf5wXuhvs7
         DjYUaMRw6I0es5VJQY17sveFX3JK0Tf9L5aaZjXYudoiC5Eq35W14mS029Ou6N/c/H+O
         3xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GYZdHgXiHBouJ9ejDg7nryamtVIjQkYJVCR904hj2b8=;
        fh=lBzv9ud4HkbEwl9/fTfWyWZcB5hEhYz5LX0eZueQOWc=;
        b=HLfLlkZyN6CVrrwRGJ2n7dpFDXdjFJewOEGDVvKzacIecRx5IRIqsDmJOKRzKuF+lq
         VCvVYuvUNOiTGfpB+LBRnYqT8rY7dJEGODie+D350u4TXzkzVrzGSytK5cdSwK4lza/U
         XCQ1FRzrw3FgG4U6MhS0bcAYe6m4gQm046mvs/dj982VsQTBnix8nPZmyMgjrPU5/8IV
         fH1aibNlJ5e3nlco1JmnrGql7Q3r4/BuDZRk0rQYKW5LnpZmGFIZMdQwpN0V0duqlttr
         GbrYReBMogIajTWnTu/+sjwnA3L/BlOwyFiHpjhdp+gGlTMMIkHgiwVRcF7+diHpLO1h
         8q9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793183816; x=1793788616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYZdHgXiHBouJ9ejDg7nryamtVIjQkYJVCR904hj2b8=;
        b=R3MxyAaOexEH0lun8t2yK7yt3N70o/OlnilQy799DFMEb+iOJ2wEnCYrF8QgeJRTYe
         g7eXF5ybkYmkBUfdy3uTWnflbP9JVAcLdGaTmyr8wqDQQ3ndIs/KU3usNaur+mwxbel3
         v/ddWaH0VutQBBYr+ITb2aVy7DeOtMZkNTngLxgiWR69tmKkVvL4J6WwOYBSUozpYbGb
         nQCAn+yaYLaRMcKjdwGZehXiDf52yi9A3bFR2xLF86RuS6FeH8vLptiOQxeFP6DRiz5L
         ncELnUarmpGc0no+OOEf+QNSiYzP2jujWzHIqoa8iX7CLlOXFri3DvcxDwz3hjw5vIF9
         qmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183816; x=1793788616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYZdHgXiHBouJ9ejDg7nryamtVIjQkYJVCR904hj2b8=;
        b=daUhTmM/zvqupLWXGMMoL1O0QV/qbAvkg5YxckCdNqZqNfkmtoH787Cza4U0a1rNtc
         eEaYvDHThtgxoD0u6PuvrpjCL+6iovNUQpSc1c3gqTlHUHjev1Zz2DjK/Phk369I1G8u
         wypfJ66FHmOcnu3tYqBgUhediOg0vJegm9Iv+Sqj1qcTBYwypUNqge1GIINg3O4MwUoc
         Wk/tUehMht3ANsqalsO1ZFDbPQSQy6VY1RXanept3BuBM6SnUCk1B/120q6qqSSs0lLK
         XYZmZJ7SgaudwwzoMV2/c5sQS4wuO/qoiXw7DlB0qFedgP4UH0GUb03vb/Q3GZjwFbv1
         k5mw==
X-Forwarded-Encrypted: i=1; AKwUvBzW1BALsmIelzTKaWMHQWyTCSBonhGbFlL7V5Y9e0nqNd3Qj25IKze8k0vRc1eR3+XZAwx/bD14u6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBI9VOtgWeNbQqJFgg7kPq0IgdXZnE5g66QtHFpsNh/+xEBYml
	OykKbwSxw5QwSswsqVBC4+3Sqb1demHUt5xWVoLqQYgKIuqotWfYmXZGgOTiSule0tSX9BDJARE
	zFFWdLqdBovMv+MbhXh/CYmB7oYbztCQ3MvN/MLGLxbNqyoJR4XTqfLCq4y1HpdNmSXezf/ZRen
	N07E45eAJf6zeuRnHd0NwKFJG66AvE6rtw81UQ4A==
X-Gm-Gg: AYBFou3u9jGhbJRkhM+fWtC1BQWaYSTu6zcjSEPiqktoPqJ5p/4fejn3AFl1nccYFgO
	br6QQGDqj2z/UcAnWpGR89U6y1x122xr0IW/pXdCPkDXF3+R57+dnLRxNJO41uM6UDqPYDKIQ7X
	oRi4A1/AIoCp1MGF017TTSDmZWhDK9kBvCLrEdGCyqRzmS+ZXseqLmMxak/bOCk3M1A4W2smm59
	lT5rKcyoNrYgAxxUQ==
X-Received: by 2002:a17:90b:3f8c:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3ae5835d8a6mr1377094a91.59.1793183816028;
        Wed, 28 Oct 2026 03:36:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ae5835d8a6mr1377070a91.59.1793183815482; Wed, 28 Oct 2026
 03:36:55 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <00b63b4f-053c-40cf-82db-21a86fc485c6@kernel.org>
 <CAPx+jO821-wULVT_KbZB4oaPSYAHi3PEpM0VzvSL_7NBns1t_g@mail.gmail.com> <CAKekbesRt5qDOf76MBG_8hROMa6Z=UCNdXHKoE=5u3xFcznhhw@mail.gmail.com>
In-Reply-To: <CAKekbesRt5qDOf76MBG_8hROMa6Z=UCNdXHKoE=5u3xFcznhhw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:36:40 +0100
X-Gm-Features: AclHuK9Xu0HlqvsyEeUvS1LrhIXq4uQwwd1vAC47YGpdju_wAFdqdb0bMNU_sHU
Message-ID: <CAPx+jO_C+xHihnu+ZweSoFL3gJrj3mjJm9RUVX4aXTdKEi2mug@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXxkxqT2l1bfOd
 3wRGg0BUu+9Qx+j9ojJ95mx+mzK6jLL4HjmTP4O3B1Ic9JpiHRX+Uw/NcRdlKHE1QJPtNaa/rP4
 OFAn2/jt8o/Q9FDjrpPQnCrGcneKbls7pam3RdrFPS5LhGza1NnpLom1/mBeFf0mpQY6RM2KO1z
 X4Qeqq6RPEIPot1sYv4XViAnlqvX44vjqWlmAX39oIfLjPeTWUdqt8EBVo6QsLCUhu8o0lMl4Te
 Mng4XXW/fvgOWR/ctdPyigX5Anx6cgTythphrtOpS76+DWws9Z7Gz6KzPuH/d4GtqXIsAC5DV8t
 9JFHyQSaNC++qKKhOZ7pDxL5SwJLKPblg2mrbMznK4jc4WPvac+N/A/5Pft/B2/L9vOSpB6gykG
 xWHAvXJvZ3VAZ9yk4mBBOpdR1sX1dhdGqgx2lN01JffT7aTNzM91evCTSQJMBkcpaXe5n5kajyj
 rm16A/vbnVwAE+cD07A==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae1d049 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=VJCnStefonsj0tF54p0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: zWHA2HOa6RVw7NRrVk_qVCuDT9NVmItn
X-Proofpoint-GUID: zWHA2HOa6RVw7NRrVk_qVCuDT9NVmItn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXzKuG6ubQiFKC
 jJ7m/vGR1cHInLB9gsYpUMPnpOgrZBjuT6HvTo5Fw2DrorFcwd4/Ym/yxnTKzF02x+Us5uixuNn
 nu8Q0gvyW1hSE7UaScdZ0lGuSYvEKco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280042

On Tue, Oct 27, 2026 at 9:31=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> On Tue, Oct 27, 2026 at 3:48=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 4:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > >
> > > On 27/10/2026 15:40, Ulf Hansson wrote:
> > > > From: Kamal Dasu <kamal.dasu@broadcom.com>
> > > >
> > > > keep-power-in-suspend is currently documented as SDIO-only, but the
> > > > requirement it describes -- preserving card power across a
> > > > suspend/resume cycle -- applies just as well to any card type. Drop
> > > > the SDIO-only restriction so eMMC and SD platforms can use it too.
> > > >
> > > > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.=
com>
> > >
> > > Incomplete DCO.
> >
> > Sorry, I should have explicitly stated that I will leave that to Kamal
> > to contribute on top.
> >
> > Kind regards
> > Uffe
>
> Hi Uffe,
>
> No problem. I'll resend the two dt-bindings patches myself with the DCO
> fixed and the DT list on Cc. Do you want them as a separate two-patch
> series on top of your patches 3-6, or should I post the whole series
> as v11?
>
> On the SD wording, since you plan to add SD support too, I'll keep the
> description as it is, unless Shawn or Krzysztof object.
>
> > That said, I was also thinking that maybe it would make sense to add a
> > sysfs node to allow the behavior to be controlled by userspace.
> > Thoughts?
>
> For this board the requirement is fixed hardware behaviour. Firmware
> reads the card at every S3 resume, so the card has to stay powered and
> be reset each time. Without both DT properties the board enters suspend
> and then resets at resume, so I think the DT properties are the right
> way to describe it.

Yes, that part is clear and user space should not be allowed to
override that requirement.

>
> A sysfs knob could make sense where it is a policy choice, for example
> on SD. If it is added, I think it should not be possible to turn it off
> when reset-card-at-resume is set in DT, since that would bring the
> board back to the failing case. I would prefer to keep it out of this
> series and add it separately when SD support is added.

As stated above, the reset-card-at-resume requirement it brings with
it, must not be overridden by user space.

The reason why it could make sense to allow an eMMC and SD card to
stay powered on during system suspend is primarily for two reasons.
*) It allows internal garbage collection to happen in the eMMC/SD
card. Meaning that the card should be able to perform better later on.
*) System suspend/resume latencies may decrease.

Of course, this all comes with draining more energy, so it would need
to be carefully used.

Kind regards
Uffe
