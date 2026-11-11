Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400690;
	b=AZLiPaTsy4sewC1JdSJolZslmCntbh1+6ZLqO2vCE7HqpGexTaQyynX8XfrNwYhJ2CT/
	 npPdgvcOuevcP/FbZ/3rqK6zuTLiUxrwPnSOj+bL6OafqW9Ke/m2MhniRt0Clm+SczXHj
	 kXVcdViWdM0d8FBC+QhseOPETurKm0QNw+K4MciS8lJgbV5GcMRrWcXlfbhglnz0NNWmv
	 uLGkMlUdlJ2AWP4MI3l7dTqBG2gymgXEZjObCQFAhG7gyzWWRp26Az+LoL9ZuHptJWbfr
	 9Msd40QfGKKoC6CbhjVvJk3szOHvIuvAwvt9Hta6cdJPc3fu+6bOGwiemB+RsRYBs/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CW6quIFeGW0S9qeyAqZMpDVvXADn4a/wl2z3Q8pRkF8=;
	b=rC3Hl1EKEQWHRcHse2VJULNv2h0tLd4a8SYESeeQyLaZdbJthXuZ9mmn6Kmn+lgHo+mn
	 dDPThg7AofkpOOaoFGiAt5UybE407kLtGwuMye7HCKDpFq4tBDSonxPtyDio4xGsjbAuc
	 3XMZX3/sIuK6YNoews3jzhddTf66feR5aAXImwj0rDI5LvujSCVWVnJmv+SskF8WQcRW/
	 zP6oSOieaSJEL1MTtcREz4ObEOzL+Ho80fEvBG/Lc8ASDWr19RAx45lJcMXwosDL9sZ4X
	 jAD2TvWmGFYK/UsDqU2vJ4OYOKinz82IuZ1dSMZkm3BSQflZMbmgId687Jt6EPejVFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VeD63yOx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pnkekkka;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E9606A89D
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568E9606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VeD63yOx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pnkekkka
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYwSm300500
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CW6quIFeGW0S9qeyAqZMpDVvXADn4a/wl2z3Q8pRkF8=; b=VeD63yOxGAGneCJb
	+1OVmdcm3sbOLO3FiSWOWVf3Rcx6n7sQdRgKzdGkgdM1vHUKyndr+2v63M0LDOlP
	3CYRtbEfSPoDXzlVlLqWHz2Fzl2c+il9F6NgSImqxIiIWs2z6TG/aCdCiyhkjvr1
	u2vNE6JoTUY1736ASKO8YZYME//8wvbkOXoG3rKijsanks2Y4tZHJP2rr1vqTvAw
	JfAarso25iY5tBqQo2YXziHA8f5i/EoV+jKuxQ/jU6uTYlkOVrwXpPCDVowFKXYx
	M+tvWdHAxgdxk+KwFvGjzoxQIU07c9Da4sTJBQLqVPrgi3wPsqREf0kKT70hp3ct
	DpwBMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjrgcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1814372a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 04:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400688; cv=none;
        d=google.com; s=arc-20260327;
        b=U4X3QLDO39cTsaI4G1FQhViUR6YcJ1oxRw68npJ0V9vG/afX6EggZlH/ufDLg27LhB
         U86hjbGZZDhIEKAQsLfKL+MVtmNnUOfAo6zAswMnWByuzSr/SSYMvXZ8iM3imoMnlHt6
         EtPutptaafyQ60nFgUOtuOAe9aMdIwln7am37GCM3yT6Ry/xT3+Z2vViXLTWsCiBu+2z
         wrad/ArceREjBYGlGU5x9TQq+PiWau9Fm9w17+9FSgeLP+vruGR6E3bMVT2HSH6lAIkK
         jtscP1R6m7+ufFX9aVzrJVYcfXYkZYW9PA4/KtEd0sqV8NW18VwVR5EBnRO2oEjyThff
         Gnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CW6quIFeGW0S9qeyAqZMpDVvXADn4a/wl2z3Q8pRkF8=;
        fh=etG+aPtYI1tyyMmawyEgMtaf8prizXvNFPav6tb5ZWU=;
        b=BY9KV4gXXGfWltUPxaBz0AgP4yE/yUZ1a1wyC7/CWRm04lwSqaH5EX6oTjUrfoGNB2
         v0iTpIADowkVq5zhWQbW9diTrHFzHrfejEtSWicWk6JPKFbpbxkIRoS94iPf+hzBbLNR
         2C2lD/oMrqhIfLTjgVspgNYN80+bBvLsiD7opUtIVEY5dtFyiu+OrJZVVUi4wGUrl0U6
         e1jzmf904XYhbiXhDwMmLQo9tZd7UEZsn1nncNA28vUUb5cqRTMTOXJMjzsLFckh1tP+
         jwWemqDEciHdvHUlkrNRcjNpkOH7L8Qdzkd0j6lZ6scCXLaZhH9yYU4WjW+1oXm5Qx/F
         H+jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400688; x=1795005488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CW6quIFeGW0S9qeyAqZMpDVvXADn4a/wl2z3Q8pRkF8=;
        b=PnkekkkaQB3h6GPnABYsjjj0+9tL8k9trwl8JVWiuTSGIkJkbjiUBINRZ+0PbP8B4E
         2gTJ8CPLt/I3swhHDvSSPHzYIFjOjyqCNjV+9fY54YmoCBKnnTx4rXuW+bxjUYRW1OiT
         +Z9/vfD879O0gCwyBC16hpa1QRlz208ywElwOWOoSx3B5CDIjrSboXkHDgbTDz8YD7zL
         ERjkSCmTSyh2i9H5FbJ8GRGMnAJ013TCbvNgpPR4AlwsFtsUQzu3bsM0ootyYyk1qmkK
         jsvnIl43lWr9Nq/A64zVQGI8QGrbJQ1faqo28+zpuAt5cqXKzhCl6FJpb11Tt2+pSnc3
         AyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400688; x=1795005488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CW6quIFeGW0S9qeyAqZMpDVvXADn4a/wl2z3Q8pRkF8=;
        b=rtCsecQHxIfPn55ZJQIEeu4RRhj+j77utZcDeDHtzJEIQTaoYjKeJQ8zVjOld1+TEj
         iW1QlqQoPZM4Nd6oykze65iyPuQFKdsrzrOpVe1qAhtkKf01SIeotadnLsb0BOrYzACG
         ww1kEm2w4pUVovAFmaM4l/Ta7CAQOdu/7RRVvBYrLj0Vzf7LyURSZ5eJu1qDIjzoFRxU
         SoqlmdTw77H4Mt9iLzOXR2QS2gU6Sek1QscZIeEK0GaIxMsJmE2SvEkkR5XP4IBC7jWI
         8WQBhqoUDnbyrPdiOQOXxg2J9wER6b1jQuwBOTE+RD2XACLLAKynBbu0vMogQbHPoqvY
         wXdQ==
X-Forwarded-Encrypted: i=1; AL+hErFfW1XGflCBtua4dYooJSR8rkfj8BGKT34nWnQLlvgC0urCz7s7VqtvyITiaKbqMeAEoVDutaghWSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BTxRbbO4NktPEbaXmYEbIHFQYOgI5BeIWE22Tp/5rj0CfGqMD
	Y/dRXbKkfC0UMmEp+0bIlPA7S7XjM2/XweiZ06tJZ3pGS0SjHVtEAUH1rPbIP9vKGoS72P/Xpov
	wZbiuS3qcQz+ZIesV5X5+o0eJQSgz209k5k89qdEdoDnrr7pW1Eb5TzlRXsMAPUuFdAgUozck4E
	A23ur/la86L2tmQ6p37OPohoO0KIqC3gSFE0sPyQ==
X-Gm-Gg: AYBFou1fM1nTgbVUEYA5ZysKogT/w+KQ7l+s+RM7ZcCw0w1F2kLmocuHufvLZLkwTEs
	sZ5mZUjexgu2UedBst7iJHZJiNDpl4kgE/AiV6gEA5Wd2BDIus5zYnvgTOM82O0GBz9olHBh8eR
	l+gUBbK/ZbpeLHg5Ug/3xm8kxomB7TRRgdzsCopCZ5er+Ehqt1MCQ8f6dDmQ==
X-Received: by 2002:a05:6a20:430b:b0:3e2:e6c:7d4 with SMTP id adf61e73a8af0-3f2febd5b5cmr2404184637.23.1794400688087;
        Wed, 11 Nov 2026 04:38:08 -0800 (PST)
X-Received: by 2002:a05:6a20:430b:b0:3e2:e6c:7d4 with SMTP id
 adf61e73a8af0-3f2febd5b5cmr2404168637.23.1794400687573; Wed, 11 Nov 2026
 04:38:07 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103101622.213425-1-benchuanggli@gmail.com>
In-Reply-To: <20261103101622.213425-1-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:37:56 +0100
X-Gm-Features: AclHuK8k7mGhF9iBNdobqT-RXOYiMQvxs9HDSg1iTHFVCJcU0iDK-RWgmtY7uSo
Message-ID: <CAPx+jO8rBfADRej2meFUwjP7ZjTDYf-EWSW25y02O+6kYVxg2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add Genesys Logic GL9768 support
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, ulfh@kernel.org, SeanHY.Chen@genesyslogic.com.tw,
        boris.chen@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXwvl6xgIpXEaP
 vdp5n1ffkJvtZYUfLVPm+x10ZkpDYkKcQ3eAJrY9uXyyfxR8XoZDPOWQ2PTAt2GVqT6aHL7mpJW
 6r41BCsontObO1zaX0hqIPbZb73IafpC5DyLvUw2Ok+GGbGeOZSBnSUJJX0nD76tdBaCNmeGIOx
 hBXSgMJ7oYz9jf3yHcj/Vqw9/61K473fq6pu/yOwsg6RErbBFnKbuZFcMYxJjdci2Cjd/aE3MaF
 xKG5EtJj5zGZRol6+HJS1/fdvQhM8jqVnLyKGJ32tEdrSXenKnm6rg8uJZ6QuVR/EZxVjCD62xG
 1A580KFbMVE11NG+XLla+FqA4MNuABpTlBey1z84DM7KSx/3zsgIZYKl/TFQGsuUZBaHVzDeTN9
 iqB8hNCKdWVgyxVWaeKtdFBUQU/f6gJKCD8uhfNlY24uxC8+M0zQ6wAciM/kSkxkZYUNxVAmPs2
 0Dzv0uHQADj134uD4IQ==
X-Proofpoint-ORIG-GUID: DPY_5lEpAhhQJt1Xdmrbk-1xCkXGlyDz
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af461b1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=MTqqJCi6AAAA:8
 a=iJYJqG9Hh-plSMGQH8YA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=Ezp7Wq9ZhlihhAROVjRg:22
X-Proofpoint-GUID: DPY_5lEpAhhQJt1Xdmrbk-1xCkXGlyDz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX6gXni8DDyEQh
 keNenTk25YKeYZgbNmJ5N/t0w7lvS6skCB8kScRWEzKcjDUXpcGQSjRglR9K7LmoGVNJ29FtxHU
 uyAvEtKc7BLROWfXiSuFGmIlb0UI0g8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050

On Tue, Nov 3, 2026 at 11:16=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The GL9768 is the successor to the GL9767 and uses a compatible
> register layout. Reuse the GL9767 driver for the GL9768 by adding
> the GL9768 PCI device ID to the device ID table.
>
> Clear bits 2 and 3 in the SD Express control register at offset
> 0x940 when the driver initializes the device. This clears both
> bits to zero, matching the GL9767 default configuration.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 7 +++++++
>  drivers/mmc/host/sdhci-pci.h      | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index a9000f3bd419..db0417238131 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1959,6 +1959,7 @@ static const struct pci_device_id pci_ids[] =3D {
>         SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>         SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
>         SDHCI_PCI_DEVICE(GLI, 9767, gl9767),
> +       SDHCI_PCI_DEVICE(GLI, 9768, gl9767),
>         SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>         /* Generic SD host controller */
>         {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index b55618566d65..66452ed8cd8a 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -245,6 +245,8 @@
>  #define PCIE_GLI_9767_SD_EXPRESS_CTL                   0x940
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE                  BIT(0)
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE   BIT(1)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1                  BIT(2)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2                  BIT(3)
>
>  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL                                0=
x944
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2            BIT(5)
> @@ -1354,6 +1356,11 @@ static void gl9767_hw_setting(struct sdhci_pci_slo=
t *slot)
>                  PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_SCR, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value)=
;
> +       value &=3D ~(PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1 |
> +                  PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2);
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value)=
;
> +
>         gl9767_vhs_read(pdev);
>  }
>
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index f38f0bd4165c..bcae29f8d8da 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -81,6 +81,7 @@
>  #define PCI_DEVICE_ID_GLI_9750         0x9750
>  #define PCI_DEVICE_ID_GLI_9763E                0xe763
>  #define PCI_DEVICE_ID_GLI_9767         0x9767
> +#define PCI_DEVICE_ID_GLI_9768         0x9768
>
>  /*
>   * PCI device class and mask
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.56.0
>
