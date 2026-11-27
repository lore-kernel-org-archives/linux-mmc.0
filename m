Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790645;
	b=3ylJrIiAAiMor05fAShKzobqYrUNjFiF7s0QzW8z5oR+t1FCuij/R308H3k2uEu51Oy9
	 KivMnuFJ46geDlZZLZm2fMfYrVgerrackyHmUMmCVyNrJ7wQfL2Lm67ZThPsG+X81bXhL
	 pCIM2424Lrxn78L+c/NR2EvTsWuSc/w2udieIGrkC9CeYWNUDLm5Cfe54eMqOTkE6LhZv
	 LE+dWXW1yQ7noywlFHcA3G3SrhCKZxSJbMc1hpKKnlhqSPpZpQst2OvE2kEU8ZlvMgBH8
	 94ShqLfZxA0wZVuRZDr5GfZPhlXOB1ISN/trnGK45R0K41KlRhYAWjU0RtX33jty3gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790645;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Gm0SC2OoLtHJGqeYOnwPOMS823rNI5WQcbZ6VsTFSFI=;
	b=QOek2SMhGhhXqw8nZKXQHgdzDIb0klL84XJNCVNAjD/qo46jKiBrlveYurGOWsXtZ2jZ
	 9gViCN5yWOQxI9JH1Qk7zRQKrOOMUKJSlIO4lhYFAfsnD/V+/EyqU6dHuCVSb/BFtP34S
	 /IK6S/aDbVxjpGk5edbdrxnRS2R5jRgA9CZXWj4Qn7hs9xmU3TPllfSajoWVT47DBqQtb
	 wOQhik+TBu77ht9PY1EgJraigMtv5SRgFF365HgVKbeX71DwnyM385oKYqD7P+ZRpTTtk
	 oJD4xAhtIAUTu741yyApxitgjeebnhz6WFCm/i5m0bEJsW03soATIq2ljPZm8nm1trQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ITRN7jWd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jorthud0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0A606A331
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F0A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ITRN7jWd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jorthud0
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Pmm1790995
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gm0SC2OoLtHJGqeYOnwPOMS823rNI5WQcbZ6VsTFSFI=; b=ITRN7jWdYeGit414
	XY3MbIRB9nhtVM3YTmBem8rNTpiYSz3nmz89N9qpObQ8vD8xiNmmgBtqM7Nj77TS
	wiRqR4rnq33IBgBYfAGd3DjRhPAdtArY8Cl8jn/S3J4JP454iQ5O8oqCFxDTE7er
	OWcGUjVl2a2OI4YLva1KFmWhQ3ijMLB3woYgdXVaU3JQ+x3qAXlJYfzLXIPEgoNt
	df4h+Le0zFp9J4vHtGzAXgX946RjFf4XFpmm/C6gcFt9tLACIZ567INGtkih1/Bj
	IXQv4Aeabp6Tl6pqrfDH1Uwv6LD2+WVZ+bKKEIgN7O8HjgBuyEJVT+UX/k5mM2cm
	7Z1O+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3b0du-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b42ebf632cso5967941a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790644; cv=none;
        d=google.com; s=arc-20260327;
        b=IUDiU0e8TAnRlwcVUMHJiHjdvSQe1kCq1Dy/KNchwbknAOZ19ayPFBO0iaZSpLqOYG
         5OeqfCcT8KphZZJjsGbgSmh3g2K7Dr5q82vObekkpk9Kqu14brIECQTHuQ4FcEE/dm2M
         F1NoLm7Vbj9cLNHGs10OJ3S5nxzvzyDZ5MZIyliAv1P4RsLRqhmXoyk/zhPKrpFt/Zm6
         W77PAfmjlcdWD0683t/chKitgul6MmvRrxtXE8m/3xbVJFw5tl0fNVte5vXQdRZyAHyu
         ueOdNuJfuqZzEIqSSO3CZbe0eJFxIZGoY/m8IMDZUP/z+t2A5NhQyjUOWVy0uM45NvWX
         lrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm0SC2OoLtHJGqeYOnwPOMS823rNI5WQcbZ6VsTFSFI=;
        fh=rj3rsDLX83LoIYa9H/FAyJjBlU52LcYdB4pS0zl3LCY=;
        b=XZKwZkDuqfwKSDDK2BMVd/x1MpazL3wKH8vTfEWg9V0r72s4b0pBW78/FEGxzQSuy5
         n5wktCg/WPEcoBvbd/Rea/7trHjBf6pqKE63hNoifvIDj2+rdVGg+htU4Sz2TTmTFQTQ
         yRPQGDoBw9udC3GbywbZrgkvnDBLVSIgoND8b4/NjgcQN4vdYnGTO8oJMKXuoYK3DqO7
         vft0Y3a+lBIOUuv5YpOns8mi7Z3xeQemxhU0mlx6bQhewLnZm1ZtGK3RsUEVeggOZm2j
         BR/OniLABfMhVQu22UVTExkwAzwBa+m9IgaX4f5jTgSkSXRw4IBUp9cJ48jDLqI+orrt
         v0nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790644; x=1796395444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gm0SC2OoLtHJGqeYOnwPOMS823rNI5WQcbZ6VsTFSFI=;
        b=jorthud0+RB/X+X9tbTS6/DCRtw5MKld63wKX3a2rWCR0jfRBab3iWyTkgeH7Q3JRM
         q0QlFab+6uGWtLQ0BtcAXqSIJ/HZVDQDjmunog3f150q4K7oGWwQO/1E+CCfcbBz1g17
         CCyws5umf0Khzb093rjgwehrjBr223Yu55A/cZEFalBuhzTA8TqNDMya/Dsp6POrWdzW
         O3ZsU7+AMeLkSWzhKuej4STCkFSDHhyqMWs8IGq5Z214ZJG4JKgHSXtl96SfhU9XyQeS
         ge+J08zhIPeQ2JQ3FUnnM8HQw6v1Ddl/2mhvqaC63m/1aQH7yuSQA72Y6p4p6+IDnmtt
         H7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790644; x=1796395444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm0SC2OoLtHJGqeYOnwPOMS823rNI5WQcbZ6VsTFSFI=;
        b=VremaZziwIOHfL/SBE0S6FOWGSLS2btnT0uMQShVD8yWyHgGGf3XSQjUJ+Cc7ydqn2
         eLSBbEL7hnZRVm253MuHPhXq5RSR74UvvJdf4i/0CF2CO/K5TcL2zPDdCXqb/RV1rvu+
         ideyO3Y5qBRZp8tbLaagfGbmXxXZnX/Byq66mse/m4/RfmX/tv9+YdJ9MsefwedyoItg
         XNjDbBPApHU3ir/5V70ZuCTCEdoD0fSc3tJy5JH1+B9/zhobrOjyfa/vlV3/XsFkmHB8
         X/gUTehYMPcG4JCw+i6b6myHEoDeHNLRVTRw6NjVRCQwDOI46geAV24KPL+EGHXCn3Gm
         mIxw==
X-Forwarded-Encrypted: i=1; AL+hErFlZRoubgdtJdzKuzbZW6dxgFGMo4GRFy0aql76eNH+ggVP5PzFMJEo/505Bi3H0rr8ZJ5HBTsJxtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9x9i4oQ72jweYnJciFHVg8/GCIv2eLSWu94ImKq24Mtm5JMCfS
	JD3NHJcBrx7TVA6AjE2mO/AqmC3qYbF7wuXt3xbWGS0bqV+CYnyiH9W/bsHO0EJuIgEh3VAfhly
	34u5xfiUO9rsCjYz1qPtCpsAz6voNIkLyDPKNsLOImyQ9KI0yXWS7jhdS+70HeA3FOw2NL8VoG3
	R/kU+KWUB3CvQYm1CQ4ZEE1PjSQtW0nYg1oQTeAg==
X-Gm-Gg: AZFdTZfirHrfrEYonUJo3uE1AHcSFD7FRm5EJdVFZ7uOgUqK1IIhVBbpWVLb26KTgeQ
	U5inatCXxYt3SYHUSg5/RMrLo1fMLL1ylAJ4CDnqAKOsJb8efkregptuZc5jSSW+Fp6KBjJHo1X
	7CNLZlttURTPdXiMoDAO8kaQo/uYwn0zUFuKW6VldQiF41E2lrfjBZ7lBb0w==
X-Received: by 2002:a17:90a:ec86:b0:3b3:b0f4:1bf5 with SMTP id 98e67ed59e1d1-3b41c9cf154mr22306739a91.25.1795790643612;
        Fri, 27 Nov 2026 06:44:03 -0800 (PST)
X-Received: by 2002:a17:90a:ec86:b0:3b3:b0f4:1bf5 with SMTP id
 98e67ed59e1d1-3b41c9cf154mr22306703a91.25.1795790643094; Fri, 27 Nov 2026
 06:44:03 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112101443.62417-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261112101443.62417-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:50 +0100
X-Gm-Features: Aa3M54prP2UHzn5PjkT34uEO0dhZsx3V3cq8jc-3H7qImBJ0krZzEtCQlSs-mao
Message-ID: <CAPx+jO9Fzw5Ap84-hG-tw_g+hOfp73-Ox1yY+T_WrXZdUrZBqw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: Drop Asutosh Das
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b099734 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sIzR1sLO6NqiVEzso7YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3e5Bj-Xyz_NzGeXYenP1-ymwX04NP2bX
X-Proofpoint-ORIG-GUID: 3e5Bj-Xyz_NzGeXYenP1-ymwX04NP2bX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3x2DwM0DqFee
 OUy9EVMg5FjFzArBpsn9cxCKJBeEUWGXwHtLfUn+UK229J8pzhnRFoG6fzFMqcV7u9vRKfHN4+o
 avGo9pjdl7MMHsjyVOTl/hzgg7cQdkpjtQZGStNA24Xzv+Crvvgd2RPzcqFzU2ukeKql3uCQmU+
 9V8afkWdXlzwr3cpMLlZndMno/5bLPW66YSi1pP+meRnZrjRP++3y15M6FGTJYhPPiafli4ZHqL
 o2XqKwdJGdtKB+B+RkJn1oiTh/m/nKDfmANdEzwNmRD2adF7CyQ2vgqrkarA0S9zxcqu3ev2GvU
 s65c4dH9J4Q2u9BoycM1uedE+601qWdCMAEWIv2SUIWtCxTRmey+XrZ868YF3JLA9YI6rggaTRB
 GlC6sUwV7080ehH7TpefRoOascvAvXro+Bv5q1dWVDS/JGJZ2dFDuIsBMEYCz40XMnGs3S21c3D
 3v8TdXjyth5q1gzRO8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX0kML6rMb49sT
 simw8Hzp1OcahjowenkBPdjxuRdAMc19kHqPqJT3Ki2sAYRPz36Yy3YMwp+oRgz8JOoPg4bAyr3
 5fduTlHFt3RC7QqVz/9PrGuSI19Ojd4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Thu, Nov 12, 2026 at 11:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Emails to Asutosh Das bounce permanently with 550 code.  quicinc.com
> domain was long time ago changed to oss.qualcomm.com and every Qualcomm
> maintainer was asked to do the update in maintainers file, thus if that
> update did not happen, then maintainer has moved on.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa647f5d37dd..b0ba5fd61b33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9868,7 +9868,6 @@ F:        drivers/media/usb/em28xx/
>
>  EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
>  M:     Adrian Hunter <adrian.hunter@intel.com>
> -M:     Asutosh Das <quic_asutoshd@quicinc.com>
>  R:     Ritesh Harjani <ritesh.list@gmail.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Supported
> --
> 2.53.0
>
