Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201A37A832
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348245; cv=pass; b=IdjgdXnDfHk+OJu5hQNzBA3KiDzatcw4kQYAK8t+KBuaw0y+KhvHUmcDGRA56Na4W1mDF26KJL0MhsTtvKxXolp+h6OHpu7KUBlE6Pel29dXk5mmbB11bVIz/hIQ1Ea0gcQWMk+ogsURjcOZD+mpu4S85fGA1uC4X5zb9ZkrPBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348245; c=relaxed/simple;
	bh=ZRwLiDI5MHUvrzoZrz7k6o9CvSk/yRRgFgCB6VWaIEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rr7K4Mm9i14SKhf3ZjBW5k+sGRbQ7iXRN4i/M4GASsOPIHzT9Ftq+da2JCFAOkW1HJWEAEXa+jbQMgrQW6oBjh9vFTOQx+KH2HwQwjVcNOTSpjs8hR9lAntqZ8v89vKdW1bVorioxsMntBrQjqXKmOwUlYFLQ4YgYu9d57JGiuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CyvsW9Ea; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CSXaQyok; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CyvsW9Ea";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSXaQyok"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EDsdJ834862
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 14:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZ0s3QfRjhNE/u6DApVb4UZ/WGmpzxChAEXvM3G81ck=; b=CyvsW9EaNWmGxqz6
	faBAiWvUekg2eby6UqKkTz3xhXeiq3iLII4qy0gtbij5GOG7q1Awl07ORl87hICV
	xtIv+IyHcix1X70Jgf4+Wrb/5L0VRWnzpEzO1zw+sOW+PZ5GH6p9DiN63+QvfnOP
	oWYpP7+h53Z2nIOeYV1mzYbCPxFBiSrP9rLyFxTcDQ89SPvPHCe3RYk02AOIXFTj
	7cNUTcNe/8ac5N2HOTO4dRGxF7DVTB+S0LxQ27ar4C9UTsm/XzQfxr5kyTUhAjaC
	j2OSiLp+TiYSndKcDTXbbj5YOaQUYmSPAtthI2Bj/RCDtG8vbLlXK/2gthT8phsE
	LXbmXQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgsa21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 14:30:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92158791d14so315463185a.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 07:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783348242; cv=none;
        d=google.com; s=arc-20260327;
        b=lLYeWrAHIfe3veF05exeD1wXo4ZNpMNP+etO53eydqukqSwB9QobUkZDTs+cV6SJqy
         vo66SFvuNaUVNZtHJcoq5c5ohNhPfCqjOKZ62RzMqtjS9yBpa3dXe9Ejvsv4N6wT8DoQ
         jFBipRCQh7yQlgD2Ykch0CV8Y9kHgLTcFzcftaAO0KofCCPsqpgyOJdibs7D4DlJyv6d
         U0J/V8/gUqqSPOMr7BPN3PStckrCbe/mrJAf0kvkNG2YvRixy0Z+bt/gTYZ35jTIZA+7
         ad9PImaESiRLLixwXs7J4TsNpg8cp/kaqpIKg6nnd+ry0AkXIUpfND+hFdvgO2BBI063
         CVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZ0s3QfRjhNE/u6DApVb4UZ/WGmpzxChAEXvM3G81ck=;
        fh=2pPOycmBEIRoS/wSDcQfl8jmIC6aOtVqeUN+7x8mxTo=;
        b=aBfyfOPC0JwPJZS0kymUBWKD58KwDKxDMVriTWEZ/8znCJe7IaqmOgIOUsTGFvJqXC
         rXY+Of7jDDmoU9Ef2TT7Eey4oXLmD2yfcZQiM7+y04oCsYrENIguYQucp73iQUzeNTB7
         r7YSbyREE8vKg5dTQA1krOWfv+mXsa7vCyPppUun6ZOZswdLatePcq6l4h62GE8OCjAU
         OFQTnGgd9nEAj5wzdtHjYxSPt7fHYmm/GuYjn7fElSWI2bVSM+8E8QacWnVXL2D7G4rW
         Oku0/UK2GCEN5jDAsCm4U73XGLm1tvCON8uUwaZIxBkPbSMnXpOPS/XBH/Nzxn3ROCDO
         gl6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783348242; x=1783953042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZ0s3QfRjhNE/u6DApVb4UZ/WGmpzxChAEXvM3G81ck=;
        b=CSXaQyok4EM4InYmr+xgJyPswZsQ9uOoqk1r5BgZCC2uGnXB3ERa/BWowMiZe8HuUM
         dpEuSh5oMcSpS5goD92fNUEL9BMAeEHcGco03nFfoVc8GBTFbr66W4ITVC+/uOBCEsHX
         YCzoCELyvBKZ8TSuenvx90IO42qYaxWhzu3Vu9M4nVOcvJWjqTzEsqGgc3o5H3Z55Akw
         0P+6ZKAGeeHJ0gPsxU1KGijgsN/9QY0KNixC/kLbNYVadFGOzScvCOKWXBk9No3T4pbn
         Noa45C8IePTt+6Ivirem8UiIGLoUVeQLM8E2oBPo9ZE0GLwxaTL+jcuV5rOHKYLcXz2K
         aHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348242; x=1783953042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZ0s3QfRjhNE/u6DApVb4UZ/WGmpzxChAEXvM3G81ck=;
        b=Qgkfl/mcAHGZRxS6cyS2bPF/H7KSBP74uBKAOkVYNPIJAXVymObEw+T7WpIZEY+KW6
         XBmpmJCNh+sFFfx9eooRjD8dTz9Uk816jyBEI4SHL1KqByKSfkHc5jd54cldqik+KBRi
         4s2S4zO9pU68pi3VcztAl+RrqO0n6Nm1q3XfhJIeLyS95HgsJrkpbBd1ZUYK/Ht4VnMW
         yJGmOCez2tqTEmrL7WbC3bYNsTregeTikhpPqlnN77s8sdpO49qqi42ELZoshIQT65DG
         Duo1iOBcG/4E6a+2DRD5TIaIY1+MPR/R+b/yplvkdgANxrW/6JLZCQ4XIOrPL7VGvzbY
         UJBA==
X-Forwarded-Encrypted: i=1; AHgh+RoX7gAOU6Y+c21LITttzntYnF0SZ0Rg1XCE3C4XzbZonK9O/GPl2O3bhNRl1nG1A2RCp0tx5diS1Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXKxuvhj3MN9BBLRCeJXXaSbxXDLmP/z8HDZeuGoI/jq378rg
	aCLQwcDr8l+L4q2tQ6oUc1VhOny74p1I8dHHcqFVxmUVMJKfg1XXx4d7/s1FQQWGafOOcFaoua2
	XxOxSKRBc7ORPPfaaniS5Kz+abGTsbFiWW3ByaJ/mdm3iVRK2Rsv2o2GdR8dHGzFYLiOEsdbHb/
	0FmROIm9jwQ1anNqMML0lmCAaTbfr+QSv01oy/wg==
X-Gm-Gg: AfdE7clK6gt7vAeR5t/Zrvd5V0IHAu58ZZuQDqcvyW8midZRMrHHwJFcGuouPrrNfRj
	+GPA8/kaEm0+g3IU0ieldo3DMwxWaILtOJXiXDDVxy4y08iQ8G3f1eB/5mTZ/STc/ou667hohMc
	eIXGxxh2rgkSBIYV/TWgnycT1Jwo0usjg7/rk78x1Ky8+fK7AxEHfVOBps8mGOjZg8cinZ
X-Received: by 2002:a05:620a:27c9:b0:92e:73bf:e948 with SMTP id af79cd13be357-92ebb60d66emr106790785a.57.1783348242057;
        Mon, 06 Jul 2026 07:30:42 -0700 (PDT)
X-Received: by 2002:a05:620a:27c9:b0:92e:73bf:e948 with SMTP id
 af79cd13be357-92ebb60d66emr106780885a.57.1783348241347; Mon, 06 Jul 2026
 07:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623102353.755235-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260623102353.755235-1-ben.dooks@codethink.co.uk>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 16:30:30 +0200
X-Gm-Features: AVVi8CcbFoleWHsV19SLPTYZkQshT6_cnmmlLDpfDAPnfRoPJTN_fQxtGZz6x1U
Message-ID: <CAPx+jO9BtwN+=Y_xLFXusTwFFv=5KDZCY_3QmSpRmskMch3W6A@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: add declaration of dw_mci_pmops
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sUQddl0OBFyCtTAXr1MSSUVbGL07EOCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NyBTYWx0ZWRfX4frnmFflh+7w
 y8KKxN6IUtG9jjdnhOeTipUAfU+aLxhgEOclGBxrRjCdCR9uGmqZPSB+JxysLEiyT30eXFvx236
 CDYvaXhdov7cJGkltYmAYKBBQCpfbEG68Jdxu6rH2+2ZAc+TeR5BB7yAL/SCHKZfZd4XaHxH9YQ
 z0vUuTLfqe0iLeaH+zUguGio/N7IZP7BVdA0QXPdHTLJ3YS9JS0LqHJuxRY6UPMj7W/Smd/USg6
 weGqpW/mTf+h/zAzDFJ8G0OLZF3PhD0tsBE+hqTLMi81RX4/lJT8B7DX4f+DLqJ+yJ4xXn8f6rg
 bn7zb+TIRCPwlcgiTduGiYCpyafYPtanO2nPXp3IaFz2CNnalu+GLSTxdxTXbCN3AEBJaKQ7IU5
 V+rL5pJfDQU7qEpGXDsPh5RKRabNKFIoNTyNVEfd3w/I3pY+sHOtkwxh2jbBdH0BUywLUpfOAeV
 p88nuhhYwmMlQWD5Tjg==
X-Proofpoint-ORIG-GUID: sUQddl0OBFyCtTAXr1MSSUVbGL07EOCF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NyBTYWx0ZWRfXzT1fKZIGRZ/k
 8rA3fjqglmYI2NXRNv+X3Q0LvtB2WiYoMRCaXbftFO0Re/eQBpITMbFhC82I740392k/6RqgGbb
 xUurGGpoHnnckSFUJeRQKjV10hxC/6c=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bbc13 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=1EsaE_6oAAAA:8 a=Q8MAYVp2rmuI5hWQ0tUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=3ZumFrijQQ-2J9H5h8ct:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060147

On Tue, Jun 23, 2026 at 12:24=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.=
uk> wrote:
>
> The dw_mci_pmops is exported out of dw_mmc.c so add a declaration of
> it in dw_mmc.h to fix the following sparse warning:
>
> drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not=
 declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 9ffcd3946cff..38610c89d54a 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -19,6 +19,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/workqueue.h>
>
> +extern const struct dev_pm_ops dw_mci_pmops;
> +

It's already extern declared in drivers/mmc/host/dw_mmc-pltfm.h.
Perhaps drop that then?

>  enum dw_mci_state {
>         STATE_IDLE =3D 0,
>         STATE_SENDING_CMD,
> --
> 2.37.2.352.g3c44437643
>

Kind regards
Uffe
