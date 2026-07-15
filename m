Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61D3D9667
	for <linux-mmc@vger.kernel.org>; Wed, 15 Jul 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106530; cv=pass; b=cCdmBaPwPVr19q1ixxq3qO+Yrr6BbQXSD2W0Z6+edX+K9Ts/+DXcwpewCS0yajQ3F55X9S5IorbqSHTpD/wpB5mVY+rwb74gZfYaHIO89AZHUztdDt7lG0/12KZQNCDwzOs8MgIvqxUWhEM7PGzmMG6cgTpcPt+IQ/LyQk2RmkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106530; c=relaxed/simple;
	bh=/AcugW1SLtFJv3o/LPDOfTqhwLEWDGNKe87L7Mxdy68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PodVpqr6Ofc3LbGh8AS5tbTzKlZQavmdceCuAuTKbAEBcGD3Z2bQTauEFpvXx67byIWpZEFt3iFJZoZUA3GXh5695jDV4nBTSrWuAb+9Ui0Ji9UD4Cxsh209iAMTRE6OlOyf7Nw1ymqyA5Ahy14PA7I+QwxzV0CpxmgT+82tZY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjQO47h+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ELt0Zwak; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjQO47h+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ELt0Zwak"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l4Gi2679667
	for <linux-mmc@vger.kernel.org>; Wed, 15 Jul 2026 09:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0s4UvEQjbDQF2ld7XgN78VAO8eHi8w7IlIEUGbUVuOE=; b=MjQO47h+G/ky7ZP/
	j8kG6VyYVGzZFEz0WuFuA2LE+aszAqo8E9xYzqvtH/YTc0CVYIcrbQUDuTaWtTOe
	5x/Ik2Q53EXNmQNwh75UcicAiWj7r9fOCRfiqs1A5Ix3169JSJ1BrPO/gXRKlbTO
	CQgbl5qUjuMFP9sjrGIS1TctXo0sLN852Tn9f/kkx3jsWF6QdsaGD+IPjsnpsjgI
	UweFeqhupPuq/79C1BdHUIQVST98Nu3PiznsbWFL8oPbkbaWHc0tn+kjXXAVIU5B
	hmusFKhgTHekiZSeY7vtZxQ6z+00N4ljAIP+iOzuf2A9b2dHr7F3JntliOgYj3qn
	A2LVYg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnuuy0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 15 Jul 2026 09:08:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1ada6c43so79741811cf.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jul 2026 02:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784106527; cv=none;
        d=google.com; s=arc-20260327;
        b=hzJZC1DJ7RFsz+Hn0cJsCAcCA6TA8sC7pz9iHLTJRRbM91/TC2Tz1LCE+NV7HARP/4
         J4J3Ja7pJohsWngTPTdInDFfpgbtBGepvmeZycv07CUzp/Ap3+b12AY52v8S9hLMMnbK
         WnqTPeBsVzkA2UjfqnkRCQp0hQdNXG0Z6HoOie+fjcwyeadZsup+BgyKiGObmhhiBo5H
         eWjotXEKTVAx65Q7dIjNHeLhJ8rsH2lPUL7UbTKCnasEuRhCuB0l9U1EheCCGAoNX5UC
         nXEh/bgkBGUkkphNptnf3xZMvGX7Valk3YrWeIkE+5B0kQ9xOliracoF5ca304h1V6fX
         imxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0s4UvEQjbDQF2ld7XgN78VAO8eHi8w7IlIEUGbUVuOE=;
        fh=0OKCF5DNuojb/smVmefNMNTgL2S2/DwjGIBSRr6Wfd8=;
        b=jpvaFhApO6gT3aXxbudbYlbgA9NdWuZsww5VKr2SgQsDziRrXeBut2Necf0oKCYKBD
         mCCE87M/St9S9sKLfFi+LQ9IuZi+wtETrRCCJyKkH9XRt5yZ0l7A1Lq4+io0FsJHqJuS
         zziKjinnhBLShliTWOuomN+lF21OMoKC5/aGsN1gJpmw/TbhaWVmMDxBQVD2nA4u6p9H
         Fp0m+dIV37WBh9yNGt5/SP1TKq2Z/MHhawk1MxXRCqh4egyTk0jo8oPf9+9L4UO15Xza
         6LHL0zLCwnNGzYgZZ+WcsULEMPwrAX96p29jtssmctm6BP1cmt2P6YcCiC3f+B6u9zLa
         IT+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784106527; x=1784711327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0s4UvEQjbDQF2ld7XgN78VAO8eHi8w7IlIEUGbUVuOE=;
        b=ELt0ZwakKQLpYIqFRoZi9wzcfCFAz4sSdGaY2ThBgzNTKxyFelWtuoHnITVH8fipn/
         vEOsvY0FHfw+P8FSVeky3Po9zSekrsi9eU61KRNqzG5FfTjoIw6cpnwWUGkQ5sMIbvQ3
         ond3ZeSnphh67Jx/WvfhmOUlQQJYN94bLb3hsx3OTqUcCNPuseDYStYxjDGG+dH4wsge
         /f+IdFPNBpIlZYrRReKbRPSUVMxpg9FQ2hyMYeWkTSGN40Sj50aIgaZQ8tZ/ptVwtiR/
         /N0B/GWUG2b/TobiQHihMG2Cw/WzgLf387VZI9UD3tVjrrzHbAy2KKM6Px6IaNXyGU33
         wmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106527; x=1784711327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0s4UvEQjbDQF2ld7XgN78VAO8eHi8w7IlIEUGbUVuOE=;
        b=FWk0tLOGA/Jd2n7NYWyCOSzMkXr7Xlsn1rG35vk7n5IiEEG6PTTdkCdXBMlKZs8yHI
         PHL4pGqaYhz3T7jdca1C/5dmgDresE0URF4suyO/4gtOJ+dRc7o9o0tOdLQwvsApVlT4
         sJMwUDI5lOyr1LrHR3sgeh166dzd+herMRfgpaR1RBSI7Ba2srE/Qxg9UXs5+lUPRluO
         q3AmboGZPWt1v7GBuISt1D2nVKPeSND05tpvep5krJGS1JD0qtpyOL/wpfpp3DJfoujo
         Q9pyQEYEj/r9qyt9ClaBGOUTTADKWgmCUuewqrUFPtyWKzdjscI84UMqS3P09VTHCBiX
         ZOPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGZktroJIJVFgg3T7jHcK8mn/SBxpQa/Hc9RKH///Fl6rmDmeXuXQTu9YnvW/TXmWtUFC0vxkeGk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOpOeHbEr7/AbPz4O3nA0ZCbwI/P19rTX0+ubh2nRFzB9PpFn
	8sILAhJ97SPfXW9b/JLKyEwrjffkFjQdiIFS2vioteXi5JCqcMYUelkleSWCnjBt3ZkaKRRFuWa
	EbEkh8JEWp6H02/F5W0MgH0ltcATKAPhuHDth8jFMCMv57WtbeIqHl3zaNhlpIHzbH7mrvTr8AM
	Yshe6zRwKfYBHlNXaUJWtPgBuQHsf+ZJoVpIQKpw==
X-Gm-Gg: AfdE7clbh/u9aEcPMlQAbzFYh2iwNY+21cBaeHT+zXgec7vODNCzQoRZts4UBB3r6dp
	eSbHDeS54hQc7QoHnfNr5E9Hyu0FzUjO/Ivh53EFh+rX33QEyzVzafiuvSTpDiXsgcQ2jxztdiS
	WD2MGkRqJOCiqTDe0yp7voA0sN1gRF0hSEpUnEA/bLvywIXw8KWG4JtPY+Ot1AvCbriRo=
X-Received: by 2002:a05:622a:124f:b0:516:d612:d1c4 with SMTP id d75a77b69052e-51e4f0a754dmr18899751cf.52.1784106527431;
        Wed, 15 Jul 2026 02:08:47 -0700 (PDT)
X-Received: by 2002:a05:622a:124f:b0:516:d612:d1c4 with SMTP id
 d75a77b69052e-51e4f0a754dmr18899531cf.52.1784106526991; Wed, 15 Jul 2026
 02:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:08:34 +0200
X-Gm-Features: AUfX_mw5_zd7FHkNF2aqrnmGS08lBZtf204AnFVjvOZno8cszHuFFX58iO0JEgc
Message-ID: <CAPx+jO8LALFoiB+7JkNhG9D3e+DN+D-iM0qL0T=UAw=BTouN=Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
        Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
        s32@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: VWXV9uB7ldfJYmSz_QURSUfXsh9AbpNI
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a574e20 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8AirrxEcAAAA:8 a=j4ls_bG9junj-QLuZ2QA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4NyBTYWx0ZWRfX409EgkliFu9I
 36l+7wQn/3rNPwajtu59f0qnJPpaorsQ8WQhHK+mZsgmrx1BVW+7/7MSEunv55iTpP6m3u+twcm
 8Ugcc/fesi8zl8iPKyqzVoWBcN0heY3HY9CrZHEbRC1eXhRyFW+OJnfGix/TQdGsopQYscQ/ShU
 dbIN2w2EFqtd9WqRInZmFOpf+dKyoGj4Bit0NwS20lzFMXTqohvqJNWjv0gZOYhoUmIZ4JvPjdc
 w8hJP53KVIvsZUHxmY0d909XgSfbCiE1BsZJolBFPGKsQuceXXxHl7lsoXJS7KgNtgiCWCaTde5
 8UEr0tpOzMfQP0KHfZN2vhrmFb6L1CvqFN75x75JK4+fvmnpiY8Zqk7P0Kt+MQlHbxoEgM8uZRU
 YpqdUkTkLZgNP1ImoNBdQkQDq/iem1UdUl93dhKUloKidzRJiFsaGlQYElKdCZ96R8E2B4uczF2
 3RLLPxfeVUanyIZPQbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4NyBTYWx0ZWRfX00WW+xiEU6rf
 cJ2qNMzshnUcKY9SjasB4n29sE52uKHRUVgcf8R+Qx4rVkgM393yyNUKURQqjM+fi3UBl8Pyp4U
 sbBpAbGL+4/g7by13FyViD2TN/hBT9k=
X-Proofpoint-GUID: VWXV9uB7ldfJYmSz_QURSUfXsh9AbpNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150087

On Wed, Jul 15, 2026 at 9:16=E2=80=AFAM <ziniu.wang_1@oss.nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> This series fixes several suspend/resume issues in the sdhci-esdhc-imx
> driver, primarily affecting SDIO devices (e.g., WiFi).
>
> Issues fixed:
> - Tuning delay values not saved/restored for out-of-band wakeup devices
> - DLL override lost after resume for DDR modes
> - Pinctrl not restored before DDR_EN is set, causing CRC errors
> - Unhandled interrupt during resume causing "nobody cared" warning
> - Various error handling issues in suspend/resume paths
>
> All patches now carry a Fixes tag pointing at v6.16. Patches 2-8 fix
> regressions introduced by commit 676a83855614 ("mmc: host:
> sdhci-esdhc-imx: refactor the system PM logic") in v6.16; patch 1 fixes
> commit c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card
> stays powered in suspend"), also in v6.16.
>
> Changes since v6:
> - Patch 7: Drop "ret =3D" for non-fatal calls (sdhci_enable_irq_wakeups,
>   pinctrl_pm_select_sleep_state, mmc_gpio_set_cd_wake) so they no longer
>   touch ret. Call them directly in if() to keep semantics clear and
>   avoid any risk of a non-fatal return value polluting the fatal error
>   path. (Frank Li)
>
> Changes since v5:
> - Added Fixes tags to all remaining patches (patch 3, 6, 7, 8) so the
>   whole series is properly tagged for stable, as requested by Ulf.
>   No functional changes.
>
> Changes since v4:
> - New patch 3: Fix esdhc_change_pinstate() to move IS_ERR checks for
>   pins_100mhz/pins_200mhz into their respective switch cases, so that
>   legacy timing modes can still reach pinctrl_select_default_state().
>   This avoids log spam on resume for devices without UHS pin states (Sash=
iko)
>
> Changes since v3:
> - Patch 2: Remove unused 'boarddata' variable in esdhc_set_uhs_signaling(=
)
> - Patch 7: Expand commit message to document intentional skip of enable_i=
rq()
>   and sdhci_disable_irq_wakeups() on early return, and explain why the
>   PM runtime usage counter leak is acceptable (Sashiko)
>
> Changes since v2:
> - Patch 3: Updated commit message to explain the SoC IP integration
>   detail about internal loopback path change when switching pinctrl
>   from GPIO to USDHC function (per Bough Chen suggestion)
> - Patch 5 (v2): Split into three separate patches (5/6/7) so each
>   patch fixes one problem (per Frank Li suggestion)
>
> Changes since v1:
> - Added patch 5 to fix error handling issues identified during review
> - Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
> - Make pinctrl and cd-wake failures non-fatal (dev_warn only)
> - Use esdhc_change_pinstate() instead of pinctrl_pm_select_default_state(=
)
>   in resume to restore correct pin state based on timing mode
> - Skip pinctrl restore for wakeup devices to avoid SD bus glitch
> - Check pm_runtime_force_resume() return value in resume
>
> Luke Wang (8):
>   mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
>     for tuning save/restore
>   mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
>   mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default
>     state restore
>   mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
>     resume
>   mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
>     interrupt
>   mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
>   mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
>   mmc: sdhci-esdhc-imx: fix resume error handling
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 91 +++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 33 deletions(-)
>
> --
> 2.34.1

The v7 series applied for fixes and by adding stable tags to all of
the patches, thanks!

Kind regards
Uffe
