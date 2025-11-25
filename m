Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AC1EB5E1
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075659; cv=none; b=WgIgk7wC9m7tJX17qIFebDPAh1Ll3TVjaAzzltidZ5kx9ZlaWPwacZXT9J5C0EYwZahwdfFSMfdjAgGbphROo9Rf52CYceNPAaM7tDCrSp4UqFAHKbuzmR+ALkCzQNfK9l7r1a05bUcXxCVkZeO8yjfrWzHCVMYeHPF7lkzNIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075659; c=relaxed/simple;
	bh=MxSu7/+tDC/ewCZT6aP4aMNTRlY8x1JNcimqpkHUEjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttg8yjAmk20wsTJMtNdLBw9xjmQy6yn0+LdLDgIivYwPr9Eul/7zlylVyUXO4OBNCwTZciOkra1b/HPhsfjX/Cir9zGjWyjv00vomofT25fjvFkbeALIXYTbD+UAYx/soCwb6cNKNgRk24o4Ob7MEZFOMYkRaW2smBD2Hr0J+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgMIjQjm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgMIjQjm"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7815092cd0bso51703197b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764075655; x=1764680455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxSu7/+tDC/ewCZT6aP4aMNTRlY8x1JNcimqpkHUEjg=;
        b=vgMIjQjm5z+nPYXkl/To7CriDZnBIh4vsFw9J2rCzqDD//szGKLY0sqT3BTVZn/Sxv
         nQPXpUYgbMfE1wKg90H9NDOS+lr1QkXm2mfVUX/rpGrXGbleVcUtdMnxcsg8X5kYhx1q
         Z8HOLkLD+HaQoaEstOAMXojx4rJ2aVpcpWjvS/Pq1qzOZAkVufXoLK2nhBrV1c6K7P+x
         dDcsfoyfnXoF9pK3vtB0KL+PndVlnCeRs+VK8l7MdUc92C6R/DXevnkfIoI93TEDHZUY
         OAprMk/qew9SxghCUFMlk4audn1C9jFxr/gAtmcTqGiR01MsSRiPfyeaPXWIyLMJeXxu
         t2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075655; x=1764680455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxSu7/+tDC/ewCZT6aP4aMNTRlY8x1JNcimqpkHUEjg=;
        b=sgXgey0tGxYhWwZavA2EjUxOZN4cFrGUj3CiOarqhz6/2EQu0sXpgvKXNdpjsx7Ua4
         n7RHvSyPeYwH139hmEpIh6D60ZDR7reoycjIc/kvC3gN0EyVlkK4YDUPmXRw3OYWaK//
         NPSH3yp7TB//zZFU95TLZVJH80sdIGZYdqExifXzSC2FLJ7WFPAxcA2XbUygY0eRhIez
         uRnzvNDyzSx8tuzIRsXY2sMp9e6COhWcJ9Y3T9VHBigbWc4bOiKJoXY6/D6G6mV3PsGo
         eLNOxadxWt7/VKp1g84sLYaLdxiKh224BdDNje/DQhpyy+iGpDj9pV92sCD1eKkx7Dqj
         VBGA==
X-Forwarded-Encrypted: i=1; AJvYcCU22IOc2M1Sona0Mzh7wrE1zErxJH4POhl4vVy0l6kM7bMHVbTaDAWCJhg1DhiThHFVVeWbgODDCOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yGJASdeodbC4kdcAKNswgBjmbb/k2FvgIVRebv13UnHQfKKo
	87rk8f2MtPc7gTlH8XMNpONODQ3ixWgNe6e2bG6+hUUy7svCo78o/HInRxohRR12V1DsAF2tlQ+
	hnwmH9tEsMb1XxR45ZFRJKMyiPG/W0UwMgwZEbfEUsw==
X-Gm-Gg: ASbGncv0nccxisoBzSAaFrBUs5EZ7VhIDUDpxdl6hNmJX2pw9f7FwHmNQlOI12Wl7na
	gVLkakCdqG7f8pik9fsmyRVloM+EynHTxU0xButr41HL7B9XSSO/KnY4i5RPmRfmLIBHCel0pFr
	tHWNAF/t1XSUPyBX0LnPzFmxQXh+DwWybnrenetDv69iJwOrBONIqfLD1TeQ8wBbuWZPxHiV0X1
	uk48e1uToR9tlN0P3WKiBQP4S7jyaSknJfGZVcu5K+jtZ+3TLtn2keh4DZ3mgSGyh1028LC
X-Google-Smtp-Source: AGHT+IHlKYmpPx4ytkCZJ43o1/YRez9M93lptuGk9x+25iF18/2lXfKBMy3NSSymEMTxd9GqKo6iCsg1bhEgFKaP8Zw=
X-Received: by 2002:a05:690c:9688:b0:789:3166:25a7 with SMTP id
 00721157ae682-78ab6f3d484mr38401397b3.46.1764075655052; Tue, 25 Nov 2025
 05:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114082824.3825501-1-sarthak.garg@oss.qualcomm.com> <CAPDyKFqssyDuyRFxRUurudWLYGiZ1AXTWV6isyYc8Wz0NLriWw@mail.gmail.com>
In-Reply-To: <CAPDyKFqssyDuyRFxRUurudWLYGiZ1AXTWV6isyYc8Wz0NLriWw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 14:00:19 +0100
X-Gm-Features: AWmQ_blVMx1RCPDTQFql3H0BDcLS24cFJOHcU1KrNtPwwkrojK6XQDO2akwmf2k
Message-ID: <CAPDyKFpyCHvnGQUrdMxSmksd2hQtxrfwcWKiQTz4Eu9=tyXvGQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-msm: Avoid early clock doubling during
 HS400 transition
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 11:55, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 14 Nov 2025 at 09:28, Sarthak Garg
> <sarthak.garg@oss.qualcomm.com> wrote:
> >
> > According to the hardware programming guide, the clock frequency must
> > remain below 52MHz during the transition to HS400 mode.
> >
> > However,in the current implementation, the timing is set to HS400 (a
> > DDR mode) before adjusting the clock. This causes the clock to double
> > prematurely to 104MHz during the transition phase, violating the
> > specification and potentially resulting in CRC errors or CMD timeouts.
> >
> > This change ensures that clock doubling is avoided during intermediate
> > transitions and is applied only when the card requires a 200MHz clock
> > for HS400 operation.
> >
> > Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>
> It sounds to me that we should add a fixes/stable tag for this, right?

I applied this for next and added a stable tag, please let me know if
you prefer something different.

[...]

Kind regards
Uffe
