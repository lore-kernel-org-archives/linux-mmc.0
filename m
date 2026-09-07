Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120E4C77D9
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789554; cv=pass; b=mLChwSgjHgZ8/uDLsv+vD3P3CL+liGuyaDv2aw2fqGmscGzL+sTRx38M44b30gCn7vR0lYJHmVXsiZlzP/HkiJpO2VoyJ189EAE6bzX9WbQywOZxZi+gTyRfi9sl/4AsfZPb3/Zdi6FJ5Uh4bGfmfrYQC9RFLp+3c+DsqK5xP40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789554; c=relaxed/simple;
	bh=NwJeYH9HfWoQA0+pi04qpdp3qkisLDGogZ9NUcnKXUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxXzZalKRM+ZLmU3cRoTajIGMeZBNg7wy6OuhrnASG0kCZHS/kMraoQh+OtbcZckdJXLw9iQRgX8eanePcZ/1aptGc9Jo58V/D/o/F7qfIRqq3ZrQV5Jiy3c7nIRp0XofujbrvvtNAwXlqKCBPsFqU+U8O+aSAgPFcGDyWmOEu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eALyls0p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kC+veldk; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eALyls0p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kC+veldk"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdIKQ3025740
	for <linux-mmc@vger.kernel.org>; Mon, 7 Sep 2026 13:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VVHg/deeZB88z1FdYVwHtMFQ845sPnDM9+iWyblIrc=; b=eALyls0puU6WI7Or
	cv3dOhIrfQdwpkdEpAlcJ2RQq8go8DsnVvHdi2OrjJACRMMkRQAmPPtijpRdh2dL
	LvT/LcpqgFMnTKkFa+zuhXMt7ruHxhHPidItl7pXHnTbf1z00GgtXLtkAAOKiH9V
	yhctgIDH9VHF2pLN12bhbz5xe8IPxepZl8XUcXU5DkEg4zSoeKVGqqGR+9J9Zs2Z
	00oz1DJ0foKyGUIe8UXIL+CHj18QMENlFqXIvgXb5DQ93GYstdYVzjscRMlstu+H
	0l3yZ4ZCxnbMBxHVe+BAUQ+SDBkWEkB8ISE2E0qVNRSsB2ltV8F9OGugqFtEcghX
	MRIiIg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0xg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 13:59:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d9336581a2so58053565ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788789551; cv=none;
        d=google.com; s=arc-20260327;
        b=Roo9AZRn8JglyjkfiydKuxqsa8/r1/u+X5mEW5C1kbOwvQWrjgoc4XxyG0uAVx5PQL
         k8eSr8/cJcvtfciunsPWUCcsBeCPis02yERG8HHr/p0/rvvV56WLsliyeiMfIk9O5p5l
         F2eBgG/akwADZRhXjTMLrT8OzZVH5p1HOQHpFos5cIPB7WPsyJJeO5r6nN8fWMINuQiU
         j0w7KbvWzrytYvimktegVESvHwEGEvbwDmI/UEQcuXK5bVoeA7WJdts8M1Navn6f/Hoz
         q3HBBhQeyi5BwHVDVHMEIFA7AxCfpmkdgJ1NdZHrcEqD3l5pR8OZAPwgaSzSR+KipYFZ
         V+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3VVHg/deeZB88z1FdYVwHtMFQ845sPnDM9+iWyblIrc=;
        fh=eOkU53YCi/qJJkkCzYEaB5793k4tCjloF46gl7Wgrfg=;
        b=V6ddDFKbP3kqQxGsIIs+U1W41/QgkfGGFu+aydAA+TXWpIAW9zx+iQngW+2UUaX/yF
         N49xUQbO9Q1gjA7X1gX1IKK0OS2mu/cJofvqnENqVcu4IIvlairZ3bhJyayaWBCQxjAK
         Qw8uhAgP3Ezz0sU313JAdTKy33pzudgGAVrVjz0qusly6u0STn54fIagVHS0SxyjSMmw
         K6V4V2B2kHzJKQeLGJXJ4LUSFsln53Dgsf30kH+I5q+cxsyPog0fySDGtVHpPcA/iCCD
         VX/wqSVUJKEMaJtXUTg7NL8K8FydWe5mOshEGIKFqFDCZyrSzoCwfGr9VVG1JKFvW2PD
         vGhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788789551; x=1789394351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VVHg/deeZB88z1FdYVwHtMFQ845sPnDM9+iWyblIrc=;
        b=kC+veldkFp9kjOYANu5K9Ch/AjPbHUu6k3R+HfaOGt+EqF04tJl3KDNKsfMjfEsxb3
         e9p5SPnC/ttnG6+l/unhuom12xhHpM9t35M0n8sy0SHQbYwOc2q60K5gfrZQVrHO3clV
         uuNP03MjpeHEeKinKhmvLqq59+bnjyYL89ePwWAeKUkk/7tkKW7PTD63JJLBTO7D5DdO
         kVKHy0nQaDy14lfFezW5O39wLjPhGM5UXCXl+2dnb1/5aERdEZ5+aXAeL24EDIUr8i3V
         nInNkLLNoaeq7ue1SW2KOxaTdGd2Q3TqEgsAaTp4PbHyIyH9svnlOPZSCzkDNQEDwsOM
         YCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789551; x=1789394351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VVHg/deeZB88z1FdYVwHtMFQ845sPnDM9+iWyblIrc=;
        b=oZZE7lW0DgQGSf92GlBOUzSk7TF2X76DDzjgcQMOeQtutPQ+r7n6sz/LmBN03HXEgS
         yXS/41lCKGZVT+KM3EK14t8q8QuiC3nxUJxHqPv3mTRLdVwDysukfGxubW9K6n5g9U4p
         pBTG+dnyOEfafscyqTrJ2fQb5Vd8Nd8N5qK3H7+lVw4SzfEMLqifD3iitq5ssZ6gC5pV
         Mt2NC3j+acI+uPZfPrV7p8vnfeu+tk7WR4lsW23uXEsOeq04uEkgjVgodyQJXDuvRgPU
         l6z3DjvaUUfbOSu0RgHDN2BW+Ddg9sv6XKp5L5wrLvUejSgcVdFGAcstVPtkLOBJvxf9
         3FJA==
X-Forwarded-Encrypted: i=1; AKwUvByQp2ZOHSLdBGvqLB1eYMe/MCsurJi/Vzo+C9R9IGX8dQVW5ZXbhj64FQD2SCV6NeY50OHjqvqXgQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++kP7wqa3JWr67JAN3EQp0BsuLFVdKKwa15UUUtBv/U/YPlHPizc
	+/Kkxeoe8Bwdo8+Lh7ARDDFEsYpitjG86lkQ/Icoe0sPuxMDUqXuW2DPfCArIFmJtSldnfJKvEL
	VJLcN8vfrUln6dqoHVwUU9Qpwsqkk0auody/46cpIn0f+MUjrWOsaVeah7IpIy57DseUP8RLG23
	P8EzW1dUPaJYu9gxTit6C4ET5k1qCWNx+WPA5ZsA==
X-Gm-Gg: AYBFou0z4t4hUZKk62CTpzhMX1NeK1P1g9YNv8A50RIRPgU7YVQ/D3me9BN43ULaV+1
	GLRMUktMOydaXGnd+s84J//xdq1olazv6kS+VQ8HmrUzkWQ3/J3Il8/PvBFQav56cXOGSR0r9Ik
	UinOi97yBcqCNUkJMF1Hy2VuL53BY8BD8oQR9fzx8CtvlC3aHUsxk5b7PJyw==
X-Received: by 2002:a17:902:fdab:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2db122edaa3mr333592405ad.3.1788789550484;
        Mon, 07 Sep 2026 06:59:10 -0700 (PDT)
X-Received: by 2002:a17:902:fdab:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2db122edaa3mr333591535ad.3.1788789549864; Mon, 07 Sep 2026
 06:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811163810.1599747-1-kamal.dasu@broadcom.com> <20260811163810.1599747-4-kamal.dasu@broadcom.com>
In-Reply-To: <20260811163810.1599747-4-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:58:58 +0200
X-Gm-Features: AcwNN1U7KUEyYnfl9_qJKr_fb1jhRRgzZJDm_YSNUThEHQk94Bvc8gLTjUePlxo
Message-ID: <CAPx+jO9Gpjb5b8ZpYypCshxKaaK80b5t2TJQTb-pCzas7z8q_A@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: core: Honor keep-power-in-suspend and
 reset-card-at-resume for (e)MMC
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
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9ec32f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8
 a=FONrPqi87L_Oz8XYBr8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: eZLNIQaAoFnMGgF4M-Jv-DwYTMoFxcq4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfX3LrICAqsN6RY
 LCza62WAFcl2YGIp5W6FAakJJS1RW07MUqQDsYQ6mA+ZDwAoBMlt5FoStrQbzGVpsAr4IVOjzFH
 swY3JQ7jXySgNxmLCld8CFqJuoz0P2c=
X-Proofpoint-GUID: eZLNIQaAoFnMGgF4M-Jv-DwYTMoFxcq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfX1aF0Yrx9vlUc
 Ofxtsh8qgNK1Q6/u0vQTRE9tLYWm0mABu6UcXxDaLjwDXNOX+pxweucrGzdm+MKJCR/NtHX9o78
 VvqpAsskyRI8BeNYS6bEBRCpdbh7CoYpAhUFB29V3HWwLnkM17VryZcKO0CMywXVq7O25g6/v2a
 NbmMkc13KB/TPd5Hp06g8O09l8L2XaQwaigUcd1m0+Vf59kTShgtdR0c4OvKCazyrzIBTTwSGDD
 qy21Y5xfvICvM7Y4t8BUXcbmw/cFflVtXxTFXCAtBzLp5Kz4IibghSqd09FSVdYjWhtsueK5Rn/
 1N7fTYnBlFr88XXbYcQKR7t+DAvL24SNjUOvmfSLvDMMcfZKvw8LYDCKEKHFrvEER/dyyVKNl09
 VgryUrH+7e+sj977LhcC8Vr9J8SVdVwK2Q4QwF+kvhM6/i0h808b59NCAqnBSnhYpX13kfzJIgp
 RKomYA7StXcSN5Ko5lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070155

On Tue, Aug 11, 2026 at 6:40=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> On some platforms, firmware accesses the (e)MMC card directly during
> resume from Suspend-to-DRAM, before the kernel's own resume path has
> run, in order to load boot code. This requires the card to remain
> powered and responsive throughout suspend: putting it to sleep,
> sending it a power-off notification, or removing its supply is not
> safe, since firmware needs to talk to a live card. Since the card is
> never power-cycled, nothing else resets it back to a known state
> before the kernel reuses it after resume.
>
> keep-power-in-suspend / MMC_PM_KEEP_POWER already exist for the first
> part, but are only consumed in the SDIO suspend/resume path
> (mmc_sdio_suspend()/mmc_sdio_resume()), gated on a per-function
> runtime request via sdio_set_host_pm_flags(). (e)MMC has no
> equivalent function-driver layer to make that request, and the
> requirement here is a fixed platform characteristic rather than a
> per-cycle one, so _mmc_suspend() checks host->pm_caps directly
> instead of pm_flags.
>
> reset-card-at-resume covers the second part: when set, _mmc_resume()
> resets the host to its initial bus state the same way _mmc_hw_reset()
> does for a non-power-cycle reset, before mmc_power_up() and
> mmc_init_card() re-identify the card.
>
> _mmc_suspend()'s fast path requires both MMC_PM_KEEP_POWER and
> MMC_CAP2_RESET_AT_RESUME to be set. Keeping the card powered without
> also resetting it at resume is not safe for this driver: skipping
> mmc_power_off() leaves power_mode at MMC_POWER_ON, so mmc_power_up()
> no-ops in _mmc_resume(), and without an explicit reset first,
> mmc_init_card() runs against whatever bus speed/width was active
> before suspend instead of the initial state it expects. Conversely,
> _mmc_resume()'s reset checks pm_flags rather than the
> MMC_CAP2_RESET_AT_RESUME capability directly, since pm_flags is only
> set when the fast path actually ran -- the only time power_mode is
> guaranteed to still be MMC_POWER_ON, and so the only time resetting
> the bus before mmc_power_up() is both necessary and safe. Without
> that check, MMC_CAP2_RESET_AT_RESUME set on its own would drive the
> clock and bus lines while the card's supply is still off following a
> normal mmc_power_off().
>
> The fast path also leaves the card marked suspended without powering
> it off, so _mmc_suspend()'s pre-existing early exit for an
> already-suspended card can no longer assume there is nothing left to
> do: a shutdown, unbind or undervoltage event can still arrive before
> the card's next real access lazily triggers _mmc_resume() via runtime
> PM, and those events need the normal power-off sequence regardless.
> Reselect the card and continue into that sequence in that case,
> instead of returning early and silently skipping mmc_poweroff_notify()
> and mmc_power_off(). Reset the host to its initial bus state first,
> the same way _mmc_resume() does, since firmware may have left the
> card in a state that doesn't decode reliably at whatever clock/timing
> was negotiated before suspend -- otherwise mmc_select_card() itself
> can fail and abort into that same early exit, before ever reaching
> the sequence it was supposed to fall through to. If mmc_select_card()
> still fails after that reset -- the card may genuinely be gone -- fall
> through to mmc_power_off() directly rather than aborting again:
> unlike the other steps here, powering off doesn't need a responsive
> card, and shutdown/undervoltage need the supply actually removed
> regardless.
>
> host->pm_flags is set alongside marking the card suspended, and
> cleared in _mmc_resume(), so host controller resume handlers can tell
> power was preserved if they need to.

While I certainly appreciate a descriptive commit message, this is a
bit overwhelming. Please consider making commit messages a bit less
wordy and more to the point.

By reading the above, it becomes clear to me that we should really
split this patch. Both for reviewing purposes, but also to use the
step-by-step approach.

I believe the first the patch should take care of the updated
interpretation of MMC_PM_KEEP_POWER for eMMC and a second patch on top
should deal with the "reset-card-at-resume" thing.

Anyway, I understand the code in the mmc core for power management is
somewhat tricky to follow. Rather than continue to provide you with
in-depth guidance and review comments, allow me to spend a couple of
days trying to make the implementation for the above and send out a
few patches that you can test.

Kind regards
Uffe

>
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainel=
li@broadcom.com/
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
> Changes in v9:
>   - Sashiko's AI review found two more High severity issues in the
>     same shutdown/undervoltage fallback added in v8:
>       * Calling mmc_select_card() straight after finding the card
>         still marked suspended assumed the card would respond to
>         CMD7 as-is, but that's exactly the assumption
>         reset-card-at-resume exists to distrust -- firmware may have
>         left the card unable to decode commands at whatever
>         clock/timing was negotiated before suspend. A CMD7 timeout
>         there hit "goto out" and skipped the power-off sequence
>         entirely, the same failure mode this fallback was added to
>         close in v8. Fixed by resetting the host to its initial bus
>         state before mmc_select_card(), the same way _mmc_resume()
>         already does before touching the card.
>       * Even with that reset, mmc_select_card() can still legitimately
>         fail (card genuinely gone). The code still unconditionally
>         "goto out" in that case, skipping mmc_power_off() entirely --
>         but mmc_power_off() is host/regulator-side only and doesn't
>         need a responsive card, so there's no reason a select failure
>         should leave the supply on indefinitely for a shutdown or
>         undervoltage event, or leave pm_flags/suspended state stuck
>         retrying the same failing select on every later call. Fixed
>         by falling through to mmc_power_off() directly on select
>         failure instead of aborting.
>   - Patches 1/3 and 2/3 are unchanged from v8.
>
> Changes in v8:
>   - Sashiko's AI review of v7 found a High severity issue: the
>     keep-power fast path marks the card suspended without powering
>     it off, but the pre-existing early exit at the top of
>     _mmc_suspend() (for an already-suspended card) doesn't know that
>     -- it just returns immediately regardless of pm_type. Since the
>     system-resume path only re-enables runtime PM rather than calling
>     _mmc_resume() directly (that happens lazily, via runtime PM, on
>     the card's next real access), a shutdown, unbind or undervoltage
>     event landing before that next access would hit the early exit
>     and silently skip mmc_poweroff_notify()/mmc_power_off() entirely.
>     Fixed by reselecting the card and continuing into the normal
>     power-off sequence whenever the card is suspended via our fast
>     path but pm_type isn't a plain suspend, instead of a bare early
>     exit. Calling _mmc_resume() itself from here isn't an option, since
>     _mmc_suspend() already holds the host claim.
>
> Changes in v7:
>   - Sashiko's AI review of v6 found two real, complementary bugs in
>     treating MMC_PM_KEEP_POWER and MMC_CAP2_RESET_AT_RESUME as fully
>     independent in this driver:
>       * keep-power-in-suspend without reset-card-at-resume: confirmed
>         on hardware to hang -- _mmc_resume()'s mmc_power_up() no-ops
>         since power_mode never left MMC_POWER_ON, so mmc_init_card()
>         runs at the pre-suspend bus speed and CMD1 times out.
>       * reset-card-at-resume without keep-power-in-suspend: the reset
>         block ran mmc_set_clock()/mmc_set_initial_state() ahead of
>         mmc_power_up(), while power_mode was still MMC_POWER_OFF from
>         a normal suspend-time mmc_power_off() -- driving the clock
>         and bus lines before the card's supply is enabled.
>     Fixed by requiring both capabilities together for the suspend
>     fast path, and checking pm_flags (not the raw capability) for the
>     resume-side reset, so it only ever runs when power was actually
>     kept this cycle. Verified on hardware: the keep-power-in-suspend-
>     without-reset-card-at-resume case now correctly falls through to
>     a normal power-off/power-on cycle instead of hanging, and the
>     paired-capability case is unaffected (still hardware-verified,
>     now with an extra confirmation run after this fix).
>
> Changes in v6:
>   - Reworked around Ulf's two-property split: dropped the
>     unconditional mmc_set_clock()/mmc_set_initial_state() reset from
>     the suspend-side fast path, and instead perform it in
>     _mmc_resume(), gated on the new MMC_CAP2_RESET_AT_RESUME (from
>     reset-card-at-resume), matching the property's name and
>     description ("before the card can be used, it must be reset").
>   - No longer touches MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-
>     suspend at all -- that capability and property are gone, per the
>     v4 rework; this patch only adds MMC_CAP2_RESET_AT_RESUME.
>
> Changes in v5:
>   - Only set host->pm_flags |=3D MMC_PM_KEEP_POWER after
>     mmc_deselect_cards() succeeds, instead of unconditionally before
>     it. Otherwise, if the deselect fails, the card is never marked
>     suspended, _mmc_resume() takes its early exit, and the flag never
>     gets cleared -- leaking it for the rest of uptime.
>
> Changes in v4:
>   - Gated the fast path on pm_type =3D=3D MMC_POWEROFF_SUSPEND; it was
>     previously unconditional, so it wrongly skipped the required
>     power-off/notify handling during shutdown, unbind and
>     undervoltage as well.
>   - Set/clear host->pm_flags |=3D MMC_PM_KEEP_POWER around the suspend/
>     resume, mirroring the SDIO convention, so host controller resume
>     handlers can tell power was preserved and perform a soft resume
>     sequence instead of assuming power was lost.
>   - Dropped MMC_CAP2_NO_POWEROFF_SUSPEND and the no-mmc-poweroff-
>     suspend DT property entirely. Reuse keep-power-in-suspend /
>     MMC_PM_KEEP_POWER instead, per Krzysztof's point that the new
>     property described the same contract as the existing one.
>     _mmc_suspend() now checks host->pm_caps directly rather than
>     pm_flags, since (e)MMC has no per-function driver to make the
>     dynamic sdio_set_host_pm_flags()-style request SDIO uses.
>
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
>  drivers/mmc/core/host.c  |  2 +
>  drivers/mmc/core/mmc.c   | 98 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/host.h |  1 +
>  3 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b7ce3137d452..1622f7846441 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
>         if (device_property_read_bool(dev, "no-mmc-hs400"))
>                 host->caps2 &=3D ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1=
_2V |
>                                  MMC_CAP2_HS400_ES);
> +       if (device_property_read_bool(dev, "reset-card-at-resume"))
> +               host->caps2 |=3D MMC_CAP2_RESET_AT_RESUME;
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_=
type) =3D=3D 0) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 05444ecf3909..3a0855a4ca44 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2144,8 +2144,55 @@ static int _mmc_suspend(struct mmc_host *host, enu=
m mmc_poweroff_type pm_type)
>
>         mmc_claim_host(host);
>
> -       if (mmc_card_suspended(host->card))
> -               goto out;
> +       if (mmc_card_suspended(host->card)) {
> +               /*
> +                * Nothing to do for a redundant suspend call. Otherwise,=
 the
> +                * card can only still be marked suspended here because t=
he
> +                * keep-power fast path below left it powered and merely
> +                * deselected -- reselect it and continue into the normal
> +                * power-off sequence below, since shutdown, unbind and
> +                * undervoltage need mmc_power_off() regardless of how th=
e
> +                * card got here.
> +                */
> +               if (pm_type =3D=3D MMC_POWEROFF_SUSPEND ||
> +                   !(host->pm_flags & MMC_PM_KEEP_POWER))
> +                       goto out;
> +
> +               /*
> +                * Firmware may have accessed the card while it stayed
> +                * powered through suspend, leaving it in a state the ker=
nel
> +                * can no longer assume it knows. Reset the host to its
> +                * initial bus state first, same as _mmc_resume() does be=
fore
> +                * touching the card, so mmc_select_card() below is talki=
ng
> +                * at a clock/timing every card is guaranteed to decode
> +                * rather than whatever mode was negotiated before suspen=
d.
> +                */
> +               mmc_set_clock(host, host->f_init);
> +               mmc_set_initial_state(host);
> +
> +               if (!mmc_host_is_spi(host))
> +                       err =3D mmc_select_card(host->card);
> +
> +               if (err) {
> +                       /*
> +                        * The card still isn't responding even after the
> +                        * reset above -- it may genuinely be gone. Nothi=
ng
> +                        * else below needs a responsive card except
> +                        * mmc_power_off() itself, which is host/regulato=
r
> +                        * side only, so cut power directly instead of
> +                        * leaving the card's supply on indefinitely (and
> +                        * pm_flags/suspended state stuck retrying this s=
ame
> +                        * failing select on every later call).
> +                        */
> +                       mmc_power_off(host);
> +                       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> +                       mmc_card_set_suspended(host->card);
> +                       goto out;
> +               }
> +
> +               mmc_card_clr_suspended(host->card);
> +               host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> +       }
>
>         /*
>          * For the undervoltage case, we care more about device integrity=
.
> @@ -2157,6 +2204,33 @@ static int _mmc_suspend(struct mmc_host *host, enu=
m mmc_poweroff_type pm_type)
>                         goto out;
>         }
>
> +       /*
> +        * Keep the card powered across an actual suspend; shutdown, unbi=
nd
> +        * and undervoltage still need the normal power-off path below,
> +        * since they aren't guaranteed a subsequent _mmc_resume().
> +        *
> +        * Check pm_caps, not pm_flags: unlike SDIO, (e)MMC has no
> +        * per-function driver to request this via
> +        * sdio_set_host_pm_flags(), so it's a fixed platform trait here.
> +        *
> +        * Require MMC_CAP2_RESET_AT_RESUME too: without it, _mmc_resume(=
)
> +        * has no way to bring the host back to a state mmc_init_card() c=
an
> +        * use, since mmc_power_up() no-ops when power_mode is already
> +        * MMC_POWER_ON. Keeping power without also resetting at resume i=
s
> +        * not a safe combination for this driver.
> +        */
> +       if (pm_type =3D=3D MMC_POWEROFF_SUSPEND &&
> +           (host->pm_caps & MMC_PM_KEEP_POWER) &&
> +           (host->caps2 & MMC_CAP2_RESET_AT_RESUME)) {
> +               if (!mmc_host_is_spi(host))
> +                       err =3D mmc_deselect_cards(host);
> +               if (!err) {
> +                       host->pm_flags |=3D MMC_PM_KEEP_POWER;
> +                       mmc_card_set_suspended(host->card);
> +               }
> +               goto out;
> +       }
> +
>         if (mmc_card_can_poweroff_notify(host->card) &&
>             mmc_host_can_poweroff_notify(host, pm_type))
>                 err =3D mmc_poweroff_notify(host->card, notify_type);
> @@ -2217,9 +2291,29 @@ static int _mmc_resume(struct mmc_host *host)
>         if (!mmc_card_suspended(host->card))
>                 goto out;
>
> +       /*
> +        * Firmware or other hardware may have accessed the card while it
> +        * stayed powered through suspend, leaving it in a state the kern=
el
> +        * can no longer assume it knows. Reset the host to its initial b=
us
> +        * state like _mmc_hw_reset() does for a non-power-cycle reset,
> +        * before mmc_init_card() re-identifies the card.
> +        *
> +        * Check pm_flags, not the MMC_CAP2_RESET_AT_RESUME capability
> +        * directly: pm_flags only ends up set here when _mmc_suspend()
> +        * actually took the keep-power fast path this cycle, which is th=
e
> +        * only time power_mode is guaranteed to still be MMC_POWER_ON (a=
nd
> +        * so the only time this reset is both necessary and safe to do
> +        * before mmc_power_up() touches the bus).
> +        */
> +       if (host->pm_flags & MMC_PM_KEEP_POWER) {
> +               mmc_set_clock(host, host->f_init);
> +               mmc_set_initial_state(host);
> +       }
> +
>         mmc_power_up(host, host->card->ocr);
>         err =3D mmc_init_card(host, host->card->ocr, host->card);
>         mmc_card_clr_suspended(host->card);
> +       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
>
>  out:
>         mmc_release_host(host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a10..14a407a9f9b7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -463,6 +463,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that ha=
s GPT entry at a non-standard location */
> +#define MMC_CAP2_RESET_AT_RESUME (1 << 29)     /* Card must be reset bef=
ore use at resume */
>
>         bool                    uhs2_sd_tran;   /* UHS-II flag for SD_TRA=
N state */
>         bool                    uhs2_app_cmd;   /* UHS-II flag for APP co=
mmand */
> --
> 2.34.1
>
