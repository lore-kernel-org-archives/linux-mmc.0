Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF842A155
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352857; cv=pass; b=IGgW3XGXHFMPEl/bah5W/gGcMaMkS5I/gtaVtgb+tl2ApMGVOFOLNBWV8UevnGRExkHY8WViMkpSgQ7yMc6jaeltpn/VDTaEzcR1GmU2QH3V5pBrroK1pMG9wyrCKS2+RMwJDhEx0ilOdMx9MUzMIOJKV42eewsFkDJ9JRa44l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352857; c=relaxed/simple;
	bh=CM+ubNu5Tpn4oFeIeJPj+Kz+IN8dhQecln5qBTFzr1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mW4MWpJGbIyDnCnU2EYuIqNKHuRsWIFqx7JiwVaTTRV/GMwrCZH72qgFxIpiMqcIJpg76rlkhVoBKfLhi1LItnyDOMFH1cH0Z1nmtPLcGgr7D26d6Qlxs3LbfKQt4GznKUqY5DgvMVWC/5JDgxMmwOQa6qJzAe29jMG6LdFpc2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JCGdUd74; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWxKnN1O; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JCGdUd74";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWxKnN1O"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF0JS825590
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WxWaaRb93QDxqs8eJfGcKt+ODegJrM9FAhD1rn4dPwQ=; b=JCGdUd7433iyy6of
	C2ieIfbLAFPJj/a1Av//CnFq26oYmJ3u3dTULDOCRCcW1uV4qG2Pu6x7bm5t2d5B
	O+dpelG6Mc+qLkskLQYLSa5a1OuiO1tjDBe3Ebie+2Q93tvXWR1j7F44RIW0R3Vz
	pSuvZhWR8PcjBFabUYYBDkjrygbYzieHO3uMgZvyn8iXJ+YU/me+lPZ24MX+rt3P
	dO/ywJPL2oDJNpYEKlxNlDZG2rQk+6ntgcFNYgdk3AF/xRahfGXP5/BzrWq8MtEw
	LRun+0/hWL6co5Ya51FTY7qLbihQx3hJAGIUflBMNgBYmAQFhqAdGgsEWah8Pmnq
	3EHF0A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89y3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f871so37689396d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352855; cv=none;
        d=google.com; s=arc-20260327;
        b=C57Hd2W7wCIcfr0NZZqiTQXLvIyyqKuZB/zEuhpjlpkk1cHw96o6NyPN/YMTz5FZT1
         8z22OF6bwZVATbzsR3CYjXnyeY3IxPU7ILWQGPIaGgRtzzrpvA3fp6NhLMMCTz1A7eau
         T14YiSWrNppD+Ru3qGaQOy7Tg5LY8qe58K8Y5FCryhw4HFyakX1LUdm77QR8i9x3/nS1
         Icj/uT03UgrzyOQFN4Eyl5tVn6Mvh65pQgNJzz9TiZua2fqwp0rufq9FeDInld8+GOLB
         /BWgOtbI257kFm3cuHxLwWwXMaCKtfHgeZOwi6AHfwXnCfMuoBKcv6UAXQvmCFTQZrSR
         kWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxWaaRb93QDxqs8eJfGcKt+ODegJrM9FAhD1rn4dPwQ=;
        fh=YSWgvcnqmCcNjRBotNl3eoN8OmzBELp9St7/Af/Rh2I=;
        b=d42ei1f0+JeZA4AYFDlsoCuJhbe5y3n87S2v4oCbKBkmKADOUVbIveFRa46ErWSF/F
         /+5u128HFf6SU//oI9h4n2vxclDU2UqO9GgBj2KXNuCKZabGbS8CsVb2iNGTnfUkHPyX
         2fcSe0hx3+bhXTjdtzouzquDixMlk3ACfSKtNlKEcguZV5EH9dwyoPIFae5I9G/bPoq0
         EP/3rJg+YoCxOJ/lRNJkzCZ5Y2vUaXKqJqhjGUPgcuCu0oiMEj+uxcvy/eOkc+ZeRkfW
         7jCwoOCVVtC3vDhlP2N6pIdG5byA13ZRWQ8PaIS71Hz9MfTHzLBa8MMvKPnDb4NY1IjT
         lcag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352855; x=1783957655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxWaaRb93QDxqs8eJfGcKt+ODegJrM9FAhD1rn4dPwQ=;
        b=dWxKnN1OJQmCpigmpPaTUYpe5TkWNbAd/vKRSBYKcC4bZ/gyEVgePSeNJS2aIzGJ2+
         zkXr9MOaGYwq4maIdVxSZTEWYyVZmpdkMwf4ay9JPULRb8AcsX1TdDT8TpEKBIrWRxUs
         WomlQWTWx7lIPw1jApfRrvyKrr/ng2grpnXIafZrpWnHURRCRzOHQdT6SN0jFp9GPczE
         8Aesb3yhGOUg/saOBOzSViefClECXrGzMWRnupHOgdIg/xs4NRajen1S/reKZmT6PWKY
         D0WKOoLdhCNAjynrROrr1ZszeEmRcxfS2Bq4JlsbEP5U9RAQc0EZnAo46+03Q1o6i+Er
         K3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352855; x=1783957655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxWaaRb93QDxqs8eJfGcKt+ODegJrM9FAhD1rn4dPwQ=;
        b=Zz1q6FFOEappHcP2Ba1FRYkj03bCTmRTsl/DOCqQdNMEbZGF3HmATf/6uxyvmshlCD
         j7hKbO7F5Rmtx6KEvukzUVwZ1kgVf2JRG3Ekicf1LWyLmpBOBp8gEXyTOVC/LIKIfwjA
         DyfoosVuRKp/mo1NcLrafUcLJvHoDVv3m+jlXNkrJ5sI/2yoAyVFMQfNLsqo4ngGONAf
         7sEsixjIh4t7TUGt8ZYtPqlM8TxR0QSkvDOPTyUPnUz1IVz3w9Dql62ZU4zCKfKdSl4T
         sBaENLFejegc/4xSmSnmAgvSkX37CgwDrhV+6Ou8TYlqlnN/OzIRylznH6rjUPKq1Q4k
         uMrQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0pqQgCQuca4PEtZvIoil48FEFMsRima/sX6a7+Gso7sb6FDa80q5eYKrP4WPwEAyQf/GcJPuISRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMIxbWQC07bQ8ixLepc/o9W/oVnTQmGUyBle/MBVZ+SFboUwl
	JmLe81ZMYACVSxpmx3nIhgRy3glAh36eUEtnOo5SkZb1nKSrfMDQpNZNQOB1OdrfoWrYXKH4j88
	y2lwW3YfMFEG/YVLBTHU/i1nrqUhPGKBUq7RxKhyeDi76njkgOudwJs6x+X9rk6tho5WPL2wUut
	YSFbmhWBLFNIo2QE2HFvCd5dQhrSio/UZS6MFrLg==
X-Gm-Gg: AfdE7ckqZzXjzTjj9pXfPH6yZzX7Qemj5tmCufE5C25EHaX5tBr1berhAgYSHdTTJQA
	3aS5p4qNyQz/jhhM/hQwS7Y3ZCpzPxgn3ccrcmKDmWPb/+0NwazhlngF8pOcb7GN15M7VaaKRTt
	eCFMDmjIDwpo37Gcp4P3WEI5TfSqNXrjmkDF9qnhW0RXnU2uw25c3h86CawHzyG+b4P4WC
X-Received: by 2002:a05:6214:48f:b0:8f1:579e:a418 with SMTP id 6a1803df08f44-8fcb56c8f99mr13325336d6.43.1783352854502;
        Mon, 06 Jul 2026 08:47:34 -0700 (PDT)
X-Received: by 2002:a05:6214:48f:b0:8f1:579e:a418 with SMTP id
 6a1803df08f44-8fcb56c8f99mr13324626d6.43.1783352853910; Mon, 06 Jul 2026
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
In-Reply-To: <20260629-st-mmc-v5-0-3cf0e639bff8@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:19 +0200
X-Gm-Features: AVVi8CdvK6SaPleWpu9C87ndPSmgsnOwMTRoR_g7UJCEqp43DcokT7xQKZ8HiEI
Message-ID: <CAPx+jO9kjT0eMozVMiS8iot+4PEsET+Spm==p6vc7O_Eo8CGaA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] dt-bindings: mmc: st,sdhci: convert
 STMicroelectronics SDHCI-ST MMC/SD Controller controller binding to YAML
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX+4+JQRUlG1uB
 qkt8+P8IY6P9XWoM82K6lSBJjqLMJSjeCql9qRtaQlRjeHAin3MK2XPNBOnk4V4ESc1NW/2H2aQ
 +jz4jOLwhfCfJVETIcXoOsLr6y2bJhU=
X-Proofpoint-GUID: YYMnVTin8bb-nWvfbY_dqPj4uTu0-_e-
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bce17 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=X2qA2KYq_BSYQ49XwqcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: YYMnVTin8bb-nWvfbY_dqPj4uTu0-_e-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX22ybPSdo9+Bw
 Thj/khdVmUd1MvstazclnvleO/0vISCtP+53BdzmOoMNVS42esUIqebeViBQ1sZ5ZUblM5+0IpY
 N4it/+LYCFfFtNE53mWHwNWeGywXi8pvhQBSSb4OvoAIuOXBipMJ9tEj9O9++XfA8f5UEBa+og7
 1Q1+Z21UbFfdoRmVDR33qR9alGA1i6DjwO4CYLhyMOXd5rxG1lPnIWtkB5WNLS7rx93LaBfY76N
 GaAN3rfyZBUvuqV2aAlsXfhtYXro0kZJ+iEQOJI6wr7ButaMatXtDgSb2tlPKyS8uVR5Vtzm1P+
 aLaSu14I5DfU+xCNy+VCaMqha0aBAgiF2kYoNktJrVAuGD7+4/PrB7hha7Owi8hnsoqf0bN+wlm
 ytFbhTVLBHkPRDfj3MSlDGvzMEV0pabmGoDPCG06o0OAwo/tlfZaDWhN6v73479cAAKTT6oMEfN
 Xfz7nAlIFoX+2tfRZRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160

On Mon, Jun 29, 2026 at 6:26=E2=80=AFPM Charan Pedumuru
<charan.pedumuru@gmail.com> wrote:
>
> This patch series converts the legacy text-based Device Tree binding for
> STMicroelectronics SDHCI-ST MMC/SD controller to DT schema (YAML) format.
>
> Note:
> The patch "dt-bindings: mmc: st,sdhci: convert to DT schema"
> depends on the patch "arm: dts: st: align node patterns with established
> convention". If the DT schema patch is applied before the DTS
> cleanup patch, `dtbs_check` will fail due to the presence of the removed
> properties in the existing DTS.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v5:
> - Rename the sdhci@9060000 and sdhci@9080000 device tree nodes to mmc@906=
0000
>   and mmc@9080000, respectively.
> - Introduce the max-frequency property and add conditional logic to inclu=
de
>   reg-names when the reg property contains two entries.
> - Modify the commit message to explain the changes done for both YAML and=
 DTS files.
> - Link to v4: https://patch.msgid.link/20260613-st-mmc-v4-0-b3c385617c16@=
gmail.com

The v5 series applied for next, thanks!

[...]

Kind regards
Uffe
