Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369591;
	b=DoBWBkaYJpgvjDzbf33Ta2GlV2Z/oPWZjU5/enLPK6cndk/BjxPdbUOTkFM+ypiBxc2D
	 UnYSb+OveVA5UHz8ghWyV9mPqs2btrH11Fh+DcUesQb56yqCpFm2f1OQHFIIOY36Helez
	 cvXyhWVUigw0P7TYS2/zTQ+QBJyT/IkXFMNUSeh+9ir/ALhDj6rz7uUH12ftI+A3GBjum
	 hbMxTXKWBi9/p2SXBJNI12RbUxTy9dAU8ihH+RkSHnFW1Fz3GgRCS43mdm7BMXcf5d8Ps
	 c+rJC7FsKDIclDJ8bWA8rU2j5Msl8rrMM7tjhoBQ/kV7tq6r0bEP3HonnCs5O1JiPdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NUzcSHyggq9tqhkaG69OpzfnfjchHDGUoaGLtUyxly4=;
	b=iOSLgBnIVHYrxidpX7b4JInTNeVNz1OFipYVtC7GEQtOk1lrE0p5fJ/PjlhFwwIkQ9SO
	 pjDaDrPv9ycAagHbh3z20OycTUypF06jDxNzOfBEz04ovn49Fliz0qE8Io9sZT2xX3GE/
	 9Gcto0MmBk0ZADXF8aCwXy1I/hAr1Bu3DsX9oxUY5r4rjdrlB7wfJISMz733O4uIUgqht
	 8P7rCXAune0kZa/UBHR4SKunQ4howQf9+it+goVnoZUbisrBAK5umiotABgJoxQ5C0ztd
	 G2hIF0xudTU63303KAL7fzBKiNU9E+nAYnmWR0kjlezSciWITNJZfrTdbCPDoRT5Jlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kjeZ719u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DoR9Lcq6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29043606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29043606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kjeZ719u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DoR9Lcq6
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDn9pa2511781
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUzcSHyggq9tqhkaG69OpzfnfjchHDGUoaGLtUyxly4=; b=kjeZ719uG6oJSdNA
	Ugbpodn8/BEuuwAGNekqvfq359Wwao63stVYVTyjHYV/QykHUcGpcZXha62Ak6eT
	hTFOA6SlNXXxggg07AnCs0H3jg7hCBG6VBdORjgisKzyywqC4qNDI3P91IDxrL/b
	MFUcxPMOtOFm5mngI6NhVo4fHN2AycjnGcMxrge7Ml+J7aSNUZe3QHt6elyxsizp
	zZ+gIqLergREsPMO8Fpj+i2PBI3HisqDSSkQVMElSvGesTdX5aFhv04mJpClujfQ
	0o7HcYlYRNn5vyS0kdi+aHXOtVJLKhyRB1ClYDqnJH3a65lRE143gtEAv690fzmZ
	Gde/Gw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pbe5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:13:10 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7bf08dc2fc8so143364137.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793369589; cv=none;
        d=google.com; s=arc-20260327;
        b=LBdJA61gdLjCus+flu9zapqf6IJaeb4lkEZ8hX37V9189lhLrjjDI6Gbgiq7Yhe5Mv
         +BW406UVQW7VinwDeEQQ8WpjsjBo9ZahVJxrb7hwOPN437e5AeXQnNx0QzMZZ1Em85X0
         NF+P4tzPZBq2kUk/o7LUX+DfIg38lElNFy1JC4fy3PXqIAktvsWjxUGEsJI+kv/QafI6
         PZQGYhhKlJ7Se41IZtV2nOVA5lxKYJimoHUcXFp3esqaeSD6N68rdLYNRIt1hqrjuHVI
         hAuq6Yi1N/I1jX8eYOJSybUO+cp3FCHuUgwjucJ1cKGQ5PDtQGUwXxUFAMFy2dn7DX+M
         +YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUzcSHyggq9tqhkaG69OpzfnfjchHDGUoaGLtUyxly4=;
        fh=ZCjaOEp3Qfjc5s3IhonR73ZiPtcueJCiuX0xlIExtnM=;
        b=ACg5AzZ2TymB8HMugSp+uOFUm058hGZ9sFGu0lvrJhkVhDf8xXyF57ca6961DSviwV
         eidV1i7Mz9dPBj5zQjUqKjRMUPqvsyjneR6Xuj8be5jMDOJcmLm1E+u7XHxEB9X98Q2p
         eGVb78WwdKg2dcpJwlwVFS2H5d4G14xnTCkiF24NzE914Go5mWs7Szis4yrmBEy58CIj
         /7Jh9FZsOwcf7CCws6GDv33hbHDL9sK/Q/AMInENgj2+Ftg3yl2ZdIUXs2n4MDMCB3JV
         0ybVKQjfEWFcHdT0eCPyHAml+FK/f/ZmzGA99kKtHRAm7SXEPV7IWVDXKGuc9uHBjqp+
         /oUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793369589; x=1793974389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUzcSHyggq9tqhkaG69OpzfnfjchHDGUoaGLtUyxly4=;
        b=DoR9Lcq6sWMBhpV7ISzf7MQWp/Z5H5PJ13HT45ZaIqo4ygDAeJH5fI4JsDtO3i/EhQ
         /jmSQ9TX0jF48qHL9arArMH8aV28CKSVdXUML/IYEwihAe0U6Sbu51rSs0/oQjSS1Rzn
         jxI2yOSWeeKuijidZrQQzSxNoQLnKlrYkrf6tPHyGQeZ29R04ExFiJm36FriE2lLZ3RM
         eUSJtcvMJGVVqy2WwXdsUpGSGKRbu+naDiAzZzs4OBOshCxHQYcgPRa2ZVEuOQha0tFK
         g8NR4I3TNkKg7hPivFcI9LnESGBjQ4VzTVAK0xL8734VipobbvO5mDMqjvyzw6eMjvE5
         C1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369589; x=1793974389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUzcSHyggq9tqhkaG69OpzfnfjchHDGUoaGLtUyxly4=;
        b=YeoVJkjbYtfvEIkY0XbwKpCr6SSvf+j0vZKEy4ZUfPy4UhltwFbTFn7EaMu0E47lKn
         BVX4LbeE0itWA/EgMYaelEkb7ZheZ1L0zYoUESF49UY3qXHsoSWlNyJbnLSU6ep6iZAV
         RpDm5Fwcm8YKW9mTocwmomjY+Zy7/fKRtbrvhb/5pVQeoqNbU/AlxZgOssLgArZBPIZn
         3B8A4C6xjeiQ30chvQJ0N1AkKhnIhtPZ/mDK5Owjc8QJlfnBbux5z+64/4JZBcumOWSo
         pw5zbm7122lRhUvild+UROQvbgPVHU2p3q32C3o5W89Qhjp1rO5oVac2Vmt5Hzpsib+T
         uMIQ==
X-Forwarded-Encrypted: i=1; AKwUvBz38dY+CqJEo8AtKhEwPDEjCV9Y47GmaHXZwdBUZVMwWsSQyRRRNCETizSNar4C5Jp+4hLMUsyGpHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHmbW85rYPjoa5lEBXodd58YaWGFWqn9HnfiFALLfkesdTp0xW
	hdEZoG+p2+eIeIBR4DZZpfPZwWkDKOeZlBIpLEaQwuRrTD6qvxrqxT/ROj4GKVYxYBee7pabpwp
	MEnUA09RXTQxFtFtZJfPwPoQdPlZYYHC/Jp37dq8d9Cg4rs7lZhkLD1XLmwGNmA8AjYBjTABUZB
	u00DywZ1lrY+w45waTvvpuJOuA0VHfLG4YMei60yGaaFOYhA==
X-Gm-Gg: AYBFou0XgU/6h0hE6fEIKMSDGb/hqUodn+tRjF0Aqu4C7VAJ8oIt5Ubopx7wWvshH2R
	8NMM1lkHP0pxf1xWj5e6mgU1tQn8B0BknW8tigDCga3NlUL41oPfEzaU6XETY+37jrLI0WJEzEy
	m9UBe5vdP3eUvcin/w3RIaEKuPieglrRUQRToUBxHun2EduSrlUFXkIglgCg==
X-Received: by 2002:a05:6102:3588:b0:7cc:2152:4f88 with SMTP id ada2fe7eead31-7d072c827camr1113188137.21.1793369588875;
        Fri, 30 Oct 2026 07:13:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3588:b0:7cc:2152:4f88 with SMTP id
 ada2fe7eead31-7d072c827camr1113174137.21.1793369588220; Fri, 30 Oct 2026
 07:13:08 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
 <BL3PR16MB44734321BBE9FC4EB9EC91C7E5BC2@BL3PR16MB4473.namprd16.prod.outlook.com>
 <0e773d95-eaf4-4408-bd20-42821c38e634@rock-chips.com>
In-Reply-To: <0e773d95-eaf4-4408-bd20-42821c38e634@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:12:55 +0100
X-Gm-Features: AclHuK8mlx-CDmcoJUylUWnywDskDlZOWl9tvGwQjSfc9pxKqO4nu1VPRaGBn48
Message-ID: <CAPx+jO9mbSobH3m9ZAgr4RvDa4n0vrdG8u4cNo4-RYynMx1j1w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel
 cdev + mmc-utils)
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Avri Altman <Avri.Altman@sandisk.com>, Ulf Hansson <ulfh@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX1cRqtYSQ0ep2
 n3bFYR89UtenwOZj4JubyvVJ3FT30BkyBwxwpHdc8Jyd+HdHL6Utl8lB1fO/SQTQPJ0H2a+SRqi
 +hZBz6IcriTiITWUV9IVGdAFiHSDN3Ur65SZYQxiN2HS1IMvfxNOniGVCbY4BGyYqbXK7t3wzX/
 299hLHkkvIxwXIYAj+R5b7F4O9DH7RPcGJBCqXYnuIBPQ1XmGUDc+/qetV3Nd2FNSs0O+L9b5vs
 pbCFNrgXzmDTrwu/ZiF5whevVjHqYizmmGALK78GFrB84APn6QVmBA5fwWLvKBUFd/4d8w9jcuP
 LUkVw8tVbSO2Oj0owbljETkpq5Fv1CjGvRLw0Ht30OvNXHd93aFPTlGZohFfjp+YrujyjYSNkyK
 SqZeypWitgi8QtL1Q+CwbBlTOp98K4LrK/fq0RB+nUSSp92h68DR1K73hPx3d8lEiB/m7eJZDO8
 rsZdDAObbEPvyDKswYA==
X-Proofpoint-GUID: B553eqZnEcI1cqDscbC2dja_Gza19_SX
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4a5f6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=s8YR1HE3AAAA:8 a=wfzTyofhZhidIFns9ukA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: B553eqZnEcI1cqDscbC2dja_Gza19_SX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX12OTxbnbPBab
 mWJNlPr4OGnEy1gc/fJLmaZIQLh6fPMgWrafivLrL0Z6UENpmil3euZq2ofuQ4VticwYSzeg68Q
 sUjKoZj1BEMb3ddqtlSFSSDvGs6JMxg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300056

On Mon, Sep 14, 2026 at 3:19=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> =E5=9C=A8 2026/09/13 =E6=98=9F=E6=9C=9F=E6=97=A5 15:24, Avri Altman =E5=
=86=99=E9=81=93:
> >> From: Shawn Lin <shawn.lin@linux.dev>
> >>
> >> Hi Ulf
> >>
> >> This RFC series adds raw userspace access to the SDIO register space, =
spanning
> >> two projects and therefore threaded into a single series:
> >>
> >>    - Patch 1 (kernel tree): a passthrough character device exposing
> >>      CMD52/CMD53 to userspace for every SDIO function.
> >>
> >>    - Patches 2-4 (mmc-utils tree): SDIO enumeration in 'mmc list'
> >>      plus 'mmc sdio' commands using the new interface, i.e. the first
> >>      userspace consumer of the kernel patch.
> >>
> >> They are sent together so the kernel UAPI and its user can be reviewed=
 as a
> >> whole. If you prefer, I am happy to split them into independent thread=
s per
> >> project.
> >>
> >> =3D=3D=3D Motivation =3D=3D=3D
> >>
> >> SDIO cards are normally driven by function drivers (brcmfmac, mwifiex,
> >> rtw88_8723bs, ...), but bring-up, debugging and factory test frequentl=
y need
> >> to poke the SDIO register space directly:
> >> CCCR/FBR in function 0, or vendor registers before any function driver=
 is
> >> bound, and some deployments, notably lightweight IoT boards, want to
> >> handle the SDIO function entirely from userspace.
> >> Today the only way is to write a tiny kernel driver per device.
> >>
> >> eMMC and SD already have userspace tooling in mmc-utils; SDIO is
> >> conspicuously absent from it.
> >>
> >> =3D=3D=3D Why not lssdio? =3D=3D=3D
> >>
> >> Standalone SDIO enumeration tooling already exists: the lssdio script =
of the
> >> sdioutils project [1], and the sdio.ids database proposed here comes f=
rom
> >> that very project. Still, I would rather grow mmc-utils than use lssdi=
o, for two
> >> reasons:
> >>
> >>    - Userspace tooling of a subsystem is conventionally unified:
> >>      USB has lsusb, PCI has lspci, and MMC/SD cards are already
> >>      enumerated by 'mmc' from mmc-utils. SDIO devices live on the
> >>      same subsystem, so extending 'mmc list' is their natural home:
> >>      one tool, one consistent output format, one place to maintain.
> >>
> >>    - lssdio is a standalone perl script, and SDIO devices are mass
> >>      deployed in lightweight IoT/embedded systems where a perl
> >>      runtime costs 10-20MB of storage - a non-starter there. mmc-utils
> >>      is a tiny C binary already present on most boards shipping eMMC
> >>      or SD, so SDIO support comes essentially for free, and the
> >>      sdio.ids database it needs is a few KB.
> > +Johannes , who might be interested to comment on this as well
> >
> > The kernel UAPI may need a small reference/debug client,
> > but that does not require making mmc-utils the home of SDIO userspace t=
ooling.
> > The fact that SDIO shares the Linux MMC core and SD physical interface =
is not sufficient:
> > mmc-utils is a storage-management utility, not a generic enumerator or =
control plane for every device function carried over that bus.
> >
> > My main concern is the long-term scope boundary.
> > eMMC is a JEDEC storage specification with a relatively stable, finite =
management surface,
> > whereas SD and SDIO are part of the actively evolving SDA specification=
 family and extend beyond storage into device-function domains.
> >
> > Once mmc-utils starts carrying SDIO function enumeration and its own sd=
io.ids database,
> > it establishes itself as the home for SDA SDIO userspace support.
> > That is a substantially broader commitment than a small reference clien=
t for a kernel UAPI,
> > and it invites further non-storage functionality as the SDA specificati=
ons and SDIO use cases evolve.
> >
>
> Hi Avri,
>
> Thanks for the quick review.
>
> I agree with the scope concern and am happy to keep sdio support in
> mmc-utils out of this series, so we could still discuss this later but
> focusing on the UAPI design itself now. Your suggestion of a small
> reference/debug client seems the right shape, so I plan to rework the
> series.
>
>
> Ulf, any objection to tools/sdio/ as the home of the reference client?

Seems reasonable. Although, I would appreciate it if you or someone
else could step in and help me to maintain this part. Similarly as
Avri are helping out with mmc-utils.

> And I'd appreciate comments on the UAPI design in patch 1 itself.

Yes, this needs an in-depth review as it becomes ABI. I noticed your
ping on the new version - my apologies for the delay!

Unfortunately, I need a couple of more weeks to complete the review
(entering a busy period with traveling). In the meantime, perhaps
there is someone that we can include to help moving the review
forward?

Kind regards
Uffe
