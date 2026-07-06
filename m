Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4574C81
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336419; cv=pass; b=PtsD+GLOwtaLOcwuCiqE7OcdAJQb6I0GlPIyyO43UY+h4+SHN8dpunsKudJPyHVhfdp6hpUbv1jgVLeiw6ZGWrWBPJgioUQ3Rl+YpqIEjOR1ysc4ta4L8MXFKR3ix1YHOyfpf/NDzh/qJpzUgw8eU7X5POFih2wV18gVvk2dnx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336419; c=relaxed/simple;
	bh=AMCaSbh/ZiqHcWXlH0T/N0BidhH/YkSSvYBbWqurz70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG5Z2br4+5NEQU+g/YixnXhppqR5LtBcIzkMHnA9vJVDQAH4UWK+AoR4e8KU09KsnX7e5TqcC+XtcDgAyNJ6m9GWRMZwkBK+lQX3oWf7Z2oIagpeUm9a1ZqzGgt1qB7WDiP9noB6i9tnOA2JseEWqcT7NSxabaDA+dRozQ5KvLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J7KKlWg1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iZss/6WX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J7KKlWg1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iZss/6WX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxH7B174778
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 11:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l037eqxWT6mwjPQfRW2ZRLSIaMTwxnyZwM1ZzxP5Rcg=; b=J7KKlWg1FpZqTMOA
	6VVbJPSD0S+eftlD40Wlu2MgLMrRtuKhF1aGAuSv0vXwdARcLGfzmMWm2OPeH6GV
	fd6gNGkpqZgnR99QVKnVxN+MjOoQXer9Ixa6xQo9odmWGWIIcyhhSnLqn4nlGWIm
	bsNqKt2SX5FTwyEMurjmNj0/bjnUS8XN7VxxG3rC03/FjUdX0fVJipXW2xY7+a4O
	LFpOP+nFkN4wlRJhM+nIN1ym66tmR3ekkLHfnaPVgacOK/2c+m8AZ9XiKHgRpu3r
	jxYKfrQaVRMkxQ/jOGkDtG66bgnYAImejHGZ3tjEZjjrdjQrAHqUMK6JYomxlsNX
	OVBh2Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxry01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 11:13:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f39a46efd9so44379006d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 04:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783336416; cv=none;
        d=google.com; s=arc-20260327;
        b=cluzAdbhXDfo98pTj79HYYDp2+HpkU4sr0jUwCrzZMf1A3lO8CcN+Vlfxnu0RBn8ie
         d9h3kMN5dN/4L/k5ZNezI2LU8sepUZximwbWVsdM8xxjp/MooVv6ldpUqhCGlvUGc5ud
         22I6ostAXYvilRgkMM5fySkbkvX/kGgcQSxTk3VybFKg+3nXd+750sjcAFYPTyc7+ZYt
         mFORq4/jkWJXc8Dw9QOOZ/Q1F9Ms7szTFUsFWDT4BkoKyuarM3+NdM6Fa44NhktHnKrx
         kDyDsNNW8TAleJw0HeDRM3g8FPAqIosg7EdRD/XMN8lxiikiDrSQK1nmmdJcha6O1YBO
         0URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l037eqxWT6mwjPQfRW2ZRLSIaMTwxnyZwM1ZzxP5Rcg=;
        fh=BekpoOiVs6vAF7DN8PAzRwHnMwc3kdA63CmRaf7kb7w=;
        b=Zb6pv8kqmqEOKvdQ3QY9iFz8RM8mguXhmFL0Vkg3MmMNN5PXc4aBlmbQZylLkMLrOo
         v7a2ksx09LV4escJdpTshxHDdcg4RTiUpWbN7i8K1betYGUVyoiG3c3ZUhH1HeCAoj+A
         KVg3GPz+pf7KoW2ALgapptRc4G/tEXk+wg9wh1yl+mvYnuFgW0HZDo4atMwEEGOULNgp
         dYAYYTBSDZhNMMsmtSaBbo79CSfscjC7MAsStVtDCS+7xZpP6s9oBE6RbX7Iu/nsY5cT
         nXAEuxseOFzUotdngpWTHiSAxW5EYTRSmiqFD3hikPAXeQIsqm/eoKYcrgYv1kaav7+N
         ZxUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336416; x=1783941216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l037eqxWT6mwjPQfRW2ZRLSIaMTwxnyZwM1ZzxP5Rcg=;
        b=iZss/6WXffmPUuqJLQcthojQyINo/MkboYO2xxgucuV8CKqDg//QcCAp0dcMZEcpsV
         NSmGsAosy/2Kcvz9qf+sFdamG6uTpcdZ32AxsjP2xMaQRN2Jsn/dhn6XbBgem20w0BSa
         0tVOSzPNm1qoBl9rG4Wpa9ZbGooGhjGVtowWe5058J5vS7HV4Y5WjIsBZ2tmBGOL3kOq
         sEuyipmNPzdD8a1RUt2IYEZHXMmrWjDesDA+T2SgpQtexAdejjo58bCwbmj4ACFPDOtV
         LcYpk6LR97+hAiyvTVjeqT03pgUZWPjzVzN9Yj1/vvO9jLCsAEhLfgrQc39dyR/uRbXW
         O64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336416; x=1783941216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l037eqxWT6mwjPQfRW2ZRLSIaMTwxnyZwM1ZzxP5Rcg=;
        b=ruDmikMU1PNuyGZ61Buc8a1uhXk7J+KRR/ERD7lh9e+KUSgItGBRrqMW8gsRz4vM53
         EKEtqpWbUMmpdQyQNE0ioX8aEudM3J4VMR1zAobimkegwtW5Q34UEeL7JJWHo4UP9/of
         XAtU+Mprb3SmC3Mx6F/qbwSLWA75lJxQelSLOd48l4ZIiZUOPaASSdT+l5wcw+857Bbw
         82Hl1KyeGfhSkkKpRexuYX/xsH1zlTLuPc48I/mlY4u/fxxP68ryzNBPE17Lv2vHqa1E
         ldZhOcAa8tD3+RF/Bi7yNbuuZ9sJehkeUGG9IRcnKEE49gYLUg3B1GxXeDuZoTrBAdZx
         89gg==
X-Forwarded-Encrypted: i=1; AHgh+RpEvXUYVF6uPkzYvyl+Q1iUK2FmHvptOecictAMrPbja02cVAR0+klFnCNcxBw48nHt4yIY7euzlJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoc3OppPC+PlkjdkhpUFugEpC6785IXvSu7/7dVkYJjdeqtOs
	05b46eWiDQvYN3EmEbNUSgUDKD6zkdDdqdknWw3Gda1RhYHJfHTqnEhYMn+Cgg+CW7RfoZqKHRi
	dR35+vUI5h7DVI6IojdMOiZplXs2eku4S9BnEhB0N1Rws5W53OcE35vk1Y3ctA6K704e9rmO4V2
	IRw1RaJq8uL6ZGR6+Ye+m5dhEMhvE022Rg/jrgPg==
X-Gm-Gg: AfdE7cmuZoLh3vgqvE95FlhVNYNAY/IQaXK9IBVsznW8a9D6sXdrqSr0fi6mpCh/Ca+
	Ok6l46aFRvVx29s/cVaFOwaSxHDDG0PI4EebCS011oC2gFTW98sA/KUuEBgXAWKgkmJ6fBYZcqB
	oOTbVHAAUDuwUUzQASgPmayYtfi9IqU3aj23oPoke2jDX2B6/Hqq9HcH9nFbwR/sJCGVYC
X-Received: by 2002:a05:6214:2e41:b0:8f0:ae2d:c7c7 with SMTP id 6a1803df08f44-8fc96d4e67dmr2225076d6.11.1783336415758;
        Mon, 06 Jul 2026 04:13:35 -0700 (PDT)
X-Received: by 2002:a05:6214:2e41:b0:8f0:ae2d:c7c7 with SMTP id
 6a1803df08f44-8fc96d4e67dmr2224686d6.11.1783336415323; Mon, 06 Jul 2026
 04:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778672403.git.sean@starlabs.systems>
In-Reply-To: <cover.1778672403.git.sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:13:24 +0200
X-Gm-Features: AVVi8CeFFePxuRywRmMqlwf5mHGqRwyyFqQVpM6X4lLYh8vyhVbRDqfzazGMANI
Message-ID: <CAPx+jO9t8Hr5Tcozi0Gs+sUMUuzrxQ8US3qS-+mZGXs_8WzU5g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mmc: rtsx_usb_sdmmc: qualify card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>, Ricky Wu <ricky_wu@realtek.com>,
        Avri Altman <avri.altman@sandisk.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, rogerable@realtek.com,
        matthew.schwartz@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: FgQJtenlKXs0KOv18Th86SIdDOJiSKTe
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4b8de0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=lDt4X5A2n95T_cetI-kA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX/y+kJspkDPvR
 90sqiW5eJz8jWok8CSnK30jPZl4Op9G/9/Lban7cMQeBbipXJBUzn9m5K6kHW0l7offMhTYctcj
 ENZDEiyB1oowHN9ufj1MMEyLy6rixN8=
X-Proofpoint-GUID: FgQJtenlKXs0KOv18Th86SIdDOJiSKTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX/rX4Pdj636/y
 eEdXFmljET7mdTa3RJtMnaxVWU5wjJhWiGJkbO/0LLaIZEJJfXTeJuCkxM98zx5b1wyEhPjMDP8
 Fpee4vPJSWYaIBAoujSNecmhK2vUlb3NxPR0AlHcGIsN8P2aJcy0ngmm50YNNPTeP6XFRbgoEL7
 wTDL2XSxdnYB3NhU72j6AUY0BlbHmn1kSMX5KNZf4VgtrT1eDmOjlksCm8IH/En/NoNGmg2KUkd
 x6ZF6SYZNULwuGvjl1nuuyijiBGL+PwCa0+Ukk0zLgwNhfSosleyGwkmPnfW7vtHuSyKZFsbgrG
 1NO19ELR7rowEWpR5xWl0X9lLh2LpPEuNgy0DCPAoSgmFu9+U1biIpLdFWRYOUhAu+Ep70ogxAD
 AxiAkdTQ7RdcIU9K0I/fEGk1A8n1OPnHC3ndnutdae1VUp3lCN7nfHwAOM7U8bZA8j26Z+YVtrS
 h4Ep7QYeNWazjjXE2kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

On Wed, May 13, 2026 at 1:40=E2=80=AFPM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hi Uffe, USB/cardreader folks,
>
> Uffe suggested sending this as an RFC and adding the USB/cardreader side,
> because this may need input on where the media qualification should live.
>
> I previously sent an RFC for the USB/cardreader runtime-PM side of this
> problem. That did not get USB/cardreader-side guidance on the detect
> layering question; the only substantive feedback was that the MMC child
> should already own runtime PM for a real inserted card. I have since
> retested that, and it is correct: with real media inserted,
> rtsx_usb_sdmmc holds runtime_usage=3D1 and the USB parent remains active
> through runtime_active_kids=3D1.
>
> The remaining failure is narrower: empty tray only. Raw SD_CD remains
> asserted, the MMC core repeatedly probes non-existent media, and the
> runtime-PM hierarchy does not settle.
>
> This is an RFC for the Realtek RTS5129 tray-reader false-detect issue.
>
> Short version: on these machines, raw SD_CD is not a reliable "card is
> present" signal. It is asserted when the tray is inserted, even if the tr=
ay
> contains no SD card.
>
> That means the current driver reports card-present to the MMC core for an
> empty tray. The MMC core then does what it should do: it tries to initial=
ize
> a card. The commands time out, no mmcblk device is created, but because
> SD_CD remains asserted the detect path is entered again. In practice this
> keeps rtsx_usb_sdmmc runtime-active and prevents the USB parent from
> autosuspending.
>
> I retested this on an RTS5129 reader:
>
>   - tray removed: no mmcblk device, rtsx_usb_sdmmc suspends, USB parent
>     suspends
>   - empty tray inserted: no mmcblk device, repeated CMD0/CMD8/CMD55/CMD1
>     probe loop, rtsx_usb_sdmmc remains active, USB parent remains active
>   - tray + SD card: mmcblk0 appears and reads correctly; the MMC child
>     holds runtime PM as expected
>
> The old Realtek rts5139 staging driver did not treat raw tray/CD state as
> sufficient. It qualified insertion by checking whether media actually
> responded before reporting a card present. That approach works on this
> hardware, and avoids papering over the issue in runtime PM.
>
> I know the previous version put the validation directly in ->get_cd(), an=
d
> the objection was that MMC command probing does not belong there. I'm not
> trying to ignore that feedback. The question for this RFC is the layering=
:
>
>   - if the only exposed hardware bit is "tray inserted", not "card presen=
t",
>     where should the Realtek-specific media qualification live?

It depends on what the media qualification must consist of.

>   - is an rts5139-style qualification acceptable in rtsx_usb_sdmmc if it =
is
>     kept out of the generic MMC core?

We can certainly add some specific hacks to the rtsx_usb_sdmmc for
this, but I think we should be able to do it without having to
build/send all the corresponding mmc commands directly in the driver.
In principle we should be able to rely on the mmc_rescan() work to do
this for us, in one way or the other.

A part that is still a bit unclear to me, is how we should handle the
card detect when the tray is/gets inserted. Is it possible to
insert/remove a card to the tray when the tray is already inserted -
or does the tray need to be removed (and inserted again) to allow
this?

>   - or should the USB/cardreader parent expose a qualified media-present
>     state to the SD/MMC child?

Is there a way for the USB card reader driver to figure out if there
is a "card present"?

I thought all it could do was to signal whether the tray is inserted or not=
? No?

>
> This is intentionally copied to linux-usb and the char/misc/cardreader
> maintainers, not just linux-mmc, because one possible answer is that the
> USB/cardreader parent should expose a qualified media-present state rathe=
r
> than having rtsx_usb_sdmmc compensate for raw SD_CD.
>
> Patch 2 keeps the validation path in a known initial electrical state by
> starting SD power-up at 3.3V, matching the old Realtek rts5139 driver. It=
 is
> included because the validation sequence must not inherit a previous 1.8V
> state.
>
> I have deliberately left the SDR/UHS rate patches out of this RFC. They a=
re
> separate capability work and just make this harder to review. This series=
 is
> only about making tray card-detect correct and stopping the empty-tray de=
tect
> loop.
>
> Thanks,
> Sean
>
> Sean Rhodes (2):
>   mmc: rtsx_usb_sdmmc: avoid false card-detect on tray readers
>   mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
>
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 161 ++++++++++++++++++++++++++++--
>  1 file changed, 153 insertions(+), 8 deletions(-)

Kind regards
Uffe
