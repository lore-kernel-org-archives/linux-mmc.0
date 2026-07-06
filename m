Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194D434E3E
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352869; cv=pass; b=D+rTRecmohqAJ6qM4CA3gA4EmFUyFanwpNlDHciOLwswZQlu7J9EPsPcPIM1F3feLHBUP0x9+kPeFtMDQtU2dP5fOhswMtzF7rHgH32U9FpfDqy5R9WI3RrIjXAgBS0kAwl0CadDIUl+fzfsXfJjSKHS2sOrjONF8hwI8OtDJWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352869; c=relaxed/simple;
	bh=RKcq82o+IatSlpbgbrVf1lQcaa7ltx+vix63gvV+M4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUD0ASi8P2ZqZneH97vGlDebQBI23Y/yMXjFQlHlUeg/wF21hkBxDozfvMcOQ5qkYpByZgBHA3xMpBKstUXsvfh2uYfD38BcVjaQAqNAKMH77cvmheYTDQtTTxblfuAVu2sjE2LSB1G5FCJAbtASB3SmbEhwdlB26pkLZuoxN0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErDesEsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jw0OsGhz; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErDesEsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jw0OsGhz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6Ki981547
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=; b=ErDesEszR03MGw5d
	zYUoc7iSaLjFtyM/iUV3KX526SOPJAe7dsNLiIpfz8FF133C0yduRIQzvnDGn9oN
	Zi8qGhzu86kMoL72R4daHYlYA6G2iZZS/MVuT2HHNJulRBfFJRXQsxK4dNeWrM8d
	8Wo+KVKoSwEOn7YpsWFMPXfSCAMkTFv9FHSdUBSpXZUsRQCxMrL6aESWXxcvEZIV
	Py61iOFd85zy4aDaTBCvambabJ1JbDPvF/iC2IqUV3WKccSrhrL/DiEzMKpsjNje
	Ko6+EtEGNe0wNC+bVea59J/Tg7p39LCzrnHI/eIaLEwf+lQcpaM+bO30PPAOy29e
	QOoSHQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsr7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8eb8914e651so63242986d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352866; cv=none;
        d=google.com; s=arc-20260327;
        b=iY3Yxb1cn3OuFgTMP4RMOYmOdRDl9pqjTiI6gm7sgrYEuL5SPGIOUEybkJXhz64kYT
         e7Ga00yryPpOYzWlYRJleiS3zLcpFq/kD8u1ys34vU2MEeStDWEwrlWzWmPcBKSYLB7T
         1zjC9NimPT/ZOf2B7XkacQbwQ9hm8KyfyCvYSsLmS4PErf74/CRi3uikTWy4LsQ92kCr
         Q240G6KJGjUWS1ITlLmv01ZUzPuIerNs7siSD5dlKFfWHvWpGEJINVzmp4Xk8gfa+DbS
         FMyhlP+g99EFpvnGpi+XMSWeOmq+pfwQ/mc0tNWzx+wF21BwGAQOGsQZObeR3WU6WbmP
         tVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        fh=XBaaCSd2wHg6c3SvumGJfUsoLXd/skleNfdQfUPiKdo=;
        b=G4ksa5hj5Aj9dvIpB1ENtDTTXJeSv2MjciCDbr74BYhjehP/sCSMlB0ovUzbo7NSnH
         d93RMBZo6k4+n1Ey52qkvI/fJjQjC/etsb4drrdMsGbF2vs1dklkl01nq5ucpo5qcNte
         TU0lvi3hRwDzhHRTeJeFwV2I5SinHiBvU8xAOkHaBnd7f2FkSyBuQycJvkpHmxRFksDL
         jsfk1uinc4K8z5TGVlhkL9HeYlzDh+CIgw4M5yZLJcvrds9UAsTMXhhc60sonBFH6waD
         j1PuoJpi1Zus2Pjwp4x2NJPQyhJ+Z8p2BQEbyMydRwWjy3n0nVyqlOaQp1hKTYzFiWN4
         TBlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352866; x=1783957666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        b=jw0OsGhzg5FZ5gDM9B1npzKnXAjj+jW6kOKssetxqScjWmTYE/VbT59EwITKdSCm/9
         tkho9TowzSVUdVI72poc4dlJHywRRX/5CRG61Hf1Cww/Pee6rVXS0K74v8gpPA8PvaA+
         ytsNKpsqPCX8D7CYKg0K0Fc6riOMFfpb5pdB2s7BwJIXaOfLOkJb0gso8tk+krCdtSDp
         1uhiDw6Zv4ZpSLBW6NexhPThqCodhyYIODvQ+ghix7YRFzg0L2sOpOOwzXrIEgz8czj1
         N9Ucs1e41SIwFSXDx7hXNfgcfkvSySMykEOJMjA96bhdVO5Y5nerbYEXzWuGdkiNJjy3
         AgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352866; x=1783957666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        b=AQ5LIJ8b7urpWO/RZvhfUXqZiRHBoibahUzuJ9zrigO8MpJh4X+sZ9K0Y7xH/osei5
         FAlPoYhkrlcZd9AviVkBUD8jIZJPZYbd2btENUpHi9hpfMxmRV1VNjioRz96IG7VBzsX
         WqO5RCenoJhSK6L8fLeY/96faoyYJN6fK1UgJ1T/ncVvjjRmqpOjcLUQs3CD225rE8Pk
         a6nR7ThalIn0mTprYsq4LqJPq/jcQdF/HryFcqRoL9oQeE1JQeN2i3/vuj1UeqbPKVfl
         bvWF8Vm0x+8X54TTP7KhzmKYGpFqFgudMwOdsdNeyDmBCMZ5M4nK+SEBD1DrHTYAGFgf
         70cQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRvsdSyjGpMFZh7YHMnrCGekF9K8WYeAxk3M4ctdgq0HzTANTYI6a7bt8is1Roo4Y+Zq66qU5RBS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+pzHiVDQ/yXgbTALcSwCCPCf8iAdblCUoWazanIGzZFxrKD+Z
	Ebw/KJmR6QvQ+T6faPlH/+1Z2Hcke9H/IixWZPy/WHHWy5Ui0qgwk0iB2TYtgmHPKyWCyEpDl6b
	fDIAn/AqjYXLxFKblW1Qeo/OADF8VBVpouEcQDGFrYEAKLBeCPbiuj28COnopnn1kaBlhx0RXGw
	KtnFcDbTNgLNQW3TQi5XfR3rCV2ojO9a4LJjbf5Q==
X-Gm-Gg: AfdE7ckqtn+lq1BaDOBEQtHQBrG28BZAxJV+EfAfMFGv3deBhxB1HhkUv5oldeL037x
	L5OkOWdpguAV4Hu6jg8TJKTsYjWP/qN/JQJZGj0gQ9Z1KoSZhZUTTQNaBFbbrltWAxiquR1rrFw
	bGkihUd/amT794uHTFUnJqYytqen6ipEYVPrhosWsZBjwF6nD+KEtGWT12Hw5VtsIn1o+g
X-Received: by 2002:a05:6214:19c9:b0:8e1:6c6e:9612 with SMTP id 6a1803df08f44-8fcb2a85d71mr13055706d6.22.1783352866095;
        Mon, 06 Jul 2026 08:47:46 -0700 (PDT)
X-Received: by 2002:a05:6214:19c9:b0:8e1:6c6e:9612 with SMTP id
 6a1803df08f44-8fcb2a85d71mr13055186d6.22.1783352865595; Mon, 06 Jul 2026
 08:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706114218.907-1-ao.sun@transsion.com>
In-Reply-To: <20260706114218.907-1-ao.sun@transsion.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:34 +0200
X-Gm-Features: AVVi8CeAnDa519BBIGFgvcJJMaeYsdKC8qNJU7WmqIK1pBgl7ciC_41RXpYlJpM
Message-ID: <CAPx+jO-oC9eBuejURDanXi8nxeuUAxQcZWJeBRuaqMhoSoKAoQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: fix RPMB device unregister ordering
To: Ao Sun <ao.sun@transsion.com>
Cc: "ulfh@kernel.org" <ulfh@kernel.org>,
        "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "jenswi@kernel.org" <jenswi@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hongyan Xia <hongyan.xia@transsion.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiazi Li <jiazi.li@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2gpdslERxCv83KEjGy7ODMcM5gmvnDFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfXx+L8Ur/jjWuv
 K2HwFCO/edX9O/UA4AJz0VYXbDZ5UulnulRsz91D7KZk7kHVbTaQnVWa0+51GkNv86BsdAfGoJP
 RYKRXziE/A5HsgVTEl4DqS8rrJis7LZByDgQFUYzsADy5RgQnjF2fAvCNQJLEO+sfgrdFvMb3p9
 lZ+ryNptpJeHj4zpkmRdUeOH3y2a/KbOIfGGVNxrUBawZ6jGMudv+a3nP9K71goOssNZnTjuYUz
 U6YkVy3NZR8QUicd09+m3SlEGDVEcLkNDcB69w7Xe1Hedxyy5gzXoerWQcbyI2frKDlzaUBHdre
 i0claV8cOdeTsGU7hnhiIQtRjo4MmpxGY2NigYyixXIveDFleibrsKyR/7UOcug1LEzqA5gHAMa
 x9DyuWY0wyyx0k02+gDtE7yW4uYzD6mbhUZ6PwaftOkVQR4aNf2WJ1kQ3CjqTzJhyjuaxI55Nxt
 yxrNUFwVqe3zg1ZjnDA==
X-Proofpoint-ORIG-GUID: 2gpdslERxCv83KEjGy7ODMcM5gmvnDFm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfXxDeqG3Cvs2BE
 9e728/7acJp9M7HcVJCNyaB2aZ0jtxdWQUSnst9TDC2PQ6FVp4TtmmCCNf4LbjyUul0tNmOFmRr
 aXwlrRGtk4oLwPW6gn/IjATm51gpvUI=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bce23 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=3xJz9W2bAAAA:8 a=VwQbUJbxAAAA:8 a=InJrZTXqAAAA:8
 a=znh_XOoVjrxqlL3qVLcA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=amiGZ1mxdzcEAW_x1qlF:22 a=WwJ7OKCui7YMbFU4sWpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060161

On Mon, Jul 6, 2026 at 1:43=E2=80=AFPM Ao Sun <ao.sun@transsion.com> wrote:
>
> From: Ao Sun <ao.sun@transsion.com>
>
> Since commit 7852028a35f0 ("mmc: block: register RPMB partition with
> the RPMB subsystem"), each mmc RPMB partition is represented by two
> device objects:
>  - the mmc-owned device (`rpmb->dev`, backing the legacy /dev/mmcblkXrpmb
>    char device) and
>  - the rpmb-core device (`rdev`, backing /dev/rpmbN).
>
> The child RPMB device holds a reference to its parent, so the
> parent's release callback cannot be invoked if the child device
> is still registered.
>
> Remove rpmb_dev_unregister() from the parent release handler and
> unregister the child RPMB device in the remove path before tearing
> down the parent device.
>
> Also delete the extra blank line between mmc_blk_remove_rpmb_part()
> and {.
>
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB s=
ubsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiazi Li <jiazi.li@transsion.com>
> Signed-off-by: Ao Sun <ao.sun@transsion.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
>   - add background describing the two RPMB device objects
>   - add Fixes and Cc
>   - collect Reviewed-by
> ---
>  drivers/mmc/core/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0274e8d07660..54a923ba4f1e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2715,7 +2715,6 @@ static void mmc_blk_rpmb_device_release(struct devi=
ce *dev)
>  {
>         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
>
> -       rpmb_dev_unregister(rpmb->rdev);
>         mmc_blk_put(rpmb->md);
>         ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
> @@ -2930,8 +2929,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card =
*card,
>  }
>
>  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
> -
>  {
> +       rpmb_dev_unregister(rpmb->rdev);
>         cdev_device_del(&rpmb->chrdev, &rpmb->dev);
>         put_device(&rpmb->dev);
>  }
> --
> 2.34.1
>
