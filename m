Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BD41A766
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352837; cv=pass; b=bSzV+lqFWNzh9MRK1bHiViIoPargIKpT0IuXu+a0Yhz7vaGx0NaW2eBNhXst35I+wiGm1t69DZzZjb1e8rzg7wjaV722h5jmSW2Cv7eiyA8V5JtJou9adTothANpwM4D8N6L9zCEPwib92lLy+HtyPfptxQDMKaZpBasFoTFJrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352837; c=relaxed/simple;
	bh=E3CBLMIg+o8aJJMHOmPeH/gbGd9GIscDdPd59gmAJGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw/gOzWg8P2SK01cbzNEBPnYjfhl7LurN2E7mhMhCecP5QLFIJsF2dt82ao6sr6ACmF4JibllN/xV6BQm/uIZBVcKRmwJjiqLMBlnQ/Tr4lZR/CJpLDBsLA8UJVwXnWidwgyo7jSzEMTfOLHT2L04KtCfqNqkspGAhheA0boWH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aIBhTJd8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dswV7uUq; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aIBhTJd8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dswV7uUq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFCTB972267
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BFfezvwTH/BefOLxndpn64cUB5jXMIkVjWU57dxK+Ck=; b=aIBhTJd8YzFv00VR
	n2yX3KyHG6SXSIS4AU8tvvtN4CT3Ais1sWVae8CAeyN8sOc8+I5SZU1WCpde2VJD
	aqOoTxWv+i9LhiusZ1Vl6sZrtqL8Fwyd3byJVdsxkgTiUX3nqjTO8oK5TZ9umIEK
	akda1J8nW72fez3H7rN9ELvANXBUY0Rr3SZZMgz4l/EbE6B35D6ZEDWuSR+59CS4
	Sl7PvuendH/sMlQma2zMWd2hpoFtMGCqiAH0RjpDUipZyOs5Une17sZlL8gH0Tpn
	Ov8iOuV9dIqUgvtu/wH8iK/Vml9utnzuFHfEobN0GqW/VL3vgOT69uEHl7Prb1zm
	CYlP1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r1hsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so33925101cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352833; cv=none;
        d=google.com; s=arc-20260327;
        b=OQJrBjMqHjBKPUVf/EHuvk20S6WORf/KJR0QQ0FAFc/Ad2Xd1kdQBxuqEq2QSz6Jvn
         jEcTdBx+GFv+c4EDhxh72zsvGa5WyRfTdBkgEwGhdP4E6krXMsIDcfn+k1SXIUGIkm0R
         m7NC3FARmB1I1IsA4Bvj2n+YUBNTAlH1/q2dRdsZWaAILuwVy5UGbJVQLbmV6BTBwyzX
         jNKphCiLEjCr4UiZSSNiKNWdFnSnyycyLJAGfVmPuKO6YC6CaYkRJgiapboE+wXYpVMz
         pL6/oVQcmhKFu2r0IcQF0VTe3g+VPAJGrPH35hI2E2jGlJm2JA7iyqKeaYj0e5qvrM4S
         iiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BFfezvwTH/BefOLxndpn64cUB5jXMIkVjWU57dxK+Ck=;
        fh=3jsks+qqSsOwz6LAFkaHABmk8PevXR0hRlPUjkbAg10=;
        b=XD/SEXGx/gIkHio9d3jIsd7ZWxAoRBH4zYJmzLdvaDT7SyU42MY8oGijQQvzds/cHZ
         aEyFSN27WmMZkYhsYgc3AdjhHgqfwQKRe6LuaV/6OUejhjyE9MP6mbYLMtDhwUQVr1kU
         NuYmZUYhnjeMuEq4PkOHarYberKtvpjM/HvVLd2V7bW+LuGralXMkG9DF5mVTGb1zv2U
         LrD95ewxg8c4y0QvjmNDJ1/y2Obul2Lm9AhvObvy1hJvmOWVsk2BGs8EWpQ8ZJjxrIT2
         OjhK/QpXAh2J0EUbzj2Mm9xL1hekSdkd9sQX8FgcNSQbt1JiqYKYrZlemhaIf+LrYewO
         /2Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352833; x=1783957633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BFfezvwTH/BefOLxndpn64cUB5jXMIkVjWU57dxK+Ck=;
        b=dswV7uUqoqKXTIjiSDQZoTcJsHJJAXjd1EL0Ne3+hdM7fJI6vExV+WcBt71dk35B6V
         Z0RQkJZZCoJQephbMGEsqTxOUXKfV6ZkIu+e9ORtbl5gQdrlUF70RxqLbRcS546sVNlA
         O7aB2opCQ7GQeLwldO8MPIZ2a/QwmK3AKQQAicTD2rQvN7CFL4Dc3KPZ9zqyspfHdjqe
         IoMvDVUncV8rKunZhhb74hDJwX2Ud5WA8hXhuxcxtKmgYwcgnncfN3aLzTjjevbIH3I7
         xhQl0QeD98bPvSAnBOtSvhGddCXEPHZb1KSCCscy/FVgO9m/BMbDf7i0j6Z5cUVz2Wjc
         WJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352833; x=1783957633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFfezvwTH/BefOLxndpn64cUB5jXMIkVjWU57dxK+Ck=;
        b=TLs3g/Kqons35Hr4Zn6/19pJFjxb8DShYaxnlUlkoDRxYa4t+mpVu51qOEQB5XNvYj
         04zRClLx+FOlfM1ZiQpRFhiMyDsujfz5+PzvZthl4gZk66mbmKr7WL4j5ScWfP9eQV32
         7niSpi75Pa9BtFI2jx/dCg4kNfFpYphDC2e5Ye0NJ1aP0Z4dMn3K/w0sa86m2/Lp8JNS
         aZsxNYEEI66s8UzevyqmWNX7iTpZiyWhMA8LDCBWvaMy9IsWDZa3KEG53GNSj2/v7UrX
         aupqZ3uGTSquZuo4fHVZLoS3vjs2/Mw+JudGUaPm8aA86lZwMNj8n7O3FCwtysXHqwl7
         CPKw==
X-Forwarded-Encrypted: i=1; AHgh+RpZUECBrKSo5Pu29xQZTDkefOw/UVcy70z8ZjqjBF9ghJXoZNR1xxKMM+XhqwQslUCFlyqslR/xC1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIhLHS2zZZCP8Njw8C7Oyexl1esprA4qCgMU6zY818D6xIZRj
	Kjy1XtjDmGQtJ3TG3Mdamy6SvofSO3TwR5Xgsh5rajtHu3UpgTf9hu9t0d+k6ao1fjtY5UA5qDt
	uEecLrGDxA3oxdHW0I7wnt348FokIwzTNcs9jSkjDirhZm+Niotk7+te3V+S8WjWNdd3J3G02qk
	mKvVv2KYB6XYvj1I/GsJbCvq13JLnX3yEhU3vEsQ==
X-Gm-Gg: AfdE7cl9lMDhb0s4xB7UyR/4bhvIRxRpgHnNWwvg2eVhc7Y/rmQffi58M/UwfPpXC75
	m/zKolwvKd9ighOruBAcKSML2Xl+hBQXtJe+c/10yDYId/LG2GtPV5zdFHYDvwrDXd/u2ZU9Zjq
	0uDRxxImZxRZbUe00L+fKPstlvV2qKKBgEYQmWg0zmQX5xP0NwOCWrHn3p6DvZeXRfb6yX
X-Received: by 2002:ac8:5806:0:b0:517:c65c:488b with SMTP id d75a77b69052e-51c7464b724mr12951991cf.0.1783352832441;
        Mon, 06 Jul 2026 08:47:12 -0700 (PDT)
X-Received: by 2002:ac8:5806:0:b0:517:c65c:488b with SMTP id
 d75a77b69052e-51c7464b724mr12951361cf.0.1783352831853; Mon, 06 Jul 2026
 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618220209.211875-1-jm@ti.com>
In-Reply-To: <20260618220209.211875-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:00 +0200
X-Gm-Features: AVVi8CfjXh0u4tF-7PxbFkuwCfomEE_3se_wwKm5CGV8cPU-GJseRbq24UkHo7Y
Message-ID: <CAPx+jO-K8sFTfn8dRL=k6==9h+3G6aAn-fbM5OgH5kuvfNS4_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself to maintain TI AM654 SDHCI host drver
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Moteen Shah <m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX527jbpENUG9f
 d+ShTjrPE48gpUsSGfyjcXhLBFXoCC5EP/JZDbtlMWTSp4xBFL3eCjA25VyQtsJr3i5WVGfxyRF
 RjJOA6S//POmz3Vr4TRnVrdU4XOe50XYNuOuON2kwd9vOhAOlUPp2PwSdIVSlbv0FxZPxfRo+g5
 lr0Abz5y1eZ3N80t5IYbw2LzP8rHGaHmotj1NjX4mhuS4cACUaFVKrlcpLS0Z3aECo1bxbnLhn+
 cbV96rMPjLuzi/iS4eM7uqSd6w5UIoDu79nfJKO8LOBE5FFLN8TNN43k1mfGV7XguJwDWlWIcOj
 ibfYlBBLqKl7CDcUSykfAmYwwdOoklzzOxe/utCKuHK0XtZFT8OMxGtBWumO293bitHjzw4nI0t
 n26HgVV05GnpfE2UrwX8d2bbtXBRpW2Fji0vzPQD+7fh/0/PE5rnXRDUTR/ixsjyJBETtdUlqBT
 VRntg2zX3LgESZCz5KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX7M36f/NXOts8
 veJzwG+t4H82Y1I6YqJPs+XdcYWfzySbMKqfR+IDpuI0dHXm0stV5h3AD3OvvYBKGUK2c7QFpLY
 TMU8fEgnxXuKb+SnlpfdGvoYOY1CMcE=
X-Proofpoint-GUID: IGHzVUVgVzSd-4Dg-pRDQLSUut0EKXtJ
X-Proofpoint-ORIG-GUID: IGHzVUVgVzSd-4Dg-pRDQLSUut0EKXtJ
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bce01 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=xq3W2uTSAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VSY78tqDkl8tcLGwDFkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=P5L7wpMTXyg1GfFA3Gwx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Fri, Jun 19, 2026 at 12:02=E2=80=AFAM Judith Mendez <jm@ti.com> wrote:
>
> Since actively working on TI AM654 SDHCI driver, adding myself
> as a maintainer of this driver.
>
> Signed-off-by: Judith Mendez <jm@ti.com>

Applied for next and by updating to "Supported", thanks!

Kind regards
Uffe



> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2040011a3865..97b9b01275729 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26640,6 +26640,13 @@ Q:     http://patchwork.linuxtv.org/project/linu=
x-media/list/
>  T:     git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
>  F:     drivers/media/platform/ti/am437x/
>
> +TI AM654 SDHCI DRIVER
> +M:     Judith Mendez <jm@ti.com>
> +L:     linux-mmc@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +F:     drivers/mmc/host/sdhci_am654.c
> +
>  TI BANDGAP AND THERMAL DRIVER
>  M:     Eduardo Valentin <edubezval@gmail.com>
>  M:     Keerthy <j-keerthy@ti.com>
> --
> 2.54.0
>
