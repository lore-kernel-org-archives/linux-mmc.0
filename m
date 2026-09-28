Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB54DE711
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608412; cv=pass; b=apnAKm1e3UuLWLSyk5RjzbHbt0bNQId56jFdJI7bRppiiUir8P/Y9lLhji/BXpYb03jQnalWZHsONPNkCebACkAq3IfQqKXs8nFKj1OuUagPPX56Zuxue4YVCNMpoZnOv2ZQH8c4Folm6yxo22dr0u1jaY5nFIcn5sXVsdX3/JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608412; c=relaxed/simple;
	bh=1OXCRyF9AThOKu8/UttVQyGmeY+oDLRzsKSsi+2NRzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spDr86JntY16yKDCrUD5SaF7xCDo+4wpwE2OWZ8RzHVe6TK2AwfmhJiON6r7TTAWIrZyku/zNU1Xav8Ek7nXT0sJE+v4cks6aq0FG+t/1du8Kpis0Mybtb7wHkldpCgZD0ojqXSB9ZDC6yGHJS7qXbE5DQmqPUi3IdQs0jDbpfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfXexi02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JeniOuri; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfXexi02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JeniOuri"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe6GW1647364
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nBH+Kpv5aivjj51nEWxoe+/mFmj4BPlEmxJ/4Xp//18=; b=hfXexi02Ep4y35wB
	mxQ8k9UoTkBevQrYiO7sySeFhY6UKgWI19vWl4+A7pf9JevF+m44EyD9wZHKtUCr
	X4dG630DALMCc/xEOqHOAl597jUxGS6qHopBl304wiCC27tkOpw3PPnSBgbnijr8
	nz2UW9cQyKO/i+Fozp5XMuVpbvT++iVKZSSrYwR5obLMrtslbCS4p1ZSEJbU8K8/
	6opij5VKPEGkvXwNkVVFojloqWdHw3qLndtqyZF0yeyELbbysKHLnKa3KRtxM3mV
	x6N8g6gMxyYzDbGmNLoRtOlpCaPSgL6punB1AuUkYQRQkUiHxj0XmR86WnarWwrD
	vXdTVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc1c22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:13:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so31541465ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 08:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608409; cv=none;
        d=google.com; s=arc-20260327;
        b=rKSSD3qFQ1ZIl4I0genMBNXH/usskTWKwbOpKtpQso8Bh5M3jmudEnnfzUYEvZV4g/
         4OWAHLakAu8EwVpgcwRUtlvxJaJ6rij2gI0EuRpJKZpdCsBrt4qHXvwzg4tvN8H5pWzw
         41Wc8QElkO+H7k9FXLoL02jBXm0owtaHEtj1qB8K0ps9OcO3y7JQVM+iJfRZzEmYT2Bs
         zczxRoFDV87zfeOsORsGRBJ/vWRD/6iMZDvfcq13jBe4vwiUY7hnbgtI7jaCG56tRQ60
         zi2vCCCOD+98GAS/OVl899rPNI05Kg70ij6wnZeSmZG04XE2YKiUl3VkQ09hzBICofzV
         6IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nBH+Kpv5aivjj51nEWxoe+/mFmj4BPlEmxJ/4Xp//18=;
        fh=Kc4U+tamITuILmoPACg+16/hHx/EqPeatAdln5G/bgw=;
        b=qZ9Mz4adTBH/gUzZU0d3vXFDMbqCsP9aekAezZNpymh+lPTHFO2P82CPhllngLJ431
         5jYrP6C/+3vIF5nrXKTqKj/wMWIEIRjPZ0LQLWpFiZxChKWab2FPaNFFZksuLtd2W+Jf
         /5NpBTr/U1FEq0XT4gYLsac/qZyXPwOJIJR8Wn2Uu/H3Xc1oRZuA0cht54s90nlScC2S
         rlTxB+buxFwJ3I4ks3O/sY0SAKmqpWCqdOxt/jr28rXJeQWe+19eRuIELjphRbGERYQm
         r+AE3p9GtpkgusYGX+C4vazN6Sp3PZ0lTs6QrzZDBh1obws2PU/GuJ/aPcQizfO66dpf
         pUpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790608409; x=1791213209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nBH+Kpv5aivjj51nEWxoe+/mFmj4BPlEmxJ/4Xp//18=;
        b=JeniOuriQEbYisB7n6aY46xYXX3fi/jrNT9qoygQ9MvsJDj24Qm4GpA8Mf9diwRX/d
         L80wrMG1xEPeBIG4oTTJchOLIvW8A1dSek05O3VS+HGvomYizFiDdYzpBkssYzQ6Rdz+
         6ga0hS4aaN4oxRSEdY+vf9rlgbrUgxbEifqvkchoghC/cpWlB+WFt0keOxqL/B4hdohX
         2RORIt0r9iGM1hw7qYCxA8wq6kzCrOzApFTBsWja4Cb8uYqjq07osz8HP6WS5PzZXv9W
         YnKaNTajbXrCBlL/PnkUpxZ0vNgBoHooWtLDP/WG4Ilik7ljSNJIV6jjBx+sVZRnGlQM
         YPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608409; x=1791213209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nBH+Kpv5aivjj51nEWxoe+/mFmj4BPlEmxJ/4Xp//18=;
        b=l5hi6l1r8zNmSuTjEZRKimAiFkmVFzJdmKhQCR1l9hXiZwNYeuEPWxDzJIvRft9bGw
         9XMNCUyg0ly9W7zcHOO2f0u7JLNWmsWbuW8sFqP4n39/U6Iguv7/+O4cnA5DcHnjx+3v
         DXSBlqJN38DfXbQpvAVXk6fVYinev5LELiT7dZpmkYXKGJfBIwRf6L7LTf7f0VV0TOhC
         tsQEOv0u0CRttZpYArBX5o3jNyd84h/j5zE5CA05E1waOOy5iiX9OUIh1XV5NIvnMLVN
         Lf2/FxySF9dx5FPkcixK3/STWNYyqf83PFYbl0M6cUy5XPCoHbguYowC+0ABkW3sfirA
         k5yw==
X-Gm-Message-State: AFq9FYKbDFjg5mMfIShzhfnMbgZWSZzGvYJVOpS3p8xkXfzIP5SfJaoF
	m9ns+be6bAMZU7TQtJkrTEPikhTjkPkuh79ZqVfiQfWsf5RtKAUAqSkq79va1XJhkv12gWw9/XO
	jHOUyog5hYRaP9FebZNls/TdvWhbb6gFfJvDfMI+Azohu0Ad7qk6p01Myv52/O1IYpxkikz836x
	pZQAO3/09jbWCeNo2oqkaCOw9acviR2O/ctFLL+fKGStLznA==
X-Gm-Gg: AYBFou3zk66G4ewhmPYd8qEqeJ2HMZi3bzvVnD+IEIc7l049YtVC95dQcktelPkX/o7
	24fA/O/LdMRBNW2dpjblTsh5qIEEXDzevKrfDij1A663ApAXm2TBQ3Xkkda9qsUQ0l+xKxFFgbs
	0wRSfn10V+qkdKSJH82vSHTQJlzCEFYFksWOWP4xV2NLhI7P9raQq5MRur2Q==
X-Received: by 2002:a17:903:3202:b0:2dd:c100:b2c2 with SMTP id d9443c01a7336-2df7dc49ac5mr118602685ad.45.1790608409071;
        Mon, 28 Sep 2026 08:13:29 -0700 (PDT)
X-Received: by 2002:a17:903:3202:b0:2dd:c100:b2c2 with SMTP id
 d9443c01a7336-2df7dc49ac5mr118602405ad.45.1790608408495; Mon, 28 Sep 2026
 08:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF9RqJ4USGg6G9=X=YQ3Rtg11YS5aPBE+RrejdYfcJB8Td4-wg@mail.gmail.com>
In-Reply-To: <CAF9RqJ4USGg6G9=X=YQ3Rtg11YS5aPBE+RrejdYfcJB8Td4-wg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:13:16 +0200
X-Gm-Features: AclHuK_2znw927VBjZkB6nWfjwu2zK07eo5IS6fhqMWKbKbiSFpFFmRg3hlXRg0
Message-ID: <CAPx+jO_X1DYyHpQFfoo05+wLPhhw=AiBr1TP2KhfPO2asmYowA@mail.gmail.com>
Subject: Re: [PATCH] memstick: ms_block: rename misspelled sucessfuly_* parameters
To: Ruslan Vagner <rusya92266@gmail.com>
Cc: linux-mmc@vger.kernel.org, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba841a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=Ydy-zDh7byrXg15PCQQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 2l7Fy7MvOQ4TpzEaB1P2sjWEzbzBozmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MCBTYWx0ZWRfX0EZlH6gOS7xk
 0TO09+tf2zagieEmZ2SiPlZrvrW2E+fMwDkA7e2bhOSKf/SKJaB8whe4dXkfspzZLU3eX+MAFq7
 JvfIYvRHLbaWl2sEbCK+GD1CCU7AOaeeGIeGRFVJfcF5zcHW3e1GhLseEZUopUN1yr40ToHcHSM
 9P0uwKhjrXQFbyYrjckPAqMnRxfleAShkFTUam3wkY91FnyUvYD9xQ2bl9sVqCovN3HyrQEL/iC
 6pqDjU9tc1nuOQGhLqV19EsnKuIm7zqxvtMY+kyOfvBZ8CT5HLwkBiSPpjyA+gQxSZYbquePkwh
 hr7IZVlpevVU4AKu6uyd17CpgFjVQJ9As7Ifp32XvCKedt5mYLjhRPSJnFxad7JZEdDsZIJrdzx
 1aVLbGW+3y9vvVAdZrpajLYHsrp84n9qJ7OttlBGIE1nVpK6+3DAZUZ4kKdpyN7bUBCyppRIpAi
 szyg6iv2/oUfG+/TJ4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MCBTYWx0ZWRfX3pF+w2VNZOcO
 V73ZbRFVDAIe9ARn+9u1IrneXsZ16/9Ql69JthxvpQZre+MtMLj/3UfppLYDLhucR/RhPL+gaqz
 Jiytbjv/urWD/SYh+pBMBuYj7c/a61Y=
X-Proofpoint-ORIG-GUID: 2l7Fy7MvOQ4TpzEaB1P2sjWEzbzBozmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280060

On Tue, Sep 15, 2026 at 2:56=E2=80=AFPM Ruslan Vagner <rusya92266@gmail.com=
> wrote:
>
> Rename sucessfuly_written/sucessfuly_read to
> successfully_written/successfully_read in msb_do_write_request()
> and msb_do_read_request(). Both functions are static and callers
> pass the arguments positionally, so the rename is local to this file.

Instead of fixing the misspelled names, how about renaming them to
bytes_read|written (or whatever unit name we are looking at), to
clarify the code?

Kind regards
Uffe

>
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>  drivers/memstick/core/ms_block.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_=
block.c
> index ce33907bfc24..133282c2744c 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1812,11 +1812,11 @@ static int msb_init_card(struct memstick_dev *car=
d)
>  }
>
>  static int msb_do_write_request(struct msb_data *msb, int lba,
> -       int page, struct scatterlist *sg, size_t len, int *sucessfuly_wri=
tten)
> +       int page, struct scatterlist *sg, size_t len, int *successfully_w=
ritten)
>  {
>         int error =3D 0;
>         off_t offset =3D 0;
> -       *sucessfuly_written =3D 0;
> +       *successfully_written =3D 0;
>
>         while (offset < len) {
>                 if (page =3D=3D 0 && len - offset >=3D msb->block_size) {
> @@ -1830,7 +1830,7 @@ static int msb_do_write_request(struct msb_data
> *msb, int lba,
>                                 return error;
>
>                         offset +=3D msb->block_size;
> -                       *sucessfuly_written +=3D msb->block_size;
> +                       *successfully_written +=3D msb->block_size;
>                         lba++;
>                         continue;
>                 }
> @@ -1840,7 +1840,7 @@ static int msb_do_write_request(struct msb_data
> *msb, int lba,
>                         return error;
>
>                 offset +=3D msb->page_size;
> -               *sucessfuly_written +=3D msb->page_size;
> +               *successfully_written +=3D msb->page_size;
>
>                 page++;
>                 if (page =3D=3D msb->pages_in_block) {
> @@ -1852,11 +1852,11 @@ static int msb_do_write_request(struct
> msb_data *msb, int lba,
>  }
>
>  static int msb_do_read_request(struct msb_data *msb, int lba,
> -               int page, struct scatterlist *sg, int len, int *sucessful=
y_read)
> +               int page, struct scatterlist *sg, int len, int *successfu=
lly_read)
>  {
>         int error =3D 0;
>         int offset =3D 0;
> -       *sucessfuly_read =3D 0;
> +       *successfully_read =3D 0;
>
>         while (offset < len) {
>
> @@ -1865,7 +1865,7 @@ static int msb_do_read_request(struct msb_data
> *msb, int lba,
>                         return error;
>
>                 offset +=3D msb->page_size;
> -               *sucessfuly_read +=3D msb->page_size;
> +               *successfully_read +=3D msb->page_size;
>
>                 page++;
>                 if (page =3D=3D msb->pages_in_block) {
> --
> 2.54.0.windows.1
