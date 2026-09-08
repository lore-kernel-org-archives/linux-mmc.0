Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8F36B93A
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883832; cv=pass; b=ADTwhB5Vf8Ncx3YYPINnnZvf3ymBo0F/c99VGE1RFA4g1ebo50vpEQTixORoVoKp3C0NS0wgsyNkYBjbS74nGDPnQQyB4Fqv38CsbCBnMAWkoEmnnnfm0LtUiGBAICcvSUdh50fekBrn1wwWjyrzwoGTHHs9+ciu12sUQJHFVQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883832; c=relaxed/simple;
	bh=6aGgyaVNV+tz9lQO4iNPAUjI6AhvmkuMr+8cf09tqq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1H0b3KNRp5FDsMJgjSbuvA8CZlzpoXF5bxlqSUUfWA64c7ERtyn9jJbw6uMx2WCynNWNghS2OgZvO8XMwjVVFDp4HqGYmH9LGeNuX4fBjpSgBnjhDOI8jT42BipooOpI61DUzD6MH6q2f4u9pC7wxDM2NCAxwaDP6mCUrhvsHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wym9qvhx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NB4YpsS8; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wym9qvhx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NB4YpsS8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdX2L2769554
	for <linux-mmc@vger.kernel.org>; Tue, 8 Sep 2026 16:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/jmstT2Zeq9ftDIOt+LP0+nqq62lgJGu5YFnVkMj8I8=; b=Wym9qvhx0i9s34Ns
	deiPdGODZSfOch2qfXuQPcigTEkHSNjVMjrz1XahSpCoPP7TTnOysq3lkFQZz4GX
	Hp9N7y0MK9ixz6QUc80mkw+By6sNWwBgt3b54br5DlyM1yUwYYc0o6eWVWPtECbQ
	cVIOxRYoEwPDUDPvkpg2wDO8qYya5Y0hdpuP/KwhB+a3vcHJHE7kJuipfrkr+dt5
	D12/EUqtXotLT2f6sGepK8dMurVGmHP9u5mv1168UdJjBeMicmj6uf8EH4EBrKf+
	6H/U1Wi7OcoMHItVWa6OC62O87oRkRcY48JqzeaJmpT/mDS/Z1wL38k9QYVpdp7g
	WpJBnw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvugxa0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 16:10:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f80c76e6so91228025ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 09:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883822; cv=none;
        d=google.com; s=arc-20260327;
        b=OBbQLsHPUeSxgQCKIOmF+33enndsLV3u8b5+mCuJPLQpaKEy91ChpbPCU75KvihRY7
         o8FQa9kzlN9oLHRH+HHQJCnENtCGav+RD3Ce5mahgKL4mOgUGkvvbs10++bdOWGbkHEh
         9/fYmQRwP9l14jncHnaU8cwZlMi5b3E3o6WPMzUWE6yjSnQMmJnBGcLK2O1H0cGpx0UJ
         QacWvSPPnnb6ycsSssFDkRA2/zFU6q3blJVDd1yIKAPvpZ77l36R2UvU2DZqqc8RqGRC
         vqNmLiHcxy0qJydVGcg1DcFRk7CBqF0+n8yMYRCVke2mgwNKkx93PVAHIhw74T0MHUPC
         InmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/jmstT2Zeq9ftDIOt+LP0+nqq62lgJGu5YFnVkMj8I8=;
        fh=ypGwMMasw7+dc5Lz3xJuJ1ldlFiGCGNaqPzJNKhO8B8=;
        b=kK7GkFNp2uG+RTb/2zXmvYtQmOEFdYMOprBMyWIPyPmxQVp1A0h7Tq0V55eeX3ongP
         PVjX5uEZ2IpN5B/fMdPv6w+E2W8t3xoDMk+6xZlbw5LvXQRC9k2ux8dC2aCn16LRa/h1
         G68TEQN0Uxi4p3AaE+FiPEruwMkE3W5RmdV7ON8GCJu0jMABKaE1xqHNho7qVPbLTqdr
         1xpq+x8s4c0oP20W/OEAKChZS0sepg4JZqJxo4146Sa3nSvz9S7Poy17ZTTmRLQmgDNJ
         neAJXUTSGudgbf7D4eiRhArs1M5Nd1ALoP9D0591fZd4NC44SogKJ2HzM/xURSbJw6K2
         h0Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788883822; x=1789488622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/jmstT2Zeq9ftDIOt+LP0+nqq62lgJGu5YFnVkMj8I8=;
        b=NB4YpsS8y5SGnhc0y6rwhT3cyYEaYr1mJ4xVuoeuKrnlSVYqdMQL7yGKraC93Y7hdV
         4ftZJwhGO0T1YivXfn27av7CqK0pnvmagVnwUcBxvXge9TRdZ4Mlby1hYGzA7Ar8i7qy
         O+Y75KxGtPAOqaPw4KL5UVIzFHyRV4QqKUEQp4iFZxxLw+BaHsryGC9JUk51jFttvzFa
         qyoDr8wCpY2KYf/fLdTX14fyJY3pN2D9WDhTM4y2Y++94AFyns42cJKmvX6NoDY2PxRW
         D5heljV164dRfsVrhJcgLkbNGQIrKa4vO0NXCqkJBhy6ouj6dzv+Hu5hXIPzYivFw2b2
         CBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883822; x=1789488622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jmstT2Zeq9ftDIOt+LP0+nqq62lgJGu5YFnVkMj8I8=;
        b=LjFZRt9TuaWYZOW1VihIMRWPmbBmx4zpvqSmt9PcNtu7O21kTGvSLkOzbk0hlRw/Jr
         4XrH3gHisSDN7mRoVKVjBHgU+Wh2aUMJQsWbCuzai37F9uQLzH/EWkv3VRIzNQZxqmXY
         wQCi+vO4kbPHgHqudg2KBscbLcVg9PwWaum7ZiK87kcZqd92sOmFK/3jt3CJxsuJhUmD
         VvFOfJTrNQP2VWzrny8MpByQ1TdV6bEazasFMz1/fk2Xl8SKzSVuWJXZmMyFRQSGJx6j
         TEtHWV32s/hVUMjyqBl76k8E1i3sjMT/c+fMf7tB5B8pU0ofUOBj27cfMTsHITXFSs83
         PcoQ==
X-Forwarded-Encrypted: i=1; AKwUvByPOQtFgYifWoidDWoe2sAsdBjNUqX4xvaYkhcOiWjttD97Z63NNTtu7DsZ9P0EmSxJF2isf3QfIiU=@vger.kernel.org
X-Gm-Message-State: AFuF++m2vwFkNmkoJU4dKVZafLBU4w4mbqZTvXTYopVlroaUZnCHI4hA
	1dkFWFInkPWNxRzZKe1jeHLcI9grxqk28veNZ1ctqoNYobOV8shckDUKpc54FxNHmqRnY4S25lo
	/bqnVMXh9L9b1kW+aDn/V20csdBZUQQjmz/VttrqaE822NLUN+HsfVQUGoPCksdeIqX7VixMH3n
	0vAPHYE6rckLmzlbO7jXt51T7Ddhun/niVd3vnmw==
X-Gm-Gg: AYBFou0GdYwqNo0v13zumbKrKcDsJgOITVU4IIVnZSwOj4uRvja6BdnbtlP5XaR95T0
	HEndio3D/dWRja6u5Zd/IwzMinwTnQZ3Scd40ImxKnXFV118kyPu7IdoVZ2m5OvJw1sEjuX9rlJ
	7TMH+72aHH93D09TBos1jCDYi1izBdl5aCAvEFDNV8+u22uJQm11AFh7eh2w==
X-Received: by 2002:a17:903:1b65:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2db8d928e3emr2837765ad.6.1788883821919;
        Tue, 08 Sep 2026 09:10:21 -0700 (PDT)
X-Received: by 2002:a17:903:1b65:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2db8d928e3emr2837105ad.6.1788883821531; Tue, 08 Sep 2026
 09:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813053404.21553-1-phucduc.bui@gmail.com>
In-Reply-To: <20260813053404.21553-1-phucduc.bui@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 18:10:09 +0200
X-Gm-Features: AcwNN1UW4IZJxDfsw72uzKL4GFJXZL8rZaPaQEJwZlE7EQT6AUnNa1eW5qYq8ig
Message-ID: <CAPx+jO9=Jvi0BqzSUSfnY5LXbt8g-00h5pvznL76gOiNzi72JQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: Handle errors from optional IRQ lookup
To: phucduc.bui@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Stepan Ionichev <sozdayvek@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Osama Abdelkader <osama.abdelkader@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: SbSMkuXityFQoHfnib45rgkkMIz5Gnu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX8Q0/uTcQ1H5Z
 diKCJ2f2/ubGnYiIGkIyxT4MXfADheai6m0Fd81nYwoUS1GzfGEJmolKmMCKUIF5zwm3fAqYCmM
 RGBP9jEsGHtrKCRXbdmsq6qlVfP81PUHBRTUOlHY0gsJmhNMYHGNUfj9OPyueZtssQmEhkV3eyP
 Igw77ifJhGs+WPLB58McR09dKz1FHjHNJEpD74nbGfaB/iTnTg+sq+fvFlsguTSt0+kjdhixlN2
 0PJ+60vrLu74HCOiF46izKaBuLGAyHGngFX6NV9++Rz3eoVrXk+97ClKbqxUqdtXHx8Y96gGyxy
 2xzvsyl9ebxBYq/s/zfinRMyRqOPjt61156OFs8MGEzBpPMXbac+Kwe2zq/oyjEpEyeUuHLHADI
 VloHv+jdP9kKnyoqmQtwraezQGmwTal2FSXPqDT/fDlKtqYPCYNk5hc3sxWno/N2WDuh4NJWHP5
 sARNRAsuKTeKIyVKVxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3NCBTYWx0ZWRfX8o7ccTxLau89
 DcFW8V/oYABAGTdjjTbOi6oeuo+7hz29kBLKDzd0q4nsg231FIdMWn/G00XVtGEzr58avQ1S/wS
 02aWQPWqo0yMxxsR7RHJAVs1klX19k8=
X-Proofpoint-ORIG-GUID: SbSMkuXityFQoHfnib45rgkkMIz5Gnu-
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa03374 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=tukmojBuO8YyzP4fvAEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080174

On Thu, Aug 13, 2026 at 7:34=E2=80=AFAM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Hi all,
>
> This series improves error handling for optional IRQ lookups in several
> MMC drivers.
>
> I noticed that mmc: litex_mmc handles the return value from
> platform_get_irq_optional() correctly, distinguishing the case where an
> optional IRQ is not available from other errors. This series follows the
> same approach in the affected drivers.

The series looks correct to me, but someone should really look into
improving/replacing the platform_get_irq_optional() API. Callers
should not have to check for specific error codes as that is just
prone to problems.

>
> Changes in v2:
>  - Use parse_fail for proper cleanup on IRQ lookup errors.
>  - Initialize cd_irq to -ENXIO.
>
> Best regards,
> Phuc
>
> bui duc phuc (3):
>   mmc: meson-gx: Handle errors from optional IRQ lookup
>   mmc: davinci: Handle errors from optional IRQ lookup
>   mmc: davinci: Handle optional IRQ return value correctly
>
>  drivers/mmc/host/davinci_mmc.c  | 6 +++++-
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

Applied for next, thanks!

Kind regards
Uffe
