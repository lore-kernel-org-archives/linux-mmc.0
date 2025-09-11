Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AE326D73
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597701; cv=none; b=jiJ9nOzu/hildGpbnj0BpNNKDJLRJ+vI9SXVtS8tPM5eGFlou+1X7klld3TXvULvPNpRkZedLhkwXLvQMIGDEeB6YILKxkgVc1sV8zB1AP6ZrSfo6+PZ7Nf1bWSr/XGX9+5uTGtrtIT4SpBNGDuW2sYHFRs62dGEucnVmM3JdYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597701; c=relaxed/simple;
	bh=dKD8GMOoG+4Yyag3B2X/sjwh1L9UvQheZXr6rel0Y0I=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsCgEBS/sBGQIX2/uN+Xzug6B5bTVwZVgXjmQh3G7dzv6nO6BTJQtx4fXp2l2CdkrOflzbttxhcdDGXw5V1tXnE0ks4xj45Q2cfRSgz6i7R4EhpOLh7jceUunHyMF7bUsmSIgMG1tIf0tH4oltfL02zEKYO75Sxy+IUBUtGvojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DJJVXlpG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DJJVXlpG"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-56a04f7691aso1667265e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757597698; x=1758202498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuU7uzJ803t+7G/jlS9fqoPlRvJYw9o9k9ZjizAu5JE=;
        b=DJJVXlpGtzC+xDmqltEFTTxXxDcfvZnVnMmnpNhysBeDurHm9H61+W61i/22Hd2FOt
         RSpCHxsw+mv2hrtqsQdwknz47rmGSlI0HHfJDRpF/pBQ9PlQzACqFbkUIVh/BQg1hIPz
         wxfhlCr8jmZom0t2ArdnNBTKvFhG6WyZpFREKxsBByHImUjPVZVmjVgRIIuD2msZ4Nqi
         +Q2vGMMx4DInfzGlDwa+SA3jhK86a9+rlPxSdyhnc84YrH3W5yxUDjzShbxzlaTv/LBf
         qPH83HkrT1M5A0/fONxifhSRHaDcTFNwrDWY0H+4abT1rPTu2qH6mAS0wLeJM2n5K65Q
         RgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597698; x=1758202498;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuU7uzJ803t+7G/jlS9fqoPlRvJYw9o9k9ZjizAu5JE=;
        b=wGP6eSiJ1NAoO/r6fJSmDALyhYJtGWPRIBNBnaanoEIGF6DcLmVAuISt354K5Dt/gc
         0Lz4OR8BKMs5+PqYGsaNjymjkC4cFOqP0XmPXJcUm7cYtRUmzAuMXRMBj+UySrUsLOtc
         I4gLEmQFgNBadpTLW+jMs2An/GAGy9O1zUaysNXzNHxdwEAFKiwy+leHghdPdoeg7rH0
         /K1msH1ZBO21yVZct1Tc1RGOgZaLw45ln3cjd7qA1/grZZGMG15iATndX84JLx0DMUV7
         UwmX8J/2XsuShFU5jeQt0bhDqlG1jtJ/nIRmSJ3KGFQUVnooY/D/O9A3IXZFKRJhABTt
         wpYg==
X-Forwarded-Encrypted: i=1; AJvYcCX4AYQCtX7B7Q41FRCgArhtc6dDm65zX6HWrMSKpsz/70bxrzvf3XmYbkTAMf4V2JvpnFyZfM59Sgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxgi4gTe/3fRWbJd0Zn/zQbWPxKBifyel5nyMdflC7VtiFjrFh
	dk5JU8FSf2xdqKiDgACMtTz9JWs/eebHHgfVBdX/ZJa+Ovu7oW0YPVR7VniHr09Mqku43ckqOy/
	3Bp/nfyUDUnQZRdT9OlqOSXOzTeIhmOnQgNzRT4FaXg==
X-Gm-Gg: ASbGncsu3hGq50kQHRWYenD1d+m3M4/+aT04vNBRMtjEqmW8/TTYsXVc8/BX1wIU1Ul
	Ji+vKziMbENx3cdwGDKQMUnh5KlDsuDwaKywSgCZ4QqC8yy/fMLVzSovMeV375kAUe9QAHnzof0
	NDjrcEIwnyishaZZX5MCE0YAeUKgbdoVIB9grGaprplQ/rBRquv8foRyetKG9CaV5F9Ve4Gsqod
	7Vdcqh/EfHakBXd9QE0l9BjxoHMe5Q31zHSE0pUnGc+NW/adw==
X-Google-Smtp-Source: AGHT+IGZyVuFS0SWwhsW0GkXG7C2O7hdvLrhWa2ouKXjUmaKEWGKB5rOyUWCPW4ZDky63sjUjVaIfTVqhhGY31to38o=
X-Received: by 2002:a05:6512:3b13:b0:560:87c4:e0ed with SMTP id
 2adb3069b0e04-56d789b0dc9mr1285479e87.18.1757597697646; Thu, 11 Sep 2025
 06:34:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 08:34:54 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 08:34:54 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250908-lemans-evk-bu-v4-6-5c319c696a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com> <20250908-lemans-evk-bu-v4-6-5c319c696a7d@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 08:34:54 -0500
X-Gm-Features: Ac12FXwwEtmXKsTJF1Zy2OvzYXGdM0No2024s7j2f5LD4-m8j7oBYTl11y-yDd8
Message-ID: <CAMRc=MegZ4Xe8zc0U=ruACUMA4KpP=aw6jrKCN+=KRfUKTuLkA@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sep 2025 10:19:56 +0200, Wasim Nazir
<wasim.nazir@oss.qualcomm.com> said:
> From: Monish Chunara <quic_mchunara@quicinc.com>
>
> Integrate the GT24C256C EEPROM via I2C to enable access to
> board-specific non-volatile data.
>
> Also, define an nvmem-layout to expose structured regions within the
> EEPROM, allowing consumers to retrieve configuration data such as
> Ethernet MAC addresses via the nvmem subsystem.
>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
