Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC828C878
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137737; cv=none; b=a4XJcfmPXiI9YljgUw7sEUCuvwuCZaXQzS+uHsS3T/v+aODwxIcKRTUBdAB8J54PtlyRc5DUGXBzVnVsep+aZFJxrgE7QpPBcBbeM6jVsyfVbLwajSuRx01TdGYu0o+DXJo5oFwAC0wQUB5KqRD5D0+Znmh0ed53NlmjHSG0Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137737; c=relaxed/simple;
	bh=YaLtdwlFm8Pp8FrAVenfUscodpXbZafUSMlYqOfSb20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIsxKt3Dga0jGVjytSVuO1s9Wd2/TURz0aunJw7P0NADRFh/0qlt7NWwCpL5dVE6ATX6iVSEdFLzzyGSFFuL95njozHlC8L2lb+WkXq+QsgPMWcZyFTtJod62mLb47879riHp97vw/xhNTRdyciYnmEZcMDXrPVIwZbwoMOC+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjhPiN7o; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjhPiN7o"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e81a7d90835so586703276.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752137733; x=1752742533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TuZ56aBu1u+xu2PP1rjAbadZECnB88F+tV1akFcj7s=;
        b=bjhPiN7o5rLB1qQAS+mq0oHRXTIg8H/301ZaatZvNrF10q152PgpJhBQSeshnJpYY3
         h6KT6WYZfOyFdzr7Vlqke0WrdYzsCiaFl2c46FvytjM2quHDAj5lDnnM1NnmHL7W4ujP
         JFKHEmC/lVYKHzND6h2qp16IVGoHuMUby0h1wlY3Jh8TI/p9Ik4A2TwJ+G9Vy2FItSjY
         diLliq8UF93XHbm6Yl3uUKRa/2mq6XOVNG+r/0FRTGg1eTlTZkRwX2xdyi6J9QOiL+Kv
         BUiVGIaBGzydd/SZqwHU62IJ7qkEgi6xNZ6I9D7HbWplzh1ogb21RrriUcvs4XnSsrGI
         PTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137733; x=1752742533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TuZ56aBu1u+xu2PP1rjAbadZECnB88F+tV1akFcj7s=;
        b=rec/Z4aBM3hJRJDYir+N7KML2LeIqmX17VZxexl+6sxDJOFmVr+OK6WRapYdZOSN/j
         mkjZ7H125yt3I3v1x//x8LtLYpiv334DJB/w5cpOp4BTA9FAv8MAhK0cjI+SZM6w0yqx
         vB40g8/x5+DbhmOATonqUV7/NFlP9F/ZLIF81pPLlI1L2Ae5Zv9U/TBIMo8XhypyhBcV
         Bb+R3GwZ2KepI6Y5J5SEIFUybBBstGkwtJaIiRBJoLcuXOQHMFSkEXDvqotuFPYEJvpd
         /578AfbwlFmIUvqVIcGnOXCI9Qhmvv7qwuBOuRf1dYi/b5cHmsH8dQR0akISkeF7BTtM
         Dh3A==
X-Forwarded-Encrypted: i=1; AJvYcCWXNPnKxuqxocY8QfsbjIo1637m0YWPFszw/eQ9YyJVYDeWEAdoettgkeIuhrxU18S8egicLXFKIiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhf9Yj27oVlONXYThaj6XIjr+JNsdHJkGo1ymTlLso2/dGFQ8e
	MorQcx+WBG0LZg/Vtqd18KdHt2HyFoKKMGJCe08qY706tZaPnGeGqofWFsaFncGcgPsIB6bp9YH
	FcSAVTtOu9BO3Ngo4HTS5tqLCeg/auDfG67mr7PIgGg==
X-Gm-Gg: ASbGncseU5j0F9xK03wAwDrSMqJkB1A0x7Ldu9djjMZ0hDhGWwzc0cpdu++FfOyxIXa
	4xiEJcBuBGtrmgGM6qdllD5t01qNrhmjUQQjA9RUS/Z84Lsv9WTl3/mATCY683rOQZvXDKfkFEN
	6mCNovPpge5bwivMw/JdARqgUvPyJ2xkHvpQklVS7hAf7/vFPm00DVuQ==
X-Google-Smtp-Source: AGHT+IHpRL2f96J2shlr6yd/d20feDoo2GsONMoQSuHy/AWMYz2R16XYx1ueu1bLXtoc/tX9i+fwP4H2NzSFrMq0NXc=
X-Received: by 2002:a05:690c:3608:b0:714:13:357a with SMTP id
 00721157ae682-717c4797266mr24854187b3.20.1752137732579; Thu, 10 Jul 2025
 01:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-3-avri.altman@sandisk.com> <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
 <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com> <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 10:54:55 +0200
X-Gm-Features: Ac12FXwT52cMSLZxsnoKeWPoRMOLx6nSn-_e5ELZKtFgfGO5--wjl3MB67l7xQs
Message-ID: <CAPDyKFpiVFHhQwp8gyUMi+FHX6sWMqZdB6imOeGB255qpbK-KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit handling
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 09:57, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> >
> > > >
> > > > >
> > > > >         /*
> > > > >          * Current limit switch is only defined for SDR50, SDR104,
> > > > > and
> > > > > DDR50 @@ -575,33 +574,24 @@ static int sd_set_current_limit(struct
> > > > mmc_card *card, u8 *status)
> > > > >         max_current = sd_get_host_max_current(card->host);
> > > >
> > > > Looking at the implementation of sd_get_host_max_current(), it's very
> > limiting.
> > > >
> > > > For example, if we are using MMC_VDD_34_35 or MMC_VDD_35_36, the
> > > > function returns 0. Maybe this is good enough based upon those host
> > > > drivers that actually sets host->max_current_180|300|330, but it kind of
> > looks wrong to me.
> > > >
> > > > I think we should re-work this interface to let us retrieve the
> > > > maximum current from the host in a more flexible way. What we are
> > > > really looking for is a value in Watt instead, I think. Don't get me
> > > > wrong, this deserved it's own standalone patch on top of $subject patch.
> > > I still need to consult internally, but Yes - I agree.
> > > Ultimately however, CMD6 expects us to fill the current limit value, so
> > multiplying by voltage and dividing it back seems superfluous.
> > > How about adding to missing vdd and treat them as max_current_330, like in
> > sdhci_get_vdd_value?
> > > Maybe something like:
> > >
> > > +/*
> > > + * Get host's max current setting at its current voltage normalized
> > > +to 3.6
> > > + * volt which is the voltage in which the card defines its limits  */
> > > +static u32 sd_host_normalized_max_current(struct mmc_host *host) {
> > > +       u32 voltage, max_current;
> > > +
> > > +       voltage = 1 << host->ios.vdd;
> > > +       switch (voltage) {
> > > +       case MMC_VDD_165_195:
> > > +               max_current = host->max_current_180 * 180 / 360;
> > > +               break;
> > > +       case MMC_VDD_29_30:
> > > +       case MMC_VDD_30_31:
> > > +               max_current = host->max_current_300 * 300 / 360;
> > > +               break;
> > > +       case MMC_VDD_32_33:
> > > +       case MMC_VDD_33_34:
> > > +       case MMC_VDD_34_35:
> > > +       case MMC_VDD_35_36:
> > > +               max_current = host->max_current_330 * 330 / 360;
> > > +               break;
> > > +       default:
> > > +               max_current = 0;
> > > +       }
> > > +
> > > +       return max_current;
> > > +}
> >
> > I think it's way better than the current implementation in
> > sd_get_host_max_current().
> >
> > Still, I still think it's weird to have three different variables in the host,
> > max_current_180, max_current_300 and max_current_330. That seems like an
> > SDHCI specific thing to me, unless I am mistaken.
> >
> > I would rather see a more flexible interface where we move away from using
> > host->max_current_180|300|330 entirely and have a function that returns the
> > supported limit (whatever unit we decide). Maybe it also makes sense to provide
> > some additional helpers from the core that host drivers can call, to fetch/translate
> > the values it should provide for this.
> +Adrian
>
> IIUC, you are looking for a host->max_power to replace the above.

No, the new function/callback should provide us the value immediately,
rather than having it stored in the host struct.

> However, giver that:
> a) there is no power class in SD like in mmc, and the card needs to be set to a power-limit
> b) the platform supported voltages can be either be given via DT as well as hard-coded and it's shared with mmc, and
> c) the platform supported max current is either read from the sdhci register as well as can be hard-coded
> I am not sure if and where we should set this max_power member, but I am open for suggestions.

I will certainly be host specific, so we need to have a host ops for
it. Depending on how the host is powering the card, it may need to do
different things to get the max-current/max-power for the currently
selected voltage-level for vcc/vdd.

I can take a stab and post a draft for it. I will keep you posted.

[...]

Kind regards
Uffe
