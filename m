Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F94582E6
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514918; cv=pass; b=BovAErpgTg206v9baNRLBKIF9a5D1Kc+Ew637H7B+sNXQbPTDAZc1eoahdQUvDuQjuNvieHQ1qTUBSm12PCMvC4az2kN2Yp1tYPlMBL+IguHj8LP+FgFKLyBM/fx9zD0Ej3X3NZ27VtyPeciVCRP2XXSQJbQA/G4qNfsCefwFNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514918; c=relaxed/simple;
	bh=qRGzzdaOPo3OS6XeDCZ3Be7zPlIFi7jn0EjMfIZ+rxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoFLt8L3hX7dgR58fMnaSnOT6GI2rtzoxYd2Zd6FUL2udPSg43J2/+e4znDt+SzVNjguS3iEi9NIcrKE3qW+nqwlwnKWun/GFcNde8m/h4HuNfIzo+VliGQe/iV/uLl5blf5Q9c/FgKi2gcinHWggRyaPsHOnx9WHpdB9c5gFzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BuzxoCzS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8NNo92Y; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuzxoCzS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8NNo92Y"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n3r02976828
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tj5w9Ay0zp2EkGqnRPIaa5YhxwHFgmpY35Ucat+9+Y8=; b=BuzxoCzS6uD10tGP
	S8/k97MAZ6tZ4xbSJ8ip7+J6EK5FS0J8ZDtPEoqRSTaaqEw11Ym2B0A16de2cARK
	3qwh8/KmJ9oHXTPF6+gK1hezY2WJqW1ELNPbVtpzosFgJDiU/NzE79hCigLbxjXu
	dcU1UhP306/q4Uj5JqeJWcmivQl9ri1vRs9390ykHBoBcFsuz8wICFQl4mpgp+AU
	wcupHf46/e3HCadlTy8zT6Fv3zk5Fy1xZTG0lirKzwNty/8PIFjgYjONMaAXVWhd
	UZWV66rxUmYq33OZSS+m9kFB5lUdX+ym7T0QcdtI3ywuUX0Ru95RXDUHztk17VXw
	EWc70A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxjxu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce7dff6253so22315245ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514915; cv=none;
        d=google.com; s=arc-20260327;
        b=WHac2Y+IiiULKIwbu/POw3X4MuiYJjclX/u5hr2HfTcqzQcUoKFlKSneBEn02OJ7/1
         KvqTt6sB8gGdgCEExxJ/W4UsMAJXC3bok24Tjg/A1biJ3yl10oPGkY0Wboe3mnrvQDA4
         7QzHZCRDSiZ5i2Kgqvk/5wPgTQsoz247NooFA/B2FCSzapX4fv6Fp9km85EdIycfwZL7
         LGDjN3rWQFVpsrulWZ38T6F5bJfuguJ6T6zLI/Dw96szOoqzIBCCqM/bHdrkGB2HC4pv
         ONUXXTVzSvkz79YjTJNV77j175HiXycKbdJVWI3mmzZAalZFTogIHLyhiG3czUnCQPEE
         0I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tj5w9Ay0zp2EkGqnRPIaa5YhxwHFgmpY35Ucat+9+Y8=;
        fh=i8YCMglgFCwYdAPiz6a4TFs1Q4Z8DwAG7BEB8AELe+k=;
        b=fxmYGn+8DHAQ5axNLDaltC8YCnc/bZlH+s6/X3I1kWR0TwAASV33dZxuvObMltIEj6
         ZXphC91zlRK1Vh+lVJ+lqoXohxLMQ1eEQFMchv/yWZhBl2BznWHaQJC9LXAjIsEHOJln
         Qi3pni33deIobNdWqrwVojnTl32wwL50LIxhWNg5hButhUUvKfEaxXay4+DHY9u4fwX7
         9nFHcwPbkUBPPJYWX7tp5pLaqBc+TZlDvz1NnYQHsUi97hDycRUsQ8RMZoh0mYnY0P4s
         2je6WFyPbZqsbyiFcCZf9mBy9VdwDM4mnBAm6PQRvPwi7FhwvGPsX2VTMPvVC8iY1Xkt
         2dkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514915; x=1789119715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tj5w9Ay0zp2EkGqnRPIaa5YhxwHFgmpY35Ucat+9+Y8=;
        b=J8NNo92Y2zT9FO2JwSrjM75XtDkISaPbnv61Z1/oHKFd+mdAMxk4cdzkfZ4nd9Fn9z
         CWxNXZ14tDqUlKhDLMZiSBAbdGpCntzyVYaTS/CV+GpCmt4Zq/gUa3zikkrXDHsD4Lo6
         QZRWKWfxIRIZn2T6kTyz3EuLYVzRo07ajmPZgFGV6v1d+BhiPO6GSjqyV533wRznU3RC
         KuJMrz2Ipsr6F8m4ZaX3xBxpjysuUQgrZJc3gHGrjG8TtKlpmfLDugZxRmDz7hWzV/62
         fA5lC9PENMrdpupmgcnWYnO2WVc4ygJdH+jrLLLPF/K2njUkopO8XeZ14l0Ta5c461zB
         50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514915; x=1789119715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tj5w9Ay0zp2EkGqnRPIaa5YhxwHFgmpY35Ucat+9+Y8=;
        b=mwlfnUJMg56H/+rk0pc8LhmHV0nEW6mRfOiubTXL8VPVUezss3wr7HGhDrYTJVNOSK
         fmxPQuxI1m/Hcxjvsz+q49F2cW63jr3UD/h44oYDOycBA9mslfXDqQCgRM/438r+gvjv
         4Xo06p6VU09toFnbNnGRzJg5+EmZmMRK3V9/jBtxIUECuNdWNaxYh8Ihu446+O1HO+yc
         CCX9PufLQSZ3zNIP2TWNo8L6ncOiyqT1uxR2wixetVK9cGObYT4U6dec+ZxlsnPehdY7
         5b74bVO4MqCYvbHEhjtgsQXuMwYvVyHLB8aPxH9yTBo6cTDXUGBqgKFEfomfgGJYfl4a
         7dEA==
X-Forwarded-Encrypted: i=1; AKwUvBzDqfeUf2kIfeknMseQc3ps/iEO7IWKyCV7PQ6oNQWevx9m+N5uEfX+pqykPtc9enBP/aQQ2BRpHyE=@vger.kernel.org
X-Gm-Message-State: AFuF++k9I7iK0iU6Tzazr7dO19xpyC7md0hMjv9qechnqGgA3hJPm/UQ
	IwZvS6S8edtG+fpVUG+mKLB7PaD8Ssb7ixqS0bU/lrproLLR8fvNF8Jxwc1ZQJMmFPPtrlvksRI
	3SP5P7aAlMRVENc93/oF59cBpQxx2jdUIjaD+dH1a6ibdc8MupvFcrwi/isyKHGf9UmeyZdPqla
	tcP+DXvgz0ZMhXD6IsJWJ9bqkHuz8bNcjkGwiJzw==
X-Gm-Gg: AYBFou0pGnyIzYm6YP0Ag9RX4TN+rtPpT17/51Yrc+DWEyK2I2B2FdSHJWNzqq4MOVP
	dXU1N9x3++bZPXZD5alJAMquN8/zugpBm+m/edRT/A8CxXJTGTxRN/+pMsg41V4YEGapEwYj9u9
	NIUJQ9NfWTwfQUVKNZqeChyc8tzxYS1+S2J+gm6Pvi72o8aZei62Vrj1xs5A==
X-Received: by 2002:a17:902:d4cf:b0:2d8:d4cf:fe4a with SMTP id d9443c01a7336-2db15bd9addmr33760805ad.16.1788514915383;
        Fri, 04 Sep 2026 02:41:55 -0700 (PDT)
X-Received: by 2002:a17:902:d4cf:b0:2d8:d4cf:fe4a with SMTP id
 d9443c01a7336-2db15bd9addmr33760515ad.16.1788514914955; Fri, 04 Sep 2026
 02:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806162202.657512-1-jm@ti.com>
In-Reply-To: <20260806162202.657512-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:43 +0200
X-Gm-Features: AcwNN1WuovdSU_2kEKvHD8EEYyXMloGWDohy5Yd4DT2AHl_0YEhIymeBDEfX6pI
Message-ID: <CAPx+jO9bWbwzZqgjW1pzYwD4OfsHLBuxEEsqkvzLgF0NLT4Rmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: Add power_off_delay_us support
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SIifRP0Zc1uBRi4hllgyMvljtBererK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX8SxidxY/bPO5
 /dXGFncKNnvxzaoUkzjMjvE8lxfmopuhauDk/EqyEEEd355q8Fhp5TaFxjXHsc7wSM403S7LLKj
 PlCrp19PIwp7zlGWNer8Cy8mHDqdW3s=
X-Proofpoint-GUID: SIifRP0Zc1uBRi4hllgyMvljtBererK0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX6O1m76jziZvW
 LStBRt+/H5MLOe7A+QXua/cd3e+dxJTTuedH3NdVo0S2Ssfx2p9NLCVoKoBFr7EA5AgvsAlvbR5
 d2wmaYG+LQAwKCtTRq1VxpD7r9sVtRYOvsqef9cLuJ9g8RISJldWqHXz6AiWvcp064+2+ScfADK
 P5AiK5y3VGDnIzQX8Rfd16PMbKN4GXaZsJCNgWpttlUE70oX7wPExwjLLplodBJVMNrkk8afUym
 OMydh25/nH483JowkEx4c0JU/1PhNs+OzMSr87PmvgcbzpIpumFTddKjmxqC8hlk/FipG3UeSNi
 S8/lwb3oncVvyRJ2Ly+TmFr/lxBtyGtB6+8uuSupTl52XYD7EIqoFRytxf2SGjJbjUDJHI2Qp2p
 fRkBUnFe5Dc+eq6xait39WiT+ifs2COGXFl68yF/Uc9mVms5IQd6i8kpRABbKrrMpWDoR44YaMp
 T1VGjP5KOIsIRugT/yA==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9a9264 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Z57f2_SGLxpEgxUGCI4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Thu, Aug 6, 2026 at 6:23=E2=80=AFPM Judith Mendez <jm@ti.com> wrote:
>
> This series adds power_off_delay_us support for MMC controllers,
> enabling boards to specify custom delays after MMC power off to work arou=
nd
> hardware issues such as slow RC circuites on MMC VDD rails.
>
> Rather than adding host driver-specific workarounds, we abstract the
> implementation into the MMC core and pickup the delay value with a device
> tree property (power-off-delay-us). This allows any board with slow
> power off requirements to configure the necessary delay without code
> changes.
>
> The solution is minimal and follows existing patterns as with
> power_delay_ms. The allowed minimum value =3D 0 ms (early return).
> The default value is 1000us to not deviate from the
> original 1ms delay set in mmc_power_off().
>
> Link to v1:
> https://lore.kernel.org/all/20260716232641.2659710-1-jm@ti.com/
> Link to v2:
> https://lore.kernel.org/all/20260722205701.372789-1-jm@ti.com/
>
> Changes since v2:
> - allow 0us as lowest possible value (early return)
> - Change custom logic in mmc_delay_us() to use fsleep()
> - drop dt parsing checkers
>
> Judith Mendez (2):
>   dt-bindings: mmc: Add power-off-delay-us property
>   mmc: core: Add power-off-delay-us support
>
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>  drivers/mmc/core/core.c                                |  2 +-
>  drivers/mmc/core/core.h                                |  8 ++++++++
>  drivers/mmc/core/host.c                                |  4 ++++
>  include/linux/mmc/host.h                               |  1 +
>  5 files changed, 24 insertions(+), 1 deletion(-)
>
> --
> 2.54.0
>

The series applied for next, thanks!

Kind regards
Uffe
