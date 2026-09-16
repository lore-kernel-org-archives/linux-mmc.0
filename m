Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E23D7D89
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551415; cv=pass; b=NGOEHNg6q1sYwt7F2+OyiHozUAyQYu1oQF1H6UodON54CGYnkyiXCspgXQ/TkQFmN7MShJVB1bZucbkIjMLoq/CYMcvc0YLW7WmrMcoSCWQg74Pv0LmDZiZx5U4TQXhExOo/VW0ZLYT9ROr69LYpaY9QR54px/TeWYklxYuNq94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551415; c=relaxed/simple;
	bh=c4DGMrBsMajbdwdD2OhI60qkY8BD6VCk+Kt6O56KwVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgHKhBPE1b+DOgyRJV8im+CBkzUzg9LaND6IStIQhlHaO/Hez19uVBNfC+4cgk4hO3ty1EMx/d6zU8zZcb7eERYgNU1K96QPks+NQLryCgXJ2Mdsx+ZONU11q7NdrYJOsARJ8HQcKdl+ThzXC+qYhbBlUmqiWKSfLe3XISTR8/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5b7xWUy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YnsH4PGQ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5b7xWUy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YnsH4PGQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G92pJB3377391
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c4DGMrBsMajbdwdD2OhI60qkY8BD6VCk+Kt6O56KwVg=; b=T5b7xWUyo3gy4Mx3
	20mskpuJTgh7bxXdtlpKH51GqGVtfIjbL2kmUuHDlO0/r2MIShKC4HSc2oNWzVvq
	YBHrhSJ7opl7EvI3AqgwPZMM5eFcY9xL/ioamRPTxFIoP1pt50KDzIG4xaM3H0Kk
	sbd7If46Re8jAC7MEer5wfJkYyCgoBSygZdwXyQunmM3W5uI0oG9mgWNuEI8OVnN
	0+m2W04sMDI5vG7dMHBPQ1ZvBpUIX1lR2zAaXZmWVIVdJvUyJsdOh9KVGw92rQDh
	X4prYTP/uOmFbD8xg7RZjryF5cgIMV3psY9wdCA1Vl0fd2wpAxdDPL4ZxvXFsPzV
	ZV4vuQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqefpae37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 09:36:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so54663425ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 02:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789551397; cv=none;
        d=google.com; s=arc-20260327;
        b=mbZZqQ/McOMHPGMBcBzN6N98rk2zdEbicMHZzGJwDXiMNTQFU3WZ+nueXVVJFjwWMg
         FFfUvwCOncoJz9lw/GqWmg2OTWxmnlEI6ihGzbq1jVh+IQcY+VPo/X6umTDjbaP5q+db
         4sSsH1LKIiRdOpXFNMSISzF4mKOR56psUKYyPRBjph1YR6PAm55Z4RJV7L+kNQpx0tQz
         7WTzQ1OxTf+JW/HGo5o1ZlyatM6t9uW/4bPHvaN+/2tjidb4PLaApSAZLd+nCJ1Dfdvz
         fwCy6k/CumJzerYo+KNxHryCviJJ+CBMaUhZbMfXs2fccuUFl30P8dr9KOHbtZrVbEpY
         uLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4DGMrBsMajbdwdD2OhI60qkY8BD6VCk+Kt6O56KwVg=;
        fh=Nv9y5tHef6GRcJbbnQalQM6xWAkoQr/cWlXnAc6GUjo=;
        b=TT8dONPSGOowtjqy0B2Ak4L2ZnWbV55hbMLbx8qo7l/AydWln7KuDDMtl7YliU3Lpa
         /1Eickc56Y0TdotC2anUKqM499ZiiFLFGi0EbXKmBP4Zyv7E7ktuEWc8YSZ56vt1lgu7
         69lWbG/wWsj4/IBvnYj2E89PJFcZV3Eob9gpV8IM63ZAbTsWmexjArKiCIjwujEgMs7R
         d7OB9ydrGFP/x6Rp2mPI/n3OhiTWsCoPpS6xxZzMcM7LsAQOUDB8VE4kxTcUL0UN70EU
         2Xvm/ijhZIHua6fKysw0croo8oV88DBiFU7Is4mTm8zUT6qBrSgp6iEMYCth76U0XfN2
         /orw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789551397; x=1790156197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c4DGMrBsMajbdwdD2OhI60qkY8BD6VCk+Kt6O56KwVg=;
        b=YnsH4PGQ8FK8SC2O3Gtd3XIBxo9J7lh+7RAzsQugHRm9Pwp8mEqfoyQ/2l5ccfj/1/
         MUMjR7e2DPQL4ulmmFT6seT9ars4q/gG/iyxuLFK4Q7y2yCu9GylLolEl/Wg13ctViFl
         0CHhX9pEQTFPl+mLMg2lu5Ri1NricY006Zb7H7LZzp8cMgF5qn9mBwKJWa1DLvL6xWSV
         7HsEAogngSGN50++4ypbzZOqPSwbKC1U6x3Ozy0LXSR1cbSYOYclOmrReINlA0YBN6PH
         uauzWFmNN+Qk1pyhdnjC/HQjFy6X/yWJqDUrkuqZaFFDhchSOpiG4eZOm+xBNSu/EnzO
         oxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551397; x=1790156197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4DGMrBsMajbdwdD2OhI60qkY8BD6VCk+Kt6O56KwVg=;
        b=oUK8goQq11VzMb7vuCt9cC4Q+mPKfJameeBtE7JsNcG7etGT+yDBamJIAX0OdHb07C
         OJy2ScGOWuYRj3xRU0SpUuXsNabgkAX7sMjXoCjPDATfKqIs6/2xpxh36gmeZX8an3O+
         E8eC5HbnmioYOWLxljWc3o/0O56Aftzkmk+Bf9YiUOhNVNmYvJ/uH34yBrOQpMKkfwjh
         D8XopzuURcTBx7pAtqkczykyNtLTtZGLkAwBjd/YBXnXhsN90P8R8fRmQ5nToxhE59yO
         67oM+uORfCdqqsv5+i3JgeClcoDy9EKiGRwGTZ6lB7pg2i5otjvXa9Ei6LQqYHRgCgF8
         mGKg==
X-Gm-Message-State: AFuF++nM5Ozt2BmnIRE/IvcJ2oRNa69GvirWoAeo/U4VTeNp8tbbwme2
	ntBq8xhL83uGtsg5hrqQxaje7tjCI8PaIG3Fgz2KZvr3b7dMqBHdWxt+60tXCNq1t324S7p2ST1
	x55BmKxxp5kU06hUgFlsuSwmg82YcVtDe8Qbj9khDrqVX7vBj3tNskCMe0aWMpSgDKIrr9R62Pg
	qbcdytsOtCcV42pUeTk3ZXMb6ZCLaFiU7/mF9b/w==
X-Gm-Gg: AYBFou06Fyif8WinAeHDfSL+8Mi8VEQ0Lr5ooZvF3/hR2KM6QVFQ/W9McyRPpmDOQIO
	FM7N3bdaMseAb7eXLt9jFmgM4Oo5px/7vJ3Bw8jjfs1Q+EuBrfHL65yvqG85UzzwtrWt4NL3b+O
	2US7uQ3ndWQHVg1eYdn4saJ4qWYD1fpVQJlCgYT9G9uRKU4yQ1OI+qZzffnQ==
X-Received: by 2002:a17:903:22c2:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2dd8e52c3aamr36286985ad.15.1789551397186;
        Wed, 16 Sep 2026 02:36:37 -0700 (PDT)
X-Received: by 2002:a17:903:22c2:b0:2d9:3083:a3ac with SMTP id
 d9443c01a7336-2dd8e52c3aamr36286545ad.15.1789551396701; Wed, 16 Sep 2026
 02:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com> <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
In-Reply-To: <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 11:36:25 +0200
X-Gm-Features: AcwNN1URMFDti_qG_vPpRruVZwp168EX0dKhlyzlmVzuq_rdnS_nPLrIHlUnh0s
Message-ID: <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static functions
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEyNCBTYWx0ZWRfXxpJZnn+1OsT7
 PO6qORV2d1EdOjNnW8UitEblhz2SL6QvoYJPhfLoHWeV6dT7BAY9hj7QSXlawbuWjkaCczxqwV4
 V8Z14LDJA5DMc8wn61X3hxCSY8cuCtU=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6aaa6325 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=NPqBZDST3jB2sRw4lm0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: Fd8sDfpDqCSJWQMWAQARIcU47A9nn_MA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEyNCBTYWx0ZWRfX1hKqe9XB8Gfv
 LjK81ZhuKNNiJq95V+lyyiGSGvjSMauz4LmeJMI3CB3kWuZjgypMXzToRFgLsHARw+SBVuyS1XI
 dofy7nYx97lGxfzxng2B3oXqOsc4no61kn/n69wVbwGF8t4z3KMNAQl+0hqLOjRzuQrSQp7Eftc
 LQhCsDURKh8RnCQ1XITM1r44A3h3uaOc8wlIZbl59YwP31Lc1VrPpzxSqvVYbvjvH7rBJxjzdfj
 EBdDe8YWLsB4V7/S0rzoFpuGA+pXP1sdksTZUMuyYm+xXr7Edhn0H+qya7xgphEAfGCSoNHFbGq
 sqW+bWnYH0hn93FaPEbXponbJtc/9QD4xlOC66/VksxXP7DJDXaLg7JADWZO4Isr9OSCCZEgDNM
 OdXz4mCUpEWiO+vNgSLSoY3wNLNRt8UVJKdnnjACNe/WwjoYL2qMVhbGP7hRndg43AE0INc4mE6
 JznBp082SkOXj9PJTRQ==
X-Proofpoint-GUID: Fd8sDfpDqCSJWQMWAQARIcU47A9nn_MA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160124

On Wed, Sep 16, 2026 at 9:43=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Sep 15, 2026 at 03:20:46PM +0200, Ulf Hansson wrote:
> > From: Ulf Hansson <ulfh@kernel.org>
> >
> > As there are no longer any users of these functions, let's make them
> > internal to the mmc core.
>
> Why would you want to do that? The devres helpers should just be simple
> wrappers around these and sometimes devres just isn't a good fit.

At the moment there seems to be no need for them. I would rather keep
API/interfaces as simple as possible, so I prefer to remove them at
this point.

If we see a need for them, we can always add them back.

>
> Especially with the work cancellations present in mmc_free_host() (which
> I have pointed out elsewhere should not be there), a driver may need to
> free the host before tearing down other non-devres managed resources
> during unbind.

Can you please point me to such an example so I can try to understand bette=
r?

>
> This may even be needed for greybus which currently destroys the
> connection before freeing the host.

I looked closer at gb_sdio_remove() (the greybus sdio driver's
->remove() callback) and I think the problem isn't about freeing the
host.

Instead it seems like the call to mmc_remove_host() is done too late.
To me it looks like when the mmc core tries to power off the card
gracefully, through mmc_remove_host() the driver has already moved
into a state where it no longer accepts any requests.

>
> I suggest you just keep the non-devres interface around (after updating
> the prototype).
>
> > While at it, let's also flip the order of the
> > in-parameters to mmc_alloc_host() to be consistent with devm_alloc_host=
().
>
> Johan

Kind regards
Uffe
