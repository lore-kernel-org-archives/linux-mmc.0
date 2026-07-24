Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43F175A87
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909970; cv=pass; b=OYMwy7UTC5j/xQ2hfAoFJbGoum0iGA3sQS1iwdq4YV6y0pFfe5W7LrSo/x6LrfcTfr9wyu4roMsg/CXtH/vl+1Q0bjtUcJg5xWD8vuQBvScGE1YN+jHMGoAUwM5klm5dGM6Ci7o/rWOlh0qzXK/smHkUffiwxStC5kDxyitVjTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909970; c=relaxed/simple;
	bh=2Pz7yi8VnRHhiqlQrvwuFgDpKz5CVC4Q8lP2Pw68SCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I93ygVuOZbXJlKvi+pfvqxCBRDliGKWWQkwSnPRAtN0QXWzozzgHdBdTp3w2w2nbYC3sng/XlyOIA8gx/v2uI6TJkxiBGqHHdkdCEotiQpS9suwgktTn5BkXDhcaetQ8z/jY39W01SeB7APF0iR6CWqj8Mqk0P28hBU5Owx0FLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbVcHouG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnWBs8p; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbVcHouG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnWBs8p"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbDD92933529
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=; b=nbVcHouGe6Z+VeOs
	h7qeGBArJI327t86C+PrctOZsyltv748m/ScDV0HsPpenC1z3jFTg4LyiV6J/FyZ
	owGOr/4SL9LTo2UqQvKh0uDL88gNcHr0uVKuOvntU6WpM2VT9F00DWYccU7reCNf
	3W+Shr4Az7Cj3bgZwWT10I5+AfeG1ieAsn6FNNauwF6wH+zK8KT/3uOxiM0PKJA5
	g5hCgpfIWj021uazh1SKvG5t/yYiUeiG3mZT3crN8cA/gFB3Nd8A8h8MQQObHNWx
	CXusUmB8HAJeYd6rra2az3epDYLosYNDbtF7F4WrLTpOgjM4yHXPbGflsMaEgVX3
	My6sdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cj8s4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so62865785a.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784909956; cv=none;
        d=google.com; s=arc-20260327;
        b=Jpf/jA37rObJPreSuLpy8KAcM5m1U4ESNXRwhIKC2sHjWpPCXOyZMIl+VaspWWqIah
         Lg/93RS89ASkCAniuaRPJp2Gq6ntyQcn2P3XYeXyu/cyXL5T1F8Ajm2FKlwNuk+TmGXd
         SK/+DGFqxWtsyLJ7JHWvZxvmklQk5jFpWnQuLi6IZwyOCPWpJvzhvdjdOVcVUfwMXZ8C
         dE1xN42hudtF6u/RhUKLe3Bo1o27V+C2+gYyQW/aZEVtgXZp7oeRkFExq/lZGScK23VU
         ijKkFpWGURK0YLOfKY8yB2BA7zBGD2Iu4kEocSc3efoClNyXIL5whvUSeMJAUG5BYifw
         bpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        fh=HRHDHasTtUCD4O4uKL+eLuVUU7o5uHTOJj7qv1kEu8s=;
        b=hnq01onsgyCda4Wj06KF4+XDe/c5sv5wjdvrQMexcqmL7YMu1AHiIIjgOGQSutASJf
         Dj2Rh4yRObvT5gVasyYLY3uiM+3NYc/y7OcYtDt9flJPZp6by9B4kWrh6V7tOe1h64ga
         eptPkxG+LahxCmtph+SvhcvVZkpbymaHfHOQD2hDPQYVluLXnMGSgJhvrftCdVqZo5bA
         7FfymPDxB239mztM7S3XlIqKLWqsUdfnjzqmtjce5VnOXxVcAAdCeoNpGSekzwNefCnB
         kpjEG/6e3jAYSwlOJoRnAqU3LytnnjCNdCfFTKU6UlaSaycfCvxrKwhIK2SR0lKBt1Nx
         3mDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784909956; x=1785514756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=QBnWBs8pQw5wzNA8WwdaOkxUQQF7Ena/XK3A2pUYAMvQPPyb581gO2Mi/SAXt4VDxb
         pJNJe7B3v2OfgFRxwFEEBcaCxpmAOIGWUzmyQuttmynAImfQD73xIZdZl4l0P0rERPJP
         /lpeco0LGrc68SVmmkfXDi/Aiw6UgwokLKaftWKsyA4eseUOQuApP6mrpcFDoGn1Wdp2
         XzAotZjdfQ0eU3U+C+NtkPomPdCRd4j8kHoXIpQM7ncqY9xHNmrgaWVaQoVZS3puy+79
         pPlDzrHQ7WmKBGJy7BPyjCLZwlU5rtEpJaNSb/4DoSuZoS5RoR+vhvY0bbEDi+a4G8IK
         uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909956; x=1785514756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=GhHwUc72EjdWI60q/I73dTmsq1nyM5f4euoezovVv435lXEfH0VIrFVCGb9Lzg0w58
         xPK/GZLrocU5W2RmgC+oxbRsK4omEK5N5IdNUvoEOFSlZUNTjcu6wIqGHQKsFw7syjCY
         TQpXxwGyPvkvbxbFOVfvws4/EwIk/M2UUzZ6cjTffolFxK+kCtQ7Ou1nfL0W4qgljpkj
         B4pRBKcRDPvx1FPE3QLapd8eTh/fJwCcDl2eXmSVjyMZP7NctEPz9QVzLaLW6k6oAOL1
         dEdantZaP+sF+5es2Q0A41Hjd3j2YjDR+ix8RuZG9Asah+EwKLVxAuGK3auv1P7T7y0k
         DlfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzoL6tM7qvELyPxjUQvxU3XnmkuTWeCttjNm8luX6AFtadtG1Sp6AuI2vTszuSKbc1RHuo/FXIbl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrjN5q7eRwpJI/g2AY8HR52e5piFbCuYEOPDQ6XPUdXLAkgsA
	SynkEUbnSg8VdKVA8ybUV9hQEM6HrIbyE1pqvRH/OPc00QZAdBb4eEHghCTk0/NDpmlbk//zPL7
	+7Z0JUSVljlz4h9Q3tbKshM0xDbUvKgYmx5kJTm5L8k6+/PT1g3+ojjyMX6FOkTAncGw/XqlRdD
	48f4hWwKrvBIsudzBT0GyY9KL4UJfrg1UeOA+glA==
X-Gm-Gg: AR+sD10/zuJWueja8d9Pzpl6vTNFQAy3mV7BxK2n4endFTOcRDSZd9So2G23FEhCk92
	ATb8DzBzM4RVoGST42QTioqQK2BUpXsM1h6Jyf98A/WlSj0au6w8DTHx47RTZ8m41HeNy1HMmHh
	sBRffWlrrlh2vSlDEC3HDXbU9y1jKYSu06jU02+MMPcXdNcgFzsTTys/x2/1RdV/GB5Upr37Fhw
	J4WP+PsSttvb3xf3ehSDrJQ9lor56bifhgmQaD43U9b2/cTsqxR1A8m5i7UhbZOrZo57mensCI=
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id af79cd13be357-93103608240mr655012085a.35.1784909956480;
        Fri, 24 Jul 2026 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id
 af79cd13be357-93103608240mr655005485a.35.1784909955860; Fri, 24 Jul 2026
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
 <20260703-block-as-nvmem-v8-5-98ae32bfc49a@oss.qualcomm.com>
 <amLwz6WuHYUwKKJo@infradead.org> <CAFEp6-1_iariDyqWj0KezHAtULSO+piPHX0F=Z46Rx4KDNLmXw@mail.gmail.com>
 <amNkX6HV7c_8jRUa@infradead.org>
In-Reply-To: <amNkX6HV7c_8jRUa@infradead.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 18:19:04 +0200
X-Gm-Features: AUfX_my698y_ctqeRF24VMWwW_1w27mTDvVkuG8C8ZhXfnEBEfynx8DYsYuY-cE
Message-ID: <CAFEp6-2sZTBba4isNDmykh1X0HCxoeWQb5_bJp7AGQHU1E+MLQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] block: implement NVMEM provider
To: Christoph Hellwig <hch@infradead.org>
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
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GJE41ONK c=1 sm=1 tr=0 ts=6a639085 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=JfrnYn6hAAAA:8 a=-e8Xlw_gh5nxI56MKtwA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX3NL7zrDVAYxG
 qSs2ys+zmUL9jNc+g7rGezRQ+auBkGVcxl1xcS7Rkuer1n3W10a2wdpfJnfFSqUfcDIXv1cyouK
 bEKwKpIahGl8ZPBrUC1De5Rd+FvDCQJVbFt0iIrpx0JtSHaIfnfiuFr+cXanWdz4MVxih0HlD2j
 34tMM44vesBwuvFH2V8n14KJMfSNRUqKYUaF0oh31xR9GnHfjVIULy6rbDWLaPjz0QIC3vv+VsQ
 +LOrqL2FiopZEOj3fInH28nCAlGCJ/joc9A77cj4NCCzmLEn5dYmU5x6UbE2mfR2vsXyXDDY7nJ
 OVX7ttK6MUYBTRE/J6LAigHnJ1F0TkugbDP2darQF1bDNYmH4Q4dlhoKqSARe1cwLqimikAszwc
 kbPsvWkmltfld1wffRk9bVt+j05kB1hs2Egp4oBiMiScxAeK1bimfJfy1lNpfpdd8IDRj4YxQ74
 qo4AS/hsOxiLDMKnaMw==
X-Proofpoint-ORIG-GUID: AED_N9ndlt5WRCA1CI68fT-K6gUloYl0
X-Proofpoint-GUID: AED_N9ndlt5WRCA1CI68fT-K6gUloYl0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX0kG/+PNk4DeV
 g4UBb30IuYtyYLsRNAyVo822IIUv93GV0TGmgt1revukWpizDG9tUUiBPWfddSmOmlD+4zv2Lw+
 fjgUICZq+Ri45QEYT/jhQK/jDuMy4AM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240146

On Fri, Jul 24, 2026 at 3:11=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:10:58AM +0200, Loic Poulain wrote:
> > Right, I was planning to add partition support in a follow-up series.
> > But since this is really supposed to be a block-agnostic feature,
> > whether it's a disk or a partition, I'll include partition in v8.
>
> Please include the partitions, as including them or not matters for
> the interfaces.  What is holding that support back now?  fwnode
> magic?

Yes, there is a bit of fwnode magic involved in partitions of/core,
but adding it is fairly straightforward.

>
> > > Also once you register the whole devices as nvmem provider, we really
> > > should keep it from being used a block device, shouldn't we?
> >
> >
> > I'm not sure, the whole concept is block backed NVMEM, so we still
> > need to add that block as base layer, though we could discuss
> > suppressing uevent for it. Preventing block usage would make the
> > feature much more intrusive than other NVMEM providers like MTD, where
> > the underlying device stays accessible. And we may genuinely still
> > want to write the disk (e.g. for factory provisioning), updating the
> > very data the cells point to, etc. There's also the layering aspect,
> > if a disk (e.g. mmcblk0) has logical partitions on top (mmcblk0pX), we
> > still register/expose the whole disk mmcblk0 as a block device
> > regardless. So if a disk contains NVMEM cells, I think it should still
> > be exposed as a block device as well.
>
> So we now get two unsynchronized ways to access the same device?
> At least we need to prevent exclusive openers on the block device
> side.  And document the side channel very well.

Yes, effectively, so the simpler is to open it exclusively per read
in reg_read with a holder (exclusive). This gives us proper exclusion
against other holders, but only transiently for the duration of the read.
It's the simpler solution if acceptable.

Another option would be to claim the device for the whole NVMEM
lifetime, but currently we can't bdev/open the block device from
nvmem_register(). That path runs early, while the disk/partition setup
already holds disk->open_mutex. So that would require a larger change.

Regards,
Loic
