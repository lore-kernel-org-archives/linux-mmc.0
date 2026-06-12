Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EC3A0EB3
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255558; cv=none; b=d0XUMJ60nOGaFExIj5780enoBF+aJmwk9powl6fqK/vtTZApeTEesdn8PSsKlhWDpd8uMR3//X3vGj73vsvAlwoE5ihq11YAhoX+nA4m44B9U1WNLeWJcrfK1Yy4rmmXWP49cQin8GBGuVWHtHgVSXBK1T3D3GPEFF1gqwrkkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255558; c=relaxed/simple;
	bh=J1AFntJO8yn66Ges7ZIJc4qYkwhNSJYwQcAxHEZv4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQd6JbP0RXggRjryfKHkgr5rLZtX/zrIIzGEWqafVF9donorZUuGcP4azWUGZiwTMCFeW8EPCJcbIBSf9gTooxoLC0cBqkXhmQA6Ms1lZuRMhpCszNUtUiH7jN6MDxaOWyaAaQryZweEumnGkEe6lUR0snMQeIQadoqCLQZZ94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFNQOBw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bzs5AY5h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFNQOBw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bzs5AY5h"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Uqv2496522
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 09:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQHHtK59LcboT6pjvqkOS+sy
	sywNj2Fo6GwGmNW3Glg=; b=jFNQOBw0YkLzDcDJnKXoiojTKiEGuD6hPTR+kfeE
	2ss4OSCbPpXkPqcf78P9LgzYKAqxaVmcPlAGqnC4mH8u2xP+ivX8Z1JKJgYJEiuu
	tFZy4jkbxlMuHM8OS5TEILW7PcEy6XJ+vVd8MXZaQ873NJ+HB+Ao1D4o1bO/TyIV
	VgTKANxBx0aZTaKWlh9+1fxOJPmQWkduGpSZMoSm+IRWKyDvfkHt0jY1Y3IgaWBK
	15jG+1HAywMpEhomeAzvahK6xEPIWgg+hnoa6czhQ64d/fuNWtlXMgaVvJnAfehT
	+9DqgRSqF6u6zfiAclJrVi8a4I0g7mc3Ush60MbZ8QcBMw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7jwkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5176cc5bf2aso9093661cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781255551; x=1781860351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=Bzs5AY5hQbtm2yrX8Y7CsMdvX1vXyovoF338iwmc6pduDSh0fBPKgGcKAOWdyPdFPD
         Qx2hsh1pZm7rooj/VzOsLNR2qzQi0q2AUuViLiMFfMkIzg2kGv+8k3PRyJN8g4+vXWqy
         MwS2RpM8YRMLpFraIPrhA0QmWKnQXiuaX19Kd12sWxNivvXE0ummS4ZmQmpbOc5Ftadq
         z7LTD34t/tfEoM5EaEPFKoHjNRn6EXGblmUNm2RgIdpmrnHwL19fIA99wHShMtUL4ZYS
         lFjct99L088btDWL3ObIjPVGyw2ZpuIuDr4kF7nODPnKZBVJ01TtyB4x7qa7I4ESWqsZ
         sjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255551; x=1781860351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=P3aaictoBgTe4s4bdoipMTm4wIGmvbFWj5BoQxOZZz5HSn8DV9LsxJk5O2Kvl2pMQI
         Z67wE2KYy7eDgpCfYq65oRj6nfWwcn2Wd/KEZSMvjRD/d5XSg/eivX63j8LJx5WnlivT
         wFeauH9Nik+/HdkC2VV0L7i4pjP/pl/zRbEfoxeTdEWES60nLAI2qNcVUgq+XB2fpehS
         AOyZhh0rGwJnSk8aIGmCn9sVe3eV7MjjmfskkYpwATtyHaA8FZf7MsSbCQq7uJfHb7IJ
         omTWyvAZHutaiB6tgDzS5w02vYQP6PbgPBVT2J2ikv1I91TjzQX/qI100kJRlQErGMru
         Z7Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8zw9XIR3/L6yY4afiRTyt5DJW/NdreEC+CxmMfRKUGYRvS+dtmeaAjgzZ7F60XKd7wvyMIc7KRAtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHn+aK6hbzg9R42zUUhSLxxZWDPDdhnMosY/I5iT4ON+ZNs4H
	BhsbxW/sXzBnbpq5JzY7pz067fpe0hzJLJVSZR4up8/zUFygQ4R5H7P7GMddgh5pVzaIFcYIr36
	bJXvjUq4RdhV0AAePsGdYQwZQkVp1/YOXxe95MWovfWJe7o6wZyepDdcTZTqnssI=
X-Gm-Gg: Acq92OGzpYlcTmPegrOyUE76nADA7e4G7XrvpbXCk3AZMxdDnq/i8ITBstMFm0y88ID
	WfMy+X35eCyvvOAvmIICbTH5pmLREsnNnanZLYrtwifSIcc+GWBL74li4qHjDLgZCy20x+1p4nG
	ZyvVsWKbBbvaPZ5xA+LIAS/dnlfiEhlWgxPBaq+V8+xCJ+9YGJv1Ac4cH3Qc6LJRiXIxHcZct+S
	vYT7whlsJhTugPAYDpLdBNpBDP0z7Wim/pZ6an0pMvNZFkZrnjVpHdPnCi5LmZ2JaO6TRwSx34h
	8db80Q8uYG+uWqJFWSzNQX9bcCFQVdacyKEc1ILSLgjnvg6VTbEQhoFiSl0gTjWDM+HNE8+TVHj
	Gu64TBcb0211cZ9Bm4ecqPYtezv2VDNSw5r4HTdPk9IfiimeUGQ3lxICKsFye5tJ2nEkIW4cFE6
	PXGOIzhgE1tXn12i0dkj1JJrUUEvVvyvWi46Q=
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24249111cf.52.1781255551594;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24248931cf.52.1781255551221;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7357sm381663e87.42.2026.06.12.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:12:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:12:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
Subject: Re: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Message-ID: <uybyiffu2czpzhycp6x7w2pptzmhajxlx3ogglshamppo66kqn@izztlisgr2xc>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
X-Proofpoint-GUID: QWPwgpi9LZOtcdJc1a_Jzn8KsAC2asRz
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2bcd80 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=m9cM9ScjmTDVYK95jDAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfXwRTDkyKYKb70
 JUaXSVy4V49ImQQkWa/NfSAaGCJOTEZK5WoDoPy6pwC6f63V47M70oiCkie8qVxetby8j6Nfnsb
 cWX0PB4PlHgE6SiicjGs45cP3ImqH5ErpEv0fACZj3flvtp2dFuv4Mm5ux8LZZ7pqFqwfeAyzHh
 iEQWHE3mGMU2ljgzSvnZE/4Zb1D9lVg7vx28dEqG7u71aFIk579O9zIq1p3rlejmLxrWeYjUC1y
 Kb7RJ6gdC2jIuwRddASqsNTsXA+/KOD8OhYVvySH7ft25D6SWy69/jP3QH5Scye8GoluROOxP7v
 0nAXMXuJSwSuGWB/I0CK0zkeYJqSTrxyXRa4hdr2SjNn0d83HPPeihYy8IPmdf/ZWl9qVvcRZ+j
 kJOQA/cqkIemTpxDwz7S1/hydO9uzM28W7H2QU0y8urAfZWvXtjRDzfZRh9Vnslo9ClwEuNpC3g
 3oXCmTcvolPI4qNiRYQ==
X-Proofpoint-ORIG-GUID: QWPwgpi9LZOtcdJc1a_Jzn8KsAC2asRz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX1i6HP89CNnIa
 C72LKW8Dn6WWy2LyFY/mWvTIiWwTO4sgCEBwwWC3nlYdHT3XwAkl20zV3WiTZ0WI+ioVYFRIFCs
 kU0m0Gl03LkGnFOs6CvtB3YqaGcfBZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120082

On Tue, Jun 09, 2026 at 09:52:32AM +0200, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.

Okay, this answers my question to the previous patch. We need to support
BE addresses.

> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
