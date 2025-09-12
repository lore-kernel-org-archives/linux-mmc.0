Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A882281520
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673249; cv=none; b=X42DDPU9UPektb63hIRBOz7YWjL8wYXPsTkvKr5KU5f+v4YzhvRciTskaZVkzvvQ3v+xNAiE1lZnixGZ7MuAbINhH+rTU+/geDzArkadh8TOCen3c3hETQj/DHMDy/9+ogIAe8hQAyOMRGkppxgCSNt5S4IkAFeOa50hfV3G57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673249; c=relaxed/simple;
	bh=a2gSg3SjUDd8u4zi2AkN6vrD/eZ10e2gbI9I3y3t1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu7e3oOTFLZPij4eC6MWYZdVkZ54TW2bDU6Tkgzg3NegupL+n9vdc49G7oUFt3fiYqJil6DPBVZ+6km1k4b4x55zam06cRlC6WKWDcVwGcesD623fcKkqo/kiIIOVFT47J+m04aEjJ3dgAcOrY+Cnu0rbiH7XtRgT37g8kfjZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yxpXqKiu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxpXqKiu"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so1813814e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757673245; x=1758278045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdULkCF3wHtDOeV61QyKWlC3GANnIuBmmuXKUPdZUu0=;
        b=yxpXqKiuNPkFsB5tvAPV7dDI+wVafeeNSHSJui5+2eQwZ2ILO7WquuxjrQ243wxkXw
         kWi0vP2SjILkgBN3e/sXTDVjFQ2NSnnv6pkCId3pqHAvV0f/VzMgcjaLmfjjboKKvUgD
         1OwLIujEByYAo53UJcLtatv3iIYlu/Jnc4Ra2CjQOJMFoPqRR3Ul9kuUr/I/hm+DfQ5N
         nGkF/76HleiryhnGKiTsdWOw4ZAGoE0OtanL+IV3hgiMpCN6KT80x7/rfhUUWH/LmjkS
         6YbcQHRbAjxpVyw6WSH5dId590hfGhwbvWwyPiSxtf1tTgez3U+3PJThKJtSrejWzBR9
         Rgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673245; x=1758278045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdULkCF3wHtDOeV61QyKWlC3GANnIuBmmuXKUPdZUu0=;
        b=hz+aYKb7OrgHE6TF2jb78xj1sckub7/OV+7tCsmh7+7QgC20iTFEN9h8JukKzx1spA
         9t6QIe+HBMrVFiJ1kZG/r0PIDOte5Vr2rtd5k40F9zVnKtAkTq18GQJ+m2E7pUSwG1JI
         mcPVnmm7oGZRv1ZCrRilFhd4rf1bbzw3kOmsvw2rIdTe36za/eo+9a/LKl09GAE50wPe
         ksTlwczhzzqp4M7o3256oMccOewEQ7TW1CpNvoxIFn0pDRQvDQsOtvxNkHVT/07+meKp
         rwPt11yQRUm528S1YXwYh6sjNawI+xw4iAlMxO78599o/dcX3xhUCxUZwM93rh4Q8iF2
         pbWA==
X-Gm-Message-State: AOJu0Yz+1aLYCCea7JNYPBXcJxpb5gsl379FE801HQtHp8GvAEScC4Hy
	jjoraOtHoWJpS8DC9va8j4lgalqAGecrpKaS9yf7Jd7Xtrp45tKvXWqKg5+8ayAL8YE=
X-Gm-Gg: ASbGncuf2vet1T3EUQKR0JJbyUdinl1BoOXvvu4tJhtNIOUavyKeB+K/dN0GK+Sq7+D
	6lpFBhwrBZCi6S0wsLFlNI+2WcBJPC6uNm+VhU355yZJBe2B94o1QhKpzvjrqRpPYmitTIhvb8n
	7ImIysqu91MtSac2k6RElyb1feXtxIDkbbQMDKhOYi6WJWXk+FvV125B9AGuOI9KBZb1pvYXZEQ
	z1R+71O+NLtWT8hmTg0UCqPhT/SyWTRTyfMhFEOqvaabC02rGD4hNottNHtuVf6L4lwM67/vZSZ
	ghOovSRMrEPyblbdWKIXZ7cF73XLN4vEiHJuZdRlS1uo/eYYPESbDwW36S8iUmkZzlETZiMsEde
	wst+ityU8xEI0+O7CYacPeTOvbfoR+qMrbu6sytmxYObw7+PXr02RyJR5mLNemLYmTg==
X-Google-Smtp-Source: AGHT+IEYLTS967/BEvhOg8jJEl25DNiR+DJTVVF1bWTZ1043oUVFc7I9igh8/IpErBhBmyOySthfkA==
X-Received: by 2002:a05:6512:290e:b0:560:8b86:75d9 with SMTP id 2adb3069b0e04-57049675d20mr688273e87.14.1757673245258;
        Fri, 12 Sep 2025 03:34:05 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a32f66sm1030978e87.138.2025.09.12.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:34:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:34:02 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com,
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Subject: Re: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
Message-ID: <aMP3Goa-IVjCmSHa@nuoska>
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org>
 <20250912084112.2795848-2-mikko.rapeli@linaro.org>
 <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>

Hi,

On Fri, Sep 12, 2025 at 10:48:47AM +0200, Geert Uytterhoeven wrote:
> Hi Mikko,
> 
> On Fri, 12 Sept 2025 at 10:41, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> > According to Heiko Stuebner <heiko@sntech.de> all SoCs
> > since 2012 have power domain support in HW and
> > ROCKCHIP_PM_DOMAINS should always be enabled.
> >
> > Suggested-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
> >         select HAVE_ARM_TWD if SMP
> >         select DW_APB_TIMER_OF
> >         select REGULATOR if PM
> > +       select ROCKCHIP_PM_DOMAINS
> 
> This requires "select PM". Oh, that is done below (out-of-context).
> So the "if PM" above can be dropped.

Yes, it's selected just after the context. I can drop it from
"select REGULATOR" in v3.

I was not sure if the PM dependency should be there or not
also when it's explicitly selected.

Cheers,

-Mikko
