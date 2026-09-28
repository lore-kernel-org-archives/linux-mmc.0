Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970884E73CC
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611604; cv=pass; b=m7/olPBvoeWfssWsQMrwt9aw5sRwPFG+sfxgd0bvm1GywuBLZ8OsNWLTzgdAlBYYl11ZxBnVhByihl07aTfRMGfswlX+3NAyW9KkPdAadDmoR32UgbGxUAzEDUBJ6DgZFAmGWCFgA7Bht4vQCmJiwRlAS1/KWMzce+zYBn9yJ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611604; c=relaxed/simple;
	bh=AxwspMKsVZK1XQ0X1dJ8SvYhPShfagggpXNX3D7+lkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZO4cvGVMsIkbia5gnT3/ZcJ99Z7VXWkbLNVSA/eh4lRJA6J6MMioMSUpI6xBAPegUWQu5JEVTFDDOuzM9GjCoBPk60qSJGUXKknH2oJccTRcuZCI6+YdEylr6Dhs4Jno+ae3lBfgyGaRz5uihTBcIZ/FKBRKrBQzV/cnqBFZHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M5E5ZulZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YRlnwJPM; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M5E5ZulZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YRlnwJPM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEduu61016603
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=; b=M5E5ZulZAP4oNlP6
	EtiXRsQkimO0coeymPP9xnQgROgpGWaYQowXn9Oadi0rj38qsAVXzTjuOFgau5pm
	t93DeZOdyYrvHi58xTkHBABjEamUNnpeHNTG62CPil7fTTStxpz0aDkLtbfecKAM
	3UDlSEwTMGkE3mLZTGc1BZkZfF0mp1WVOsHGgmTrn+ot9MemCFI66nWn0IbUtIJg
	tZSy4RWIadrmToiStbs6FgIYzIWihhWfRSyoa3dQcWqb+0jbF4m6bO4IVqODp/cZ
	dGMq3zCAjRCswtd5kC+07wD+V9nISDhwP24lU0jQGVt/ixvOQbDN2l/VVF9eLsst
	LVSpjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq314n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:06:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a0c0c2d456so3074083a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611593; cv=none;
        d=google.com; s=arc-20260327;
        b=ZdwpiL5RQDVuPGKy5vnTd8h57UFf7ZevfMZu3Sa4cQV/ZraAqFGa/6iEhvtND9U98c
         FVDervibowpLr75BolPTQdD4M5JS4LbCvZ/zfczRW6gUaYskCrh6Cl30O8mCLIDjdZHR
         0DDhNgiwnLrwyEk7+kmLBMF8zh8/H4QkVX/3h3PjvACkeWdlcr3Qo90jlBD3GFOqNL2O
         wrxRweiCPWTeI98hLq8COMeMH3MmQf6EohzhvWdMKDS5EHBHyiylrR4te9sPyQlV3Omc
         8pYjY06pu4H4kq3WFZ6aXEJYhzwa4UFPGdTNeaInnZXWMsx52ogiSkVV6V68/c90+3Sr
         ce7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        fh=3yd/19H+t8giM7tJAlhrVUeukDTP8TBrNx8UoV6SXZA=;
        b=ekbTB7md7prdEoQqTevMCY4wuzkxRufjvc1fSGhcftwauXpSYMzq8ilp57FTWHuJ7I
         VPBKM87Gki1enbrUFNpBGc4gWFIfBUUAMy9Z+//cbhMBo0mX9wZNMQyJKbfPpf1FQiwT
         gUhhEP9shM++hAkng3Z0UYhbt++bNAbM5ToqLLtCHkeOavMorLen2rcvUlQgGg+kEAQy
         IrtfaSPCj6pr0ZhcmkCJF0QJNVnwvGrz2NdkcKyjr6Vb6cwXQ8G1h2ReUuztvQtdySQy
         znqJny4SYTvPQB6STSrXIeS3JtcrgN7HWYzWlmEnDf9mjb0FeVTUMxQ5xGP+Fcl6B7yM
         bU9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790611593; x=1791216393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        b=YRlnwJPM843OPEp7IQ/+gvYPbTFbRHkvhu67xcpzhdr1cNWWejIrmpqdHYJmFvk4Ib
         /Q4R0TUKCeWsxx/VHY8y7vLwWh76tywzmxNgW2iWIJ/dfuqHVBFA4GiuFfBu8dd/2Uyf
         VEmCy8I1sV4UmzxuuZQYpCDldO6uLUWfdH+UX1S9JHzc+tq8899biEt0JK1jiAZI5Ibx
         5NVSYwyp0wq1J5SBJpSa02M68shY71PDdzUBABqewepYr5Pacmb8WuTIVL8BAtxdD6TD
         MeGNUZix6pEc3RA7vbxXIvb2hgSe/PINEtdcQntsHTx7VBg+XlKA7jwoa5B79T4MZ/Ml
         GRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611593; x=1791216393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        b=DMj2BbB1Pz3vcExWJNDolKAL0mNl9m5COY6ewmjq6QldJmdh9yNkLeyv10karHi6am
         9YGPJJvswfGQX6UtuHGj7B2QlaObatwy/6QZoi86y4/M1DekXd5/90zl6ciHMUidmerd
         SKvSWwdVckb2B9b40AY2Ij9oBDBFzmfcJzZhrt8bOIwozD+4dwBIjpoXC9La2+Ruoj8B
         EDiAt8c4uGxAeNQos9ZvPuaEVAkI7LCdHlJFg6MIVOczr+vUpeGFZCKC5DlUAjztuVOR
         WbZ6jcqyfrJj4fTc2xXa+VfjCg8IJYPzR12AXpPn3UlP6e9oeFEMs9SJuQKUYC3MV+Ra
         N2bw==
X-Forwarded-Encrypted: i=1; AKwUvByl/kG0lIsfu/Ih/iPDWtcBjT3DezC7etfTJb0Fnnfsp/PcJIYBHgNhmTIPTeYKdYMpVzwl4Sk+DO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBMw+XwXkhwxmUa/AhVowPwLEcDdekegKh+5pSOtvUT/8SU5fl
	ldvhkaRF6KiwR1mCj7vKdf6FMHES64InXKW/5lYgQq4j93dMIocWpf5Z43fYDkUrsSWwC2RoGUm
	LzLwcsr2mbKHvYsn1o+6S87XcfDgWOx58csZ1tosf1mEgB1ISn7LHjJ+KOGoWEmL5zP9ScVqEI2
	EsJr48a+Oq745F+h26j4rnsImaDmT05r1NSSA++Q==
X-Gm-Gg: AYBFou1o2fZCcp5iMfwfwF6bir43PKYf+MQUvlNyCNedYwO0SsGmakwpaYEEqQsrlfU
	K1zzDXjHfxiHUHg0VbXxvrj95fPkJYSFvlVR54mOJLw+hUosaMchWUcqhOTnIEd5G0vRB273u0P
	2+0PtG+mBSZyxkB4keX07ww4zTDkwz0b46IB7or+Fg3wpBa0VGQDfE7mJSEw==
X-Received: by 2002:a17:90b:3e44:b0:3a0:e247:3ad3 with SMTP id 98e67ed59e1d1-3a0e2474be8mr3602117a91.40.1790611592592;
        Mon, 28 Sep 2026 09:06:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:3a0:e247:3ad3 with SMTP id
 98e67ed59e1d1-3a0e2474be8mr3602106a91.40.1790611592087; Mon, 28 Sep 2026
 09:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917101750.2146473-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917101750.2146473-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:06:20 +0200
X-Gm-Features: AclHuK82ucEdSmeT-bQHmbw_Uh16I1-7A4GMKqZ9onj_bi2194OPKgUaCmdLCEY
Message-ID: <CAPx+jO8Jef67qM2nvZKO77=H7P5EAAQQq-LfpFxCuUmhi+xiUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix OF node leak in mmc_add_card()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        s.hauer@pengutronix.de, ulfh@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pvPsS1TdbI6wv-wMKB3dEpYFGUmoePVs
X-Proofpoint-GUID: pvPsS1TdbI6wv-wMKB3dEpYFGUmoePVs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXyQUTYCD0pOee
 H06S9HRyzTRYhBwtSQN3IPHcslmhFQLEfi3SHMTgwtelr00YsAbLDa0WT14xCW3FSSRr+Yp0vdC
 WOMDthXhVYKc11CaAtaFRiUD+qHYJm4=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba9089 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=PUCtf4xQaR7MHDhmUGEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXx+97zSRp+vDW
 xEXq5K+mNzRCtq5P7aE1HsNYWqFV3iNgqJQVJdA6zwnaTG9O/FTMMSUv4bYEFyPNhZ0jU+VUjXg
 wWw1rFhxLLcaaoNqKFO0KKq+vNtyz3r1s3DAs9tWUFTh5J4Hx9cLWMOv1hdCgX+s3FhHrRDMDN3
 l77O7BJ8G71LqONoUwRkASSOwX+rjT29Oz4B/38tZlJnfL1strFYQbH28jrKjqIrJ8BfMwe2+4H
 bkxQNxAK2WHXy09tzTy6mSYs+OAiWrS4r7mSzPFdTMhGr3vuWshwT6O7UFLSk2lpJvGH8fPnHsx
 jpp2dJgbx45eYCkGOp9GGECbmDIgeoaLUGN+4Y1IyI25E4Z94405996sbK/zVs4iUVeBcxO4o2Y
 ptwuIjANf8oT6ScBOksGfNHWMYDeGZTTgFklg9kAgCfhLspebulXiG6SZ8mKEAjcLZxBT+epanE
 nS4lY1vhMpJGLMRrZFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064

On Thu, Sep 17, 2026 at 12:18=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> mmc_add_card() stores the OF node returned by
> mmc_of_find_child_device() in card->dev.of_node before calling
> device_add().  That node carries a reference which is normally
> released in mmc_remove_card(), but only when the card has been
> marked present.  If device_add() fails, mmc_card_set_present() is
> never reached and the cleanup of the failed attach cannot release
> the node, so the reference is leaked.
>
> Release the reference on the device_add() failure path.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

We have already a commit that takes care of this ("08b54e16d547 mmc:
core: Fix OF node reference leak on card add failure")

Kind regards
Uffe

> ---
>  drivers/mmc/core/bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index be5cf338bdeb..4d862d9bab23 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -379,8 +379,11 @@ int mmc_add_card(struct mmc_card *card)
>         device_enable_async_suspend(&card->dev);
>
>         ret =3D device_add(&card->dev);
> -       if (ret)
> +       if (ret) {
> +               of_node_put(card->dev.of_node);
> +               card->dev.of_node =3D NULL;
>                 return ret;
> +       }
>
>         mmc_card_set_present(card);
>
> --
> 2.34.1
>
