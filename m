Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4E2E7658
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552301; cv=none; b=pU+/3NgZLBe2CdNWvNRBGGAhvC2svMuySPd4bFiwQiyKdKfOt09iNIzEHRjPAEeRrv5lvAv+U0fKfdL9H+usYbR95yA4iIb+TvgHipNlFrtrTnOIqPxUXdb092F2Z1t0V7PtQOdBa5dkp/jaxClHjSHnlAQEcc4ffZFqfUHl564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552301; c=relaxed/simple;
	bh=lDEriJrBoc3Z+FCyx3l8NGEqH25UvL1Vt5miiyOmCZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhuX6oXLmup0cziMmXMiXTRBsdJ95M2Dk2eTFkPxCwkJvS1di0H+kv/KrJ7a8jFLlhYMK0P8yGDdnpwYvI+PuTiQkCR8+cDaCn9jeoREM83FLSf66n8mN/+j1B9avufEHhea3OwlXP9bqjb4NY0BixMiVL4lfGIxh+jBNIm6PAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJka/BVM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJka/BVM"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7111d02c777so54104487b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751552298; x=1752157098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDEriJrBoc3Z+FCyx3l8NGEqH25UvL1Vt5miiyOmCZk=;
        b=FJka/BVMMa+CcS/D4YzLm9Y/gi+MKnnj/rNU9tmjKjS45mywk7ii/fVMjrRmJpKpbB
         jMVcr6S9WjGSDkBcxWG2BFzItagHdmlaOUCTgKA+iYeSKfXvKLFlV9ExcqaQREPYDz7B
         9wsI2/ionZg6qtwcxMf3suOy9MnqaMC5Elhn4mjCMzREwMNbtMWX9v0V0hwmTvfuX9gm
         l3CDEN5XjV7ey8b90migl09S8IHVfUZO8E2cTRm7A9EIEA1z61hJ3OpALVHQnLLHmZHv
         CE4YEvBsbMDARxEAzAAbQ935pIgVBt4PtvlagID95K27lRykHMjHARP8QK0WoocRXpYm
         XroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552298; x=1752157098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDEriJrBoc3Z+FCyx3l8NGEqH25UvL1Vt5miiyOmCZk=;
        b=VnZXHbqmZ0KqB3rQVQRvVxZ8ZekWURYkkb8/TaffICpCUe2Z55llFCg7C7v9P+PXb7
         C25G8y4Alk+1dtp6T4a1W7LraOc4jP7Zv7i04VadYKiN3dIrGCKPq1P2NB+dgCHxG8vz
         cYsxDfwGswiqqhsn7mypEYMHL5PGXpWZ12kDVnTZOtFWnyPXnhhy8aMKywpv8O3p17y8
         vy78q79G1Cz9jO8yYGc8IaPrFPfSDSTWR6OKpuMfpp3SydoErnEyx4Al1DiZeg27vzZn
         bqr/qnDZLWx+IF97inx9cMhEQhd7SxKSeY7hEXcRMMi/LWhSVtW+hNVjQMUpOugf6XCz
         8DUw==
X-Forwarded-Encrypted: i=1; AJvYcCWThkQdB17hORC6GiAVTlEc40+GgGa9gNmRUKs4N5fkp7irBSh7JUh0uE+FGrbiHGrL5Sdg8FVh4+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kDv/G2G70LwD2oBoL2PxyZcR8WQnTU/iojSCn+ErXnsaqEH6
	l1uJCRr5guGPzAp5b9f9m2hl8dqNlJPmMNje6+dhNMVsb/oj8BxmG2VUbDQV96jTaAWymEtOrOP
	XLpiB3Jis4fjIu8BmSyMhmCo3Ebwmq2lgOltb8dALfg==
X-Gm-Gg: ASbGncvIixFXbQK9WZlAbaxmFNPY7ciNbPlRlD5z4eVpS33xwyZWopH87fpCwraTro9
	17jqZv/jlnOo4RpfPVzplRA48PakGgO+fg4NoTGlOabjOkW7qiW2384dTqeQLlCDlzz1+XmzRlW
	ki+7jIMdb7NscAXmwIdx1Sy4PJ/0WuPf9pxWXzZcf49aL+
X-Google-Smtp-Source: AGHT+IHKCVcm58iGQvDz5IlH+nt0wPYjDF0vM/IkWNqcRP0IW3DHZFT+X09mtu99FrvVXSO9bQ0r4w8ZqDRsbPuqnNs=
X-Received: by 2002:a05:690c:4:b0:70d:ed5d:b4b4 with SMTP id
 00721157ae682-7164d3f1568mr98778977b3.24.1751552298210; Thu, 03 Jul 2025
 07:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701100659.3310386-1-quic_sartgarg@quicinc.com>
 <c7lpaij5f5monr7zfeqitncwnau22iollid2gs7okyorlegtmg@jlq65x7ipp25> <9db5d1d4-1965-4334-9540-fbb66498d7d5@oss.qualcomm.com>
In-Reply-To: <9db5d1d4-1965-4334-9540-fbb66498d7d5@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 16:17:42 +0200
X-Gm-Features: Ac12FXxdoEtdtcX4FMKf6jgOtjpthIQIwg_rwvmCiwfJ9Oh4FD81OkKMZc8cM-Q
Message-ID: <CAPDyKFqh9tUrNGRj3xnRGtT=YxX5XhhMcWPCTATdon_joVHqAw@mail.gmail.com>
Subject: Re: [PATCH V3] mmc: sdhci-msm: Ensure SD card power isn't ON when
 card removed
To: Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Jul 2025 at 14:09, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
>
>
> On 01-Jul-25 12:27, Dmitry Baryshkov wrote:
> > On Tue, Jul 01, 2025 at 03:36:59PM +0530, Sarthak Garg wrote:
> >> Many mobile phones feature multi-card tray designs, where the same
> >> tray is used for both SD and SIM cards. If the SD card is placed
> >> at the outermost location in the tray, the SIM card may come in
> >> contact with SD card power-supply while removing the tray, possibly
> >> resulting in SIM damage.
> >>
> >> To prevent that, make sure the SD card is really inserted by reading
> >> the Card Detect pin state. If it's not, turn off the power in
> >> sdhci_msm_check_power_status() and also set the BUS_FAIL power state
> >> on the controller as part of pwr_irq handling for BUS_ON request.
> >>
> >> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Should this be handled by the MMC core instead?

Ideally, yes, but honestly I am not sure how.

The current support by the core, detects that cards are being removed
and then it schedules the actual removal/power-off to be managed from
a punted work. This seems too slow for this kind of use-case.

If the core would try to inform the host at an earlier stage, as soon
as the mmc core detects that the card is being removed, would that be
soon enough?

>
> If possible, yes, but if it only works because our hw-specific
> sdhci_msm_check_power_status() behaves a certain way, it's good
> to go as is. I have no clue if that's the case.
>
> Konrad

I agree, sdhci_msm_check_power_status() is certainly HW specific.

That said, I decided to apply this as is, for next, thanks!

Kind regards
Uffe
