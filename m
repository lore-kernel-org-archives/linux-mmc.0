Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CD230D1E
	for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807301; cv=none; b=cDPOlYrVwSWw1EGcDvgp0oDrXTqTCyoi4EtHPhzAZsrZymZ61IxQQtJS9zI/Rw+kBFgqv+TmIQ5/e3IBR32oDfoK4S6qdRhmt/NNmFRyyZTOcnftRF2Ghe548JzkiMZEg+EbpWyXoCohiE7EPYJQrYNgEVAowE53qshX+HQlLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807301; c=relaxed/simple;
	bh=YDVkNcZQalJ2j010y9V0+C5w7+uerTdqWyV+aIv2oSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQ5Oum/gDzazzaPQOfP2Q/6WdGW2vTNDRlXBvrJQnk2R1ISxo715IQAeoNu57tQDpb7EQaVvLsdaMnDpewmPRdXQG2WWxdKMFi/+RUp/vvP3dvIQaG0Ey2n5hILvMmqTiaeRXsCrRZzbDXR/kWh3Qfx59KCUYrRQMnq30YuDIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+owLuDL; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+owLuDL"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63497c2a27dso689379d50.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758807299; x=1759412099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtNjzQKudYD0ky97v1743lPf/WrnfS9KJCemG7a+/I0=;
        b=E+owLuDLYt4n1hzwq57nBBJ8yA0AlfUKkNZEFQHc09LedRYkZtyTwMec/67yXstYf1
         3Me1GFSvw7XqEf1n/I0rwC39f/TmdwoTaGy/Q9ANGAyknZLL+LzBvCvipuIeUUdZsoTA
         v3KqJx4O9P+004pW9tK4QuB4Ze6DF0lVi4a/ZAJi/1cXio62UYexRjOgihOLL47GfiUY
         A1QShO/ImHlRxq9eAYbYqLxe2pcOusl9i9qK5IM2Ix7Y8sT7d1MtN3kdUarMNDw2oNiF
         a3VxvfhMgkS4D0GTS4JjV5RpnnebLHkbmAig7F1PPCqyhdOax2Jj3CpI8IRUugX75Bgq
         o9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807299; x=1759412099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtNjzQKudYD0ky97v1743lPf/WrnfS9KJCemG7a+/I0=;
        b=dUhlQlExGpdYCHRs0pV+Ipza3mLDufhzmtyi5qkV/UPBrvvSElenB4FY0Wj8JbysFx
         z2YuOe8hiqqKipRNnvARSj5WBBqAy0njwrmNmOBnM1l6Tnh7WUaTS1iAeatMAG5nB9os
         ILPrAF0wnDHxpJ6H2IxXAbifdlzYJILGXGR2kkB20dSKRxP+oyjGYQSrhw7NfDzv2My4
         BFUTIYkm55fv98tieJCohqxn+vtrHJT/gwcsO1fCiCzbQJmRLNgeTaW5g+zFEQ19P18w
         BdxECv9x0Mu1mCITl2VbYBR/Ctr8Uw0QzDtBblv8CU4yjjKDpfrjV7qGVsvAKgfJobqQ
         IACg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWAO9NHaWGkAjwRB0jJaJW4nfGFA4BeA4uRVTiQWcB5/7mRMkHAfAgE5LWHZser08frhfTVL7nHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WJMho8Etktr4ZuGQ4SeaFTQv4xQ1S8eRzkuQ7SBGK6/Fg1HH
	o+MPmmjIB4YKp6dL0CC7HRWrvJm3bAGkh+1L/jFsdYxs6u4JzPtz2NQktxu+SdK0IxsPI11ZrD0
	g5kYnJ1sdfv3HZlTwAgGuQmAKXABNsP1PdG5Z7t7HWw==
X-Gm-Gg: ASbGncul/pZlaN9dO/0MYBn60wnPISMWjp1P9FXqErbWWFJXwUHcx+XpWYi/rozIw7l
	Jw40Tz2G6M10TA3zBNEUebnQWrQqfEOpQqu214uxvNDQjiFfdf9vskZJIcgRhAlQmIIemhHQbmR
	joUxQ/zDlLb7NMDS0IrKtF6r2VlgahcuT1HvaZSaHSdcCWMWt95tLqgw6Y8wzstmiD2MJnBHvJm
	EoZrHBq
X-Google-Smtp-Source: AGHT+IGimO2Q23ZQRuh/31hfKH0M0gM5VQ+Kb4vJFyOlHv/p/Vvr462F0FI6JqMOIO0OkAJ4FQSVqaMbzzoyb5VvJmI=
X-Received: by 2002:a05:690e:240d:b0:636:d335:2515 with SMTP id
 956f58d0204a3-636d335263emr142033d50.3.1758807298695; Thu, 25 Sep 2025
 06:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925090412.2068216-1-yangzh0906@thundersoft.com> <20250925121155.2401934-1-yangzh0906@thundersoft.com>
In-Reply-To: <20250925121155.2401934-1-yangzh0906@thundersoft.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:34:22 +0200
X-Gm-Features: AS18NWBTeJE3De2V6Q2_nyOlyupwgaA4ybsnxBjHtD7xymMmZJcjw6ksT3sbAGs
Message-ID: <CAPDyKFp3onTDGgygvOrK-G40w4mSx4S5=PbdZ+26hsQ+nPVRSA@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC
 and CDCU1.0 board
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: arnd@arndb.de, adrian.hunter@intel.com, bst-upstream@bstai.top, 
	catalin.marinas@arm.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	gordon.ge@bst.ai, krzk+dt@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, robh@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 14:12, Albert Yang <yangzh0906@thundersoft.com> wro=
te:
>
> On Thu, Sep 25, 2025 at 05:03:57PM +0800, Albert Yang wrote:Subject: Re: =
[PATCH] splitting SoC and MMC parts
>
> Hi Arnd,
>
> I may have missed an important detail in my previous note. If I split
> out the MMC-related patches and submit only the SoC parts first, I
> cannot validate the SoC on real hardware: both the kernel and the root
> filesystem live on the MMC device. Without the MMC stack (DT bindings
> and the controller driver), the board does not boot to userspace, so I
> cannot properly verify the SoC/DT changes in isolation.

At least to me, I would not consider that a problem. As long as you
can test the pieces together "manually" that's fine, I think.

I mean, the platform was not supported in the first place, so it's not
like we would be introducing a regression - or break something, right?

>
> Would you prefer that I:
> - keep the MMC pieces in the same series for initial bring-up; or
> - validate everything locally, then send only the SoC/DT parts first and
>   follow up with the MMC binding/driver as a separate series?
>
> I=E2=80=99m not entirely sure which approach best matches the normal work=
flow,
> so your guidance would be appreciated. I can proceed whichever way you
> think is most appropriate.

I think doing things in parallel would be the best/fastest way
forward. Validating locally and sending the pieces upstream to
different subsystems.

>
> Thanks for the review and suggestions.
>
> Best regards,
> Albert

Kind regards
Uffe
