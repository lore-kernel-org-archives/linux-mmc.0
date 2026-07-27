Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881836EAB0
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166940; cv=pass; b=u86uVQQDyMbxXsgrLRtZNPB+yhnSNmmag2dCs/D3Zvy42i96lwwgrOkCnw/y/6OP3WxCVj1HCnFnbGRZGKNN2Jag/G6C5cxoqTVK4EiVR7v5ySFg6cqQ1H0G7uzo2sNCbff2MYHQb6Ztpsu/WZDjQ+5CxPJXuYOXRGgbzZLnrzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166940; c=relaxed/simple;
	bh=/P+mZ1vCnMO189coZBbLR4T94MXahEYogap4CAVHjSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nsw7T3nGVu+4srOVEbleYyi51gYk7v/uvYjk4J0aE8IcOlB1G05Nvq6MqijlOy1/WCSu+tgtV4LymRcVDK+/snctyjqFhy+5/B34ecVMaRl6rccTfvpTe2gZ/f8IDBJEsKykqZCyLfWWlOqAMl1bE4MilxfsQS2oEqbz+PbwJT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnTAOlE0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jTvFSnr9; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnTAOlE0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jTvFSnr9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlpYJ3787311
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/QH7XxmaePM1TvBDSkmC/X1cynDgtGI3zs7VT5vhVw=; b=cnTAOlE0R1LPoHSd
	xvb2U/aZy3B2bTLk1ngsSDhR6/m6LbwnWt3g1bOv/bT8H5VFEEjR+KVBI1LOnzgh
	p9W8U3ij/78nmERQJ0bEG9m3gL4aAOabQ2OlEYnsv375npRmlKr6KK5S5j73Zukn
	JFWVdvCl4wFwnzbN18O7/FvIEcsSjdrtw5h/RknmaQ7YSdqZz7fRnBXXh84HBAir
	Bx9TZHQLltKa1ODpnURImQmmzsTEZXPlg+8r2xfoVYPpje+Ko5A1yPrcGVOR9mil
	5TpJR1HlOj/+M9GwxvJhGCuzX4k1rIdnuMABzNmE7hDQLWez1UhezHVm7QKKuio6
	haLHEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2hr7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 15:42:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso65248176d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 08:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785166938; cv=none;
        d=google.com; s=arc-20260327;
        b=ahh/IyLTULoknacWHIYylSGdiRQATmCUxCU9FIau4BNpvpnGo5JfW1KquDrzzfWFRi
         hw5wI6lQsiFy80f4Fddm8QyLM1Bpwy55+bBrNuyaW2H11KQCd4edT3Q5kj8ISMViXUYa
         rhSBpR4qzef9NSRrYyHmIrPmCm+hc2Vn6dl9DLGXhNF+oS7s1wpQl+PfhBVON2Qpc5KF
         ccTvPnA+a9W6Co8rYIwFuNUFqVB3FcXo3jsi5F7Xa1QkK255mahahcrd6U4QVi/3q5mD
         17FmjCvpjy5j0NYNRQTFvzu5phNHed1jdgLDbitUyOywjWUMutVvo14bqxoiATYyrEfY
         +wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p/QH7XxmaePM1TvBDSkmC/X1cynDgtGI3zs7VT5vhVw=;
        fh=DoeBUxqPhb+snLCQp5D3Jz74RmPZ6O39YrylLXRUWY0=;
        b=CbGdy0c6NqravENeE34Jhbt5I3QTC7h5H8YDLU9x6ctS3MJCSs7+y7QX5rT4TFeo8s
         aWiSVRMrv58Oi5qAgYqMngkrUxejZI8J8/7WXLuxylw7CyWfanyKTeuhrud7/lNtu/gD
         WyFTobGT7Gm0c8pKsf7luSkhvQ1s/58hsXH+rBmXe/5Y62A7Z7KM3Tr4QpF2Y60hpYMj
         Lgl4ZqllC4N3SZrwa7yo4u9RWbv62dN2oQ8I/6bKaUTHIaDoX/pIGU6tRAXYNs4q+UwO
         ly1T5Rc1YWEBxco5pMojOFmL4CclRkcyQ320UBq1sEijLRk2WoBzXenOKFds6OMvo8Mb
         a0VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785166938; x=1785771738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p/QH7XxmaePM1TvBDSkmC/X1cynDgtGI3zs7VT5vhVw=;
        b=jTvFSnr9wyI9rbYqEt0MExp05s9P0yUDUtEz6HlBduDlFoCres0LOEhK3nAz8/fui6
         Ch3+kPeza3d6gMcMhsc6Y0TOBH8Mlyok74T+CpfEmfHppbwA2lyKVGh8FYGnCocK53VP
         JC+uzQDLy6ORsys24GeuEHmEWVcOvJ1umG9urgqudqDynaKRwRHhF3L/fdexcHxfa471
         zCXMmxIyjjMvGBRw1VfyNxxs7wo/I4Cn7CBn/5K/iD31SBBUpL5/68vVVreqfeLKjbaN
         66T9sQvZxfT/YawVZ3i76on6cECfnyvXjMXP5o3I8z0i73eu/5qAZWFgMzYrQBFPYG/H
         /pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166938; x=1785771738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/QH7XxmaePM1TvBDSkmC/X1cynDgtGI3zs7VT5vhVw=;
        b=YF+ezsvBXEymMgCMyN+2VQa0BeZtkEUeNpWRiv5AG37Yzrb39qwoQbEdyRzJHbY2vX
         6sGAicnbqhBjbfwTqn9IV1kx3t3PG/7TcZseO+uoymEw3/DQAr8k7cdQTXL5EEuUhIir
         1X7ryRcIhW5+5F2u1WwggUm8XUDj4U6XPHKzXL9An3VC0vkbhXTBKIXFTR7h8YqMsTUo
         KsG1SuxtA2omMmG+2KB7StlWQzsfRVhkCiD3p1HlU38dx6zX3fGIj0TSogOAVhoFhg3a
         ewdF4+LtOWHUTHmsOZb4lPaxBVRjQTq0dGXUZ9njxBeAuZ4tSsuDf51oHRzZmGPmYbOo
         7/zQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXGmZjypSgwpDFe9uoPa90BqlzkR8uBER0NJqZubBlhdvgkleqKb7J+HN6dcG+5s7n1oy3NS6k1Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6jFV4b3Pg5t4XKEAEfdsNzq3vb596QB8ysoPt1FWY096HIF6
	AZ20j58HyYob3nc70tu6WB3VmG54MHnDGZ2Ke8s00Gxiq2aXF+j/10POFIZwEHV4aS+D+kxcUBc
	9nYV76Zm5xYfEGcAok8/8iqPPadSHO7t6fq0dn8gfRXPU07dh848D88hNviPIrzCkLET7ybvGWn
	yymTS5Flnt7PM/GhUqXv/F2L6P7uQva1UPilZJUA==
X-Gm-Gg: AR+sD12b5bTpzLne3npwqByhA29lRt347sye5V8VmnASg58frd8cAGMUM0aGWEh30FZ
	qzV4/1J9Ee4HycJ8G3YC0mJ4SksER1l7AhhfgSxwh+jjS/hACwRHBW55fWi2kUUXJqdg0QCm2Dg
	KWIAEVhelHXUdU4M+o0PVQF/uNMsmsVS7ic3NwB7CAYNBwjaj35PlkI/HhFA==
X-Received: by 2002:a05:6214:1243:b0:8ee:39bc:8fb4 with SMTP id 6a1803df08f44-907ec7e3ce5mr112440736d6.33.1785166937737;
        Mon, 27 Jul 2026 08:42:17 -0700 (PDT)
X-Received: by 2002:a05:6214:1243:b0:8ee:39bc:8fb4 with SMTP id
 6a1803df08f44-907ec7e3ce5mr112440206d6.33.1785166937198; Mon, 27 Jul 2026
 08:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com> <20260722211417.3702709-3-kamal.dasu@broadcom.com>
In-Reply-To: <20260722211417.3702709-3-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 17:42:05 +0200
X-Gm-Features: AUfX_mxn-h2UtplQOFwlGyNVlEJdPMf0XzY2soiCdXB5Mh5Fo4iiWpgLMGCSTiI
Message-ID: <CAPx+jO9kvStHxc+ccSne-S-NA=CzH-wEf9H+Beejyv7BGi4uoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: core: Add MMC_CAP2_NO_POWEROFF_SUSPEND host capability
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NyBTYWx0ZWRfXwJujv4DTJ5jb
 AMGELE4CUXYa7TZAo6aWvG6LU3nePp9op/cOpqM8YD93um9Z41Lp5UIfeTz16gS0UFp9+oPzrkP
 i5YaXhEoB2ce82jEU+ST3uUsw8WF+NE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NyBTYWx0ZWRfX4JFDj7vPnGHH
 cxkCSJ3rptaSZ7DWGn9GLsxiVcbB0hHN6icCnVkXmVTspcubxTAecjI5aui810hU8cH9fQhWNEX
 nvaDb+IAsIVNLFSFkKBO/tG0LNcKttfceqgJKGtmKbGqb778IRkde5kCsePH3eNctaDYvllYGw4
 UJZpWv14n3bSQuw8M4Zrk+ut9OxeXt+JhIYEgmCH+8g2DcnIaLY7f5DdIvYUlzRuJlL+ERvOa77
 +2+gf+A0VNPDx+yNAhM3MR0EohFSYhjkM84SeS2bJwvZmofx9Fxf2NtiQRWzwtrHeycgIqJCTxb
 0B4Bpd4Dd+uEyVydYPKezt2jUDa27HA3unxGaIBt2mr96IaI4dx3WhAADj7KbrOgd/hSX4K1/Hh
 FuyTgRSzWTVaRUU3/mBieSDhq59yxG8Fs8HEXB9jCiYQ93NOkM9XfcXKggtCTImJvolHYBmggxE
 Vg0Z5ywAws+AbHQeQ0Q==
X-Proofpoint-GUID: bwIPykAyKl0PzjHmt5LUBkiliqQWntf8
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a677c5a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8
 a=-NkzacoIYP-BbfFoRNoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: bwIPykAyKl0PzjHmt5LUBkiliqQWntf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270147

On Wed, Jul 22, 2026 at 11:14=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.co=
m> wrote:
>
> On some platforms, firmware accesses the (e)MMC card directly during
> resume from Suspend-to-DRAM, before the kernel's own resume path has
> run, in order to load boot code. This requires the card to remain
> powered and responsive throughout suspend: putting it to sleep,
> sending it a power-off notification, or removing its supply is not
> safe, since firmware needs to talk to a live card.
>

A lot better description, thanks for the update!

> Add MMC_CAP2_NO_POWEROFF_SUSPEND, settable via the new
> "no-mmc-poweroff-suspend" DT property. In _mmc_suspend(), when this
> capability is set, skip the poweroff-notify/sleep/power-off sequence
> entirely: just deselect the card and mark it suspended. At resume,
> _mmc_resume() already unconditionally calls mmc_power_up() and
> mmc_init_card(), so the card gets fully re-initialized regardless of
> what firmware may have done to it in the meantime.

That's not entirely correct as mmc_power_up() will in this case bail
out early, as "host->ios.power_mode =3D=3D MMC_POWER_ON".

That said, we probably need to call mmc_power_off() in _mmc_resume()
before we start the re-initialization of the card, or what do you
think?

>
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainel=
li@broadcom.com/
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Kind regards
Uffe

> ---
> Changes in v3:
>   - Reworked _mmc_suspend() to skip poweroff-notify/sleep/power-off
>     entirely, not just SLEEP, per Ulf.
>   - Renamed to MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-suspend.
>
> Changes in v2:
>   - Replaced the card-level MMC_QUIRK_BROKEN_SLEEP quirk with a host
>     capability, per Ulf.
>   - Added Reported-by/Closes crediting Florian.
>
>  drivers/mmc/core/host.c  |  2 ++
>  drivers/mmc/core/mmc.c   | 15 +++++++++++++++
>  include/linux/mmc/host.h |  1 +
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce3137d452..35fd0be99c58 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
>         if (device_property_read_bool(dev, "no-mmc-hs400"))
>                 host->caps2 &=3D ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1=
_2V |
>                                  MMC_CAP2_HS400_ES);
> +       if (device_property_read_bool(dev, "no-mmc-poweroff-suspend"))
> +               host->caps2 |=3D MMC_CAP2_NO_POWEROFF_SUSPEND;
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_=
type) =3D=3D 0) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..27a559e6fcc0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2157,6 +2157,21 @@ static int _mmc_suspend(struct mmc_host *host, enu=
m mmc_poweroff_type pm_type)
>                         goto out;
>         }
>
> +       /*
> +        * Some platforms need the card to stay powered and responsive
> +        * throughout suspend, since firmware accesses it directly during
> +        * resume, before the kernel's own resume path has run. Just
> +        * deselect it and leave power alone; mmc_init_card() will fully
> +        * re-initialize the card once the kernel resumes.
> +        */
> +       if (host->caps2 & MMC_CAP2_NO_POWEROFF_SUSPEND) {
> +               if (!mmc_host_is_spi(host))
> +                       err =3D mmc_deselect_cards(host);
> +               if (!err)
> +                       mmc_card_set_suspended(host->card);
> +               goto out;
> +       }
> +
>         if (mmc_card_can_poweroff_notify(host->card) &&
>             mmc_host_can_poweroff_notify(host, pm_type))
>                 err =3D mmc_poweroff_notify(host->card, notify_type);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a10..e082aab8f4c4 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -463,6 +463,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that ha=
s GPT entry at a non-standard location */
> +#define MMC_CAP2_NO_POWEROFF_SUSPEND (1 << 29) /* Card must stay powered=
 across suspend */
>
>         bool                    uhs2_sd_tran;   /* UHS-II flag for SD_TRA=
N state */
>         bool                    uhs2_app_cmd;   /* UHS-II flag for APP co=
mmand */
> --
> 2.34.1
>
