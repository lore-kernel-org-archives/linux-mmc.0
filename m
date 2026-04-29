Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C3391E55
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494032; cv=pass; b=rg1au7whHkYqFSmpPaN5UWhd3LTz2aef4YevSqQzUEVqFrqCI4/86mgBT5XMRuh7lxxDWK0ca2R71sMfRyeizZO3Syq/2gvjsKxM1n+bYW7cUU3Gfk1KmEh0UGCCWiAf5roP1od0Y4mbmA29DPObJT7qy1S41zmxtkkSY5yjJT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494032; c=relaxed/simple;
	bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gig7OppLseqxeLVJDQpfa7iVFrb34x4YUfKqLWiWpPRMV127AnzrFXiwP/eqlHxwmDsNNP349Mw9GfHDgghuehDOA8CCZJrm/y674tGS47xvKUOqbhlrJ8XXNQnwPZNgixqVK0G+WxsuuWO0p0SrYClYuigYO2R8r9q5POzw/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJ1yil7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T24P9Fi6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJ1yil7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T24P9Fi6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFPwQH2094252
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=; b=ZJ1yil7RRd4FYxIp
	p7Iy/QHM4zbRhNpPA0hYLTXJPDkjEZpj0nlJd1/gcn1CaWRIma04TC5JKe3D81SW
	vVeiRZzWMnD6h1j+/NrrML/N1EdSQ9j/g1w/HfPjcjKblwHioKNVvbPOTS7wMt1g
	t0Gzh5vN5ormYORSYWNaDzPSF5QRW2Nn76i06d+SpiMnh38SIooyjOtYhh5AvjdN
	CZmgTmQB8ODoWqmGpsdbBkWvdolXxWGtqhvkZLbyynEZ4or8H895Tf9JexmnCUm7
	KfrnoxvQeAAeJ1xqAifF8YREdrGH3wXxomLatFCwx3CMWJQTzOX/W5W2A3BAs683
	leNRfg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3u6k4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 20:20:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50faf575af4so4155461cf.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494029; cv=none;
        d=google.com; s=arc-20240605;
        b=ItM1MwDTNPOIdaZn5ah4UG2hK6E5QHKrYXFzyZhYlRDHWQ/UNOeH74e59AkGfCJesy
         ehI37lMFIlR6g/VskLLcEVuwVcMz3zDUL6yEdi3AMqUqVUiGLNygPIhDl5/LbvXJGLn2
         e73xBVNuwU/DNJEcaJc9U+0hRTpn60BUOq/GjST2gxZxKxI3TTAvVtXA9FOPRr7133K8
         HXIw6bIZyYqrAvgkjAETNvki5StUNlAd2LZIIgwql9b+o2VbLz5bRmKiPUYg1ZqOf9HV
         pT0yz4LZTxvM8hH/muKjcaGTtspIA9Yhzt0swh5QdYS4lSFztmA9paW9cgug7ELqQsec
         SZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        fh=JQPaWmlXMF0e8Pci3f5hZaWWrLhnIpt+5KOhXaa0ELg=;
        b=lSOsz8QLNypHcPB4VyIfJb2skpDbTzv7dGxZXoqFSo4cLJTsDeJnwBTVRoVEnB8lSv
         zwtnOnG8FH5/UObRQBxrXXC0CecXz7ZNbKcMtTAmCGC6B6kEFAs6CbeyvaPrLP5gJ8H8
         /OGzqZ8x6bwLNFP9w8L3KRX3rEuRJx5BDmeqDp8VcLSbFvBZsuDALIJz4ejzv1amSKQE
         pOfpi9vd/Ic1h9eWhmwIJAL3OWDViQ413A4KIvj37gB4Cp4fVp1YoGltj+ua+dN3tFkO
         QlMkKJChcA1cyfFPy5bQ2SKl6PiFTd4pGIjhCJQpPhlocptulEVkAg+dLRUqZ/47Lcad
         YUlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777494029; x=1778098829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=T24P9Fi6Gf9Zjk4iMavuKmXO+S0kBOW1j11fp+tN8dJeMhZ7AyIwSiSIil0oREiY7O
         aft2bmgLO5PlC+vWwAwD/jJscZIZdBXEOtHD1hbtYl1+yd33QyWzyFG8C+UyzydLmKAN
         ctxniHxGmG2dGtuWcGQ1RiUsyXYmdx+3Lq58ciWRCYw7n30BGnGWxPewjF7M0CB26raa
         n+CKzEGTcjioh1vWjBETZ2SAzyYVBB4IQvLZTAtHnk1MRQLSBN2P7EGZ6G2Hx2w8mHrq
         Bn0dIxMgTFx2Y7H3gtVcdOZq1Dsw1ffCJbqJUversd03uc+fk7UXUZM+4L94JeprgeeY
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494029; x=1778098829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=AEaa0n54yjzzi9SzGX+Ppr45Z+NtlcrpTFzRBGURDPd8TUTLqc8C9VY6Ics8AB0p/G
         4Qp2EuSMbVhPyk0vX2wxcbx2lHY1SPgGkxo/x5nR108Hb/pe+VYp8+kyH8pJjm8QFfl7
         nP77j7cQP1q1CZOp58o3Ou0dnMDV8wQOnec83IG4Lp3gC2GW58LJiDmYOgJLyhC61fGF
         1MyQ9f6tJkINdbRJZjkXhVABbbDj7Lhyj9HU2lIAIPs6+dH/Y0Nvwy2LmqKN4b3xl7tA
         GCxt11BVbH0PXTsg8v6XQx0iKLdJpxCzFgtkFUjCVLenrtKTm9CZ/eoJpiGGUxljUpEa
         M0cg==
X-Forwarded-Encrypted: i=1; AFNElJ+9p55Wl078pEPq/So48WOXSqxKl6ihjkQn+PybEyElyNy4GKg5RSZtBpjLH4/yW9VuQR3sm7nDMZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpxUU1h+Yy7V2QW3jkKP4XoFMROBH7AX4zocNrPnebQ+/xWNN
	r8bqjevtBLGZa47hhuCbIBsTklwc5YiecNoisGgUng4HJn8Qp8IhSGiyeQUDeMyOvDLSdK+kwvU
	32AEEhhPuBjzUeJ2P4ev9GANXAR4Al4i5WupHBxiHviMrbr8thqI0dGvfE7UPHaO1L6a3I/qdge
	gsxT6PA6FZnps7PLr3eNmws/QLS/0bomKwoEaJFA==
X-Gm-Gg: AeBDietUqWcK6zfAHhVGI9IYcsckvMNLCO3DscF6l2C/xq1AJ8R8k9Si4qGqHdEh3DJ
	EFYAzgNRZ/S0cnqm04/lEzKEvb8t2xSMS4E+1vRDXRgpAkehVvXWTFLYRt0ItEE3vc/zFby+zg0
	VF8MYaZ1HY9Uq86CpxaB9jfXwDq2oHAcmcHQZ7jmag4XC2Wmf/cQkcN6Bv9XY7ERaIQQGHNR5vl
	iyO9l0Gls883Zg19oSgIxWMx0+JZ8X59oeqsJcn8ErwkFCeAA==
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id d75a77b69052e-5100e10eb2fmr114762511cf.17.1777494029278;
        Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-5100e10eb2fmr114762001cf.17.1777494028820; Wed, 29 Apr 2026
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com> <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
In-Reply-To: <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:20:17 +0200
X-Gm-Features: AVHnY4IQns7j5YMIXICXGX8mkvbJAvEU7QYVILcU5HpEGI8Bxfo-jvWggVlQrrA
Message-ID: <CAFEp6-1GdaJd6Ua15TsyQC07QDbArXO2JZa9nKVFoCG=4xBpWQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support for block device NVMEM providers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: zwnNgk9Tys98EtySan1gerv9jJdm46nP
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f2680d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8 a=ICsrgdoeZ6IjgJzXnBsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: zwnNgk9Tys98EtySan1gerv9jJdm46nP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIwMiBTYWx0ZWRfX4YCAUe1La3OE
 UoKir/tyyxsZfu94mrO2ipDNk9RarC8DvT/eeHREhTOgJa0Dy2XaXe0UIQ7FM97mxZ74KEG8m3R
 QiB/Al8a0XqpMDiaRGpQJFVVFbhKB3ZSZN4QCVVRwDi4eJie0p/9Wz9MRB8ZHE67j9C7Z6p5Ul4
 h0DM99zFNYuOJGNwTCy8TQhH64Beq7I1Z+Bw1wHRH4lK5PG7dCoAqwnlgq/nFNoK6qEHur22PUo
 RvfDwUijgzhBUf54bQ4jl+oFxTq/lngyKjtDg5SLJRAQ8fY7exyOv20eLqqvBx4iwsUgPtiLqwn
 IOsOAlylamEjty1TR67jAG0ML6AIx+MpITVffYCJ/4S5RvmMEsVqRGFhwBjX0Y3ih2r37MsDXVg
 MfIH+x54B3iq8eWLCmUIIRUcp6kPd1AbJJvDvjzA2PjN0PtwuDgXdtxJ9dx7sXQaOahzrzUw3vB
 MTAmWEAVOkA/3BkGD8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290202

Hi Andrew,

On Wed, Apr 29, 2026 at 3:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Note that this is currently limited to eMMC-backed block devices, as
> > only the eMMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
>
> Would this be
>
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/mmc/core/block.c#L=
2641
>
> Looking at that function, mmc_blk_alloc_req() i don't see it doing
> anything different between an eMMC and MMC.

Yes, that=E2=80=99s correct, in the previous sentence I should have referre=
d
to MMC-backed storage rather than specifically eMMC, since the MMC
scope also includes removable MMC/SD cards. That said, eMMC is more
likely to be used as an NVMEM area.

>
> An eMMC you don't expect to go away, since it is soldered
> down. However an MMC can be ejected. Is the code prepared for that?

I was about to say this wouldn=E2=80=99t be an issue, since the NVMEM devic=
e
would be unregistered along with the MMC card removal. However,
looking at nvmem_unregister(), it simply performs a kref_put(). This
means that if a consumer still holds a reference, e.g. through an
nvmem_cell, it might still be able to access the NVMEM reg_read
callback after the NVMEM device has been unregistered and the
NVMEM provider data (bnv) has been freed...

I guess I need to try and dig into this but at first glance it seems to be =
a
general NVMEM issue, since even though most NVMEM providers are
not hard-removable, there is nothing that fundamentally prevents them
from being logically removed/unbound at runtime.

Regards,
Loic
