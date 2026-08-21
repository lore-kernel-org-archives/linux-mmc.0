Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02D470EAC
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312195; cv=none; b=kLdwlG63cu7K96Q2G7SJhs6AOYrVfoFOBk9XLT2V6cg99UWJMt+PJKxvHcfaTK4jbTQeXSWMnb43Y8uCVPCDXs5wa8CE4p8ZxaGPowglngJAGdwGlZiazhV3S/ie38YqAr2q/ZdzBqSfPqq5rsoXzDZoqvHwwe38o5ogSQ1d7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312195; c=relaxed/simple;
	bh=zTUqexKzRd/ffgVVQLYyFm6wrBTaM5V92oYObJi9TRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNqeNc4FEnUsmXDY3SX5GdkiFftjjEFSEAmnEBBwIDRiqTRXJHQs5+u/kYZSIx1r48UGrWALSWFsXAL3NOgcXexItAyLHfj2zi6PmJ5ymG6Yz6/BoLLTSbvAHGR76GqEDWdPQEaKTHd/4p9FCePTXc4S3aQQh5TjGx52261Q1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bf9466867cso369559e0c.2
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 04:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312192; x=1787916992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ec+NopWifWei3xhy94Jsaew2jyivOXpRYVcmATiWbTA=;
        b=mPFCYwQ0AgcIoGAnYsFn/rS750+aXiDuf7d2I0IAHSWI/aqpzIr5vOm/CTuPvFY8nD
         VGFUb0nqlvsjqsJ4RH/g7SKahPlOZD6JFdO0nJFoFoIUmDVqF8yL9J7A8e5Sp2RKQM8b
         z1VcqNK2i6ghHZhVMktTtXL8MXXUheRrpqgqHrwKbVoUZAoZkN6y+Bpk8ODZ0LLLz5nw
         O2KKF0Q6tgpnOWGG7fZX475LadZi4p4+FDtlym5E1wNua0Hly2Dp1hrVofIiawFZ4CME
         Wl0v0/JSuGbJ71NQNvfiySyER5hT97RtojkBOUxZ12b6uBKnbgY9m+RqdhLFjxJpvhMq
         9Omw==
X-Forwarded-Encrypted: i=1; AHgh+RrW57EYDACW7PL5K0KDn4Gq1TX3o8IXR8UPRloNDFKt38a6G9/GumRDRjqN9Wa3lXJMgKXCjaFSGuU=@vger.kernel.org
X-Gm-Message-State: AFuF++my5uFuYTfcWaCwJSb1M0TiGDbTfUB4cZpghnXBnODPdTy0F7nZ
	zpp5ocBhPPiTfslv6JWic5C56nmvI/7E38AAvnzATKqZXwhnEN4HHv3Xurp9UGF4
X-Gm-Gg: AR+sD10VZMTW8cxPOHjBGTtCI0p6tL8rxRLT5n0eNjtVmdGwG466T5EB2c1KEZrJ1gF
	qpwvLLAZ8ne7odI3A6NdQCWvsrT9aZ2PYPmlTP1i11t6/dgYRs1UobAFYeVCBbGC30UKwIY9rr+
	vMC1Vigml95LNsDg05pqKzM+UXlh3xWWUk52GF5Ysclh1BNnFP/89jeoFauc6qX9C1CqLtQQj5f
	cPXdUQteYqocEVKBFwl2AbYZ1DnYW1s8XZ8ItbIxO1vPAeH5/buEod+Ihe4c5HQht0dfLysZe6E
	w+qKxWtqqHl18dc97HqIG7xAmvh9xkmxWrtlGLdtexO/dY/NzYncp5jaS0anYqqBv2j6Y6vi/Al
	uia1rwKxIDa0B1ShEYnTVdWhRHuX7Rhl6dqOHa2I8oTUSKdwar7MFM+9u0Sb/eFg5Dz30H+S5uW
	XmVTd8gzWjvr4xaPf761V5wjyht33xtQ2sNN/oA5RDsrnupzz19AiM4xbxP3Zs0p2M/mIXG0uqx
	Y1SdyhBi7TknoOq20WKbmLZcW/l0Q==
X-Received: by 2002:a05:6122:8b1c:b0:5bf:7f98:9657 with SMTP id 71dfb90a1353d-5c5ff805479mr2234698e0c.6.1787312192081;
        Fri, 21 Aug 2026 04:36:32 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2639be2sm8445051e0c.8.2026.08.21.04.36.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 04:36:30 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2c96286f0so411346e0c.3
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 04:36:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9OwXuMfyPd6ho0Du5tKhnAIk4m5KAYHV3FGlZuZMjh6011OSoPDLkTlixsuxcYNQeNH+vmTscXY4=@vger.kernel.org
X-Received: by 2002:a05:6122:1798:b0:5c5:732c:f4f5 with SMTP id
 71dfb90a1353d-5c5ff866132mr2035837e0c.8.1787312190118; Fri, 21 Aug 2026
 04:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787240090.git.geert+renesas@glider.be> <5d066598-7aff-4912-89c6-23761fdccc7b@amd.com>
In-Reply-To: <5d066598-7aff-4912-89c6-23761fdccc7b@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 13:36:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSwx36pDJ0kW=CvQztFx53OvcdfMTpv1h2H6J3z2+Wfg@mail.gmail.com>
X-Gm-Features: AcwNN1Vx5LhEzAerkbLpsNS7FWTQ-s_Hejhf3XNTw2-87OEOYM9RyiJaA3RAFBU
Message-ID: <CAMuHMdXSwx36pDJ0kW=CvQztFx53OvcdfMTpv1h2H6J3z2+Wfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: Make sure clk_init_data is fully initialized
To: Michal Simek <michal.simek@amd.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michal,

On Fri, 21 Aug 2026 at 12:56, Michal Simek <michal.simek@amd.com> wrote:
> On 8/21/26 12:06, Geert Uytterhoeven wrote:
> > The clk_init_data structure contains several mutually-exclusive members
> > for different methods to specify the possible parents of a clock,
> > prompting drivers to initialize only the members they need.  However,
> > not initializing all members may cause subtle issues, which are only
> > exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> > enabled.
> >
> > Hence this series aims to make sure all members are fully initialized,
> > to avoid such bugs, and to prevent future breakage when converting
> > drivers to a different method for specifying the parents.
> >
> > Part One[1] fixed all cases that I identified to be real bugs, in
> > response to a crash I saw on BeagleBone Black.
> >
> > This series is the MMC subpart of Part Two, which fixes remaining cases
> > that are currently harmless.  These are still fragile, and may cause
> > future breakage when converting drivers to a different method for
> > specifying the parents.
> >
> > Thanks for your comments!
> >
> > [1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
> >       initialized (part 1)"
> >      https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be
> >
> > Geert Uytterhoeven (2):
> >    mmc: meson-gx: FIXME: Make sure clk_init_data is fully initialized
>
> It looks like a broken series to me.

Doh, I made a silly mistake while filling in the correct patch prefix...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
