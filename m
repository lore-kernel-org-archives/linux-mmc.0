Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4412468C15
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514925; cv=pass; b=qIOzLjFFeJ/xRiPBLt3s+ke4rfDYbmZP+dFmBiL91GRXeHyeMRKdo+p9x7OYEW+RmoM5/3m/en7qfRPyWI5o2C3/2Mw2jSSWmVeSIyy29yAAzBHAXsgZunFaIPHJ7/zLCf/rshoh9JDJCl31/R+nOTqqvDl42m6c7JHfLKMQh00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514925; c=relaxed/simple;
	bh=2wkfA1DEwAs+9lXG3t5JnbeNmCMTTyR4AdSizwxbj68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYbEdaMNLUNssb7AodFp3SHgNJDm3pQ6hG3tj3Y1Xc3ZeQzQ+xSZiA2IECiY6yFXIcvXjRt4rS/nbMC7cEqvqKo+yO0kcQCkWmlE8a7sNEQqDGej6+wRsPk0rdcN+fN5aTtIA5YlyE0Gr6btKoEOYNfV30LFH1VI4o/UfXggWcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8lYNg4C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bQ5ILipX; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8lYNg4C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQ5ILipX"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mlFt3234616
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	drGBsyaTJV0/2pWvs9VkHMfKeT8PZfVoKRjMZYVaAc8=; b=T8lYNg4CZVbT394U
	vnx5o0XfFZZjXSOmfE7fklfkqXU1Q/tXAonOJyO65u8kRVS2S2UtxF6WjiGtYGXI
	9yWRHduZLAQQX+yo2QobjZSu03U8QeWnkitiDaPtdZSsxAobSCK1OoSCM4Fgs+F6
	g4TyhvmdGEUPIqWgkUA4gnXukTMfwLM5L8RpydGUnl6tHa2qYzjuvME4Jy2HztXi
	UCD6235l7XROkk6j8U03OKPX7B+XOmmTh25/stIND/FIdstjEdC0YbOHMpSG38qn
	wZxWlVs+5BISU9ZB2zXhvDaGGyuDdqfYKG4UawOlFq804Aiod/Z/9D2YQT0fIsTj
	fSOonw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r148t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:42:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cade6b71so933079a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514922; cv=none;
        d=google.com; s=arc-20260327;
        b=r0SyCro5UQCzAD8St1lSAlsivwvRu6bS99mIOYaOxO3gVfji/a6YWaVpvSE5GRFeUd
         K5/w2K7IOiKELVXvlW+BLhkATFbemVQGkTDlQPTVNp9u05Y3j92JvbvVTtQmniNBdNQU
         K40nGsFuJsbFfqmNtq69YZ2KsS2CEFkmJWEBCp0iG860/VlZsyzRHHwurNEW0wkEgs3x
         v6xcVwG8lq2P2M8oRjOvZa4kKmGB3MJmzXHxVTDhmMPdrIpnt+iH3ig/HzMbe+LNOSM5
         6xrRVXjcKL2OCp9hZIbUMDBeKtpcugRrO8/UQ7GhzUm7WkMP3z36HJ93/rDQVjPJDTR4
         RErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drGBsyaTJV0/2pWvs9VkHMfKeT8PZfVoKRjMZYVaAc8=;
        fh=/9zYQDMjZmhbEODQbqhvw0wYyAYP/IVAWy8/z2RidGA=;
        b=PRkb7J4lFwrhkY3b7BObIqd4hsgHmrBzKpTEmVU1f4R8xyyQ96QlHKSxhtdUZRDBX2
         SR7vwBaimG0GHllt2zlGfRVyBy9RS8tBtsixyJZbfkjntWQFMb6D8rP+Opy40UjCMvpr
         GkJp6cobwCsAMlgyQCveirAXb1LHLN+B05+6Qx7S9Q9xUOzkOi2xIgAOqO4k88RBIOXk
         IVl4qRklbqNWKbJ3624AMJeUWSZKg2/ajRLRezXDN+dnTnt8go6i60IEvFd/dVYCxM55
         g265Gt1/CMHxItQdzPFbGgF8kC6XRJGFa9ArTVD8tbXzldMbvPFqpR522pvct6o2FaTN
         5HQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514922; x=1789119722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drGBsyaTJV0/2pWvs9VkHMfKeT8PZfVoKRjMZYVaAc8=;
        b=bQ5ILipX+6GeMD2pxgNaahFKeYUyTvyaaSnUZJg945YgG0tSghISi6M1hC8SIFK1aB
         yVwfU+FV77bJqQGan2eGR8Ib06X64xp/X0DkokrQXPj6AeRvwPws4mSr9ys/VcVdNNBn
         TzuUR7ue9zHpZIRx7kevrc9VksXFVRVdOkKsYVkAZ48oFFQukvj4I5VuT8jmJIBY3pqq
         gJbAAu8HetNqYBjlWj+ksoWlUIwHkFHOxUtZL9L+Xfz/VaYj39Mk0r5sP7aNi6jPAVon
         BtClh9v7g+exqrExKz4vtsT8VymYkfDshVeUVprhYGNxlZR0M+pXcbHKHOvrK1YoY5AC
         zuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514922; x=1789119722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drGBsyaTJV0/2pWvs9VkHMfKeT8PZfVoKRjMZYVaAc8=;
        b=mbUjfHewnyGzC37uVpikoUBrgKy+EF8ZURvxT780Egjv33e31YlcRzM/dVR04viuoa
         6s0MMZMOKABrceBTKU2KYyTFmoO6342OxnZgr16NUM1mHwXENbDU+iYyGiKXmIgGAyiS
         mkkvci7+LGPXUuCbFLfjhOSgjMuKgv+yjueJE2ogGyKDT8y97g20k9ptUyXCj9kdRI0+
         lcFZxmevQTTJg4jK4KbVmOMOx93HKxo+e58gQ0hQyG+uvvkr1i93YztYN4k6t8EGCaZh
         BWaXp8ako/hIAKKOONtTew6lzmHxeFq2RpnR11Z+veQl0CLpnew6Od8XRo2d1A2ESxcf
         qzog==
X-Gm-Message-State: AFuF++nZ8sU/7D4OsUcltcW5D0c3eA/iGibjHD0tqrL6bFkxWd58gWcQ
	craBaTiXeanfeb2w0dkDmQ4aiPUyGmuYrMSzNhXyMZaHtymJ3yldUrtGgbfsfOhgH1Tt4x3JjgX
	OjqWvgqsVjL3+A7SCAYVKNaibS1hqTE9bJANLQ+h3B4sO4r53+UkkzUs5BXgYiy15HQKIHyFixl
	SoOyaOpoyZyo5hjt77lFE905Rfgsbsg4FF7GMJIIHLFOurAw==
X-Gm-Gg: AYBFou37VHz0KZEV7pJ8wyqLE/Jo3vNqhHFvWdC0g4j3ENE4Ri37Q05kqNyE0oPbnYQ
	F+0HPU6fzzuytVrG2sy+lqcHAud6ZJWEFQSbS83ahbTl0HriZjkWRB17ABIU0AP5ZzkRdpYUj3k
	oCAf8OG7+6EX1ojFKWIjJUv3EEekZYzrFii8p5MKLIkA1p0XrPXlhf7ym5wQ==
X-Received: by 2002:a05:6a21:3292:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3da214199afmr11699370637.9.1788514921673;
        Fri, 04 Sep 2026 02:42:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:3292:b0:3cb:b6b0:1b83 with SMTP id
 adf61e73a8af0-3da214199afmr11699335637.9.1788514921233; Fri, 04 Sep 2026
 02:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810153442.132286-1-torsteine+linux@gmail.com>
In-Reply-To: <20260810153442.132286-1-torsteine+linux@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:49 +0200
X-Gm-Features: AcwNN1W2N6tURi5KL0pGdrryUIMx_U4gq3Ovl_sJLG0jZCvtf4bN-oTVYr82cTo
Message-ID: <CAPx+jO-_944wxAN3Ha0=wy_L6Td4hYRXSUdEWfy9i-GR7Kk6fg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mmc-utils: lsmmc: add 'mmc list' command
To: Torstein Eide <torsteine+linux@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX7u/yC6HQE0zN
 j0cfmA4zYPnC9P/ZAyrDFjqN+erG5wNF+Q4w3al1FkBRuSS0QeG3gIfDk/HTWwaXyo6mVgTgR6W
 AFHXuaezCe53aW7RkPdHQ/DR/vkoyxk=
X-Proofpoint-ORIG-GUID: gewY3csTn2KgI2qGlz_8oCsclRkLmB1N
X-Proofpoint-GUID: gewY3csTn2KgI2qGlz_8oCsclRkLmB1N
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a926a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=InJrZTXqAAAA:8
 a=UdfhzE3rKW6iTSnQkLIA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=WwJ7OKCui7YMbFU4sWpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfXyo2xgC0Ur6Hu
 RrAb12h4md9HMJvVrXhzoH+JLnWL6yP4IQg97BtzKyUs+Rtl+FPsA2HgxW7rwJSzcTOsl7CKo9Z
 3A24LF4dKt1HPot8lEbJqgvQassyv98yjJggqeOGkOD8m5IzjXZjD+oszA71E7NOW9pzbvrmSlO
 0MJtkEplAliQ5ZtmlnTQ7YgvuDX+TtReQSMKWM44D9mhOSqQ578J2vWhDIRId2dQMPnqSjwxb2x
 EvFCjIxJUGNVYSXJqDjNFDsc94PSAyK1x25vu8/Q9lIZiEpvqA/3uEctV/gmGqcrd8Dd7w5XAth
 AIntimaEnAHCW5jJXAFlnRI1CSLQVqUG6Hn5qc1A2eqKY+frAWiGxaNCw9Q4CVv/GvOYtzPdZBk
 w8JtBCEuLNWUEqnp8EJNnpkVNrhClIcNRCqO6XCSMvmdVBS0NAtu+/5w2laqVSgRKgB8dYgfw9i
 w7c95Hrq/J2TfTQ3LBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Mon, Aug 10, 2026 at 5:34=E2=80=AFPM Torstein Eide <torsteine+linux@gmai=
l.com> wrote:
>
> This series adds a 'mmc list' command to lsmmc that scans
> /sys/bus/mmc/devices/ and prints a one-line summary per MMC/SD device
> (device name, /dev path, bus type, manufacturer, product, revision,
> serial number, and manufacturing date), and teaches the existing
> register-read commands to accept /dev and /sys/block paths directly
> instead of only sysfs device directories.
>
> Changes since v5:
> - Patch 1 (Use external .ids files ...): carried forward the
>   0x09 "ATP" sd_database entry from the mainline-only fix in
>   d64cb08 ("mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
>   database") into the new sdcard.ids, so the manufacturer ID isn't
>   lost in the move to external ID files.
> - Picked up Reviewed-by: Avri Altman <avri.altman@sandisk.com> on
>   all three patches.
>
> Torstein Eide (3):
>   mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
>     paths
>   mmc-utils: lsmmc: Factor out CID month/year helpers
>   mmc-utils: lsmmc: Add mmc list command
>
>  Makefile           |   8 +-
>  docs/HOWTO.rst     |  71 ++++-
>  lsmmc.c            | 649 ++++++++++++++++++++++++++-------------------
>  mmc.c              |   6 +-
>  mmc_cmds.h         |   1 +
>  multimediacard.ids |  16 ++
>  sdcard.ids         |  24 ++
>  7 files changed, 486 insertions(+), 289 deletions(-)
>  create mode 100644 multimediacard.ids
>  create mode 100644 sdcard.ids
>
> --
> 2.53.0

The series applied for mmc-utils master, thanks!

Kind regards
Uffe
