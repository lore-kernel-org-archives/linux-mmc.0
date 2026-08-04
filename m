Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE14499BF
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850984; cv=pass; b=d/9psyYCVfklD201w2ajZIaURNrZWrxYClo8lqTOEy5IV7IMgv4Km1m/A7fVI5QfHQ1+v09oBLvYLIXtamQguNZxj1Jxx6RBfseIa6gc1VgCpenE4mH80nlMgEfnbalvSTO/yvct7zXq9ojz/jYCoZoY+NXCRhqbGEYZRdnXXM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850984; c=relaxed/simple;
	bh=Ap50wJNS6rGhW5kOX2jJWrelaNRHw/n8EXoTFaWVrbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmeQ8DibtqOj/x+QKiRrfMSVfZl2AH4seE38hb0nHNkfm2hffFB5A3YAAbVIg0jsnzRewhQN38xHdCZv8nu1rSR5RjbTKciRaNr0ojWvenoXdK+Q3uH9MilENkPdtG4iGOEQM3uSDlq5VauEJsXncI5kOxzAFS+Dg5E/AomgxSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWITTC8o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foI/XZAR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWITTC8o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foI/XZAR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWlD2818407
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HVvvAVztjSa7UDj58naCmzw8jLM39lU68nCOnQc7GUA=; b=bWITTC8orBglSf0i
	QYmbNZwOtSEgtwXBOfOgypiNpx/R/CB3WJRKcKBsb2nt5SL/K3GDgetEle58fjow
	cWMCi7jB5694vMj2gvlnL5pXWNWNhFpcNhr3ashNqxk7E55L/u4A4ASNNzZYxtfx
	oDulK6XOARRJRQk4qrXQGtqshPsLn2oGXIkLzsasjLqsborCVCy85ciy43UEF1qM
	NpqbWOfQrFVLrY/Ax+HpW+q5SNSfHikknXN5SVcop+XoYcemhs0bE/v2qIFu8KZm
	rMHQoHe+jgR1w6/R8YGWGME5FfFAnxuzP23VgUL1l7Crn1iqJNbloCRiICL5ciaA
	jwOs/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud1dh3k1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9349c5af52bso779328385a.0
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850981; cv=none;
        d=google.com; s=arc-20260327;
        b=F23bVZMp76UCkFlE7gPgNAovT3ClfyTqKZqVEtfhduIpak5Y9sunMcxejLayGuMAJm
         bo85tUG6IvpVaasFCkomrrsZDsBDcVGet5XRqT4ZSPKRYBN5XyU5DBgkcmRRU9sRYFZ0
         oBEwQsGV6Wz10ChoSjfGb0R7pAT9Kl10qctnNv9BQ/rkwzI5B9md9wSxP2ikUNgUrpah
         ALpPRbE7/FUY1j4+KCjUAAUKOIz2Prm39V9dO752cZI3YZp1iOO7Ha7SeOktKgadd762
         mqcBlF4lmGKyw38MME9yoIKxso8GFFtzX024nbIjGtuvox3qEjkXIBCkyVXE8kMnCWh9
         SEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVvvAVztjSa7UDj58naCmzw8jLM39lU68nCOnQc7GUA=;
        fh=Eu04nb0n0QYpol6Htj9zGSivMTzhG7LFaa8dYeCbN9s=;
        b=GCzaEDlsxdoZQYscpKzkx4FXlHdQ006lg7+ehh03emkPwNg9Csp2smjsKAj2N745WL
         dhRE4p5Jkj7+p9NfDf4a9mR9XPdU2gjSjdAYdTWl8T3vKSDDfnnFb7S9f3q4HXVTuiMe
         cRg5ZUKG0QFYcte1vrY8VAxoxdRrqbx+HJs4DCPkqU9llhMiuMJMB5KycdBUr9rXvqZ/
         Z5XIIQiGQ+vnVuI3dSj/yGCl0GVKagDxr7BXLqVgXmpE5Ojn1sGI/VlLeCs3tTcNtN9Z
         FMSuLyZpUvhqXlxW/A/GvGTrHD2W1tjYe6UC0lm6SRJLkOMA+B0bDGit4LtQIntQJ9ip
         fdmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850981; x=1786455781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HVvvAVztjSa7UDj58naCmzw8jLM39lU68nCOnQc7GUA=;
        b=foI/XZARp0RTOeRGc6zeBrLGkkOUCpo0CPr0uNSBTM78leFImEPPxX/S/L/T/2Pwrp
         BhsoO3TD0uq71mj5EU4JMnd4FRRO9ts3Svhx3QUWaUgoSATN1Z9WFOJVAu/SYZDvC+YC
         Q04/cBk6W57sKxJ6G2XHl/Eebh9O6CeiudFn1U9PZqnrgM+TAiv0ze1bsJohLwQjFsRv
         x9jPTZ4uzW0N7dDhmCsjFV/IA1mukpPSIOZCem9w8AuLofNBYiHqDemTS/g/enJjL/cW
         xGaN1ncf1MJ+OSwxr/sMLhT+XOncMHnfYcnj0qKDYPp6/PI/AIjsGgpWfv1li6Q4z2r0
         F1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850981; x=1786455781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVvvAVztjSa7UDj58naCmzw8jLM39lU68nCOnQc7GUA=;
        b=W8thT6Rla+fvFmoJFWwnPVaYIslPGBH963QTyw6XR2n5JCAGHJHb5ZBEaTuXMA0n0E
         vovT142wYLjoBo9RDWBG1yQ+Md8s8rMkEp/dTqqbmgJ6hnlbNNbyJaWMNVMqvpksLiRs
         Y4WdlPzjmi1CmPho8TKGBqikipiRqI3u3qQHePB7kjYicW1s+g/57CRbh4KcJ+ZjcHqQ
         GMB6KkadQAl6Wap5U6rI9V6yuRV8gX1q3pg/WLQetdYORdc5xG4mxXzzocbm+Bl94+qn
         2/+wVLBEcDPonH8gQ4g2nZyiKTNI1Xk0S3a5ZKwH7rEvQFZ+nt//J2+QMwrKqhgy34bk
         KBkA==
X-Forwarded-Encrypted: i=1; AHgh+RoIqZTDvK/bH+2gyI8U3vDuP3SIomlB3typvSVzYz2bxzaJQHjUs5GW873DLfwEUsOjrR593AopGnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVxeREgJRwJI2nryThVnWQa5C/KJHSRZEIN7RXeMGruQehwnM
	0TpC8qPiYC6qShvdhtatKIn8yH81Rg3GJoZ/S9CXYYD5QeKz0Vvoz3bBc6a9zgYGCarYYpy3vcE
	DKYi1a8WVARpZyHYvBOpYoZuIi6zBp71KCeYciRIW2qC0NyPztxQp0dgw320hJ0Iy7QMW1dynXe
	V1q/03OMknIPuIXCvs+i2t+UKUwZpSraKOc0NPh8GYg21C1A==
X-Gm-Gg: AR+sD12M2h4mLl0iEAGQX5AYQpgY8vLysKHngFHqgEfeqZ0cKKvChHYbviyZOtWal2n
	JfTt4LA8SiOvjybqchcEdRfJShNxmI/anuzBlWztaKm3WA9SGtnCIugb5uxe8W8HSVZD/x0NDMO
	PnGuubmeJzCO/4aqKOPkA6sDxoJz4arOlDJOhpZAy/StkoQln5PqmQD03YCw==
X-Received: by 2002:a05:620a:460a:b0:92a:d10e:bddf with SMTP id af79cd13be357-934a07488famr2617500985a.4.1785850981332;
        Tue, 04 Aug 2026 06:43:01 -0700 (PDT)
X-Received: by 2002:a05:620a:460a:b0:92a:d10e:bddf with SMTP id
 af79cd13be357-934a07488famr2617493885a.4.1785850980858; Tue, 04 Aug 2026
 06:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-sdhci-fix-v1-1-1a655a5d895d@nxp.com>
In-Reply-To: <20260727-sdhci-fix-v1-1-1a655a5d895d@nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:49 +0200
X-Gm-Features: AUfX_myk1A7RNMhBTulzM3h54dI-ohoFMQTns5udRhkwANPFbUAdJDDOVeY7yWI
Message-ID: <CAPx+jO81304unQwypjFLvYj108u5r1FJy4j3NeiZ-JR=VXde8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: make tuning_err a signed int
To: haibo.chen@oss.nxp.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Zn7GGo_93DQ_LOFuqxriSx5VnM22aeUF
X-Authority-Analysis: v=2.4 cv=SJRykuvH c=1 sm=1 tr=0 ts=6a71ec66 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=8AirrxEcAAAA:8 a=1PNuwfDnIaaTBrVRkbkA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Zn7GGo_93DQ_LOFuqxriSx5VnM22aeUF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX0Qwh6K3ri5xy
 wgJOc+KIjmIccPJKP95haEwKHIenQJmYiOvpjn1oGH4bAgTxOtti8kV8Ue58FS3o7v0avdZFaRd
 hp3fOjwaImmwj0PSsV9Uo+jn6ydp32c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfXwc2Ppcz+ROWA
 s6Fgz42PFQfMM+anzfTdxVqVBhUiPbKC4gV35PzMPTOnEAxVRiPmgvFdHqCIrttBATwYzvi7/qR
 ZgsQAo3uEBoiFzaAHisCyulQesTkzJkB5i4//z/jMBVFNKQ703ro2qWOarER0E8hmzYnEqqWGte
 M+/1RZTLVJuoxry60EqlSe4pPtLI2pJtMD2JYT2FmNKxAKCM5QC/VJyHyRKyyUmcgcrAWBWVhBJ
 kKVIEAlCBWptGjsVFkpI4GBR8Dwex/gfVZHCq00hvgo9Jrv16UaZDmwUXHKB4sLqjrktZ2EWe9i
 oehRObUzHg1/DbK7iyBydCHmEm/OPvEcNPCBG0roabJBJ7fTfHDe2SmgxUOnzVv4W57FHbskvf7
 Zmw2r1wSvpLRF/AcXhL89qvL/00uLUA2MS+uJWWhsayHhgxuWuo1I/SdsOGSZ8nUZMgnWf8EFev
 kG39tQ8Yr5Y2YkincUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Mon, Jul 27, 2026 at 12:35=E2=80=AFPM <haibo.chen@oss.nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Coverity report INTEGER_OVERFLOW for host->tuning_err.
> The tuning_err field in struct sdhci_host is used to store an error
> code for re-tuning, but it was declared as unsigned int. Several call
> sites store negative error codes into it and later compare against
> negative values:
>
>   - sdhci.c, sdhci-of-dwcmshc.c and sdhci-pci-gli.c assign it the
>     return value of __sdhci_execute_tuning()/__sdhci_execute_tuning_9750(=
),
>     both of which return a signed int (possibly a negative errno);
>   - sdhci-of-esdhc.c assigns host->tuning_err =3D -EAGAIN and later does
>     "ret =3D host->tuning_err; if (ret =3D=3D -EAGAIN ...)";
>   - sdhci-of-dwcmshc.c prints it with the %d (signed) conversion.
>
> Storing a negative errno in an unsigned int and reading it back as a
> signed int only happens to work because of two's-complement, same-width
> integer conversions. It is misleading and triggers sign-conversion
> warnings. All users treat the value either as a signed error code or as
> a boolean (zero / non-zero), so changing the type to a signed int is
> safe and makes the intent explicit.
>
> Fixes: 7d8bb1f46e13 ("mmc: sdhci: add tuning error codes")
> Assisted-by: Cline:claude-sonnet [read_file, search_files, git]
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b6a571d866fa53ce2aad0105cea2909abe6bce01..f0fd81409a86c6fd9120e6976=
6fa2407c14e9048 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -659,7 +659,7 @@ struct sdhci_host {
>
>         unsigned int            tuning_count;   /* Timer count for re-tun=
ing */
>         unsigned int            tuning_mode;    /* Re-tuning mode support=
ed by host */
> -       unsigned int            tuning_err;     /* Error code for re-tuni=
ng */
> +       int                     tuning_err;     /* Error code for re-tuni=
ng */
>  #define SDHCI_TUNING_MODE_1    0
>  #define SDHCI_TUNING_MODE_2    1
>  #define SDHCI_TUNING_MODE_3    2
>
> ---
> base-commit: c5e32e86ca02b003f86e095d379b38148999293d
> change-id: 20260727-sdhci-fix-13481630ae02
>
> Best regards,
> --
> Haibo Chen <haibo.chen@nxp.com>
>
