Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46C42EEAD
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352833; cv=pass; b=LyJZJir5rPYix7vPhoLqUrYXWDeoFlVVsNmEZPwRZNkZSg5jRZRx86CPSyo//MFbBFsmmRVsANkUNuGL/ym8y/XuMUSd3L9IDWcJ4gDp72ckk2ppPc44b5Ku6mQ7t5oW/pXE3nZEZ4Cjb1Y8VCmFUpXPREZJljYcamAQqtpvTzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352833; c=relaxed/simple;
	bh=ZK3umFUl4l3m+TbCatgyuRkELcarGJ4iocTqg7dKedg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/51BDFr4wJQU7P1q/M9o24eZ1bSRS3CUGHZ5mK8mSU8EFu1Y/sE6QA2OEN14IzKUTeXCtSR9Ug2V1LKVzPKJAQKZkqGUZh2yjIQaftJDl0r235aT0NN8IeSK/fAwXhTy/p3ImcoI8fjHAUtF284HDBctguIq8HYATw9Qf21cko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nct9fni5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hu7J1rG/; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nct9fni5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hu7J1rG/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFE6B809717
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=; b=Nct9fni5GyAQ2dbG
	XSC72Az4Wj83teMB6OixCxRi7MKkUOqYxqG1wqBWI7RwAFLxkAWboxxrRWjzQy8t
	niiXys+zQ3W/Uz+s+zkeWWOFQ8ILlTlRqX7wra/0PJirc+NEwoR2ARdPHNU8vZug
	sj/cv0izVU91jYOO4awJn/LAkirikLkqB5S2lHpIy20nsB6NvGW8DB4tUWZW5q6l
	ttnsgUe2ITEhHe274wUxsYP6iO9G5kxA/BxNWAjc3doZLys1BjTwhfBGIao7GHcf
	uUMRJEkJW5Nsy7Cy4g7gQpiEmTa7Ov7emW0di9o+IQoqtj0v31OSyDGVMbeqDtL9
	ax4YzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsa29t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92158791d14so324913585a.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352828; cv=none;
        d=google.com; s=arc-20260327;
        b=Hs+CIQgz0bCfv6oWD8JYephbEjk+T3PfAXsEabRC9APLzCqLpsO8eCheWg+hhCgu5a
         mWLKyVfqJ42vZuz4gxuKIkhkUtCXAwi+910Bhz/odvDYZ9L9oYjH362Hzuyx7c9ZRF8D
         QsIrTlLXpymfuuYsatAfDpBfg9RRa6Ogq6zr2pcDCgwcpSau35Wh5kSGwBU++Zl0HpWt
         7ESBPRlMPNC4wehtXI4SKvfb61r6uIGd9lX2LDNH4vDtWTvkkRpp0AR+nlZv+sJXe8VE
         gxQGV9KZ84YicqfVhuH8ggdXURfE43DYnDC0x4YhlZnDQRMfkwvA2KKY5S4ZUpmv7IMp
         cePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        fh=YVgER7JaMuGyQy2V6KrgMLMFE0QHZZz2p0v5n+T69k0=;
        b=Hfx0CFLr8Rx0fCGluunNF33VBIYVdKqPYSt41wR3kWypyGXKaDWBimbdlFxT1pt6n3
         eseRoRj7Jlb5/lK6GtPF2Mkz8QKzJ4f3M+XdEar0PWc7FFD/QeflgDjZOnRzMoeHSkpN
         xzrDZ7lSKtZK1FL4dqS1jZ9Dc8kv0SOWGomQsN0jWiFFsFwDofbDMPMJIomUbylUfnvw
         JFFm7gHPhPaQgc5yrq0tsYVBgDwuZDzlk4U/z2fy9yKzFAOg+lcKSHzgA1WIFR/MK9ga
         uj7PmKEh1hpeVDrHjdcVkoQmiJ2kn6jdMHJfbJp98ujTM2SiWVR/7P044v679GeKAk3j
         YDDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352828; x=1783957628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        b=Hu7J1rG/nbH3wyFSBWchs95psI6LBeRfjMnk7wYZQI60JqPXXUorm1JxrQVLisKXE1
         Ox3xdkKjXYKwd24HH1jiFy3GTATn7+rBPyntpF7cadkJ+P41LJKN3ghMc1EVO072twTQ
         AbQImrOdwV0JxJYusrhJf+CQLHlBanPF87cJRPjg6iO1vEDSoFdYNxj2Mu8fwMiMm6Gr
         11lV1F+YK0WgbeIxSxyzXr6iyR6mvxpBdO3lj0AizmtSFBXH4mkOxYbUdMOtVjtsNZba
         W27zAyaLXaEAhZO05Y/Lq5n3aY9Qd0SxoLHdBnmZhMNQLKwn0zpv/lLvtVdwPfnIiShT
         STaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352828; x=1783957628;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iQGNVUX0c+xixcxpD1Mh6//kGs2C0OMb65NaHkl0Oo=;
        b=W9DV1Og0ge/oe7V3CCXBe7h3pB6GpAPGFvv9ixtK+3OQWbp42gPH6YXjTYjCvFBylA
         79lbqeJS81Y0KaNErDE1CmjmSNHkoPsTgNN06z0fLa+LYZOu3qMJdS14+t8PfW9YK6ZF
         tUunAh7g8+DEuevYk5wjddiG/L4KBf5NSPd/G1UoS4r7heuJhpKZNe3s84xOWY5FGOlz
         X5FrSy2XgXzBFhgFt+DLzQo/PcgFLL4B1jivmI6qqq8LGkBYKr1NsFTp4sNeenXK4jmM
         +iN6aXdAEdXpLZOGGc5qXFJTJGMvnGIJSMxsRm55cGA9HcIfVrIBFXQ9xOB38AdSgzmS
         pLCw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4DucL6A017IrDqbF/4yrGlElptJ2vmPgmv287TWfUgZGuq3tobqPm4yb75WvlVfmDIlDrMukJhzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzulI28KtxFGqipJEjNY2fqLOXy+BbNBBKwHSfXt+mkICuy7W21
	Jnulyp3RDFPeVkDAnRTW1XLCNse4X9qZtFg9cBpSLSDUAZoU33Zsg4drrnXsqxrxhhHohLLgAAJ
	acQjcHBX38NqznvAYAbYTn4FTkJJEcniK7BjNKjNFX6esIIiljQzyS05jC5n7b4+okD04y+1PPW
	CsAuuFCMuEqx5rOMx1lbcHPCGP3a2f/LOtuN5FUg==
X-Gm-Gg: AfdE7cnrUfjY+AR1nyUqHspVyUBVze5VOCivPZ9/Ja3kSQpPE4pokt7w3bhLHW9ofUG
	3NH2vZhm1h0WMpxKj2PRm8+siw5PvTdmJJZmJbc8fTb6WPi2g8Ctj+lczneQKu1QTASgIJqS3Ft
	ptY6Aku/zm7xJq/kwmWVAIww5bi/pKXf+8EGpm9N7UFv6td+EzQONH1yZlRDYKeC4+NYwa
X-Received: by 2002:a05:620a:838a:b0:92e:72cd:325a with SMTP id af79cd13be357-92ebb534c69mr154355085a.15.1783352827632;
        Mon, 06 Jul 2026 08:47:07 -0700 (PDT)
X-Received: by 2002:a05:620a:838a:b0:92e:72cd:325a with SMTP id
 af79cd13be357-92ebb534c69mr154349385a.15.1783352827129; Mon, 06 Jul 2026
 08:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617152319.957866-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260617152319.957866-1-runyu.xiao@seu.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:55 +0200
X-Gm-Features: AVVi8CdcWzNBLTglm0g3tUKG4yFhxoCahXMX-lM1N-hReZwTQgECqgmyYQF9Ues
Message-ID: <CAPx+jO_ZDDvEGueT-7EMHJst7qoZPJr_Gcnx1Qn3+KGpGjd39A@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: defer reset until cmd_mutex is unlocked
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Olech <tony.olech@elandigitalsystems.com>,
        Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: UcRf4T7FTkF1Bb5HGAIa4uDyocxtmiZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX31YmeG+8RWaO
 yjuU4ASzlbuhuzgPkCyHMvvlhm5AtmWFqXZBghaZxMBAUYiIozYkqCAIjPrB8Hz/NUklvv85VdU
 bIVj1zVRrY2xX38GJPwmgq5B1VUzmNCpPnuDmTyrFhkY68DU4Dx1xdJpLTzLCSGiorKzMRngZpP
 fcFTtCwH7UuKqdiQhqlgn3gUeaztd51uQ68sP1eMv7/jznZHUbP8pHA9FZszw0KSoV7/rjDWNf9
 J/bX+EUJmkAfHBjBhjhMEflXc8JfVdS1admweMtNvArscv1lp0W6V84A8HqqVIlQ4IipTbQDfFv
 iky/OhAFfXzUeE2d1NTKllOaMzhMvMo+jU0GfevzsIzfCmknthmcSAJcLoM/tCezOlzXvZtZ3j0
 rOEhLaEclxunEYiGSTLRGvu4B5BsambCPSC7yhjVZNI+t7zUwnWDL3DvQPxBwKA02oLBxaubi7y
 H4OUDNTRfNQh2KvtReQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXxw+9c3Uqyg4T
 X2pIUVMND1eASCpq9oj5rkZs3I8dT3MnJ4evXD06kg+B0iiE+JusS8Ockr+o23bsEcxnWY8GWrW
 MMglNTTs+esA+4faB1Vh9UfZpuSZ400=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bcdfc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=ubNfKOfgc0bmnuDSWJcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: UcRf4T7FTkF1Bb5HGAIa4uDyocxtmiZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Wed, Jun 17, 2026 at 5:23=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> vub300_cmndwork_thread() holds cmd_mutex while it sends a command and
> waits for the command response.  If the response wait times out,
> __vub300_command_response() kills the command URBs and then synchronously
> resets the USB device through usb_reset_device().
>
> That reset path re-enters the driver through vub300_pre_reset(), which
> also takes cmd_mutex.  The worker therefore tries to acquire the same
> mutex recursively while it is still holding it from the command path.
>
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
>
> The grounded PoC kept the real worker and timeout/reset carrier:
>
>   vub300_cmndwork_thread()
>   __vub300_command_response()
>   usb_lock_device_for_reset()
>   usb_reset_device()
>   vub300_pre_reset()
>
> Lockdep reported the same-task recursive acquisition on cmd_mutex:
>
>   WARNING: possible recursive locking detected
>   ... (&test_vub300.cmd_mutex) ... at: usb_reset_device... [vuln_msv]
>   ... (&test_vub300.cmd_mutex) ... at: vub300_cmndwork_thread+0x12/0x20 [=
vuln_msv]
>   Workqueue: vub300_cmd_wq vub300_cmndwork_thread [vuln_msv]
>   *** DEADLOCK ***
>
> Return a flag from __vub300_command_response() when the timeout path need=
s
> a device reset, then perform the reset after vub300_cmndwork_thread() has
> cleared the in-flight command state and dropped cmd_mutex.  The reset is
> still attempted before mmc_request_done(), preserving the existing reques=
t
> completion ordering while avoiding the recursive lock.
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index ff49d0770506..1c335e070741 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -1583,7 +1583,7 @@ static int __command_write_data(struct vub300_mmc_h=
ost *vub300,
>         return linear_length;
>  }
>
> -static void __vub300_command_response(struct vub300_mmc_host *vub300,
> +static bool __vub300_command_response(struct vub300_mmc_host *vub300,
>                                       struct mmc_command *cmd,
>                                       struct mmc_data *data, int data_len=
gth)
>  {
> @@ -1595,17 +1595,11 @@ static void __vub300_command_response(struct vub3=
00_mmc_host *vub300,
>                                             msecs_to_jiffies(msec_timeout=
));
>         if (respretval =3D=3D 0) { /* TIMED OUT */
>                 /* we don't know which of "out" and "res" if any failed *=
/
> -               int result;
>                 vub300->usb_timed_out =3D 1;
>                 usb_kill_urb(vub300->command_out_urb);
>                 usb_kill_urb(vub300->command_res_urb);
>                 cmd->error =3D -ETIMEDOUT;
> -               result =3D usb_lock_device_for_reset(vub300->udev,
> -                                                  vub300->interface);
> -               if (result =3D=3D 0) {
> -                       result =3D usb_reset_device(vub300->udev);
> -                       usb_unlock_device(vub300->udev);
> -               }
> +               return true;
>         } else if (respretval < 0) {
>                 /* we don't know which of "out" and "res" if any failed *=
/
>                 usb_kill_urb(vub300->command_out_urb);
> @@ -1701,6 +1695,8 @@ static void __vub300_command_response(struct vub300=
_mmc_host *vub300,
>         } else {
>                 cmd->error =3D -EINVAL;
>         }
> +
> +       return false;
>  }
>
>  static void construct_request_response(struct vub300_mmc_host *vub300,
> @@ -1746,6 +1742,7 @@ static void vub300_cmndwork_thread(struct work_stru=
ct *work)
>                 struct mmc_request *req =3D vub300->req;
>                 struct mmc_command *cmd =3D vub300->cmd;
>                 struct mmc_data *data =3D vub300->data;
> +               bool reset_device;
>                 int data_length;
>                 mutex_lock(&vub300->cmd_mutex);
>                 init_completion(&vub300->command_complete);
> @@ -1768,7 +1765,8 @@ static void vub300_cmndwork_thread(struct work_stru=
ct *work)
>                         data_length =3D __command_read_data(vub300, cmd, =
data);
>                 else
>                         data_length =3D __command_write_data(vub300, cmd,=
 data);
> -               __vub300_command_response(vub300, cmd, data, data_length)=
;
> +               reset_device =3D __vub300_command_response(vub300, cmd,
> +                                                        data, data_lengt=
h);
>                 vub300->req =3D NULL;
>                 vub300->cmd =3D NULL;
>                 vub300->data =3D NULL;
> @@ -1776,6 +1774,16 @@ static void vub300_cmndwork_thread(struct work_str=
uct *work)
>                         if (cmd->error =3D=3D -ENOMEDIUM)
>                                 check_vub300_port_status(vub300);
>                         mutex_unlock(&vub300->cmd_mutex);
> +                       if (reset_device) {
> +                               int result;
> +
> +                               result =3D usb_lock_device_for_reset(vub3=
00->udev,
> +                                                                  vub300=
->interface);
> +                               if (result =3D=3D 0) {
> +                                       result =3D usb_reset_device(vub30=
0->udev);
> +                                       usb_unlock_device(vub300->udev);
> +                               }
> +                       }
>                         mmc_request_done(vub300->mmc, req);
>                         kref_put(&vub300->kref, vub300_delete);
>                         return;
> --
> 2.34.1
