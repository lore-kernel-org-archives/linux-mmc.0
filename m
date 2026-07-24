Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60237335091
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907348; cv=pass; b=Ybhv6v5xjV7OE+ygPoGwidGGKsselVaViSIsT7K+6v71FTEpgll+pJ5qJnB7jK+Up44naWD0QNDJr7kHkM+BhnzA5FMnxXuNtn0ktyYh0OQsOfQP3UI3kHggZTNQUh9ic2fu8kqmXzQO8ngcquTls6Y0hRph8xWscxsoTg8M+lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907348; c=relaxed/simple;
	bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGqqxLSSLi73v9jg7Wnag0rDX0t6d45vGpgjOfX37/oMZHUebOZAe66kFDKVuIFlnrTCg+p1hfpgaV8LsLui+sF2tkJ0tzXO2Aqf0a2wyPHitwXzwZvjEQ5TI+CPfX472OBTR3dk+YdbnmTZg1Os8yWO1G0fiQgveJYKa3bC7Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0UZBLpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mh26x3LK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0UZBLpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mh26x3LK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbEVw3089466
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=; b=U0UZBLpmLfPDvk4s
	5VVXy1GRsf9VjasKo9AZa15zarTyGa1QjJqnsNNIcbBeIhq1YHNQb+NLdvyNnDBN
	7R2Qp6iSbQ65AuK6J6JrFFQ1KCQdPr2+h/xLiVb0Y/MG478NDq04DnEdkLa8RE0C
	q+9xAuEvlxgPwplct6yAF7BlP/BSC51W0qX4xC1wqPCC2kNiVj4k938GrWe9if+u
	71b3BDT2ouTx0lPbmDcd2jAvWSKlChEuLO3YlNrfAItJPh+7d33op3mu57wYkF5k
	m5xvoz86F6mTz6U79nCSLiaxF3eZb68e4/ZCxZPnHU/bjNLEQ39PFmoJr1mgXWyD
	Gn0Tzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cggm7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d30035dso6847221cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2026 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907343; cv=none;
        d=google.com; s=arc-20260327;
        b=FS/WY8pRyq1V2UtaWTZ2eoxXVCPLsnEbe33WrEYOlcnIvHWqypmi1J+vMnoLY1SNYn
         9tiZ1M/uBYU1+xMpFFYnjgKSAKEAZ0ZgSZjXV4Vlg2fjAtYBVeFSaq/lXM4C5QMUxO9p
         xlL6sM8Wntvs1Iqq/brxncTiF1h9XbcJzrJ2gX2KSvQLDoAe53/UZ6n7Zuk87oWiK90m
         uAhn4oMakSFBfdnOdfVVj5z59lA/3vhCmJ9PfhpSppMh+0iU3zT/YdcCJX9CSRmWky9U
         RPvfjZ1YtXaI0zePdCGC0EV4phiUFzyaTy8RVdGuyGvnUj64dB4fQGTk/T3ynBR4sLmi
         NJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        fh=onDwiUIIMT/4skzOzAOX6LZVvMHBUl6PNfG4jcx7mc4=;
        b=rEaCwmd3EIszQg4rnBAxv58x2XBbgJLMYjpMI5MKBqk+Ypc2j6gZWmSgCh0ObZeGwq
         n4QfNRDk9kjyI03VxsRCVK0zYTS75McPdC9aQbrJZjWV/OudERVsg75gv/PiVIE7oQ1m
         YFR2YRYGhCYfbkP85D0s++JjX6CXlRC8Wu1flIeQORwoRBWNqPjFQ7uWINP/W2+YNkRi
         mo2L8XUsBzxfjNbdTo4/NAIHb3edPVPzEEbNIQGjHWAVqX9r20FNid/CFz0NG7m6kyLb
         PMgOMtc1wUl01/NlYCXdstuq4lSfS4HOrlmL6SMGVIn+BlOjCYJgCnF1Vgjfyy+R7x+j
         BdHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784907343; x=1785512143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=Mh26x3LKlUfjMyUTMsdPzBsSIeHZkdI+mvNO7yint5/pGl5OhGKGzyUhVm4cwzUhP8
         ByS+yjWITK1i3sYzP0P77bSL6q6Vr0M5GLkpA6K0FB9VXq6660zEBGCsjMZi0ZgKaEyF
         gWvk4HYyBCw9GSwJVBa1EQB6KJxkUcxFZamUuH2IRWXAtfdcL3SuFVwWMh4tx4OXMZH3
         Md7ZkQvgwbnuaG1kyvFOiB3SRvHuQi7whrPblAn6CuEp9/NRGs4eky9fg0R783/J79sN
         1mnUAWmrAxBie3kHUD9RnHxWTycPzad+sEga7XvGUy95zriVZo/XQBC03Ya41b3iKMIZ
         Hqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907343; x=1785512143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=lw0ZlXKPxtDli0TukFq2h2eVBYThEAKTdtdRQgtPUAMxGB2OplJnKyJiDVJHoFEYcB
         KJT/gD3lF5Ux3IIxWDI5sWlfg7vk8mdfjGhB/gVab5s7gI6lXvPD9B25ZOl1KWRYCYc+
         vMo7PFATGUuluGmzNCA6MB1B7k3MK0LpZ+JYv4S8yHbDXkUNU5TRVX5URnpDWEe2fCVN
         uil7HTUIPdIK93BiUg0B+ZakbdppqWfo92YiOvdRtrPhLdz2US6pKmOC7FY4MN2Sw55l
         pHe/nh+Utep8KJSHcaaBFsLEQNekAqQuPn4kxY8UQpK2VR/HsLI0OCgjraVoLFuYwZI0
         uHmg==
X-Forwarded-Encrypted: i=1; AHgh+RrFNq8PvTaCvYSGWf47rpUO+c+t9RpD5qf5Bsnzj9Px3jyrKKWtIG1w487xnOb8A7kysnnq1OaX/R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEu/rIDMM6DuOFequeCGIN0AbiaLEdlx5Ebh/650Nt9IemtFQd
	iycvi8iU3dUzyqCJyfxSteRbeRNmB4h3CxXrb3Huir/2AmCKwDaDIwyRMUtUNzBymsFJR6SjcbT
	BuKFoJdsBFojI2oi+QRGuAR1Y3St0islIjRYRFTXoVDi3+2v3BOfnMaW/YJjc31tZH9BJokh0qp
	AnlRqZKVvsN8Qyxc5MAPZ821M0N1x4NVwt0jf8/g==
X-Gm-Gg: AR+sD1236O9bAQMXRhTs5LN1R5/SVXGkho+qPYLdRrJK+Dk/tLjh9YwFspUJVLENjsr
	vHsZ5bSyL1MXMN/osPTBnufKAkF1WOGkmW1nOsif9qYuKol2U1zxyy80OlhRNycIVdFzXnrgXYR
	a2QRgYKo5yEsyTap72zZgw3gGjS4BHCUtQGd1wgdsCDHgUqBJh0GDNwb4F9w==
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id d75a77b69052e-5283de54e1fmr76891111cf.39.1784907343486;
        Fri, 24 Jul 2026 08:35:43 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-5283de54e1fmr76890551cf.39.1784907342860; Fri, 24 Jul 2026
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
In-Reply-To: <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:35:31 +0200
X-Gm-Features: AUfX_mwd1WNIZvdvXqoWeMIN9Hp4kEAy8VC-hn59NszviBxEKOIP4_juVgFnXVE
Message-ID: <CAPx+jO8-9YSJtXNfnTrUX_JiCyddXHn=wHek9=c99+fNp22Zog@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Support for block device NVMEM providers
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX0ICcnFrHLvLf
 U+roPI4ZxK/Wr35EU1Xud6aNRMRaN4l+RtWvVWYcR77Yb9sCcDglZKzJJrglHug7LTEUXcIRHUK
 QPf5KW9WSyNlVzxlDJe4VPmp4MFtVDmgSLf0NLf4smocIAMz4gBsksokNka2n1qA+QxFvReMUbM
 F8QYdRqdVpSDWqip4Wn8xmnPqDNaiXY7mtnPu7q0SkBTvfWUmxzUoJ1XNpOAUIZeuI0YdKM5Xfa
 y7DmfiFyMtNj9Hq913kDW/LrlnFRRMnUyRXpaG2Z3W4gGTsdq2DMFwysdI7wENDqoMSq/T5makn
 lWSasu/HVJlBkBvqs4Qi57sXrWWwszOqLhkyBmmc9/l3fVbj7h3MaaLrG1FXDJJiT+TKsu3RSU8
 4ag5XHNgDaXXtKLE8TWVnDrFfXIhn6IdszSerPNUVFWPECpR9ye/8n55qPAj3T0FZshcfGE4+sx
 P4rfstnslLT6DDwgpJg==
X-Proofpoint-GUID: WKNS4DrUKLn6Ubk_zMyd4XgSWTok1F0R
X-Proofpoint-ORIG-GUID: WKNS4DrUKLn6Ubk_zMyd4XgSWTok1F0R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX+a+VeAbbL8i6
 szpSjoDmBwZxcIK3ro7M2rTon2hKC8OnLNsmtnIQ3+7ePXQ9wTMcjk7O6BkQD6pFeQK7+RnKoUd
 s7Pakknwj3C2daMLM88fAMgluwQaTSY=
X-Authority-Analysis: v=2.4 cv=P9sKQCAu c=1 sm=1 tr=0 ts=6a638650 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8
 a=XoVDlNqzt-XzKL8N3f0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240139

On Wed, Jul 22, 2026 at 3:56=E2=80=AFPM Srinivas Kandagatla <srini@kernel.o=
rg> wrote:
>
>
>
> On 7/3/26 2:45 PM, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > Until now, accessing this information required a custom bootloader
> > to read the data and inject it into the Device Tree before handing
> > control over to the kernel. This approach is fragile and leads to
> > device-specific workarounds.
> >
> > Rather than adding a new NVMEM provider specifically to the eMMC
> > subsystem, the new support operates at the block layer, allowing any
> > block device to behave like other non-volatile memories such as EEPROM
> > or OTP.
> >
> > This series builds on earlier work by Daniel Golle that enables block
> > devices to act as NVMEM providers:
> > https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.17=
09667858.git.daniel@makrotopia.org/
> >
> > It also introduces an NVMEM layout description for the Arduino UNO-Q,
> > allowing device-specific data stored in the eMMC Boot1 partition to
> > be accessed in a standard way.
> >
> > WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
> > Bluetooth requires similar support, which is also addressed.
> >
> > Note that this is currently limited to MMC-backed block devices, as
> > only the MMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> What is the merge strategy here, Am happy to take it via nvmem tree if
> all the non nvmem patches are acked or reviewed-by.

I am planning to pick up patch1 (dt), but waiting until all the
complete series is ready to go.

[...]

Kind regards
Uffe
