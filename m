Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E33B0585
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056338; cv=pass; b=cRDxxjfnQ3I6VPoUGtiw6xYuwOKdBnV1kzFDwGE9+DXZeu9z/JtDiFF34BmeHwZK2lOEtUj0Q7sjIATTDIHGaQ8izel8aFjUknTbgNcdbkxKAV09tbZnU3iPV4J+UOd09zR+Qe7u3bijA9/UBL2HtsfOJBuvm0Zun/vEyN7Eisg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056338; c=relaxed/simple;
	bh=54RhIuHDDM2GaGWdALTnNLwdvOShYkecjrdFePcvKsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt1ki+IHsARsiYM7pHdAA3qqMalx9unts5UkIQLFHWQxLIXxWvMIGIdaXfsd1P+OA9Q2JIeFr02kXchttfPFFIhhNfCjwdI4yHo3EHTERZC3TMb/avUA5xHDdqXcWmlNitR5rokov3OnEwwQfuoTetgw9qJujcem8VDVYaVj3AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FEm82QXf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5+sncIB; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEm82QXf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5+sncIB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF55Lm650753
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	18M6Eo0NvxWAhenUsNXlgY3oGJusJpfPkNsLbndCZAc=; b=FEm82QXfrEs56Zqf
	GVpHaSODOL9WG7Sc3sc/WukGuOhKHK5SCTtQ6zX0dsaAcJ+Tpkg717pGFIyIcD3X
	JsknAGVCp1DFvCAXmMdy6oWEk68FM3HkjxzZoQ8ilCGjS6qTylrvD+AjLVCmqGrc
	mUXet3TJIWTuitbEUzD1Q92xSZYwZlNhhNX+OuaIo3XxHO/HauDWgF9L1iNycL9/
	oVtQ+L+/sS9N9a0LdWJwR9v2PUhjC5f/2XNzavNipcCv+/e9iVUqXjdqqrG0Kzfo
	XbwlLLL1MzyRbIIIz5u/RVJbHlivz+8KRlZQVYbc8Wpj/nuvuacyghqX3mcYpnUs
	j/Gn8g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxv78b4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a880e91f0so801786b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056335; cv=none;
        d=google.com; s=arc-20260327;
        b=Mhm0eMGlMCmYGlCZTT0pg/ad54noPrcCXNNp/Ft3Hmn2x6IIOSFawc/QIjcL/eGT1u
         QvjVNhvaOhO4kSNagiCGWGPMKGikg9R4BUhGvg2OnTzBK5axVgX4AEBmg25inBEDFXw9
         CtIPF72MnHpZ1FBaWBMEEvx3YNnz/ea6sApMeV7EgRM51R+BBhnlRb0eLfXdsV9mchAd
         7laO369UrntxDt6wdPj5UyUBnl0PVksSGLIqJfuzjPllzP4Hnb9UNMpdsQRLDGslLHpQ
         UV5Lko8aG3lENWhc8U7/jXya6R1GgH+MROuB1B0nO3bmQlGPFQ3IiZm/QT83Jo1PHzfa
         y3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=18M6Eo0NvxWAhenUsNXlgY3oGJusJpfPkNsLbndCZAc=;
        fh=jcdcXbBRcfz+1ITW7SuLZ5fyuQu8LCOyzUfcfBssygQ=;
        b=CfCtebTzKW6/lFl05/r0b5TMt5G3W/WC2UXqSLWInMDizZCPrP2jl0x8xxJkdXkw6K
         y2h+nGsAu4n636is1AvRNntL1x8GFbUtPM7CbGq+AyGn9W5XkmjFxpdtzC7IF1orI3jG
         MvJKkJtaPk3KzUpQBX8hpLQaI9yIGQpqH2MHlF7jUzRegg6+sQt180DQhXAQpnTF325D
         XSXLsdPKNlEWzvvdLPmH9dHMlk5wO1J+SEUf6b3dx7hF2oM9J4/Agp0oEXkGtZIpVV9Y
         0nXVwimmVhT9RDGt+ZGOS/MYNM1Zf02DD/TkmxuITKAcaO8eLELqsm3PmFszbNv1WsT5
         ulbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056335; x=1789661135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18M6Eo0NvxWAhenUsNXlgY3oGJusJpfPkNsLbndCZAc=;
        b=R5+sncIB1H2pwhLmCfhwLUT3aP8x4Dt6qGII+noKqk3ktpcbUuXy6S4XofWnfRUPTr
         nFnBfWfZaH/WZ0J3DS3h/eVmZWDhf/p8lIc/r/WmGrYe+UDf36d3H/vCmKESuKOnFd0z
         Yp2hRWzCdf5GwZVQWuOEEIk5PyTrl7ov73BP2tzy8cch9oG1lUxGrcobhJOhIKYxi83Y
         p5+Ifk572q+HPxLQj4f3yqIHO3Rye9QtWzayWx1jHu8LGkjKVe2uncD1ZcASbWiPyJNW
         bZ2wDYtC2fMUQl+q1EE+QX66TYCpeJwqUjXbMXTkGrJg4J00XhmBpt/XJ8EkXZSZnbdB
         k+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056335; x=1789661135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18M6Eo0NvxWAhenUsNXlgY3oGJusJpfPkNsLbndCZAc=;
        b=cMw4B3+mu0Xc3RGq0C55tcF+utgUQui/qD6mJC8Au8dv0pBw6zxpd8d2n6F1VXJ67U
         i2QKaKsbOXLxfT7AT6HGf37Et4lpkJG/LR2oaVSM+mqw8GWS2Gk+e0BoP940gmrdtkFY
         ++LDFjavHZaNeL8qoTXsxuJ2pSCKQBnCAdArsS/OdtGsAiiMekOgOvZtD9mGZ8Lk1OO5
         O6aCTnHF/XPqqzp72itZqYyaC9TDEAEWFJSdygmq+qFz+WvniXlPDQ9RjGXxV5lOQ1Kx
         QaOFbbEJgSYJ9lTKAu5hQWeJuLi3cwRyWQ0o387sSRehbERzPOeLG1QlVK2NotMP0nOZ
         MCUw==
X-Forwarded-Encrypted: i=1; AKwUvBzASfwpeNuVZdAAOM3c8fNuTJ8bPqwEpE4ChQ64ntpNxeFCQIqEsy6jZieiXgGn19TQ4v78xuxv9Oo=@vger.kernel.org
X-Gm-Message-State: AFuF++mBMb24a+vJPvG7tmjstkIBPY3+l2/jdePWiU5DmrFRFNNGZCVE
	wDusn+YmQD5F3XtjP7Q838eD0I9/zuzgU6H5YPeV01LTkc3Zc+T9uXnEqBWbrZvEPbERNDj164X
	Fk6HtCvFOTzHX+ijvh2kGobdAc+/TiuTmm4qQKHO2eWAGSnLMb8Nhb1UOUavkQH093xDIRt3QUi
	RqSPCNpMOn0s+r5j5SWotKl+Td7BIuGGUaLBPwEw==
X-Gm-Gg: AYBFou1LFbAj6lY78nzrsHPmZiYmu/PXMVU7+efp6kIL/h5kK2AZwy7uk++BXWgKsF0
	oxXbvYkFa+W9siGYFS5/pO70R4P5TugsDUN+yATPGTU43LIoeX5kQmLO2Du8E2OQQxzSihq6uSx
	dVcijiNi/OZV2/YEPxFmmVpn8XVuK5IrfmorUXjrVQWJeG0tdIyNOs1X4l5g==
X-Received: by 2002:a05:6300:85:b0:398:8870:b58f with SMTP id adf61e73a8af0-3dacbeed903mr14709188637.14.1789056334495;
        Thu, 10 Sep 2026 09:05:34 -0700 (PDT)
X-Received: by 2002:a05:6300:85:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3dacbeed903mr14709128637.14.1789056334124; Thu, 10 Sep 2026
 09:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822-sdio_uart-v1-1-2cf3b1352c35@gmail.com>
In-Reply-To: <20260822-sdio_uart-v1-1-2cf3b1352c35@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:20 +0200
X-Gm-Features: AcwNN1WTNJQE_bI3tDsx6RveXi9DnvcQ_k6yd2A9MyqwIo3F1VzkjjIGkFm6OsU
Message-ID: <CAPx+jO-rNTcPM=sgY6w4epUhvThPDzKRDmQgWM619+J=yZ+TUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio_uart: fix xmit_fifo leak when the port table is full
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Cox <alan@linux.intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfXzGHr5f/PJkZS
 dsdofHSTONUuqikXkF/lWDVn/4pzujXj94peHMK0df9ONsRulhvweThfes1HJx10O8vcRB07Rzd
 s9gTvczR/ZbH3eairuvrugGZ4DSk9Os=
X-Proofpoint-GUID: QnP75QNiD17f6TnsIQV9Ax0IK5ruSWb3
X-Authority-Analysis: v=2.4 cv=FPSOVOos c=1 sm=1 tr=0 ts=6aa2d54f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=UZU69nzyrOPdbO5r1bMA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX/woiwdaCQK8H
 ODiuCVVaP3OLjVXzwL4vHl2XcRJH6zGVm2pVAorrF2FNKbSJ1wKlAHhBIk1l+lS54kO/l+tTEu5
 K0dErOQ3VmDJ4CsQc4/re6yw/eXo70gGLYY6NJeGR5qztlbkAmMZL6XNTmANu/uNvRyd/qKasNg
 AYpGOQVFT3NJ5U9MicYduhLiPFWP+kJhej3qcAniv0skW5Q3uh8ZeikYX/i3V9xaheVF0DX1ZOD
 iB1UKfmeSVXC+WxHUpiRWiUfL38XUaQTVmci/OneL+mNqO1yZ8anE6yE4ssTZcKtD5QvRTZK5JX
 IW+PW9zFcTNLgAwAKACvXBZkhj6MybXFj02Er7RPmVhBBgzRg1qWECSQIzV1mj4XObCkHivRMRf
 JHUPYpEiezhIznE82jNVL1KPWv28tGDLrrCbswjsvKaoxLOUMwYGsADDPd1ibtkJhBqi2itiSaY
 PQCyx0eEiydziQITLVw==
X-Proofpoint-ORIG-GUID: QnP75QNiD17f6TnsIQV9Ax0IK5ruSWb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Fri, Aug 21, 2026 at 8:58=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wrote:
>
> sdio_uart_add_port() allocates the transmit fifo before claiming a
> slot in sdio_uart_table[].  When all UART_NR slots are taken, it
> returns -EBUSY with the fifo still allocated, but the probe error
> path only kfree()s the port, leaking the transmit fifo.
>
> Free the fifo in the failure path of sdio_uart_add_port() itself so
> the function retains nothing on error.
>
> Fixes: 8b197a5ce7a7 ("sdio_uart: Use kfifo instead of the messy circ stuf=
f")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_uart.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 7fd5dedf3ac0..705163c42972 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -104,6 +104,9 @@ static int sdio_uart_add_port(struct sdio_uart_port *=
port)
>         }
>         spin_unlock(&sdio_uart_table_lock);
>
> +       if (ret)
> +               kfifo_free(&port->xmit_fifo);
> +
>         return ret;
>  }
>
>
> ---
> base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
> change-id: 20260822-sdio_uart-a702d7cc5eb4
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
