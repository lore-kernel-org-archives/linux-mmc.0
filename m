Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790649;
	b=ecHW13y3DzKYPuxLuyuJJ2b8Isfo0sczYZO7451qdYRXD7XCmm70xCVk6vmOpzR1v0PO
	 4EKwh7F5V2Sm4O273svkJr7ZeFDbeh853GdXfs5gAsfwidG3/8ERfL/2Ivz9j5ZrI89EE
	 OPMARJXFaAKv3DaYcgAPfvpo6+Np9SuIizgGi/CB5XxoIheuHdCq0dRExVAEssdnoQPsg
	 GVH0D4CNswHgKidhAlKWPa18luDyzWlv4bZf1kGuTS8RAb4dKT8ya2Txc/ePVkBtQijyY
	 mT+WkX9NNQ8LsR0L2gFHia/CWFR3SPB/hNttWjG2oqDGIyzgePIfm02fM6NcpibVA7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790649;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
	b=oYSWUqbk646hbdB4xhwqo+0jMyA3XB/javf8wp0DjjxKZO1MXxbYCjzOvOLDVUE7CkGa
	 H0mZCvpdKudcrxtZ8jTSDEI0IfnP1fXXAKEgjwpDBNe8rz0rinNpBawIUSAJscyqFS2Po
	 FnteV6TVE/CzpS/sXaKlHeLtBZTPYZd5CujCKFW3wddWVXEAbwMRzOqWAZwIxmepm5UTa
	 2jKm73BB2bxQWTZOh5gFj5XdBqzc1iBu+TAJDJaKbeazizw8lzSHU7paqnwbqKCIRGm82
	 DEr67onDmQRYj5oyvPS3i93JtIWXA/vr92Ja5K7GPerhIAIPvysr95sFOfQuH+Y/kgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+rP5MD4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzSwTZvP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA1606A333
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFA1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+rP5MD4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzSwTZvP
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1GTa2376250
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=; b=n+rP5MD4czaDZqzl
	J/Gxmm7QvtDaMgxzE/xVipGHdwLg9Qc5qzHYQuTEXFQZtFrUdIgEK803v/WJa8s3
	UdUF3f6EfFVNiYd6OiAWv6zPw0Vy69sVKowhIdufOQKKSyoW84i/Bom+mYZSVuTT
	ugN5fzMhxx4FSb/IvuCOoCIuohndlRHgHzc+HYieYj61vVtnfOx8G83ubwm8a4UP
	1YNBBAXSMlJFlwdWpEHJBeB4FNtaEs/uUkZXkvtdGEh7V3S+zOrLeecE0IWERJUQ
	CDu6p9p6y1FAFp8gKhLBDiSZdTXATInA5Fxglm5L0ULVRHWrCiwwoqomPn1je2+U
	B6VlmA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hugkc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3fd219d07so6565007a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:44:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790647; cv=none;
        d=google.com; s=arc-20260327;
        b=FG8M6tGlvUlBsV2KstAx4E9cBNN+pztowd9yxYtGUmygcmB/nQNR5ujXWgL0rSFH+P
         MTvXYD5mTiE6dmSaTZTAD/RItBuOlwHvclD8krDyJWYp/UbehSxCKjWvsfzIBe4KU77D
         BabgZJ58/wc8zEke9hvdworWjq0oFoxaT6szIsLVFMlzuXWaNFM7x2DVoDP7Ah6F5Kwy
         RRZNcLkzWToAznzsxIdQCN/UDJZ1scRw8LkDLoEdGUBJ1B1Zv34HonOMdHgw9d0VQBVQ
         q42l9b/9/jK/cJ/+hySIG5+Jppo0edjer3yeVNzWINVabXr11fOae0hROySCSAKXFsd6
         lxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        fh=CWCeQrMZ/9AsonPSPsDj4Hr23QMFGC0hooiHPEcr8/E=;
        b=rpvEn17qDNLn9YAt1QqsvAzLD5tnrnSfD7MwS9IiFSDjwiQZSAPwDFPNpubCcwoTIP
         H0KbByPoPzzsSOSn9SIWN3ZUJA+K8T7hLMCYt6qWpYhW28k+7jk0/bhOuuI/F1CGkEcs
         UyQBuZToWlOf/PMsKE8k4GXT40knAXdOUEyI3c7xyk4XA7Jmp8A1DrwrOK4S9S5Oaz2M
         zYe9oytet63jie8Kd5M7EO2PRxonsswv1jHqp2DwW2KCiqXSdacFW3HM3aQxkPjMlDBz
         NdgbvAH6BpYZfpWfewVIkLSy/msZOyrXOzJDdzbf8KXvtKr7VVGng2488AnXFETrWfvF
         FUOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790647; x=1796395447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        b=bzSwTZvPQmGGu8Mm4Vso/hibqoLWrIDGMKSvxKJkgEk4ZV2bnBymGFpbfh71h5j3wM
         c3rcWK8D7X6sy4HNKeOsQiDNm4pgMeXQvlFi5nM9xQ26Yz0XIhwNaSxCUL8eVBuUvtJv
         QhQj8LJfx8zQEjqBFmTNxmP8FAMID1NMpnnumXlHRSrcUhg/Mjg0HyKjWKof630nds8S
         tJUYm7DCOsbxPXrK9As7q9ZbOY2MXeRSM+uH+zoU0Ew0cNevKG36a+UikX2ObEI5yT6x
         ucvKIcPfI/JqTI2dpvYCjEQfAhHv0RbyGhC/7lyO3O8OH6tX6Z81/r5lZbttB5zP3q9E
         UFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790647; x=1796395447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fWmJjgPbxIUKCTGzOe0a4Eos2iKjxVCfgqaeMXCphk=;
        b=EGwuXVhLsKIy7/UG/qxgj8eTCLsPEu4eLGKbkbGMv9OsM2OXky8+L6obBEuADyZoQs
         0MQMUHS0Worz3mDzFs4oobo41KF3eVg+cVPXq04asdxoBq/+VOx+h2tQNBq/FLq2EHbb
         MRNmh1DZ1MEuCB5AoQjjMQcCe62yAT06nYMhHG6rkXbznsx0vFTLphtfqfKm1Nag6rpI
         QoqE40/URFJd5uU2q0daqt4L7A8V0patrKHq8alaXRagB4GYIeSCvJDoq9SIGiZ4Je6T
         W5wzoInP/c5p2WhkK6ftKQuB/md50oZ/z1Lqc8nEPlpslCzW9sc7JO7yYwNpjC8uVK7E
         8PMw==
X-Forwarded-Encrypted: i=1; AL+hErH/+yd9Sp4AuSZaNzni/4VlnTvwthZG+xABxEUyyoGfIzAiGenpsGQl9Dp3bHAeAzsNtuf/t+PjmfY=@vger.kernel.org
X-Gm-Message-State: APuU4Z92xfSjOE9UCl+dd1S8A0kLG1CEmGuvKBLUzHcBdU/WvZam/stw
	2G+xaUPx2bBriQ+njaVXgV7Q5s/u6GrwxpKoT4KybOxxiaCA6pN+PSRIKGubdH69vHzZLnDi4TX
	gDWsxKczwIAUzmEFcKe8304/cvppMPw/3yMKLAi+OND7KNv79wukhAkDjNP3pDHYK8XimLepsbe
	5/3kdKE0tjLPnhfQJQYBc7LItx6YWfZexnMfVgDg==
X-Gm-Gg: AZFdTZciSwr+gk6zxooGQqXUK8WnECgzUg+YdslmzXoAig98qB2B9iyUJTCgu23pF5Z
	tjigmTLBVRI2V/Y+vQU4DUHVDYk/k9YR95cqm4TAuNiKmskPZNE/+DEdKpTphNjuWLbiDb9EKZa
	iRZojWv8VZYIVpksKTZsCpGpAjaGNkvs0aOIvh771PO2Ao5AhMOh+O4qkzgw==
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b41c911c9emr22651791a91.26.1795790647207;
        Fri, 27 Nov 2026 06:44:07 -0800 (PST)
X-Received: by 2002:a17:90b:4b05:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3b41c911c9emr22651754a91.26.1795790646565; Fri, 27 Nov 2026
 06:44:06 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112124430.110629-1-johannes.goede@oss.qualcomm.com> <20261112124430.110629-2-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20261112124430.110629-2-johannes.goede@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:54 +0100
X-Gm-Features: Aa3M54qk4bwCpPsnUmyVfc-bvQG8ppESh3VRSOGzyqFs2PO3uFGfxwQzQmGY3R8
Message-ID: <CAPx+jO8boi=E6BhvCB-CS+Kuy8B109wGfcZeJqC7yEK-eLz7+A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdio: Set acpi_device.power.flags.ignore_parent
 flag on sdio_func companion
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
        linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX4IpI5WdAlqxj
 v+onOSRhlWpZuhNp7b1AvZ1lBZGWmUkkSa+LYQFMokexHm/KRm8PHJlvBUskwRHHfZ8XTJ1+Lsg
 bIK2Ev9Vz8iJe2hRKZQGQtuq3q/NmwY=
X-Proofpoint-GUID: dmf01cZ1z-U9laC2ApFXYdhG2XuHjBFI
X-Proofpoint-ORIG-GUID: dmf01cZ1z-U9laC2ApFXYdhG2XuHjBFI
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b099738 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=axVEnJ4QPotxFK-0UZkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfXwwD/GJgvxwT4
 1EEpvG9sisyW97RuCE5gsuPlfw65jcROfFV4hyooWvi24cEH/Ie2EyNNJkOJ9DuwR3k8gQAWmC3
 54oK1c8+eVzuaP7nleTyNdNAolgBkgPy9yosMRJzR2E4ydsCHLrbgLXMyTZunQlsMKuIIBNC7xi
 V5MlUD4LtVD/TtAddLr78WIcN/LgB2hx2Y8GQfnVZve2IwKWerG/fgtsdmTKTrr9SAxO4AerZW/
 6QMunvmTfkw7gxGimw13RCx0+ckIaorJVZodS+ZKabsgcFXMePa+SKSWfY4X905LkE+X9H3IEK7
 KrscsK8AXQ0Lx3VKw4v9fPnKud1aK9F3vP5xWzww63NfWNogKeqq61UKrIJIzGwIvQ8Hm90oNDe
 S4Zn2MlMPNzG8WCfW5FTy//gHk7g/S9Ch0v5CWE4OB4ohgnVc6IFw3ti5OK7pGQWxG1FpxDRw75
 s4p1BHyq8OBUDRBTRWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Thu, Nov 12, 2026 at 1:44=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Many MMC host drivers call pm_suspend_ignore_children() which allows
> to keep MMC cards and SDIO-functions on while the host is suspended.
>
> For SDIO functions which are in the ACPI power-domain this causes a race
> where the host may end up runtime-suspended before the driver for a SDIO
> function loads and probes it. When the probe() loses this race this cause=
s
> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-doma=
in
> code with e.g. the following error:
>
>  ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
>
> Busses using pm_suspend_ignore_children() for their children should set
> acpi_device.power.flags.ignore_parent on the ACPI companion device of
> their children to avoid this.
>
> This is safe to do because drivers for sdio_func devices should always
> call sdio_claim_host() before doing any IO and that runtime-resumes
> the host.
>
> Add the missing setting of the acpi_device.power.flags.ignore_parent flag
> to fix probing of SDIO functions sometimes failing on ACPI systems with
> the error mentioned above.
>
> This brings the SDIO func handling in line with the SPI and I2C handling
> of ACPI fwnodes which both also call pm_suspend_ignore_children().
>
> Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
> companion device will stay around after removing the sdio_func device.
> This re-does the ACPI handle lookup because acpi_device_notify_remove()
> runs on some device_add() errors and from device_del() clearing func->dev=
's
> fwnode pointer.
>
> Fixes: eed222aca8d0 ("mmc: sdio: bind acpi with sdio function device")
> Closes: https://github.com/MocLG/rtw/issues/2/
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Drop unnecessary clear on error in sdio_add_func(), sdio_remove_func()
>   will get called on errors and do the clear
> - Some spelling fixes for the commit message
>
> Changes in v2:
> - Do not clear func->dev's (ACPI) fwnode pointer before calling
>   device_del() so that acpi_device_notify_remove() properly removes
>   the physical-device links from the ACPI fwnode.
> ---
>  drivers/mmc/core/sdio_bus.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 4b07098c33c3..2cba8c45c8ed 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -373,11 +373,32 @@ static void sdio_acpi_set_handle(struct sdio_func *=
func)
>  {
>         struct mmc_host *host =3D func->card->host;
>         u64 addr =3D ((u64)host->slotno << 16) | func->num;
> +       struct acpi_device *adev;
>
> -       acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), a=
ddr);
> +       adev =3D acpi_find_child_device(ACPI_COMPANION(host->parent), add=
r, false);
> +       if (adev) {
> +               adev->power.flags.ignore_parent =3D true;
> +               ACPI_COMPANION_SET(&func->dev, adev);
> +       }
> +}
> +
> +static void sdio_acpi_clear_handle(struct sdio_func *func)
> +{
> +       struct mmc_host *host =3D func->card->host;
> +       u64 addr =3D ((u64)host->slotno << 16) | func->num;
> +       struct acpi_device *adev;
> +
> +       /*
> +        * Re-lookup adev because acpi_device_notify_remove() runs first =
and
> +        * clears the fwnode pointer of func->dev.
> +        */
> +       adev =3D acpi_find_child_device(ACPI_COMPANION(host->parent), add=
r, false);
> +       if (adev)
> +               adev->power.flags.ignore_parent =3D false;
>  }
>  #else
>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>  #endif
>
>  static void sdio_set_of_node(struct sdio_func *func)
> @@ -417,6 +438,7 @@ void sdio_remove_func(struct sdio_func *func)
>         if (sdio_func_present(func))
>                 device_del(&func->dev);
>
> +       sdio_acpi_clear_handle(func);
>         of_node_put(func->dev.of_node);
>         put_device(&func->dev);
>  }
> --
> 2.56.0
>
