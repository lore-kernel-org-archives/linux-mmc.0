Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6F41E6D4
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209059; cv=pass; b=rgVY9VhJ28kobAE59bsfO4bR/b2zkVrieSTlvV42hX4grjW5bUh+BmCMqNUuRX6ZIfJcErulWEcom5sa6E4XvXG0HD2Oo9FcpXngLrBfLdraOZG5C2140Gn/+aUkYpFyIZ/nvl7Q2taIM84ENZ6broE169Iryx/eu4yY2+y3JKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209059; c=relaxed/simple;
	bh=1aXnFY53krYuOZuQpV2j2RhkeAvxCo1KAwi0UjQa3G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpkpw1Zr6B2FLCU+CQpz55rRiZKOVZ0QD5qm9C2vr+cJBaA4w3UaEjOdfqEDWdtcQGqb8M67INlceK6ABUkzaxPA61GC+/HB3OnIpHSB02Ud49VOxLFn1YOyk6NcPH6JHQ2wpxQO2RdBAmjwKP/1ZXGmPe14cqL5iu06QlcJqq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=koBtFBM+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BOqklBCy; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="koBtFBM+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOqklBCy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJnWK2837994
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X7wiIfj5l8bSUfyQ2Jq7YXo0v5uKuE1RL41eHyKAd4Y=; b=koBtFBM+1qmC14tw
	RzE0fIEWxqBlfrZmmXzos5RSoSBfxEXFDu8S+SI+370w6MxHy5uhEeKOzBoQxryq
	gmcXaSTPW8h4k3LNfY1BDTVnseL92z7YcD6Mp3B6ebRbY96bDBZDrXHVZKqadwwM
	6x/r/dXYNy6I+py8B37LcOLwZLgbtyT8mgJupAnGzRG6/nT7d0kX1qhkFdJ5eEk/
	Rt8Im2df7hlxAzdqxNjEvWfhyhZkVKbdU3ZrwF8Cs9UV6fwzCVpa54aLTIACV7Az
	HjYt0V6NDCIAXeMSVVxtBp5zZsIOpQF3fDvTwzh8fMKVQCWByyb6F3OP3gLQyEOc
	vrjHZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqm4dy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 13:37:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ec3146553so1346370685a.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jul 2026 06:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784209056; cv=none;
        d=google.com; s=arc-20260327;
        b=EL52BDSzzk5CkzS/5Ua7oddXpEOQpDT1RsVzzEJjBhWmC2p/HLlFtxuLqZPZIFGGcK
         pGAlNixXPJn2hfh8YfsELWlatjo55lZqnqgddc7tAs6ZUitPU5avJp2saNwGsiLaiF1V
         MHlvSN+FJaJhL3BreS1/x+l4DN1UCLWoAyJKkd3boL289gFF4VD7ddb6hPJlXj+gcgS7
         h23btzYETtA8vvGj+0Y4iAulPveSJeGoba1ZhuAhkjuYcok7fBcc9TFWu1Sl0T1TnR0X
         DLeSF6y0E0ytcMt65KNn1nujSLsbmEh+dUQJSOrlEjn+2px8ZXPY+UcCjMgUxyAWJSq5
         hxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7wiIfj5l8bSUfyQ2Jq7YXo0v5uKuE1RL41eHyKAd4Y=;
        fh=7QriWlS4U0icu6m/72NGA22bMQRTV0KmoTSy8AjNEBw=;
        b=rMK+wuuo6KJqnFYpgiK0l7sL9QRYqscFd+HR6k4ivtMGTymKiQiivMFWLPWgvhOQj/
         Wu5+MJhqQFiYP/UVwtQeEA0rXUxQGkSMT2cCkCAWqNRpYo/7XEhJe4l3ACWVlKZ3BVN9
         v/gISD9POqemSGR3JskRfAJgP68f2Flx1E1O+hJlxvw+bepJb1YdqW/qQiCvxQzE49QP
         mZjCJSUzGt4/W1nnD6IIURXFideuDZGtzRsC2uRR9oESqw/odzp03rjrYFEioioUAtlS
         GfNTJfh+PLZwZoZ1/tz/V/aI5YVWTuAuCFVHPNeUTJmUofpYKloIaZkSlPhoKFWy5Z7U
         9bug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784209056; x=1784813856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7wiIfj5l8bSUfyQ2Jq7YXo0v5uKuE1RL41eHyKAd4Y=;
        b=BOqklBCyotuyFPc2yE+ZJSoE95q1kkRzY7/iTValDJw076wHbe7PnNZGu8KrfTdWhV
         WvPHI8RGIsWCjyuU0EyqWXKp544iNwPlJC4oAJmYbgGiKL7CJv5yyu0fbtIosFf/bROh
         Oet+6b+ktVQKUPMxNBbAAUDCt5LWM+MDOc/U3lMYdXkXwoqWrhcd3SWDGW/HTmBuliw/
         SaKUIyycPKLC5TE2zz1Qh01LrHq1MDkObinAf0noYpdF/XxR5GoOp/+nSaNEPXJxPc/k
         pI5RARRMk1VfEEDYCxE73RgVBdx42CeQRXS/DF5OI93pQk6zF9pLgYdZqsmKUy4o5ZR1
         h5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209056; x=1784813856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7wiIfj5l8bSUfyQ2Jq7YXo0v5uKuE1RL41eHyKAd4Y=;
        b=BZsHC5KQt7yhVotorNeTDEX7oPW5Qb/lVdOHrjr20a80rRrEIijujFvjA09FttIdev
         axHHCWPfvo63Cu07aVL8aBDkbHj3DQumL56LdC3QriUQROfY06MmCpvaQM6p877JTq45
         dAHPHUitHOZAX/DGxNXNMXf21Bdum3lgva8z7skkf3t/plfGI6h5pSkRp/3dfNedzvL7
         wCzlBTu5K/bzUPDOegxenGhhNtkChKWacxCvZqhSR3zbXBY9+cD7XoigAltrzQGIdp/h
         GeAfV4P80oYCnGGng6jD/3ExuORVADU+oiR1MR0hLdNQfatT0T0WbgjrFLMdV8KfPVgf
         zMcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCwy67RIqUZxvLjyVWewu5Iph0YwqqsITp7kAjIFcgTwlyF1RyMunt6Xm+sOWwcjHbPlKFxKQ9VMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDvtqLbXPtFHF4lmaUCAKkbM9+cFzj5r/qaZcjMz1LiwnX44P
	Evatyzpe9FiGtuy5ZAwqwfLUcP2u6V4woKE6TexTfA+2WQ5V+JlVkeh35X6hXSESQ41SmhsDPos
	RHEjfmW4B6MJ9Koe/659oqKVmBa3LBsZhtb1BDXMYXyrWtEWwsrMdewIs9iAS2tYFI3lfl0slEs
	1dFCR5zRmP4M6JqGwOICRwVQy6kPY16GPZId9tKw==
X-Gm-Gg: AfdE7cmU3BhACcOmPbkNEETtbe2Rnh5Xn1+OrA4ne9/DQZxW9tXWKpAlIa8X3t/2LDu
	zRfu4X1kTpwmCanDjFWIhjJvZ45hofV4gHbokKMNY2Yzj1mJDti87TxQH1sbYWk6rPEMCNnL7SS
	0DWxa7vg/s3+4dSaJA7JpvSpAQP+wgs97l8kolC80VJfcRrJ5tyAJIx0lMoFSGmu0rIS7PBtIuV
	GxqLUI3nMtdb1We4eb06lcjPqwV/TQJ+PZgmRhhJZZXtvBeRhuQSNujPCQdKLw3vgnIu5l0zR7m
X-Received: by 2002:a05:620a:2a09:b0:915:94f7:55df with SMTP id af79cd13be357-930961ec42dmr789767785a.20.1784209056491;
        Thu, 16 Jul 2026 06:37:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:915:94f7:55df with SMTP id
 af79cd13be357-930961ec42dmr789765185a.20.1784209056076; Thu, 16 Jul 2026
 06:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
 <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com> <CAPx+jO_6KcZyp=4HuJqnYY40VKt1ee+si0BEpxUE+1pkMFtvCA@mail.gmail.com>
In-Reply-To: <CAPx+jO_6KcZyp=4HuJqnYY40VKt1ee+si0BEpxUE+1pkMFtvCA@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:37:24 +0200
X-Gm-Features: AUfX_mzUGsJpNZbOCbBzK6qgEgvOrmyZdlmDjPAHBJOztrU8oh-UhYCbNKmWFvI
Message-ID: <CAFEp6-1CXaOHFnbSZ=ijwSi-nBnZXv1v+DhjT5P3GQoB+zB1Rw@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58dea1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=qKCy34jk-mlrzchimWYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzOSBTYWx0ZWRfXzsgziLto6POR
 abJqyPKTepx92G/K04wQgXTq1DT+D+SCN0mtKZwRKdIHvQPf+7y7XCkzw458xbksH1blb8m8yps
 CPWjJae3UUafNqQB5bq3l6srR7j/1lI=
X-Proofpoint-ORIG-GUID: EMRy1qhZ7UnYROZEe_TOUWH_6R3GGdVa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzOSBTYWx0ZWRfXwb8UmHqbHcg6
 FxnDbYUxoIgTITpc2Frpz1WmZbBK6nR8c2UDVDUyw/h8ILK4Ts3UBPw1oisiUjwPaecUSyuqGLR
 SNnF/abDJcrNkNH6NNbojKvMV9P3UU+DFX4zEmKU5ylCBViJzN9O6QaTpHfJLJVhx1m8nKwkzjt
 gH8IfMD4GlTsKvPTirm5n9NrIqhG3ZuBWDQeWvShJU7nDkj5lfRdlVcczSa5i/Aj201ydMPOHdA
 921SpHvBY12z/gYnW0ODeD7RnzpVjGnbZVUjc85J7WrCvNODmofo6b7ujiMTe9gS5tQUibxQaRR
 15sC4AXr2BspKrBusHA60qMJeZ2Lcffd04yQMGLfLp4Lca3mb6jfeolvqmCQ9ptyeW8oB1qPLi2
 QErT5OKK5/3oqSOB9KRjOfOAyyXOYBmYO8JeaksrcmQUX9emXSUu/iZK3hUZRb/PMFCc2Aik65x
 RRatVEI37V015uHs3Kw==
X-Proofpoint-GUID: EMRy1qhZ7UnYROZEe_TOUWH_6R3GGdVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160139

Hi Ulf,

On Thu, Jul 16, 2026 at 3:16=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> - trimmed the cc-list
>
> On Fri, Jul 3, 2026 at 3:45=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Allow an eMMC hardware partition node to describe an NVMEM layout so th=
e
> > partition can be exposed as an NVMEM provider. This lets a partition
> > (e.g. an eMMC boot partition) store device-specific information such as=
 a
> > WiFi MAC address or a Bluetooth BD address and reference it through NVM=
EM
> > cells.
> >
> > Accept "fixed-layout" as the partition node compatible, in addition to
> > "fixed-partitions", so the layout can be described directly on the
> > partition node.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> I think it would be nice to have some version history here as well,
> for next time. I noticed that v6 was reviewed and ready to go, but
> then something changed in v7 as those tags were dropped.

Indeed, the changes in v7 significantly reworked the DTS and binding
structure, so I did not carry over the tags.

This was called out in the cover letter:
Rework bindings/DTS so that the eMMC boot partition can be expressed
as an nvmem fixed-layout rather than as a child of fixed-partitions.

This change was made following the discussion with Rob:
https://lore.kernel.org/all/CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzsz=
PQCA@mail.gmail.com/

That said, I'll make sure to include the version-to-version context
directly in the commit message and/or when such changes occur.

Regards,
Loic



>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.yaml          | 23 ++++++++++++++=
+++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docu=
mentation/devicetree/bindings/mmc/mmc-card.yaml
> > index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca6829=
2b58a5fdbee218358 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > @@ -38,7 +38,9 @@ patternProperties:
> >      properties:
> >        compatible:
> >          contains:
> > -          const: fixed-partitions
> > +          enum:
> > +            - fixed-partitions
> > +            - fixed-layout
> >
> >  required:
> >    - compatible
> > @@ -86,6 +88,25 @@ examples:
> >                      read-only;
> >                  };
> >              };
> > +
> > +            partitions-boot2 {
> > +                compatible =3D "fixed-layout";
> > +
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <1>;
> > +
> > +                mac-addr@4400 {
> > +                    compatible =3D "mac-base";
> > +                    reg =3D <0x4400 0x6>;
> > +                    #nvmem-cell-cells =3D <1>;
> > +                };
> > +
> > +                bd-addr@5400 {
> > +                    compatible =3D "mac-base";
> > +                    reg =3D <0x5400 0x6>;
> > +                    #nvmem-cell-cells =3D <1>;
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >
