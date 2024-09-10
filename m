Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0E188CB1
	for <linux-mmc@vger.kernel.org>; Tue, 10 Sep 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971443; cv=none; b=lxNFyNzQfc25buCcASe6jvFX4wqo1NYtFayDZZCpH8AdoTkNH7Xn1hBK1dfWh1dTzcr7AB6BipD8T+c2e+WksWd+hBju8DYj13J7nuvfmQfWpod3zWktfCQIIcTBCk/fa4MeMweiABQl/GdNwX3pli04awca8dgPWZOAXM6cv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971443; c=relaxed/simple;
	bh=ppUCsgXacjAC80PDszgBX3Ef8FiJY9iaHZyM32DTSdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW0c1Gxb26N8lCuTspy+lz+KGqnRr/pVIjA2dyzJdir/oeur3gsfnKRx08Dk3terEJsPemfEGitcB118S725ecGegnzTwTbdt+j314WM/4jX3x7REKz02WtpcpFTtFpeXMDVaVuqQQJ2+4rFGlG4LQOHoh5kMt6HfePvjwrKSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ReA7/Qdo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReA7/Qdo"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso5757511276.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Sep 2024 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725971440; x=1726576240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppUCsgXacjAC80PDszgBX3Ef8FiJY9iaHZyM32DTSdM=;
        b=ReA7/QdoLmSvK4km82wYuyNejc0mzxo5Ob1fUiKR+GT1EHvESYgClAn7ROzBpYauvP
         9Vt1Tck0N4EQFFFC2MTtfSBAWnG5jb8njIyCYZuw+hGFISwd1eYxW00IoomO9jzGtJjG
         J+QAPpZn649jo0ibQMVbxi8MWkuhXcP1+6hY8exqKHoKPBIEdGhyN5FK8JoxDRXses1h
         KF3HjV5bLS8f+BuII46JcO+hjxkg+ZGCTYHlYGpqnMjGZeceGGkaIfSu3Rddg0Y1Hdzu
         mdH5p26u/g14dcRlcFyXC5zubhybT1Tdv+lJQwrdHzYO6zNpeBVhQhA11IXgEZ9yYrEB
         170Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971440; x=1726576240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppUCsgXacjAC80PDszgBX3Ef8FiJY9iaHZyM32DTSdM=;
        b=wQqP0VY1x2V8VdecWPXZGdMoSAZXJN2mwdD7wmMw5whTcHIZy+SOjJitPkmXhM7ZUc
         PNlOTjpTO/AYTOOyRInkyv8pftn/qibCvqPl0OsSwUk7jKj1diroGCe0wGxJVztUjvoa
         PswRqylZzK2O6ivJsHPELyqqei8O7LaDfXqVYIaJZD9hGqbPgz95RcYv/kxwBbtAE3uf
         40icsr0cxbDE1ls2nNLD4Ls2UxlKugLdaXsw/QJUqwwhhbT0/xNgT+UczyGvvLSdYs1i
         sVzq1fZ3fj/7jvYxt7dR1IpJ2F+S59i2s8sVioLxVJ91/4MNn8iv18M1wcmCIwQel3eF
         eqpA==
X-Forwarded-Encrypted: i=1; AJvYcCUBWfx1P9UHR2pXtkXB498bJSBo5kMje3wEvSIMesmI6Z3xD83K1Mj6NP/gUgmGUHtM/jF7oBoWPas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytp2Yn2BmWGOjhtpXIluWVcspbCMcSrVptJ08GlBNdKpUo65LJ
	ztUD5Ms19n/tCyfUhe4eOsOPMCvzjqxwNFb3cR+DoFnLX/tK103kz6uF/zdltt1OGWlHmmp5x61
	pPkm4ogBY8TKPMVIrnePs7lvrCLGXJmn1VGcUAfC6XyFV/ss6
X-Google-Smtp-Source: AGHT+IF4U5CTSnV3pYSaQJ/n8K1wSJ9mAgTe5GbVqywQ7b1jqX22ibNMGGcNOYlAxtjf+hqIw/fyPRG7e6crS2giyFQ=
X-Received: by 2002:a05:6902:1145:b0:e16:6feb:e615 with SMTP id
 3f1490d57ef6-e1d34a3865fmr15851471276.48.1725971440307; Tue, 10 Sep 2024
 05:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
 <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65757BAB092322ACCE642A6DFC9A2@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Sep 2024 14:30:04 +0200
Message-ID: <CAPDyKFqJaAob7xceSkNe3aNogT55OoY5WRdPsFs450Sy3GhM2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Add SDUC Support
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ricky WU <ricky_wu@realtek.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Christian Loehle <christian.loehle@arm.com>, 
	Michael Wu <michael@allwinnertech.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 12:56, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > I didn't actually give my Reviewed-by in v6, but I guess it can stand for those
> > patches.
> Sorry about that - apparently, I misunderstood your last comment to v6 0/9
>
> >
> > For "mmc: core: Prevent HSQ from enabling for SDUC" it needs feedback from
> > HSQ users - cc'ed Michael Wu and Wenchao Chen
> >
> > Otherwise I have no further comments for now.
> Thanks.
>
> Ulf,
> Am I expected to do something more?

No, I just need some more time to review this, sorry.

I am also heading to LPC next week, so hopefully I will get to review
the series before that...

Kind regards
Uffe
