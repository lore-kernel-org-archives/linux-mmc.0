Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A90434E20
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352867; cv=pass; b=jxxjMaYUf3qIiu6Xfez6L43+h/LyWFbDiwupEkKW9RHp4ZN1tHSvvoVgxyeRQcRR8UoS0VzMZJM8bGVwJQiSSaW/HgQyiVBeFuU6AF3o+DRvNjBsVPxBgPEoSyX3dL/3tFdEYXesBdJPlkIiRPleHqwn0v15iqA1JDLtiJYUGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352867; c=relaxed/simple;
	bh=0tiakhhRHWloBkaDPloS6cW51EYt6Ge7WA++l4ZNoq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6Zlu3Y1whUe/8ydsxtZu5VQNXWsdIg2tJTuscRGDZy4N5MbPT/WUzpfuRYPs/7oc0jpjCc3pEC1kvBn1crtERRjbERihTQM5AnhNtGxAK9I6D4B/t0O0/UqBPpLMrpUrUe7GN4K9VGMhsCJ8IkDM0zKLRWJHTeyx3Gd3V1s5F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fnLcbYMn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R9kuTc7t; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fnLcbYMn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R9kuTc7t"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF2ek980949
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tj0gObdWkFCTVs4u237wDEw/Qb+xCQFXIKqWze4lcIg=; b=fnLcbYMnU36V8e0k
	q+N47oSggJwy2YnhvCHMQZ7Ve2+2waHDgIcu+6xrOvRGqj8dbhEXcDZFWNsIy/De
	wG+zxy2xxs4b+PHA6mq4/ng1zF1gnkXRv9jYRKLscvQl9kV/tZMTPfm0hz1QX1Vj
	mJUE3AuVwI94RkG2WtQETRCaL4RqEu+PO2EuudeK1K6XnND6aKuMIieAlE0qgBl0
	sd97+fH60kvyNnuD7gDpYtBfsZ4ZOr83czrJf3MUahxPBUWkbDNc8QpR8wqzGXxs
	pFrAbFsz/DgUtTONEcvRhj3js4K3IyE3mMYIZFyfY5ec5y8Yisot/ozPSVj8NlZU
	ZgxxIg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsr7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eb8914e651so63242616d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352864; cv=none;
        d=google.com; s=arc-20260327;
        b=YnoxrQJs0JPxbO/qiw11tIYOVtPfDUIYP1JPDXjyL45SHh5QAIfKU8rtfgVc6n0mPG
         xV+ThW8/KVs5Pnc9l7YsokBlMjcMI+WW98PwpaCZTjvdqYXQ7i2RazkuErPvAxwDclcG
         4iT1b27TuHWWQCuFQNNFbAHpKaU/XQwndRe+Z+zIykbzUNu52Va+QBAHh+cHtMqbwOzz
         CKYYv0D3sFpGuviKwUajGP2JmiXfFV1op0UpMCrX5d6wsdD6pdX1UDXymYt5b9n3HUQw
         RBcjuKjeffKFlcjd4XhtinP/yBJJJqZBWvl2hf9ZmdeJq0OFiUzyIOzkIwJvTruPKtzQ
         zLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tj0gObdWkFCTVs4u237wDEw/Qb+xCQFXIKqWze4lcIg=;
        fh=gFha9ppfLGHW7Lc8L6X5HbL9BF4GoZXMgrgkW7DNvVo=;
        b=O+ur3BYYPktdXtrhSDpl5pbZQDBq0zW1vXHKoJgW+f2GPaaOIEqZJaFn0XBZlwOlHm
         5LblAbDPEWMOpY2VniiB4eBBYp2t4hw0MBuwcTw+BmN9Sh/XzAvk19vig0reOkuKWf4h
         VZSpoPzIS+bqPhpW5NdXx/ZAYXK9du2CdcK8giH7R/o6b9WZ8iu9kDrJiJbOU3O80YG4
         ixICQFbfOtZKBbak5hTjTNXDAy70+dNhF7nKpEkU9TPXgbteX7jU+5y25lGaA90afqqJ
         UaZT5ZYYFfzcUx7sx+dwxxGuJJpQFpY2tQBE5/W4pI7hx4Ostj80gvBppZsTx48MQeU7
         7Vkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352864; x=1783957664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tj0gObdWkFCTVs4u237wDEw/Qb+xCQFXIKqWze4lcIg=;
        b=R9kuTc7tnrSwrSIl0bd94j5BpIrBbvJg24cocZs3ZL7WMwmBnfAQb/fw29+b4AgAS4
         uErfL28DFG+N05GEz9Y0NGN9f0bWKafZRahJnGUbDesX6AVYde8lGW44FC8eQb7tRqTZ
         7zk78lPQx+uOPNGw6KISTelzOi1BgoFNjfTjKKKA2n1MG/mJVGl2RdIcusL7jw+bGp4U
         t3B5sGs4YQQp9wuMeLcFsaXS0Mo76mQQ7ZtBOgns6OArQ+krFhA0Kd6kZDP53kZqq8OU
         avIiIqib+bQfSYZXE2amCnQ1jo/jSmmkNywdx6yv6PQsnw7ACpDDGQMaVF7xeer0UQJk
         rTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352864; x=1783957664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tj0gObdWkFCTVs4u237wDEw/Qb+xCQFXIKqWze4lcIg=;
        b=jcVS4cIckzd4NjgBuoK+/c18ti4QNTqaNX2uxJzmFY2AJee5YnPGfyuEXPJyKpoQr+
         DUswpVLXlG3/WCKLUegOjI+wLhqC15bMUrhT+RyoCm/I0rNbHbhaIB6PgRUkj83t9hVX
         HA0jxYVVcehvCDbOgJpexsANkSaI++fUnNHtvVGoHk7YMv3Emg958VPbfFFnb3yu0Vne
         EJviAslBgRLfEsqNngCAwXYiHsmVlyVGpoBOJ/2aSpduWkF/kNR7H6l1zNQ0dHbIOG83
         tzeqZ1jZO+N0YKuZTqLKK+Vr5lmCuBI7ZzUIHrvvnsf+ixLiXtPbFgi1fwg2bysJf6zj
         xriQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp09kD0/GvQ/rw3ekQaIWt3yNURZo+um0FbJCnURMXjLS3evBY31wsir3QC0qPq2floOmTKzg5Tfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67KwLkrbDNrteT1qBnvU2ia1N0HJ0Olzl3kqu44j6527H6456
	lc8TbpzUUpiF5BrE3YxCuZyf4RiLpIRRLIbYZ/Jsbl9mpyH9txN0crQUt78VBPezc27H2tsV1Uq
	6PG3B94hvqZE0RRAJD8q8/Jr8RnRkc+DAWcaYG2nEswkIn5nHbk72+pE5BiBEMB7CnZfgdoewcE
	mKmI15uKzGdZtLjIA/E2Xx5LlnSaivb0vV6FDqNg==
X-Gm-Gg: AfdE7cmVm7lHaEfmTI3X1/ZB3r9eDjDf/Yb/UynLo2zxamRKC696EnXIviIITq9pvvq
	0w6vKpw+dK3TLqA5CdJt9jQ2AT/I79ko0sD0zttHeQYgoBLRoaCjXQc8k1gMkWlN+Qo3n219zir
	q8Tk0sqBvN1HON+mbPNyQISLGfbXDOWUWSRJWB3kRYjOXfO9d6+4hT5uBKqR+Z+ql1+PNP
X-Received: by 2002:a05:6214:4506:b0:8ec:cdb2:5e11 with SMTP id 6a1803df08f44-8fcb1ed90b4mr14552936d6.2.1783352864273;
        Mon, 06 Jul 2026 08:47:44 -0700 (PDT)
X-Received: by 2002:a05:6214:4506:b0:8ec:cdb2:5e11 with SMTP id
 6a1803df08f44-8fcb1ed90b4mr14552456d6.2.1783352863886; Mon, 06 Jul 2026
 08:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704124115.2874-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260704124115.2874-1-pengpeng@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:31 +0200
X-Gm-Features: AVVi8Cfc23vDy9sML05-jTCqkpjriTSh-qx-MZzbfaJJdsJ4vWmJahgYgtlUlYc
Message-ID: <CAPx+jO8WTpHOU=1qziE8Ez9vqyRu_Hq_-yKLtNA+z=-GviXjaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-ma35d1: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8l85OH_MizhDi4Br1KR3AndwbjG5ILA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfX8fT1Z0hib2Yc
 9y5KcRp8PC4FAinme+Lk/DsYa8ArQjSw2vCY0hOiws/oLK2rVPYrL6xj87QvoQORe3DLIQDH5Ua
 zVTbFwoVGBcAhMVo9OvgT7V6459qgWWhhTGnr4HYoDIkf5ln6rLwm+G64eIwIIdeCpxWE5ce7bp
 IAeU7zIhg4G0MxNNPGkiF5aNusJCKwY55KkkxrEJR2Imc69MmorxSYX8H0GOV4qWGUXDkl52QNG
 D1H3v5BSO3qrzpcM+if5uMDzHaktlSborKFuiBLhd4GTD3bx3PwVxMxDwNOQcByXhu9uk3vTkYK
 +74eNERlpB9Szsm2HHNvcafTJTlcy1SzZ4bHJ3vj/uVI7fFsc4IqPkyk3UXK1EHBtbBR/i3Efwm
 aD4bwb9UPLngpZuDAYcluSmMRHthGaIOntnLF5cCAc6FkmuBfdHMqFk+MN8LR2AsF8fdqjeeXq9
 LQPPy2TX1T+PgKfMKZQ==
X-Proofpoint-ORIG-GUID: 8l85OH_MizhDi4Br1KR3AndwbjG5ILA9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfXxmI1gvV1ej7n
 gLmssSf9B2JIXhL2IJyB6DdZGV4IJqKpBhKBjuApKwDNfb9Bt5PSoqh3pqWa22w8gQ9Jqa9hZky
 lwMR3lJSGI7eD3c3+z7c6CWgJCkUvHo=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bce21 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=HOKP6D99j0CxLuPf18AA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060161

On Sat, Jul 4, 2026 at 2:41=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:
>
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied for next (by cleanup of the commit message a bit), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-ma35d1.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-=
of-ma35d1.c
> index a3b676894838..2a826de97779 100644
> --- a/drivers/mmc/host/sdhci-of-ma35d1.c
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -290,6 +290,7 @@ static const struct of_device_id sdhci_ma35_dt_ids[] =
=3D {
>         { .compatible =3D "nuvoton,ma35d1-sdhci" },
>         {}
>  };
> +MODULE_DEVICE_TABLE(of, sdhci_ma35_dt_ids);
>
>  static struct platform_driver sdhci_ma35_driver =3D {
>         .driver =3D {
>
