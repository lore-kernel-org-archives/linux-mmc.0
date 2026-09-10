Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19D4BB29F
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056360; cv=pass; b=SXoDGv/xD1qT/WkWeYGF0fDTqJi6qfuhhwwssVXNiF32ajgdsHfSqkxKINIf6T8YOncTAcHqG6am1oOokjaZ6wpF0+tepMKSXfsQoNANqfBeQxUwSNd8yZeTi0aqKHxQWr6cCrVp3RaLJoHixERhwDE98pcjCvxaaMgZhBTrfJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056360; c=relaxed/simple;
	bh=3iOwpVluDzsXS/xAldAolUm40X+EsqehUJGmAtlu/hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYQer4Nh3yc5t15JeN737kCfeSMtE08w+QzeBdF9+CIB4C5mo4+ZXEKjr7sPAG6nsb85pKMVF4KZD4wbVIo0W2zRHnS721Xeqkw1rbAhKOZLZ5Fix2byvApBe/muoiXwhuCQiql9jvYkALO2C+ENPxOD1YUg/vOg+2p8o0Vhjv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWKFWFpQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gi0qql8D; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OWKFWFpQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gi0qql8D"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4ZCd1186700
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X1Bu/LYRl73Dkkvy54LYXfG709cEf4Ijhpujjjq1ldY=; b=OWKFWFpQrcZc69w3
	czKY4eALvsME0nCyaaPtffkJGzRp40Eou7atqQPYmdV4R3dzXKKe6sihMw7aPByn
	40mCC9ZrE1e5PlLXm6XPCnQJLpYjdEhkYjLL4JVu3a6J1mgzVmwWsGuJHFDoaKOA
	+Tckfj6F/bLE8rqTTUOMSDsxzESIb2h+OvT/KAR7eMpRrl+7GF3gv7Hh7zBN3kYz
	MztM6jGzZndWXxFH2ehEc0jEagYtUpN/z4uINMRei0gorSIVUb2UEJfkvdT2Gokv
	wjLq/3c/3GcIWLU603FwXtyVBQerBS/1q8VaLlrWfhguXBK+m4iet2xfKTaHcb57
	F7ajaQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkraka9fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fb956002so105921015ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056354; cv=none;
        d=google.com; s=arc-20260327;
        b=Q4mBp2V9MdH7M7MjeiuWYCfhQ/f6r4GAmYaSoPEAocez074AvtDcC9ZH+8qLMIPEff
         HNAu5/xKDAodnDgr/gg/F1CxSWeghs/qyCNmFeiRni09XIpzHLMy+aWt1rVL/LEGa3Qu
         Vb99Zvn6wwOkdn58diyFWlm4IAKtfhNViaxlvyj9DDy6XnPyBTkV7L4njgAqMijwgdZH
         ZpPqoIm2hLdV560L70+jJBXQ+9gKDVhAhU1MgGV3kSddp+RRmERNoGWMhDt+0MA1US2k
         KKwEKXbLR+pFx6cLXrdlAJrj2L6SDWpFzndTAp2xz8vzqBlAy84rKaSa5xaVgpQQhtmt
         aF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X1Bu/LYRl73Dkkvy54LYXfG709cEf4Ijhpujjjq1ldY=;
        fh=6Y1reOoGkoWLQBPagp3RVs8eLZ72qnIMV0ObE6uNKX4=;
        b=AQHUExA30//ZPjajja8Ib6B80wGAaWdEHV1Arc0evRLJXdttiUJ2fZARgBCFbd3X3e
         40j8i2G6ukqIe04q/fZdd27YcnOKJ2nL5JkQkoWcakQyR3+xWDZcJIjQdiyubqwklNqh
         QrEz7Q+iVBU79igqtFj2FSPOpVVGVKg0UcDg8b6jUuHKW2qBCeNsPTSO+Ny/URvIPiur
         thaQygHrRx+LYZF3P+HnymIwgeMW3RG+fF+uCXllfAIN5ngkWot6B09DHk32BkpijiuH
         1yQB4Odz0FDyJAcPrpr2TF/7tG/sVw3JWSbohhh7EFjWC1jGrhd2vnctarnj/A+bkFYI
         CWKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056354; x=1789661154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1Bu/LYRl73Dkkvy54LYXfG709cEf4Ijhpujjjq1ldY=;
        b=gi0qql8DWzjjer326uqM3HztzXPMvs5ZoISXkp4ycnfwo0LyVPRDIX2i9LJ7fmuNC/
         NGnnDJT5AJVvzCLKGURQjr2I53MGSthlfOcLdi+Y7l6hZLZiKyGFQqvLs+ntUJ5K3oHf
         /4qfChdmIGx0Stys99QyV5Q0o0+m97emMbU3snwg51+vUaHvj40uYpIqqie3bRH1acUk
         sh8OTRLHsWgxsRbs/o4I2plUaK+E9FLyIQmAu4QI9V8aJzBf4KKu3pDDVxvK13BmL5Jg
         KaVZsXPnJWyscq+VCFB2i0hDH7sukCcU4S4WozLgDqpX4mvB6vnkThaIeGJOZPAy6kDa
         aeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056354; x=1789661154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1Bu/LYRl73Dkkvy54LYXfG709cEf4Ijhpujjjq1ldY=;
        b=nxUqGHeQBPOwo0xFpBivCU0fapg0ckisHhwLbeU0KA+TAgTL42iEZ5hVrKMdt61GcG
         o3PwRyQ8+hfUmfkWxLLMhX+MV7zWcDXEa8R0YLGMr5SNCZ3qWpiCHqraPwWTkNZNTa6O
         FgjQifMvwcTwlDvKdO+pGY1KCKEo7QmlEUp3LZ26tJRRxrEwpmyicAXMFRO5r2omXMVT
         8FHr2MD0lalCokEArQGS/kKl+44QZs6hgckTjHyNqbquGmjn/c9y8ekrmqDOMwtFzmZN
         XGTM/FNFNf1i2qiBIicP4mETvnLkQAUai2JXW4iAfgwu18tUnxJegpaf6gimNbAlVAMg
         z62Q==
X-Forwarded-Encrypted: i=1; AKwUvBwO4qPG6Y69wyZ+S2HhjQVVblOFpBhM4MEdDSRU7VmWJnqwUiqwPFehMjI2FSCrc+WysPuK8Z7g0KQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lYHBD2SvQlhoHJapoENOOBchiR4BNyLxcA1s/U6W3z1AqryQKT
	EaDCozaTxsIq6l8N+fSvvO9ux+hfGIFiF6sCyAszV4H0559N8rFzaoj0w+yDnmTNAoRdnM6/mLG
	4UqvC2mNKTLw1ODuo65OkuTsYtuIK0loWec+7Rc1/1yTTReO/v8cfMo+Vdflv1r3zhLs5+4k7t8
	iKSA/LegFjeXxu0qXlHjJFp4ZPkflwPZkWnbQDjg==
X-Gm-Gg: AYBFou1cylyXG47mqSBKU/iXH6DB6WtXLurKeDFrtEncWBG8AMWEw8Ntmyx9f6H073F
	IUeIi9dVD7+r73/4pjYpDEF2hTTEnxMH+DAUMBZWfAk0+0GqFDwdqwp2d6XHp2TyLA1rooxr6zq
	VHGtHsrh0vRdIv+3vPKoMzvo2c2AtpEwSoNGsAqG1CB56aYAKXQs/bv4euqg==
X-Received: by 2002:a17:902:d549:b0:2d9:32ee:7b83 with SMTP id d9443c01a7336-2dd2a1ea649mr1642565ad.8.1789056353593;
        Thu, 10 Sep 2026 09:05:53 -0700 (PDT)
X-Received: by 2002:a17:902:d549:b0:2d9:32ee:7b83 with SMTP id
 d9443c01a7336-2dd2a1ea649mr1641995ad.8.1789056353149; Thu, 10 Sep 2026
 09:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1788526382-45113-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1788526382-45113-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:42 +0200
X-Gm-Features: AcwNN1UZ3jKBzcNOBYINezQ3C7x0RueUlvm3oo4_TB_hS_N14OUKLLauSWJ6_Iw
Message-ID: <CAPx+jO8hj_VJBdWg_6evrWVVF8N_39k1dbpV3O_aofisNZbY+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Close the device fd on the return paths
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Avri Altman <avri.altman@sandisk.com>, Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX01vmdZW5IdIp
 CK5rnBx50MupL1GlsvAAuiX/924JODVSkj0q5mqaRgv70YfcYUaa5PDyk3aCeHjokyEIcDdx1TS
 rUNbYQiM/RCs9698rxURam6ZKa5Mwos=
X-Proofpoint-GUID: Xa9UxAy8eLpXvLQedeHGcZTKa6rfsCsA
X-Proofpoint-ORIG-GUID: Xa9UxAy8eLpXvLQedeHGcZTKa6rfsCsA
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa2d565 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=s8YR1HE3AAAA:8 a=17l7gqAnU1oj5PDviSYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX5B4lRuG8QLLq
 GwbzAUzkQfzJ0Zof6YQHs+9DcM1U8KfO69BiQYUnEeVUXlwu3vxnZK2TK3XIlmHLJ1YRBSsNw3A
 0MEnXoCXiG9Rwdt/ZeB15FAXcX++aVfLFCT5u0ZXsR3C+R8Cb8Y96da6ZgoSs2cLgiRiuQZPFXG
 8YyIobCsGh0kzutMzzEFqI3PvzNvHVKYqQc6juqDlwGlDQqefMZtSxSi9N3b/SFA9MM9QnENyma
 nGuunkx3pk8cW4flDD5VpyZnrtJOL3oF7PjPDKgIDXLE2Cb8yS0vx/Ij6rDo/qIOAvwws5JTncq
 OAAPR7QIS04PK+iZtS0P57AX4xVDPBz+vhS2F9JdHEmZ50ch9bWX76nJP00YHBm1gEKwU4RB6C4
 0JMWa3uLmOu+hHrhfbVbkpLjBo+l2ygSg7E14Drc9S60sUS2b4P5IYxRTmuIokkO8UI9tGC8BQ8
 iSeaxQgI5HazyzXuwJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100195

On Fri, Sep 4, 2026 at 2:53=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>
> From: Shawn Lin <shawn.lin@linux.dev>
>
> do_read_extcsd(), do_write_extcsd(), do_writeprotect_user_set(),
> do_create_gp_partition(), do_enh_area_set() and
> do_write_reliability_set() open the device but never close it.
>
> For a short lived command line tool the kernel reclaims the
> descriptors when the process exits, so this is only visible to fd
> tracking tools (strace open/close pairing, valgrind --track-fds=3Dyes),
> but it is flagged as a leak and would matter if the code is reused in
> a long lived process.
>
> Close the descriptor on the paths that return to the caller. The error
> paths ending in exit(1) terminate the process and rely on the kernel
> cleanup, consistent with the rest of the codebase.
>
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>

Applied for mmc-utils master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 43dcdcc..0692505 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -550,6 +550,7 @@ int do_writeprotect_user_set(int nargs, char **argv)
>                         exit(1);
>                 }
>         }
> +       close(fd);
>         return ret;
>
>  usage:
> @@ -1442,6 +1443,7 @@ int do_create_gp_partition(int nargs, char **argv)
>         if (set_partitioning_setting_completed(dry_run, device, fd))
>                 exit(1);
>
> +       close(fd);
>         return 0;
>  }
>
> @@ -1589,6 +1591,7 @@ int do_enh_area_set(int nargs, char **argv)
>         if (set_partitioning_setting_completed(dry_run, device, fd))
>                 exit(1);
>
> +       close(fd);
>         return 0;
>  }
>
> @@ -1656,6 +1659,7 @@ int do_write_reliability_set(int nargs, char **argv=
)
>         if (set_partitioning_setting_completed(dry_run, device, fd))
>                 exit(1);
>
> +       close(fd);
>         return 0;
>  }
>
> @@ -2170,6 +2174,7 @@ int do_read_extcsd(int nargs, char **argv)
>                        "Please check sysfs node '/sys/devices/.../mmc_hos=
t/mmcX/mmcX:XXXX/cmdq_en'\n");
>         }
>  out_free:
> +       close(fd);
>         return ret;
>  }
>
> @@ -2202,6 +2207,7 @@ int do_write_extcsd(int nargs, char **argv)
>                 exit(1);
>         }
>
> +       close(fd);
>         return ret;
>  }
>
> --
> 2.25.1
>
