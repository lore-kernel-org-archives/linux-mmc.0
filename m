Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E13F823E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689677; cv=pass; b=UdVEbjjxCSDyK/eMafW+ynukr9EHFdy29wcYr0ooV/V1zh5UrF6bddJ9ccktdAF9Q6jbHj7HTFT952RvYAM46e+qTOwScOGe067uDozEmMjlYrV7k2JVj9+gJHcftipfgyGzAU2gWmBiTWLo7IImMaQRall1JMpdFRBCCKkjyQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689677; c=relaxed/simple;
	bh=6V8xqOk7RhmH2G3Vm3AhtGc5cjePutnffUELGx3PwhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5YpnZ+z9Mp9L3YjonyvDHKrAC4mG7H5VUwrENAUWOPfqs9uHUxacyghkMWj1E1knjd3xlxcu+1bfVOQ0PHQ4CdogccMEHCkOyhtTeubIoRtQ8u/dl9X6C2JROwYtH6pOQLJTRlkkel/k/rvQ4fMHM3KR86uh2gR3Oqq1wRnDsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBIHXK+W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FkKIMe2+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBIHXK+W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FkKIMe2+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD7ebd732707
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LpfuTQwHo5siTId3ykY8QQlK6S143X9BYS8aA/TieiI=; b=SBIHXK+WT6xP+2xC
	rXcB2zbugB2PO4zKtn4eypADZyyyaeyosKq3eNM2b0BJ1QRxF6pf+8YD0kdalaMx
	O6Mnp4KtU/++TKB0+EvH4RWIoPcz4ohxhflRL4K9qfOQtlnGWja8sbUXdEaan93q
	mXR8Ah01QGNK9LcsU+Op7oY1DLDpBNhO829JWGOOexqSbMC4/vgRhEXQGRrPgmOb
	+SBu/edlSQ/NMyeMTi/k9LRR/AnKEpt+VoQkecZmyeaebY+gqaDBSBKpFFA6SxYT
	+Ck9iRiQraHN4IVTJH0y5I5efTVLx5j36comNq33bL4hVwnvGtAUQYNFXeKU+2Kc
	Y3o19A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24vcyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:21:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5939so116788385a.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689674; cv=none;
        d=google.com; s=arc-20260327;
        b=EXXg3+8LFxnQxv/oOejGKSK2DLj5eEs4aPP2BEk9peasGBw9KCWlY0+Pz+wrGfQrQP
         8NQzE/PH+sCOY3uRlFiB+63xwYPYw4NmWM27iIfwDivhYTetiPSeISHFFmO6D2vdicVx
         EOjRkU7N4zhCTidHQ4MVEQYEe2KgLc2hr2MOEiRMDoGwMOSmsydoZWdLMGtN0bqKu83O
         uzGn3Yk3r7In4unk3eKodUZHS1F5zlTm/4LA6NkoMsPmjyIZSucNDIMyGSxe7DWR4Eye
         F08pErYARpjztJHXyQt49Ey4O2PY9o+K5/jn2Mb8FwBwxFFJYEQ+tXqs7PqERqrDGOLk
         DBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LpfuTQwHo5siTId3ykY8QQlK6S143X9BYS8aA/TieiI=;
        fh=BI9MK0W8laxue4uFWXN+6Hy9fUh65hrlKHgVwMOo/hU=;
        b=cZ4aKMk5QOgb2UbPHVUBe2DDlGszFwT8Kpm049/Yu5psmkYN8PDYO0FG4oX8rLwOC3
         lSeviWMFCIdPelzo4Din7T6I5MmE9dgaRGk+6Mh1roqJVNsD8/OxayQM4prlzdRoeZmS
         7bx9fxQoduxYvV3ktk6BRBg6qkipB3+offed6H9ppyGvF46xb0ym2PQo1JZNQgFp7cpD
         SaYRJ+7ZX4h7/iz/QWFtcrhT9PKDzEce09RfK1DBGA8MIgAqZDMeVxIqoRtEz18wgCoy
         PLJcgi4yh/JkljiDvwpbHyx8F/Hfeg/WbLfW2GbN2We7+6U8ZyRFxRycOVvB3/xR6rhh
         ihHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689674; x=1784294474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LpfuTQwHo5siTId3ykY8QQlK6S143X9BYS8aA/TieiI=;
        b=FkKIMe2+FTlT/DLCx/qpaZk9YX5FwUVS10xSuGgRkTuM7/iXvWBBSAk+CFtbvFp7gm
         40F3VB1LlZHBUlth7D70UKMZM92ZYsCL+tmzyQBnXYCqjdadUZ+4Vn/GSvdfSuZ/hC+F
         5BQ8zbAonUVJmAnwNqeVUCGWaedBN0It3yNkUGTxvTQYwWiBYlhtRfa3v2hfaxhzLoI3
         fR6JCpkbwLXIc4nA3EQC9+oNr8j73CAQz9D7bOAj+6W4Vb/m0CHxojOaSWCXwaPFYTjq
         /PGb233LIL3HdrHWZdhYsOa3xDYXYU5jbRVyO2Ce4z7ytknYulka6QDNc6VomZjyzosp
         wXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689674; x=1784294474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpfuTQwHo5siTId3ykY8QQlK6S143X9BYS8aA/TieiI=;
        b=OS6aYtcc4NoWckW2xoxJdlDiV3FvS/gy3wv7FKdnq20uUkLBlKsMi7cQFE5ukGmkpK
         1KRenuW7eA0y7X/xMhFmsQWo7E2f7QjCg6JA9FAlSrC60zgnjcj9G8RmQMOq6HDejNLs
         8KExwC0DtVkvGsFsMX5cw0uXzg6ZWQ9eJkQS85kIPPWMHTPzq9vGY82+E15Yo/3gPtWT
         7WpnXApXqCf9l68HR5awlLfJfCJoM7oB9z1pjC1f3+sK3e9MlEMOIvQodTmTEvEmP8ds
         hVdYhY13V0PdfW7qkrZhL9Geu26N3i4Jv+YwIGoo/dCBa0WMYV6Pvfv1ye82lRBIskSi
         FVBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqyk6SkTa+xz5spKkwqSxcvLghXDQv9/PhIpH04DkJbquK6AJCehvqVxNBrDvFJ3F6E981JsEm2M7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuny3AVOECsHAAXoH8KSoJp0GXZc7ufc3dYyaOVmxiYGB+zB1P
	IYeKcB0Cpx5ccVhXF4KP5jZzWLAlw24TH/7Z8HLmFMMUVD/ZL0TW0J0unVZDZLiayh1bWX4Ai78
	9402BiKvsxTeoTerRkngXYCo2xc1wfsdZKCq0g8wsqCMMMFW2bp3xIqcC0p3uvL6b8WgY9G8n+9
	2jolHeEJuLw0D/ufgOp+45/q+QhQyLarpiYRbbPw==
X-Gm-Gg: AfdE7claTMDgcXpx6eYDqzi81Rp7w3zy9bs2ceQWZiiem+sId6BUBKWtUXkvBDkShdD
	6fns+eElU/1gC5JEbeQrVL3QmQDFpU3xCqViQoXoe65rC4UG653wsN/CZlnOTgV9yvVW1cpqHPo
	8qWXfyyPcQiUqedVpqSiQWiJsC2yYi65g8ToxF9WSuBovV4liopH32h7ONF0JqHpmxwfV3
X-Received: by 2002:a05:6214:2a89:b0:8ed:a980:6b2c with SMTP id 6a1803df08f44-8fec6939f2amr130753906d6.30.1783689674416;
        Fri, 10 Jul 2026 06:21:14 -0700 (PDT)
X-Received: by 2002:a05:6214:2a89:b0:8ed:a980:6b2c with SMTP id
 6a1803df08f44-8fec6939f2amr130753116d6.30.1783689673770; Fri, 10 Jul 2026
 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C7A17066496D0ABA+20260706092501.853376-1-raoxu@uniontech.com>
In-Reply-To: <C7A17066496D0ABA+20260706092501.853376-1-raoxu@uniontech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:21:03 +0200
X-Gm-Features: AUfX_mz-FGVE1w_SgIA8dLQvsQEvCEr5v_7aLi3gvIdVYmmAQ0d1SAgsTGv3eyY
Message-ID: <CAPx+jO_b5daCjCXBSB_j4BqWwaJ8tKiLoD5VutHF_F1Dmsb3DQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: reject invalid perdev_minors before division
To: raoxu <raoxu@uniontech.com>
Cc: ulfh@kernel.org, avri.altman@sandisk.com, beanhuo@micron.com,
        shawn.lin@rock-chips.com, jens.wiklander@linaro.org, kees@kernel.org,
        benoit.monin@bootlin.com, marco.crivellari@suse.com, b-liu@ti.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: yw1YkflyaKDQcCEzun1UOIvxtUxKKOtu
X-Proofpoint-ORIG-GUID: yw1YkflyaKDQcCEzun1UOIvxtUxKKOtu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX4CFgghqDU2R5
 e+8ulq+i/Cv3iIQqvR/cZROfQYBUCFWclcg3ySLIyzqbC+/HQTj5adu7Crm400lYeu2CVEJoTV8
 /cLzSvx8oO17N5/nmsreBGzy1V09wf8=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50f1cb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=iHwBjlyiAAAA:8 a=RlWO296T2keaPHNohIMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX7NjWHhFFRuMV
 Bpm9yIYJcTmqKeP4u2JZJmyvRJ1bqKOFxJQ/1HltrFYI1SP4CKn5WUoQVkyAnMKqP1wb6W/HzYt
 z+whq6TVhfeqbWDf3Z6Z9yNZjJLdifFvxORlEYx8n2ommHSp5TzWEoFHDFuXqucMpi+LWQdKJeB
 OO0HTF/f1LY+i2P61xT26hi8Wf/Q5iubi9ndRPyabPGLA8b3Ce0SaKjRBl5Vi8s8qFWRYdKrqmX
 9eYiiqBHrz2JrWf6+LO/YnPd+rHV025Di0uMi+zncazId6vf7bcQjKvNkpAk13ZAk+BvpSaO2Jg
 cmrVaofCdZeAYDReB8LJmmG+ljQacgvyh41YKTYHof1UdsE1uwVJrsIC6dylBqWN+W5uJghfyno
 5DN3VITZTrUJ+tB0Y14w4w7Gp6l9eRxH7/F5Fx82jvipXO56deQ5SVA88Frb5CK2QfrsHiJOlyV
 NLALCPp93cm8eusTFrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100131

On Mon, Jul 6, 2026 at 11:25=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> The mmcblk.perdev_minors module parameter is parsed as a signed int and
> is used during mmc_blk_init() to compute the number of supported block
> devices.
>
> Passing perdev_minors=3D0 makes the init path divide by zero when it
> computes max_devices. Negative values are invalid as well and would make
> max_devices negative before it is later used as an IDA limit.
>
> Reject non-positive perdev_minors values before registering any mmcblk
> resources.
>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0274e8d07660..9cfd27c90215 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3338,6 +3338,11 @@ static int __init mmc_blk_init(void)
>  {
>         int res;
>
> +       if (perdev_minors <=3D 0) {
> +               pr_err("mmcblk: invalid minors per device: %d\n", perdev_=
minors);
> +               return -EINVAL;
> +       }
> +
>         res  =3D bus_register(&mmc_rpmb_bus_type);
>         if (res < 0) {
>                 pr_err("mmcblk: could not register RPMB bus type\n");
> --
> 2.50.1
>
