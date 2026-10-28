Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207760;
	b=EaFpZ5Uh1crfWsdhaZaehybEziykJfKk8bJ001nlqmyIqTCz1dcvu5HHM8SUSWhIv4Ou
	 j9/s7acj1ePA/CHc5zHWPxEKaEtgxRt7vCARlILnDSp9k2L41fUz4FftK6R9qUMxWmhKl
	 ud0/ZUAdautFiJHdqsyljOb2LKldIms5y7BXohsL5b1RFkVFBrPkekVhEKI+5cH+k4sWv
	 B1b/iWIhsRO+RCoGdgGD4xfXyyjw5M/4lWAV2g/0JNddnK9XMqQZAsxbyCcL2zMUiRnFY
	 jYZ2FFf+PEGCpVN87SaQ+yCdfaR6k91M+24iFp1ibIrpi6xhtC0sm0+PwUY7aRNDGSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=U6J0BRrI4kPVJ/bk3IAJhv1IXMizxeZjW5h8A1WOixo=;
	b=kmbodKIC8i71at5vPZYdJQGp1K1veXPqrNFd6rVlEir3kNMZgHRTjWG4wwCaRlP0kn1X
	 s1X5sF4xPB23lazp0KMVj6WEQgCGuhFgBA/3N5FE8sJYjQRfKMgiomAUWJViV2ahxaN1x
	 aBWL7SK8hukBhjRaA74qycnhgnwG/Y6T1KNVfYq77nVlzsh94Ax7ddk/UaNAd7Z7ko9XK
	 JYLuLV0jFvWKUE9uvlbSFvF8is5+9aihWhWKWGvi/weZqkrBnLQdbt9C4RaSlNQF+fiG9
	 DJrwSwA0hdTODAS8ZguF7kx5xLakOAc5Wj3X8LyTakDOBoGM8muCAThyS56fNwk2jpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zm68wNUr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ap+d+FuN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0F606A31A
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zm68wNUr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ap+d+FuN
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAYl11153386
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U6J0BRrI4kPVJ/bk3IAJhv1IXMizxeZjW5h8A1WOixo=; b=Zm68wNUr/Q5Zt0Ax
	qYY3vozS7J3KBUIelyem6d8Wl+nIFXdxj2zVm7iT8KDWq8ayy0RGFPIPwR36ujf7
	IERq01AKADPZ/uQByoEP4p/cyPq2TsR79CUg6pbk7UfOlRLIcxqEQGBccesDLAne
	rhACbd/fv6ffIGy13RUpqH1BkMiIbUXbYuFtzgZx2xwxUvt2z8fiB9TELNQpjeJ4
	AhTB/KTOkWU4FQy0+8HJCaah3S82ZqdQPiNNyvkwQDQ+5AsADNDj3ayHHmcE4oh7
	1dCX+C5EExTVV6H/I00CgIkCEEddfMWlLzpr06MWzCKJer+6dbw9Zotn+1LvKh0H
	13R5Ww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be3ps2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e818ca61bfso11003135ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207758; cv=none;
        d=google.com; s=arc-20260327;
        b=eHT14u5TdnGNViZkKAJn0ZLSZ8EHrArbxcCKErrGX8V3r211jkULaVCO33OGYmjW46
         xth9Pnau2lD9c8ssxC5AY7wJ5M7nzwgVHiy/atwKwA00i469S/L9SRjrfS7I3bWiYji6
         61zoFbBAs/iZ7WwYel4SArE1VMtEr3B5DvToWgCzbf5tcBcGS10OR7HVmFNLp+8kEj+V
         r7RyN+lvl7HkiNoQ8ZC5aok9L7RSPFXZMIOzOQ52nhyh1sCWlpJW00YuTPj9f9fPxpF1
         ES+9hQxw0w4FRNsl/GPMJD6hGHibhJbOQYYoLBjSatfDvJoze4daRocqLbxyAZvFejpf
         4xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6J0BRrI4kPVJ/bk3IAJhv1IXMizxeZjW5h8A1WOixo=;
        fh=upiXEBuV6RP7wytMrfJKobVqZ4H+VQ1Ad35V5OFus/I=;
        b=WJTUoFq4jKBruZTTnlBMC6bmbxJAlHJBYAFdCvG5ZlnCHLQUaohODE8VGkGExF/nE/
         HbVVqaDlZ0rF+XY94aBgYeGiCzNWHzSHxXMXVKFM4YdhknHBTjxjxMT78q2+y8sjVEQj
         R2CwKb4CK+PIFJKN1kVluYEvjdLu8AFDclgQ2CBIrsJusd2FTDCpEWMU45VDaOuqDnOv
         anvOIosqJjg+r/+RtsapVOX97QuZKIiKJAoeriUGjkBtHlruz90PXtAYqfaAnkIOwzHm
         J1hmHGDxyJZvTBHNw+7anN8bB11CBUgRqutX8kLvzASeYWo0w37NGJe085aPClwDRJTQ
         65Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207758; x=1793812558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6J0BRrI4kPVJ/bk3IAJhv1IXMizxeZjW5h8A1WOixo=;
        b=ap+d+FuNftCQDytCXYUw2/4kjZ+8Ku8m+/Nc5qrT7xRRUioSA8u9tkZP8wpi2ICHdH
         JzZX5DbfU7iWpLHwc7tlkz+ApevzPLyM2HnWJF0lraj9SO1CZmlipPP81YDibnsNBsGx
         nmWHICvj/bgTYLA5K/3npGr9JDjcc8eFdwapKxrXmM+6aLOPIhKvfUjwPDeCRt3Ssgjp
         QLNQoGlCAEqK5ZqXqCFwNL0os8KICVYI+8Bf1aA6XTx2Ke4ooWNdAA/gq1lHER5kKTpg
         SuMZHgtgq6kt/zb9YtLAnLhAse+dkmxHkWLjPABrqqsYgSAL75pnrvwnlB1JgUzLtxnx
         JSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207758; x=1793812558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6J0BRrI4kPVJ/bk3IAJhv1IXMizxeZjW5h8A1WOixo=;
        b=W+1StHzyMcwfIjnVAmG1CU4lYaqC8ghvSYhFMzL3l0dUkLktMlnhBEUVxuYPLXRrds
         rvhPh1hMVjkEeg31MPJ7HGEtmJMfWT1tK+72E5Tyd3DNxs1w6YAJj8Rk/UCarfJy0eZ5
         yEqqdWx+j16bEZxR6pk4Fk2MAhwejEYNn2VtHhYwV1KtLJqqrpjiZe3qzB9R6rloIFD6
         wuWSsWXFXdMjUe8yCvOdaanx3el6+cOkyr4J7HQ2Y9QUejfo1kEnEgtCBTRCQi4i5k8g
         mYkZwYrzkyBzPJ0CCdEp1OA3RsE/A3oSsJBxgk6dXhhIh6EAgsF8//i84rpVB/1fR4dr
         nS3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxtf9A0q7RRGxKaZXEbntUpbU+6a+jFPznVn9S1BvWSKUFlNAjg+EIeBvX+VYgKegbobuGZuXcwxow=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDxxb3FQG7W2j9KyzwOx5yGyfS9oFkuWzFg0fxYs55EwJ5cY8L
	0aHuUjOg6datm1GMhR1GepwBaJUnIgP/MjheIm4vHXvOZad1zNxXin+Q+UDcK1FI5j5YUR44sCa
	NQyqrzNZtXnXOXbad6y0A2gsYcbCL/h49lJ/wS/eHpqX35nyIe5q4QCU2XktePGJmaVI0YPjV22
	sdXKrEu0KJ4WaEfty47jXn6SHJ/tOCazpgNJeT37plzgGvig==
X-Gm-Gg: AYBFou1yn6T1dhFqZKJsawoSb996DGhjWNJuFNZUWLNEjrAxm0cs0UhM2cYvnEgQu+v
	vL3z7b1ifcDAI36aGWuT3RY4M8bApqJ0EMW9lyTidISau8YavFZ03ztazHXXa7VdwvpamKZ+34M
	ggXt31iYBpJf+o63ffUIL7uUY7gZHcI88rVhkyyJDvsF3X4TvCC+mhpORxyQ==
X-Received: by 2002:a17:903:1cb:b0:2e9:5714:608e with SMTP id d9443c01a7336-2eb00487c87mr29459005ad.49.1793207757727;
        Wed, 28 Oct 2026 10:15:57 -0700 (PDT)
X-Received: by 2002:a17:903:1cb:b0:2e9:5714:608e with SMTP id
 d9443c01a7336-2eb00487c87mr29458715ad.49.1793207757243; Wed, 28 Oct 2026
 10:15:57 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026070029.1108506-1-shawn.lin@linux.dev>
In-Reply-To: <20261026070029.1108506-1-shawn.lin@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:43 +0100
X-Gm-Features: AclHuK-1eFjBO_fC0_qvhj7wAlh8booO9BFsvkdj7cONHm4D75eC3V1Cgsz7y8k
Message-ID: <CAPx+jO-gvwpF97XZcB94m0U7n+_Pptx58X2bnfVwuODHXiDREQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix wrong comments in the regulator helpers
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: VM1meaSjfXioShYloIKjiewaZSOg-hJW
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae22dce cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=s8YR1HE3AAAA:8 a=0Xp6xAE764Q90VD851IA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX3/b5hJLCrzow
 098xN7eN7+0R+wptwgvISdsyb8S83LjmsrvyML4pO7Xj+5xeeUapGOVuhp7SHBrMvlitcEGbiMA
 AbnQb7/uk6Bg2gIU+H7zICx4jEMTvx8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX2KClh4OU9A+8
 OFu8A7g+Rf8AUZjKPZKmfhOePwXJX7qy1KuHgxwIIUWdPV76H7bV4aZg1G6e78YU3p7aVVQrKfs
 4Vo2A6KsGfK8SjKLvWdtXONV9JPL3/p5jz3cwW3vndXdMdu4Fqss6guz6mD9c709vjG2ZnxVBHO
 WgumyZBStE9k+8AlpCTxtZgrhWTPOOpCJu/lbh4PL3gGQem8GvfqswJcqeATxDroNOcIonlMO0+
 UYmjQhHbQYJbjhU1uVbOHoSryZ8KJALPGay9pvQT/GhqyD3BXLm8rnu/gJ74vA3ZLAAKbdpD1oF
 nfzUlZj6bHV7Qnb8VGf5Q0SRENpNMBoGZIvjPxxhnWAUxZHvIhy5nvLInhaO3em9htsLPgiEB+Q
 z0Cmq9k8WFTkuJ4HdFXNlIELVMOIJIp8kHQe2IaKAjtFWmX0O2yEGB9fZ0KLMLBOpdD3xXrkUdg
 YO31NWxmowy25a2wvLQ==
X-Proofpoint-GUID: VM1meaSjfXioShYloIKjiewaZSOg-hJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280068

On Mon, Oct 26, 2026 at 8:00=E2=80=AFAM Shawn Lin <shawn.lin@linux.dev> wro=
te:
>
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
> mmc_ocrbitnum_to_vdd() stores the voltage range in microvolts, as the
> min_uV and max_uV argument names say, but its kernel-doc documents the
> unit as mV. Fix the unit.
>
> mmc_regulator_disable_vqmmc() returns void, but its kernel-doc claims
> that it returns 0 or an errno. Drop that sentence.
>
> No functional change.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/regulator.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index a85179f1a4de..bbc773c647fa 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -19,8 +19,8 @@
>  /**
>   * mmc_ocrbitnum_to_vdd - Convert a OCR bit number to its voltage
>   * @vdd_bit:   OCR bit number
> - * @min_uV:    minimum voltage value (mV)
> - * @max_uV:    maximum voltage value (mV)
> + * @min_uV:    minimum voltage value (uV)
> + * @max_uV:    maximum voltage value (uV)
>   *
>   * This function returns the voltage range according to the provided OCR
>   * bit number. If conversion is not possible a negative errno value retu=
rned.
> @@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
>   * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
>   * @mmc: the host to regulate
>   *
> - * Returns 0 or errno. Disables the regulator for vqmmc.
> + * Disables the regulator for vqmmc.
>   * Keeps track of the enable status for ensuring that calls to
>   * regulator_enable/disable are balanced.
>   */
> --
> 2.25.1
>
