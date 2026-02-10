Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3B328B7D
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731074; cv=pass; b=K2dv4RWPrMpiz5Cgcj3sfvKF+0WvDvzg1LmoP1krwGPg30qPrdOY4BTx4L3lGaQTsP8xcoWnJSmwZ7QNnxLFq1wqwmD+VcUy1cUszVHmGTVIkb9GOodaOyTRUNqVgXA+s06+yJ4hI95+v2QbXBlMuJxXzbfQtVrU+OMjn+QAWq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731074; c=relaxed/simple;
	bh=My7H0zv9om6eGFOqwrY8WEQgO1PL3LXVOyrjI3ZQRjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3JASjYJm9cbQBhaL3JwFscgZ+bnZVdgBzwxscACB3buvqeQaP3TeOJB7qb864DZYquwhz6YI96mIr1Nz8eOUT6QG7Eu3eTgP59Pd7ZZkluGN3rwUVdGQ1wBbnZJP8IO9RcsVHclb90m0OF9w6QUpy/A92Vb14LrqrLTDo2OMv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vw8WzPB0; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw8WzPB0"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad8435f46so3372013d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 05:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770731072; cv=none;
        d=google.com; s=arc-20240605;
        b=EH2f8faN9vzjz0JkAAY7sSBUDOferuj5cH96NRzrJCZIF7qoxVKhtgGkONpsodR7lV
         qmf3LDlo3msNIoKGQVvjDO5Rkf1ZFv61StCE2fRZA+3EuRC5fIL0Dl3yA/kpVgpjEdE5
         n6Xned2idgsY0ZmIZ9u0plCPOYcWmm1xdbm29dgR9zHzvJc2aA8b9x3N91pHhhCHchKK
         lTMhCKeqCmT6evHebjKhn1jDOJC5OVx0VwKlpuf4KQoBGqg/CmwAuwnnX7nkWuWJHgHW
         lUT9myNR0djgguAAC31r+/+2ELNSaPXjRCYSmppc3dl4iAFIbzT2ciiDI9o1Mwtya37P
         M6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        fh=K+waowAMsWZFUvGIefIxN5XNWuXu8odPIrRLe6epYmU=;
        b=PRBMlBfSc3Pv0npWLqDcbtwHAnlj2+KlNtnYNsH8dn41jnlHI7i9JoYUW2g5UlWQtk
         KTRnfaPG5lra+Z8pLTFEy2DK72pBaiTHeS4jGgRJCH6kTzt8OwucgDC7y72B+1e3U5Kv
         nAxZOyLOdbuEmvN3yOldzQ9OIaQBorSrHrF12jZgUhFaI4MWJtyK/X1tMZPUp9DAJoDN
         lrqcIZ3Skfg0xP2h/QdejtH8e6+z1uUlm+n76WIjVqBBYnJq8rzBLPbNiWlhIT1AmjjX
         sC02yjYhoRC17fOKsCvxQUmfbny7saCBXodoU/ggECS8gZ3C5jE79BEImM8l71OYLTqO
         4tmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770731072; x=1771335872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        b=Vw8WzPB0oLcYWhtQSx/BjgeR0IIJffAqCy/AtF/PqSjkoeWAJ3MPMv1QGab0EKCEJp
         hYOrRYbpzrt0KLCPL8dv2ImW+w3GICWzj0n+MLSB8F4DaPx0w3X9pqcj/75b/SrDmK+0
         dS6JJILoKeKUQwgO44dPaUMEmOtfdsgxTXuM9w/SFYfhDEhVXbdIppsVZ474fE4EH5z8
         W5tQMD6yyOGACdGI2sBNuBPlvNFy1h5C8ojSZJ9FMMJx7l2OTuwjy/VDX4yB7L05G2NR
         AU1NqixA2Lis3AnkTkzixffUUqPnjIMvk9NfWEWDvDQciQRcfQzdH3t2uFPeYph0ihxZ
         tAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770731072; x=1771335872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO0B8QPhPo0Y3GlbKCDusifXNzaiAeSd4InIZCnguwY=;
        b=nSaEW4dZZBuSte2ILZyOVcuDKhp3GDT48ZgNLgAtN+bMTYb24p+UT2FveoCYDK3MUj
         cjEh+ZLtH3AoJj+6nFvJFvEve0JlCcq1rJ+bg66RMy0koTId3WmkyyboyI/ewwvkqYf/
         cfbHuEenm2Cw2891Xswx9FbpIjSSI2xsYk3HcGwkTCE1VzMKEG65jh2/M9iakx5nv6Je
         N0yELLeljLiAxFa0GJSerQhms8SSm5Yt4vNcv/b4s3Er/asrHmFJLdlQbxxThIEKNKAs
         vZLTi7wT0fl5MEgPNm4gl/IkLHh0uGQQANQclH3DsNLGk5tC/0AoYG+8IvRcz8hzh5Fn
         8GAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAT4uwkEA8dokQ+wdojaagWAMmvYMz2QhUwEbRRwrt8KMJOrc+QD7C0Ua6w2dBc1aZuSSq3dfDQPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5LQKABBKT1U9iOMFlTo53ak8a6r4rTWt6TWXVBgu8otVw/7q
	/+1rAzBDK1MaW1RgoydZLRzorGgci8IIqx9x+ZzE+3a+qJS1zY512Vpq8okKnHETcObK+hCav6g
	1eLmiaTnlRqCv9s39UIxlaAVoYjv0Da3jvrVQ6jXCyg==
X-Gm-Gg: AZuq6aLPTJMJmDIohgoPlEeXm2+H18MJBlSv5kNP6n19Mmqo8hOdtnayVAHTTSkykey
	pubhIDO4tE8eIuqd57Mzl9VII0g6H+2j/Ih3KlKteiMtoshXmGHKPgMPK24gL6i7kPiOifQboTz
	kCIn5DcIB+U1nBFAKIRXn/LD7ivIKTwUgMQ3J2ewoD7R5DN8dW82r921yy/UIxaHyVGjzYI1P5F
	qFKv6Tr2H9HqK2DcPZt6G68FpmGeOxTpSt+lIFabJevaWFsOldeC/DjKx2lV1AUh+KnTzx64TTo
	UCr0FJHY
X-Received: by 2002:a05:690e:b4e:b0:64a:f188:976f with SMTP id
 956f58d0204a3-64af1889b6fmr1730648d50.45.1770731072184; Tue, 10 Feb 2026
 05:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Feb 2026 14:43:53 +0100
X-Gm-Features: AZwV_QhTZ9KRaRA5GTHx4N22K6Lp6hSICHstQ6937DBI5S-nFi13iuFlfu6mtC8
Message-ID: <CAPDyKFocm3yRTG0TJJRxfDvJMjvvvri5fzi_HoNY4YSd-41oKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] soc: qcom: ice: Remove platform_driver support and
 expose as a pure library
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Feb 2026 at 07:56, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series removes the platform_driver support from Qcom ICE driver and
> exposes it as a pure library to the clients to avoid race conditions with ICE
> SCM call availability.
>
> Merge Strategy
> ==============
>
> ICE patches (1,2) through Qcom tree and MMC/UFS patches (3,4) through respective
> subsystem trees as there is no dependency.

Just wanted to double check that this is really correct....

The propagated error codes (or NULL) are changed in patch1/patch2, so
is it really okay to pick the mmc/ufs patches (patch3 and patch4)
independently?

Kind regards
Uffe

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
>
> * Added MODULE_* macros back
> * Removed spurious platform_device_put()
> * Added patches to remove NULL return
>
> ---
> Manivannan Sadhasivam (4):
>       soc: qcom: ice: Remove platform_driver support and expose as a pure library
>       soc: qcom: ice: Return proper error codes from devm_of_qcom_ice_get() instead of NULL
>       mmc: sdhci-msm: Remove NULL check from devm_of_qcom_ice_get()
>       scsi: ufs: ufs-qcom: Remove NULL check from devm_of_qcom_ice_get()
>
>  drivers/mmc/host/sdhci-msm.c |  10 ++--
>  drivers/soc/qcom/ice.c       | 127 ++++++++++++++++---------------------------
>  drivers/ufs/host/ufs-qcom.c  |  10 ++--
>  3 files changed, 58 insertions(+), 89 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260210-qcom-ice-fix-d2a3a045b32d
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>
