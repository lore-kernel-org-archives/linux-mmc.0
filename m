Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6A46AEE0
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904775; cv=none; b=u9Nb1dOXU4grHMY2L8MuyQMxz9Xhl+p47neWCYysrWyWm58y1T5+znPUSamqy0RoPAUCI7dDQRCyx3b2aMc69WWlbZTPokufKpKNYNmjAj1xxnp5g3A8JZgybfbwlR6SLup6oC3e55SG1wNHKPDFihMcWt3y7MzVh/AbnkxOYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904775; c=relaxed/simple;
	bh=Ua0ef1yufrvAgyuq1JcYRzLNA3rEellk2uJBPX5w7XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtjLGBogKp51V+LTRr8k4h4oAesHqubzpp/nlwAS/ehMJ4D2kPu8tWXGp/K4DWHor+8m3Tu4DoVJFUFb3c+2lX1/RvTL68EuMaiLrwYx808XhFM++5gKcA74thKtYAXurFBWi6aJbJsLnIU5N3Ooz+P96mWcEJtYvXpgYxGrMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwxZyeyl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXQZDHdW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwxZyeyl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXQZDHdW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8iJS683268
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 11:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=; b=gwxZyeylLOdVJC5D
	nuiZH2uaPci7Kc/y5/kYSdu7RKfA7lOmveWJy1VW4oLWcuH5fgjB1NchLw0Ke0dB
	UTygydJC/Obd+YoZgeo7oAUK8CXqIFKcX/nwHed63IOvth5hm1ULhYCZe82PI5BZ
	RlRRg5A//oin8Om9NSrqlkktK7tKPHQLLLKipvVr3iYaXvt6uAtRMLVGRPINW8fk
	pBCYjpq/e/ILwtMuiDELUSRDXVl0dBy4raERAUgi8GDprDV+Hvmv7CyPETGSejji
	0A8KVrbPAPM7jw/ECj54GWkVvVpLsbR6U2kaDO/345lDmguhzCoiTY5cEcdMXOzn
	t/WJSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqkxmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 11:19:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5a63e1f2so5801785a.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782904772; x=1783509572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=;
        b=IXQZDHdWWTas8L/k0iV2V4Bj6gU+wziQ0NUJvzzmSwzSiZ6AfVTAFXJ0HDeJG4F93z
         gNh6+dEjVQKHMmLRK+e2958LKGgvE9VsUx1szpJN+cuKcutjuwnl5ZR0fM7EAyQBat8Y
         4CuKjD4YLtxz4qn2KKQf5duYldumaza5AJ0t1zGzBqLkCnj0peo1ZiZ1irYFxmdYvM0s
         HEbJxBt94JgbgQ/3XBFkR1Ej7NyKRqemG3Uuw90sPFA9tilVRnJDeLIf6DiNwVtuEFrZ
         PsiG+dYVN278uTNp4FlJ2JZKY+J9JltUTkNY1UOLLZHGq8g1TRXQti47QOJbYi9ovV0P
         VvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904772; x=1783509572;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URtox8zEzP/untTK+3HtClYPfjcDlUxDwjjp/zQVHfE=;
        b=W38UgJmE8JCEy+GUxaC9eB1iuhVDMuJCPfd4OAzJQLwaxTiUXHlD3UHdoUje08xcHf
         84gWt/9BCAQALpfND5WIvggo/GPV4b6gpzdR+Pk/rdmWAmAgLKKmt1wM5D3DqgNfD4am
         FPPtpr6vttMTrogzTp4k0hmIjXFqA3v1aCREFZL26C7xUj5OURK2yyHWZZBFrDjADnT+
         y/ZJPpuat2ebWYHPnLPktbTCuAqVIydH/kNGg9h33p+gIYzqUHnkDQqgZ4fPnObnbHPa
         y9R40I5w/JRJMOM3FldwePvCnia/vjlwOL/N98MKGWcZJ2ltMtq9YXdtGxzQIMs3E0zU
         COOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hc3WAlXNO4hT4fqa+2FJQQNUcLDtD23LKZtz+EnjdRSIF24ORPMFLbMzrLtoizGtFk/e4JyrGPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHv1SY8yo6MabemqUy4bX/UBG7WC3OpLG6EMhjeQPaG9qo7fu
	/jHvWy+XPOsHlnwXOKtpH+PYdTZc9PKBaSxM0m6GwUrkIm+ROPeMmgRbAsO7eptqPFATioV3fVN
	ByUChVPHh0IwGPlvOp7to6kPK6KAk5gPpUXYesT9aR/fIn/XlwCZ2FRrqDz1u9+k=
X-Gm-Gg: AfdE7cmW3oqe6ylG/Ql+jqbb5mBZsex7Ozi1WprQNA8S4M1aQW2oqPwNVrgB0YSkMPY
	EKrhNMpBzQQ65li7kUN3tYnckF3Wq2hj6TtB1ZLkrenHdVglGSnPq9hO16cqLWriLcxoGQY4IqM
	n4NDHjmRu5amjm75csPVEvvjOQDyjhFQf84KQlh9TdK6htm/VUpUY+PVuUcgaqr1n7STxqMfsR4
	xQsnWOox3aRle857ejDmGXS9l7FNcGfLcP1dgBORymUTNGWOWuReZwuCqRbRggl67Clnfnfm2Bn
	VkEKaQz+NliE6+qIRv2eW5jimSHJs4w4503vMlXSCbv37quh1DniYMCDXFiMHIpTcYA4XLAPS7L
	iRZrfPByiANBUytfoaaamle7vogonnPqmjiQ=
X-Received: by 2002:a05:622a:14d1:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c26b42202mr8376221cf.11.1782904772069;
        Wed, 01 Jul 2026 04:19:32 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:51a:8c9b:6494 with SMTP id d75a77b69052e-51c26b42202mr8375671cf.11.1782904771316;
        Wed, 01 Jul 2026 04:19:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6b068sm261505466b.25.2026.07.01.04.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:19:30 -0700 (PDT)
Message-ID: <597fac9c-8522-449a-891c-2935382c0cd6@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:19:27 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based
 HCI driver
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-4-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-4-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yEhVT8_OAfG_eUaNlnqSgcwUs9-A4xHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExOSBTYWx0ZWRfX+m7OqKAn8FtC
 AIjQ8/JYbUYziO7Mzq9/Iy7VYnU8rUfvw9EBR95WzG+i+1gSkygZcLyA/zS/wmjvY+tmiIn7f3/
 F5r0Hrd082xr7jlufnFuAmKS/VB2sJvuOXcdsp/BKZKR5ltcNqpailLPJeNM3l3sDKT1o4ub+an
 gL5tFDG65wzU4+0lPF9cNLeAnIHwe21Tuw6hUvthhupyoqhtC/xdrQTz0nv9gaKtrjhEqDHWPjX
 hlqihUY8rSOzKK8+MQ+hxkWoX05PoHSgzMJNz8XwXldQqx46SYWxgjLBp9HBjEBnLs0VcTGc/55
 j4LWytrCgxZ/wPRJMEhGxCoTTCFQq6V8ZjQlHWbQNs5upC517uKt0nVQKZO4bnoZagxJXKFoH5w
 lqcJKmUFzRPqfuYfuYtzMyMji6q4yO2+PkaI+ZPdx7eAQFcfZqkxQC3hcLw/aB2DGEpj1Tn349J
 bxXkxgQO0+qpi/It7ew==
X-Proofpoint-GUID: yEhVT8_OAfG_eUaNlnqSgcwUs9-A4xHP
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44f7c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UqCG9HQmAAAA:8 a=ZNUA0hKuP8YIc2uBTmcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExOSBTYWx0ZWRfXzlH3YamA3I+6
 bGXS+Svjpx3bucVz5YX3cSVmc3ol8ZytIA4nO0c/EyNceT0rfk/L6WBxxiZJyEFvobYaz+OoW1W
 of2WQ+9Pc5+Xk6ud6N9x6nx6a5M9gl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010119

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add support for the Bluetooth controller found in the IPQ5018 SoC.
> This driver implements firmware loading and the transport layer between
> the HCI core and the Bluetooth controller.
> 
> The firmware is loaded by the host into the dedicated reserved memory
> carveout and authenticated by TrustZone. A Secure Channel Manager (SCM)
> call safely brings the peripheral core out of reset.
> 
> A shared memory ring buffer topology handles runtime data frame
> transport between the host APSS and the controller.
> 
> An outgoing APCS IPC bit and an incoming GIC interrupt handle host/guest
> signaling.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/elf.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/mdt_loader.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>

I don't know for sure, but the amount of the includes suggests some may
be unnecessary

[...]

> +static void btqcomipc_update_stats(struct hci_dev *hdev, struct sk_buff *skb);

I don't think the forward-declaration is necessary


> +static struct ring_buffer_info *btss_get_tx_rbuf(struct qcom_btss *desc,
> +						 bool *is_sbuf_full)
> +{
> +	u8 idx;
> +	struct ring_buffer_info *rinfo;
> +
> +	for (rinfo = &(desc->tx_ctxt->sring_buf_info);	rinfo != NULL;
> +		rinfo = (struct ring_buffer_info *)(uintptr_t)(rinfo->next)) {
> +		idx = (rinfo->widx + 1) % (desc->tx_ctxt->smsg_buf_cnt);

That's one complex for-loop! Maybe move the assignments into the loop body

[...]

> +	/* Account for HCI packet type as it's not included in the skb payload */
> +	len = (skb) ? skb->len + 1 : 0;

Unnecessary parentheses, also in some other places

> +	memset(&aux_ptr, 0, sizeof(struct ipc_aux_ptr));

You can do aux_ptr = { } at declaration

Konrad
