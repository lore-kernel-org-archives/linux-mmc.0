Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801B3932FC
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253204; cv=none; b=YR/Y9QbfQcukESGgTKw9b1qQXVWX0UZYqIv21Zotj1JtobWnvTFtxe14GZQg5Ce4Z34T//pULoc4U3Vpe0byLtgouiOhMrFkVC8CXBa/M87FpijvzDOPCV2ln0HLYHt/4te9d4aWe9HwvTBlCYTAWEYZ0w27peHfu/qq9hRr1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253204; c=relaxed/simple;
	bh=lwN1MwVG4PyX3cM79mV8sU6kpbDpiMrRuAdutC2BaOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEW3cNqg5XZYGZ2XayCMUAxTDqb8d2ZHvhMzMcmpVhAxrr88TncheuN0K97U7vwARn5qsBpuqbX/kTCai8GELdwU8V9SoX9sybQnRTRxdIy+Eyiyjcsm05I6Zzg55cPchwmpDc3bkEUkUaGU7Sr5hYRscPFBSCO56gKsD1OGVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx4aDMYI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=At29DyAv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx4aDMYI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="At29DyAv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDF7UN979990
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=; b=Gx4aDMYIqARYD4Pe
	266DP0cghVQ3x+6RfeQxVpA++XSXASwMCZyiOlXvjpXc0kXvpLisEVBXI6G53FPN
	2jH3yda/CdH+EeXbuibHjk0khP91476PP+e2Ndwtq6tk8gQHsg0E6K2GQVuzgCjX
	afrxE7gfP3cfd5ZIFu6/boNFtHj10cwnolNszGH2uKSkPy+f21z24UyRyYdzuvc1
	6tSMaUhvQMP3ry553Aw1rLKK4DlDQ+7RVRstvhp6ha/2fy8nJ4ZQYHtIK7xHUV0Q
	ROKpdx/mFIim/7L2w1/caYxmykfcfs9TXUh888pi93GoaNFHVlR5GP1t+qf3K8Jo
	zhAoWA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxcnskk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 16:06:42 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c124d17880so88329137.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Oct 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792253202; x=1792858002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=;
        b=At29DyAvmxYDGlhdYzvM2G6bET85m9eXW9/Qx4hTSVapF9WH10UfXAYJwysdAcXL4z
         bRcI/nw2v+cAPi9I305JyrSUTCZcLfjUSpFVi73dSOpc9KlTixCoxWsXQiA+W+A0vTiy
         0hSHzNQcwoM1wQKpcVVIK3m9NlKtH6nn9PUE3O+cWs10sg3l6nWBC8myoT1VZSc2iir4
         3Lp7sA41TdNqbaKigdC/bY2BOsZ4S1xu6juTVSs+4wV5D9/aaQHg9OERxx/8QaOxJ3MX
         NPVjNOj54CYRlQ6H618MXrA+lkO8D8TZ4xbvrLtGuYtNXc0hX6YgCHgz9JPvgSniJP/J
         VDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253202; x=1792858002;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWUIJUNW++U4FJT90NmUMrUUvQId1rnNmsj7eMJfVuo=;
        b=LhFJMx8KLKF3rBPs9zMUliJ262zO/L0jW6cVHqMkPPb5IzrvPIb8s9PFWhSpewmP46
         pzp8bmiVEsyXslkTKqW+CjuSbO4/uZb3IoXc6jiBRZPckMqw8iOin1/LyNMmz79tXMko
         Jr11IHdHM8ue1UAgoPSRftTgdX8aww1JfVct0scOR4GasqCH+evsSck3WIkTZEwigY92
         tC8J5GwVH2RPwsibZoIdvaqE5xHdGoKlicBvhQmzMZjzm/QkxT0GDbjxD+T8QYXvCews
         lTN8oXtIV9dJzNM1Q+BP6HO8zP45FIRzAXaLOdFaE3kE16Q//IEAm+cUAfgqd/xQ+mio
         mjBg==
X-Forwarded-Encrypted: i=1; AKwUvBzpzOg2+9zOaK/76W1AHyyLKpETNT9oMnN2oyiMH4/icp7BQB/Up05CYdaz/Ym/QDYFX/A/C7i8eEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXTh9HsjLTj+oaX4ZfSwPmX8AWeLJd533JxokrOkpljcyFCWPg
	pCzh9lSz4S2aS0RhA0n7sM6rURhVdLNsEXnTGT4bZjYXfT+W3yT78wuuAIKCHZfPF1uShb09oPV
	nAVexnYu4Tr8ORV2uXfOLSPuzU/4lC0XRyR3AKOUyIuxBUY7pVza4ZsDWR+GQNOA=
X-Gm-Gg: AYBFou25lhkxNDuvuUaaq1ChfWW1QTQMT/cqFa5Rk2T+OZeIGy3KPRrwVw4jI12gR0q
	F5UCdOSWq+pe4vJ1RHFQDflG60DbcLqM8U3Z2VgYPBxE7XKljQEQEz8ZhUPT3q1FJkuBiNJoAIX
	ugOlkMXhS4n6CpDsHL6yV2B0/c1zOHhj8z3JMAzHhHWKlda+SNdzDAaN5TuCYmOCHkxKUmgUlmg
	l6LzO4kQ1Q97PKhzqVZbih/9eHEdN7qArRhu995JjddIDKjZcnjr2y5Ce9+dJVvnNWnagq4W5nJ
	IwTXo6XWfk7FRbzW14EnAi1tu9AQ7fSKqLyTUCsdin+yby5Dfka1QY4kZWIuJdt52Loc8MRdt3t
	qQvl6ppxcgeY3g/DGi/kBWs6KWF+FM11qk0H2hkKEylmP3cMWQS4AzCMvrwiPL1/LIMvXzozWOA
	47gEksKTHAuaxd7Gmfjo374uzgA2kzBGUIOq7W/JsLbL1WhsAodx1Sma4i9k+1OaHGVA==
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr721526137.31.1792253201305;
        Sat, 17 Oct 2026 09:06:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7c1:b55d:373c with SMTP id ada2fe7eead31-7cc36b04d29mr721518137.31.1792253200767;
        Sat, 17 Oct 2026 09:06:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1e9da2sm2126373a12.31.2026.10.17.09.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 09:06:39 -0700 (PDT)
Message-ID: <4665b4b6-1af7-46a7-bb86-68e9817b1eea@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 18:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] mmc: sdio: Set acpi_device.power.flags.ignore_parent flag
 on sdio_func companion
To: Ulf Hansson <ulfh@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-mmc@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20261017160448.77436-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BNUmP1QG c=1 sm=1 tr=0 ts=6ad39d12 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=mvwfG5SEgSwQCSBJfY0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: -PYiU_r1yrxttnpBjGsBvIKT8D2rR5a-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfXzDWGqVAlaMkE
 TkHj/gXTvEB+8vOrp8/zZvlBg+Ixv/8MMDx0B3s1+lm9hIaW4vVvG9PO9l0qB/uWwi9Pujsuzhz
 BAUef4NqYCfLSx8TuCtP8LhHzw7ANVM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfXxspqX04G0yZt
 SAD133XY4BFS95t38kfYT7pjkBhOfj4+0xEExU9yhXsYaoMPfrXLzJzTdNJjrEuB7QMQePF9JKn
 cGIbr0wwA6FdZq7CXcVO2+Yn67iKH5C+LEzlsJs/pCw1NrNNFHHafUs1m3Uimy+0flUZ0uKeYF3
 FOSIbzpavNRJyLEcecYrYAknN6urRLhq9+BVm0RY1HALCi1tTpVjaKeoIfw7ktF/H1COKCnR8uv
 QdjR9AKmQp75QKgUgbKB7gmalzi0nJIgX1RC1vxAVZEFx6s/0c0icj1MS0jCkz5lCb0Zz2bOj4f
 4pFqRfSR3S6s9fjihx/7nfeX/VlgdWTbksFatZYnq53UTY8hroebaPm8sG+fgxHfj2e56FncN9u
 zktCm1lPIa345DHuH6iF9I/ZZIX8tucwWKnKM2Fc2YUn1TCJiJCgXkoYacTTKh4Pd6MgEavwyi0
 uxYfjZAQ73sa8joIF0w==
X-Proofpoint-ORIG-GUID: -PYiU_r1yrxttnpBjGsBvIKT8D2rR5a-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170064

Hi All,

On 17-Oct-26 18:04, Hans de Goede wrote:
> Many MMC host drivers call pm_suspend_ignore_children() which allows
> to keep MMC cards and SDIO-functions on while the host is suspended.
> 
> For SDIO functions which are in the ACPI power-domain this causes a race
> where the host may end up runtime-suspended before the driver for a SDIO
> function loads and probes it. When the probe() looses this race this causes
> the pm_runtime_get_sync() in sdio_bus_probe() to fail in the ACPI pm-domain
> code with e.g. the following error:
> 
>  ACPI: \_SB_.SDHB.WLAN: Cannot transition to D0 for parent in D3hot
> 
> Busses using pm_suspend_ignore_children() for their children should set
> acpi_device.power.flags.ignore_parent on the ACPI companion device of
> their children to avoid this.
> 
> This is safe todo because drivers for sdio_func devices should always
> call sdio_claim_host() before doing any IO and that runtime-resumes
> the host.
> 
> Add the missing setting of the acpi_device.power.flags.ignore_parent flag
> to fix probing of SDIO functions sometimes failing on ACPI systems with
> the error mentioned above.
> 
> Also add a sdio_acpi_clear_handle() function to undo this, since the ACPI
> companion device wills stay around after removing the sdio_func device. To
> make sdio_acpi_clear_handle() the proper inverse of sdio_acpi_set_handle()
> also make it actually clear the companion pointer on the sdio_func device.
> Technically this clearing is not really necessary since the sdio_func
> device will go away shortly afterwards anyways.
> 
> Closes: https://github.com/MocLG/rtw/issues/2/
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

2 remarks:

1. This is a resend with Ulf's email address fixed
2. This patch makes the ignore_children / ignore_parent handling
   identical to how the SPI and I2C busses are handling this.

Regards,

Hans



> ---
>  drivers/mmc/core/sdio_bus.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 4b07098c33c3..fa1d300211d3 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -373,11 +373,27 @@ static void sdio_acpi_set_handle(struct sdio_func *func)
>  {
>  	struct mmc_host *host = func->card->host;
>  	u64 addr = ((u64)host->slotno << 16) | func->num;
> +	struct acpi_device *adev;
>  
>  	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
> +	adev = ACPI_COMPANION(&func->dev);
> +	if (adev)
> +		adev->power.flags.ignore_parent = true;
> +}
> +
> +static void sdio_acpi_clear_handle(struct sdio_func *func)
> +{
> +	struct acpi_device *adev;
> +
> +	adev = ACPI_COMPANION(&func->dev);
> +	if (adev) {
> +		adev->power.flags.ignore_parent = false;
> +		ACPI_COMPANION_SET(&func->dev, NULL);
> +	}
>  }
>  #else
>  static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +static inline void sdio_acpi_clear_handle(struct sdio_func *func) {}
>  #endif
>  
>  static void sdio_set_of_node(struct sdio_func *func)
> @@ -402,6 +418,8 @@ int sdio_add_func(struct sdio_func *func)
>  	ret = device_add(&func->dev);
>  	if (ret == 0)
>  		sdio_func_set_present(func);
> +	else
> +		sdio_acpi_clear_handle(func);
>  
>  	return ret;
>  }
> @@ -414,6 +432,8 @@ int sdio_add_func(struct sdio_func *func)
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> +	sdio_acpi_clear_handle(func);
> +
>  	if (sdio_func_present(func))
>  		device_del(&func->dev);
>  

