Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B636BCE8
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919108; cv=pass; b=OYiKpIRS+KY4p3E951Ro4OYT5DioEEN4qKo+6AhUURdzPv1iumuiYI7G9OdG+xLu9RpdqTje9X7mgbSu+NKijzulSfITgk63fER7djcVfmrI8km+DqtnZbq2tc7HZPPw2cdaXinXiu4LdhnGOmq2qvxTwjOq0jKtjLm82XwpjZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919108; c=relaxed/simple;
	bh=hhj8Vip6KRSgrU2uE5rO79Ldiak2Rlsg6Hs6C+XmYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNTrfw5o7g13EwD4xnw5MKZkjITutcpETtntNGhEW4ACd+aHWj38na4cw3MDsBb3DhmBgqUEobzlU/R7lk+FWGXf64m1651aR5SYOPdX5onI939eUskI9H3tKXzbp5i7JMd85i9Ym6B1vRwlD3sZKELWmHJP2sI6Gr0vXtihItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyjq1X81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcO5O9lG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyjq1X81";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcO5O9lG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9JHM3029443
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=; b=gyjq1X81lQIRnvcO
	G1um2E6TV7hqmLL1Crrjwm5U2JX9LsLsEKMoBAB5r9dv+Re6mmmqF2N4BlWwnJWe
	WipwNPhnPDyTaQA1648cU+hTlv0M50/vvS6qQKzliDV+B0P+UasYAt4nGWww+/2V
	Jt2hVfesaJfjYeEx6LLpZB3Zd7kugW563Aw8AhYGU9FXuGT9sI2lmrgrxr4ipjYE
	RyrKH1rZFL3kTTJ+uQ3sF56wCseXRx5Ce/219eLO3wNRU5YKKduHHRQ7HWqC5dUT
	x7K2ybfU3hPnmKnk9GZzZSnL5s9fuvmjIHV2Ao63T44wc4jwbv7XlGhlcM4VQxJB
	Ow6dcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun40d9j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 11:45:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5175bb9d47fso84771941cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 04:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919105; cv=none;
        d=google.com; s=arc-20240605;
        b=jtiUTzrPUJEcuHVo7P3OIrYWy3hSpT/iOwUpEEmrTG7bxxFKfgBjucxDjwRe9+utLJ
         yVHuI8duUvShbcwZra9O/ylpkgLe7yN6a2K54yG4G8I/wUrK2+XaQRstjG/oQ3n+spSW
         nc4Nhx3QPq/6lfpYBda9SICf4QFmqPpJqANUb4HxtyvZjQFuYOwn6/h+h66xxQJu0Ned
         Fh53eIcoRDF0jMgO2UvytuwUbRimnoVK4yGw6+NztEjTOgVh28TZ/i3T1e7R6/ybUH2O
         a9b52NvnhBtl56ey4AM71vlLoQ1iM9esFPSmqASkWxkSAKNZXxF3/fb9bv/llOG3tWjg
         OlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        fh=mbsx2oav/TIR6to68qbuvGpnH+eUT0neK5jwBHokF+U=;
        b=XDJu/3zsz7sBYRa/Zgp5iMjyAjCjZZpkVUpV2l4TGtae6XbX0gXD+lyHCUQWJBdCgs
         0BPAK7tZsxtoNxNOz0MCgWg0QnKKctMktCQIXSOkgQL6MHFKeqVg4w3V/sEH+KlBelMY
         lKCGYS3t3iJyRWcct5PojQK6FrKMZtm07kPvftqRv8I4kh80x6Sqd+68R7t6EGI54xwd
         HS03+ryevnhFeGJPqz2YPKEEYD+hBIKW+HAXouxlOHCdrCIWAmlOgvlNwEaw5QLkCda0
         bJybYp0XbiRThxByCAtJcsS1sZFhGOsaahS9m6PiMru8mNOAhNdZBvNKS5BVNWoLu3Ts
         Pt0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780919105; x=1781523905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=RcO5O9lGigUkcWBwngH5Wfra4pY3AIg683iEjDPu8iUitQvGL7OQVoChTSxOluDdJe
         +hSAORC1TWMgyB8XsS3ZAQFY7KgTWS5iYMxlK62hFqYhjc0ndnX9EaRRkcQijTqkY1r0
         YV1xsL0aKD023FfuillwZ3qcB9MvSonhseaSsiLWkScBlOaCA2s3mdI2kBvKree7hBwS
         zTCuF66jImfhEkiGIUv8P1cjypl2ziR+x80fXyxoz0Zm/Up+no+yC+OJn8FmtDHjGTql
         H6yt7tI8DTvpoPd8hNE1eRpZEjButzMMQak0CD/iP05MOo3AbN8OlKXglp+S8XyTSvw4
         wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919105; x=1781523905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=JXUfnIPPyIjlp5rwrkDc0qy/EgMCdPn93b5gkGdBfPlay4pU7ByghOkVcJvVqzlhrp
         A4dgviGvcucRoFK7RXE2RYbO4E5TLB3f8IsItT1FE5f0ibV5ajxLP7RzyXiLXJHdPMJd
         ZvGwDpT+46vjHaPH/iBJPgP+dAB2MMaifNx8CI0b6q/hLXkgCatbsnwbMJ6fPhXPDP3U
         KGzG9dfK9KDTTM8NkedQJhaCvPk6SSG6iFdfwYuo35vTWKvdMEyFc0w1w2tbVQA0l0RT
         ZkUIUy8y0J0nx8L9EeMBOlnfe7qrXZf1tIteG5/34U6FA9b9w7ivneuPybIlATaNNBAp
         x0ag==
X-Forwarded-Encrypted: i=1; AFNElJ/3A1I/115gYj/5oR2GlW46qLkclDCKT8tcoebPha7NBsdHe2NNW7YLVm6FmsuQ2s1bdISLcEm5UxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJjMY+va/xMXsEbb8/QsBdm/W0IGxEWv2DKMPEjABQJutEuYY
	PLw0mxqzbFIZmh5p0nByB48npWFCj8MHyBDxsrt7sAeRZC5WmlgL3qZUO73S43qdSt/6Zpp1LdQ
	i0CdN73p6iRC0jkBLbR8oSVJSbyy/aWSNcL1rX14bkckc5mOSz7kh2chbEiVQeWTdBgqIl1jwOe
	tmdOe9TVpVRYWD1PeWnFv+awhkSCDzgHhZcgSXYg==
X-Gm-Gg: Acq92OHOj/grezleuJPwZaTQOqhzTir+PsIPqpiPKcItQ6bJCm1NhNTVHMS8+lOvOki
	VuF560ER0/ke5AdxjsluhuOUGQDsNnYQ51XNTrIQcK1VAE4eVhx7TBlsiRMfGWA5xQsjclx/bjQ
	6GZT12TzBpMB2AAAo8am4o0aPcFi3vfc7B5PsO/h+00qN1/pJPDasX/RxcX05aSW/KsKSRJu5aG
	QrsJX/9bEkiVEVzeRWM3Fb8/kYil0hPTki4f5gtYjroorxyUFA+rXUzqKMfHhhOHL7lcJEH941N
	+anYwhg3RLXQTTmzZ7d8kA1t/La6ZVC5
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id af79cd13be357-915a9dc9a4emr2367276085a.47.1780919104840;
        Mon, 08 Jun 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id
 af79cd13be357-915a9dc9a4emr2367267185a.47.1780919104401; Mon, 08 Jun 2026
 04:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com> <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
In-Reply-To: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:44:53 +0200
X-Gm-Features: AVVi8CcIivK2P5dE8YRtSTP_9u8m9dGK-3gXU3su59C5FvR4dQPnW2soKiKG5MQ
Message-ID: <CAFEp6-0u1DBhXo9DCie5HCGTjcduWcHAiifVo88vFJwjYcjCog@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExMCBTYWx0ZWRfX1ci6Km53EL0o
 ghnPs0IsGR09lc70+QRS/UHk8NCKkoxB52KunxGF/j65CTrIrG0DEfmLm9eQMT9z9y5QVg6WQI/
 M96t2InOAWfqZsEq/TK1HbFUR1SHNXlXE7Hn5Z6RqFVYIxBYCWyVwoo2acqGjWYrVCLgY+bi2C1
 MTBCY2VHJ0GD3X+Qh4MUkh+ESQI9zXkSYy3RLDecl2Jiyq9fG4x+95fsx/evW0anEgiwZb9cRXI
 LzFPKnZ08Co738AjMyYjeWio8HStLivICCaeRJFabIL6ch6Rj52O3Cmn89Udgk0rOmMtbqryPaF
 ruh7I+w08V5JiNKlv3hprvrSAQ/rqe1SrqC/MEJ/wy4z4yvXBbHNTE+JKwKwrwWI3LjIFHyO632
 xn2FtFAfC8ho3WLZYZHF7TpGEOftnPT4qKO0RIjFvp41/vjryLTj25kL1QEbFCr/e8TmQe9UQxd
 WvwgTeAwsA5gt8fLT8w==
X-Proofpoint-ORIG-GUID: XVA71EoDNgc4_jpF-1zI-28L8hDnmVM2
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26ab41 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=4LeufcCx7mgyzPUJGOcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: XVA71EoDNgc4_jpF-1zI-28L8hDnmVM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080110

On Mon, Jun 8, 2026 at 1:29=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/8/26 12:50 PM, Loic Poulain wrote:
> > When the controller BD address is invalid (zero or default),
> > set the NVMEM quirks to allow retrieving the address from a
> > 'local-bd-address' NVMEM cell. The BD address is often stored
> > alongside the WiFi MAC address in big-endian format, so also
> > set the big-endian quirk.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  5 ++-
>
> Squash mistake?

Indeed, thanks Konrad.
