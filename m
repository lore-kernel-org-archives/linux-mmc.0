Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FE4071C6
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689609; cv=pass; b=TOld/MT6ezww7zSWlN+O2tdXVOcC01dgnwE7BhBneXLz9Uu/wrS4O4dgugD2rKcGSX5dZpLrTRygR8JEaKAuGOv0PsVGgCf3KR/jEAlpseXbPec18U7OgLmabC73cvCMBKae9fP1NzNLauZ3yju+Ruy+ggW0VCsFkRG9ox0GIho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689609; c=relaxed/simple;
	bh=hqFXr31iND0t+oWxM2LNH1lwtdOVb5fT6YPXD1RJ8IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKygc7nUT8BO8kI8dmVvaaVxZWhpYfyNrwtyNSVNdjOWXIBPTsToBUECQF4/lSox4W9AwByXylRJbSPEq0xiJmXk3beQ28Gbc5o4YL/WBZExqiXcvfX3Mzmf9d6gT1JH8EXuIP8R5d+fmRmDQDT3JwhH6+6jLYrde+bsz+TfI94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuN5/hxm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YI0MDp0z; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuN5/hxm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YI0MDp0z"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD5uBK910230
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+IKDvfDzFGbwqSYx2nsASuQ+2zeb1K3v/PA/7fdhfbg=; b=FuN5/hxmAGVOeKhz
	TBXLUDz7Km+ZWilvTYvYtq3PFQOnOSWFHA9opAz/gllgit5tdnJLEJoQDle68SNV
	pL7XLqwHz+8JmHFQz633EBnbhjNVFtvXiT/nHHc2OaWH9eGzMf8r0XR3baY7F79U
	3c7cgG2tN54fgBFVhUMmCUf2TKm/5JzINDRGTYay3B15v1bou64+t5n1DeV6tgmO
	H47tazfJIhW0OLhyODJadCuDBCnO2NQaN5gYP8YLWR85cvFVMWa+LNh/d78N3e7U
	uAiPlZkQqYmN5LTQQpcP05te26eHk+Qz7DPUrRcN0aeTjD+h9pRBW1UlA3AOlqG/
	emJzgA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwean88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 13:20:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e695a3b28so222219785a.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jul 2026 06:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783689606; cv=none;
        d=google.com; s=arc-20260327;
        b=e3sXp+sec1/aV/HG72pqy6zMGSp8+cUG9NWhl1dv85rH4i0wRuBF/TzHJwFsUYWFtK
         UNtaseSYT3aBs9LqSs+7Xjtiul7ECG+EISmjjdHWx/THy1uYn19I4kKrrvEdTuKcLAEG
         9LVviqNQ4uvLpfY63dr8p6RCWSJ6P8QxJtEGwcnxuslRpoy4mo80D+cQf/AsvaQya/u+
         3GL+ruB0SIrGuAHPuX0G2CyuxhNpuqSNdaXXqxbJplCKTUcR/aq3YWXClk05RyzC31l4
         1ZjF1gTRvn4AdzW14AKdRGqrIBbB/nHZkNG3eLBLPMpLbJ/x/1ZwQZisfbiDIRMFDeR6
         mtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+IKDvfDzFGbwqSYx2nsASuQ+2zeb1K3v/PA/7fdhfbg=;
        fh=Q+c9KwE426XVUBjnJ3XkCucRjTIGR9iCQkE+t4dRadc=;
        b=s0s+iixINAl+2pMjBhqWLjFf9o6YEus/pDtfuwhMCR95eIg55OWPSGAN1Y4lZ60c6x
         PUda7C3jAiJzOFEWU5NAu7lHAud36nEefoJ9W5Tagjs2Hxl2R0YtrnDPpR/pfvgetAU1
         j0cfXsQ9u90yzEkFViUk0bDqvk8rIXlZfLf69wIP2B4FsKbGsdc8z0M0ukngjHwGnGAA
         q3P/7HT3Bi4e1nLV+6oeAuvHQapxg8eJIaew+/+apWU3TG5FVpWUyZHNbvyAOBFqm23O
         6fibLcFwxgZj952pr7smA6XscTqIVPmtGE5h++QIoKZAyxNU4fYFq5BUcxgNBsbyZCvE
         8J4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689606; x=1784294406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+IKDvfDzFGbwqSYx2nsASuQ+2zeb1K3v/PA/7fdhfbg=;
        b=YI0MDp0zJGbGPSaeDREjn0n34Y6NR/1/z97dYQwXDiFsqTV2P2HQGDgJSu9w7U+Es3
         RduZZ2D/KvuWGv9BbagujyN7f9aElN5/Sc6UmJVaQV6GbqU/Y4blfZiReYFkBMhKuCoh
         lyrWKtTVUZ4VeHeTRyd/9pcZEnO6xt5UG/ZtuNXKrl+S+344LlqkX03xFMuefsqwaQ3F
         0JEwEYjZ792GlL9CkH8lkza2NAwh2zpQJ5zNagA0Wj3wAQjT6K3/RbLqIwY4PrS9ocHW
         bAMAS3Fhe61f0fExHD5l9RaaOPRhV2ivpCzQbBOVDtiMmnhwCbbQNYiwKuLL5+W5xvsI
         YCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689606; x=1784294406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IKDvfDzFGbwqSYx2nsASuQ+2zeb1K3v/PA/7fdhfbg=;
        b=f2vaOQltrkfLvZHQ8XHAz1nfb7nUzbrm5w9SL74r7w7EXSIOuOSFKr0r4n6SAHO63y
         IMxZ6r+gzXS8BBQGc7+R28u/BmskF297Qg3XPtEsjahTMSTNlOuXK7y60vhdkt5IRvEF
         W5qiDU7jnldB0TQr0RvwzN0J6bCqsLkIr8H+q+He1nqIDK/3BCiPRZDXbChCD6JqRAuU
         aE7I5GkvUb7ZhlWKQOVAmPRTkYtw3scCv3cyzGhe6CTtYkgdsRe3OxjyC3YwHr/POD6B
         a1FQpUpYA9rRkFPTqO/0taPhsJQjDWXyBkh6tgKJK1aF8u7hWzAL6rX8oAWTcU30YDQj
         1qQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3YAlexashshBW1p8GgJtl/7pKnJPNsVYCzNcLfHDACUVbaU0fT7g3fXDaOBfbvMHY/hZ2Lxn76Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxM81hKUAjPrGJJrV+73Lbkmnfi1PoTNp+9OZsNmgpbhp2yNq
	qSi9PLS9aT1/6AzuR3W4gxscC1l+bXMoZZFK4atjss1oOtRGwGoTACm+gGCVjsKNkAM3p2MZN2D
	x/s1RUechdW8Yu6XuXcoGPfahcMOJjDIhFMTNxgdz9omGkxb7F5L2r3/FOHwyxCJvh7JIjBwMxq
	d3VKY/vtYE05UQ+Rl0yiospRStGNGh9Lkx5PtpsQ==
X-Gm-Gg: AfdE7cmTlO0qYOeKzAHhCWb2I3Q0833u4yNFrXwAwfRizvjR3sHY1owaFeLnci8THXO
	vRGI0Hj4oua4OvAfXwcuWYB0vpJmtaQTXrQ5Okmi5Phck+ud7WQF6F4cSzU67WHUOerdrzlNjQB
	el5o15PAhpCMGSIsI5YGcKOE1unW6YyVbVgx/GflF2adCWjm4PrJiS4aTQhfoOY6jj0i7O
X-Received: by 2002:a05:620a:3703:b0:92e:5949:3567 with SMTP id af79cd13be357-92ee4b9c9c0mr378848285a.14.1783689605927;
        Fri, 10 Jul 2026 06:20:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:92e:5949:3567 with SMTP id
 af79cd13be357-92ee4b9c9c0mr378840285a.14.1783689605263; Fri, 10 Jul 2026
 06:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:19:51 +0200
X-Gm-Features: AUfX_myX85sm0CK23HsaVBWLtyuOsQFVaWPiXZvcMl9d2lwceyk99PJTRc2r1Fo
Message-ID: <CAPx+jO9PrycaUM2j+BS=pa994DzWqYN_yQQk7=pwkq+ik-xeFg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume issues
To: ziniu.wang_1@oss.nxp.com
Cc: adrian.hunter@intel.com, ulfh@kernel.org, haibo.chen@nxp.com,
        Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
        s32@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50f187 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=8AirrxEcAAAA:8 a=j4ls_bG9junj-QLuZ2QA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX8VtBJBbuatF0
 +E87fU6cnfWVL6XKwPnWLZ9cwgJ8GsDoQ1hH6nS4ytDlEL5gQwnfhlviV96q+2f2Zsbxxx7pduQ
 hV4D7K8Aa08Z3LfWU6RjXfJp3d5T1y10JRyemcsDaddTke0t2ZxSGdz5ekpPR0QwIFDBc41gZGZ
 dPcM8Ghl8/c41bbhzBb/9F+wZNcfdEjbcnEkxMx+raKZWqyPZmvfbMidjbsvDTwJVuHVRh8j+e5
 upMDAqCeYay+Ewz9YocdAWw6wP0T7uAihoXmHVYxxy0JgWCyKFMJZrhiReuTa66P198x4k6ZZm+
 y+t1TWczxNhzRiALl78DIt+NqICNm8WNYfdmov3lodJ8DO2unHks1laZdWn+IiNYqTkjiQECFft
 6vBwy4iHK51UqIjdID1SL+apHPCu33Na402PI11z4T6zTHdeDOmt31yHOol2I3QfZiN8psAVZUh
 Dbh09IyXcXJKYT9mO4A==
X-Proofpoint-ORIG-GUID: xOsM30LU6eiGkIi6pDPjgcMxdFL_KcrZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX+rx+n10LQh5Q
 Ju5dXGfngnEYskgGrv822FGowHyJJmn3t49Trc6P0BGzVDr5cw4zqwLkPtG4AytI/ZZOnpV7WmF
 i5Z8Hl6sEUNE0RP7EQbwAKtmotqVigQ=
X-Proofpoint-GUID: xOsM30LU6eiGkIi6pDPjgcMxdFL_KcrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100132

On Tue, Jul 7, 2026 at 1:00=E2=80=AFPM <ziniu.wang_1@oss.nxp.com> wrote:
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
>  drivers/mmc/host/sdhci-esdhc-imx.c | 84 ++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 27 deletions(-)
>
> --
> 2.34.1
>

Looks like this entire series may be material for stable kernels, but
perhaps it's easier to manage that through manual backports to do the
quite extensive changes? I can certainly tag the patches for stable,
but in that case we should have a fixes tag or specific kernel version
for all patches in the series, can you please help with that.

I am leaving a few more days for reviews before I queue this up for
next to get it tested.

Kind regards
Uffe
