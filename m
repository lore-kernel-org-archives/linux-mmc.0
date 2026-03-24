Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7246389108
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366394; cv=pass; b=S3JxUxjmlAexD6nGZGq0PKS5s0G6ds5DXshvCcrq65Wspum0K/dLoiUJFW58Xvp+b2hbf8QWiUaTcKnEdDX/u1USg4nwpoiqOwW02Klf/q9zkVZySQpRLxXxBfO/30su2SN+9Zm39fU3/UdmF2GcGzarYcMNKIfMGXfrnIuExRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366394; c=relaxed/simple;
	bh=Dazekn3wXmbpwkh5O/X1zv5TQzsAC26KJKVLknF3CtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njHbb4NcnBkQ15yudPFMDjNKs2j57jwnKtvZRmmH5ExNQrVxYi0d2E5f2p6vfF55nsltCJs+SSVxVTTzT+5XzTn7UjXEv8DmgDdbRLggrsGNxjIkR1YuhVbgzkvudyOk1qyfHaypufyLbrWrJvwsbm8QvDrntRLKPBMNUXrk6XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfhQBry8; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfhQBry8"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a297a69089so773720e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 08:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774366391; cv=none;
        d=google.com; s=arc-20240605;
        b=epn5YN1s6v/n5/CeNSAx3vusse5oWMDG/EHUqvOLaDyGWAgndeDBt08KvgnDUXbcMN
         ou49tCzJrrWMdI/2Z+Y9/+881/Q2dQJa49t7M/zktK7gwOGML3yWj9C6mf3Dt8p2hKaM
         hs8CMTHZONAXtXH3ThC6kFJdhNTt1ryh3Cva+AmDSOA7QM/4AsXgKVZI7IRVDx2ADLQR
         Q/iMOnQ7Txqodk5yrRfLdp8mhCm1xD78IKdEvrlKHurwIHajjxHOjQGNEmcIPX1inQso
         aHL/hhQrYrqGWVFVg205GX2uhxMC1prFU0WjLCOTFMou0vOBn2ARfm0Xqoiks4gu0wow
         W2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EulhqrAKC0l+YiIKM9vQzcgUyK00GqZZETJqdzlidD4=;
        fh=ncXaln0Su22nt2YRxjHRir+hUEAtAVuKqDnQ9kDfEVA=;
        b=CL36NbwDU0C2ZPcKFJKnx4gbYP2XMmNDg3NBKVyGx5KbAPWB2mC7R/Zs9LpnexBs7J
         81IBXEI2f5E4uxQJ52n5wTNKDItMDGJ98KeZza68HsRpiD/Pg6s9+dOrD3NZBf/YKhyU
         +0uXbW7WCkqScELJ2lhJiHyBBjwXvTT1j6ahm+zUSJbHkM/Gx7jpft5hHhZjXy8Z+GKn
         ee+NLOzI+vAMtreZXXM6iukiImV8avDDR0fk2PV4Mm6ab3RHzbfQUxVJrUCSUanHdZOU
         UpdfJhV3G8lIJBPGA/Id2BzpUQRTUBQ+c4x5SBH2Hph1P+6WDn4EfwhCzuwpDckQrj3y
         wiWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774366391; x=1774971191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EulhqrAKC0l+YiIKM9vQzcgUyK00GqZZETJqdzlidD4=;
        b=MfhQBry8VVauB0l+mYUwiDI2hwlBc6c82WWWq6WyrWqzBKquGBkgOushMUpBWWtYMh
         qU9gn+dP9Xhg8v82ZIe+e/0xvuZa7r/SdWA29OlL0uc1gCKAmwfG4PZakSFwblzuod29
         HTUunEL1SBwGsypflOkt9266ATY05wFB9X6SFHb2xjTfqekSOIexDm1wSZXxLbOlJxMs
         WTMpDK9Cs/vmrFZtdbRPGHg1K1AVwrxNEE4qYADK58GM0lmCpFAkk3mc1F+4zc00oY71
         uOPKwivwAv1W/xJ1uqyowWym0ahGDJ7WG5Wg6Se4GwrToKEYdLjQlVLgkwb0N33Rbf1s
         MAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366391; x=1774971191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EulhqrAKC0l+YiIKM9vQzcgUyK00GqZZETJqdzlidD4=;
        b=nhczZbkl/hAuC85OgGZ2/5351OWsEZdcYWRpCav9JsooiYGKGuEPL1ytb2WQkuAONC
         Ekn1Kj/riNrTF4Kv4XvwgDccJ7k/cWF/HLL/7s7AwWoWZ4x5ZsiBcvco10Aa1tNi/klM
         eChLUb6vB/eb0GGRZFxPYpCxKIjfrbpTcJ3gqVlwdgmsBfTSLlbGqbJqNW81PKEGz80g
         0KzhHRd1LOcMm+npGLtJgX4tVnPkPWdPzFF5pCf9Mxmm+DzwB1HoiAnIvIijrQpcaUxC
         5yxA8kQ+CmoIjIOdXeezoHxN2UkB7VUXQA10LzNeSVQ/ZnVImUbTF8s+06mxBaK2WPTh
         AS4A==
X-Gm-Message-State: AOJu0YxHr8kEkY940D3lDjf1B3zZ3FqVroCiNRkFue/fAOizxPiBqX+S
	asulo9WDSd54UIDuzrmRxInC6SIIZjlZvMVHbDSsKB135QrraXQ2faIybXt3BCdWpPFZfiy3Po2
	sSfRZ+5ZYeb12eCtIuhTty9lP1PZwSadBQEj9XiEv9Q==
X-Gm-Gg: ATEYQzzfTmEbs6DVLlkLy8lAgoI//Z5WOg2Z8qnKl9N3VHSIzpL1qKvSBrs13zQlmDJ
	qugOZWca/0caWSqOP4VnAz9k5VcDRxzcY2adJb7/IWE3FhbnvBsuK/ih7BZ02Q+2nTvXcki4BHs
	uejns8DU8RY+a1+VCIIblxHJMJjM21VtwBkJOQn5w+rEVwCygI61Xo333w2smw/CLVHnLtZoQod
	mW5fEwU+jW/157miLg6NzIppQ4Rt11NP/QUvLFj0CLSYSccRrlTiYRKwjWEryobXl94t2t6TWWZ
	eUzQ67tY7ljAErI/aqo=
X-Received: by 2002:a05:6512:3f09:b0:5a1:b83:c7cf with SMTP id
 2adb3069b0e04-5a285b3fa20mr5280414e87.25.1774366390722; Tue, 24 Mar 2026
 08:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113031517.244714-1-jeff.chen_1@nxp.com> <CAPDyKFp0+70OSrW_zrV+-fdr-BUScKkyNzTHkN==+9k52Z5j3g@mail.gmail.com>
 <abxGvaylqulUeN8N@nxpwireless-Inspiron-14-Plus-7440>
In-Reply-To: <abxGvaylqulUeN8N@nxpwireless-Inspiron-14-Plus-7440>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 16:32:34 +0100
X-Gm-Features: AQROBzAYGekqO4V2ORtagadlK4xrZJc7a8BC8YV7N4zO3GW5aEbUNWBcJKzHovY
Message-ID: <CAPDyKFon9jqA4vjM4_3T_fWbk7eAypZBiH_nkGzrazsy7Ahocw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: add NXP vendor and IW61x device IDs
To: johannes@sipsolutions.net, jeff.chen_1@nxp.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wyatt.hsu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2026 at 19:58, <jeff.chen_1@nxp.com> wrote:
>
> On Thu, Jan 22, 2026 at 07:03:19 PM +0100, Ulf Hansson wrote:
> > On Tue, 13 Jan 2026 at 04:16, Jeff Chen <jeff.chen_1@nxp.com> wrote:
> > >
> > > Add NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205) to
> > > sdio_ids.h for future support of NXP Wi-Fi chips over SDIO.
> > >
> > > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> >
> > Applied for next, thanks!
> >
> > Kind regards
> > Uffe
> >
>
> Hi Ulf,
>
> Thanks for applying the IW61x SDIO ID patch to mmc-next.
>
> May I ask when you expect this patch to be queued for mainline?

It was intended for v7.0-rc1, but my pull-request for mmc was broken,
so Linus rejected it.

That means this is queued for v7.1-rc1 instead. I usually send out my
pull-request the first Monday the merge window opens.

> The reason I ask is that the nxpwifi driver is currently under review in
> wireless-next, and without these SDIO IDs available in mainline (or in
> wireless-next), the nxpwifi series cannot be built by itself. This
> blocks further review and testing on the wireless side.
>
> If the patch is not expected to reach mainline very soon, would it be
> acceptable for you to temporarily drop it from mmc-next?

Sorry, but I don't want to take the risk of doing a re-base this time.
I have a lot queued for v7.1-rc1 and I am also hosting an immutable
branch for cross-subsystem dependency.

> In that case, I can include the SDIO ID addition directly as part of the
> nxpwifi patch series submitted to wireless-next (and keep your Ack), so
> that wireless-next can build cleanly during review.
>
> Please let me know which workflow you prefer. I=E2=80=99m happy to follow
> whichever option fits best with your merge plans.
>
> As discussed earlier with Johannes:
> https://patchwork.kernel.org/project/linux-wireless/cover/20260305143939.=
3724868-1-jeff.chen_1@nxp.com/
>
> Thanks again for your help.

I guess you can try applying an exact same copy of the patch (pick it
from my mmc tree). Since it's a really trivial one, maybe git can sort
it out when the wireless-tree and the mmc-tree tree gets merged.

Although, as stated, I will not be able to help with re-basing this time.

Kind regards
Uffe


>
> Best regards,
> Jeff
> >
> > > ---
> > >  include/linux/mmc/sdio_ids.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_id=
s.h
> > > index 673cbdf43453..39ac2b612e4a 100644
> > > --- a/include/linux/mmc/sdio_ids.h
> > > +++ b/include/linux/mmc/sdio_ids.h
> > > @@ -116,6 +116,9 @@
> > >  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
> > >  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
> > >
> > > +#define SDIO_VENDOR_ID_NXP                     0x0471
> > > +#define SDIO_DEVICE_ID_NXP_IW61X               0x0205
> > > +
> > >  #define SDIO_VENDOR_ID_REALTEK                 0x024c
> > >  #define SDIO_DEVICE_ID_REALTEK_RTW8723BS       0xb723
> > >  #define SDIO_DEVICE_ID_REALTEK_RTW8821BS       0xb821
> > > --
> > > 2.34.1
> > >
> >
